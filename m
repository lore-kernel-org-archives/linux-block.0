Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0506DC43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B381821928
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bXJ/3NXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389705AbeLUTWl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:22:41 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37824 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbeLUTWl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:22:41 -0500
Received: by mail-io1-f65.google.com with SMTP id r7so498043iog.4
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=epzmYaIh4zMP0kDzLyJ8KFoNUE0GXvC2piAg5pPgvm8=;
        b=bXJ/3NXMvCHImsD5JYBlvmi5EjWtlIVvGtjj0nS9l2POWqXetcuSGoL03Dw0l6EMXV
         1b6YxdnbvMu7wKnqgDhnQ/DNqERmZme0WXMnH2cZ8Q6TG8ul3D+P5OauG1uu8EIGgb68
         Bjbh1n/xwpL9uOdVpuEWTWAIqy/LEMcOypEpZr9D5JwkMW7xl8IBHeROM72n5XTQhnlD
         GCfknzOXyNx0I5pNnksFjbUwSA2kxVCBip71IMU3xzfwrIu9KGHDaf57oxgZYPXpqxmT
         qpqGEmeGVl8uFQxvuvkpWOBc+PhvekN5EZas7c4nhRYEYALGpipLjXXYgpiD4gETBTI0
         +Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=epzmYaIh4zMP0kDzLyJ8KFoNUE0GXvC2piAg5pPgvm8=;
        b=fOYTeyTKvDnslyr8Y1+1uDI80cJrcosKmSGGEjDvIoCG059XCB/w4DHv8QgKOaSHgR
         lfUzz2UMgvfVGJQh4b2N7liq6Ykj/V9Vercp2alis9VyYCnPiNp33HWjd61//FK24X8X
         vaBL6lFDmxrnM/HN/b9kizSaiALho53yqSG7jpGrVewWEDfXFxjs0Txb+Zl5uKPE/PYU
         JjTogQ4Nhp5mP2KMbT+nvArFLaUpJRFb6uNCuYTnZ6X49TQRb9D+bW4R5pDtEulz02qo
         AeLvWfc0IraXGpCsrJW+sSOJLITuuf6FJqTERgJjKm1RXkjnccQgDKflmPWsvWFbHtO4
         zuVA==
X-Gm-Message-State: AJcUukfDMUeWm56xjU86KkxSiPH7H6KAWqbG0MACJQfMHmvby8a9lPEb
        YFTFGHppb6JPyiQ68ou3eByivgBDE3RLyA==
X-Google-Smtp-Source: ALg8bN7vAj9K0YjdeFgindlOrRiHjb2+NHujm91Ku02w62ab+LV9ZY/CSg/czZJZOdjFYVFnWKmILA==
X-Received: by 2002:a5e:834b:: with SMTP id y11mr423067iom.298.1545420159948;
        Fri, 21 Dec 2018 11:22:39 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:22:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk
Subject: [PATCHSET v10] Support for polled and buffered aio (and more)
Date:   Fri, 21 Dec 2018 12:22:14 -0700
Message-Id: <20181221192236.12866-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Going to be out the next week or so, but I wanted to flush out the
current series first. Mainly just addressing review comments, but
also fixing a few issues and just cleaning up the comments and
changelogs in general since some of those were a little stale due
to initial churn of the series.

See the v9 posting for more info:

https://marc.info/?l=linux-fsdevel&m=154514775822067&w=2

As before, find these patches in my aio-poll branch:

http://git.kernel.dk/cgit/linux-block/log/?h=aio-poll

or clone it here:

git://git.kernel.dk/linux-block aio-poll

and the code is based on my for-4.21/aio branch, which holds the aio
patches queued up for 4.21 already.

Since v9:

- Allow user buf to be a subset of the fixed buffer
- Fix __bio_iov_bvec_add_pages for partial bvecs
- Fold BIO_HOLD_PAGES and bio_iov_bvec_add_pages() patches
- Get rid of REQ_HIPRI_ASYNC, add helper
- Cleanup !CONFIG_BLOCK handling
- Update a few comments
- Update a few commit messages to reflect the current situation


 Documentation/filesystems/vfs.txt      |    3 +
 Documentation/sysctl/fs.txt            |    8 +-
 arch/x86/entry/syscalls/syscall_64.tbl |    2 +
 block/bio.c                            |   59 +-
 fs/aio.c                               | 1952 ++++++++++++++++++++++--
 fs/block_dev.c                         |   20 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    6 +-
 include/linux/iomap.h                  |    1 +
 include/linux/syscalls.h               |    4 +
 include/uapi/asm-generic/unistd.h      |    4 +-
 include/uapi/linux/aio_abi.h           |   47 +
 kernel/sys_ni.c                        |    2 +
 20 files changed, 2014 insertions(+), 186 deletions(-)

-- 
Jens Axboe


