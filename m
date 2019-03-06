Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AC5C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 16:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B94F20684
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 16:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w5Dc63nQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfCFQN2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:13:28 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55388 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfCFQN2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 11:13:28 -0500
Received: by mail-it1-f194.google.com with SMTP id z131so10299129itf.5
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2019 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gRcpq9CxdNSfX4LA/KD+JC2axv2ljFZgXCq5AC6Swb8=;
        b=w5Dc63nQyjMatswBsOUCQbsEe10PSqfZ2my7AfVtklA9m7IN3aL9z6ay+6a/IN5zTd
         pATptjjVazvzXrVnVwaGSn4d3HEfZn+iUNIqHnOLwF4/sag0TzLxU59/Rg/RyDKCc+Zk
         5WywD0MQUV5o63j+dk6jOQ8crs/trovj70cUrJ7PwTVfXaJNkZW6jEHALXu2tSjRVKh8
         6+k9P/CRJZFRJIzmyC2J3Qzt8XMJXYiOaOcuLqkq7B+RxOuCjS0mQL7zcAhh/YI1N9t3
         2qJm9gGW17+21YQTAoUOqcybPSHB6TGueCXQ03WWDScvoSVCAXvhkg61BxAPGOxgWVJ+
         dYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gRcpq9CxdNSfX4LA/KD+JC2axv2ljFZgXCq5AC6Swb8=;
        b=UZH2VUINIL8wpVBdqAPKZjR1kq+iIaNNFe+edPXz49cS+vYcP1I5apvIdP+nQ1gv/p
         xdGF9UdVcMz/IVcNdD9U07JFk4jubfLaLR69g3YqURmKmOCb+Tw6oF89U9usTgVafW+d
         qAhysWACslPLZR4Y3aIvq3Miv2EpY1kAeQGM/R00KNjuKDqftJygwEcof4BHnp9czeKf
         iVgW6zs3v2CbDibAPu20EoUpmiePpxaZd6BluXZ+H+9y5szKxAKz5tlZgT0byWnvy2g0
         MY4bkctrHY4rONvDDH628pkVIQS5AC8Xxt2Vmqp9hGNqXRkL1KPLxGugGZ/p98LP4vqS
         LPMA==
X-Gm-Message-State: APjAAAXo/g9N9tgvr5faY64NAVzEQJKSCiMx/WPl5XTNytTuntXHmo6l
        szlg69AnN4g3h3FDCqAvTDgaN/VSKxrN7Q==
X-Google-Smtp-Source: APXvYqyomvglIN7hJ6AZf/1MS9b2s6wDMM1c/8eROCNdMBh99HNOke8CRPM6o5dC1z0SuZRCkAB0PA==
X-Received: by 2002:a24:21d5:: with SMTP id e204mr2558692ita.56.1551888806944;
        Wed, 06 Mar 2019 08:13:26 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u25sm623768iol.76.2019.03.06.08.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 08:13:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Support for the io_uring IO interface
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
Message-ID: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk>
Date:   Wed, 6 Mar 2019 09:13:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

2nd attempt at adding the io_uring interface. Since the first one,
we've added basic unit testing of the three system calls, that
resides in liburing like the other unit tests that we have so far.
It'll take a while to get full coverage of it, but we're working
towards it. I've also added two basic test programs to tools/io_uring.
One uses the raw interface and has support for all the various
features that io_uring supports outside of standard IO, like fixed
files, fixed IO buffers, and polled IO. The other uses the liburing
API, and is a simplified version of cp(1).

This pull request adds support for a new IO interface, io_uring.
io_uring allows an application to communicate with the kernel through
two rings, the submission queue (SQ) and completion queue (CQ) ring.
This allows for very efficient handling of IOs, see the v5 posting for
some basic numbers:

https://lore.kernel.org/linux-block/20190116175003.17880-1-axboe@kernel.dk/

Outside of just efficiency, the interface is also flexible and
extendable, and allows for future use cases like the upcoming NVMe
key-value store API, networked IO, and so on. It also supports async
buffered IO, something that we've always failed to support in the
kernel.

Outside of basic IO features, it supports async polled IO as well. This
particular feature has already been tested at Facebook months ago for
flash storage boxes, with 25-33% improvements. It makes polled IO
actually useful for real world use cases, where even basic flash sees a
nice win in terms of efficiency, latency, and performance. These boxes
were IOPS bound before, now they are not.

This series adds three new system calls. One for setting up an io_uring
instance (io_uring_setup(2)), one for submitting/completing IO
(io_uring_enter(2)), and one for aux functions like registrating file
sets, buffers, etc (io_uring_register(2)). Through the help of Arnd,
I've coordinated the syscall numbers so merge on that front should be
painless.

Jon did a writeup of the interface a while back, which (except for minor
details that have been tweaked) is still accurate. Find that here:

https://lwn.net/Articles/776703/

Huge thanks to Al Viro for helping getting the reference cycle code
correct, and to Jann Horn for his extensive reviews focused on both
security and bugs in general.

There's a userspace library that provides basic functionality for
applications that don't need or want to care about how to fiddle with
the rings directly. It has helpers to allow applications to easily set
up an io_uring instance, and submit/complete IO through it without
knowing about the intricacies of the rings. It also includes man pages
(thanks to Jeff Moyer), and will continue to grow support helper
functions and features as time progresses. Find it here:

git://git.kernel.dk/liburing

Fio has full support for the raw interface, both in the form of an IO
engine (io_uring), but also with a small test application (t/io_uring)
that can exercise and benchmark the interface.

Note that this branch sits on top of my for-5.1/block branch, since the
multi-page bvec changes caused a few conflicts with the pre-mapped
buffer support. I also moved a few prep patches to that branch today,
which is why it appears recently rebased (moved the 4 bottom patches
from io_uring to for-5.1/block).

Please consider this feature for 5.1, so we can finally have something
that's both fast, efficient, and feature rich for IO instead of the sad
niche case that is aio/libaio.


  git://git.kernel.dk/linux-block.git tags/io_uring-2019-03-06


----------------------------------------------------------------
Christoph Hellwig (1):
      io_uring: add fsync support

Jens Axboe (14):
      Add io_uring IO interface
      io_uring: support for IO polling
      fs: add fget_many() and fput_many()
      io_uring: use fget/fput_many() for file references
      io_uring: batch io_kiocb allocation
      block: implement bio helper to add iter bvec pages to bio
      io_uring: add support for pre-mapped user IO buffers
      net: split out functions related to registering inflight socket files
      io_uring: add file set registration
      io_uring: add submission polling
      io_uring: add io_kiocb ref count
      io_uring: add support for IORING_OP_POLL
      io_uring: allow workqueue item to handle multiple buffered requests
      io_uring: add a few test tools

 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   62 +-
 fs/Makefile                            |    1 +
 fs/aio.c                               |    6 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/io_uring.c                          | 2969 ++++++++++++++++++++++++++++++++
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |   13 +-
 include/linux/sched/user.h             |    2 +-
 include/linux/syscalls.h               |    8 +
 include/net/af_unix.h                  |    1 +
 include/uapi/asm-generic/unistd.h      |    8 +-
 include/uapi/linux/io_uring.h          |  137 ++
 init/Kconfig                           |    9 +
 kernel/sys_ni.c                        |    3 +
 net/Makefile                           |    2 +-
 net/unix/Kconfig                       |    5 +
 net/unix/Makefile                      |    2 +
 net/unix/af_unix.c                     |   63 +-
 net/unix/garbage.c                     |   68 +-
 net/unix/scm.c                         |  151 ++
 net/unix/scm.h                         |   10 +
 tools/io_uring/Makefile                |   18 +
 tools/io_uring/README                  |   29 +
 tools/io_uring/barrier.h               |   16 +
 tools/io_uring/io_uring-bench.c        |  616 +++++++
 tools/io_uring/io_uring-cp.c           |  251 +++
 tools/io_uring/liburing.h              |  143 ++
 tools/io_uring/queue.c                 |  164 ++
 tools/io_uring/setup.c                 |  103 ++
 tools/io_uring/syscall.c               |   40 +
 33 files changed, 4784 insertions(+), 148 deletions(-)
 create mode 100644 fs/io_uring.c
 create mode 100644 include/uapi/linux/io_uring.h
 create mode 100644 net/unix/scm.c
 create mode 100644 net/unix/scm.h
 create mode 100644 tools/io_uring/Makefile
 create mode 100644 tools/io_uring/README
 create mode 100644 tools/io_uring/barrier.h
 create mode 100644 tools/io_uring/io_uring-bench.c
 create mode 100644 tools/io_uring/io_uring-cp.c
 create mode 100644 tools/io_uring/liburing.h
 create mode 100644 tools/io_uring/queue.c
 create mode 100644 tools/io_uring/setup.c
 create mode 100644 tools/io_uring/syscall.c

-- 
Jens Axboe

