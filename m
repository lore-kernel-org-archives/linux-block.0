Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED221C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 20:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDAE20661
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 20:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ens1ombt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCFUFO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:05:14 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45447 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfCFUFN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 15:05:13 -0500
Received: by mail-io1-f65.google.com with SMTP id x9so11318700iog.12
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2019 12:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rpl6XbZhYbL589CyP4dvzVbgAwwQsQF/zVr3FgwE6lc=;
        b=ens1ombtwhliK7u4Xjbj6qBYsUtenG+W4/FZ0avy1obL9FTtVeqUbe8gWAgxVq52Lp
         tc12i5s8ru6cn2wzC/WPW07+qvnfqdLuV9u7GDe05setut9Ffo4tK8NlKa3Y8RvqHBjp
         f6PINNFnOout/cctP8FWCs8vi0wtftorwPLFTm6sj8xTTk7bvwuysOEk9+9DiwAS4J4a
         hiGhhXaYoxVYmRk7fi5I7wLAZwExMeQy1qIjXqapUJijPTunJlyBjrYXHaqd8CT81aOJ
         NF9I6HSm+9B97KRAvJMFqumH2x4YL321GcsbwgDtQlNTsMYIaqo1R/8XpRUud43ZlTAd
         va/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rpl6XbZhYbL589CyP4dvzVbgAwwQsQF/zVr3FgwE6lc=;
        b=tobkd2cawiJiNy9DrVdydOSmeE/Nw5Pprke0H6i0DL1W4n4BSnxecOh8/Hk+bOc55H
         OA+jKV02R4Pb38fA/FZOcfZFttbrKfc3rR2R8V7RV7sZWjzaFrdXWLq62Ahb5l2XkEyB
         xBSjngqg7iAj8J51ATQmarYErKn2gTBnYJIT0mvngYi2H7dqvez6cIx31A6ylWkrcryL
         5+j+DU6fthop5NzMW6Xhl5lZD5Eh4h69cru3ZH0X3PcZpRRio0ffBRStAHHvgz8f8POp
         Fj0Ig/ueRsg+r6/sloXKre5/Hslj4vgvejsjlILVV4Xdg//zJ4YpEdRqPYfxuXB7ewue
         bbqA==
X-Gm-Message-State: APjAAAXtzwh9e5C5LB7uOO0yojAvZbxzlqx/hh+7BePVKy25j2iOnyhl
        yFNHAVDQpi6qGDhjVfMBH/n7s9IG+hZ9Cw==
X-Google-Smtp-Source: APXvYqwh11HU6TK2dMIj31CvsEdeA2Ris8UUPqzZNv/tR6dxfWf1HD0m9eprnZJmRpAs2r5hhsHR7w==
X-Received: by 2002:a6b:e009:: with SMTP id z9mr4291436iog.54.1551902712263;
        Wed, 06 Mar 2019 12:05:12 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x17sm1273436ita.43.2019.03.06.12.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 12:05:11 -0800 (PST)
Subject: Re: [GIT PULL] Support for the io_uring IO interface
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
References: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk>
Message-ID: <5c128dfd-9e6c-21fe-7b2b-397d495e112a@kernel.dk>
Date:   Wed, 6 Mar 2019 13:05:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/6/19 9:13 AM, Jens Axboe wrote:
> Hi Linus,
> 
> 2nd attempt at adding the io_uring interface. Since the first one,
> we've added basic unit testing of the three system calls, that
> resides in liburing like the other unit tests that we have so far.
> It'll take a while to get full coverage of it, but we're working
> towards it. I've also added two basic test programs to tools/io_uring.
> One uses the raw interface and has support for all the various
> features that io_uring supports outside of standard IO, like fixed
> files, fixed IO buffers, and polled IO. The other uses the liburing
> API, and is a simplified version of cp(1).
> 
> This pull request adds support for a new IO interface, io_uring.
> io_uring allows an application to communicate with the kernel through
> two rings, the submission queue (SQ) and completion queue (CQ) ring.
> This allows for very efficient handling of IOs, see the v5 posting for
> some basic numbers:
> 
> https://lore.kernel.org/linux-block/20190116175003.17880-1-axboe@kernel.dk/
> 
> Outside of just efficiency, the interface is also flexible and
> extendable, and allows for future use cases like the upcoming NVMe
> key-value store API, networked IO, and so on. It also supports async
> buffered IO, something that we've always failed to support in the
> kernel.
> 
> Outside of basic IO features, it supports async polled IO as well. This
> particular feature has already been tested at Facebook months ago for
> flash storage boxes, with 25-33% improvements. It makes polled IO
> actually useful for real world use cases, where even basic flash sees a
> nice win in terms of efficiency, latency, and performance. These boxes
> were IOPS bound before, now they are not.
> 
> This series adds three new system calls. One for setting up an io_uring
> instance (io_uring_setup(2)), one for submitting/completing IO
> (io_uring_enter(2)), and one for aux functions like registrating file
> sets, buffers, etc (io_uring_register(2)). Through the help of Arnd,
> I've coordinated the syscall numbers so merge on that front should be
> painless.
> 
> Jon did a writeup of the interface a while back, which (except for minor
> details that have been tweaked) is still accurate. Find that here:
> 
> https://lwn.net/Articles/776703/
> 
> Huge thanks to Al Viro for helping getting the reference cycle code
> correct, and to Jann Horn for his extensive reviews focused on both
> security and bugs in general.
> 
> There's a userspace library that provides basic functionality for
> applications that don't need or want to care about how to fiddle with
> the rings directly. It has helpers to allow applications to easily set
> up an io_uring instance, and submit/complete IO through it without
> knowing about the intricacies of the rings. It also includes man pages
> (thanks to Jeff Moyer), and will continue to grow support helper
> functions and features as time progresses. Find it here:
> 
> git://git.kernel.dk/liburing
> 
> Fio has full support for the raw interface, both in the form of an IO
> engine (io_uring), but also with a small test application (t/io_uring)
> that can exercise and benchmark the interface.
> 
> Note that this branch sits on top of my for-5.1/block branch, since the
> multi-page bvec changes caused a few conflicts with the pre-mapped
> buffer support. I also moved a few prep patches to that branch today,
> which is why it appears recently rebased (moved the 4 bottom patches
> from io_uring to for-5.1/block).
> 
> Please consider this feature for 5.1, so we can finally have something
> that's both fast, efficient, and feature rich for IO instead of the sad
> niche case that is aio/libaio.
> 
> 
>   git://git.kernel.dk/linux-block.git tags/io_uring-2019-03-06

Slight mess up in the stats, here's the correct one... Note that this
also throws a few more merge conflicts now, due to the syscall merges.
All trivial, though, and the branch was prepared for it in terms of
numbering.

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
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/io_uring.c                          | 2971 ++++++++++++++++++++++++++++++++
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
 32 files changed, 4782 insertions(+), 146 deletions(-)
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

