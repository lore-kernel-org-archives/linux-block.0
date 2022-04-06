Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AE8C433FE
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 20:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiDFUvw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiDFUve (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 16:51:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021473CBF3D
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 12:07:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r10so3813987eda.1
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TnUktBxvt8+vZXxb7vXGqvLd54peL2xRpiiuPoGFnkk=;
        b=RTjQs8filYk4C4QQnW6B2lyt27Gc5MyDO2AWKp3UlCdUISg90K1O9Hav0/7pdY97gl
         b0nlFnS7D8D+7bfLJNpuq25U9xZYXGoh3G+vn96SLCdeBEmXa9/N4EYLpCIrk790sjwh
         Eyicd/11fMeVgIm1IvCKoca+kw4pE34D5v15p5Xsn/pHZTxAvKYFS2jGGgkEqbsGgXK5
         znTMf2671Efgm6HThOvVkCyYDmyJcscyHfEVjFUgZOkLW8Zb5ty0Lw/KcvBaAYpkHP8c
         uY5orEeRzQcUztWB1myK7izLj8q93jCf3Rd5lHScKNZ2TsWUwGeiOVY7oVgFDoXLVVSK
         HCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TnUktBxvt8+vZXxb7vXGqvLd54peL2xRpiiuPoGFnkk=;
        b=Y13yGy7aaZuYBbT+cvR+oSo3oqo5Zu9AeBSlPVsB8NEQSkN9a/54PkknA8v6pQIp1E
         9uswLlMV0kIl1aryB0vKzdAvpPxBYi9enTuMpd+K8J4h1NuFqFWLKwiNP5eK6k/p/CBv
         HYC66LvTpKEa/Sp+wNj5k1YBbq3zry67rUXiSmTJd7lHHzkhSFRF8z+JDl/x28SZWMqr
         DsmuOduZcNiGoQpKaQZ5f/YPaaEaQpjNWqtBO8Wd7dyBY9sXiUSPa8dlHppcZbHY+sjr
         n1+BH7MegpzgofTx5PLV4zSx1EmYSrLA51zttnD6uhsxfchdu+GkRLeacpTs2M2etFTg
         5QPQ==
X-Gm-Message-State: AOAM5321v8tr8pVd8kUzioMFup/o+MLG1WMaOrerBNDHb0V5/DZqbKca
        cIqZOPvg88uOXynaZEGlhZAGXA==
X-Google-Smtp-Source: ABdhPJxx9ngsTndlvSdykCBzt140ypyzhYFDLBaN1Ud/EcD94rJa1p1GXvY0GkN6S1lJk4ud48Suuw==
X-Received: by 2002:a05:6402:2687:b0:419:1f59:19c4 with SMTP id w7-20020a056402268700b004191f5919c4mr10447356edd.255.1649272056533;
        Wed, 06 Apr 2022 12:07:36 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id er22-20020a170907739600b006e7e873ed6csm4323534ejc.53.2022.04.06.12.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:07:36 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Cai Huoqing <caihuoqing@baidu.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 5/7] drbd: Replace "unsigned" with "unsigned int"
Date:   Wed,  6 Apr 2022 21:07:13 +0200
Message-Id: <20220406190715.1938174-6-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Cai Huoqing <caihuoqing@baidu.com>

when run checkpath.pl for the first patch, found that
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'.
so fix it. BTW

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c6c1843452ba..0825766ce910 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -364,7 +364,7 @@ drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector_t secto
 	struct drbd_device *device = peer_device->device;
 	struct drbd_peer_request *peer_req;
 	struct page *page = NULL;
-	unsigned nr_pages = PFN_UP(payload_size);
+	unsigned int nr_pages = PFN_UP(payload_size);
 
 	if (drbd_insert_fault(device, DRBD_FAULT_AL_EE))
 		return NULL;
@@ -1629,9 +1629,9 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	struct bio *bio;
 	struct page *page = peer_req->pages;
 	sector_t sector = peer_req->i.sector;
-	unsigned data_size = peer_req->i.size;
-	unsigned n_bios = 0;
-	unsigned nr_pages = PFN_UP(data_size);
+	unsigned int data_size = peer_req->i.size;
+	unsigned int n_bios = 0;
+	unsigned int nr_pages = PFN_UP(data_size);
 
 	/* TRIM/DISCARD: for now, always use the helper function
 	 * blkdev_issue_zeroout(..., discard=true).
-- 
2.35.1

