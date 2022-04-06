Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CB3C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 20:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiDFUxP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiDFUwd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 16:52:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FD9F1AC7
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 12:07:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q26so3781323edc.7
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 12:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POlr1a0iTGBoJ3bnuukX0R50RftAjAl0lTvKR+vp4fE=;
        b=lsMjsM8hxfLRElDhpBGCBQAWVxHPdgBMTP0fgUwIURdERrRguIPnGMBktd9IeLNUl0
         QTSMQCDikvX/cPN4g0moz7n7yXWOVjRvKJpzHbdmQloqYiAZ7qGSl0P1uWyEnLMl7bcJ
         HVIl/2ATefvZPve2FGSxSnvynVBVVDeGqyCmU51duL5Gz88iDLthmoj7DrGz/XEBVeJx
         TfUA1W0R58CKFNnbhiFvGEoZyqocemong5+RmVpQYF7FkgQk/ygaQM2FubSmPfq2UFvt
         o3/f9QlfBKhhliDJUZ9nKbRTy8tu9dd4L1S+zc3gkU7pgvMH20Mnegiwv2iqGAk32ZGC
         K2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POlr1a0iTGBoJ3bnuukX0R50RftAjAl0lTvKR+vp4fE=;
        b=FR91iKkxl0epMQuoutQYQN49S0MeTXcRq3dECDcibbJbT3gvoLBmUD1bavfdANJse7
         GuaWcA/qp9z92I1HCOmq2L3QudteU6mkv880bvqHJYASnZ7wa59tc+Hduhx++yXnSgyd
         +6jcXkqqGqApBbd3toNzJulaVxH8fTi7iYLCbvVt1POs8jUdU654T9OsJdYCT9RCSg/v
         A031ZsTJYqgUCozRzGMrmU8bJ1ab+r2869j1eA6iirU7xLRcAUXM1UakeoLe5QrzIhKf
         nIq3R2t6c66wsSUbIfTIOKPs4IRFiuCxyc6wkKHxCZQV/S+tUipbX+Vt8FBVX1Es8WlS
         rBMQ==
X-Gm-Message-State: AOAM530Qf8VDEQjZppwdzlWqaupcTROsSPwYD3NtJh2b5Id9BkEMUyuy
        PdMoRZYVRxWP+wNa5D7qBZsGoA==
X-Google-Smtp-Source: ABdhPJyO9677zCd7VbzMR7POWXOfRfPVkPceRUPrJkIhga3FMwv044ystxo1E0V0UEFKxVx4KhhlTA==
X-Received: by 2002:a05:6402:2050:b0:41c:dd5e:3c63 with SMTP id bc16-20020a056402205000b0041cdd5e3c63mr10339789edb.56.1649272057830;
        Wed, 06 Apr 2022 12:07:37 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090654c300b006e4e1a3e9d5sm6404685ejp.144.2022.04.06.12.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:07:37 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 6/7] drdb: Switch to kvfree_rcu() API
Date:   Wed,  6 Apr 2022 21:07:14 +0200
Message-Id: <20220406190715.1938174-7-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

TO: Jens Axboe <axboe@kernel.dk>
TO: Philipp Reisner <philipp.reisner@linbit.com>
TO: Jason Gunthorpe <jgg@nvidia.com>
TO: drbd-dev@lists.linbit.com
TO: linux-block@vger.kernel.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c       | 9 +++------
 drivers/block/drbd/drbd_receiver.c | 6 ++----
 drivers/block/drbd/drbd_state.c    | 3 +--
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 074b884ec225..ad6e40864b37 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1612,8 +1612,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 			drbd_send_sync_param(peer_device);
 	}
 
-	synchronize_rcu();
-	kfree(old_disk_conf);
+	kvfree_rcu(old_disk_conf);
 	kfree(old_plan);
 	mod_timer(&device->request_timer, jiffies + HZ);
 	goto success;
@@ -2444,8 +2443,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_unlock(&connection->resource->conf_update);
 	mutex_unlock(&connection->data.mutex);
-	synchronize_rcu();
-	kfree(old_net_conf);
+	kvfree_rcu(old_net_conf);
 
 	if (connection->cstate >= C_WF_REPORT_PARAMS) {
 		struct drbd_peer_device *peer_device;
@@ -2859,8 +2857,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 		new_disk_conf->disk_size = (sector_t)rs.resize_size;
 		rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
 		mutex_unlock(&device->resource->conf_update);
-		synchronize_rcu();
-		kfree(old_disk_conf);
+		kvfree_rcu(old_disk_conf);
 		new_disk_conf = NULL;
 	}
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0825766ce910..5e10572a4d3e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3751,8 +3751,7 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
 		drbd_info(connection, "peer data-integrity-alg: %s\n",
 			  integrity_alg[0] ? integrity_alg : "(none)");
 
-	synchronize_rcu();
-	kfree(old_net_conf);
+	kvfree_rcu(old_net_conf);
 	return 0;
 
 disconnect_rcu_unlock:
@@ -4120,8 +4119,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 
 			rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
 			mutex_unlock(&connection->resource->conf_update);
-			synchronize_rcu();
-			kfree(old_disk_conf);
+			kvfree_rcu(old_disk_conf);
 
 			drbd_info(device, "Peer sets u_size to %lu sectors (old: %lu)\n",
 				 (unsigned long)p_usize, (unsigned long)my_usize);
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index b8a27818ab3f..826e496821c7 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -2071,8 +2071,7 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 		conn_free_crypto(connection);
 		mutex_unlock(&connection->resource->conf_update);
 
-		synchronize_rcu();
-		kfree(old_conf);
+		kvfree_rcu(old_conf);
 	}
 
 	if (ns_max.susp_fen) {
-- 
2.35.1

