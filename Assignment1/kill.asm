
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 08             	sub    $0x8,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
  19:	bb 01 00 00 00       	mov    $0x1,%ebx
  int i;

  if(argc < 2){
  1e:	83 fe 01             	cmp    $0x1,%esi
  21:	7f 14                	jg     37 <main+0x37>
    printf(2, "usage: kill pid...\n");
  23:	83 ec 08             	sub    $0x8,%esp
  26:	68 90 06 00 00       	push   $0x690
  2b:	6a 02                	push   $0x2
  2d:	e8 4e 03 00 00       	call   380 <printf>
    exit();
  32:	e8 e6 01 00 00       	call   21d <exit>
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  37:	83 ec 0c             	sub    $0xc,%esp
  3a:	ff 34 9f             	pushl  (%edi,%ebx,4)
  3d:	e8 72 01 00 00       	call   1b4 <atoi>
  42:	89 04 24             	mov    %eax,(%esp)
  45:	e8 03 02 00 00       	call   24d <kill>

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  4a:	83 c3 01             	add    $0x1,%ebx
  4d:	83 c4 10             	add    $0x10,%esp
  50:	39 de                	cmp    %ebx,%esi
  52:	75 e3                	jne    37 <main+0x37>
    kill(atoi(argv[i]));
  exit();
  54:	e8 c4 01 00 00       	call   21d <exit>

00000059 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  59:	55                   	push   %ebp
  5a:	89 e5                	mov    %esp,%ebp
  5c:	53                   	push   %ebx
  5d:	8b 45 08             	mov    0x8(%ebp),%eax
  60:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  63:	89 c2                	mov    %eax,%edx
  65:	83 c2 01             	add    $0x1,%edx
  68:	83 c1 01             	add    $0x1,%ecx
  6b:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  6f:	88 5a ff             	mov    %bl,-0x1(%edx)
  72:	84 db                	test   %bl,%bl
  74:	75 ef                	jne    65 <strcpy+0xc>
    ;
  return os;
}
  76:	5b                   	pop    %ebx
  77:	5d                   	pop    %ebp
  78:	c3                   	ret    

00000079 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  79:	55                   	push   %ebp
  7a:	89 e5                	mov    %esp,%ebp
  7c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  82:	0f b6 01             	movzbl (%ecx),%eax
  85:	84 c0                	test   %al,%al
  87:	74 15                	je     9e <strcmp+0x25>
  89:	3a 02                	cmp    (%edx),%al
  8b:	75 11                	jne    9e <strcmp+0x25>
    p++, q++;
  8d:	83 c1 01             	add    $0x1,%ecx
  90:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  93:	0f b6 01             	movzbl (%ecx),%eax
  96:	84 c0                	test   %al,%al
  98:	74 04                	je     9e <strcmp+0x25>
  9a:	3a 02                	cmp    (%edx),%al
  9c:	74 ef                	je     8d <strcmp+0x14>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  9e:	0f b6 c0             	movzbl %al,%eax
  a1:	0f b6 12             	movzbl (%edx),%edx
  a4:	29 d0                	sub    %edx,%eax
}
  a6:	5d                   	pop    %ebp
  a7:	c3                   	ret    

000000a8 <strlen>:

uint
strlen(char *s)
{
  a8:	55                   	push   %ebp
  a9:	89 e5                	mov    %esp,%ebp
  ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ae:	80 39 00             	cmpb   $0x0,(%ecx)
  b1:	74 12                	je     c5 <strlen+0x1d>
  b3:	ba 00 00 00 00       	mov    $0x0,%edx
  b8:	83 c2 01             	add    $0x1,%edx
  bb:	89 d0                	mov    %edx,%eax
  bd:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c1:	75 f5                	jne    b8 <strlen+0x10>
  c3:	eb 05                	jmp    ca <strlen+0x22>
  c5:	b8 00 00 00 00       	mov    $0x0,%eax
    ;
  return n;
}
  ca:	5d                   	pop    %ebp
  cb:	c3                   	ret    

000000cc <memset>:

void*
memset(void *dst, int c, uint n)
{
  cc:	55                   	push   %ebp
  cd:	89 e5                	mov    %esp,%ebp
  cf:	57                   	push   %edi
  d0:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  d3:	89 d7                	mov    %edx,%edi
  d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  db:	fc                   	cld    
  dc:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  de:	89 d0                	mov    %edx,%eax
  e0:	5f                   	pop    %edi
  e1:	5d                   	pop    %ebp
  e2:	c3                   	ret    

000000e3 <strchr>:

char*
strchr(const char *s, char c)
{
  e3:	55                   	push   %ebp
  e4:	89 e5                	mov    %esp,%ebp
  e6:	53                   	push   %ebx
  e7:	8b 45 08             	mov    0x8(%ebp),%eax
  ea:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
  ed:	0f b6 10             	movzbl (%eax),%edx
  f0:	84 d2                	test   %dl,%dl
  f2:	74 1d                	je     111 <strchr+0x2e>
  f4:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
  f6:	38 d3                	cmp    %dl,%bl
  f8:	75 06                	jne    100 <strchr+0x1d>
  fa:	eb 1a                	jmp    116 <strchr+0x33>
  fc:	38 ca                	cmp    %cl,%dl
  fe:	74 16                	je     116 <strchr+0x33>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 100:	83 c0 01             	add    $0x1,%eax
 103:	0f b6 10             	movzbl (%eax),%edx
 106:	84 d2                	test   %dl,%dl
 108:	75 f2                	jne    fc <strchr+0x19>
    if(*s == c)
      return (char*)s;
  return 0;
 10a:	b8 00 00 00 00       	mov    $0x0,%eax
 10f:	eb 05                	jmp    116 <strchr+0x33>
 111:	b8 00 00 00 00       	mov    $0x0,%eax
}
 116:	5b                   	pop    %ebx
 117:	5d                   	pop    %ebp
 118:	c3                   	ret    

00000119 <gets>:

char*
gets(char *buf, int max)
{
 119:	55                   	push   %ebp
 11a:	89 e5                	mov    %esp,%ebp
 11c:	57                   	push   %edi
 11d:	56                   	push   %esi
 11e:	53                   	push   %ebx
 11f:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 122:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 127:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12a:	eb 29                	jmp    155 <gets+0x3c>
    cc = read(0, &c, 1);
 12c:	83 ec 04             	sub    $0x4,%esp
 12f:	6a 01                	push   $0x1
 131:	57                   	push   %edi
 132:	6a 00                	push   $0x0
 134:	e8 fc 00 00 00       	call   235 <read>
    if(cc < 1)
 139:	83 c4 10             	add    $0x10,%esp
 13c:	85 c0                	test   %eax,%eax
 13e:	7e 21                	jle    161 <gets+0x48>
      break;
    buf[i++] = c;
 140:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 144:	8b 55 08             	mov    0x8(%ebp),%edx
 147:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14b:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 14d:	3c 0a                	cmp    $0xa,%al
 14f:	74 0e                	je     15f <gets+0x46>
 151:	3c 0d                	cmp    $0xd,%al
 153:	74 0a                	je     15f <gets+0x46>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 155:	8d 5e 01             	lea    0x1(%esi),%ebx
 158:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 15b:	7c cf                	jl     12c <gets+0x13>
 15d:	eb 02                	jmp    161 <gets+0x48>
 15f:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 161:	8b 45 08             	mov    0x8(%ebp),%eax
 164:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 168:	8d 65 f4             	lea    -0xc(%ebp),%esp
 16b:	5b                   	pop    %ebx
 16c:	5e                   	pop    %esi
 16d:	5f                   	pop    %edi
 16e:	5d                   	pop    %ebp
 16f:	c3                   	ret    

00000170 <stat>:

int
stat(char *n, struct stat *st)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	56                   	push   %esi
 174:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 175:	83 ec 08             	sub    $0x8,%esp
 178:	6a 00                	push   $0x0
 17a:	ff 75 08             	pushl  0x8(%ebp)
 17d:	e8 db 00 00 00       	call   25d <open>
  if(fd < 0)
 182:	83 c4 10             	add    $0x10,%esp
 185:	85 c0                	test   %eax,%eax
 187:	78 1f                	js     1a8 <stat+0x38>
 189:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 18b:	83 ec 08             	sub    $0x8,%esp
 18e:	ff 75 0c             	pushl  0xc(%ebp)
 191:	50                   	push   %eax
 192:	e8 de 00 00 00       	call   275 <fstat>
 197:	89 c6                	mov    %eax,%esi
  close(fd);
 199:	89 1c 24             	mov    %ebx,(%esp)
 19c:	e8 a4 00 00 00       	call   245 <close>
  return r;
 1a1:	83 c4 10             	add    $0x10,%esp
 1a4:	89 f0                	mov    %esi,%eax
 1a6:	eb 05                	jmp    1ad <stat+0x3d>
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  r = fstat(fd, st);
  close(fd);
  return r;
}
 1ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1b0:	5b                   	pop    %ebx
 1b1:	5e                   	pop    %esi
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    

000001b4 <atoi>:

int
atoi(const char *s)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	53                   	push   %ebx
 1b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1bb:	0f b6 11             	movzbl (%ecx),%edx
 1be:	8d 42 d0             	lea    -0x30(%edx),%eax
 1c1:	3c 09                	cmp    $0x9,%al
 1c3:	77 1f                	ja     1e4 <atoi+0x30>
 1c5:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 1ca:	83 c1 01             	add    $0x1,%ecx
 1cd:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1d0:	0f be d2             	movsbl %dl,%edx
 1d3:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d7:	0f b6 11             	movzbl (%ecx),%edx
 1da:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1dd:	80 fb 09             	cmp    $0x9,%bl
 1e0:	76 e8                	jbe    1ca <atoi+0x16>
 1e2:	eb 05                	jmp    1e9 <atoi+0x35>
int
atoi(const char *s)
{
  int n;

  n = 0;
 1e4:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
  return n;
}
 1e9:	5b                   	pop    %ebx
 1ea:	5d                   	pop    %ebp
 1eb:	c3                   	ret    

000001ec <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1ec:	55                   	push   %ebp
 1ed:	89 e5                	mov    %esp,%ebp
 1ef:	56                   	push   %esi
 1f0:	53                   	push   %ebx
 1f1:	8b 45 08             	mov    0x8(%ebp),%eax
 1f4:	8b 75 0c             	mov    0xc(%ebp),%esi
 1f7:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1fa:	85 db                	test   %ebx,%ebx
 1fc:	7e 13                	jle    211 <memmove+0x25>
 1fe:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 203:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 207:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 20a:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 20d:	39 da                	cmp    %ebx,%edx
 20f:	75 f2                	jne    203 <memmove+0x17>
    *dst++ = *src++;
  return vdst;
}
 211:	5b                   	pop    %ebx
 212:	5e                   	pop    %esi
 213:	5d                   	pop    %ebp
 214:	c3                   	ret    

00000215 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 215:	b8 01 00 00 00       	mov    $0x1,%eax
 21a:	cd 40                	int    $0x40
 21c:	c3                   	ret    

0000021d <exit>:
SYSCALL(exit)
 21d:	b8 02 00 00 00       	mov    $0x2,%eax
 222:	cd 40                	int    $0x40
 224:	c3                   	ret    

00000225 <wait>:
SYSCALL(wait)
 225:	b8 03 00 00 00       	mov    $0x3,%eax
 22a:	cd 40                	int    $0x40
 22c:	c3                   	ret    

0000022d <pipe>:
SYSCALL(pipe)
 22d:	b8 04 00 00 00       	mov    $0x4,%eax
 232:	cd 40                	int    $0x40
 234:	c3                   	ret    

00000235 <read>:
SYSCALL(read)
 235:	b8 05 00 00 00       	mov    $0x5,%eax
 23a:	cd 40                	int    $0x40
 23c:	c3                   	ret    

0000023d <write>:
SYSCALL(write)
 23d:	b8 10 00 00 00       	mov    $0x10,%eax
 242:	cd 40                	int    $0x40
 244:	c3                   	ret    

00000245 <close>:
SYSCALL(close)
 245:	b8 15 00 00 00       	mov    $0x15,%eax
 24a:	cd 40                	int    $0x40
 24c:	c3                   	ret    

0000024d <kill>:
SYSCALL(kill)
 24d:	b8 06 00 00 00       	mov    $0x6,%eax
 252:	cd 40                	int    $0x40
 254:	c3                   	ret    

00000255 <exec>:
SYSCALL(exec)
 255:	b8 07 00 00 00       	mov    $0x7,%eax
 25a:	cd 40                	int    $0x40
 25c:	c3                   	ret    

0000025d <open>:
SYSCALL(open)
 25d:	b8 0f 00 00 00       	mov    $0xf,%eax
 262:	cd 40                	int    $0x40
 264:	c3                   	ret    

00000265 <mknod>:
SYSCALL(mknod)
 265:	b8 11 00 00 00       	mov    $0x11,%eax
 26a:	cd 40                	int    $0x40
 26c:	c3                   	ret    

0000026d <unlink>:
SYSCALL(unlink)
 26d:	b8 12 00 00 00       	mov    $0x12,%eax
 272:	cd 40                	int    $0x40
 274:	c3                   	ret    

00000275 <fstat>:
SYSCALL(fstat)
 275:	b8 08 00 00 00       	mov    $0x8,%eax
 27a:	cd 40                	int    $0x40
 27c:	c3                   	ret    

0000027d <link>:
SYSCALL(link)
 27d:	b8 13 00 00 00       	mov    $0x13,%eax
 282:	cd 40                	int    $0x40
 284:	c3                   	ret    

00000285 <mkdir>:
SYSCALL(mkdir)
 285:	b8 14 00 00 00       	mov    $0x14,%eax
 28a:	cd 40                	int    $0x40
 28c:	c3                   	ret    

0000028d <chdir>:
SYSCALL(chdir)
 28d:	b8 09 00 00 00       	mov    $0x9,%eax
 292:	cd 40                	int    $0x40
 294:	c3                   	ret    

00000295 <dup>:
SYSCALL(dup)
 295:	b8 0a 00 00 00       	mov    $0xa,%eax
 29a:	cd 40                	int    $0x40
 29c:	c3                   	ret    

0000029d <getpid>:
SYSCALL(getpid)
 29d:	b8 0b 00 00 00       	mov    $0xb,%eax
 2a2:	cd 40                	int    $0x40
 2a4:	c3                   	ret    

000002a5 <sbrk>:
SYSCALL(sbrk)
 2a5:	b8 0c 00 00 00       	mov    $0xc,%eax
 2aa:	cd 40                	int    $0x40
 2ac:	c3                   	ret    

000002ad <sleep>:
SYSCALL(sleep)
 2ad:	b8 0d 00 00 00       	mov    $0xd,%eax
 2b2:	cd 40                	int    $0x40
 2b4:	c3                   	ret    

000002b5 <uptime>:
SYSCALL(uptime)
 2b5:	b8 0e 00 00 00       	mov    $0xe,%eax
 2ba:	cd 40                	int    $0x40
 2bc:	c3                   	ret    

000002bd <wait2>:
SYSCALL(wait2)
 2bd:	b8 17 00 00 00       	mov    $0x17,%eax
 2c2:	cd 40                	int    $0x40
 2c4:	c3                   	ret    

000002c5 <setVariable>:
SYSCALL(setVariable)
 2c5:	b8 18 00 00 00       	mov    $0x18,%eax
 2ca:	cd 40                	int    $0x40
 2cc:	c3                   	ret    

000002cd <getVariable>:
SYSCALL(getVariable)
 2cd:	b8 19 00 00 00       	mov    $0x19,%eax
 2d2:	cd 40                	int    $0x40
 2d4:	c3                   	ret    

000002d5 <remVariable>:
SYSCALL(remVariable)
 2d5:	b8 1a 00 00 00       	mov    $0x1a,%eax
 2da:	cd 40                	int    $0x40
 2dc:	c3                   	ret    

000002dd <changeProcTime>:
SYSCALL(changeProcTime)
 2dd:	b8 1b 00 00 00       	mov    $0x1b,%eax
 2e2:	cd 40                	int    $0x40
 2e4:	c3                   	ret    

000002e5 <set_priority>:
 2e5:	b8 1c 00 00 00       	mov    $0x1c,%eax
 2ea:	cd 40                	int    $0x40
 2ec:	c3                   	ret    

000002ed <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2ed:	55                   	push   %ebp
 2ee:	89 e5                	mov    %esp,%ebp
 2f0:	57                   	push   %edi
 2f1:	56                   	push   %esi
 2f2:	53                   	push   %ebx
 2f3:	83 ec 3c             	sub    $0x3c,%esp
 2f6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2fd:	74 12                	je     311 <printint+0x24>
 2ff:	89 d0                	mov    %edx,%eax
 301:	c1 e8 1f             	shr    $0x1f,%eax
 304:	84 c0                	test   %al,%al
 306:	74 09                	je     311 <printint+0x24>
    neg = 1;
    x = -xx;
 308:	f7 da                	neg    %edx
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 30a:	be 01 00 00 00       	mov    $0x1,%esi
 30f:	eb 05                	jmp    316 <printint+0x29>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 311:	be 00 00 00 00       	mov    $0x0,%esi
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 316:	bf 00 00 00 00       	mov    $0x0,%edi
 31b:	eb 02                	jmp    31f <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 31d:	89 df                	mov    %ebx,%edi
 31f:	8d 5f 01             	lea    0x1(%edi),%ebx
 322:	89 d0                	mov    %edx,%eax
 324:	ba 00 00 00 00       	mov    $0x0,%edx
 329:	f7 f1                	div    %ecx
 32b:	0f b6 92 ac 06 00 00 	movzbl 0x6ac(%edx),%edx
 332:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 336:	89 c2                	mov    %eax,%edx
 338:	85 c0                	test   %eax,%eax
 33a:	75 e1                	jne    31d <printint+0x30>
  if(neg)
 33c:	85 f6                	test   %esi,%esi
 33e:	74 08                	je     348 <printint+0x5b>
    buf[i++] = '-';
 340:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 345:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 348:	89 d8                	mov    %ebx,%eax
 34a:	83 e8 01             	sub    $0x1,%eax
 34d:	78 29                	js     378 <printint+0x8b>
 34f:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 352:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 356:	8d 7d d7             	lea    -0x29(%ebp),%edi
 359:	0f b6 03             	movzbl (%ebx),%eax
 35c:	88 45 d7             	mov    %al,-0x29(%ebp)
 35f:	83 ec 04             	sub    $0x4,%esp
 362:	6a 01                	push   $0x1
 364:	57                   	push   %edi
 365:	56                   	push   %esi
 366:	e8 d2 fe ff ff       	call   23d <write>
 36b:	83 eb 01             	sub    $0x1,%ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 36e:	83 c4 10             	add    $0x10,%esp
 371:	8d 45 d7             	lea    -0x29(%ebp),%eax
 374:	39 c3                	cmp    %eax,%ebx
 376:	75 e1                	jne    359 <printint+0x6c>
    putc(fd, buf[i]);
}
 378:	8d 65 f4             	lea    -0xc(%ebp),%esp
 37b:	5b                   	pop    %ebx
 37c:	5e                   	pop    %esi
 37d:	5f                   	pop    %edi
 37e:	5d                   	pop    %ebp
 37f:	c3                   	ret    

00000380 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
 386:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 389:	8b 75 0c             	mov    0xc(%ebp),%esi
 38c:	0f b6 1e             	movzbl (%esi),%ebx
 38f:	84 db                	test   %bl,%bl
 391:	0f 84 a6 01 00 00    	je     53d <printf+0x1bd>
 397:	83 c6 01             	add    $0x1,%esi
 39a:	8d 45 10             	lea    0x10(%ebp),%eax
 39d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3a0:	bf 00 00 00 00       	mov    $0x0,%edi
    c = fmt[i] & 0xff;
 3a5:	0f be d3             	movsbl %bl,%edx
 3a8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 3ab:	85 ff                	test   %edi,%edi
 3ad:	75 25                	jne    3d4 <printf+0x54>
      if(c == '%'){
 3af:	83 f8 25             	cmp    $0x25,%eax
 3b2:	0f 84 6a 01 00 00    	je     522 <printf+0x1a2>
 3b8:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3bb:	83 ec 04             	sub    $0x4,%esp
 3be:	6a 01                	push   $0x1
 3c0:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3c3:	50                   	push   %eax
 3c4:	ff 75 08             	pushl  0x8(%ebp)
 3c7:	e8 71 fe ff ff       	call   23d <write>
 3cc:	83 c4 10             	add    $0x10,%esp
 3cf:	e9 5a 01 00 00       	jmp    52e <printf+0x1ae>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 3d4:	83 ff 25             	cmp    $0x25,%edi
 3d7:	0f 85 51 01 00 00    	jne    52e <printf+0x1ae>
      if(c == 'd'){
 3dd:	83 f8 64             	cmp    $0x64,%eax
 3e0:	75 2c                	jne    40e <printf+0x8e>
        printint(fd, *ap, 10, 1);
 3e2:	83 ec 0c             	sub    $0xc,%esp
 3e5:	6a 01                	push   $0x1
 3e7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 3ec:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 3ef:	8b 17                	mov    (%edi),%edx
 3f1:	8b 45 08             	mov    0x8(%ebp),%eax
 3f4:	e8 f4 fe ff ff       	call   2ed <printint>
        ap++;
 3f9:	89 f8                	mov    %edi,%eax
 3fb:	83 c0 04             	add    $0x4,%eax
 3fe:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 401:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 404:	bf 00 00 00 00       	mov    $0x0,%edi
 409:	e9 20 01 00 00       	jmp    52e <printf+0x1ae>
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 40e:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 414:	83 fa 70             	cmp    $0x70,%edx
 417:	75 2c                	jne    445 <printf+0xc5>
        printint(fd, *ap, 16, 0);
 419:	83 ec 0c             	sub    $0xc,%esp
 41c:	6a 00                	push   $0x0
 41e:	b9 10 00 00 00       	mov    $0x10,%ecx
 423:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 426:	8b 17                	mov    (%edi),%edx
 428:	8b 45 08             	mov    0x8(%ebp),%eax
 42b:	e8 bd fe ff ff       	call   2ed <printint>
        ap++;
 430:	89 f8                	mov    %edi,%eax
 432:	83 c0 04             	add    $0x4,%eax
 435:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 438:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 43b:	bf 00 00 00 00       	mov    $0x0,%edi
 440:	e9 e9 00 00 00       	jmp    52e <printf+0x1ae>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 445:	83 f8 73             	cmp    $0x73,%eax
 448:	75 52                	jne    49c <printf+0x11c>
        s = (char*)*ap;
 44a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 44d:	8b 18                	mov    (%eax),%ebx
        ap++;
 44f:	83 c0 04             	add    $0x4,%eax
 452:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 455:	85 db                	test   %ebx,%ebx
          s = "(null)";
 457:	b8 a4 06 00 00       	mov    $0x6a4,%eax
 45c:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 45f:	0f b6 03             	movzbl (%ebx),%eax
 462:	84 c0                	test   %al,%al
 464:	0f 84 bf 00 00 00    	je     529 <printf+0x1a9>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 46a:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 46d:	89 75 d0             	mov    %esi,-0x30(%ebp)
 470:	8b 75 08             	mov    0x8(%ebp),%esi
 473:	88 45 e3             	mov    %al,-0x1d(%ebp)
 476:	83 ec 04             	sub    $0x4,%esp
 479:	6a 01                	push   $0x1
 47b:	57                   	push   %edi
 47c:	56                   	push   %esi
 47d:	e8 bb fd ff ff       	call   23d <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 482:	83 c3 01             	add    $0x1,%ebx
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 485:	0f b6 03             	movzbl (%ebx),%eax
 488:	83 c4 10             	add    $0x10,%esp
 48b:	84 c0                	test   %al,%al
 48d:	75 e4                	jne    473 <printf+0xf3>
 48f:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 492:	bf 00 00 00 00       	mov    $0x0,%edi
 497:	e9 92 00 00 00       	jmp    52e <printf+0x1ae>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 49c:	83 f8 63             	cmp    $0x63,%eax
 49f:	75 2b                	jne    4cc <printf+0x14c>
 4a1:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4a4:	8b 07                	mov    (%edi),%eax
 4a6:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a9:	83 ec 04             	sub    $0x4,%esp
 4ac:	6a 01                	push   $0x1
 4ae:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4b1:	50                   	push   %eax
 4b2:	ff 75 08             	pushl  0x8(%ebp)
 4b5:	e8 83 fd ff ff       	call   23d <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 4ba:	89 f8                	mov    %edi,%eax
 4bc:	83 c0 04             	add    $0x4,%eax
 4bf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4c2:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4c5:	bf 00 00 00 00       	mov    $0x0,%edi
 4ca:	eb 62                	jmp    52e <printf+0x1ae>
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4cc:	83 f8 25             	cmp    $0x25,%eax
 4cf:	75 1e                	jne    4ef <printf+0x16f>
 4d1:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4d4:	83 ec 04             	sub    $0x4,%esp
 4d7:	6a 01                	push   $0x1
 4d9:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 4dc:	50                   	push   %eax
 4dd:	ff 75 08             	pushl  0x8(%ebp)
 4e0:	e8 58 fd ff ff       	call   23d <write>
 4e5:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4e8:	bf 00 00 00 00       	mov    $0x0,%edi
 4ed:	eb 3f                	jmp    52e <printf+0x1ae>
 4ef:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4f3:	83 ec 04             	sub    $0x4,%esp
 4f6:	6a 01                	push   $0x1
 4f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4fb:	50                   	push   %eax
 4fc:	ff 75 08             	pushl  0x8(%ebp)
 4ff:	e8 39 fd ff ff       	call   23d <write>
 504:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 507:	83 c4 0c             	add    $0xc,%esp
 50a:	6a 01                	push   $0x1
 50c:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 50f:	50                   	push   %eax
 510:	ff 75 08             	pushl  0x8(%ebp)
 513:	e8 25 fd ff ff       	call   23d <write>
 518:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 51b:	bf 00 00 00 00       	mov    $0x0,%edi
 520:	eb 0c                	jmp    52e <printf+0x1ae>
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 522:	bf 25 00 00 00       	mov    $0x25,%edi
 527:	eb 05                	jmp    52e <printf+0x1ae>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 529:	bf 00 00 00 00       	mov    $0x0,%edi
 52e:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 531:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 535:	84 db                	test   %bl,%bl
 537:	0f 85 68 fe ff ff    	jne    3a5 <printf+0x25>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 53d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 540:	5b                   	pop    %ebx
 541:	5e                   	pop    %esi
 542:	5f                   	pop    %edi
 543:	5d                   	pop    %ebp
 544:	c3                   	ret    

00000545 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 545:	55                   	push   %ebp
 546:	89 e5                	mov    %esp,%ebp
 548:	57                   	push   %edi
 549:	56                   	push   %esi
 54a:	53                   	push   %ebx
 54b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 54e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 551:	a1 08 09 00 00       	mov    0x908,%eax
 556:	eb 0c                	jmp    564 <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 558:	8b 10                	mov    (%eax),%edx
 55a:	39 d0                	cmp    %edx,%eax
 55c:	72 04                	jb     562 <free+0x1d>
 55e:	39 d1                	cmp    %edx,%ecx
 560:	72 0c                	jb     56e <free+0x29>
static Header base;
static Header *freep;

void
free(void *ap)
{
 562:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 564:	39 c8                	cmp    %ecx,%eax
 566:	73 f0                	jae    558 <free+0x13>
 568:	8b 10                	mov    (%eax),%edx
 56a:	39 d1                	cmp    %edx,%ecx
 56c:	73 3e                	jae    5ac <free+0x67>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 56e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 571:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 574:	8b 10                	mov    (%eax),%edx
 576:	39 d7                	cmp    %edx,%edi
 578:	75 0f                	jne    589 <free+0x44>
    bp->s.size += p->s.ptr->s.size;
 57a:	03 77 04             	add    0x4(%edi),%esi
 57d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 580:	8b 10                	mov    (%eax),%edx
 582:	8b 12                	mov    (%edx),%edx
 584:	89 53 f8             	mov    %edx,-0x8(%ebx)
 587:	eb 03                	jmp    58c <free+0x47>
  } else
    bp->s.ptr = p->s.ptr;
 589:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 58c:	8b 50 04             	mov    0x4(%eax),%edx
 58f:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 592:	39 f1                	cmp    %esi,%ecx
 594:	75 0d                	jne    5a3 <free+0x5e>
    p->s.size += bp->s.size;
 596:	03 53 fc             	add    -0x4(%ebx),%edx
 599:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 59c:	8b 53 f8             	mov    -0x8(%ebx),%edx
 59f:	89 10                	mov    %edx,(%eax)
 5a1:	eb 02                	jmp    5a5 <free+0x60>
  } else
    p->s.ptr = bp;
 5a3:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5a5:	a3 08 09 00 00       	mov    %eax,0x908
}
 5aa:	eb 06                	jmp    5b2 <free+0x6d>
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ac:	39 d0                	cmp    %edx,%eax
 5ae:	72 b2                	jb     562 <free+0x1d>
 5b0:	eb bc                	jmp    56e <free+0x29>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 5b2:	5b                   	pop    %ebx
 5b3:	5e                   	pop    %esi
 5b4:	5f                   	pop    %edi
 5b5:	5d                   	pop    %ebp
 5b6:	c3                   	ret    

000005b7 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5b7:	55                   	push   %ebp
 5b8:	89 e5                	mov    %esp,%ebp
 5ba:	57                   	push   %edi
 5bb:	56                   	push   %esi
 5bc:	53                   	push   %ebx
 5bd:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5c0:	8b 45 08             	mov    0x8(%ebp),%eax
 5c3:	8d 58 07             	lea    0x7(%eax),%ebx
 5c6:	c1 eb 03             	shr    $0x3,%ebx
 5c9:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 5cc:	8b 15 08 09 00 00    	mov    0x908,%edx
 5d2:	85 d2                	test   %edx,%edx
 5d4:	75 23                	jne    5f9 <malloc+0x42>
    base.s.ptr = freep = prevp = &base;
 5d6:	c7 05 08 09 00 00 0c 	movl   $0x90c,0x908
 5dd:	09 00 00 
 5e0:	c7 05 0c 09 00 00 0c 	movl   $0x90c,0x90c
 5e7:	09 00 00 
    base.s.size = 0;
 5ea:	c7 05 10 09 00 00 00 	movl   $0x0,0x910
 5f1:	00 00 00 
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 5f4:	ba 0c 09 00 00       	mov    $0x90c,%edx
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5f9:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5fb:	8b 48 04             	mov    0x4(%eax),%ecx
 5fe:	39 cb                	cmp    %ecx,%ebx
 600:	77 20                	ja     622 <malloc+0x6b>
      if(p->s.size == nunits)
 602:	39 cb                	cmp    %ecx,%ebx
 604:	75 06                	jne    60c <malloc+0x55>
        prevp->s.ptr = p->s.ptr;
 606:	8b 08                	mov    (%eax),%ecx
 608:	89 0a                	mov    %ecx,(%edx)
 60a:	eb 0b                	jmp    617 <malloc+0x60>
      else {
        p->s.size -= nunits;
 60c:	29 d9                	sub    %ebx,%ecx
 60e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 611:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 614:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 617:	89 15 08 09 00 00    	mov    %edx,0x908
      return (void*)(p + 1);
 61d:	83 c0 08             	add    $0x8,%eax
 620:	eb 63                	jmp    685 <malloc+0xce>
 622:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 628:	be 00 10 00 00       	mov    $0x1000,%esi
 62d:	0f 43 f3             	cmovae %ebx,%esi
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 630:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 637:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 639:	39 05 08 09 00 00    	cmp    %eax,0x908
 63f:	75 2d                	jne    66e <malloc+0xb7>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 641:	83 ec 0c             	sub    $0xc,%esp
 644:	57                   	push   %edi
 645:	e8 5b fc ff ff       	call   2a5 <sbrk>
  if(p == (char*)-1)
 64a:	83 c4 10             	add    $0x10,%esp
 64d:	83 f8 ff             	cmp    $0xffffffff,%eax
 650:	74 27                	je     679 <malloc+0xc2>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 652:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 655:	83 ec 0c             	sub    $0xc,%esp
 658:	83 c0 08             	add    $0x8,%eax
 65b:	50                   	push   %eax
 65c:	e8 e4 fe ff ff       	call   545 <free>
  return freep;
 661:	8b 15 08 09 00 00    	mov    0x908,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 667:	83 c4 10             	add    $0x10,%esp
 66a:	85 d2                	test   %edx,%edx
 66c:	74 12                	je     680 <malloc+0xc9>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 66e:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 670:	8b 48 04             	mov    0x4(%eax),%ecx
 673:	39 cb                	cmp    %ecx,%ebx
 675:	77 c0                	ja     637 <malloc+0x80>
 677:	eb 89                	jmp    602 <malloc+0x4b>
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 679:	b8 00 00 00 00       	mov    $0x0,%eax
 67e:	eb 05                	jmp    685 <malloc+0xce>
 680:	b8 00 00 00 00       	mov    $0x0,%eax
  }
}
 685:	8d 65 f4             	lea    -0xc(%ebp),%esp
 688:	5b                   	pop    %ebx
 689:	5e                   	pop    %esi
 68a:	5f                   	pop    %edi
 68b:	5d                   	pop    %ebp
 68c:	c3                   	ret    
