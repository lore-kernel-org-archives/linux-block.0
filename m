Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422CCC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 01:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0749020835
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 01:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W3rnydOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfCDBxm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Mar 2019 20:53:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44020 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfCDBxm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Mar 2019 20:53:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so1784002pfh.10
        for <linux-block@vger.kernel.org>; Sun, 03 Mar 2019 17:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=uJQ/hiTS1J8lSXUOjoqnNe5rwxLwoENy37yf6d5LQos=;
        b=W3rnydOyIV5W7qYVjHK9n0WfFTVJJmYm2y7AGn1Jd8LiPMESKZnxNg1kzFj69pXp5u
         STLeFyK+DibocXN4nsGd3HgYSVHmWQ2IMVD8xdNhizWajR3OwgyGhYmgaplX4DkkJ28/
         6b1kyPPrYP77qTEYwv2xOcL/t8B28aSLTi8KHTUEqhuDsm+5ba5TippmzjX6JESH31eF
         K3dN6DMyYmOPcDR79xXsrWQqHvdf6YU7R8EfBR0Bp7V84iMfz3CJm1OSCHk1IB5AV5nJ
         Cm8wU+8glTNsD5ATsYu656m2QZyIdYFQawb2vvbz9qP98IMXq3UzEsRcGcPkimNSRVwY
         Xxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uJQ/hiTS1J8lSXUOjoqnNe5rwxLwoENy37yf6d5LQos=;
        b=F0DNzs7chuxnjBy0s7Ft74wHCiLXvy9auiXoVjSPg+GPptCoV2u5oj3MCdljBN4Iu4
         l/mMqL7FtS/Up8thtnA7uO4w1MgtktGyoV/5yqWQfH5WzgbwQgibJpWxXq/OxxSmPPBD
         cb+oW9BS+xr9ZRd5q9HBuKX5sy/ccSTrlPHh6twBbrvgGbRQX552D9F/93rlSF0l5mJU
         /hXGc8oBB7rf8km8BcFs2qvMCdRlKeV8d5sTDmMLAU6w7hfgRdPfqr+7felucy2RHqUw
         2x5kww9ePfUI+k8jALp0CMPnIeh+gSucZHLWobkOIkRQCIuiceYHVnvu5gJtfzqAc+Gg
         mBmA==
X-Gm-Message-State: APjAAAUiJfZX/ILDMe8VqjLAg4/EiptM/kdSQHh9aZO4h9DHHW+63f3O
        mEFvbkHOaFw0BiXsOjZdmyXNa03Yf7Wi18UI
X-Google-Smtp-Source: APXvYqx5zOyWZ22tihw27sZVRTOIr1rSQwxE9Cn5I76/92AiG1XXx5gGKwbUbkRqOZM26g9ke0Fy6g==
X-Received: by 2002:a63:6244:: with SMTP id w65mr15947016pgb.300.1551664421086;
        Sun, 03 Mar 2019 17:53:41 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f192sm3711934pfc.180.2019.03.03.17.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 17:53:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Support for the io_uring IO interface
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
Message-ID: <f15aeeb9-e602-27bc-f230-ce52e59f6bb2@kernel.dk>
Date:   Sun, 3 Mar 2019 18:53:38 -0700
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


  git://git.kernel.dk/linux-block.git tags/io_uring-20190301


----------------------------------------------------------------
Christoph Hellwig (1):
      io_uring: add fsync support

Jens Axboe (13):
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

 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   62 +-
 fs/Makefile                            |    1 +
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
 23 files changed, 3400 insertions(+), 146 deletions(-)
 create mode 100644 fs/io_uring.c
 create mode 100644 include/uapi/linux/io_uring.h
 create mode 100644 net/unix/scm.c
 create mode 100644 net/unix/scm.h

-- 
Jens Axboe

