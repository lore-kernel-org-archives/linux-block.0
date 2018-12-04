Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61222C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25398206B6
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="y8odIUOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25398206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbeLDXhj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:37:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46354 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDXhj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:37:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so8993150pfe.13
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TVRjj3eSNfRG01uNYz+tlFRyZi8AZvJdWXKY5GkKMSI=;
        b=y8odIUOFP9wpSjR9+w6PVXqbbjaPTeoe1i84C3eKeTN7dfrWR07YZ3CbFXIvjgtUfD
         qdUgWsIUBooScC99wAnwWvmOm7DNKGAkIQr5qOPvxqE0M45Gx9vDzdQ5gCceAmAndO67
         ZhDqwby3hgHfDFNDg1d4IJHsw9E7xHYmiEYIh/4Vegy8Q6kEIZXqWM86P1YYrRnxKOcM
         5wx+TCUYXo2UEgVkUrZqxnTTS/SYJvJrjY5B9dmiT2VJSOERbO7EckODTZoZ/IKWsY4J
         6P+Hn1vtoJT6bk9xZgPe+7GD35CdmZ6amQ1fR0+cySZOmckk7/lf+zVNEHFaMRfwJR5o
         nNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TVRjj3eSNfRG01uNYz+tlFRyZi8AZvJdWXKY5GkKMSI=;
        b=fmY97I6y7aIjf4CiSR7Dw4oz7WFh8Y3O8/13VlvUNBFIb3LftvLbsdtyIqeNt9sFFH
         vBN2OciSFKRTLHlSINwnS9VpU+omuhOZ7WvEnZ03/LCAOzqWg+yop3ZpEN0NcNleyA3Z
         cFTTkBhnNvhI7bHsU46oTUKOTSYpxl0TNn69Ts/wpOV5bx7TGJ3QDBJhPY/WEmO0MLTn
         1nVjisgCozUB7IBozkc5vSwzZMD/Y3k3m7cqOHOYgo32xN69T/ZD7g6mOixYRpN2+EO/
         hW8BruHB1PN1AHY8xS8Fgdhwduk5LgYe57p8nSBn7l3GQjte5Khb3I8GIXGWxSkWWLFC
         kp/A==
X-Gm-Message-State: AA+aEWbKFdYtPlMV3BV83x1d+P4RSXyqZep9y40ewSzOd3wrrNuTruEn
        IL1+o50WU/SWlJwC5mwTSpWxLOCs0eQ=
X-Google-Smtp-Source: AFSGD/Xfjd4zqPiaHq+bSIvupkG93vNq/rrCZikq9c3d1mgPL+/U47ndEIcSFfsq20b4MPjfR4ZdOA==
X-Received: by 2002:a62:5658:: with SMTP id k85mr21929327pfb.231.1543966657213;
        Tue, 04 Dec 2018 15:37:37 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:37:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com
Subject: [PATCHSET v5] Support for polled aio
Date:   Tue,  4 Dec 2018 16:37:03 -0700
Message-Id: <20181204233729.26776-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the grand introduction to this feature, see my original posting
here:

https://lore.kernel.org/linux-block/20181117235317.7366-1-axboe@kernel.dk/

and refer to the previous postings of this patchset for whatever
features were added there. Particularly v4 has some performance results:

https://lore.kernel.org/linux-block/20181130165646.27341-1-axboe@kernel.dk/

New in this version is io_ring_enter(2) and a ring based SQ/CQ
interface. The rings are mapped from user space, an application can
submit IO by writing to its own SQ ring of struct iocbs, and get
completions by reading the CQ ring of io_events. This eliminates the
need to copy iocbs and io_events completely. It also opens up the
possibility of doing polled IO without any system calls at all, if we
add a thread on the kernel side... I've done experiments with that, but
not ready yet. Doesn't require any changes to the API. I can trivially
do 1.2M IOPS with a single thread through this, and 173K IOPS with
QD=1/sync.

You can also find the patches in my aio-poll branch:

http://git.kernel.dk/cgit/linux-block/log/?h=aio-poll

or by cloning:

git://git.kernel.dk/linux-block aio-poll

Patches are against for-4.21/block.


Since v4

- Switch to using ITER_BVEC for user mapped buffers.
- Drop unneeded import_kvec().
- Use RLIMIT_MEMLOCK as a cap on total memory pinned.
- Fix poll check with min_events == 0 actually checking for events
- Add REQ_HIPRI_ASYNC
- Add ring interface and io_ring_enter(2)
- Change io_setup2() system call to accommodate the new ring interface

 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    2 +
 block/bio.c                            |   33 +-
 fs/aio.c                               | 1440 +++++++++++++++++++++---
 fs/block_dev.c                         |   34 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |   10 +-
 fs/gfs2/file.c                         |    2 +
 fs/iomap.c                             |   52 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |    1 +
 include/linux/blk_types.h              |    2 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    5 +-
 include/linux/iomap.h                  |    1 +
 include/linux/syscalls.h               |    5 +
 include/uapi/asm-generic/unistd.h      |    4 +-
 include/uapi/linux/aio_abi.h           |   32 +
 kernel/sys_ni.c                        |    1 +
 19 files changed, 1450 insertions(+), 195 deletions(-)

-- 
Jens Axboe



