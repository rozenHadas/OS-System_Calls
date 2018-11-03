
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 ec 0c             	sub    $0xc,%esp
   9:	8b 75 08             	mov    0x8(%ebp),%esi
   c:	8b 7d 0c             	mov    0xc(%ebp),%edi
   f:	8b 5d 10             	mov    0x10(%ebp),%ebx
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  12:	83 ec 08             	sub    $0x8,%esp
  15:	53                   	push   %ebx
  16:	57                   	push   %edi
  17:	e8 2c 00 00 00       	call   48 <matchhere>
  1c:	83 c4 10             	add    $0x10,%esp
  1f:	85 c0                	test   %eax,%eax
  21:	75 18                	jne    3b <matchstar+0x3b>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  23:	0f b6 13             	movzbl (%ebx),%edx
  26:	84 d2                	test   %dl,%dl
  28:	74 16                	je     40 <matchstar+0x40>
  2a:	83 c3 01             	add    $0x1,%ebx
  2d:	0f be d2             	movsbl %dl,%edx
  30:	39 f2                	cmp    %esi,%edx
  32:	74 de                	je     12 <matchstar+0x12>
  34:	83 fe 2e             	cmp    $0x2e,%esi
  37:	74 d9                	je     12 <matchstar+0x12>
  39:	eb 05                	jmp    40 <matchstar+0x40>
// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  3b:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
  40:	8d 65 f4             	lea    -0xc(%ebp),%esp
  43:	5b                   	pop    %ebx
  44:	5e                   	pop    %esi
  45:	5f                   	pop    %edi
  46:	5d                   	pop    %ebp
  47:	c3                   	ret    

00000048 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  48:	55                   	push   %ebp
  49:	89 e5                	mov    %esp,%ebp
  4b:	53                   	push   %ebx
  4c:	83 ec 04             	sub    $0x4,%esp
  4f:	8b 55 08             	mov    0x8(%ebp),%edx
  if(re[0] == '\0')
  52:	0f b6 0a             	movzbl (%edx),%ecx
    return 1;
  55:	b8 01 00 00 00       	mov    $0x1,%eax
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
  5a:	84 c9                	test   %cl,%cl
  5c:	74 65                	je     c3 <matchhere+0x7b>
    return 1;
  if(re[1] == '*')
  5e:	0f b6 42 01          	movzbl 0x1(%edx),%eax
  62:	3c 2a                	cmp    $0x2a,%al
  64:	75 18                	jne    7e <matchhere+0x36>
    return matchstar(re[0], re+2, text);
  66:	83 ec 04             	sub    $0x4,%esp
  69:	ff 75 0c             	pushl  0xc(%ebp)
  6c:	83 c2 02             	add    $0x2,%edx
  6f:	52                   	push   %edx
  70:	0f be c9             	movsbl %cl,%ecx
  73:	51                   	push   %ecx
  74:	e8 87 ff ff ff       	call   0 <matchstar>
  79:	83 c4 10             	add    $0x10,%esp
  7c:	eb 45                	jmp    c3 <matchhere+0x7b>
  if(re[0] == '$' && re[1] == '\0')
  7e:	84 c0                	test   %al,%al
  80:	75 13                	jne    95 <matchhere+0x4d>
  82:	80 f9 24             	cmp    $0x24,%cl
  85:	75 0e                	jne    95 <matchhere+0x4d>
    return *text == '\0';
  87:	8b 45 0c             	mov    0xc(%ebp),%eax
  8a:	80 38 00             	cmpb   $0x0,(%eax)
  8d:	0f 94 c0             	sete   %al
  90:	0f b6 c0             	movzbl %al,%eax
  93:	eb 2e                	jmp    c3 <matchhere+0x7b>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  95:	8b 45 0c             	mov    0xc(%ebp),%eax
  98:	0f b6 18             	movzbl (%eax),%ebx
    return matchhere(re+1, text+1);
  return 0;
  9b:	b8 00 00 00 00       	mov    $0x0,%eax
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a0:	84 db                	test   %bl,%bl
  a2:	74 1f                	je     c3 <matchhere+0x7b>
  a4:	38 d9                	cmp    %bl,%cl
  a6:	74 05                	je     ad <matchhere+0x65>
  a8:	80 f9 2e             	cmp    $0x2e,%cl
  ab:	75 16                	jne    c3 <matchhere+0x7b>
    return matchhere(re+1, text+1);
  ad:	83 ec 08             	sub    $0x8,%esp
  b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  b3:	83 c0 01             	add    $0x1,%eax
  b6:	50                   	push   %eax
  b7:	83 c2 01             	add    $0x1,%edx
  ba:	52                   	push   %edx
  bb:	e8 88 ff ff ff       	call   48 <matchhere>
  c0:	83 c4 10             	add    $0x10,%esp
  return 0;
}
  c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  c6:	c9                   	leave  
  c7:	c3                   	ret    

000000c8 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
  c8:	55                   	push   %ebp
  c9:	89 e5                	mov    %esp,%ebp
  cb:	56                   	push   %esi
  cc:	53                   	push   %ebx
  cd:	8b 75 08             	mov    0x8(%ebp),%esi
  d0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
  d3:	80 3e 5e             	cmpb   $0x5e,(%esi)
  d6:	75 12                	jne    ea <match+0x22>
    return matchhere(re+1, text);
  d8:	83 ec 08             	sub    $0x8,%esp
  db:	53                   	push   %ebx
  dc:	83 c6 01             	add    $0x1,%esi
  df:	56                   	push   %esi
  e0:	e8 63 ff ff ff       	call   48 <matchhere>
  e5:	83 c4 10             	add    $0x10,%esp
  e8:	eb 21                	jmp    10b <match+0x43>
  do{  // must look at empty string
    if(matchhere(re, text))
  ea:	83 ec 08             	sub    $0x8,%esp
  ed:	53                   	push   %ebx
  ee:	56                   	push   %esi
  ef:	e8 54 ff ff ff       	call   48 <matchhere>
  f4:	83 c4 10             	add    $0x10,%esp
  f7:	85 c0                	test   %eax,%eax
  f9:	75 0b                	jne    106 <match+0x3e>
      return 1;
  }while(*text++ != '\0');
  fb:	83 c3 01             	add    $0x1,%ebx
  fe:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 102:	75 e6                	jne    ea <match+0x22>
 104:	eb 05                	jmp    10b <match+0x43>
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
 106:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text++ != '\0');
  return 0;
}
 10b:	8d 65 f8             	lea    -0x8(%ebp),%esp
 10e:	5b                   	pop    %ebx
 10f:	5e                   	pop    %esi
 110:	5d                   	pop    %ebp
 111:	c3                   	ret    

00000112 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
 112:	55                   	push   %ebp
 113:	89 e5                	mov    %esp,%ebp
 115:	57                   	push   %edi
 116:	56                   	push   %esi
 117:	53                   	push   %ebx
 118:	83 ec 1c             	sub    $0x1c,%esp
 11b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int n, m;
  char *p, *q;

  m = 0;
 11e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 125:	e9 8c 00 00 00       	jmp    1b6 <grep+0xa4>
    m += n;
 12a:	01 45 e4             	add    %eax,-0x1c(%ebp)
 12d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    buf[m] = '\0';
 130:	c6 82 40 0c 00 00 00 	movb   $0x0,0xc40(%edx)
    p = buf;
 137:	be 40 0c 00 00       	mov    $0xc40,%esi
    while((q = strchr(p, '\n')) != 0){
 13c:	eb 2e                	jmp    16c <grep+0x5a>
      *q = 0;
 13e:	c6 03 00             	movb   $0x0,(%ebx)
      if(match(pattern, p)){
 141:	83 ec 08             	sub    $0x8,%esp
 144:	56                   	push   %esi
 145:	57                   	push   %edi
 146:	e8 7d ff ff ff       	call   c8 <match>
 14b:	83 c4 10             	add    $0x10,%esp
 14e:	85 c0                	test   %eax,%eax
 150:	74 17                	je     169 <grep+0x57>
        *q = '\n';
 152:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
 155:	83 ec 04             	sub    $0x4,%esp
 158:	8d 43 01             	lea    0x1(%ebx),%eax
 15b:	29 f0                	sub    %esi,%eax
 15d:	50                   	push   %eax
 15e:	56                   	push   %esi
 15f:	6a 01                	push   $0x1
 161:	e8 15 03 00 00       	call   47b <write>
 166:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
 169:	8d 73 01             	lea    0x1(%ebx),%esi
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
    buf[m] = '\0';
    p = buf;
    while((q = strchr(p, '\n')) != 0){
 16c:	83 ec 08             	sub    $0x8,%esp
 16f:	6a 0a                	push   $0xa
 171:	56                   	push   %esi
 172:	e8 aa 01 00 00       	call   321 <strchr>
 177:	89 c3                	mov    %eax,%ebx
 179:	83 c4 10             	add    $0x10,%esp
 17c:	85 c0                	test   %eax,%eax
 17e:	75 be                	jne    13e <grep+0x2c>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
 180:	81 fe 40 0c 00 00    	cmp    $0xc40,%esi
 186:	74 27                	je     1af <grep+0x9d>
      m = 0;
    if(m > 0){
 188:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
 18c:	7e 28                	jle    1b6 <grep+0xa4>
      m -= p - buf;
 18e:	89 f0                	mov    %esi,%eax
 190:	2d 40 0c 00 00       	sub    $0xc40,%eax
 195:	29 45 e4             	sub    %eax,-0x1c(%ebp)
 198:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      memmove(buf, p, m);
 19b:	83 ec 04             	sub    $0x4,%esp
 19e:	51                   	push   %ecx
 19f:	56                   	push   %esi
 1a0:	68 40 0c 00 00       	push   $0xc40
 1a5:	e8 80 02 00 00       	call   42a <memmove>
 1aa:	83 c4 10             	add    $0x10,%esp
 1ad:	eb 07                	jmp    1b6 <grep+0xa4>
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      m = 0;
 1af:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
{
  int n, m;
  char *p, *q;

  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 1b6:	83 ec 04             	sub    $0x4,%esp
 1b9:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 1be:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 1c1:	29 c8                	sub    %ecx,%eax
 1c3:	50                   	push   %eax
 1c4:	8d 81 40 0c 00 00    	lea    0xc40(%ecx),%eax
 1ca:	50                   	push   %eax
 1cb:	ff 75 0c             	pushl  0xc(%ebp)
 1ce:	e8 a0 02 00 00       	call   473 <read>
 1d3:	83 c4 10             	add    $0x10,%esp
 1d6:	85 c0                	test   %eax,%eax
 1d8:	0f 8f 4c ff ff ff    	jg     12a <grep+0x18>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 1de:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e1:	5b                   	pop    %ebx
 1e2:	5e                   	pop    %esi
 1e3:	5f                   	pop    %edi
 1e4:	5d                   	pop    %ebp
 1e5:	c3                   	ret    

000001e6 <main>:

int
main(int argc, char *argv[])
{
 1e6:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 1ea:	83 e4 f0             	and    $0xfffffff0,%esp
 1ed:	ff 71 fc             	pushl  -0x4(%ecx)
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	56                   	push   %esi
 1f5:	53                   	push   %ebx
 1f6:	51                   	push   %ecx
 1f7:	83 ec 18             	sub    $0x18,%esp
 1fa:	8b 01                	mov    (%ecx),%eax
 1fc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 1ff:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
 202:	83 f8 01             	cmp    $0x1,%eax
 205:	7f 14                	jg     21b <main+0x35>
    printf(2, "usage: grep pattern [file ...]\n");
 207:	83 ec 08             	sub    $0x8,%esp
 20a:	68 cc 08 00 00       	push   $0x8cc
 20f:	6a 02                	push   $0x2
 211:	e8 a8 03 00 00       	call   5be <printf>
    exit();
 216:	e8 40 02 00 00       	call   45b <exit>
  }
  pattern = argv[1];
 21b:	8b 43 04             	mov    0x4(%ebx),%eax
 21e:	89 45 e0             	mov    %eax,-0x20(%ebp)
 221:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
 224:	bf 02 00 00 00       	mov    $0x2,%edi
 229:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
 22d:	7f 10                	jg     23f <main+0x59>
    grep(pattern, 0);
 22f:	83 ec 08             	sub    $0x8,%esp
 232:	6a 00                	push   $0x0
 234:	50                   	push   %eax
 235:	e8 d8 fe ff ff       	call   112 <grep>
    exit();
 23a:	e8 1c 02 00 00       	call   45b <exit>
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 23f:	89 5d dc             	mov    %ebx,-0x24(%ebp)
 242:	83 ec 08             	sub    $0x8,%esp
 245:	6a 00                	push   $0x0
 247:	ff 33                	pushl  (%ebx)
 249:	e8 4d 02 00 00       	call   49b <open>
 24e:	89 c6                	mov    %eax,%esi
 250:	83 c4 10             	add    $0x10,%esp
 253:	85 c0                	test   %eax,%eax
 255:	79 19                	jns    270 <main+0x8a>
      printf(1, "grep: cannot open %s\n", argv[i]);
 257:	83 ec 04             	sub    $0x4,%esp
 25a:	8b 45 dc             	mov    -0x24(%ebp),%eax
 25d:	ff 30                	pushl  (%eax)
 25f:	68 ec 08 00 00       	push   $0x8ec
 264:	6a 01                	push   $0x1
 266:	e8 53 03 00 00       	call   5be <printf>
      exit();
 26b:	e8 eb 01 00 00       	call   45b <exit>
    }
    grep(pattern, fd);
 270:	83 ec 08             	sub    $0x8,%esp
 273:	50                   	push   %eax
 274:	ff 75 e0             	pushl  -0x20(%ebp)
 277:	e8 96 fe ff ff       	call   112 <grep>
    close(fd);
 27c:	89 34 24             	mov    %esi,(%esp)
 27f:	e8 ff 01 00 00       	call   483 <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
 284:	83 c7 01             	add    $0x1,%edi
 287:	83 c3 04             	add    $0x4,%ebx
 28a:	83 c4 10             	add    $0x10,%esp
 28d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
 290:	75 ad                	jne    23f <main+0x59>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
 292:	e8 c4 01 00 00       	call   45b <exit>

00000297 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 297:	55                   	push   %ebp
 298:	89 e5                	mov    %esp,%ebp
 29a:	53                   	push   %ebx
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2a1:	89 c2                	mov    %eax,%edx
 2a3:	83 c2 01             	add    $0x1,%edx
 2a6:	83 c1 01             	add    $0x1,%ecx
 2a9:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 2ad:	88 5a ff             	mov    %bl,-0x1(%edx)
 2b0:	84 db                	test   %bl,%bl
 2b2:	75 ef                	jne    2a3 <strcpy+0xc>
    ;
  return os;
}
 2b4:	5b                   	pop    %ebx
 2b5:	5d                   	pop    %ebp
 2b6:	c3                   	ret    

000002b7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2b7:	55                   	push   %ebp
 2b8:	89 e5                	mov    %esp,%ebp
 2ba:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 2c0:	0f b6 01             	movzbl (%ecx),%eax
 2c3:	84 c0                	test   %al,%al
 2c5:	74 15                	je     2dc <strcmp+0x25>
 2c7:	3a 02                	cmp    (%edx),%al
 2c9:	75 11                	jne    2dc <strcmp+0x25>
    p++, q++;
 2cb:	83 c1 01             	add    $0x1,%ecx
 2ce:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2d1:	0f b6 01             	movzbl (%ecx),%eax
 2d4:	84 c0                	test   %al,%al
 2d6:	74 04                	je     2dc <strcmp+0x25>
 2d8:	3a 02                	cmp    (%edx),%al
 2da:	74 ef                	je     2cb <strcmp+0x14>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2dc:	0f b6 c0             	movzbl %al,%eax
 2df:	0f b6 12             	movzbl (%edx),%edx
 2e2:	29 d0                	sub    %edx,%eax
}
 2e4:	5d                   	pop    %ebp
 2e5:	c3                   	ret    

000002e6 <strlen>:

uint
strlen(char *s)
{
 2e6:	55                   	push   %ebp
 2e7:	89 e5                	mov    %esp,%ebp
 2e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2ec:	80 39 00             	cmpb   $0x0,(%ecx)
 2ef:	74 12                	je     303 <strlen+0x1d>
 2f1:	ba 00 00 00 00       	mov    $0x0,%edx
 2f6:	83 c2 01             	add    $0x1,%edx
 2f9:	89 d0                	mov    %edx,%eax
 2fb:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 2ff:	75 f5                	jne    2f6 <strlen+0x10>
 301:	eb 05                	jmp    308 <strlen+0x22>
 303:	b8 00 00 00 00       	mov    $0x0,%eax
    ;
  return n;
}
 308:	5d                   	pop    %ebp
 309:	c3                   	ret    

0000030a <memset>:

void*
memset(void *dst, int c, uint n)
{
 30a:	55                   	push   %ebp
 30b:	89 e5                	mov    %esp,%ebp
 30d:	57                   	push   %edi
 30e:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 311:	89 d7                	mov    %edx,%edi
 313:	8b 4d 10             	mov    0x10(%ebp),%ecx
 316:	8b 45 0c             	mov    0xc(%ebp),%eax
 319:	fc                   	cld    
 31a:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 31c:	89 d0                	mov    %edx,%eax
 31e:	5f                   	pop    %edi
 31f:	5d                   	pop    %ebp
 320:	c3                   	ret    

00000321 <strchr>:

char*
strchr(const char *s, char c)
{
 321:	55                   	push   %ebp
 322:	89 e5                	mov    %esp,%ebp
 324:	53                   	push   %ebx
 325:	8b 45 08             	mov    0x8(%ebp),%eax
 328:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 32b:	0f b6 10             	movzbl (%eax),%edx
 32e:	84 d2                	test   %dl,%dl
 330:	74 1d                	je     34f <strchr+0x2e>
 332:	89 d9                	mov    %ebx,%ecx
    if(*s == c)
 334:	38 d3                	cmp    %dl,%bl
 336:	75 06                	jne    33e <strchr+0x1d>
 338:	eb 1a                	jmp    354 <strchr+0x33>
 33a:	38 ca                	cmp    %cl,%dl
 33c:	74 16                	je     354 <strchr+0x33>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 33e:	83 c0 01             	add    $0x1,%eax
 341:	0f b6 10             	movzbl (%eax),%edx
 344:	84 d2                	test   %dl,%dl
 346:	75 f2                	jne    33a <strchr+0x19>
    if(*s == c)
      return (char*)s;
  return 0;
 348:	b8 00 00 00 00       	mov    $0x0,%eax
 34d:	eb 05                	jmp    354 <strchr+0x33>
 34f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 354:	5b                   	pop    %ebx
 355:	5d                   	pop    %ebp
 356:	c3                   	ret    

00000357 <gets>:

char*
gets(char *buf, int max)
{
 357:	55                   	push   %ebp
 358:	89 e5                	mov    %esp,%ebp
 35a:	57                   	push   %edi
 35b:	56                   	push   %esi
 35c:	53                   	push   %ebx
 35d:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 360:	be 00 00 00 00       	mov    $0x0,%esi
    cc = read(0, &c, 1);
 365:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 368:	eb 29                	jmp    393 <gets+0x3c>
    cc = read(0, &c, 1);
 36a:	83 ec 04             	sub    $0x4,%esp
 36d:	6a 01                	push   $0x1
 36f:	57                   	push   %edi
 370:	6a 00                	push   $0x0
 372:	e8 fc 00 00 00       	call   473 <read>
    if(cc < 1)
 377:	83 c4 10             	add    $0x10,%esp
 37a:	85 c0                	test   %eax,%eax
 37c:	7e 21                	jle    39f <gets+0x48>
      break;
    buf[i++] = c;
 37e:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 382:	8b 55 08             	mov    0x8(%ebp),%edx
 385:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 389:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 38b:	3c 0a                	cmp    $0xa,%al
 38d:	74 0e                	je     39d <gets+0x46>
 38f:	3c 0d                	cmp    $0xd,%al
 391:	74 0a                	je     39d <gets+0x46>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 393:	8d 5e 01             	lea    0x1(%esi),%ebx
 396:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 399:	7c cf                	jl     36a <gets+0x13>
 39b:	eb 02                	jmp    39f <gets+0x48>
 39d:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 39f:	8b 45 08             	mov    0x8(%ebp),%eax
 3a2:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3a9:	5b                   	pop    %ebx
 3aa:	5e                   	pop    %esi
 3ab:	5f                   	pop    %edi
 3ac:	5d                   	pop    %ebp
 3ad:	c3                   	ret    

000003ae <stat>:

int
stat(char *n, struct stat *st)
{
 3ae:	55                   	push   %ebp
 3af:	89 e5                	mov    %esp,%ebp
 3b1:	56                   	push   %esi
 3b2:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3b3:	83 ec 08             	sub    $0x8,%esp
 3b6:	6a 00                	push   $0x0
 3b8:	ff 75 08             	pushl  0x8(%ebp)
 3bb:	e8 db 00 00 00       	call   49b <open>
  if(fd < 0)
 3c0:	83 c4 10             	add    $0x10,%esp
 3c3:	85 c0                	test   %eax,%eax
 3c5:	78 1f                	js     3e6 <stat+0x38>
 3c7:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 3c9:	83 ec 08             	sub    $0x8,%esp
 3cc:	ff 75 0c             	pushl  0xc(%ebp)
 3cf:	50                   	push   %eax
 3d0:	e8 de 00 00 00       	call   4b3 <fstat>
 3d5:	89 c6                	mov    %eax,%esi
  close(fd);
 3d7:	89 1c 24             	mov    %ebx,(%esp)
 3da:	e8 a4 00 00 00       	call   483 <close>
  return r;
 3df:	83 c4 10             	add    $0x10,%esp
 3e2:	89 f0                	mov    %esi,%eax
 3e4:	eb 05                	jmp    3eb <stat+0x3d>
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 3e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  r = fstat(fd, st);
  close(fd);
  return r;
}
 3eb:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3ee:	5b                   	pop    %ebx
 3ef:	5e                   	pop    %esi
 3f0:	5d                   	pop    %ebp
 3f1:	c3                   	ret    

000003f2 <atoi>:

int
atoi(const char *s)
{
 3f2:	55                   	push   %ebp
 3f3:	89 e5                	mov    %esp,%ebp
 3f5:	53                   	push   %ebx
 3f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3f9:	0f b6 11             	movzbl (%ecx),%edx
 3fc:	8d 42 d0             	lea    -0x30(%edx),%eax
 3ff:	3c 09                	cmp    $0x9,%al
 401:	77 1f                	ja     422 <atoi+0x30>
 403:	b8 00 00 00 00       	mov    $0x0,%eax
    n = n*10 + *s++ - '0';
 408:	83 c1 01             	add    $0x1,%ecx
 40b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 40e:	0f be d2             	movsbl %dl,%edx
 411:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 415:	0f b6 11             	movzbl (%ecx),%edx
 418:	8d 5a d0             	lea    -0x30(%edx),%ebx
 41b:	80 fb 09             	cmp    $0x9,%bl
 41e:	76 e8                	jbe    408 <atoi+0x16>
 420:	eb 05                	jmp    427 <atoi+0x35>
int
atoi(const char *s)
{
  int n;

  n = 0;
 422:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
  return n;
}
 427:	5b                   	pop    %ebx
 428:	5d                   	pop    %ebp
 429:	c3                   	ret    

0000042a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 42a:	55                   	push   %ebp
 42b:	89 e5                	mov    %esp,%ebp
 42d:	56                   	push   %esi
 42e:	53                   	push   %ebx
 42f:	8b 45 08             	mov    0x8(%ebp),%eax
 432:	8b 75 0c             	mov    0xc(%ebp),%esi
 435:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 438:	85 db                	test   %ebx,%ebx
 43a:	7e 13                	jle    44f <memmove+0x25>
 43c:	ba 00 00 00 00       	mov    $0x0,%edx
    *dst++ = *src++;
 441:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 445:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 448:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 44b:	39 da                	cmp    %ebx,%edx
 44d:	75 f2                	jne    441 <memmove+0x17>
    *dst++ = *src++;
  return vdst;
}
 44f:	5b                   	pop    %ebx
 450:	5e                   	pop    %esi
 451:	5d                   	pop    %ebp
 452:	c3                   	ret    

00000453 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 453:	b8 01 00 00 00       	mov    $0x1,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <exit>:
SYSCALL(exit)
 45b:	b8 02 00 00 00       	mov    $0x2,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <wait>:
SYSCALL(wait)
 463:	b8 03 00 00 00       	mov    $0x3,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <pipe>:
SYSCALL(pipe)
 46b:	b8 04 00 00 00       	mov    $0x4,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <read>:
SYSCALL(read)
 473:	b8 05 00 00 00       	mov    $0x5,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <write>:
SYSCALL(write)
 47b:	b8 10 00 00 00       	mov    $0x10,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <close>:
SYSCALL(close)
 483:	b8 15 00 00 00       	mov    $0x15,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <kill>:
SYSCALL(kill)
 48b:	b8 06 00 00 00       	mov    $0x6,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <exec>:
SYSCALL(exec)
 493:	b8 07 00 00 00       	mov    $0x7,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <open>:
SYSCALL(open)
 49b:	b8 0f 00 00 00       	mov    $0xf,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <mknod>:
SYSCALL(mknod)
 4a3:	b8 11 00 00 00       	mov    $0x11,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <unlink>:
SYSCALL(unlink)
 4ab:	b8 12 00 00 00       	mov    $0x12,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <fstat>:
SYSCALL(fstat)
 4b3:	b8 08 00 00 00       	mov    $0x8,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <link>:
SYSCALL(link)
 4bb:	b8 13 00 00 00       	mov    $0x13,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <mkdir>:
SYSCALL(mkdir)
 4c3:	b8 14 00 00 00       	mov    $0x14,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <chdir>:
SYSCALL(chdir)
 4cb:	b8 09 00 00 00       	mov    $0x9,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <dup>:
SYSCALL(dup)
 4d3:	b8 0a 00 00 00       	mov    $0xa,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <getpid>:
SYSCALL(getpid)
 4db:	b8 0b 00 00 00       	mov    $0xb,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <sbrk>:
SYSCALL(sbrk)
 4e3:	b8 0c 00 00 00       	mov    $0xc,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <sleep>:
SYSCALL(sleep)
 4eb:	b8 0d 00 00 00       	mov    $0xd,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <uptime>:
SYSCALL(uptime)
 4f3:	b8 0e 00 00 00       	mov    $0xe,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <wait2>:
SYSCALL(wait2)
 4fb:	b8 17 00 00 00       	mov    $0x17,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <setVariable>:
SYSCALL(setVariable)
 503:	b8 18 00 00 00       	mov    $0x18,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <getVariable>:
SYSCALL(getVariable)
 50b:	b8 19 00 00 00       	mov    $0x19,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <remVariable>:
SYSCALL(remVariable)
 513:	b8 1a 00 00 00       	mov    $0x1a,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <changeProcTime>:
SYSCALL(changeProcTime)
 51b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <set_priority>:
 523:	b8 1c 00 00 00       	mov    $0x1c,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 52b:	55                   	push   %ebp
 52c:	89 e5                	mov    %esp,%ebp
 52e:	57                   	push   %edi
 52f:	56                   	push   %esi
 530:	53                   	push   %ebx
 531:	83 ec 3c             	sub    $0x3c,%esp
 534:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 537:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 53b:	74 12                	je     54f <printint+0x24>
 53d:	89 d0                	mov    %edx,%eax
 53f:	c1 e8 1f             	shr    $0x1f,%eax
 542:	84 c0                	test   %al,%al
 544:	74 09                	je     54f <printint+0x24>
    neg = 1;
    x = -xx;
 546:	f7 da                	neg    %edx
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 548:	be 01 00 00 00       	mov    $0x1,%esi
 54d:	eb 05                	jmp    554 <printint+0x29>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 54f:	be 00 00 00 00       	mov    $0x0,%esi
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 554:	bf 00 00 00 00       	mov    $0x0,%edi
 559:	eb 02                	jmp    55d <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 55b:	89 df                	mov    %ebx,%edi
 55d:	8d 5f 01             	lea    0x1(%edi),%ebx
 560:	89 d0                	mov    %edx,%eax
 562:	ba 00 00 00 00       	mov    $0x0,%edx
 567:	f7 f1                	div    %ecx
 569:	0f b6 92 0c 09 00 00 	movzbl 0x90c(%edx),%edx
 570:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
 574:	89 c2                	mov    %eax,%edx
 576:	85 c0                	test   %eax,%eax
 578:	75 e1                	jne    55b <printint+0x30>
  if(neg)
 57a:	85 f6                	test   %esi,%esi
 57c:	74 08                	je     586 <printint+0x5b>
    buf[i++] = '-';
 57e:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 583:	8d 5f 02             	lea    0x2(%edi),%ebx

  while(--i >= 0)
 586:	89 d8                	mov    %ebx,%eax
 588:	83 e8 01             	sub    $0x1,%eax
 58b:	78 29                	js     5b6 <printint+0x8b>
 58d:	8b 75 c4             	mov    -0x3c(%ebp),%esi
 590:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 594:	8d 7d d7             	lea    -0x29(%ebp),%edi
 597:	0f b6 03             	movzbl (%ebx),%eax
 59a:	88 45 d7             	mov    %al,-0x29(%ebp)
 59d:	83 ec 04             	sub    $0x4,%esp
 5a0:	6a 01                	push   $0x1
 5a2:	57                   	push   %edi
 5a3:	56                   	push   %esi
 5a4:	e8 d2 fe ff ff       	call   47b <write>
 5a9:	83 eb 01             	sub    $0x1,%ebx
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5ac:	83 c4 10             	add    $0x10,%esp
 5af:	8d 45 d7             	lea    -0x29(%ebp),%eax
 5b2:	39 c3                	cmp    %eax,%ebx
 5b4:	75 e1                	jne    597 <printint+0x6c>
    putc(fd, buf[i]);
}
 5b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b9:	5b                   	pop    %ebx
 5ba:	5e                   	pop    %esi
 5bb:	5f                   	pop    %edi
 5bc:	5d                   	pop    %ebp
 5bd:	c3                   	ret    

000005be <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5be:	55                   	push   %ebp
 5bf:	89 e5                	mov    %esp,%ebp
 5c1:	57                   	push   %edi
 5c2:	56                   	push   %esi
 5c3:	53                   	push   %ebx
 5c4:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c7:	8b 75 0c             	mov    0xc(%ebp),%esi
 5ca:	0f b6 1e             	movzbl (%esi),%ebx
 5cd:	84 db                	test   %bl,%bl
 5cf:	0f 84 a6 01 00 00    	je     77b <printf+0x1bd>
 5d5:	83 c6 01             	add    $0x1,%esi
 5d8:	8d 45 10             	lea    0x10(%ebp),%eax
 5db:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5de:	bf 00 00 00 00       	mov    $0x0,%edi
    c = fmt[i] & 0xff;
 5e3:	0f be d3             	movsbl %bl,%edx
 5e6:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5e9:	85 ff                	test   %edi,%edi
 5eb:	75 25                	jne    612 <printf+0x54>
      if(c == '%'){
 5ed:	83 f8 25             	cmp    $0x25,%eax
 5f0:	0f 84 6a 01 00 00    	je     760 <printf+0x1a2>
 5f6:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5f9:	83 ec 04             	sub    $0x4,%esp
 5fc:	6a 01                	push   $0x1
 5fe:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 601:	50                   	push   %eax
 602:	ff 75 08             	pushl  0x8(%ebp)
 605:	e8 71 fe ff ff       	call   47b <write>
 60a:	83 c4 10             	add    $0x10,%esp
 60d:	e9 5a 01 00 00       	jmp    76c <printf+0x1ae>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 612:	83 ff 25             	cmp    $0x25,%edi
 615:	0f 85 51 01 00 00    	jne    76c <printf+0x1ae>
      if(c == 'd'){
 61b:	83 f8 64             	cmp    $0x64,%eax
 61e:	75 2c                	jne    64c <printf+0x8e>
        printint(fd, *ap, 10, 1);
 620:	83 ec 0c             	sub    $0xc,%esp
 623:	6a 01                	push   $0x1
 625:	b9 0a 00 00 00       	mov    $0xa,%ecx
 62a:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 62d:	8b 17                	mov    (%edi),%edx
 62f:	8b 45 08             	mov    0x8(%ebp),%eax
 632:	e8 f4 fe ff ff       	call   52b <printint>
        ap++;
 637:	89 f8                	mov    %edi,%eax
 639:	83 c0 04             	add    $0x4,%eax
 63c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 63f:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 642:	bf 00 00 00 00       	mov    $0x0,%edi
 647:	e9 20 01 00 00       	jmp    76c <printf+0x1ae>
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 64c:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 652:	83 fa 70             	cmp    $0x70,%edx
 655:	75 2c                	jne    683 <printf+0xc5>
        printint(fd, *ap, 16, 0);
 657:	83 ec 0c             	sub    $0xc,%esp
 65a:	6a 00                	push   $0x0
 65c:	b9 10 00 00 00       	mov    $0x10,%ecx
 661:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 664:	8b 17                	mov    (%edi),%edx
 666:	8b 45 08             	mov    0x8(%ebp),%eax
 669:	e8 bd fe ff ff       	call   52b <printint>
        ap++;
 66e:	89 f8                	mov    %edi,%eax
 670:	83 c0 04             	add    $0x4,%eax
 673:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 676:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 679:	bf 00 00 00 00       	mov    $0x0,%edi
 67e:	e9 e9 00 00 00       	jmp    76c <printf+0x1ae>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 683:	83 f8 73             	cmp    $0x73,%eax
 686:	75 52                	jne    6da <printf+0x11c>
        s = (char*)*ap;
 688:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 68b:	8b 18                	mov    (%eax),%ebx
        ap++;
 68d:	83 c0 04             	add    $0x4,%eax
 690:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 693:	85 db                	test   %ebx,%ebx
          s = "(null)";
 695:	b8 02 09 00 00       	mov    $0x902,%eax
 69a:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 69d:	0f b6 03             	movzbl (%ebx),%eax
 6a0:	84 c0                	test   %al,%al
 6a2:	0f 84 bf 00 00 00    	je     767 <printf+0x1a9>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6a8:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 6ab:	89 75 d0             	mov    %esi,-0x30(%ebp)
 6ae:	8b 75 08             	mov    0x8(%ebp),%esi
 6b1:	88 45 e3             	mov    %al,-0x1d(%ebp)
 6b4:	83 ec 04             	sub    $0x4,%esp
 6b7:	6a 01                	push   $0x1
 6b9:	57                   	push   %edi
 6ba:	56                   	push   %esi
 6bb:	e8 bb fd ff ff       	call   47b <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 6c0:	83 c3 01             	add    $0x1,%ebx
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6c3:	0f b6 03             	movzbl (%ebx),%eax
 6c6:	83 c4 10             	add    $0x10,%esp
 6c9:	84 c0                	test   %al,%al
 6cb:	75 e4                	jne    6b1 <printf+0xf3>
 6cd:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6d0:	bf 00 00 00 00       	mov    $0x0,%edi
 6d5:	e9 92 00 00 00       	jmp    76c <printf+0x1ae>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6da:	83 f8 63             	cmp    $0x63,%eax
 6dd:	75 2b                	jne    70a <printf+0x14c>
 6df:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6e2:	8b 07                	mov    (%edi),%eax
 6e4:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6e7:	83 ec 04             	sub    $0x4,%esp
 6ea:	6a 01                	push   $0x1
 6ec:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6ef:	50                   	push   %eax
 6f0:	ff 75 08             	pushl  0x8(%ebp)
 6f3:	e8 83 fd ff ff       	call   47b <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 6f8:	89 f8                	mov    %edi,%eax
 6fa:	83 c0 04             	add    $0x4,%eax
 6fd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 700:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 703:	bf 00 00 00 00       	mov    $0x0,%edi
 708:	eb 62                	jmp    76c <printf+0x1ae>
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 70a:	83 f8 25             	cmp    $0x25,%eax
 70d:	75 1e                	jne    72d <printf+0x16f>
 70f:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 712:	83 ec 04             	sub    $0x4,%esp
 715:	6a 01                	push   $0x1
 717:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 71a:	50                   	push   %eax
 71b:	ff 75 08             	pushl  0x8(%ebp)
 71e:	e8 58 fd ff ff       	call   47b <write>
 723:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 726:	bf 00 00 00 00       	mov    $0x0,%edi
 72b:	eb 3f                	jmp    76c <printf+0x1ae>
 72d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 731:	83 ec 04             	sub    $0x4,%esp
 734:	6a 01                	push   $0x1
 736:	8d 45 e7             	lea    -0x19(%ebp),%eax
 739:	50                   	push   %eax
 73a:	ff 75 08             	pushl  0x8(%ebp)
 73d:	e8 39 fd ff ff       	call   47b <write>
 742:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 745:	83 c4 0c             	add    $0xc,%esp
 748:	6a 01                	push   $0x1
 74a:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 74d:	50                   	push   %eax
 74e:	ff 75 08             	pushl  0x8(%ebp)
 751:	e8 25 fd ff ff       	call   47b <write>
 756:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 759:	bf 00 00 00 00       	mov    $0x0,%edi
 75e:	eb 0c                	jmp    76c <printf+0x1ae>
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 760:	bf 25 00 00 00       	mov    $0x25,%edi
 765:	eb 05                	jmp    76c <printf+0x1ae>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 767:	bf 00 00 00 00       	mov    $0x0,%edi
 76c:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 76f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 773:	84 db                	test   %bl,%bl
 775:	0f 85 68 fe ff ff    	jne    5e3 <printf+0x25>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 77b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 77e:	5b                   	pop    %ebx
 77f:	5e                   	pop    %esi
 780:	5f                   	pop    %edi
 781:	5d                   	pop    %ebp
 782:	c3                   	ret    

00000783 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 783:	55                   	push   %ebp
 784:	89 e5                	mov    %esp,%ebp
 786:	57                   	push   %edi
 787:	56                   	push   %esi
 788:	53                   	push   %ebx
 789:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 78c:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 78f:	a1 20 0c 00 00       	mov    0xc20,%eax
 794:	eb 0c                	jmp    7a2 <free+0x1f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 796:	8b 10                	mov    (%eax),%edx
 798:	39 d0                	cmp    %edx,%eax
 79a:	72 04                	jb     7a0 <free+0x1d>
 79c:	39 d1                	cmp    %edx,%ecx
 79e:	72 0c                	jb     7ac <free+0x29>
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a0:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a2:	39 c8                	cmp    %ecx,%eax
 7a4:	73 f0                	jae    796 <free+0x13>
 7a6:	8b 10                	mov    (%eax),%edx
 7a8:	39 d1                	cmp    %edx,%ecx
 7aa:	73 3e                	jae    7ea <free+0x67>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ac:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7af:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7b2:	8b 10                	mov    (%eax),%edx
 7b4:	39 d7                	cmp    %edx,%edi
 7b6:	75 0f                	jne    7c7 <free+0x44>
    bp->s.size += p->s.ptr->s.size;
 7b8:	03 77 04             	add    0x4(%edi),%esi
 7bb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7be:	8b 10                	mov    (%eax),%edx
 7c0:	8b 12                	mov    (%edx),%edx
 7c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
 7c5:	eb 03                	jmp    7ca <free+0x47>
  } else
    bp->s.ptr = p->s.ptr;
 7c7:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7ca:	8b 50 04             	mov    0x4(%eax),%edx
 7cd:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7d0:	39 f1                	cmp    %esi,%ecx
 7d2:	75 0d                	jne    7e1 <free+0x5e>
    p->s.size += bp->s.size;
 7d4:	03 53 fc             	add    -0x4(%ebx),%edx
 7d7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7da:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7dd:	89 10                	mov    %edx,(%eax)
 7df:	eb 02                	jmp    7e3 <free+0x60>
  } else
    p->s.ptr = bp;
 7e1:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7e3:	a3 20 0c 00 00       	mov    %eax,0xc20
}
 7e8:	eb 06                	jmp    7f0 <free+0x6d>
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ea:	39 d0                	cmp    %edx,%eax
 7ec:	72 b2                	jb     7a0 <free+0x1d>
 7ee:	eb bc                	jmp    7ac <free+0x29>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 7f0:	5b                   	pop    %ebx
 7f1:	5e                   	pop    %esi
 7f2:	5f                   	pop    %edi
 7f3:	5d                   	pop    %ebp
 7f4:	c3                   	ret    

000007f5 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f5:	55                   	push   %ebp
 7f6:	89 e5                	mov    %esp,%ebp
 7f8:	57                   	push   %edi
 7f9:	56                   	push   %esi
 7fa:	53                   	push   %ebx
 7fb:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7fe:	8b 45 08             	mov    0x8(%ebp),%eax
 801:	8d 58 07             	lea    0x7(%eax),%ebx
 804:	c1 eb 03             	shr    $0x3,%ebx
 807:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 80a:	8b 15 20 0c 00 00    	mov    0xc20,%edx
 810:	85 d2                	test   %edx,%edx
 812:	75 23                	jne    837 <malloc+0x42>
    base.s.ptr = freep = prevp = &base;
 814:	c7 05 20 0c 00 00 24 	movl   $0xc24,0xc20
 81b:	0c 00 00 
 81e:	c7 05 24 0c 00 00 24 	movl   $0xc24,0xc24
 825:	0c 00 00 
    base.s.size = 0;
 828:	c7 05 28 0c 00 00 00 	movl   $0x0,0xc28
 82f:	00 00 00 
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 832:	ba 24 0c 00 00       	mov    $0xc24,%edx
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 837:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 839:	8b 48 04             	mov    0x4(%eax),%ecx
 83c:	39 cb                	cmp    %ecx,%ebx
 83e:	77 20                	ja     860 <malloc+0x6b>
      if(p->s.size == nunits)
 840:	39 cb                	cmp    %ecx,%ebx
 842:	75 06                	jne    84a <malloc+0x55>
        prevp->s.ptr = p->s.ptr;
 844:	8b 08                	mov    (%eax),%ecx
 846:	89 0a                	mov    %ecx,(%edx)
 848:	eb 0b                	jmp    855 <malloc+0x60>
      else {
        p->s.size -= nunits;
 84a:	29 d9                	sub    %ebx,%ecx
 84c:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 84f:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 852:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 855:	89 15 20 0c 00 00    	mov    %edx,0xc20
      return (void*)(p + 1);
 85b:	83 c0 08             	add    $0x8,%eax
 85e:	eb 63                	jmp    8c3 <malloc+0xce>
 860:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 866:	be 00 10 00 00       	mov    $0x1000,%esi
 86b:	0f 43 f3             	cmovae %ebx,%esi
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 86e:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 875:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 877:	39 05 20 0c 00 00    	cmp    %eax,0xc20
 87d:	75 2d                	jne    8ac <malloc+0xb7>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 87f:	83 ec 0c             	sub    $0xc,%esp
 882:	57                   	push   %edi
 883:	e8 5b fc ff ff       	call   4e3 <sbrk>
  if(p == (char*)-1)
 888:	83 c4 10             	add    $0x10,%esp
 88b:	83 f8 ff             	cmp    $0xffffffff,%eax
 88e:	74 27                	je     8b7 <malloc+0xc2>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 890:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 893:	83 ec 0c             	sub    $0xc,%esp
 896:	83 c0 08             	add    $0x8,%eax
 899:	50                   	push   %eax
 89a:	e8 e4 fe ff ff       	call   783 <free>
  return freep;
 89f:	8b 15 20 0c 00 00    	mov    0xc20,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 8a5:	83 c4 10             	add    $0x10,%esp
 8a8:	85 d2                	test   %edx,%edx
 8aa:	74 12                	je     8be <malloc+0xc9>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ac:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8ae:	8b 48 04             	mov    0x4(%eax),%ecx
 8b1:	39 cb                	cmp    %ecx,%ebx
 8b3:	77 c0                	ja     875 <malloc+0x80>
 8b5:	eb 89                	jmp    840 <malloc+0x4b>
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 8b7:	b8 00 00 00 00       	mov    $0x0,%eax
 8bc:	eb 05                	jmp    8c3 <malloc+0xce>
 8be:	b8 00 00 00 00       	mov    $0x0,%eax
  }
}
 8c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8c6:	5b                   	pop    %ebx
 8c7:	5e                   	pop    %esi
 8c8:	5f                   	pop    %edi
 8c9:	5d                   	pop    %ebp
 8ca:	c3                   	ret    
