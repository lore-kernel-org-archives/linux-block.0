Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB29BC433ED
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A7D6023C
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 16:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhDIQDc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIQDb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Apr 2021 12:03:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E1AC061760
        for <linux-block@vger.kernel.org>; Fri,  9 Apr 2021 09:03:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a6so6132425wrw.8
        for <linux-block@vger.kernel.org>; Fri, 09 Apr 2021 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=88AbpseFA6q0WoPOMbn/32JuU1wKMyiot3yqCGJbXBs=;
        b=FEpzcDAjXr9O6kqEmSWONxzsiv8/x/uE1WWyQZDNS328qf2CN+SHUpPYk5wxfyilh/
         zSorf4iV3B/XtbepX8vwibNxdl+vLHoVXkClldQvyJV6I3wEjNCoEHXP3letGUzpV5ZI
         UD0FdbQBjXQH4GIWO6+5sR3ATvNGbbjaMtHs2khnGdWpTKE6W5uSvseqnSiJLBl8HxDT
         zZZo/AdEdo07q27DBQilFeaV20OfuLHVcQaOW3JhzIKCM+haf/uOqc60QfYS9gB+iWZv
         qrwq7klMjKs4G0cwjytsKZClOR/ljmUP7few004nw6Vvkz+uL6ghsqoygYHi3NocCzVH
         /72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=88AbpseFA6q0WoPOMbn/32JuU1wKMyiot3yqCGJbXBs=;
        b=GvztS5D+O6mNqaJRZLwMk01/nTDeRbYizw1DWtu3LqncSg6fkoG1nvf9AoNCf8bls5
         ysuS1lx2vXJrBow9bPGAP39hkSz82TDssTrmLvwh4vIYnp9r5/mRPmpQ7ybp0tRxUuYn
         SonZV4dZot30TAkTw24VKkYR1iQjQu1Do5VjNzSZDuwYy6VQytRhZYG3R0OVmg8cWbi4
         JthKDMMhVBKkcleKJrd/om98xiSPOCX1qJXz8xPuVwsDlwvSMO7gFQ9b/qHVjew4HzBA
         jnzbhpt3n/5vtlDIfc/6zw5SfyStp2Mztfe1NOQbqS7vYp8Z0xW2mKS5yihctM3yVGyx
         pWbA==
X-Gm-Message-State: AOAM533R/vXs42mcCovZaULNNOLXveZNKnaQwpbWKXo59peos5AgPHmJ
        L5su3AbuHSgwejZawONzeU1yFGSPt0YXu6Vl
X-Google-Smtp-Source: ABdhPJzW195iHJl37jyH0b8+3YnsDNDyMLEtYcvOW4FeoM2BOFHPFDHk5YQ9yoe+cJdvZ3wEs6yWNg==
X-Received: by 2002:adf:ead2:: with SMTP id o18mr3279018wrn.101.1617984197254;
        Fri, 09 Apr 2021 09:03:17 -0700 (PDT)
Received: from nb01533.speedport.ip (p200300f00f04582edcb1e40bc231ceef.dip0.t-ipconnect.de. [2003:f0:f04:582e:dcb1:e40b:c231:ceef])
        by smtp.gmail.com with ESMTPSA id m3sm5322883wme.40.2021.04.09.09.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:03:16 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jinpu.wang@ionos.com,
        danil.kipnis@ionos.com, Md Haris Iqbal <haris.iqbal@ionos.com>
Subject: [PATCH V6 0/3] block: add two statistic tables
Date:   Fri,  9 Apr 2021 18:03:02 +0200
Message-Id: <20210409160305.711318-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This version fixes the long lines in the code as per Christoph's comment.

Thanks,
Haris

PATCH V5: https://lore.kernel.org/linux-block/20210408135840.386076-1-haris.iqbal@ionos.com/
* Rebased with latest code.

PATCH V4: https://lore.kernel.org/linux-block/20210203151019.27036-1-guoqing.jiang@cloud.ionos.com/
* Adds Reviewed-by tag from Johannes.

PATCH V3: https://lore.kernel.org/linux-block/7f78132a-affc-eb03-735a-4da43e143b6e@cloud.ionos.com/T/#t
* reorgnize the patchset per Johannes's suggestion.

PATCH V2: https://lore.kernel.org/linux-block/20210201012727.28305-1-guoqing.jiang@cloud.ionos.com/T/#t
*. remove BLK_ADDITIONAL_DISKSTAT option per Christoph's comment.
*. move blk_queue_io_extra_stat into blk_additional_{latency,sector}
   per Christoph's comment.
*. simplify blk_additional_latency by pass duration time directly.

PATCH V1: https://marc.info/?l=linux-block&m=161176000024443&w=2
* add Jack's reviewed-by.

RFC V5: https://marc.info/?l=linux-block&m=161789033303172&w=2
* Fix long lines per Christoph's comment.

RFC V4: https://marc.info/?l=linux-block&m=161027198729158&w=2
* rebase with latest code.

RFC V3: https://marc.info/?l=linux-block&m=159730633416534&w=2
* Move the #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT into the function body
  per Johannes's comment.
* Tweak the output of two tables to make they are more intuitive

RFC V2: https://marc.info/?l=linux-block&m=159467483514062&w=2
* don't call ktime_get_ns and drop unnecessary patches.
* add io_extra_stats to avoid potential overhead.

RFC V1: https://marc.info/?l=linux-block&m=159419516730386&w=2

Guoqing Jiang (3):
  block: add io_extra_stats node
  block: add a statistic table for io latency
  block: add a statistic table for io sector

 Documentation/ABI/testing/sysfs-block | 26 +++++++++
 Documentation/block/queue-sysfs.rst   |  5 ++
 block/blk-core.c                      | 44 +++++++++++++++
 block/blk-sysfs.c                     |  3 +
 block/genhd.c                         | 81 +++++++++++++++++++++++++++
 include/linux/blkdev.h                |  2 +
 include/linux/part_stat.h             |  6 ++
 7 files changed, 167 insertions(+)

-- 
2.25.1

