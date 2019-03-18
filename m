Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60D4C10F0E
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7533A20857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="it5tXcke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfCRTsb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfCRTs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PzrDonBLtGOEoEdiJDPz4JZO1N6aHkTeofAemL8nqTk=; b=it5tXckeqyyXAC5r2Pfvmy0JY
        5Aa2kunXqByxkL8q04/r+Y+SBnb1z9qNBdr/X8t5Y5FkQpFmqXI2G7FMD+F1erGRkJy0NSlZUG43p
        Wkovnf4TB/lNXgQoPtlUM6WDuEwGJX6M4vRvTNTXQcsgML3UJta+iMVMbIbnQ/7v4Go0riJKF62P1
        vwqGrCEJrpBBeeRACRo1TdAEGRwnXdUqhoaJZ6Ef+0fxOe142jW3UIPcSW4718oQCx0VwQK57ARGe
        yxQmIWmxWdlNyKcPHylqFIjPDSquCgZDt1TiSqhPj6d9lWP3+RcQE7cxZ/VX8nagOpGw7xF1qx1lY
        5dl/XcQIQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFJ-0000w9-CO; Mon, 18 Mar 2019 19:48:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 11/14] nbd: Convert nbd_index_idr to XArray
Date:   Mon, 18 Mar 2019 12:48:18 -0700
Message-Id: <20190318194821.3470-12-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/block/nbd.c | 145 ++++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 86 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 90ba9f4c03f3..6e64884973dd 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -44,8 +44,8 @@
 #include <linux/nbd-netlink.h>
 #include <net/genetlink.h>
 
-static DEFINE_IDR(nbd_index_idr);
-static DEFINE_MUTEX(nbd_index_mutex);
+static DEFINE_XARRAY_ALLOC(nbd_devs);
+static DEFINE_MUTEX(nbd_global_mutex);
 static int nbd_total_devices = 0;
 
 struct nbd_sock {
@@ -223,10 +223,9 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 
 static void nbd_put(struct nbd_device *nbd)
 {
-	if (refcount_dec_and_mutex_lock(&nbd->refs,
-					&nbd_index_mutex)) {
-		idr_remove(&nbd_index_idr, nbd->index);
-		mutex_unlock(&nbd_index_mutex);
+	if (refcount_dec_and_mutex_lock(&nbd->refs, &nbd_global_mutex)) {
+		xa_erase(&nbd_devs, nbd->index);
+		mutex_unlock(&nbd_global_mutex);
 		nbd_dev_remove(nbd);
 	}
 }
@@ -1331,7 +1330,7 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
 	struct nbd_device *nbd;
 	int ret = 0;
 
-	mutex_lock(&nbd_index_mutex);
+	mutex_lock(&nbd_global_mutex);
 	nbd = bdev->bd_disk->private_data;
 	if (!nbd) {
 		ret = -ENXIO;
@@ -1363,7 +1362,7 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
 		bdev->bd_invalidated = 1;
 	}
 out:
-	mutex_unlock(&nbd_index_mutex);
+	mutex_unlock(&nbd_global_mutex);
 	return ret;
 }
 
@@ -1551,15 +1550,13 @@ static int nbd_dev_add(int index)
 		goto out_free_nbd;
 
 	if (index >= 0) {
-		err = idr_alloc(&nbd_index_idr, nbd, index, index + 1,
-				GFP_KERNEL);
-		if (err == -ENOSPC)
-			err = -EEXIST;
+		err = xa_insert(&nbd_devs, index, nbd, GFP_KERNEL);
 	} else {
-		err = idr_alloc(&nbd_index_idr, nbd, 0, 0, GFP_KERNEL);
-		if (err >= 0)
-			index = err;
+		err = xa_alloc(&nbd_devs, &index, nbd, xa_limit_32b,
+				GFP_KERNEL);
 	}
+	if (err == -EBUSY)
+		err = -EEXIST;
 	if (err < 0)
 		goto out_free_disk;
 
@@ -1576,7 +1573,7 @@ static int nbd_dev_add(int index)
 
 	err = blk_mq_alloc_tag_set(&nbd->tag_set);
 	if (err)
-		goto out_free_idr;
+		goto out_free_dev;
 
 	q = blk_mq_init_queue(&nbd->tag_set);
 	if (IS_ERR(q)) {
@@ -1613,8 +1610,8 @@ static int nbd_dev_add(int index)
 
 out_free_tags:
 	blk_mq_free_tag_set(&nbd->tag_set);
-out_free_idr:
-	idr_remove(&nbd_index_idr, index);
+out_free_dev:
+	xa_erase(&nbd_devs, index);
 out_free_disk:
 	put_disk(disk);
 out_free_nbd:
@@ -1623,18 +1620,6 @@ static int nbd_dev_add(int index)
 	return err;
 }
 
-static int find_free_cb(int id, void *ptr, void *data)
-{
-	struct nbd_device *nbd = ptr;
-	struct nbd_device **found = data;
-
-	if (!refcount_read(&nbd->config_refs)) {
-		*found = nbd;
-		return 1;
-	}
-	return 0;
-}
-
 /* Netlink interface. */
 static const struct nla_policy nbd_attr_policy[NBD_ATTR_MAX + 1] = {
 	[NBD_ATTR_INDEX]		=	{ .type = NLA_U32 },
@@ -1683,46 +1668,51 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 again:
-	mutex_lock(&nbd_index_mutex);
+	mutex_lock(&nbd_global_mutex);
 	if (index == -1) {
-		ret = idr_for_each(&nbd_index_idr, &find_free_cb, &nbd);
-		if (ret == 0) {
+		unsigned long i;
+		xa_for_each(&nbd_devs, i, nbd) {
+			if (!refcount_read(&nbd->config_refs))
+				break;
+		}
+
+		if (!nbd) {
 			int new_index;
 			new_index = nbd_dev_add(-1);
 			if (new_index < 0) {
-				mutex_unlock(&nbd_index_mutex);
+				mutex_unlock(&nbd_global_mutex);
 				printk(KERN_ERR "nbd: failed to add new device\n");
 				return new_index;
 			}
-			nbd = idr_find(&nbd_index_idr, new_index);
+			nbd = xa_load(&nbd_devs, new_index);
 		}
 	} else {
-		nbd = idr_find(&nbd_index_idr, index);
+		nbd = xa_load(&nbd_devs, index);
 		if (!nbd) {
 			ret = nbd_dev_add(index);
 			if (ret < 0) {
-				mutex_unlock(&nbd_index_mutex);
+				mutex_unlock(&nbd_global_mutex);
 				printk(KERN_ERR "nbd: failed to add new device\n");
 				return ret;
 			}
-			nbd = idr_find(&nbd_index_idr, index);
+			nbd = xa_load(&nbd_devs, index);
 		}
 	}
 	if (!nbd) {
+		mutex_unlock(&nbd_global_mutex);
 		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
 		       index);
-		mutex_unlock(&nbd_index_mutex);
 		return -EINVAL;
 	}
 	if (!refcount_inc_not_zero(&nbd->refs)) {
-		mutex_unlock(&nbd_index_mutex);
+		mutex_unlock(&nbd_global_mutex);
 		if (index == -1)
 			goto again;
 		printk(KERN_ERR "nbd: device at index %d is going down\n",
 		       index);
 		return -EINVAL;
 	}
-	mutex_unlock(&nbd_index_mutex);
+	mutex_unlock(&nbd_global_mutex);
 
 	mutex_lock(&nbd->config_lock);
 	if (refcount_read(&nbd->config_refs)) {
@@ -1850,21 +1840,21 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 	index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
-	mutex_lock(&nbd_index_mutex);
-	nbd = idr_find(&nbd_index_idr, index);
+	mutex_lock(&nbd_global_mutex);
+	nbd = xa_load(&nbd_devs, index);
 	if (!nbd) {
-		mutex_unlock(&nbd_index_mutex);
+		mutex_unlock(&nbd_global_mutex);
 		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
 		       index);
 		return -EINVAL;
 	}
 	if (!refcount_inc_not_zero(&nbd->refs)) {
-		mutex_unlock(&nbd_index_mutex);
+		mutex_unlock(&nbd_global_mutex);
 		printk(KERN_ERR "nbd: device at index %d is going down\n",
 		       index);
 		return -EINVAL;
 	}
-	mutex_unlock(&nbd_index_mutex);
+	mutex_unlock(&nbd_global_mutex);
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		nbd_put(nbd);
 		return 0;
@@ -1891,21 +1881,21 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 	index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
-	mutex_lock(&nbd_index_mutex);
-	nbd = idr_find(&nbd_index_idr, index);
+	mutex_lock(&nbd_global_mutex);
+	nbd = xa_load(&nbd_devs, index);
 	if (!nbd) {
-		mutex_unlock(&nbd_index_mutex);
+		mutex_unlock(&nbd_global_mutex);
 		printk(KERN_ERR "nbd: couldn't find a device at index %d\n",
 		       index);
 		return -EINVAL;
 	}
 	if (!refcount_inc_not_zero(&nbd->refs)) {
-		mutex_unlock(&nbd_index_mutex);
+		mutex_unlock(&nbd_global_mutex);
 		printk(KERN_ERR "nbd: device at index %d is going down\n",
 		       index);
 		return -EINVAL;
 	}
-	mutex_unlock(&nbd_index_mutex);
+	mutex_unlock(&nbd_global_mutex);
 
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		dev_err(nbd_to_dev(nbd),
@@ -2044,7 +2034,7 @@ static int populate_nbd_status(struct nbd_device *nbd, struct sk_buff *reply)
 	/* This is a little racey, but for status it's ok.  The
 	 * reason we don't take a ref here is because we can't
 	 * take a ref in the index == -1 case as we would need
-	 * to put under the nbd_index_mutex, which could
+	 * to put under the nbd_global_mutex, which could
 	 * deadlock if we are configured to remove ourselves
 	 * once we're disconnected.
 	 */
@@ -2064,16 +2054,11 @@ static int populate_nbd_status(struct nbd_device *nbd, struct sk_buff *reply)
 	return 0;
 }
 
-static int status_cb(int id, void *ptr, void *data)
-{
-	struct nbd_device *nbd = ptr;
-	return populate_nbd_status(nbd, (struct sk_buff *)data);
-}
-
 static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *dev_list;
 	struct sk_buff *reply;
+	struct nbd_device *nbd;
 	void *reply_head;
 	size_t msg_size;
 	int index = -1;
@@ -2082,7 +2067,7 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NBD_ATTR_INDEX])
 		index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
 
-	mutex_lock(&nbd_index_mutex);
+	mutex_lock(&nbd_global_mutex);
 
 	msg_size = nla_total_size(nla_attr_size(sizeof(u32)) +
 				  nla_attr_size(sizeof(u8)));
@@ -2100,14 +2085,17 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 
 	dev_list = nla_nest_start(reply, NBD_ATTR_DEVICE_LIST);
 	if (index == -1) {
-		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
-		if (ret) {
-			nlmsg_free(reply);
-			goto out;
+		unsigned long i;
+
+		xa_for_each(&nbd_devs, i, nbd) {
+			ret = populate_nbd_status(nbd, reply);
+			if (ret) {
+				nlmsg_free(reply);
+				goto out;
+			}
 		}
 	} else {
-		struct nbd_device *nbd;
-		nbd = idr_find(&nbd_index_idr, index);
+		nbd = xa_load(&nbd_devs, index);
 		if (nbd) {
 			ret = populate_nbd_status(nbd, reply);
 			if (ret) {
@@ -2120,7 +2108,7 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	genlmsg_end(reply, reply_head);
 	ret = genlmsg_reply(reply, info);
 out:
-	mutex_unlock(&nbd_index_mutex);
+	mutex_unlock(&nbd_global_mutex);
 	return ret;
 }
 
@@ -2229,42 +2217,27 @@ static int __init nbd_init(void)
 	}
 	nbd_dbg_init();
 
-	mutex_lock(&nbd_index_mutex);
+	mutex_lock(&nbd_global_mutex);
 	for (i = 0; i < nbds_max; i++)
 		nbd_dev_add(i);
-	mutex_unlock(&nbd_index_mutex);
-	return 0;
-}
-
-static int nbd_exit_cb(int id, void *ptr, void *data)
-{
-	struct list_head *list = (struct list_head *)data;
-	struct nbd_device *nbd = ptr;
-
-	list_add_tail(&nbd->list, list);
+	mutex_unlock(&nbd_global_mutex);
 	return 0;
 }
 
 static void __exit nbd_cleanup(void)
 {
 	struct nbd_device *nbd;
-	LIST_HEAD(del_list);
+	unsigned long index;
 
 	nbd_dbg_close();
 
-	mutex_lock(&nbd_index_mutex);
-	idr_for_each(&nbd_index_idr, &nbd_exit_cb, &del_list);
-	mutex_unlock(&nbd_index_mutex);
-
-	while (!list_empty(&del_list)) {
-		nbd = list_first_entry(&del_list, struct nbd_device, list);
-		list_del_init(&nbd->list);
+	xa_for_each(&nbd_devs, index, nbd) {
 		if (refcount_read(&nbd->refs) != 1)
 			printk(KERN_ERR "nbd: possibly leaking a device\n");
 		nbd_put(nbd);
 	}
 
-	idr_destroy(&nbd_index_idr);
+	xa_destroy(&nbd_devs);
 	genl_unregister_family(&nbd_genl_family);
 	destroy_workqueue(recv_workqueue);
 	unregister_blkdev(NBD_MAJOR, "nbd");
-- 
2.20.1

