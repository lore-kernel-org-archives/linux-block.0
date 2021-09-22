Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900E1C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE1C60560
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhIVMjT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 08:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhIVMjS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 08:39:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A5FC061574
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 05:37:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q23so2573974pfs.9
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4r5hHsLSqFPjFI5wR4N7KCh9k5AlpvO2LM7FCfFcAxI=;
        b=hNagVhUiKO3N7yS2MkYebkvw28gd9fBFAbzhqf7VH2GBGjGxL/qe5rIoy1eduDkHFD
         SfLuyUuwoWQ8asyw3ItuYiLoP/UX6vp1x6FfvGGTwr6+8oFkzMeoNPR/6Yjojx6H8fqn
         W4+fj962NmO2LoUf5aSppXon2aGSwlQrgZFyQbQjlymg38riwZhg1ZdUMIoGXsLQ7Am4
         TelQVCzx8ePx8Scxa1bxFt95UagzdOcEoneMTo4rAplvxbNVER9/UfZQLd+Dtc1B9Cbq
         IfLP6dsDY9QCdDihlxlKUfHsCbQe2YRlTWNCBrnJaHhtltNCWcBXeVJxtTyCHuKtjkkC
         SSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4r5hHsLSqFPjFI5wR4N7KCh9k5AlpvO2LM7FCfFcAxI=;
        b=ayV0Joziroy3rKvtGCqOJj4hEt4UjfUJotIjQWmpDgiAJTGkoUwlgeTZzte+Iie8s8
         juiSCBrFXiq04X1SKt4p+apEKLBa8Otan9QW5dVjXq6nSoadksvPLJ2so4xiiCYV2gkh
         WsT7cM76Upiu3kQ9PG8+4YDgSA8lYMrgcDb39L1AQnZnAoQOLbg+TBCk/ZZdMEaW71gV
         gqthcGKGgjyGUkdWxb2HYklqTA3E+ihp5ylkBEoKVgdZhPlfjoY5S1ViLpFj+1AtX7/v
         OkaC3Ua6fC6O8aeJ/1bhsfelt7911s+nDzOB1OcznbOAb3kllW6bQndH22LPU+Im/A1Z
         U5bA==
X-Gm-Message-State: AOAM53038aIIpC8C2RVGE+YJHeMiunbTlQQIvNF8kKJebAoccu6wmDBP
        ixxXIolWdEKyOymr82OOMe96
X-Google-Smtp-Source: ABdhPJzNKppc244/mgKdjew5hR8qxaVzd/w+KiEBaHXaLnfD5kjRtFp/Ve/yoTpNrqiQWoO1x1/Mkg==
X-Received: by 2002:a62:6587:0:b0:445:824:58f2 with SMTP id z129-20020a626587000000b00445082458f2mr26165014pfb.82.1632314268225;
        Wed, 22 Sep 2021 05:37:48 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id fr17sm2268552pjb.17.2021.09.22.05.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:37:46 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: [PATCH v2 0/4] Add invalidate_disk() helper for drivers to invalidate the gendisk
Date:   Wed, 22 Sep 2021 20:37:07 +0800
Message-Id: <20210922123711.187-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series comes from Christoph Hellwig's suggestion [1]. Some block
device drivers such as loop driver and nbd driver need to invalidate
the gendisk when the backend is detached so that the gendisk can be
reused by the new backend. Now the invalidation is done in device
driver with their own ways. To avoid code duplication and hide
some internals of the implementation, this series adds a block layer
helper and makes both loop driver and nbd driver use it.

[1] https://lore.kernel.org/all/YTmqJHd7YWAQ2lZ7@infradead.org/

V1 to V2:
- Rename invalidate_gendisk() to invalidate_disk()
- Add a cleanup patch to remove bdev checks and bdev variable in __loop_clr_fd()

Xie Yongji (4):
  block: Add invalidate_disk() helper to invalidate the gendisk
  loop: Use invalidate_disk() helper to invalidate gendisk
  loop: Remove the unnecessary bdev checks and unused bdev variable
  nbd: Use invalidate_disk() helper on disconnect

 block/genhd.c         | 20 ++++++++++++++++++++
 drivers/block/loop.c  | 15 ++++-----------
 drivers/block/nbd.c   | 12 +++---------
 include/linux/genhd.h |  2 ++
 4 files changed, 29 insertions(+), 20 deletions(-)

-- 
2.11.0

