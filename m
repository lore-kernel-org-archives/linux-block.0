Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FC0C3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 18:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57BB21848
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 18:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iWcR6KC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404515AbfHWSOm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 14:14:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40077 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404393AbfHWSOl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 14:14:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so6950386pfn.7
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2019 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+vSLMthTALWxEjtZYGRpHT1NBlg7uG85nfHYmtqlMAI=;
        b=iWcR6KC1SwCB9j25XJayJjKFWPJL2TWOgbP3Q6QXCE/PoiXB4cZsE4ob98BdBURajM
         L/ZXfCWBgw1r+8IZg8NtzREgDKTtbHluE+ud2lFDyTM5QdPKsl/MzB6f+8Pluf79obkO
         ZhLWb+rOtCejKJ8krOOdQVM3Z0wJRsN/XG+Ljpi/uVduESkn9sNX0zh9M5RfdNOFENTQ
         Fjvs+nE0Tn0/UVmzogzK3lQJJDQZ7LCNLo4LZhYJbkNeevvJBjVDl2XKf8T2Pxq3Mrdi
         eKGAY1UpkLsct2Ld9hLNk7QdPpmiAeAKq5Utj+kmwp9aFv/xDbZDkVaxWTAZ5bDsaQPb
         F2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+vSLMthTALWxEjtZYGRpHT1NBlg7uG85nfHYmtqlMAI=;
        b=I6v4ldsXs3Exo/H6peInDdmWofe+CeLcqGwueZpeXnkiV1BbmnVzUG7kXnXu+ZQo4s
         xZIJvlhhwLU1n3jxLYJsjcM/9C23up/rnKR9zneUiL335f04perI6l8gXdnXM3Q/XDVq
         D9mC+QcTzBW9HuufVx+0POTiCzAx7BQTga7K3L/nWWi8i7OvtoZxSN2rkoH1yCOTUiwT
         Qcnt44WU1Tw+Fe4TVy/p/LIjRRiI/waCT63oEnqrp9qfVH9cpG/MAJrqB/tEbOEZXjne
         gKM+b7JOJW9V71cfyFsDokYcIS5BDgmgACVo3tP42ylDwnm391/tlWN50blyWK2ZpiCc
         JZog==
X-Gm-Message-State: APjAAAUmgSHPkxe0aL7fK6siOMhA1Bq8/LIfxF0Ut8aNi2ZViQ3fgZoR
        fp+qPfL4mE0BVHioyaDLEQ5nICYaGkHUMw==
X-Google-Smtp-Source: APXvYqyEVJsZAUdn4j9AxElT5exTpk96yms7O+xBQToUpzu2MNpi8Z5mq2Hc+SQ64q2HMGGCaaEcww==
X-Received: by 2002:a65:690b:: with SMTP id s11mr5083781pgq.10.1566584080200;
        Fri, 23 Aug 2019 11:14:40 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id v7sm3458847pff.87.2019.08.23.11.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 11:14:39 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.3-rc6
Message-ID: <afe09b99-7e3b-ccd4-8443-3957be2807b9@kernel.dk>
Date:   Fri, 23 Aug 2019 12:14:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's a set of fixes that should go into this release. This pull
request contains:

- Three minor fixes for NVMe.

- Three minor tweaks for the io_uring polling logic.

- Officially mark Song as the MD maintainer, after he's been filling
  that role sucessfully for the last 6 months or so.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190823


----------------------------------------------------------------
Anton Eidelman (1):
      nvme-multipath: fix possible I/O hang when paths are updated

Guilherme G. Piccoli (1):
      nvme: Fix cntlid validation when not using NVMEoF

Jens Axboe (3):
      io_uring: fix potential hang with polled IO
      io_uring: don't enter poll loop if we have CQEs pending
      io_uring: add need_resched() check in inner poll loop

Mario Limonciello (1):
      nvme: Add quirk for LiteON CL1 devices running FW 22301111

Song Liu (1):
      md: update MAINTAINERS info

 MAINTAINERS                   |  4 +--
 drivers/nvme/host/core.c      | 14 ++++++++-
 drivers/nvme/host/multipath.c |  1 +
 drivers/nvme/host/nvme.h      |  5 ++++
 drivers/nvme/host/pci.c       |  3 +-
 fs/io_uring.c                 | 66 ++++++++++++++++++++++++++++++-------------
 6 files changed, 70 insertions(+), 23 deletions(-)

-- 
Jens Axboe

