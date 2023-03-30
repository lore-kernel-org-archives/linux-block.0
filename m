Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8270BC77B60
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 10:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjC3K15 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 06:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC3K1x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 06:27:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE09001
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 03:27:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y14so18544851wrq.4
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1680172069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zMenm1DZpmHocR+5Pohn/nlHFQgV1jhAeYfGdQoef0=;
        b=IkZDbJDpMPzQRtZHRJvovLadMdzAd+SRx2aObpfWLH2VEl8OAwN/9PyG/SNXyUF4Z+
         5TP2/Q7EOEWXQLX6yha1AV/M+08uJB/HYiTG/DBDrfg4s+0nYK/dzdA1INywl8pbzoYM
         UoKrS3P37etkxbyIhI0b74uDjIP4a2BSoD6B2QKGlNHfV7lxsAzfAbJ1dEgIysYyebR4
         EtUHbydQiGjqU8TjMuBqC2XIIyHP27ZETFMHC8j3PPz+i4CMsSq9EVXjf4naMVHphndM
         2svTSwMst46MVuq2SIHZ9H3bW0zapv7n6mvFev7q9cSvBru1/+cP880QwzYTMSwl9tlQ
         TwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zMenm1DZpmHocR+5Pohn/nlHFQgV1jhAeYfGdQoef0=;
        b=nQhr2NPSiUlZiHjdASQ9aWCeT68y92y2Zg9ZUhtl36GsoWhXrO1DfydwG20+dic3Lj
         PZYwLZgNeIFtKz+l8Fxi9NfdoHhqstNiGMHyNnYRNP//FUbCjyDxMEC472KqOxyFzGRi
         7OoCkh9G5RNYgyAmN4/FbzanSuzpiLk7SUoO9qKy2Yt5fnenyGpbBqgr1dTrGPVDq5WF
         zHdr0k9L55QcqAu5d0oJP0j//cfpI1vpSReF3PS3qeS5UL6vSIdnrL/7+GTninqkflWv
         xdkJ52Vp/8rBnamBD8b1fXMBLl3AR4TGJEBsivEytN2jwSkVO+tlEpwxE5epWXyTJqWG
         dtjg==
X-Gm-Message-State: AAQBX9ct/IdkkbXx7p/A8OYCe/Hl/gbuRMdBJgTdPR6artfjleMN9Co4
        VdSG+9EiCXrK7Y8wEF2NAdEeHg==
X-Google-Smtp-Source: AKy350YNTr9iU5PMyf0dtk1XSu7+m2gGnTT+oWZcNNxu2dPqnZkerqTVFTJJUGDTRemcjWti8zvFrw==
X-Received: by 2002:a5d:4bc2:0:b0:2e5:2e0a:d958 with SMTP id l2-20020a5d4bc2000000b002e52e0ad958mr238752wrt.65.1680172069377;
        Thu, 30 Mar 2023 03:27:49 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b002d6f285c0a2sm26352514wrp.42.2023.03.30.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:27:49 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Andreas Gruenbacher <agruen@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 2/7] drbd: Rip out the ERR_IF_CNT_IS_NEGATIVE macro
Date:   Thu, 30 Mar 2023 12:27:39 +0200
Message-Id: <20230330102744.2128122-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
References: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h | 37 ++++++++++++++---------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d89b7d03d4c8..772023ace749 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1918,18 +1918,14 @@ static inline void inc_ap_pending(struct drbd_device *device)
 	atomic_inc(&device->ap_pending_cnt);
 }
 
-#define ERR_IF_CNT_IS_NEGATIVE(which, func, line)			\
-	if (atomic_read(&device->which) < 0)				\
-		drbd_err(device, "in %s:%d: " #which " = %d < 0 !\n",	\
-			func, line,					\
-			atomic_read(&device->which))
-
-#define dec_ap_pending(device) _dec_ap_pending(device, __func__, __LINE__)
-static inline void _dec_ap_pending(struct drbd_device *device, const char *func, int line)
+#define dec_ap_pending(device) ((void)expect((device), __dec_ap_pending(device) >= 0))
+static inline int __dec_ap_pending(struct drbd_device *device)
 {
-	if (atomic_dec_and_test(&device->ap_pending_cnt))
+	int ap_pending_cnt = atomic_dec_return(&device->ap_pending_cnt);
+
+	if (ap_pending_cnt == 0)
 		wake_up(&device->misc_wait);
-	ERR_IF_CNT_IS_NEGATIVE(ap_pending_cnt, func, line);
+	return ap_pending_cnt;
 }
 
 /* counts how many resync-related answers we still expect from the peer
@@ -1943,11 +1939,10 @@ static inline void inc_rs_pending(struct drbd_device *device)
 	atomic_inc(&device->rs_pending_cnt);
 }
 
-#define dec_rs_pending(device) _dec_rs_pending(device, __func__, __LINE__)
-static inline void _dec_rs_pending(struct drbd_device *device, const char *func, int line)
+#define dec_rs_pending(device) ((void)expect((device), __dec_rs_pending(device) >= 0))
+static inline int __dec_rs_pending(struct drbd_device *device)
 {
-	atomic_dec(&device->rs_pending_cnt);
-	ERR_IF_CNT_IS_NEGATIVE(rs_pending_cnt, func, line);
+	return atomic_dec_return(&device->rs_pending_cnt);
 }
 
 /* counts how many answers we still need to send to the peer.
@@ -1964,18 +1959,16 @@ static inline void inc_unacked(struct drbd_device *device)
 	atomic_inc(&device->unacked_cnt);
 }
 
-#define dec_unacked(device) _dec_unacked(device, __func__, __LINE__)
-static inline void _dec_unacked(struct drbd_device *device, const char *func, int line)
+#define dec_unacked(device) ((void)expect(device, __dec_unacked(device) >= 0))
+static inline int __dec_unacked(struct drbd_device *device)
 {
-	atomic_dec(&device->unacked_cnt);
-	ERR_IF_CNT_IS_NEGATIVE(unacked_cnt, func, line);
+	return atomic_dec_return(&device->unacked_cnt);
 }
 
-#define sub_unacked(device, n) _sub_unacked(device, n, __func__, __LINE__)
-static inline void _sub_unacked(struct drbd_device *device, int n, const char *func, int line)
+#define sub_unacked(device, n) ((void)expect(device, __sub_unacked(device) >= 0))
+static inline int __sub_unacked(struct drbd_device *device, int n)
 {
-	atomic_sub(n, &device->unacked_cnt);
-	ERR_IF_CNT_IS_NEGATIVE(unacked_cnt, func, line);
+	return atomic_sub_return(n, &device->unacked_cnt);
 }
 
 static inline bool is_sync_target_state(enum drbd_conns connection_state)
-- 
2.39.2

