Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09683C61DA4
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 05:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjBBFIP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 00:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjBBFIM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 00:08:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F657F32C
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 21:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675314442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H/GDdnEt1TlEvjFb1Q53kDUMuRo1Kqy7tZ1KW92PkMM=;
        b=Fm66our1AUi24Z/nGxZavy0TBp0D4xLMd4z4BbCWJGcvwtcxjroyVW8os7kWor2coOfN5N
        3J00m/EJFXqvR308Ivj+wSlzKbnvbIWQAhW9/rIgQ7PishZSz0lyWNhFQbzvPrZ+pGh8tZ
        /VaLhjfe669Km6qSVsmy0CjH28lR76U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-193-lv2jPzYCN9CJ-2zukODm2g-1; Thu, 02 Feb 2023 00:07:18 -0500
X-MC-Unique: lv2jPzYCN9CJ-2zukODm2g-1
Received: by mail-pj1-f69.google.com with SMTP id nb8-20020a17090b35c800b0022bb3fd0718so445618pjb.4
        for <linux-block@vger.kernel.org>; Wed, 01 Feb 2023 21:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/GDdnEt1TlEvjFb1Q53kDUMuRo1Kqy7tZ1KW92PkMM=;
        b=VoTmMVJoagQzOPrbidmpnH9Unk3EADLJl3csYmDFaGeGc/7zAShIjhBL0lI4qbZnVx
         YFnt6DhQLoes55KufFyMqIS5mjwNBwgSpzCwgSqFvzAsuKkNj+ibaadGejaCKIDFjY3K
         jqMs8CjI17XfHAsxYDp5hJrHjM8nX1Z7C1ADgxNvGoN+GxzHcdK4QJw7TUeJ31jRDwfa
         QD/h+k/uY8ZrxccxHI28SjDJL+1MCujp8gRC+vINf15ZJCjiv5OBn/o1mWRd7jAnMZxo
         JTSPzJJbpsESTjO6sdMsyBe2eUExnIExiKHbRmvvJsl8OeMZRUDQNJP0gx5tGtDPFBCg
         IyOQ==
X-Gm-Message-State: AO0yUKU7vs+8ngDwPdcgdKEVuOE8okMjBcvvUJIq/KQIyXt7gJxWJJGZ
        bUbK27XnBp/FZUmqcmpke2nqamlHRwzaNsPb2s14sJ3Mnpt/XSJN1WsYMyVaVncYiZ25yxolhci
        OlIOF4p8bBv7lbgTywcHH/1idaDtbDVaIxAqrC/U=
X-Received: by 2002:a17:90a:67c7:b0:22c:5f8f:623b with SMTP id g7-20020a17090a67c700b0022c5f8f623bmr257172pjm.96.1675314436378;
        Wed, 01 Feb 2023 21:07:16 -0800 (PST)
X-Google-Smtp-Source: AK7set9uFlG4I64vItifydwT3+CmtmhWBlh536NpU7zpSrKovrB9ZNfDNJ68bU8VI27eRgNV+H5Po2zjHEOPFO/xnQw=
X-Received: by 2002:a17:90a:67c7:b0:22c:5f8f:623b with SMTP id
 g7-20020a17090a67c700b0022c5f8f623bmr257168pjm.96.1675314436121; Wed, 01 Feb
 2023 21:07:16 -0800 (PST)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 2 Feb 2023 13:07:03 +0800
Message-ID: <CAHj4cs8WN_OyT0ZZAG81UP-cW49cL6=ve5dzVFqLd_-zkfp6aA@mail.gmail.com>
Subject: [bug report]blktests: g++ discontiguous-io.cpp failed
To:     linux-block <linux-block@vger.kernel.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
I found blktests make failed recently, could you help check it, thanks.

version:
gcc-c++-13.0.1-0.2.fc38.x86_64
6.2.0-rc4

[root@localhost blktests]# make
make -C src all
make[1]: Entering directory '/root/blktests/src'
cc  -O2 -Wall -Wshadow  -DHAVE_LINUX_BLKZONED_H -o loblksize loblksize.c
cc  -O2 -Wall -Wshadow  -DHAVE_LINUX_BLKZONED_H -o loop_change_fd
loop_change_fd.c
cc  -O2 -Wall -Wshadow  -DHAVE_LINUX_BLKZONED_H -o
loop_get_status_null loop_get_status_null.c
cc  -O2 -Wall -Wshadow  -DHAVE_LINUX_BLKZONED_H -o mount_clear_sock
mount_clear_sock.c
cc  -O2 -Wall -Wshadow  -DHAVE_LINUX_BLKZONED_H -o nbdsetsize nbdsetsize.c
cc  -O2 -Wall -Wshadow  -DHAVE_LINUX_BLKZONED_H -o openclose openclose.c
cc  -O2 -Wall -Wshadow  -DHAVE_LINUX_BLKZONED_H -o sg/dxfer-from-dev
sg/dxfer-from-dev.c
cc  -O2 -Wall -Wshadow  -DHAVE_LINUX_BLKZONED_H -o sg/syzkaller1 sg/syzkall=
er1.c
cc  -O2 -Wall -Wshadow  -DHAVE_LINUX_BLKZONED_H -o zbdioctl zbdioctl.c
g++  -O2 -std=3Dc++11 -Wall -Wextra -Wshadow -Wno-sign-compare -Werror
-DHAVE_LINUX_BLKZONED_H -o discontiguous-io discontiguous-io.cpp
discontiguous-io.cpp: In function =E2=80=98void dumphex(std::ostream&, cons=
t
void*, size_t)=E2=80=99:
discontiguous-io.cpp:92:24: error: =E2=80=98uintptr_t=E2=80=99 was not decl=
ared in this scope
   92 |                    << (uintptr_t)a + i << ':';
      |                        ^~~~~~~~~
discontiguous-io.cpp:15:1: note: =E2=80=98uintptr_t=E2=80=99 is defined in =
header
=E2=80=98<cstdint>=E2=80=99; did you forget to =E2=80=98#include <cstdint>=
=E2=80=99?
   14 | #include <vector>
  +++ |+#include <cstdint>
   15 |
discontiguous-io.cpp:97:43: error: =E2=80=98uint8_t=E2=80=99 was not declar=
ed in this scope
   97 |                            << (unsigned)((uint8_t*)a)[j];
      |                                           ^~~~~~~
discontiguous-io.cpp:97:43: note: =E2=80=98uint8_t=E2=80=99 is defined in h=
eader
=E2=80=98<cstdint>=E2=80=99; did you forget to =E2=80=98#include <cstdint>=
=E2=80=99?
discontiguous-io.cpp:97:51: error: expected primary-expression before =E2=
=80=98)=E2=80=99 token
   97 |                            << (unsigned)((uint8_t*)a)[j];
      |                                                   ^
discontiguous-io.cpp:97:52: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98a=E2=80=99
   97 |                            << (unsigned)((uint8_t*)a)[j];
      |                                         ~          ^
      |                                                    )
discontiguous-io.cpp:101:45: error: =E2=80=98uint8_t=E2=80=99 was not decla=
red in this scope
  101 |                         unsigned char c =3D ((uint8_t*)a)[j];
      |                                             ^~~~~~~
discontiguous-io.cpp:101:45: note: =E2=80=98uint8_t=E2=80=99 is defined in =
header
=E2=80=98<cstdint>=E2=80=99; did you forget to =E2=80=98#include <cstdint>=
=E2=80=99?
discontiguous-io.cpp:101:53: error: expected primary-expression before =E2=
=80=98)=E2=80=99 token
  101 |                         unsigned char c =3D ((uint8_t*)a)[j];
      |                                                     ^
discontiguous-io.cpp:101:54: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98a=E2=80=99
  101 |                         unsigned char c =3D ((uint8_t*)a)[j];
      |                                           ~          ^
      |                                                      )
discontiguous-io.cpp:88:51: error: unused parameter =E2=80=98a=E2=80=99
[-Werror=3Dunused-parameter]
   88 | static void dumphex(std::ostream &os, const void *a, size_t len)
      |                                       ~~~~~~~~~~~~^
discontiguous-io.cpp: At global scope:
discontiguous-io.cpp:113:51: error: =E2=80=98uint32_t=E2=80=99 has not been=
 declared
  113 | static ssize_t sg_read(const file_descriptor &fd, uint32_t lba,
      |                                                   ^~~~~~~~
discontiguous-io.cpp: In function =E2=80=98ssize_t sg_read(const
file_descriptor&, int, const iovec_t&)=E2=80=99:
discontiguous-io.cpp:130:9: error: =E2=80=98uint8_t=E2=80=99 was not declar=
ed in this scope
  130 |         uint8_t read6[6] =3D {
      |         ^~~~~~~
discontiguous-io.cpp:130:9: note: =E2=80=98uint8_t=E2=80=99 is defined in h=
eader
=E2=80=98<cstdint>=E2=80=99; did you forget to =E2=80=98#include <cstdint>=
=E2=80=99?
discontiguous-io.cpp:140:18: error: =E2=80=98read6=E2=80=99 was not declare=
d in this
scope; did you mean =E2=80=98read=E2=80=99?
  140 |         h.cmdp =3D read6;
      |                  ^~~~~
      |                  read
discontiguous-io.cpp:154:9: error: =E2=80=98uint32_t=E2=80=99 was not decla=
red in this scope
  154 |         uint32_t result =3D h.status | (h.msg_status << 8) |
      |         ^~~~~~~~
discontiguous-io.cpp:154:9: note: =E2=80=98uint32_t=E2=80=99 is defined in =
header
=E2=80=98<cstdint>=E2=80=99; did you forget to =E2=80=98#include <cstdint>=
=E2=80=99?
discontiguous-io.cpp:156:13: error: =E2=80=98result=E2=80=99 was not declar=
ed in this scope
  156 |         if (result) {
      |             ^~~~~~
discontiguous-io.cpp: At global scope:
discontiguous-io.cpp:168:52: error: =E2=80=98uint32_t=E2=80=99 has not been=
 declared
  168 | static ssize_t sg_write(const file_descriptor &fd, uint32_t lba,
      |                                                    ^~~~~~~~
discontiguous-io.cpp: In function =E2=80=98ssize_t sg_write(const
file_descriptor&, int, const iovec_t&)=E2=80=99:
discontiguous-io.cpp:204:9: error: =E2=80=98uint8_t=E2=80=99 was not declar=
ed in this scope
  204 |         uint8_t write6[6] =3D {
      |         ^~~~~~~
discontiguous-io.cpp:204:9: note: =E2=80=98uint8_t=E2=80=99 is defined in h=
eader
=E2=80=98<cstdint>=E2=80=99; did you forget to =E2=80=98#include <cstdint>=
=E2=80=99?
discontiguous-io.cpp:214:18: error: =E2=80=98write6=E2=80=99 was not declar=
ed in this
scope; did you mean =E2=80=98write=E2=80=99?
  214 |         h.cmdp =3D write6;
      |                  ^~~~~~
      |                  write
discontiguous-io.cpp:228:9: error: =E2=80=98uint32_t=E2=80=99 was not decla=
red in this scope
  228 |         uint32_t result =3D h.status | (h.msg_status << 8) |
      |         ^~~~~~~~
discontiguous-io.cpp:228:9: note: =E2=80=98uint32_t=E2=80=99 is defined in =
header
=E2=80=98<cstdint>=E2=80=99; did you forget to =E2=80=98#include <cstdint>=
=E2=80=99?
discontiguous-io.cpp:230:13: error: =E2=80=98result=E2=80=99 was not declar=
ed in this scope
  230 |         if (result) {
      |             ^~~~~~
discontiguous-io.cpp: In function =E2=80=98int main(int, char**)=E2=80=99:
discontiguous-io.cpp:250:9: error: =E2=80=98uint32_t=E2=80=99 was not decla=
red in this scope
  250 |         uint32_t offs =3D 0;
      |         ^~~~~~~~
discontiguous-io.cpp:250:9: note: =E2=80=98uint32_t=E2=80=99 is defined in =
header
=E2=80=98<cstdint>=E2=80=99; did you forget to =E2=80=98#include <cstdint>=
=E2=80=99?
discontiguous-io.cpp:253:21: error: =E2=80=98uint8_t=E2=80=99 was not decla=
red in this scope
  253 |         std::vector<uint8_t> buf;
      |                     ^~~~~~~
discontiguous-io.cpp:253:21: note: =E2=80=98uint8_t=E2=80=99 is defined in =
header
=E2=80=98<cstdint>=E2=80=99; did you forget to =E2=80=98#include <cstdint>=
=E2=80=99?
discontiguous-io.cpp:253:28: error: template argument 1 is invalid
  253 |         std::vector<uint8_t> buf;
      |                            ^
discontiguous-io.cpp:253:28: error: template argument 2 is invalid
discontiguous-io.cpp:259:27: error: =E2=80=98offs=E2=80=99 was not declared=
 in this
scope; did you mean =E2=80=98ffs=E2=80=99?
  259 |                 case 'o': offs =3D strtoul(optarg, NULL, 0); break;
      |                           ^~~~
      |                           ffs
discontiguous-io.cpp:272:13: error: request for member =E2=80=98resize=E2=
=80=99 in
=E2=80=98buf=E2=80=99, which is of non-class type =E2=80=98int=E2=80=99
  272 |         buf.resize(len);
      |             ^~~~~~
discontiguous-io.cpp:284:21: error: =E2=80=98offs=E2=80=99 was not declared=
 in this
scope; did you mean =E2=80=98ffs=E2=80=99?
  284 |                 if (offs % block_size) {
      |                     ^~~~
      |                     ffs
discontiguous-io.cpp:290:29: error: request for member =E2=80=98resize=E2=
=80=99 in
=E2=80=98buf=E2=80=99, which is of non-class type =E2=80=98int=E2=80=99
  290 |                         buf.resize(buf.size() * 2);
      |                             ^~~~~~
discontiguous-io.cpp:290:40: error: request for member =E2=80=98size=E2=80=
=99 in
=E2=80=98buf=E2=80=99, which is of non-class type =E2=80=98int=E2=80=99
  290 |                         buf.resize(buf.size() * 2);
      |                                        ^~~~
discontiguous-io.cpp:291:50: error: request for member =E2=80=98begin=E2=80=
=99 in
=E2=80=98buf=E2=80=99, which is of non-class type =E2=80=98int=E2=80=99
  291 |                         unsigned char *p =3D &*buf.begin();
      |                                                  ^~~~~
discontiguous-io.cpp:296:42: error: request for member =E2=80=98begin=E2=80=
=99 in
=E2=80=98buf=E2=80=99, which is of non-class type =E2=80=98int=E2=80=99
  296 |                         iov.append(&*buf.begin(), buf.size());
      |                                          ^~~~~
discontiguous-io.cpp:296:55: error: request for member =E2=80=98size=E2=80=
=99 in
=E2=80=98buf=E2=80=99, which is of non-class type =E2=80=98int=E2=80=99
  296 |                         iov.append(&*buf.begin(), buf.size());
      |                                                       ^~~~
discontiguous-io.cpp:309:56: error: =E2=80=98offs=E2=80=99 was not declared=
 in this
scope; did you mean =E2=80=98ffs=E2=80=99?
  309 |                         ssize_t written =3D sg_write(fd, offs /
block_size, iov);
      |                                                        ^~~~
      |                                                        ffs
discontiguous-io.cpp:315:52: error: =E2=80=98offs=E2=80=99 was not declared=
 in this
scope; did you mean =E2=80=98ffs=E2=80=99?
  315 |                         ssize_t read =3D sg_read(fd, offs /
block_size, iov);
      |                                                    ^~~~
      |                                                    ffs
discontiguous-io.cpp: At global scope:
discontiguous-io.cpp:168:16: error: =E2=80=98ssize_t sg_write(const
file_descriptor&, int, const iovec_t&)=E2=80=99 defined but not used
[-Werror=3Dunused-function]
  168 | static ssize_t sg_write(const file_descriptor &fd, uint32_t lba,
      |                ^~~~~~~~
discontiguous-io.cpp:113:16: error: =E2=80=98ssize_t sg_read(const
file_descriptor&, int, const iovec_t&)=E2=80=99 defined but not used
[-Werror=3Dunused-function]
  113 | static ssize_t sg_read(const file_descriptor &fd, uint32_t lba,
      |                ^~~~~~~
cc1plus: all warnings being treated as errors
make[1]: *** [Makefile:40: discontiguous-io] Error 1
make[1]: Leaving directory '/root/blktests/src'
make: *** [Makefile:5: all] Error 2
--=20
Best Regards,
  Yi Zhang

