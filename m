Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3186BC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F387721738
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YVbBVbV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfA1Vfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:35:51 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50282 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfA1Vfu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:35:50 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so954103iti.0
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 13:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=yz6h+mLh2vwFNaFMdtTSP8ri6ehdHYiZQEw7fE87pq8=;
        b=YVbBVbV9qifyMltwzljiYPd76h+P/nubmrucn6NTuZk0dgcON5HX28x9lzzqYHw0Lr
         BfN44iqfEpWdcG3NLQYTOAi2iVSX3SGPxZ0gLACHIgzgAJdY8NZS82zbRbKIkjNDMLD4
         Rdz70CBn5Xwy14zQcGx4yEkbtzUB4OGWEBON1W1LQuTfL9BvQqdFhvlWoq1XbpRHU0aZ
         3TDHSS1aE8OxACtt84vG0hVOnVjEIMP7HrrBtngTAr4YeaTdsHy7VVYz1+np1WMaUCsg
         jDeIOSVZz9igUAFQasj8DZJo1ntBE4pxC610V6Qt+pKI3Rs7qtpIDNalFoKJKA8bk77M
         9W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yz6h+mLh2vwFNaFMdtTSP8ri6ehdHYiZQEw7fE87pq8=;
        b=lURii7J98tfME6DYNCDPy0heuePUrUuBMZFZLiW0YJkovqvgNMSjkM8ni77GmeiTVl
         1xNmGXxFncHf8OjJfJCoTXhFiHzls+0Sm0q6+ulv/k1HjNx15LU4FFM7elXWimFTIbpf
         3zt2Cr83ijd7IFIzVeNNjZJzpfxzPc9hM+Ot5aJ7NU3xvUM8gGpIR9/mu0o68Q2lsD1P
         EO7bhp797lLcJKFHE2W1khj98/SXB136K8jz1S+8rnk35rHZQg15S/tisJlnTWTyA7ce
         XY5tk7/uZ8iAQtnzOCNbnAr2Dywy2Fz5SfBNnuOxlYA8QTL/o4pLMWXOLxJJ/x3xnP8p
         aDAw==
X-Gm-Message-State: AJcUukeCGndviQd2+HD31qkYv1O7VfqZnxNZMPaS08VJ+nYoIvCjzgr2
        dFTgQNfx7EVkMG35rrT/4bwvUA==
X-Google-Smtp-Source: AHgI3Iav3VHNUIJsAi41EFCvRIAGyTy/XTqRbsgz/0HUw23NUf0m2LHc0TB3a03dK6zhA7BwCNWLNA==
X-Received: by 2002:a24:648f:: with SMTP id t137mr10457672itc.176.1548711345232;
        Mon, 28 Jan 2019 13:35:45 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u25sm13782077iob.23.2019.01.28.13.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:35:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: [PATCHSET v8] io_uring IO interface
Date:   Mon, 28 Jan 2019 14:35:20 -0700
Message-Id: <20190128213538.13486-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here's v8 of the io_uring interface. Various little fixes all over
the map, and addressing various review concerns.

No new features, but the io_uring_enter(2) system call grew arguments
for a sigset_t so we can support poll properly.

For a general introduction to this patchset, see previous postings or
the LWN writeup here:

https://lwn.net/Articles/776703/

No new changes in the liburing user side library, but as a reference,
you can clone that here:

git://git.kernel.dk/liburing

We're still missing a man page for io_uring_enter(2), but the two other
system calls are documented.

Patches are against 5.0-rc4, and can also be found in my io_uring branch
here:

git://git.kernel.dk/linux-block io_uring

Changes since v7:
- Rebase on v5.0-rc4
- Add grace period control for SQ poll
- Add IORING_ENTER_SQ_WAKEUP instead of overloading 'to_submit'
- Address various minor review comments
- Use in_compat_syscall() instead of storing it in the ctx
- Remove now unneeded compat system call
- Ensure nops appropriately serialize the cq ring
- Add sigset_t support for wait side of io_uring_enter(2)
- Stop using page_frag_free()
- Remove duplicate include
- Make sure sq thread and application can't stomp on each other
- Add array_index_nospec() limiter for p->sq_thread_cpu

 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2550 ++++++++++++++++++++++++
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    6 +-
 include/linux/iomap.h                  |    1 +
 include/linux/sched/user.h             |    2 +-
 include/linux/syscalls.h               |    8 +
 include/uapi/asm-generic/unistd.h      |    8 +-
 include/uapi/linux/io_uring.h          |  143 ++
 init/Kconfig                           |    9 +
 kernel/sys_ni.c                        |    3 +
 23 files changed, 2869 insertions(+), 41 deletions(-)

-- 
Jens Axboe


