Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D2EC433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Sep 2021 02:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A85610A0
	for <linux-block@archiver.kernel.org>; Fri,  3 Sep 2021 02:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbhICChD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Sep 2021 22:37:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9399 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhICChC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Sep 2021 22:37:02 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H11yV0VYVz8xsJ;
        Fri,  3 Sep 2021 10:31:46 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 10:36:00 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 3 Sep 2021
 10:35:59 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>, <linux-block@vger.kernel.org>,
        <nbd@other.debian.org>, <houtao1@huawei.com>
Subject: [PATCH] nbd: use pr_err to output error message
Date:   Fri, 3 Sep 2021 10:48:45 +0800
Message-ID: <20210903024845.1056742-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of using the long printk(KERN_ERR "nbd: ...") to
output error message, defining pr_fmt and using
the short pr_err("") to do that. The replacemen is done
by using the following command:

  sed -i 's/printk(KERN_ERR "nbd: /pr_err("/g' \
		  drivers/block/nbd.c

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/block/nbd.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2e2eea3d4512..180e53cc5a77 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -44,6 +44,9 @@
 #include <linux/nbd-netlink.h>
 #include <net/genetlink.h>
 
+#undef pr_fmt
+#define pr_fmt(fmt) "nbd: " fmt
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/nbd.h>
 
@@ -1860,11 +1863,11 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NBD_ATTR_INDEX])
 		index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
 	if (!info->attrs[NBD_ATTR_SOCKETS]) {
-		printk(KERN_ERR "nbd: must specify at least one socket\n");
+		pr_err("must specify at least one socket\n");
 		return -EINVAL;
 	}
 	if (!info->attrs[NBD_ATTR_SIZE_BYTES]) {
-		printk(KERN_ERR "nbd: must specify a size in bytes for the device\n");
+		pr_err("must specify a size in bytes for the device\n");
 		return -EINVAL;
 	}
 again:
@@ -1900,7 +1903,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		nbd_put(nbd);
 		if (index == -1)
 			goto again;
-		printk(KERN_ERR "nbd: nbd%d already in use\n", index);
+		pr_err("nbd%d already in use\n", index);
 		return -EBUSY;
 	}
 	if (WARN_ON(nbd->config)) {
@@ -1912,7 +1915,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (IS_ERR(config)) {
 		mutex_unlock(&nbd->config_lock);
 		nbd_put(nbd);
-		printk(KERN_ERR "nbd: couldn't allocate config\n");
+		pr_err("couldn't allocate config\n");
 		return PTR_ERR(config);
 	}
 	nbd->config = config;
@@ -1968,7 +1971,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 			struct nlattr *socks[NBD_SOCK_MAX+1];
 
 			if (nla_type(attr) != NBD_SOCK_ITEM) {
-				printk(KERN_ERR "nbd: socks must be embedded in a SOCK_ITEM attr\n");
+				pr_err("socks must be embedded in a SOCK_ITEM attr\n");
 				ret = -EINVAL;
 				goto out;
 			}
@@ -1977,7 +1980,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 							  nbd_sock_policy,
 							  info->extack);
 			if (ret != 0) {
-				printk(KERN_ERR "nbd: error processing sock list\n");
+				pr_err("error processing sock list\n");
 				ret = -EINVAL;
 				goto out;
 			}
@@ -2051,7 +2054,7 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 		return -EPERM;
 
 	if (!info->attrs[NBD_ATTR_INDEX]) {
-		printk(KERN_ERR "nbd: must specify an index to disconnect\n");
+		pr_err("must specify an index to disconnect\n");
 		return -EINVAL;
 	}
 	index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
@@ -2059,13 +2062,13 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 	nbd = idr_find(&nbd_index_idr, index);
 	if (!nbd) {
 		mutex_unlock(&nbd_index_mutex);
-		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
+		pr_err("couldn't find device at index %d\n",
 		       index);
 		return -EINVAL;
 	}
 	if (!refcount_inc_not_zero(&nbd->refs)) {
 		mutex_unlock(&nbd_index_mutex);
-		printk(KERN_ERR "nbd: device at index %d is going down\n",
+		pr_err("device at index %d is going down\n",
 		       index);
 		return -EINVAL;
 	}
@@ -2091,7 +2094,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		return -EPERM;
 
 	if (!info->attrs[NBD_ATTR_INDEX]) {
-		printk(KERN_ERR "nbd: must specify a device to reconfigure\n");
+		pr_err("must specify a device to reconfigure\n");
 		return -EINVAL;
 	}
 	index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
@@ -2099,7 +2102,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	nbd = idr_find(&nbd_index_idr, index);
 	if (!nbd) {
 		mutex_unlock(&nbd_index_mutex);
-		printk(KERN_ERR "nbd: couldn't find a device at index %d\n",
+		pr_err("couldn't find a device at index %d\n",
 		       index);
 		return -EINVAL;
 	}
@@ -2121,7 +2124,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	}
 	if (!refcount_inc_not_zero(&nbd->refs)) {
 		mutex_unlock(&nbd_index_mutex);
-		printk(KERN_ERR "nbd: device at index %d is going down\n",
+		pr_err("device at index %d is going down\n",
 		       index);
 		return -EINVAL;
 	}
@@ -2186,7 +2189,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 			struct nlattr *socks[NBD_SOCK_MAX+1];
 
 			if (nla_type(attr) != NBD_SOCK_ITEM) {
-				printk(KERN_ERR "nbd: socks must be embedded in a SOCK_ITEM attr\n");
+				pr_err("socks must be embedded in a SOCK_ITEM attr\n");
 				ret = -EINVAL;
 				goto out;
 			}
@@ -2195,7 +2198,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 							  nbd_sock_policy,
 							  info->extack);
 			if (ret != 0) {
-				printk(KERN_ERR "nbd: error processing sock list\n");
+				pr_err("error processing sock list\n");
 				ret = -EINVAL;
 				goto out;
 			}
@@ -2412,7 +2415,7 @@ static int __init nbd_init(void)
 	BUILD_BUG_ON(sizeof(struct nbd_request) != 28);
 
 	if (max_part < 0) {
-		printk(KERN_ERR "nbd: max_part must be >= 0\n");
+		pr_err("max_part must be >= 0\n");
 		return -EINVAL;
 	}
 
@@ -2490,8 +2493,11 @@ static void __exit nbd_cleanup(void)
 	while (!list_empty(&del_list)) {
 		nbd = list_first_entry(&del_list, struct nbd_device, list);
 		list_del_init(&nbd->list);
+		if (refcount_read(&nbd->config_refs))
+			pr_err("possibly leaking nbd_config (ref %d)\n",
+			       refcount_read(&nbd->config_refs));
 		if (refcount_read(&nbd->refs) != 1)
-			printk(KERN_ERR "nbd: possibly leaking a device\n");
+			pr_err("possibly leaking a device\n");
 		nbd_put(nbd);
 	}
 
-- 
2.29.2

