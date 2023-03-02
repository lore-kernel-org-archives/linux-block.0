Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47835C6FA8E
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 12:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCBMza (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 07:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCBMz3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 07:55:29 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2187EEF
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 04:55:28 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x3so4193479edb.10
        for <linux-block@vger.kernel.org>; Thu, 02 Mar 2023 04:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1677761726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P+RPLywpWRpuXMP+b0VdhJHn8q4YXA5NPmEVVhViGs=;
        b=xsbXLGVMB0BEySbmuZ4OPbz54jIQrq9L8n+vgdNwdHVZChDW1eXmofRZ2XwzaUaDes
         Fe6ThvsEHdUip+LQxNazRFqukSssQRL2GDL4p4Gs3PzGLXtttvg5UC5cUj4dQfblsn+0
         AhUsqK/EZP7w8hKhMxwj4L4LTeQ6vhwpguMpWc49rpHZNvTptUZRRYk7WZEiaYVBs3aO
         GXOujLfVO0z5FhPSbeyIsAgyTX9E7t05/+9jdjBZSXWFQ4IF2bpl638GSsA1WqdrpSRi
         IHgaDSorhNPpMGp2hK3GqLZcNboSRr3S5UV2DrCmn4XtZ+RifH66LMMMgIwc0LFh7GMm
         dgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677761726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4P+RPLywpWRpuXMP+b0VdhJHn8q4YXA5NPmEVVhViGs=;
        b=lWYQD66nWBolh7Ibv5tw2bjdIx3sn2Jvgzu/W0lOQ0yWrlbDRToVDyDgtk0ECjfQ2p
         rSjWng2ZfQEJmDz76cdIQgRGOt776iToOoqr2p7IZWu0nH0lHqllbVf9C32uGFpA2jBv
         Hps+Ii1t/PzX0FqWRrQdILeVin47MVwdOwDmPN4yBu9BnJjNqvNM53psVa+JJ8q3MG9H
         HxcYZ4aqm9x6zt5aKAwJ/9ULk4Vh0cM74QQ8UZqaFPcVrODvM2xYMW1cu/ogvvdWvPOJ
         dO80m9cG2CG1hHU2RU7e/FpMeu6HSdViuDVxpaBwkPnH3xfApJnBvvhHC5bgf6hY/hpu
         9xvw==
X-Gm-Message-State: AO0yUKVWKf0KV9II/xGq1pcisIlKzUCZFapjMFOGE49qU9p5E1wnyomU
        eZF5hyzS5149uT5g1Bc1caUNJw==
X-Google-Smtp-Source: AK7set/vznYuGtYbneGdvQ3uPKcuduB1qZLZKGGKrTPOJ9o6F4TkOUUHVZ4T2KJxjTqi422S9g3/RA==
X-Received: by 2002:aa7:d612:0:b0:4c0:9bd7:54cc with SMTP id c18-20020aa7d612000000b004c09bd754ccmr1244162edr.11.1677761726641;
        Thu, 02 Mar 2023 04:55:26 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id a98-20020a509eeb000000b004ad601533a3sm6955034edf.55.2023.03.02.04.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:55:26 -0800 (PST)
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
Subject: [PATCH v2 2/7] drbd: Rip out the ERR_IF_CNT_IS_NEGATIVE macro
Date:   Thu,  2 Mar 2023 13:54:40 +0100
Message-Id: <20230302125445.2653493-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
References: <20230302125445.2653493-1-christoph.boehmwalder@linbit.com>
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
2.39.1

