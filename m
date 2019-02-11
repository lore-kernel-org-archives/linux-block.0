Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40880C282C2
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 03:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C91620873
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 03:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfBKD2N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 22:28:13 -0500
Received: from mout.gmx.net ([212.227.15.15]:58625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfBKD2N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 22:28:13 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0LwJRe-1h9r0O09mw-0181Xg; Mon, 11 Feb 2019 04:28:10 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: refactor register_blkdev() to compare major number when allocating unused major number
Date:   Mon, 11 Feb 2019 11:26:19 +0800
Message-Id: <20190211032619.29208-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V+cJZ0pdJeZbiFkDkQa9BFO/CYjrqlBb0SmMPOTJ3GsARuWsj8D
 1O+sIRSXyGaVDJIjs3nKQf9QZz/PKxgy2FrRNBW2M2VEnpggCh+toAbL4jgjhFzfYsWiKAn
 MPuAOLXCcXmdwlRn/0riAPhemNWdreBlyND9TzIZf2HyV12O4Brh2c/yMHUBAH1H8mPC6IC
 39wwcPiSrwAPWWbFJJduw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jo0MizC7U1A=:dBGr24Qy2TxfGfyYabWX1+
 XEWhHIt/3lORmiK3wlQS65rOPS6v1bdgWYzBvHE6sILmARYywjVxvwWssvw/Y82PJYLccTNSk
 xkpHbmOYCl1yocEAuj9lmlW/HtTyWHrCYXMG0JpQrJMKbbv6guKZe6LYHzaoDWBbEK/v48BhX
 /+MYxuR+Rq5A47ZRlTMJxtieQY64Cq6c2dmyk1oYchaNrZhpmLfHrUqJ5lgRdn5WUEH+aO1cs
 GP6xbYS3lQbVt0N2jDvknQnhabR3BMlnl5zCjzWtHt1gscVLb/Y5PPyJhgbE/PiUFiWeozWv8
 DBRgNeINNWSa3BtIw/6URbv3YSpRfBHd1bOUDfFV0RBaxdR8tu1p94okalxMAiypXRm9FloBy
 pjq2WXviZb3yKVW5yaJCiZOS6lnNK50KISKCXRM6B92Y4j0Uf3XuOF1BmIwgdDPr8KYQ1vzR5
 ypRoWc2KegEhXLSpOGEcjW7MVR1vveVMgWWhS7KwXsmabCRZY4ocWrd1YpxZnJtz3bo3RLkGo
 Kq4ZqHBf/hrZSXgMEbOuLI0306xkqomYcjX7UxYSFnSfxsQO78bF8IcgVeLAtyIcn+3vsYrlp
 jF5uq4qbahSnuM3+3OmrxSKAr9cqO+oZBwRUOPc4Wg3IgZeBXoGDOd2W9mPWxzqjYdIruw8A5
 So6cpXPSIstI+wOux4DeEV7Yzy/HZPpLqKL5y0Y/tzDJfxJ0/Tch33d/T80fculKLBQR1EVQz
 RC16qVKIPEv4uAR5GBdGXYVommjGxXGYD4MGv+4qciYIUWrFSWvaGvqnHvbrUNbFSdlyjBJ9K
 q6JwulYzYw191MEok2VE7W+fDDXLXJN+ScIyKHWwpMMdPvKrUxnu24Iw9Q6j8RhRTx1/Ri2RQ
 Svm717aXKnh0UnhIQQxSk373r1u8y6S1E0WkJLQOFkXo0tcGgTpop43ZfQYgRN
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently when specifying major number as 0,
register_blkdev() will try to alloc any unused
major number in the range. However, the allocating
logic does not accuretaly compare major number
with existing entries, so even we have plenty of
available major numbers but still might fail with
-EBUSY in extreme case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/genhd.c | 103 ++++++++++++++++++++++++++------------------------
 1 file changed, 54 insertions(+), 49 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1dd8fd6613b8..80b788ed17d1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -330,6 +330,40 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
 }
 #endif /* CONFIG_PROC_FS */
 
+static int __register_blkdev(unsigned int major, const char *name,
+			     struct blk_major_name *new)
+{
+	struct blk_major_name *n, *p = NULL;
+	int index = major_to_index(major);
+
+	for (n = major_names[index]; n; n = n->next) {
+		if (n->major == major)
+			return -EBUSY;
+		p = n;
+	}
+
+	new->major = major;
+	if (p == NULL)
+		major_names[index] = new;
+	else
+		p->next = new;
+
+	return 0;
+}
+
+static int alloc_blkdev(unsigned int major, const char *name,
+			struct blk_major_name *new)
+{
+	int index;
+
+	for (index = ARRAY_SIZE(major_names) - 1; index; index--) {
+		if (__register_blkdev(index, name, new) == 0)
+			return index;
+	}
+
+	return -EBUSY;
+}
+
 /**
  * register_blkdev - register a new block device
  *
@@ -345,73 +379,44 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  *    then the function returns zero on success, or a negative error code
  *  - if any unused major number was requested with @major = 0 parameter
  *    then the return value is the allocated major number in range
- *    [1..BLKDEV_MAJOR_MAX-1] or a negative error code otherwise
+ *    [1..BLKDEV_MAJOR_HASH_SIZE-1] or a negative error code otherwise
  *
  * See Documentation/admin-guide/devices.txt for the list of allocated
  * major numbers.
  */
 int register_blkdev(unsigned int major, const char *name)
 {
-	struct blk_major_name **n, *p;
-	int index, ret = 0;
-
-	mutex_lock(&block_class_lock);
-
-	/* temporary */
-	if (major == 0) {
-		for (index = ARRAY_SIZE(major_names)-1; index > 0; index--) {
-			if (major_names[index] == NULL)
-				break;
-		}
-
-		if (index == 0) {
-			printk("register_blkdev: failed to get major for %s\n",
-			       name);
-			ret = -EBUSY;
-			goto out;
-		}
-		major = index;
-		ret = major;
-	}
+	struct blk_major_name *new;
+	int ret;
 
 	if (major >= BLKDEV_MAJOR_MAX) {
-		pr_err("register_blkdev: major requested (%u) is greater than the maximum (%u) for %s\n",
-		       major, BLKDEV_MAJOR_MAX-1, name);
-
-		ret = -EINVAL;
-		goto out;
+		pr_err("%s: major requested (%u) is greater than the maximum (%u) for %s\n",
+			__func__, major, BLKDEV_MAJOR_MAX-1, name);
+		return -EINVAL;
 	}
 
-	p = kmalloc(sizeof(struct blk_major_name), GFP_KERNEL);
-	if (p == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	new = kmalloc(sizeof(struct blk_major_name), GFP_KERNEL);
+	if (new == NULL)
+		return -ENOMEM;
 
-	p->major = major;
-	strlcpy(p->name, name, sizeof(p->name));
-	p->next = NULL;
-	index = major_to_index(major);
+	strlcpy(new->name, name, sizeof(new->name));
+	new->next = NULL;
 
-	for (n = &major_names[index]; *n; n = &(*n)->next) {
-		if ((*n)->major == major)
-			break;
-	}
-	if (!*n)
-		*n = p;
+	mutex_lock(&block_class_lock);
+	if (major == 0)
+		ret = alloc_blkdev(major, name, new);
 	else
-		ret = -EBUSY;
+		ret = __register_blkdev(major, name, new);
+	mutex_unlock(&block_class_lock);
 
 	if (ret < 0) {
-		printk("register_blkdev: cannot get major %u for %s\n",
-		       major, name);
-		kfree(p);
+		kfree(new);
+		pr_err("%s: cannot get major for %s, major requested (%u)\n",
+			__func__, name, major);
 	}
-out:
-	mutex_unlock(&block_class_lock);
+
 	return ret;
 }
-
 EXPORT_SYMBOL(register_blkdev);
 
 void unregister_blkdev(unsigned int major, const char *name)
-- 
2.20.1

