Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB62C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D93A20989
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="On+4Uinf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfA2T1H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:27:07 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39694 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfA2T1H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 14:27:07 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so6399487itl.4
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 11:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=5xJW0HuLHftgv+x4p++VHZmQ83Mep4USFSKzRZ5bjkU=;
        b=On+4Uinf4WxL2frE9gmzOzJRoeHQnRXbzB3s64CesCnx6siSaBROa/LLVtOk96Icuh
         AMuOegfF3vfdYIGQuyzMbkxre4efAQ+1gYDSwBGq9AGdYhCxwXQJf7XuCU5+M20UocI7
         Eh0B0qxhWZvLpq+5tQCK+wzc/dCn6bcIqcVk9qC7QXcFL2eX3EhJHY9+iLBilbA9WKx1
         B3qh1COnqBCllXGf0BNOtqNW5XawxWPSj1RkvGhBaiw+g0y0xS8Y8bBBPyMFh+sYMJ+W
         GQmm9TsAVgObShpQr3QaAD7AF2KVwgQgskwBWrYnm9H1eZ0g3XnW7apl/V3Ka+LTxWS+
         2xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5xJW0HuLHftgv+x4p++VHZmQ83Mep4USFSKzRZ5bjkU=;
        b=XfuMLqrBI+4AyVuvCEPAuprLpstY6IF8dgl8D0oUOqJvnBzsqEHXCrzKWNmg6Q0h42
         Py7xgSVk3P2NJCiE9NUyVh+ZVydK4kHAgIOLo3+wZ2ddZPzrEQL1oOK5ZDow+qAobwaB
         h2WyA1kAige/FOdZLgTEUAIPVDfWPxx62ICBBftUe2xQuk/dQnFI90ErpOgVXtkSoE2G
         kgb/lJ3f914L0DEOTL1jDCLV/qL8eyYKfKqMhzCwB5G+/N7IE2EevNXKLIsAaW1FeD+E
         EwFmTu7xF2voFd5aXTUFOXXu9aq+4V99cBq7Tq0IjQ4K3ju9jGzkNOY2uxLRJGctqWb/
         28Hg==
X-Gm-Message-State: AJcUukdmLejYTny4HvfIW60HD0QBHwEQ6JjBOiCi6AbHhYvQKiL2edg2
        WZqrrotAxHVrtiKxsSusX9sz4Q==
X-Google-Smtp-Source: ALg8bN4k2OdBQRRdfNGRcuzjLVLV6xzbltGyav3ngf5FjWfO57wJJdKGiMvFKRzodKV4BBgJHLieug==
X-Received: by 2002:a24:6b90:: with SMTP id v138mr12712592itc.86.1548790026446;
        Tue, 29 Jan 2019 11:27:06 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y3sm15223203iol.55.2019.01.29.11.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 11:27:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com
Subject: [PATCHSET v9] io_uring IO interface
Date:   Tue, 29 Jan 2019 12:26:44 -0700
Message-Id: <20190129192702.3605-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Following up on all the great review from yesterday (and today),
here's a v9 that addresses all known review concerns so far.
A particular big thanks to Jann Horn for looking into the grittier
details, which resulted in a slew of fixes. Also thanks to Christoph
for working through the patches. I feel like we're making good
progress here.

A note on ctx->compat still being there - we could store this in
struct sqe_submit, but this doesn't work for the io_sq_thread()
polled submission. Additionally, makes more sense to keep this in
the ctx instead of once per IO.

No new changes in the liburing user side library, but as a reference,
you can clone that here:

git://git.kernel.dk/liburing

We're still missing a man page for io_uring_enter(2), but the two other
system calls are documented.

Patches are against 5.0-rc4, and can also be found in my io_uring branch
here:

git://git.kernel.dk/linux-block io_uring

Changes since v8:
- Check for p->sq_thread_cpu being possible
- Check for valid flags in io_uring_enter(2)
- Cap 'to_submit' at SQ ring size in io_uring_enter(2)
- Fix files/mm references
- Don't bother with ctx referencing in io_uring_register(2)
- Use READ/WRITE_ONCE for ring updates/reads
- Use percpu_ref_tryget() for io_get_req()
- Protect sqe reads (that matter) with READ_ONCE()
- Store compat syscall info in the ctx. Still derived from
  in_compat_syscall(), but we need access to it from the io_sq_thread()
  as well.
- Don't make IORING_MAX_ENTRIES user visible
- Address various review comments

 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2599 ++++++++++++++++++++++++
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
 include/uapi/linux/io_uring.h          |  141 ++
 init/Kconfig                           |    9 +
 kernel/sys_ni.c                        |    3 +
 23 files changed, 2916 insertions(+), 41 deletions(-)

-- 
Jens Axboe


