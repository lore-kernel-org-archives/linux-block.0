Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D85DC282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9832184C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PsIFwtCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfAWPfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:35:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39213 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfAWPfm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 10:35:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so1229416pgl.6
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 07:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=F0ISlZr0XMW6187v57dfxwlwJzMc71qg9UaLqbnNVS0=;
        b=PsIFwtCZmYAIAU00oVzSbaR3zyw/r6cSMGsB4sUYSnNMZnHwH7GERXRKw0/G2xG0Po
         1GJrNddx8Xt9pL24x+zqppkhGfZyQIUFD0WyaYFdP3vBZXNg4lZ9ERmjFWDft3NAd3K6
         oCp+/U5UWCpnZBHIps7ASrJvLwBMmmc+7KuJaIisFj66ZVTuU25USfYP3JmxTdJoo+3Y
         esTLhePMou5n2egLzQ35qBNTjvHOcIUuJgiGp04iU3Ki3BPBmTBZJwRU2v1bztwjcd/k
         dv+EkAVnAPjFB9sP1vpWHjKtfZwY6Qpngc8Om8OjFCLKMYQt/0zbxQn/wDr7eDpg+xJQ
         +dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F0ISlZr0XMW6187v57dfxwlwJzMc71qg9UaLqbnNVS0=;
        b=a3EGy2gBDz4wEfXrqqlZ15/5ELcxof+DBb6OM2T+AeQ1v8/R2+1Rgt884r340t7GzW
         qXTspMLAPQLpzcHM7XcYwzV7y2NDHhDU6/Dczfrjg4hQvSGZKJzj1LuNoT6679e8YBdt
         99xEsGDluOfpem8AvfqPks/wS6g+8l4q8exoT1ocHnF/+qPO6JYQ62JUQNkIunh/+8fq
         N8XpEnuNFIlOCXnxZtr/e+x4cYOpnuXCyQktDJiTicOQJ7UfOTcU8jliqZR15bZhkcJv
         JKqgKyD0vTq1ybKOsJddLHxBU8Jueb+lJok2w/UnzkiF8mQxyg4O5NVBq9BwCTQgMlRD
         JoqQ==
X-Gm-Message-State: AJcUukfcAGoVsCmV1rAAXGjbhHy7/grAL6X5AyQzXI2kxULM8AvTLsim
        J0zDxhtYxZgZCoW3zKENDGnVcg==
X-Google-Smtp-Source: ALg8bN72eSxnP5mHQXJLPaJZE8B64IFJtbYnB0Aab4bjN4+TE5AjjfW/95MssALzQGk8R8TsXT9i6A==
X-Received: by 2002:a62:9fd9:: with SMTP id v86mr2373768pfk.191.1548257741053;
        Wed, 23 Jan 2019 07:35:41 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm30731715pfl.16.2019.01.23.07.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:35:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: [PATCHSET v7] io_uring IO interface
Date:   Wed, 23 Jan 2019 08:35:11 -0700
Message-Id: <20190123153536.7081-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here's v7 of the io_uring interface. Not a lot of changes this time
around, mostly corner cases and error handling that hadn't been
exercised yet.

Only new "feature" is an improvement in sequential buffered IO
performance. This is done by piggy backing on to existing async work if
we're sequential to the previous work item, and it hasn't finished yet.
This greatly reduces the overhead, context switches, and increases the
performance a lot. Using io_uring-cp, as test program that does cp with
io_uring, I saw a 5x improvement in speed when copying a large file.
It's now faster than plan 'cp.

The x86/x86-64 system calls were renumbered, so if you are testing,
be sure to pull apply the renumbering. The fio and liburing repos have
been updated.

The liburing git repo now has a man page for io_uring_register(2),
thanks to Jeff Moyer. Outside of that, not much activity there since
last time. Clone the liburing repo here:

git://git.kernel.dk/liburing

Patches are against 5.0-rc3, and can also be found in my io_uring branch
here:

git://git.kernel.dk/linux-block io_uring

Changes since v6:
- Fix leak of iovec in write path for larger writes
- Fix CQ event filling for error handling of workqueue buffered items
- Improve sequential buffered IO performance
- Fix leak of accounted mem in error path for io_uring_create() (Roman)
- Rebase on v5.0-rc3
- Check for entries == 0 in io_uring_create (Jeff)
- Renumber system calls so they are ready for Arnds unification

 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2540 ++++++++++++++++++++++++
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    6 +-
 include/linux/iomap.h                  |    1 +
 include/linux/sched/user.h             |    2 +-
 include/linux/syscalls.h               |    7 +
 include/uapi/asm-generic/unistd.h      |    8 +-
 include/uapi/linux/io_uring.h          |  141 ++
 init/Kconfig                           |    9 +
 kernel/sys_ni.c                        |    4 +
 23 files changed, 2857 insertions(+), 41 deletions(-)

-- 
Jens Axboe


