Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99E5C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DBD2229E
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RScvdXbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733250AbfBKTAy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:00:54 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40293 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732948AbfBKTAy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 14:00:54 -0500
Received: by mail-it1-f196.google.com with SMTP id i2so845906ite.5
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 11:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=t9pnRFLqXreqCqN6RFtoQkkuKLBMm2gpEZIYdIEJ2Eo=;
        b=RScvdXbLwNNU+U5djmvkle/9vOjRna/ogb+Y8AS2aKBO7SfmOnR5ZnM5ylOjLmMblB
         +jSdE85eLQqyO1sJk6/3t21XoTizjTOpuHVMUTj9HoLuAD1yLvX3slAsaiy37FkqVhIA
         CJRmDzzmLr23FBacL9j4WAZ9o1uxVfvBosHzf2R6PGOIbb6aJutcda4v4uRa3KVkVPot
         nYmou4n1Bj3NZDaFIJWXLaOgrLl2Enze6MqSvfR2FTeNju4q9WmUw0WscR1/c2qyIxUk
         iejlcJE5Usu/u4DsBxizatbGthN8kTNBULfyfg82176VxsI2yV6SFBGstegyZ+8pLzvN
         0hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t9pnRFLqXreqCqN6RFtoQkkuKLBMm2gpEZIYdIEJ2Eo=;
        b=a8zRiZQsrFf+YDJhXTvy8odSed5cSttbeqeAEu6xWecrWWV2tLAXxum74V6qKxhE5B
         YDF7O19imCJTl2i2v0FqL6GbxbbjLsaYYQJCXe8Inuo9qQcTV/wxX/UeUVl5gEaxAa1m
         uMRfI3Zo8Y3C/pCWJry3V4JUCldO72AnascsBQLxf6z/ySxJp93OhJNUftHkH2tbIWn4
         NOcuY9YgKSOXXxs3tjs0/IO1W9P+DWznjnwq+vrSLJhDjI2xviB2HjLStzHodbC/Q3Xd
         ZLbyc+5dxszXoveP4PwzzBA5zOEv3G/B7aJ0EJM8YR4HoDzwN+sAprkkArO+ZXhjW5Ce
         1nxA==
X-Gm-Message-State: AHQUAuZtibPplp/iNrGA8V77qgm72A6UXDfY12x4DAVCeoy+gOanuTDc
        +y/WK+8/yDDyPPJaQdEUsK6URw==
X-Google-Smtp-Source: AHgI3IbQULAvjuQutUcIaXAn2GVX990EdOj9WwmDQWSqEcNntypr8B5ZUaa58IKH+Ok/lIMU7FFivA==
X-Received: by 2002:a6b:b790:: with SMTP id h138mr15586243iof.114.1549911653292;
        Mon, 11 Feb 2019 11:00:53 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h184sm62446ith.41.2019.02.11.11.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:00:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
Subject: [PATCHSET v15] io_uring IO interface
Date:   Mon, 11 Feb 2019 12:00:29 -0700
Message-Id: <20190211190049.7888-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some final tweaks, mostly cosmetic, but also two important fixes:

1) Ensure that we account the skb appropriately against the socket.
   Some network config options apparently return is an skb with
   ->truesize != 0 when allocated with a size of 0, ensure we add
   those as references against sock->sk_wmem_alloc. Reported by
   Matt Mullins.

2) Ensure that ANY async punt of an sqe operates on a copy. We've
   already committed the SQ ring change at this point, we don't want
   the application inadvertently reusing the SQE causing issues for
   an SQE that got punted with -EAGAIN. This change ensures that
   whatever io_uring_enter(2) returned that got submitted, it's
   totally safe to reuse those SQE entries in the ring.

Outside of that, just cosmetic changes and additions of comments. I've
run this version in various torture overnight, using the various modes
(polled, buffered, sq thread, any combination thereof) and it's help up
perfectly. As far as I'm concerned, this is ready to get staged for 5.1.

The liburing git repo has a full set of man pages for this, though they
could probably still use a bit of polish. I'd also like to see a
io_uring(7) man page to describe the overall design of the project,
expect that in the not-so-distant future. You can clone that here:

git://git.kernel.dk/liburing

Patches are against 5.0-rc6, and can also be found in my io_uring branch
here:

git://git.kernel.dk/linux-block io_uring

Changes since v14:
- Fix skb/sock referencing if skb->truesize != 0
- Add comments on memory ordering
- Add comments on READ/WRITE_ONCE()
- Various function comments
- Align struct members of io_poll_iocb and io_submit_state
- Use io_fput() in two places where it was open-coded
- Make async context always use a copy of the sqe
- Don't reset s->needs_fixed_file for async context
- Rebase on v5.0-rc6

 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2920 ++++++++++++++++++++++++
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |   15 +-
 include/linux/iomap.h                  |    1 +
 include/linux/sched/user.h             |    2 +-
 include/linux/syscalls.h               |    8 +
 include/net/af_unix.h                  |    1 +
 include/uapi/asm-generic/unistd.h      |    8 +-
 include/uapi/linux/io_uring.h          |  142 ++
 init/Kconfig                           |    9 +
 kernel/sys_ni.c                        |    3 +
 net/Makefile                           |    2 +-
 net/unix/Kconfig                       |    5 +
 net/unix/Makefile                      |    2 +
 net/unix/af_unix.c                     |   63 +-
 net/unix/garbage.c                     |   68 +-
 net/unix/scm.c                         |  151 ++
 net/unix/scm.h                         |   10 +
 31 files changed, 3421 insertions(+), 169 deletions(-)

-- 
Jens Axboe


