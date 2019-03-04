Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644CEC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 01:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3696020835
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 01:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VDH46py1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfCDBx1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Mar 2019 20:53:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38826 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfCDBx1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Mar 2019 20:53:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id n125so1790935pfn.5
        for <linux-block@vger.kernel.org>; Sun, 03 Mar 2019 17:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8EcgdStLVJmu8VvMjOs2jHMXRx/3b70j/+eQ1EWk0Hs=;
        b=VDH46py1+ZerPd/2ep97fVIx1AnYPuyNF+ORnAWlBWmQDQqPm48oUPqmMOD19aWrKU
         YblAagbAZTQZQFRj/SEB61nIpS1JhYnaOTyFC6sReFOhdSL5SRK+dinlKb5yvX/8Yybb
         EfFbpCg5PXnpxlrrM7Onm+fe7u6fIusoDxnq9A0yJZ12XmGRk1ClGhCaPlDXvSwrgegt
         uLn4xwUd6kqzlW8hnZQSLTkZiF/vDUM4uI6Jc7gn6ZpZzsAPgaKK1fK8w8KNsMviI4vM
         67SkU5V6XzMEDUe+5zE5q6aKWBeMBqHJ03o0js5OnA0ZCQm5jgeTUk/VILJpGfmrZ5t8
         4tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8EcgdStLVJmu8VvMjOs2jHMXRx/3b70j/+eQ1EWk0Hs=;
        b=T3xG4g+jjGdvNoGZG/43e7XPtdtAfNT0s7s+8wdRRrAza5w9P2xjQkLd/GC0z7Kn+4
         rwc76b70ZgpMEcLpuD8Q3B4MBsVL2Xb5uJVYyK5T/EqzraSs0oggcrXESLXMOFeNWoZQ
         9k7EQxgxq2+4ShzZfjVQhnHTVcVmmSTSfctQ5VeLN6M2FUF4E6Wg98V8IqMsChNn4eE4
         0TmweoKrGb1iummCzbvlKExBxhZNALWivMBF/B1vVbxNDBnyaWB2H1AWJ1sGPderTgIN
         FT8U4WqcDtnLo48ZnsIgTD3rA4s3pVrQsYTI9FkQDRgWf892jWZ9PREbB8fLvquj4WjT
         1ovA==
X-Gm-Message-State: APjAAAUF5LJlY2N/c0S7JYsSbFtOZrV3sP+Kg9CjTzZbC1simYh4vmSV
        Jer07nNKtfWpesvmnNGJ92Y2wNQ8JiJzYgDX
X-Google-Smtp-Source: APXvYqxJemWu0gUlUZJJKApk/CxfsctSgLgY6I27ggfUddQ/rXVnm4LZuayJrdeOoK8VI8JTlbNulQ==
X-Received: by 2002:a17:902:4545:: with SMTP id m63mr17519272pld.71.1551664405648;
        Sun, 03 Mar 2019 17:53:25 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q62sm8215575pfi.183.2019.03.03.17.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 17:53:24 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <3a56dea5-a9e3-5766-fd71-e364e13b5220@kernel.dk>
Date:   Sun, 3 Mar 2019 18:53:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are the libata changes queued up for 5.1. Pretty quiet round, a few
small fixes, comment typo, and most notably a low level driver for the
PATA Buddha controller.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.1/libata-20190301


----------------------------------------------------------------
Alexander Shiyan (2):
      ata: pata_of_platform: Allow to use 16-bit wide data transfer
      ata: pata_platform: Add IRQF_SHARED to IRQ flags

Bartlomiej Zolnierkiewicz (1):
      ata: add Buddha PATA controller driver

Chengguang Xu (1):
      libata: fix a typo in comment

John Garry (1):
      ata: libahci: Only warn for AHCI_HFLAG_MULTI_MSI set when genuine custom irq handler implemented

Rob Herring (1):
      ata: macio: Use of_node_name_eq for node name comparisons

Wolfram Sang (1):
      ata: pata_samsung_cf: simplify getting .driver_data

 drivers/ata/Kconfig            |  12 ++
 drivers/ata/Makefile           |   1 +
 drivers/ata/libahci.c          |   3 +-
 drivers/ata/libata-scsi.c      |   2 +-
 drivers/ata/pata_buddha.c      | 257 +++++++++++++++++++++++++++++++++++++++++
 drivers/ata/pata_macio.c       |   2 +-
 drivers/ata/pata_of_platform.c |   6 +-
 drivers/ata/pata_platform.c    |  24 ++--
 drivers/ata/pata_samsung_cf.c  |   8 +-
 include/linux/ata_platform.h   |   3 +-
 10 files changed, 297 insertions(+), 21 deletions(-)
 create mode 100644 drivers/ata/pata_buddha.c

-- 
Jens Axboe

