Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCCEC282CC
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07F22082F
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WjHgZpFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfBIVNx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:13:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42805 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfBIVNw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 16:13:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id s1so3343526plp.9
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 13:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jqhv2GtMMjpy4yyWvM9h22WNHaYioLw28MkDKYPSD2M=;
        b=WjHgZpFhBFcUSQnxIYGoaP13uR3U0LjOCmo02U3B42+QoP55o7N70aoxKKfUvOfFFi
         QNdW+8cks58joW1viKAMsUZ5uHp+z9hzvjMusFVFfs7GnO/9kPmkR84GCVzb2kTLyIsr
         Uw5HLRWnvZGvrwtCjL81smNvZX6+2M7s7midnyBYXww7mLnke/kVSdX6IttoEVPHWgIY
         vcghia6cpuxPBGLjNerADhuZNQe/+FkXun1/kw02FIDFXn2LXpSXio4ghs5BksP1cazL
         N6gfwxE7BOJSe2Kgrcl0Wyzk1ttnTXDFw/chbqoI9pw9ZEF/ak5BIPx90OyNoZTX5bUU
         ehNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jqhv2GtMMjpy4yyWvM9h22WNHaYioLw28MkDKYPSD2M=;
        b=ps6Fo9tqkw3buRJwlFsklff4r5tluy0lQk7ZihpgBJWu1rInWImQDBmGLDZTcVz0NC
         deH6wlqiSEDWZyPNiLg679VgWhQcXlLCceBknV4c5Pr6T5IvxzTjz5X90G0Q7MwRBAYn
         5FFnWKcsPsB3fBCKydkXOxVJeVGilrCE5fpY5UPJWXr2e8sWc5MkphxnBfD4R2uqH/pV
         0oGwXwcgxTRhxl4KMabw/vx0bkP5PUjRZzsYFcjY1IKol+4omKsQ8Op1WGSAGQ2z5hcX
         NnHoaf/aQmcpR8HZU6G7mF3GEiR7EhvUJhVK8aBZ3cGVjJUhrxvIex3hmuD+6fiVjbin
         3zhQ==
X-Gm-Message-State: AHQUAua20ta/HEZ7JJOMhlgxbZ06+3fBiSXrGcOu4V+IHohOfokAiHCK
        hLrPDlUtkZ4JsBPmfDEZyMF8Qg==
X-Google-Smtp-Source: AHgI3IYkQVpDXPvntKdEoHL5CiXMUi0yHnI6Xi7/Gw5FLlIMPpltKBX+NFTdatEIyf5K6WGPe5a+pQ==
X-Received: by 2002:a17:902:7588:: with SMTP id j8mr30367740pll.215.1549746831741;
        Sat, 09 Feb 2019 13:13:51 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a17sm7004942pgm.26.2019.02.09.13.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 13:13:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
Subject: [PATCHSET v14] io_uring IO interface
Date:   Sat,  9 Feb 2019 14:13:27 -0700
Message-Id: <20190209211346.26060-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Another day, another spin. This is v14, and it fixes a few silly
issues with fsync, mainly, but also various little fixes and tweaks
all over the map.

The liburing git repo has a full set of man pages for this, though they
could probably still use a bit of polish. I'd also like to see a
io_uring(7) man page to describe the overall design of the project,
expect that in the not-so-distant future. You can clone that here:

git://git.kernel.dk/liburing

Patches are against 5.0-rc5, and can also be found in my io_uring branch
here:

git://git.kernel.dk/linux-block io_uring


Changes since v13:
- Use READ/WRITE_ONCE anywhere we touch the shared data
- Cache if we need to account/unaccount memory
- Fix fsync file grabbing
- Fix oops with fsync and deferred async list
- Fix final fput() of fixed files AFTER adding to socket
- Use correct iterator to free fixed user bufs
- up/down_read() for mmap_sem when mapping buffers
- completion -> complete in Kconfig help entry
- Ensure malicious app can't trick NOP into leaking a file
- Add a few comments, address a few review comments


 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2853 ++++++++++++++++++++++++
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
 31 files changed, 3354 insertions(+), 169 deletions(-)

-- 
Jens Axboe


