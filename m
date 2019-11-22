Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BB5C432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 15:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FE020714
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 15:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nKU8NzEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKVPtI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:49:08 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:43093 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKVPtI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 10:49:08 -0500
Received: by mail-il1-f181.google.com with SMTP id r9so7335664ilq.10
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2019 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RlvYcq0YpcoQz4pM+mWvFOPt1NkKaiDd1G712RIAgtQ=;
        b=nKU8NzEHHyHQQiwE3hMJi1jXcvtgF/Dj1CHBiTuiFir2045apyycBuja0R4FSbC2he
         MngpvZHZptXXbiTdRiPyflq2L0yVwuecACMesddBYEpdfxzZaw0mLf6G7UfwBofZX5l8
         t3SGNblyinN4HUS2Re0pGiDrtfjAl58T1U/qAfK026MKmgVBKAQtZxXLFLVuXmR+H8Zk
         EW+GYYv/qVKw5DSIhAFgAIrWI9wk0UomI3pGXDlgW+X/erjn2ryCeS3ZwJUVPAnY3WHJ
         InxDG76kRKBhPS8sUa0jC1bks+KlN8WENCt2Fz3oWT3MDJanvtMdYNGvjLTRcE4Loq/m
         136Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RlvYcq0YpcoQz4pM+mWvFOPt1NkKaiDd1G712RIAgtQ=;
        b=X2LRdimmQ9tMmtfNQmUMkn1rtLTqXUhKozmL7p4UeosqIHFMss1tZmRj+z+cXZTJKW
         9PcfKVviY/CfUxVJOU+IbHHAKjRqv2KQZ5gznlm4i7BA5TlXaw0XtSz0TdBZREp0TjA1
         gsu2CEDCyCXqpD71V1kArrsZEP5JgsIfH2/Y67UwZ22VwUVsAt1fCuwg5GmLfQEm57JW
         YVu0kGkKCPjoEzjD703X7v4hbPlTMr+NGCphFvhatRsz4APCJYKyQFQ2vbWx9Bm3R3Ip
         pKfQRl8hf8oZkUQ7+ec+0syjU9TboJ+g/avTgAbBIAdcEsoQBsbLijCFdD6AvaUCxYrl
         GGyA==
X-Gm-Message-State: APjAAAXJmTqmgHium4fnQbCJqK8akgwJ1U0nS0gKuWfPgs+tluWOGl3t
        L3MhXCUQO6pKS7Z0QlPMD4Hb96LRjksQ8g==
X-Google-Smtp-Source: APXvYqyzAqHhfBM1pTQ2mN4uIS83aBL3s4PDXnOmHUToGmNUE+X5l+JyOi32m2z2zhjF4fkO97hmpw==
X-Received: by 2002:a92:405a:: with SMTP id n87mr17791921ila.16.1574437745278;
        Fri, 22 Nov 2019 07:49:05 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t25sm2379860ios.22.2019.11.22.07.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 07:49:04 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Zoned block device changes for 5.5-rc1
Message-ID: <104ef28e-3b71-ead9-60ea-13fff988b919@kernel.dk>
Date:   Fri, 22 Nov 2019 08:49:03 -0700
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

This is on top of the for-5.5/drivers-post pull request, and adds
enhancements and improvements to the zoned device support.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.5/zoned-20191122


----------------------------------------------------------------
Christoph Hellwig (4):
      block: cleanup the !zoned case in blk_revalidate_disk_zones
      null_blk: clean up the block device operations
      null_blk: clean up report zones
      block: rework zone reporting

Damien Le Moal (5):
      block: Enhance blk_revalidate_disk_zones()
      block: Simplify report zones execution
      block: Remove partition support for zoned block devices
      null_blk: Add zone_nr_conv to features
      scsi: sd_zbc: Cleanup sd_zbc_alloc_report_buffer()

YueHaibing (1):
      scsi: sd_zbc: Remove set but not used variable 'buflen'

 block/blk-core.c               |   6 +-
 block/blk-zoned.c              | 356 +++++++++++++++++------------------------
 block/partition-generic.c      |  74 ++-------
 drivers/block/null_blk.h       |  11 +-
 drivers/block/null_blk_main.c  |  21 +--
 drivers/block/null_blk_zoned.c |  33 ++--
 drivers/md/dm-flakey.c         |  18 +--
 drivers/md/dm-linear.c         |  20 +--
 drivers/md/dm-zoned-metadata.c | 131 ++++++---------
 drivers/md/dm.c                | 130 +++++++--------
 drivers/scsi/sd.h              |   4 +-
 drivers/scsi/sd_zbc.c          | 235 ++++++++++-----------------
 fs/f2fs/super.c                |  51 ++----
 include/linux/blkdev.h         |  15 +-
 include/linux/device-mapper.h  |  24 ++-
 15 files changed, 427 insertions(+), 702 deletions(-)

-- 
Jens Axboe

