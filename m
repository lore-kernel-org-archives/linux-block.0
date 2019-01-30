Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C76FC282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 22:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29B1218AF
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 22:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WjGqJuvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfA3W4Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:56:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38331 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfA3W4Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 17:56:16 -0500
Received: by mail-it1-f193.google.com with SMTP id z20so1024367itc.3
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 14:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=esTI/cSwjY5Yw3YmqboEUl78rdBnCG5CFo2nywfTn3Y=;
        b=WjGqJuvhX8GgNtDVRgeUW2F94X0Jc3MoPt/kq5Fn/+PcYcscYURl2/G7vw/VJ3t2/3
         3lgPrHycHZdwNURIh1J+I95RmcppYM5nHtQZ6k8KbhPYrN6jJwC/u1urwsMdWJz5vOuE
         DVA/3tqyM84wW1b7U3EWOMXHjzCBZIuOwCiioLupa1Zlyllmwn1zChV1kmBg2Dm9nu3l
         A4aiGLKw70edxqQacer2BLLRoHiiKEB92I/DfEp/SQzCV5SZBQAS87DeIibcxNCko/+o
         cQrdxEm9Rnn3aiV2APe/nE6/IKdXFdEcKUD0gxoVSIaicTwVWleRBGNEjARc+SK2ELgU
         4/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=esTI/cSwjY5Yw3YmqboEUl78rdBnCG5CFo2nywfTn3Y=;
        b=lyQDtp2nG31dpit22/dnPEAyfZyuRYxnI5rPkYAr66KtEHyhpOJ/FGPgexNdDNljz+
         /UWEDhhbNrb9/UdeNZlPnd9VnHbrde7YrMMiI6ePpmy/P2N6KBnz3kT2VNEHHCaX5pgH
         9xIQlWA8GTVy4pylhPp8wuBpnR+DA9LHQyazPZipb5cHRzjdgOh+qckdKB+kZgLi78Oa
         Ry4REKQovDh+vi5UmsaBo3wKzk+4+zTMBDh8DuRugSmlX70m0vWhD451CGm/TL4uVwr5
         CEzHQu0a9jZWVJPFCcfsfaj2SsCBT3HEDXim//MCB5YvmqqhVTMUDL2VvWP79qGgYJHw
         okSQ==
X-Gm-Message-State: AJcUukdprzfTmtfeCN2uLZwPlzJOByhumgaY0ECbP9VnAz0Un5F54yn7
        2wAfAWwkI56lqyToJ+N/xqGLxpUZgsU=
X-Google-Smtp-Source: ALg8bN6SyArNyLl2NbX9BjPlW8DZLue99gDLjVTTBaKm+oNQvRdq7L+RbIwYWCZJxO3l9E+yYg4uQQ==
X-Received: by 2002:a05:660c:58a:: with SMTP id g10mr15664189itk.167.1548885344393;
        Wed, 30 Jan 2019 13:55:44 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 189sm1805081itw.33.2019.01.30.13.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 13:55:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com
Subject: [PATCHSET v10] io_uring IO interface
Date:   Wed, 30 Jan 2019 14:55:22 -0700
Message-Id: <20190130215540.20871-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Keeping the review train hot, this has all review comments addressed
from v9, with a few other fixes on top.

Outside of review comments, this fixes a few annoyances with the
SQPOLL thread. We now shut it down quick, regardless of idle setting,
and I got rid of the silly need to park it for exit.

Also fixed a case with SQPOLL where we'd get -EAGAIN due to request
shortage in the block layer, and we didn't handle that properly. Now
we do.

The liburing git repo now has a io_uring_setup(2) man page, but
otherwise no changes. You can clone that here:

git://git.kernel.dk/liburing

Patches are against 5.0-rc4, and can also be found in my io_uring branch
here:

git://git.kernel.dk/linux-block io_uring

Since v9:
- Use FOLL_ANON instead of checking vmas for file backing
- Fix bad nospec index limiter
- Address various minor review comments
- Fix drop extra file reference in case of submission error
- Fix race with sqe->opcode and "needs mm" checks without sqe copy
- Un-unionize io_kiocb->submit, from the async path it's almost
  impossible to do this safely.
- Clear io_kiocb->error for polled IO
- Fix EAGAIN for polled IO and SQPOLL for the !force_nonblock case of
  running out of block requests
- Remove need for kthread parking
- Ensure sqo thread exits as quickly as possible


 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2611 ++++++++++++++++++++++++
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
 23 files changed, 2928 insertions(+), 41 deletions(-)

-- 
Jens Axboe


