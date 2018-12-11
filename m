Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039BEC04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F0D2084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EC0gwupA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F0D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeLKAP7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:15:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39110 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeLKAP6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:15:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so6197542pfc.6
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XoZHLPT0XezLKUrzAElv5quEPn1BtSxp18WMNpWYuio=;
        b=EC0gwupADKJIDWzEP+ABEY+b8zl6CQub4vC1aO2QeoTYVDO4Dbxxm/k3t0/xNX1rDo
         pqrOderk74hdSv73H/n+gHD7bSDPN7V72gRWTKSWOm7XyRDvlC+cbEses9qiLJXbSY1b
         sdFWfJYA7GcAKFELQges+rDzXmtM7//uxidE6CPrp2H7QWsIO/ALPgtUBgZe5wtL/8pX
         OHTXsuBTx+bA6keE9j9ICDBFAUZHGyDBrYYoLeQn+8cr9gu0GrdTieWkcFK5fd6Kc+PU
         vJZrEfK/88cf0k8FhvZPmP1VOK4gJSHCk5ADIwn7/nfpJdYTucFxINiupCCD8HvqNHJb
         1tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XoZHLPT0XezLKUrzAElv5quEPn1BtSxp18WMNpWYuio=;
        b=OLlffbh/xvbtXWhekaw/IdZPntGdbb4mfd4Vpy/a4uxymdb988L+Xc/sE9qHgEFvl1
         MqHuQ5m8KPzV+75ozmx7JAkFrdTeizNGTmMyhxNvQ3W/1i7wZehcKD9xgi7St8wSgtq9
         Ht3qByfXuA+4FN4IWPuiFo0AGA+P8BcokE5b8AzbYYFVFux3VLYIrn3EKOq8aIOWhiTv
         viO3fVw/oK1GkfzOmOruOT5b5Sakgpyw0QH88PbSNxGqKrjdY6GdLP9DX2ahhLzY8JIX
         jJ8nJAAt2QC8RfxpCY7D5VX5BKDwdDMbzIMBz7ytBwlSG1Vv0q7SRu9MLFv7mkqVYDXG
         efEA==
X-Gm-Message-State: AA+aEWY2BYstKhPuIWLRJaViegbDMNHCXi5693KXRuvupk3xehNPlK1o
        7H29j0WqZGr8shH8qE9YxJX4NobISBRkjg==
X-Google-Smtp-Source: AFSGD/WWgQHOmR8/nMyev/BgToj5YuVnM5QksL8v8oStc9//HvIbo6HSgPhqot556+TA3T9IP1p13g==
X-Received: by 2002:a62:5658:: with SMTP id k85mr14154414pfb.231.1544487356993;
        Mon, 10 Dec 2018 16:15:56 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:15:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com
Subject: [PATCHSET v7] Support for polled and buffed aio (and more)
Date:   Mon, 10 Dec 2018 17:15:22 -0700
Message-Id: <20181211001549.30085-1-axboe@kernel.dk>
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

See changelog for other changes, but this specifically adds support for
kernel side backing for the SQ/CQ ring interface. There are two modes:

1) IOCTX_FLAG_SQTHREAD. This adds a single thread backing. Right now
   this needs to be woken up through io_ring_enter(2), but I'm also
   planning a polled mode where an application can submit IO without
   ever entering the kernel.

2) IOCTX_FLAG_SQWQ. Like SQTHREAD, this adds a kernel side backing for
   IO submission. This one uses a workqueue, so we can have higher
   levels of concurrency. The main use case here is buffered AIO. With
   this, we can support buffered aio with QD > 1. For cached data, we
   avoid doing a workqueue punt for reads. So those should return
   without any extra context switches.


Find it here for your cgit browsing:

http://git.kernel.dk/cgit/linux-block/log/?h=aio-poll

or clone/pull from this branch:

git://git.kernel.dk/linux-block aio-poll

Since v6:

- Add support for async buffered IO, through kthread/workqueue backing
- Rename aio_kiocb flags
- Comment new syscalls
- Bug fixes

 Documentation/filesystems/vfs.txt      |    3 +
 Documentation/sysctl/fs.txt            |    8 +-
 arch/x86/entry/syscalls/syscall_64.tbl |    2 +
 block/bio.c                            |   33 +-
 fs/aio.c                               | 1914 ++++++++++++++++++++++--
 fs/block_dev.c                         |   34 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |   10 +-
 fs/gfs2/file.c                         |    2 +
 fs/iomap.c                             |   57 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |    1 +
 include/linux/blk_types.h              |    2 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |    5 +-
 include/linux/iomap.h                  |    1 +
 include/linux/syscalls.h               |    5 +
 include/uapi/asm-generic/unistd.h      |    4 +-
 include/uapi/linux/aio_abi.h           |   35 +
 kernel/sys_ni.c                        |    2 +
 20 files changed, 1939 insertions(+), 197 deletions(-)

-- 
Jens Axboe


