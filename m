Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13446C77B6D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 10:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjC3K16 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 06:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjC3K1z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 06:27:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD0E7DB2
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 03:27:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q19so15460773wrc.5
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1680172072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tFot2qeZ2g5bJSVqE02JTKqWWEEsYCP5AgrPPpbM1g=;
        b=Kr79JUVmumwV3+sEie0htPM48raEk+XVN3Uigb4cPgz/Cwmmf2oedq9OELQ6vyXtK8
         Dm9nnTEzKOh0DsIg7z6KNN7AmuRWpDYSyJEKipM0uIJXOJTyxPTHftT9AH93utfGowMI
         6h+iHcfpohSBCDRVGzhWGQuNspw9LqCqebu19K9R6pxGDipKf5Nzir9Beq20sXWa0JqN
         xhuOQQVKRMX0leG+Trmm1hKWS/udYwoVtsuW/Ktl1lOHJnBKqXFv+y+vynPabLSsMar1
         bVMA8Z4oIwh9uLBzrCN+7RlswnX5LYLW59Kbl14Nh56ZvwcQsBkVMI32l4JwDsQz1jwY
         Qcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tFot2qeZ2g5bJSVqE02JTKqWWEEsYCP5AgrPPpbM1g=;
        b=f0anBIsXxI+4hLaSB0dL0YdVf7a5yT2gSuh/KRLe0iyYmryXbUpoH7JDh5W+Yo7HxP
         vky0zR5VSbxjnjJBwsXogNrUcR+rObWsIQQY23Tw/35PTlxjT1ZfDCc2ixglmp4p/zlz
         TO+6YBogHzDYiE+IwvG5sG4Zbrmv3DvqwCQSs7jm3jGKBfGG/3tbaj53+u8c7pnF5988
         xx4DOuQk3TXajR1YKQDwW+tKTX62PFenjj7SCFxkJ5ExZ52BkNrPTdgBaTMt1WLkdzOu
         DhHaa4u3Mqt2ZPd38zry7UUkwC2JqTGUcQHDINpM+5VKuXfRKa3SXzkGylaGbyx50I1Q
         hkXA==
X-Gm-Message-State: AAQBX9ejXoXVpLWgQw/OjrAPoy9Oxoa6dDeIPxPFw7A+4v8A68fN2KPr
        Ha0S9x2nS+5kgpbDLzg2Z+DOVA==
X-Google-Smtp-Source: AKy350b6LQoA5rGQpqDLFBlNL2/hnQq/IHj6AGMX6wydVEoKh/bfJ+60nOh+uj6nzNDIzsJxF6z8kw==
X-Received: by 2002:a5d:4dca:0:b0:2ce:9fb8:b560 with SMTP id f10-20020a5d4dca000000b002ce9fb8b560mr18901769wru.8.1680172072026;
        Thu, 30 Mar 2023 03:27:52 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b002d6f285c0a2sm26352514wrp.42.2023.03.30.03.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:27:51 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 5/7] drbd: drbd_uuid_compare: pass a peer_device
Date:   Thu, 30 Mar 2023 12:27:42 +0200
Message-Id: <20230330102744.2128122-6-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
References: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c6f93a9087b1..e352880c70b5 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3226,10 +3226,11 @@ static void drbd_uuid_dump(struct drbd_device *device, char *text, u64 *uuid,
 -1096   requires proto 96
  */
 
-static int drbd_uuid_compare(struct drbd_device *const device, enum drbd_role const peer_role, int *rule_nr) __must_hold(local)
+static int drbd_uuid_compare(struct drbd_peer_device *const peer_device,
+		enum drbd_role const peer_role, int *rule_nr) __must_hold(local)
 {
-	struct drbd_peer_device *const peer_device = first_peer_device(device);
-	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
+	struct drbd_connection *const connection = peer_device->connection;
+	struct drbd_device *device = peer_device->device;
 	u64 self, peer;
 	int i, j;
 
@@ -3465,7 +3466,7 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 	drbd_uuid_dump(device, "peer", device->p_uuid,
 		       device->p_uuid[UI_SIZE], device->p_uuid[UI_FLAGS]);
 
-	hg = drbd_uuid_compare(device, peer_role, &rule_nr);
+	hg = drbd_uuid_compare(peer_device, peer_role, &rule_nr);
 	spin_unlock_irq(&device->ldev->md.uuid_lock);
 
 	drbd_info(device, "uuid_compare()=%d by rule %d\n", hg, rule_nr);
-- 
2.39.2

