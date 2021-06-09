Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC3DC48BCD
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 12:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3B61287
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 12:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhFIMQe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 08:16:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3925 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhFIMQc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 08:16:32 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0Qv74T9Sz6w1W;
        Wed,  9 Jun 2021 20:11:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:14:35 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:14:35 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        drbd-dev <drbd-dev@lists.linbit.com>,
        linux-block <linux-block@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] drbd: remove unnecessary oom message
Date:   Wed, 9 Jun 2021 20:14:26 +0800
Message-ID: <20210609121426.13936-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/block/drbd/drbd_receiver.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 69284ebba786..1f740e42e457 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3770,10 +3770,8 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
 	}
 
 	new_net_conf = kmalloc(sizeof(struct net_conf), GFP_KERNEL);
-	if (!new_net_conf) {
-		drbd_err(connection, "Allocation of new net_conf failed\n");
+	if (!new_net_conf)
 		goto disconnect;
-	}
 
 	mutex_lock(&connection->data.mutex);
 	mutex_lock(&connection->resource->conf_update);
@@ -4020,10 +4018,8 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 
 		if (verify_tfm || csums_tfm) {
 			new_net_conf = kzalloc(sizeof(struct net_conf), GFP_KERNEL);
-			if (!new_net_conf) {
-				drbd_err(device, "Allocation of new net_conf failed\n");
+			if (!new_net_conf)
 				goto disconnect;
-			}
 
 			*new_net_conf = *old_net_conf;
 
@@ -4161,7 +4157,6 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 
 			new_disk_conf = kzalloc(sizeof(struct disk_conf), GFP_KERNEL);
 			if (!new_disk_conf) {
-				drbd_err(device, "Allocation of new disk_conf failed\n");
 				put_ldev(device);
 				return -ENOMEM;
 			}
@@ -4288,10 +4283,8 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 	device = peer_device->device;
 
 	p_uuid = kmalloc_array(UI_EXTENDED_SIZE, sizeof(*p_uuid), GFP_NOIO);
-	if (!p_uuid) {
-		drbd_err(device, "kmalloc of p_uuid failed\n");
+	if (!p_uuid)
 		return false;
-	}
 
 	for (i = UI_CURRENT; i < UI_EXTENDED_SIZE; i++)
 		p_uuid[i] = be64_to_cpu(p->uuid[i]);
@@ -5484,8 +5477,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	}
 
 	peers_ch = kmalloc(pi.size, GFP_NOIO);
-	if (peers_ch == NULL) {
-		drbd_err(connection, "kmalloc of peers_ch failed\n");
+	if (!peers_ch) {
 		rv = -1;
 		goto fail;
 	}
@@ -5504,8 +5496,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
 
 	resp_size = crypto_shash_digestsize(connection->cram_hmac_tfm);
 	response = kmalloc(resp_size, GFP_NOIO);
-	if (response == NULL) {
-		drbd_err(connection, "kmalloc of response failed\n");
+	if (!response) {
 		rv = -1;
 		goto fail;
 	}
@@ -5552,8 +5543,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	}
 
 	right_response = kmalloc(resp_size, GFP_NOIO);
-	if (right_response == NULL) {
-		drbd_err(connection, "kmalloc of right_response failed\n");
+	if (!right_response) {
 		rv = -1;
 		goto fail;
 	}
-- 
2.25.1


