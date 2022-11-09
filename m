Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5FC4332F
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 13:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiKINfS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Nov 2022 08:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKINfP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 08:35:15 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D113137A
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 05:35:12 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f5so46696968ejc.5
        for <linux-block@vger.kernel.org>; Wed, 09 Nov 2022 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hF3rMk8apVOOgsCxEsnYa+onZZgR9Ac90HGkbjlBXY=;
        b=WYj28GSbjnk/0i6VzKp+MEOsvjkvjUeibMvRcUfW8smL/+shwJz5l4p4w/58lBmgHG
         wAF7yA/kX6SFBy/U6gtEdb2TLYEoDejIGD9TO7iJI1aWWq8v8x/2NQCeQYOYCSOlVih+
         jm9H+EOdFouIINDlH9a730ZzHbq3ZLklBfiD4xL4AkgO9e6NYGl216ncs2uqfDGc2sG/
         jNtDphsOaZbNoguEdcNTKrSxD8fofe7WvgLClYsd+29wF/MgfETVfX2rzwwzOvbffDkC
         yZT1XLShDODK9R/wOvvSJbtwJdYfW2ofQea00HyXshfebDO+YAgfBWaQF2qqyeIuWtUT
         RO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hF3rMk8apVOOgsCxEsnYa+onZZgR9Ac90HGkbjlBXY=;
        b=GL7HFq42DDfrmwH7psTFWOqXY7lgSIqnfud0LOOxNgvxf6aZtCTrt3rz6Rcr3tXuIc
         1jqaayJmc17GqgOTSswJpYteEQVuEQ4YNhwHxNrgKLyv7kvYXq60Xt5N4rogAU7t3Ph3
         CfZZhUAzQOx9JZ/IqcWlens+sgAenP7bv4urj8ts0/mbCOXZ+LsE4lmMDvJ2TuZI17bW
         VZZ/ujblE/fxyTRUM9pbtKTXKvfibwybWV8SxiOxTjuS5DVkEtYMz3YbfXaVsPayVidI
         pGuurSrN6/QaHolNnvHpMYNedu6n3IemE1pKI9GSSz63puOpJUoEHnkWEXbXzj7UewoM
         FHCg==
X-Gm-Message-State: ACrzQf0xOvaAglTocMCyOxzJbNr9HTGhj3TLpBl+JWOAjoUNLzbixPht
        0ZPNIQ6QZyk0lZyTO8wtOfqFAg==
X-Google-Smtp-Source: AMsMyM4t4CWXtlyKLCZmHOOOVRWjcckjZl3xCwXKb4N+heCpjTiTxHg7GDncjRCrpLbudOygicbj4g==
X-Received: by 2002:a17:906:3b48:b0:7ad:fa67:1daa with SMTP id h8-20020a1709063b4800b007adfa671daamr38243729ejf.653.1668000911374;
        Wed, 09 Nov 2022 05:35:11 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id lx8-20020a170906af0800b00782fbb7f5f7sm5867463ejb.113.2022.11.09.05.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 05:35:11 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Joel Colledge <joel.colledge@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 2/3] drbd: disable discard support if granularity > max
Date:   Wed,  9 Nov 2022 14:34:52 +0100
Message-Id: <20221109133453.51652-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
References: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Philipp Reisner <philipp.reisner@linbit.com>

The discard_granularity describes the minimum unit of a discard.
If that is larger than the maximal discard size, we need to disable
discards completely.

Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 249eba7d21c2..63f589926d85 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1256,6 +1256,18 @@ static void fixup_write_zeroes(struct drbd_device *device, struct request_queue
 		q->limits.max_write_zeroes_sectors = 0;
 }
 
+static void fixup_discard_support(struct drbd_device *device, struct request_queue *q)
+{
+	unsigned int max_discard = device->rq_queue->limits.max_discard_sectors;
+	unsigned int discard_granularity =
+		device->rq_queue->limits.discard_granularity >> SECTOR_SHIFT;
+
+	if (discard_granularity > max_discard) {
+		blk_queue_discard_granularity(q, 0);
+		blk_queue_max_discard_sectors(q, 0);
+	}
+}
+
 static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backing_dev *bdev,
 				   unsigned int max_bio_size, struct o_qlim *o)
 {
@@ -1288,6 +1300,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 		disk_update_readahead(device->vdisk);
 	}
 	fixup_write_zeroes(device, q);
+	fixup_discard_support(device, q);
 }
 
 void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev, struct o_qlim *o)
-- 
2.38.1

