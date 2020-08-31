Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E005C433E6
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 17:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C86420767
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 17:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tbYlRCVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgHaRXe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgHaRXe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 13:23:34 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE39C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 10:23:33 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q6so1441175ild.12
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=48569lMgtoAq6m5ItdrGryOIPlrpmPtiI1pH7GfXLrE=;
        b=tbYlRCVez42BoQKXY87kSgTSg/pSqXQ7PZeSHP8SoJaPX5JMRo6HqS1TBIx3qKmAmI
         v+5e+Tv8fGu8ke6cHBPaVc6GybRTXxHV6WiIwDUy2Ic7sh9YBf5pibcVqqofGUXM2pvf
         oRgEbMbGDhcYmII5uii2LyaPVsMqeA3SU1PMzr3Icr7QaEpynvnRWBpGJSWvsVJ94re4
         8gzzaWBt+qC+NnOirS98JEu68y1tlURDbeiIxjjIp+VSucYCF/OeMJW8wZR04zS2m/yY
         5p3B3UMLQhI5bjgEA5j+lsYj6zPLaVyvWacn+/QBK1V+hfCLhO789De74DWC0qIRirom
         XZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=48569lMgtoAq6m5ItdrGryOIPlrpmPtiI1pH7GfXLrE=;
        b=TYI7j/nNIVBDMid0D4iGUkSiPpFcHoZ3SkP+mcDvoUQnXigCDNvp6A4Y8T/E0q4BmS
         MVmiQDfhr2IqJAA6wyG5UPcafQaSd2fCZ8UQdTDEBFJ5rlpNtG6IW9jWab/ak6atwFI9
         s6fwwMOYpRHqsrFgF3g5uHwDGa/zaj5BK2n6W1RU4tsNdUUTKIA4gkuDLFmSeWxtHxUU
         ITN+d0cjCPZ0UxY+bKc9ZXgWWABpMMNceRP1XWSAp2rW02FLbhLJbqKgqiDQMoHllaie
         a/RT0hmn7fxR2g32BnHFTvCU3ChwqfL/bjgcj4QcMLAxt+FBCPgIXZhEHBTbuiSLCkpE
         Udsg==
X-Gm-Message-State: AOAM533auH3kb6Tt+uJXy6Q4XAFZcqwrA7/1l7qEoSjJAYVp4Ss9eO/P
        jEqM/FlP2/IWEbdkSmVNmMiIyJCZBQzvT4OD
X-Google-Smtp-Source: ABdhPJypWKgz6Nix7swNxGj9o6W6NL7FTWqHhKnCYJlPGgTItDfeftkAE0OFk7oiSMEI7DbLBuUR/Q==
X-Received: by 2002:a92:c5ac:: with SMTP id r12mr2108129ilt.274.1598894613242;
        Mon, 31 Aug 2020 10:23:33 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b8sm2404497ioa.33.2020.08.31.10.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 10:23:32 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: ensure bdi->io_pages is always initialized
Message-ID: <346e5bf5-b08e-84e8-7b0e-c6cb0c814f96@kernel.dk>
Date:   Mon, 31 Aug 2020 11:23:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a driver leaves the limit settings as the defaults, then we don't
initialize bdi->io_pages. This means that file systems may need to
work around bdi->io_pages == 0, which is somewhat messy.

Initialize the default value just like we do for ->ra_pages.

Cc: stable@vger.kernel.org
Reported-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-core.c b/block/blk-core.c
index d9d632639bd1..10c08ac50697 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -539,6 +539,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 		goto fail_stats;
 
 	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
+	q->backing_dev_info->io_pages = VM_READAHEAD_PAGES;
 	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
 	q->node = node_id;
 
-- 
Jens Axboe

