Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19590CE7B12
	for <linux-block@archiver.kernel.org>; Thu, 28 Sep 2023 09:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjI1Jjd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Sep 2023 05:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjI1JjV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Sep 2023 05:39:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C926ECE2
        for <linux-block@vger.kernel.org>; Thu, 28 Sep 2023 02:39:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3248e90f032so172363f8f.1
        for <linux-block@vger.kernel.org>; Thu, 28 Sep 2023 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1695893942; x=1696498742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxdqCPbXhmzZcYHHWzAs1Pz189GcHmpMYCt/LIrBVmA=;
        b=defPPbsL31qtr6Fegpk+sAyp/swDW33q+GGjJfm2HTUJBv1BXu4Yz/obKNEjhlODV3
         FhWVgZyPQfTjtl/IfBLB0ay4Vr4hvmNUeyp3zgWJloAIymdu8BsIayJlOPkhtuD1cium
         e0LOnSuwZCLSaz7I0euNIkAmht+SDP3LBF2w0d4q9jYUbujT40YXccUKDdnr3Mwka+x6
         +4Stdr0uux2cHqTe/trKh6Yu0nUcYjr8Jtes6b3D/0f4Z3cewVQTrBFEc7oGmrVs7CJf
         bT5LZFeJ08cYFkqP5GVSRszrsq32sjQ8O2xJ2gb6mbA0ZaGIQMpDtls3SnsQHmFF8WFl
         xKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695893942; x=1696498742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxdqCPbXhmzZcYHHWzAs1Pz189GcHmpMYCt/LIrBVmA=;
        b=D6RQsAt4N9y5/qZUmNfr9qolOHJrvCe6UEL6xQZNnunyJS6WXjCAywOdZYXZ2sYZcU
         ZvXfYuRGK/RhXvcF1xz5Qb+2WKBFFHWsBdNQAqtmthdaDtKPu7XmyvCsIarJk1QY8hUM
         zuwr+22Y7C5OSAF7W5gyLLE+2B2MzyyDdIg4pxvpZZgRDnT3wHX4ei58MTQXnbffnrxV
         wMH9l3XwMUJZ6dOlVrczadakGxZ7oiIp6NRm4Q7Zcc3CgoEFizO/xoIzbbBp5di9LZKn
         /d+Vw3NHAl13Wk/jAAnXUfb1JVj3EPyvJiMK0fC2SdyQCdtyF/mF9mvVy5xfviRts2xh
         XxuA==
X-Gm-Message-State: AOJu0YwDB9dkenl4kh9Y2wYxAFs0Qfs0Un3MfpWjcn0HqCYO+F1aTqrz
        qt+S//ayUJh8+oVwQZQ1AdEyUQ==
X-Google-Smtp-Source: AGHT+IFXErMwVQh26NX4Lo+CN3tqVv9eERZaRoI/iWHEjF+72aA0bMsuVLkXufdDKwDB+VZd3qOeDQ==
X-Received: by 2002:a05:6000:10c4:b0:319:77dd:61f9 with SMTP id b4-20020a05600010c400b0031977dd61f9mr668384wrx.35.1695893942239;
        Thu, 28 Sep 2023 02:39:02 -0700 (PDT)
Received: from localhost.localdomain (213-225-13-130.nat.highway.a1.net. [213.225.13.130])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d50c4000000b0031fa870d4b3sm18931449wrt.60.2023.09.28.02.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:39:01 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Joel Colledge <joel.colledge@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 3/5] drbd: Move connection independent work from "sender" to "worker"
Date:   Thu, 28 Sep 2023 11:38:50 +0200
Message-ID: <20230928093852.676786-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
References: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Originally-from: Andreas Gruenbacher <agruen@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 drivers/block/drbd/drbd_req.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0c9f54197768..6e21df44b5aa 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5890,7 +5890,7 @@ static int got_OVResult(struct drbd_connection *connection, struct packet_info *
 		if (dw) {
 			dw->w.cb = w_ov_finished;
 			dw->device = device;
-			drbd_queue_work(&peer_device->connection->sender_work, &dw->w);
+			drbd_queue_work(&device->resource->work, &dw->w);
 		} else {
 			drbd_err(device, "kmalloc(dw) failed.");
 			ov_out_of_sync_print(peer_device);
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index cd56fd0f3b06..fbb47138a52b 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -823,8 +823,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 
 		get_ldev(device); /* always succeeds in this call path */
 		req->w.cb = w_restart_disk_io;
-		drbd_queue_work(&connection->sender_work,
-				&req->w);
+		drbd_queue_work(&device->resource->work, &req->w);
 		break;
 
 	case RESEND:
-- 
2.41.0

