Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F13C432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 15:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA942071B
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 15:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HkJaRHZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKVPwA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:52:00 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:41017 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVPv7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 10:51:59 -0500
Received: by mail-il1-f169.google.com with SMTP id q15so7360507ils.8
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2019 07:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=epVqkZwO5F43X9lbhTndaqg567sytD3A5w7/DXG2rJU=;
        b=HkJaRHZVqoycuJKpHAXlqpAbdrXT0ZQlB/lutiCT4Udw3FlDrI6wNqIgqOgyHnG1NP
         vx7670h6VwvyvNH+Euut8va6cHX1ESw+kGGw/IQbZzXJ8es07OPMdiyVOqfNrzrxOZVT
         reMPJ8XBvHXCB8LgeeynJGtt4z/kH8oeuEm0NBNOyECnMjNbyOU9JU5NfauOVp5hMbHf
         a1wAKVCC8pDg1uyuyIlIY6KRqOD0kCLbn3A/Flo8m1ynPlKt1Mdxco/nSlDBLaEJx+Ta
         0859CDp9WBWJyQPqUFEaVdIqAGFXyatsfH5DtQSTGNvMxTzkmlItRUpC18wRaXSDiGSz
         uDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=epVqkZwO5F43X9lbhTndaqg567sytD3A5w7/DXG2rJU=;
        b=I4vENFsQ/rif473o7hmBBxkgHpQgk6//l+2ud0vNu9mRwSfvarAPxytacNZc6cvjNb
         onQAu2UzS0lmVOSfqC+Ty1+LD+SkNdF8WfedGl9aU6k5iaoGcdjN0MhBXeW7bAVtzhUN
         X00VkR4piwOWzwNL4q1lm3+SaFXZnlbKmDxZnktLoOjh8d8EDsWYvy6eOgFSJi5rSKZL
         F9RadutlmNwn4XgVN80Xx6nHPZa1qmRzwNHrGnut6jn8NUJmoQzn99gZSN+PY5eOOpIt
         VpCm0IKFYMgA7sSHkGi9sLyTTAMsMEGCYFaWCc3+awC2H1wsWQY1rjQvFwSFXYTwtYSp
         U/FA==
X-Gm-Message-State: APjAAAXRG1AA67KdITRxOOCkf2ozOprONrBcgOUPPYAJAN/pM+FlR0ax
        GtbVeLc8fIvSw3wusICHo6/6onZ/uYLMJA==
X-Google-Smtp-Source: APXvYqzWLF5GurHhysGfCFYpsEAeciSF/VLd5GG91WDxRVDWxtnrFBgIN0YKBNokFCQ+TQIgBUnayQ==
X-Received: by 2002:a92:1696:: with SMTP id 22mr16641371ilw.243.1574437917057;
        Fri, 22 Nov 2019 07:51:57 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d1sm2392680iod.16.2019.11.22.07.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 07:51:56 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Disk revalidation cleanups for 5.5-rc1
Message-ID: <98189772-b987-2f83-29c5-a300b83f4b08@kernel.dk>
Date:   Fri, 22 Nov 2019 08:51:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the zoned changes (for-5.5/zoned), here is a patchset that
continues the work that Jan Kara started to thoroughly cleanup and
consolidate how we handle rescans and revalidations. Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.5/disk-revalidate-20191122


----------------------------------------------------------------
Christoph Hellwig (6):
      block: refactor rescan_partitions
      block: merge invalidate_partitions into rescan_partitions
      block: move rescan_partitions to fs/block_dev.c
      block: fix bdev_disk_changed for non-partitioned devices
      block: remove (__)blkdev_reread_part as an exported API
      block: move clearing bd_invalidated into check_disk_size_change

 block/ioctl.c                   |  37 ++-------
 block/partition-generic.c       | 180 ++++++++++++++++++----------------------
 drivers/block/loop.c            |  13 +--
 drivers/s390/block/dasd_genhd.c |   4 +-
 fs/block_dev.c                  |  48 ++++++++---
 include/linux/fs.h              |   4 -
 include/linux/genhd.h           |   5 +-
 7 files changed, 135 insertions(+), 156 deletions(-)

-- 
Jens Axboe

