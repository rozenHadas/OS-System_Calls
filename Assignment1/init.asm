
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 14 07 00 00       	push   $0x714
  19:	e8 c3 02 00 00       	call   2e1 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	79 23                	jns    48 <main+0x48>
    mknod("console", 1, 1);
  25:	83 ec 04             	sub    $0x4,%esp
  28:	6a 01                	push   $0x1
  2a:	6a 01                	push   $0x1
  2c:	68 14 07 00 00       	push   $0x714
  31:	e8 b3 02 00 00       	call   2e9 <mknod>
    open("console", O_RDWR);
  36:	83 c4 08             	add    $0x8,%esp
  39:	6a 02                	push   $0x2
  3b:	68 14 07 00 00       	push   $0x714
  40:	e8 9c 02 00 00       	call   2e1 <open>
  45:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
  48:	83 ec 0c             	sub    $0xc,%esp
  4b:	6a 00                	push   $0x0
  4d:	e8 c7 02 00 00       	call   319 <dup>
  dup(0);  // stderr
  52:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  59:	e8 bb 02 00 00       	call   319 <dup>
  5e:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  61:	83 ec 08             	sub    $0x8,%esp
  64:	68 1c 07 00 00       	push   $0x71c
  69:	6a 01                	push   $0x1
  6b:	e8 94 03 00 00       	call   404 <printf>
    pid = fork();
  70:	e8 24 02 00 00       	call   299 <fork>
  75:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  77:	83 c4 10             	add    $0x10,%esp
  7a:	85 c0                	test   %eax,%eax
  7c:	79 14                	jns    92 <main+0x92>
      printf(1, "init: fork failed\n");
  7e:	83 ec 08             	sub    $0x8,%esp
  81:	68 2f 07 00 00       	push   $0x72f
  86:	6a 01                	push   $0x1
  88:	e8 77 03 00 00       	call   404 <printf>
      exit();
  8d:	e8 0f 02 00 00       	call   2a1 <exit>
    }
    if(pid == 0){
  92:	85 c0                	test   %eax,%eax
  94:	75 38                	jne    ce <main+0xce>
      exec("sh", argv);
  96:	83 ec 08             	sub    $0x8,%esp
  99:	68 c0 09 00 00       	push   $0x9c0
  9e:	68 42 07 00 00       	push   $0x742
  a3:	e8 31 02 00 00       	call   2d9 <exec>
      printf(1, "init: exec sh failed\n");
  a8:	83 c4 08             	add    $0x8,%esp
  ab:	68 45 07 00 00       	push   $0x745
  b0:	6a 01                	push   $0x1
  b2:	e8 4d 03 00 00       	call   404 <printf>
      exit();
  b7:	e8 e5 01 00 00       	call   2a1 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  bc:	83 ec 08             	sub    $0x8,%esp
  bf:	68 5b 07 00 00       	push   $0x75b
  c4:	6a 01                	push   $0x1
  c6:	e8 39 03 00 00       	call   404 <printf>
  cb:	83 c4 10             	add    $0x10,%esp
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  ce:	e8 d6 01 00 00       	call   2a9 <wait>
  d3:	39 c3                	cmp    %eax,%ebx
  d5:	74 8a                	je     61 <main+0x61>
  d7:	85 c0                	test   %eax,%eax
  d9:	79 e1                	jns    bc <main+0xbc>
  db:	eb 84                	jmp    61 <main+0x61>

000000dd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  dd:	55                   	push   %ebp
  de:	89 e5                	mov    %esp,%ebp
  e0:	53                   	push   %ebx
  e1:	8b 45 08             	mov    0x8(%ebp),%eax
  e4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e7:	89 c2                	mov    %eax,%edx
  e9:	83 c2 01             	add    $0x1,%edx
  ec:	83 c1 01             	add    $0x1,%ecx
  ef:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  f3:	88 5a ff             	mov    %bl,-0x1(%edx)
  f6:	84 db                	test   %bl,%bl
  f8:	75 ef                	jne    e9 <strcpy+0xc>
    ;
  return os;
}
  fa:	5b                   	pop    %ebx
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    

000000fd <strcmp>:

int
strcmp(const char *p, const char *q)
{
  fd:	55                   	push   %ebp
  fe:	89 e5                	mov    %esp,%ebp
 100:	8b 4d 08             	mov    0x8(%ebp),%ecx
 103:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 106:	0f b6 01             	movzbl (%ecx),%eax
 109:	84 c0                	test   %al,%al
 10b:	74 15                	je     122 <strcmp+0x25>
 10d:	3a 02                	cmp    (%edx),%al
 10f:	75 11                	jne    122 <strcmp+0x25>
    p++, q++;
 111:	83 c1 01             	add    $0x1,%ecx
 114:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 117:	0f b6 01             	movzbl (%ecx),%eax
 11a:	84 c0                	test   %al,%al
 11c:	74 04                	je     122 <strcmp+0x25>
 11e:	3a 02                	cmp    (%edx),%al
 120:	74 ef                	je     111 <strcmp+0x14>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 122:	0f b6 c0             	movzbl %al,%eax
 125:	0f b6 12             	movzbl (%edx),%edx
 128:	29 d0                	sub    %edx,%eax
}
 12a:	5d                   	pop    %ebp
 12b:	c3                   	ret    

0000012c <strlen>:

uint
strlen(char *s)
{
 12c:	55                   	push   %ebp
 12d:	89 e5                	mov    %esp,%ebp
 12f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 132:	80 39 00             	cmpb   $0x0,(%ecx)
 135:	74 12                	je     149 <strlen+0x1d>
 137:	ba 00 00 00 00       	mov    $0x0,%edx
 13c:	83 c2 01             	add    $0x1,%edx
 13f:	89 d0                	mov    %edx,%eax
 141:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 145:	75 f5                	jne    13c <strlen+0x10>
 147:	eb 05                	jmp    14e <strlen+0x22>
 149:	b8 00 00 00 00       	mov    $0x0,%eax
    ;
  return n;
}
 14e:	5d                   	pop    %ebp
 14f:	c3                   	ret    

00000150 <memset>:

void*
memset(void *dst, int c, uint n)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	57                   	push   %edi
 154:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 157:	89 d7                	mov    %edx,%edi
 159:	8b 4d 10             	mov    0x10(%ebp),%ecx
 15c:	8b 45 0c             	mov    0xc(%ebp),%eax
 15f:	fc                   	cld    
 160:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 162:	89 d0                	mov    %edx,%eax
 164:	5f                   	pop    %edi
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    

00000167 <strchr>:

char*
strchr(const char *s, char c)
{
 167:	55                   	push   %ebp
 168:	89 e5                	mov    %esp,%ebp
 16a:	53                   	push   %ebx
 16b:	8b 45 08             	mov    0x8(%ebp),%eax
 16e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 171:	0f b6 10             	movzbl (%eax),%edx
 174:	84 d2                	test   %dl,%dl
 176:	74 1d                	je     195 <strchr+0x2e>
 178:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
 17a:	38 d3                	cmp    %dl,%bl
 17c:	75 06                	jne    184 <strchr+0x1d>
 17e:	eb 1a                	jmp    19a <strchr+0x33>
 180:	38 ca                	cmp    %cl,%dl
 182:	74 16                	je     19a <strchr+0x33>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 184:	83 c0 01             	add    $0x1,%eax
 187:	0f b6 10             	movzbl (%eax),%edx
 18a:	84 d2                	test   %dl,%dl
 18c:	75 f2                	jne    180 <strchr+0x19>
    if(*s == c)
      return (char*)s;
  return 0;
 18e:	b8 00 00 00 00       	mov    $0x0,%eax
 193:	eb 05                	jmp    19a <strchr+0x33>
 195:	b8 00 00 00 00       	mov    $0x0,%eax
}
 19a:	5b                   	pop    %ebx
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    

0000019d <gets>:

char*
gets(char *buf, int max)
{
 19d:	55                   	push   %ebp
 19e:	89 e5                	mov    %esp,%ebp
 1a0:	57                   	push   %edi
 1a1:	56                   	push   %esi
 1a2:	53                   	push   %ebx
 1a3:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a6:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 1ab:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ae:	eb 29                	jmp    1d9 <gets+0x3c>
    cc = read(0, &c, 1);
 1b0:	83 ec 04             	sub    $0x4,%esp
 1b3:	6a 01                	push   $0x1
 1b5:	57                   	push   %edi
 1b6:	6a 00                	push   $0x0
 1b8:	e8 fc 00 00 00       	call   2b9 <read>
    if(cc < 1)
 1bd:	83 c4 10             	add    $0x10,%esp
 1c0:	85 c0                	test   %eax,%eax
 1c2:	7e 21                	jle    1e5 <gets+0x48>
      break;
    buf[i++] = c;
 1c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c8:	8b 55 08             	mov    0x8(%ebp),%edx
 1cb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cf:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1d1:	3c 0a                	cmp    $0xa,%al
 1d3:	74 0e                	je     1e3 <gets+0x46>
 1d5:	3c 0d                	cmp    $0xd,%al
 1d7:	74 0a                	je     1e3 <gets+0x46>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d9:	8d 5e 01             	lea    0x1(%esi),%ebx
 1dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1df:	7c cf                	jl     1b0 <gets+0x13>
 1e1:	eb 02                	jmp    1e5 <gets+0x48>
 1e3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1ef:	5b                   	pop    %ebx
 1f0:	5e                   	pop    %esi
 1f1:	5f                   	pop    %edi
 1f2:	5d                   	pop    %ebp
 1f3:	c3                   	ret    

000001f4 <stat>:

int
stat(char *n, struct stat *st)
{
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	56                   	push   %esi
 1f8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f9:	83 ec 08             	sub    $0x8,%esp
 1fc:	6a 00                	push   $0x0
 1fe:	ff 75 08             	pushl  0x8(%ebp)
 201:	e8 db 00 00 00       	call   2e1 <open>
  if(fd < 0)
 206:	83 c4 10             	add    $0x10,%esp
 209:	85 c0                	test   %eax,%eax
 20b:	78 1f                	js     22c <stat+0x38>
 20d:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 20f:	83 ec 08             	sub    $0x8,%esp
 212:	ff 75 0c             	pushl  0xc(%ebp)
 215:	50                   	push   %eax
 216:	e8 de 00 00 00       	call   2f9 <fstat>
 21b:	89 c6                	mov    %eax,%esi
  close(fd);
 21d:	89 1c 24             	mov    %ebx,(%esp)
 220:	e8 a4 00 00 00       	call   2c9 <close>
  return r;
 225:	83 c4 10             	add    $0x10,%esp
 228:	89 f0                	mov    %esi,%eax
 22a:	eb 05                	jmp    231 <stat+0x3d>
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 22c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  r = fstat(fd, st);
  close(fd);
  return r;
}
 231:	8d 65 f8             	lea    -0x8(%ebp),%esp
 234:	5b                   	pop    %ebx
 235:	5e                   	pop    %esi
 236:	5d                   	pop    %ebp
 237:	c3                   	ret    

00000238 <atoi>:

int
atoi(const char *s)
{
 238:	55                   	push   %ebp
 239:	89 e5                	mov    %esp,%ebp
 23b:	53                   	push   %ebx
 23c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23f:	0f b6 11             	movzbl (%ecx),%edx
 242:	8d 42 d0             	lea    -0x30(%edx),%eax
 245:	3c 09                	cmp    $0x9,%al
 247:	77 1f                	ja     268 <atoi+0x30>
 249:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 24e:	83 c1 01             	add    $0x1,%ecx
 251:	8d 04 80             	lea    (%eax,%eax,4),%eax
 254:	0f be d2             	movsbl %dl,%edx
 257:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 25b:	0f b6 11             	movzbl (%ecx),%edx
 25e:	8d 5a d0             	lea    -0x30(%edx),%ebx
 261:	80 fb 09             	cmp    $0x9,%bl
 264:	76 e8                	jbe    24e <atoi+0x16>
 266:	eb 05                	jmp    26d <atoi+0x35>
int
atoi(const char *s)
{
  int n;

  n = 0;
 268:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
  return n;
}
 26d:	5b                   	pop    %ebx
 26e:	5d                   	pop    %ebp
 26f:	c3                   	ret    

00000270 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	53                   	push   %ebx
 275:	8b 45 08             	mov    0x8(%ebp),%eax
 278:	8b 75 0c             	mov    0xc(%ebp),%esi
 27b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	85 db                	test   %ebx,%ebx
 280:	7e 13                	jle    295 <memmove+0x25>
 282:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 287:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 28b:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 28e:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 291:	39 da                	cmp    %ebx,%edx
 293:	75 f2                	jne    287 <memmove+0x17>
    *dst++ = *src++;
  return vdst;
}
 295:	5b                   	pop    %ebx
 296:	5e                   	pop    %esi
 297:	5d                   	pop    %ebp
 298:	c3                   	ret    

00000299 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 299:	b8 01 00 00 00       	mov    $0x1,%eax
 29e:	cd 40                	int    $0x40
 2a0:	c3                   	ret    

000002a1 <exit>:
SYSCALL(exit)
 2a1:	b8 02 00 00 00       	mov    $0x2,%eax
 2a6:	cd 40                	int    $0x40
 2a8:	c3                   	ret    

000002a9 <wait>:
SYSCALL(wait)
 2a9:	b8 03 00 00 00       	mov    $0x3,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <pipe>:
SYSCALL(pipe)
 2b1:	b8 04 00 00 00       	mov    $0x4,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <read>:
SYSCALL(read)
 2b9:	b8 05 00 00 00       	mov    $0x5,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <write>:
SYSCALL(write)
 2c1:	b8 10 00 00 00       	mov    $0x10,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <close>:
SYSCALL(close)
 2c9:	b8 15 00 00 00       	mov    $0x15,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <kill>:
SYSCALL(kill)
 2d1:	b8 06 00 00 00       	mov    $0x6,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <exec>:
SYSCALL(exec)
 2d9:	b8 07 00 00 00       	mov    $0x7,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <open>:
SYSCALL(open)
 2e1:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <mknod>:
SYSCALL(mknod)
 2e9:	b8 11 00 00 00       	mov    $0x11,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <unlink>:
SYSCALL(unlink)
 2f1:	b8 12 00 00 00       	mov    $0x12,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <fstat>:
SYSCALL(fstat)
 2f9:	b8 08 00 00 00       	mov    $0x8,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <link>:
SYSCALL(link)
 301:	b8 13 00 00 00       	mov    $0x13,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <mkdir>:
SYSCALL(mkdir)
 309:	b8 14 00 00 00       	mov    $0x14,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <chdir>:
SYSCALL(chdir)
 311:	b8 09 00 00 00       	mov    $0x9,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <dup>:
SYSCALL(dup)
 319:	b8 0a 00 00 00       	mov    $0xa,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <getpid>:
SYSCALL(getpid)
 321:	b8 0b 00 00 00       	mov    $0xb,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <sbrk>:
SYSCALL(sbrk)
 329:	b8 0c 00 00 00       	mov    $0xc,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <sleep>:
SYSCALL(sleep)
 331:	b8 0d 00 00 00       	mov    $0xd,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <uptime>:
SYSCALL(uptime)
 339:	b8 0e 00 00 00       	mov    $0xe,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <wait2>:
SYSCALL(wait2)
 341:	b8 17 00 00 00       	mov    $0x17,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <setVariable>:
SYSCALL(setVariable)
 349:	b8 18 00 00 00       	mov    $0x18,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <getVariable>:
SYSCALL(getVariable)
 351:	b8 19 00 00 00       	mov    $0x19,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <remVariable>:
SYSCALL(remVariable)
 359:	b8 1a 00 00 00       	mov    $0x1a,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <changeProcTime>:
SYSCALL(changeProcTime)
 361:	b8 1b 00 00 00       	mov    $0x1b,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <set_priority>:
 369:	b8 1c 00 00 00       	mov    $0x1c,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 371:	55                   	push   %ebp
 372:	89 e5                	mov    %esp,%ebp
 374:	57                   	push   %edi
 375:	56                   	push   %esi
 376:	53                   	push   %ebx
 377:	83 ec 3c             	sub    $0x3c,%esp
 37a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 37d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 381:	74 12                	je     395 <printint+0x24>
 383:	89 d0                	mov    %edx,%eax
 385:	c1 e8 1f             	shr    $0x1f,%eax
 388:	84 c0                	test   %al,%al
 38a:	74 09                	je     395 <printint+0x24>
    neg = 1;
    x = -xx;
 38c:	f7 da                	neg    %edx
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 38e:	be 01 00 00 00       	mov    $0x1,%esi
 393:	eb 05                	jmp    39a <printint+0x29>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 395:	be 00 00 00 00       	mov    $0x0,%esi
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 39a:	bf 00 00 00 00       	mov    $0x0,%edi
 39f:	eb 02                	jmp    3a3 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 3a1:	89 df                	mov    %ebx,%edi
 3a3:	8d 5f 01             	lea    0x1(%edi),%ebx
 3a6:	89 d0                	mov    %edx,%eax
 3a8:	ba 00 00 00 00       	mov    $0x0,%edx
 3ad:	f7 f1                	div    %ecx
 3af:	0f b6 92 6c 07 00 00 	movzbl 0x76c(%edx),%edx
 3b6:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 3ba:	89 c2                	mov    %eax,%edx
 3bc:	85 c0                	test   %eax,%eax
 3be:	75 e1                	jne    3a1 <printint+0x30>
  if(neg)
 3c0:	85 f6                	test   %esi,%esi
 3c2:	74 08                	je     3cc <printint+0x5b>
    buf[i++] = '-';
 3c4:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 3c9:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 3cc:	89 d8                	mov    %ebx,%eax
 3ce:	83 e8 01             	sub    $0x1,%eax
 3d1:	78 29                	js     3fc <printint+0x8b>
 3d3:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 3d6:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3da:	8d 7d d7             	lea    -0x29(%ebp),%edi
 3dd:	0f b6 03             	movzbl (%ebx),%eax
 3e0:	88 45 d7             	mov    %al,-0x29(%ebp)
 3e3:	83 ec 04             	sub    $0x4,%esp
 3e6:	6a 01                	push   $0x1
 3e8:	57                   	push   %edi
 3e9:	56                   	push   %esi
 3ea:	e8 d2 fe ff ff       	call   2c1 <write>
 3ef:	83 eb 01             	sub    $0x1,%ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3f2:	83 c4 10             	add    $0x10,%esp
 3f5:	8d 45 d7             	lea    -0x29(%ebp),%eax
 3f8:	39 c3                	cmp    %eax,%ebx
 3fa:	75 e1                	jne    3dd <printint+0x6c>
    putc(fd, buf[i]);
}
 3fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ff:	5b                   	pop    %ebx
 400:	5e                   	pop    %esi
 401:	5f                   	pop    %edi
 402:	5d                   	pop    %ebp
 403:	c3                   	ret    

00000404 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 404:	55                   	push   %ebp
 405:	89 e5                	mov    %esp,%ebp
 407:	57                   	push   %edi
 408:	56                   	push   %esi
 409:	53                   	push   %ebx
 40a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 40d:	8b 75 0c             	mov    0xc(%ebp),%esi
 410:	0f b6 1e             	movzbl (%esi),%ebx
 413:	84 db                	test   %bl,%bl
 415:	0f 84 a6 01 00 00    	je     5c1 <printf+0x1bd>
 41b:	83 c6 01             	add    $0x1,%esi
 41e:	8d 45 10             	lea    0x10(%ebp),%eax
 421:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 424:	bf 00 00 00 00       	mov    $0x0,%edi
    c = fmt[i] & 0xff;
 429:	0f be d3             	movsbl %bl,%edx
 42c:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 42f:	85 ff                	test   %edi,%edi
 431:	75 25                	jne    458 <printf+0x54>
      if(c == '%'){
 433:	83 f8 25             	cmp    $0x25,%eax
 436:	0f 84 6a 01 00 00    	je     5a6 <printf+0x1a2>
 43c:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 43f:	83 ec 04             	sub    $0x4,%esp
 442:	6a 01                	push   $0x1
 444:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 447:	50                   	push   %eax
 448:	ff 75 08             	pushl  0x8(%ebp)
 44b:	e8 71 fe ff ff       	call   2c1 <write>
 450:	83 c4 10             	add    $0x10,%esp
 453:	e9 5a 01 00 00       	jmp    5b2 <printf+0x1ae>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 458:	83 ff 25             	cmp    $0x25,%edi
 45b:	0f 85 51 01 00 00    	jne    5b2 <printf+0x1ae>
      if(c == 'd'){
 461:	83 f8 64             	cmp    $0x64,%eax
 464:	75 2c                	jne    492 <printf+0x8e>
        printint(fd, *ap, 10, 1);
 466:	83 ec 0c             	sub    $0xc,%esp
 469:	6a 01                	push   $0x1
 46b:	b9 0a 00 00 00       	mov    $0xa,%ecx
 470:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 473:	8b 17                	mov    (%edi),%edx
 475:	8b 45 08             	mov    0x8(%ebp),%eax
 478:	e8 f4 fe ff ff       	call   371 <printint>
        ap++;
 47d:	89 f8                	mov    %edi,%eax
 47f:	83 c0 04             	add    $0x4,%eax
 482:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 485:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 488:	bf 00 00 00 00       	mov    $0x0,%edi
 48d:	e9 20 01 00 00       	jmp    5b2 <printf+0x1ae>
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 492:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 498:	83 fa 70             	cmp    $0x70,%edx
 49b:	75 2c                	jne    4c9 <printf+0xc5>
        printint(fd, *ap, 16, 0);
 49d:	83 ec 0c             	sub    $0xc,%esp
 4a0:	6a 00                	push   $0x0
 4a2:	b9 10 00 00 00       	mov    $0x10,%ecx
 4a7:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4aa:	8b 17                	mov    (%edi),%edx
 4ac:	8b 45 08             	mov    0x8(%ebp),%eax
 4af:	e8 bd fe ff ff       	call   371 <printint>
        ap++;
 4b4:	89 f8                	mov    %edi,%eax
 4b6:	83 c0 04             	add    $0x4,%eax
 4b9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4bc:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4bf:	bf 00 00 00 00       	mov    $0x0,%edi
 4c4:	e9 e9 00 00 00       	jmp    5b2 <printf+0x1ae>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4c9:	83 f8 73             	cmp    $0x73,%eax
 4cc:	75 52                	jne    520 <printf+0x11c>
        s = (char*)*ap;
 4ce:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4d1:	8b 18                	mov    (%eax),%ebx
        ap++;
 4d3:	83 c0 04             	add    $0x4,%eax
 4d6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 4d9:	85 db                	test   %ebx,%ebx
          s = "(null)";
 4db:	b8 64 07 00 00       	mov    $0x764,%eax
 4e0:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 4e3:	0f b6 03             	movzbl (%ebx),%eax
 4e6:	84 c0                	test   %al,%al
 4e8:	0f 84 bf 00 00 00    	je     5ad <printf+0x1a9>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ee:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 4f1:	89 75 d0             	mov    %esi,-0x30(%ebp)
 4f4:	8b 75 08             	mov    0x8(%ebp),%esi
 4f7:	88 45 e3             	mov    %al,-0x1d(%ebp)
 4fa:	83 ec 04             	sub    $0x4,%esp
 4fd:	6a 01                	push   $0x1
 4ff:	57                   	push   %edi
 500:	56                   	push   %esi
 501:	e8 bb fd ff ff       	call   2c1 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 506:	83 c3 01             	add    $0x1,%ebx
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 509:	0f b6 03             	movzbl (%ebx),%eax
 50c:	83 c4 10             	add    $0x10,%esp
 50f:	84 c0                	test   %al,%al
 511:	75 e4                	jne    4f7 <printf+0xf3>
 513:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 516:	bf 00 00 00 00       	mov    $0x0,%edi
 51b:	e9 92 00 00 00       	jmp    5b2 <printf+0x1ae>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 520:	83 f8 63             	cmp    $0x63,%eax
 523:	75 2b                	jne    550 <printf+0x14c>
 525:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 528:	8b 07                	mov    (%edi),%eax
 52a:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 52d:	83 ec 04             	sub    $0x4,%esp
 530:	6a 01                	push   $0x1
 532:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 535:	50                   	push   %eax
 536:	ff 75 08             	pushl  0x8(%ebp)
 539:	e8 83 fd ff ff       	call   2c1 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 53e:	89 f8                	mov    %edi,%eax
 540:	83 c0 04             	add    $0x4,%eax
 543:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 546:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 549:	bf 00 00 00 00       	mov    $0x0,%edi
 54e:	eb 62                	jmp    5b2 <printf+0x1ae>
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 550:	83 f8 25             	cmp    $0x25,%eax
 553:	75 1e                	jne    573 <printf+0x16f>
 555:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 558:	83 ec 04             	sub    $0x4,%esp
 55b:	6a 01                	push   $0x1
 55d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 560:	50                   	push   %eax
 561:	ff 75 08             	pushl  0x8(%ebp)
 564:	e8 58 fd ff ff       	call   2c1 <write>
 569:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 56c:	bf 00 00 00 00       	mov    $0x0,%edi
 571:	eb 3f                	jmp    5b2 <printf+0x1ae>
 573:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 577:	83 ec 04             	sub    $0x4,%esp
 57a:	6a 01                	push   $0x1
 57c:	8d 45 e7             	lea    -0x19(%ebp),%eax
 57f:	50                   	push   %eax
 580:	ff 75 08             	pushl  0x8(%ebp)
 583:	e8 39 fd ff ff       	call   2c1 <write>
 588:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 58b:	83 c4 0c             	add    $0xc,%esp
 58e:	6a 01                	push   $0x1
 590:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 593:	50                   	push   %eax
 594:	ff 75 08             	pushl  0x8(%ebp)
 597:	e8 25 fd ff ff       	call   2c1 <write>
 59c:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 59f:	bf 00 00 00 00       	mov    $0x0,%edi
 5a4:	eb 0c                	jmp    5b2 <printf+0x1ae>
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5a6:	bf 25 00 00 00       	mov    $0x25,%edi
 5ab:	eb 05                	jmp    5b2 <printf+0x1ae>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5ad:	bf 00 00 00 00       	mov    $0x0,%edi
 5b2:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b5:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5b9:	84 db                	test   %bl,%bl
 5bb:	0f 85 68 fe ff ff    	jne    429 <printf+0x25>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c4:	5b                   	pop    %ebx
 5c5:	5e                   	pop    %esi
 5c6:	5f                   	pop    %edi
 5c7:	5d                   	pop    %ebp
 5c8:	c3                   	ret    

000005c9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c9:	55                   	push   %ebp
 5ca:	89 e5                	mov    %esp,%ebp
 5cc:	57                   	push   %edi
 5cd:	56                   	push   %esi
 5ce:	53                   	push   %ebx
 5cf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5d2:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d5:	a1 c8 09 00 00       	mov    0x9c8,%eax
 5da:	eb 0c                	jmp    5e8 <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5dc:	8b 10                	mov    (%eax),%edx
 5de:	39 d0                	cmp    %edx,%eax
 5e0:	72 04                	jb     5e6 <free+0x1d>
 5e2:	39 d1                	cmp    %edx,%ecx
 5e4:	72 0c                	jb     5f2 <free+0x29>
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e6:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e8:	39 c8                	cmp    %ecx,%eax
 5ea:	73 f0                	jae    5dc <free+0x13>
 5ec:	8b 10                	mov    (%eax),%edx
 5ee:	39 d1                	cmp    %edx,%ecx
 5f0:	73 3e                	jae    630 <free+0x67>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5f2:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5f5:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5f8:	8b 10                	mov    (%eax),%edx
 5fa:	39 d7                	cmp    %edx,%edi
 5fc:	75 0f                	jne    60d <free+0x44>
    bp->s.size += p->s.ptr->s.size;
 5fe:	03 77 04             	add    0x4(%edi),%esi
 601:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 604:	8b 10                	mov    (%eax),%edx
 606:	8b 12                	mov    (%edx),%edx
 608:	89 53 f8             	mov    %edx,-0x8(%ebx)
 60b:	eb 03                	jmp    610 <free+0x47>
  } else
    bp->s.ptr = p->s.ptr;
 60d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 610:	8b 50 04             	mov    0x4(%eax),%edx
 613:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 616:	39 f1                	cmp    %esi,%ecx
 618:	75 0d                	jne    627 <free+0x5e>
    p->s.size += bp->s.size;
 61a:	03 53 fc             	add    -0x4(%ebx),%edx
 61d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 620:	8b 53 f8             	mov    -0x8(%ebx),%edx
 623:	89 10                	mov    %edx,(%eax)
 625:	eb 02                	jmp    629 <free+0x60>
  } else
    p->s.ptr = bp;
 627:	89 08                	mov    %ecx,(%eax)
  freep = p;
 629:	a3 c8 09 00 00       	mov    %eax,0x9c8
}
 62e:	eb 06                	jmp    636 <free+0x6d>
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 630:	39 d0                	cmp    %edx,%eax
 632:	72 b2                	jb     5e6 <free+0x1d>
 634:	eb bc                	jmp    5f2 <free+0x29>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 636:	5b                   	pop    %ebx
 637:	5e                   	pop    %esi
 638:	5f                   	pop    %edi
 639:	5d                   	pop    %ebp
 63a:	c3                   	ret    

0000063b <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 63b:	55                   	push   %ebp
 63c:	89 e5                	mov    %esp,%ebp
 63e:	57                   	push   %edi
 63f:	56                   	push   %esi
 640:	53                   	push   %ebx
 641:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 644:	8b 45 08             	mov    0x8(%ebp),%eax
 647:	8d 58 07             	lea    0x7(%eax),%ebx
 64a:	c1 eb 03             	shr    $0x3,%ebx
 64d:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 650:	8b 15 c8 09 00 00    	mov    0x9c8,%edx
 656:	85 d2                	test   %edx,%edx
 658:	75 23                	jne    67d <malloc+0x42>
    base.s.ptr = freep = prevp = &base;
 65a:	c7 05 c8 09 00 00 cc 	movl   $0x9cc,0x9c8
 661:	09 00 00 
 664:	c7 05 cc 09 00 00 cc 	movl   $0x9cc,0x9cc
 66b:	09 00 00 
    base.s.size = 0;
 66e:	c7 05 d0 09 00 00 00 	movl   $0x0,0x9d0
 675:	00 00 00 
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 678:	ba cc 09 00 00       	mov    $0x9cc,%edx
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 67d:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 67f:	8b 48 04             	mov    0x4(%eax),%ecx
 682:	39 cb                	cmp    %ecx,%ebx
 684:	77 20                	ja     6a6 <malloc+0x6b>
      if(p->s.size == nunits)
 686:	39 cb                	cmp    %ecx,%ebx
 688:	75 06                	jne    690 <malloc+0x55>
        prevp->s.ptr = p->s.ptr;
 68a:	8b 08                	mov    (%eax),%ecx
 68c:	89 0a                	mov    %ecx,(%edx)
 68e:	eb 0b                	jmp    69b <malloc+0x60>
      else {
        p->s.size -= nunits;
 690:	29 d9                	sub    %ebx,%ecx
 692:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 695:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 698:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 69b:	89 15 c8 09 00 00    	mov    %edx,0x9c8
      return (void*)(p + 1);
 6a1:	83 c0 08             	add    $0x8,%eax
 6a4:	eb 63                	jmp    709 <malloc+0xce>
 6a6:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 6ac:	be 00 10 00 00       	mov    $0x1000,%esi
 6b1:	0f 43 f3             	cmovae %ebx,%esi
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6b4:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 6bb:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6bd:	39 05 c8 09 00 00    	cmp    %eax,0x9c8
 6c3:	75 2d                	jne    6f2 <malloc+0xb7>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6c5:	83 ec 0c             	sub    $0xc,%esp
 6c8:	57                   	push   %edi
 6c9:	e8 5b fc ff ff       	call   329 <sbrk>
  if(p == (char*)-1)
 6ce:	83 c4 10             	add    $0x10,%esp
 6d1:	83 f8 ff             	cmp    $0xffffffff,%eax
 6d4:	74 27                	je     6fd <malloc+0xc2>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6d6:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6d9:	83 ec 0c             	sub    $0xc,%esp
 6dc:	83 c0 08             	add    $0x8,%eax
 6df:	50                   	push   %eax
 6e0:	e8 e4 fe ff ff       	call   5c9 <free>
  return freep;
 6e5:	8b 15 c8 09 00 00    	mov    0x9c8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6eb:	83 c4 10             	add    $0x10,%esp
 6ee:	85 d2                	test   %edx,%edx
 6f0:	74 12                	je     704 <malloc+0xc9>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f2:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6f4:	8b 48 04             	mov    0x4(%eax),%ecx
 6f7:	39 cb                	cmp    %ecx,%ebx
 6f9:	77 c0                	ja     6bb <malloc+0x80>
 6fb:	eb 89                	jmp    686 <malloc+0x4b>
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 6fd:	b8 00 00 00 00       	mov    $0x0,%eax
 702:	eb 05                	jmp    709 <malloc+0xce>
 704:	b8 00 00 00 00       	mov    $0x0,%eax
  }
}
 709:	8d 65 f4             	lea    -0xc(%ebp),%esp
 70c:	5b                   	pop    %ebx
 70d:	5e                   	pop    %esi
 70e:	5f                   	pop    %edi
 70f:	5d                   	pop    %ebp
 710:	c3                   	ret    
