Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06465C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF9920665
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mMktypjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfAJCoM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:44:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43140 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAJCoL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 21:44:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so4589268pfk.10
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 18:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=CCcyBncwVzdWqipRqNN4klGIvSLcprj9iOTQQ+ShfQE=;
        b=mMktypjV6CGigi37iJzpIIloM0ywqzBUbisH/JH77ayexNBVMDAFsjswD1d+udFNoR
         ztXxJ/TXxDF+sUMDtpq/p9a4TigyaN2ABpnmvfGMsnO+x6v+HRJoPUGiPCJ12T20VxKJ
         9s9pFjxWuZHbWypwp2bfpkhK1DKm996eyHkMivVITWEjln3nKPwyV/W3eSA3EHAeVMBp
         eXRRv6e08hiCBJAb95YqDDPoUCjQULLaxLf0NsZ6PVqEeo9ch3xEyiuyU0EM3rAlzSQI
         t4vGidnTWhxbBde76NDw9wxBkfSDRM0jxmQ04QUHAvZLiHFQHKR/rzJ0pGEqFXVHhLuw
         NRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CCcyBncwVzdWqipRqNN4klGIvSLcprj9iOTQQ+ShfQE=;
        b=Tf7LnURNd3NNQeV40E5/HtRuLELw5Nccf5vdcNL3Qy2+M3gdo1Gb6jYBOx2Fh3/tyL
         vs2L+6Ey9nprmMK3Jz3NbsEAWHQbeJN3z9FAFKv/HF0y0IDXxBIJ2Ez0LtqPOKxzw3Qu
         /bg/rK5DvYbN7a28wwfmQNtSehyYzPowl1L06m9Ual8+odQ2gEVSrGR7ox6WTJDt9Lp6
         zFCHvSkQdNeIJWmiGhCEaD4ffgHQqHgmG3+S9m95bwW8JMTPB9yj34RP8PP7K37j4T86
         K8LYVENEIk1SaLluWC6LGTeRVCNYwTvLgm8eVzgnxH6/Rlj3ThWu38+OLktpYI95cO3z
         BZHA==
X-Gm-Message-State: AJcUukdhrusWFoPktCQYid1jZiTtfIrEcLmFwcqb9PjV1J5JvySiu7Dy
        sNaU9kdq4ljgQfx/2+bVQUwpxA==
X-Google-Smtp-Source: ALg8bN61hfSGmNYHxIFQQBtDVRjwgR4dxoud4EStO8tSLlhzisdKMLdXhZCQJkKpEn7ovUG4ZV2QeQ==
X-Received: by 2002:a63:b34f:: with SMTP id x15mr7834295pgt.243.1547088250785;
        Wed, 09 Jan 2019 18:44:10 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm105799631pfn.94.2019.01.09.18.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 18:44:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: [PATCHSET v2] io_uring IO interface
Date:   Wed,  9 Jan 2019 19:43:49 -0700
Message-Id: <20190110024404.25372-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here's v2 of the io_uring interface. See the v1 posting for some more info:

https://lore.kernel.org/linux-block/20190108165645.19311-1-axboe@kernel.dk/

The data structures changed, to improve the symmetry of the submission
and completion side. The io_uring_iocb is now io_uring_sqe, but it
otherwise remains the same as before. Ditto on the completion side,
where io_uring_event is now io_uring_cqe.

I've updated the fio io_uring test app, and the io_uring engine. The
liburing git repo has also been adapted to the various changes since the
v1 posting. As a reminder, the liburing git repo contains some helpers
for doing IO without having to muck with the ring directly, setting up
an io_uring context, etc. Clone that here:

git://git.kernel.dk/liburing

In terms of usage, there's also a small test app here:

http://git.kernel.dk/cgit/fio/plain/t/io_uring.c

and the liburing repo has a few test apps in test/ as well.

Patches are aginst 5.0-rc1, but can also be found here:

git://git.kernel.dk/linux-block io_uring

Changes since v1:

- Fail IORING_OP_{READ,WRITE}_FIXED if not configured
- Fix ctx drop ref issue on failure to close ring_fd when sq thread/wq
  are in use
- Move to separate Kconfig entry (CONFIG_IO_URING)
- Add SPDX headers
- Drop gcc ism of zero sized arrays
- Rename io_uring_iocb -> io_uring_sqe
- Rename io_uring_event -> io_uring_cqe
- Drop needless io_event_ring and io_iocb_ring structures
- Drop ctx->max_reqs, use ->sq_entries
- Drop unused ->ring_lock
- Drop io_ring_ctx slab cache
- Fix state batched kiocb alloc failure to put ctx
- Fix missing write ordering barrier when filling in the cqe
- Drop io_req_init()
- Various renames
- Fix a few lines that were too long
- Address other minor review comments
- Fix IORING_SETUP_SQPOLL being set without IORING_SETUP_SQTHREAD
- Drop IORING_SETUP_FIXEDBUFS, iovecs being non-NULL is enough
- Fix error handling free of ctx in setup path
- Change standard read/write commands to be iov based READV/WRITEV
- Pass in struct sqe_submit instead of separate sqe/index everywhere
- Fix reap of polled events on fops->release()
- Lock uring for sq thread polling
- Don't grab ->completion_lock for polled IO cqe filling
- Fix ev_flags vs flags typo
- Consolidate parts of the io_ring_ctx alignment

 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    2 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 1890 ++++++++++++++++++++++++
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    6 +-
 include/linux/iomap.h                  |    1 +
 include/linux/syscalls.h               |    5 +
 include/uapi/linux/io_uring.h          |  114 ++
 init/Kconfig                           |    8 +
 kernel/sys_ni.c                        |    2 +
 20 files changed, 2163 insertions(+), 39 deletions(-)

-- 
Jens Axboe


