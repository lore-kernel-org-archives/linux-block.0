Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7C8C32750
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 16:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A728208C2
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 16:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfHMQj6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:39:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbfHMQj6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 12:39:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E667314D646;
        Tue, 13 Aug 2019 16:39:55 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-122-147.rdu2.redhat.com [10.10.122.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF3334EE74;
        Tue, 13 Aug 2019 16:39:54 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 1/4] nbd: add set cmd timeout helper
Date:   Tue, 13 Aug 2019 11:39:49 -0500
Message-Id: <20190813163952.23486-2-mchristi@redhat.com>
In-Reply-To: <20190813163952.23486-1-mchristi@redhat.com>
References: <20190813163952.23486-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 13 Aug 2019 16:39:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a helper to set the cmd timeout. It does not really do a lot now,
but will be more useful in the next patches.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/nbd.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e21d2ded732b..69d0e5260e1d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1246,6 +1246,12 @@ static bool nbd_is_valid_blksize(unsigned long blksize)
 	return true;
 }
 
+static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
+{
+	nbd->tag_set.timeout = timeout * HZ;
+	blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
+}
+
 /* Must be called with config_lock held */
 static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		       unsigned int cmd, unsigned long arg)
@@ -1276,10 +1282,8 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		nbd_size_set(nbd, config->blksize, arg);
 		return 0;
 	case NBD_SET_TIMEOUT:
-		if (arg) {
-			nbd->tag_set.timeout = arg * HZ;
-			blk_queue_rq_timeout(nbd->disk->queue, arg * HZ);
-		}
+		if (arg)
+			nbd_set_cmd_timeout(nbd, arg);
 		return 0;
 
 	case NBD_SET_FLAGS:
@@ -1799,11 +1803,9 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto out;
 
-	if (info->attrs[NBD_ATTR_TIMEOUT]) {
-		u64 timeout = nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]);
-		nbd->tag_set.timeout = timeout * HZ;
-		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
-	}
+	if (info->attrs[NBD_ATTR_TIMEOUT])
+		nbd_set_cmd_timeout(nbd,
+				    nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]));
 	if (info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]) {
 		config->dead_conn_timeout =
 			nla_get_u64(info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]);
@@ -1971,11 +1973,9 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto out;
 
-	if (info->attrs[NBD_ATTR_TIMEOUT]) {
-		u64 timeout = nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]);
-		nbd->tag_set.timeout = timeout * HZ;
-		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
-	}
+	if (info->attrs[NBD_ATTR_TIMEOUT])
+		nbd_set_cmd_timeout(nbd,
+				    nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]));
 	if (info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]) {
 		config->dead_conn_timeout =
 			nla_get_u64(info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]);
-- 
2.20.1

