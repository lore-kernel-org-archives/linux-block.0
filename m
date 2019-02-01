Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E43AC282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDEC218EA
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CwNT0ihY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfBAPYU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:24:20 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33203 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfBAPYT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 10:24:19 -0500
Received: by mail-io1-f66.google.com with SMTP id t24so6009822ioi.0
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 07:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=96NXxRNQjBufv6hafRepGIJMOEY1y+hhiggOWDOCzSE=;
        b=CwNT0ihYvWwpFXE1wNoq6DqcrZBxhHOWh5Y1h8mwjRmREWm4pyY696qi53LjVQWYu4
         TqNj6ElYIv2yx5JcsnPs7KD4qsoqOTADfAvaMnwAvsMJ4n8Tm/7iA11H7pPGiYWdSE72
         jMoWbJl78wraNUVWPe6pl+OXD1kjDtkdK9BLlD7sTnqxMYKB/TUJyOdoiD/SeZuzw+fA
         fnOze9WdYALbjdMozIq01GrxHPCZHJ0G21/ZTJu3Oojm29u+HFjLL4TMC0b1P3sq7cvz
         XRtfNC39J4FZs0rwfIP8pU76zaW48Jy/uFILzU9EvNDmDVkjU3Auxr/nbYJ3SXBJxdUD
         vLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=96NXxRNQjBufv6hafRepGIJMOEY1y+hhiggOWDOCzSE=;
        b=gGj6k5tlC+kO0tcD00xNqt+ebRlHBBeIR7LtIjHKe8to9SWVvnptyNEt58LPJOJmOy
         Z71mwWfbXwJ2e+vT6U1xGYQMdw5I/iTPKxFrqkfLOb3PuKHRWoUsMt6MTdym/us+ebN2
         72j2QK0lCxVJpNY3zCGyzW5IqAdV7tu5gy48zC2UN/eR8hzTfpRzv+IDDBvn72YX6DaD
         3lK/uCRa6tttE10kLxtuDYomJHyrnsR3ScnqcK861RgCD1Pkohz8mo9sn29TGuhePVP3
         NTJ19QzLduy7WJZr3IKlgy8jIvgg974cV3mMVYXcFSVhhOmnWD9Heo87RyZVDUB52e42
         W3iA==
X-Gm-Message-State: AHQUAubOhGf0ovhBWgSoCYXbTcDnE2hKK+lBTD+576fgBSywDC2PTPVQ
        XKDHh23ISKGz8x9OdKZB6sU3sQ==
X-Google-Smtp-Source: AHgI3IbZ9WSCHvNNOLLDiWtjJ9Hamv7WyzxHPwLTAxHpZczg5WIApMmiKpJ+hbQrWQS686FfnbKTIQ==
X-Received: by 2002:a6b:ce06:: with SMTP id p6mr7869301iob.189.1549034658685;
        Fri, 01 Feb 2019 07:24:18 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t6sm3388898ioc.87.2019.02.01.07.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:24:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com
Subject: [PATCHSET v11] io_uring IO interface
Date:   Fri,  1 Feb 2019 08:23:56 -0700
Message-Id: <20190201152414.23296-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here's v11 of the io_uring project. Main fixes in this release is a
rework of how we grab the ctx->uring_lock, never using trylock for it in
a user visible way. Outside of that, fixes around locking for the polled
list when we hit -EAGAIN conditions on IO submit. This fixes list
corruption issues with polling that some users have reported.

As far as I'm concerned, this project is ready to get staged for 5.1.
Please do review carefully so we can fix any minor nits that might still
exist.

The liburing git repo has a full set of man pages for this, though they
could probably still use a bit of polish. I'd also like to see a
io_uring(7) man page to describe the overall design of the project,
expect that in the not-so-distant future. You can clone that here:

git://git.kernel.dk/liburing

Patches are against 5.0-rc4, and can also be found in my io_uring branch
here:

git://git.kernel.dk/linux-block io_uring

Changes since v10:
- Rework uring_lock locking
- Ensure that async contexts lock when fiddling with polled lists
- Minor tweak to io_iopoll_check() continue looping condition
- Fold __io_uring_enter() into io_uring_enter()


 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2621 ++++++++++++++++++++++++
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
 23 files changed, 2938 insertions(+), 41 deletions(-)

-- 
Jens Axboe


