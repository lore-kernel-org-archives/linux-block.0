Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8547DC43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDE920896
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xqirShNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfARQMe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:12:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39326 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfARQMe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 11:12:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so6815540pfc.6
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 08:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=61povrd1ttKvrmraQY7nV3Ej8+f2a79KcHlyUya/OTk=;
        b=xqirShNapZsaA3Rg1CadrJOnVn1hSlxqLtNRl0/V6WlnGgwQTb8Z0Ri1IuzxpbLIFe
         WoF9gC7vyTn0LEtneV4dWy5/twjn44iv503inh+p7dajcaBMYplCCgDQnfbC0hGNFr5W
         Vk+aqLYBtg5GIW9MFaWRAc8oeY5SI8EHWtI+IyQ84aJgOZ/0Hiu5Wi/HxD/j/7wUaAXg
         s9ZEt8YrEPtZSlae7nvHNlxbYI9OnKXGFhHqeN618usTFhuKE1bkRT2op/Rm5dGpP0IS
         DpIu/TVFsIA1cYzqBfPmvoBC4D5qkwLmc9SCrgv5tsiADGRzmxQgwC9ifwS+w0J1xQpt
         JSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=61povrd1ttKvrmraQY7nV3Ej8+f2a79KcHlyUya/OTk=;
        b=UynkhWZ3KzQ/0y1vY4dKzNSDeJzqK83+rzS9hkMevfYsu/7y/wP2p57+w5D13g6VHN
         svKh/zb6AKz/B4j5/sHHG4C6eGZRk31YWTeGOUYzo5HG2kKdJJSarPLy5M/El+YJDVSo
         Gcuuu90RsmoQZ/H5Wf7miUiuDtgdp0F7nhY3r/CUxh5+rcfK7+EGeqt1nKTVaTJtjwHs
         45RhCd8o26yXGGfNeeB314b5yyqeeHp16eSITBV5sTDmuaUBcBhECpbucq/bw9bLV4Iy
         riMFqkChZ3IQHqXGPRqYQnzLYPmchsaab5izZ+rK4grP761pNAv/owkGyOo+lEtKVmyy
         dsoQ==
X-Gm-Message-State: AJcUukdLxzYZWUccDRf95PR1nX04N5lX3VSR3xiGEJx/Yro0SWz3i0vt
        5WA7Ol137PwdzfWJAaI8TDyJtw==
X-Google-Smtp-Source: ALg8bN5racFIDgNRtcYrCBFK32Di+GgNfXCMFFOu4otVA03Ibv/AVjNobgyByy7nySQd5ji9jPZtrg==
X-Received: by 2002:a63:5026:: with SMTP id e38mr18340348pgb.123.1547827952999;
        Fri, 18 Jan 2019 08:12:32 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m20sm5317804pgv.93.2019.01.18.08.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:12:31 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: [PATCHSET v6] io_uring IO interface
Date:   Fri, 18 Jan 2019 09:12:08 -0700
Message-Id: <20190118161225.4545-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here's v6 of the io_uring interface. Various tweaks and fixes to the
internals, especially in terms of the application facing API. See
changelog below for those.

In terms of features, the ring_fd (returned from io_uring_setup(2)) is
now pollable, so you can use poll(2)/epoll(2) and friends to get
notified of completions.

In the same ballpark, I stole the IOCB_CMD_POLL feature from aio, and
Christoph massaged it to better fit the new API. This means we now have
two new commands:

- IORING_OP_POLL_ADD. Adds an fd to poll for. A cqe will be posted to
  the CQ ring when the desired events are available.

- IORING_OP_POLL_REMOVE. Remove a previous queued POLL_ADD.

The io_uring instance is now accounted fully, and will fail if we cannot
get enough memory under the RLIMIT_MEMLOCK limit.

The liburing library has grown a few test cases, and now also the
beginnings of man pages for the project. So far we have
io_uring_register(2) documented, io_uring_setup(2) and io_uring_enter(2)
should be coming shortly, as well as a io_uring(7) man page. Thanks to
Jeff Moyer for leading this effort! Clone the liburing repo here:

git://git.kernel.dk/liburing

As usual, patches are against 5.0-rc2, and can also be found in my
io_uring branch here:

git://git.kernel.dk/linux-block io_uring


Changes since v5:
- Limit fixed buffers to UIO_MAXIOV (was USHRT_MAX)
- Limit fixed buffers to non-file backed memory (Dave Chinner)
- Fail file/buffer registration if already setup (Jeff Moyer)
- Return -ENXIO for attempt to enter dead ring
- Reorder two patches
- Cleanup some patch dependencies
- Add support for polling the ring_fd (poll(2)/epoll(2))
- Add IORING_OP_POLL_ADD/IORING_OP_POLL_REMOVE support
- Limit io_uring SQ size to 4k entries (IORING_MAX_ENTRIES)
- Check sqe->flags validity in one location, not for each opcode
- Account ring memory in RLIMIT_MEMLOCK
- Re-init completion event after io_uring_register()
- Fix SQ thread missing submission
- Fix silly use-after-free in io_free_req()


 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2376 ++++++++++++++++++++++++
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    6 +-
 include/linux/iomap.h                  |    1 +
 include/linux/sched/user.h             |    2 +-
 include/linux/syscalls.h               |    7 +
 include/uapi/linux/io_uring.h          |  141 ++
 init/Kconfig                           |    9 +
 kernel/sys_ni.c                        |    4 +
 22 files changed, 2686 insertions(+), 40 deletions(-)

-- 
Jens Axboe


