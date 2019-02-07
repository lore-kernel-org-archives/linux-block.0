Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5785CC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8432173B
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="O4VTT0DA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfBGTz7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:55:59 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38046 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfBGTz7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:55:59 -0500
Received: by mail-it1-f193.google.com with SMTP id z20so2937822itc.3
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=g2xc1nw84AxkDuPsydMqw35Ze0BbEN8TxzeA3ef4ACY=;
        b=O4VTT0DA4VZmQjpugswmufrKF16aZoXxvclm0R+WcaOxU+2V4N28sW3xcgUvmO+ZW6
         2wLoOIahw2fpyxf0v6Mr4bNVjfBAGcLDFJj/XNoKfcXn2b3RWoPxsATDKlAY/lQ2g7aF
         YLZIcI0bHJzSj7yW/uQSj20bByw9OsYDvz4v/4DPtjCwG2gq+xAoxtdQvMJr0/rveuKJ
         o5CBD1gnxiGTrO/0YVwTzQWYhLjTs9u6LcprrXzeQVagdmse/bHgKV0yYzznUmZw6UZo
         JnP+LjDKDtJD/WiCvLJ+6pjQbF6WiO5htTv5Dd8KrrzWBHIcRZU9ypadMtGcFvQTXN7F
         iEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g2xc1nw84AxkDuPsydMqw35Ze0BbEN8TxzeA3ef4ACY=;
        b=CViXqt9ncZYP1zdfnVBxD0WmAHCAJ3uTla+TgtHuO7y6fSqy5ny2JUhzsYuyVnYsiB
         ayiVwQCx4FPDwAXY/iTYomBbvj7g549fhpv5IOMSqjHD9R+JP75rOjoemlpTafWX8BCp
         i5X5hKO7KfwcCtCja02i7ouj7hCPpzsoDfYTaj2lQSpwi2c9yhRu7u0Dc+gcR2qnXzo9
         H+VVhXHaHIzG41bKisk3rkhTuiSRIxBfSXnY2eBEtuXevf2vS0qI135TAnGPoRRCyp9W
         EficPwUjZw+5eslGhatGud8mT6E0OeAXd+P3J0EwrqwpzwSWsn67MuipIFi0lWxO+ktA
         IIEA==
X-Gm-Message-State: AHQUAua6K6hLaRs2y3+GkCegyWSoDL9GjoqrYQPVqZbU0FPaTUWLHsRu
        /dSwGR1Nqeeqn6Dm5t0EIh3G7JrNBKDICA==
X-Google-Smtp-Source: AHgI3IZRQXyzMcuho4ieM4BiG4jWMYM7vATNoXw+DITmsnjQ1KKIJIafQK2JknuqfiY+bZCV/XHqMg==
X-Received: by 2002:a02:9c6e:: with SMTP id h43mr4734032jal.46.1549569358351;
        Thu, 07 Feb 2019 11:55:58 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y26sm5092782iob.16.2019.02.07.11.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:55:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
Subject: [PATCHSET v12] io_uring IO interface
Date:   Thu,  7 Feb 2019 12:55:34 -0700
Message-Id: <20190207195552.22770-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here's v12 of the io_uring project. This is the Al Viro special, where
Al tries to beat into my head how UNIX fd passing will mess you up. I
think we have all cases handled now. I've added the resulting test case
into the liburing test/ directory.

Outside of that, various little cleanups and fixes, and a revert of
using FOLL_ANON to map IO buffers. This makes it fail with huge pages,
something that we can (and do want to) support. We're now back to just
checking for a file backing in the vma.

As far as I'm concerned, this project is ready to get staged for 5.1.
Please do review carefully so we can fix any minor nits that might still
exist.

The liburing git repo has a full set of man pages for this, though they
could probably still use a bit of polish. I'd also like to see a
io_uring(7) man page to describe the overall design of the project,
expect that in the not-so-distant future. You can clone that here:

git://git.kernel.dk/liburing

Patches are against 5.0-rc5, and can also be found in my io_uring branch
here:

git://git.kernel.dk/linux-block io_uring

Since v11:
- Get rid of the need for storing a files_struct
- Protect against release loop when UNIX fd passing is used
- Retain kiocb state for EAGAIN async retry
- Cleanup io memory accounting
- Revert to using non-FOLL_ANON, as we do want to support huge pages
- Fix uid leak
- Address various review comments
- Rebase on v5.0-rc5

 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2741 ++++++++++++++++++++++++
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
 net/unix/af_unix.c                     |    2 +-
 net/unix/garbage.c                     |    3 +
 26 files changed, 3073 insertions(+), 42 deletions(-)

-- 
Jens Axboe


