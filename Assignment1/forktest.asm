
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 10             	sub    $0x10,%esp
   7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
   a:	53                   	push   %ebx
   b:	e8 37 01 00 00       	call   147 <strlen>
  10:	83 c4 0c             	add    $0xc,%esp
  13:	50                   	push   %eax
  14:	53                   	push   %ebx
  15:	ff 75 08             	pushl  0x8(%ebp)
  18:	e8 bf 02 00 00       	call   2dc <write>
}
  1d:	83 c4 10             	add    $0x10,%esp
  20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  23:	c9                   	leave  
  24:	c3                   	ret    

00000025 <forktest>:

void
forktest(void)
{
  25:	55                   	push   %ebp
  26:	89 e5                	mov    %esp,%ebp
  28:	53                   	push   %ebx
  29:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
  2c:	68 8c 03 00 00       	push   $0x38c
  31:	6a 01                	push   $0x1
  33:	e8 c8 ff ff ff       	call   0 <printf>
  38:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  3b:	bb 00 00 00 00       	mov    $0x0,%ebx
    pid = fork();
  40:	e8 6f 02 00 00       	call   2b4 <fork>
    if(pid < 0)
  45:	85 c0                	test   %eax,%eax
  47:	78 16                	js     5f <forktest+0x3a>
      break;
    if(pid == 0)
  49:	85 c0                	test   %eax,%eax
  4b:	75 05                	jne    52 <forktest+0x2d>
      exit();
  4d:	e8 6a 02 00 00       	call   2bc <exit>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  52:	83 c3 01             	add    $0x1,%ebx
  55:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  5b:	75 e3                	jne    40 <forktest+0x1b>
  5d:	eb 0e                	jmp    6d <forktest+0x48>
      break;
    if(pid == 0)
      exit();
  }

  if(n == N){
  5f:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  65:	74 06                	je     6d <forktest+0x48>
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }

  for(; n > 0; n--){
  67:	85 db                	test   %ebx,%ebx
  69:	7f 1b                	jg     86 <forktest+0x61>
  6b:	eb 3b                	jmp    a8 <forktest+0x83>
    if(pid == 0)
      exit();
  }

  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
  6d:	83 ec 04             	sub    $0x4,%esp
  70:	68 e8 03 00 00       	push   $0x3e8
  75:	68 cc 03 00 00       	push   $0x3cc
  7a:	6a 01                	push   $0x1
  7c:	e8 7f ff ff ff       	call   0 <printf>
    exit();
  81:	e8 36 02 00 00       	call   2bc <exit>
  }

  for(; n > 0; n--){
    if(wait() < 0){
  86:	e8 39 02 00 00       	call   2c4 <wait>
  8b:	85 c0                	test   %eax,%eax
  8d:	79 14                	jns    a3 <forktest+0x7e>
      printf(1, "wait stopped early\n");
  8f:	83 ec 08             	sub    $0x8,%esp
  92:	68 97 03 00 00       	push   $0x397
  97:	6a 01                	push   $0x1
  99:	e8 62 ff ff ff       	call   0 <printf>
      exit();
  9e:	e8 19 02 00 00       	call   2bc <exit>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }

  for(; n > 0; n--){
  a3:	83 eb 01             	sub    $0x1,%ebx
  a6:	75 de                	jne    86 <forktest+0x61>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
  a8:	e8 17 02 00 00       	call   2c4 <wait>
  ad:	83 f8 ff             	cmp    $0xffffffff,%eax
  b0:	74 14                	je     c6 <forktest+0xa1>
    printf(1, "wait got too many\n");
  b2:	83 ec 08             	sub    $0x8,%esp
  b5:	68 ab 03 00 00       	push   $0x3ab
  ba:	6a 01                	push   $0x1
  bc:	e8 3f ff ff ff       	call   0 <printf>
    exit();
  c1:	e8 f6 01 00 00       	call   2bc <exit>
  }

  printf(1, "fork test OK\n");
  c6:	83 ec 08             	sub    $0x8,%esp
  c9:	68 be 03 00 00       	push   $0x3be
  ce:	6a 01                	push   $0x1
  d0:	e8 2b ff ff ff       	call   0 <printf>
}
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  db:	c9                   	leave  
  dc:	c3                   	ret    

000000dd <main>:

int
main(void)
{
  dd:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  e1:	83 e4 f0             	and    $0xfffffff0,%esp
  e4:	ff 71 fc             	pushl  -0x4(%ecx)
  e7:	55                   	push   %ebp
  e8:	89 e5                	mov    %esp,%ebp
  ea:	51                   	push   %ecx
  eb:	83 ec 04             	sub    $0x4,%esp
  forktest();
  ee:	e8 32 ff ff ff       	call   25 <forktest>
  exit();
  f3:	e8 c4 01 00 00       	call   2bc <exit>

000000f8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	53                   	push   %ebx
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
  ff:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 102:	89 c2                	mov    %eax,%edx
 104:	83 c2 01             	add    $0x1,%edx
 107:	83 c1 01             	add    $0x1,%ecx
 10a:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 10e:	88 5a ff             	mov    %bl,-0x1(%edx)
 111:	84 db                	test   %bl,%bl
 113:	75 ef                	jne    104 <strcpy+0xc>
    ;
  return os;
}
 115:	5b                   	pop    %ebx
 116:	5d                   	pop    %ebp
 117:	c3                   	ret    

00000118 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 118:	55                   	push   %ebp
 119:	89 e5                	mov    %esp,%ebp
 11b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11e:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 121:	0f b6 01             	movzbl (%ecx),%eax
 124:	84 c0                	test   %al,%al
 126:	74 15                	je     13d <strcmp+0x25>
 128:	3a 02                	cmp    (%edx),%al
 12a:	75 11                	jne    13d <strcmp+0x25>
    p++, q++;
 12c:	83 c1 01             	add    $0x1,%ecx
 12f:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 132:	0f b6 01             	movzbl (%ecx),%eax
 135:	84 c0                	test   %al,%al
 137:	74 04                	je     13d <strcmp+0x25>
 139:	3a 02                	cmp    (%edx),%al
 13b:	74 ef                	je     12c <strcmp+0x14>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 13d:	0f b6 c0             	movzbl %al,%eax
 140:	0f b6 12             	movzbl (%edx),%edx
 143:	29 d0                	sub    %edx,%eax
}
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    

00000147 <strlen>:

uint
strlen(char *s)
{
 147:	55                   	push   %ebp
 148:	89 e5                	mov    %esp,%ebp
 14a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 14d:	80 39 00             	cmpb   $0x0,(%ecx)
 150:	74 12                	je     164 <strlen+0x1d>
 152:	ba 00 00 00 00       	mov    $0x0,%edx
 157:	83 c2 01             	add    $0x1,%edx
 15a:	89 d0                	mov    %edx,%eax
 15c:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 160:	75 f5                	jne    157 <strlen+0x10>
 162:	eb 05                	jmp    169 <strlen+0x22>
 164:	b8 00 00 00 00       	mov    $0x0,%eax
    ;
  return n;
}
 169:	5d                   	pop    %ebp
 16a:	c3                   	ret    

0000016b <memset>:

void*
memset(void *dst, int c, uint n)
{
 16b:	55                   	push   %ebp
 16c:	89 e5                	mov    %esp,%ebp
 16e:	57                   	push   %edi
 16f:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 172:	89 d7                	mov    %edx,%edi
 174:	8b 4d 10             	mov    0x10(%ebp),%ecx
 177:	8b 45 0c             	mov    0xc(%ebp),%eax
 17a:	fc                   	cld    
 17b:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 17d:	89 d0                	mov    %edx,%eax
 17f:	5f                   	pop    %edi
 180:	5d                   	pop    %ebp
 181:	c3                   	ret    

00000182 <strchr>:

char*
strchr(const char *s, char c)
{
 182:	55                   	push   %ebp
 183:	89 e5                	mov    %esp,%ebp
 185:	53                   	push   %ebx
 186:	8b 45 08             	mov    0x8(%ebp),%eax
 189:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 18c:	0f b6 10             	movzbl (%eax),%edx
 18f:	84 d2                	test   %dl,%dl
 191:	74 1d                	je     1b0 <strchr+0x2e>
 193:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
 195:	38 d3                	cmp    %dl,%bl
 197:	75 06                	jne    19f <strchr+0x1d>
 199:	eb 1a                	jmp    1b5 <strchr+0x33>
 19b:	38 ca                	cmp    %cl,%dl
 19d:	74 16                	je     1b5 <strchr+0x33>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 19f:	83 c0 01             	add    $0x1,%eax
 1a2:	0f b6 10             	movzbl (%eax),%edx
 1a5:	84 d2                	test   %dl,%dl
 1a7:	75 f2                	jne    19b <strchr+0x19>
    if(*s == c)
      return (char*)s;
  return 0;
 1a9:	b8 00 00 00 00       	mov    $0x0,%eax
 1ae:	eb 05                	jmp    1b5 <strchr+0x33>
 1b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1b5:	5b                   	pop    %ebx
 1b6:	5d                   	pop    %ebp
 1b7:	c3                   	ret    

000001b8 <gets>:

char*
gets(char *buf, int max)
{
 1b8:	55                   	push   %ebp
 1b9:	89 e5                	mov    %esp,%ebp
 1bb:	57                   	push   %edi
 1bc:	56                   	push   %esi
 1bd:	53                   	push   %ebx
 1be:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c1:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 1c6:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c9:	eb 29                	jmp    1f4 <gets+0x3c>
    cc = read(0, &c, 1);
 1cb:	83 ec 04             	sub    $0x4,%esp
 1ce:	6a 01                	push   $0x1
 1d0:	57                   	push   %edi
 1d1:	6a 00                	push   $0x0
 1d3:	e8 fc 00 00 00       	call   2d4 <read>
    if(cc < 1)
 1d8:	83 c4 10             	add    $0x10,%esp
 1db:	85 c0                	test   %eax,%eax
 1dd:	7e 21                	jle    200 <gets+0x48>
      break;
    buf[i++] = c;
 1df:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1e3:	8b 55 08             	mov    0x8(%ebp),%edx
 1e6:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ea:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1ec:	3c 0a                	cmp    $0xa,%al
 1ee:	74 0e                	je     1fe <gets+0x46>
 1f0:	3c 0d                	cmp    $0xd,%al
 1f2:	74 0a                	je     1fe <gets+0x46>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f4:	8d 5e 01             	lea    0x1(%esi),%ebx
 1f7:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1fa:	7c cf                	jl     1cb <gets+0x13>
 1fc:	eb 02                	jmp    200 <gets+0x48>
 1fe:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 200:	8b 45 08             	mov    0x8(%ebp),%eax
 203:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 207:	8d 65 f4             	lea    -0xc(%ebp),%esp
 20a:	5b                   	pop    %ebx
 20b:	5e                   	pop    %esi
 20c:	5f                   	pop    %edi
 20d:	5d                   	pop    %ebp
 20e:	c3                   	ret    

0000020f <stat>:

int
stat(char *n, struct stat *st)
{
 20f:	55                   	push   %ebp
 210:	89 e5                	mov    %esp,%ebp
 212:	56                   	push   %esi
 213:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 214:	83 ec 08             	sub    $0x8,%esp
 217:	6a 00                	push   $0x0
 219:	ff 75 08             	pushl  0x8(%ebp)
 21c:	e8 db 00 00 00       	call   2fc <open>
  if(fd < 0)
 221:	83 c4 10             	add    $0x10,%esp
 224:	85 c0                	test   %eax,%eax
 226:	78 1f                	js     247 <stat+0x38>
 228:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 22a:	83 ec 08             	sub    $0x8,%esp
 22d:	ff 75 0c             	pushl  0xc(%ebp)
 230:	50                   	push   %eax
 231:	e8 de 00 00 00       	call   314 <fstat>
 236:	89 c6                	mov    %eax,%esi
  close(fd);
 238:	89 1c 24             	mov    %ebx,(%esp)
 23b:	e8 a4 00 00 00       	call   2e4 <close>
  return r;
 240:	83 c4 10             	add    $0x10,%esp
 243:	89 f0                	mov    %esi,%eax
 245:	eb 05                	jmp    24c <stat+0x3d>
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 247:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  r = fstat(fd, st);
  close(fd);
  return r;
}
 24c:	8d 65 f8             	lea    -0x8(%ebp),%esp
 24f:	5b                   	pop    %ebx
 250:	5e                   	pop    %esi
 251:	5d                   	pop    %ebp
 252:	c3                   	ret    

00000253 <atoi>:

int
atoi(const char *s)
{
 253:	55                   	push   %ebp
 254:	89 e5                	mov    %esp,%ebp
 256:	53                   	push   %ebx
 257:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 25a:	0f b6 11             	movzbl (%ecx),%edx
 25d:	8d 42 d0             	lea    -0x30(%edx),%eax
 260:	3c 09                	cmp    $0x9,%al
 262:	77 1f                	ja     283 <atoi+0x30>
 264:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 269:	83 c1 01             	add    $0x1,%ecx
 26c:	8d 04 80             	lea    (%eax,%eax,4),%eax
 26f:	0f be d2             	movsbl %dl,%edx
 272:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 276:	0f b6 11             	movzbl (%ecx),%edx
 279:	8d 5a d0             	lea    -0x30(%edx),%ebx
 27c:	80 fb 09             	cmp    $0x9,%bl
 27f:	76 e8                	jbe    269 <atoi+0x16>
 281:	eb 05                	jmp    288 <atoi+0x35>
int
atoi(const char *s)
{
  int n;

  n = 0;
 283:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
  return n;
}
 288:	5b                   	pop    %ebx
 289:	5d                   	pop    %ebp
 28a:	c3                   	ret    

0000028b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 28b:	55                   	push   %ebp
 28c:	89 e5                	mov    %esp,%ebp
 28e:	56                   	push   %esi
 28f:	53                   	push   %ebx
 290:	8b 45 08             	mov    0x8(%ebp),%eax
 293:	8b 75 0c             	mov    0xc(%ebp),%esi
 296:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 299:	85 db                	test   %ebx,%ebx
 29b:	7e 13                	jle    2b0 <memmove+0x25>
 29d:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 2a2:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2a6:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2a9:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ac:	39 da                	cmp    %ebx,%edx
 2ae:	75 f2                	jne    2a2 <memmove+0x17>
    *dst++ = *src++;
  return vdst;
}
 2b0:	5b                   	pop    %ebx
 2b1:	5e                   	pop    %esi
 2b2:	5d                   	pop    %ebp
 2b3:	c3                   	ret    

000002b4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2b4:	b8 01 00 00 00       	mov    $0x1,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <exit>:
SYSCALL(exit)
 2bc:	b8 02 00 00 00       	mov    $0x2,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <wait>:
SYSCALL(wait)
 2c4:	b8 03 00 00 00       	mov    $0x3,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <pipe>:
SYSCALL(pipe)
 2cc:	b8 04 00 00 00       	mov    $0x4,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <read>:
SYSCALL(read)
 2d4:	b8 05 00 00 00       	mov    $0x5,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <write>:
SYSCALL(write)
 2dc:	b8 10 00 00 00       	mov    $0x10,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <close>:
SYSCALL(close)
 2e4:	b8 15 00 00 00       	mov    $0x15,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <kill>:
SYSCALL(kill)
 2ec:	b8 06 00 00 00       	mov    $0x6,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <exec>:
SYSCALL(exec)
 2f4:	b8 07 00 00 00       	mov    $0x7,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <open>:
SYSCALL(open)
 2fc:	b8 0f 00 00 00       	mov    $0xf,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <mknod>:
SYSCALL(mknod)
 304:	b8 11 00 00 00       	mov    $0x11,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <unlink>:
SYSCALL(unlink)
 30c:	b8 12 00 00 00       	mov    $0x12,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <fstat>:
SYSCALL(fstat)
 314:	b8 08 00 00 00       	mov    $0x8,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <link>:
SYSCALL(link)
 31c:	b8 13 00 00 00       	mov    $0x13,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <mkdir>:
SYSCALL(mkdir)
 324:	b8 14 00 00 00       	mov    $0x14,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <chdir>:
SYSCALL(chdir)
 32c:	b8 09 00 00 00       	mov    $0x9,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <dup>:
SYSCALL(dup)
 334:	b8 0a 00 00 00       	mov    $0xa,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <getpid>:
SYSCALL(getpid)
 33c:	b8 0b 00 00 00       	mov    $0xb,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <sbrk>:
SYSCALL(sbrk)
 344:	b8 0c 00 00 00       	mov    $0xc,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <sleep>:
SYSCALL(sleep)
 34c:	b8 0d 00 00 00       	mov    $0xd,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <uptime>:
SYSCALL(uptime)
 354:	b8 0e 00 00 00       	mov    $0xe,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <wait2>:
SYSCALL(wait2)
 35c:	b8 17 00 00 00       	mov    $0x17,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <setVariable>:
SYSCALL(setVariable)
 364:	b8 18 00 00 00       	mov    $0x18,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <getVariable>:
SYSCALL(getVariable)
 36c:	b8 19 00 00 00       	mov    $0x19,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <remVariable>:
SYSCALL(remVariable)
 374:	b8 1a 00 00 00       	mov    $0x1a,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <changeProcTime>:
SYSCALL(changeProcTime)
 37c:	b8 1b 00 00 00       	mov    $0x1b,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <set_priority>:
 384:	b8 1c 00 00 00       	mov    $0x1c,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    
