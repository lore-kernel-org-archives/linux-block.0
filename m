Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A973C7618B
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 17:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6D822C7C
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 17:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391141AbfGYRXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:23:55 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39732 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391128AbfGYRXy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 13:23:54 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hqhSv-0001JE-V9; Thu, 25 Jul 2019 11:23:53 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hqhSu-0001n5-TK; Thu, 25 Jul 2019 11:23:40 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 25 Jul 2019 11:23:20 -0600
Message-Id: <20190725172335.6825-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v6 01/16] chardev: factor out cdev_lookup() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Create a new helper out of the code in chrdev_open() which looks up
a struct cdev from a struct inode.

This will be necessary to create a cdev_get_by_path() which is
similar to blkdev_get_by_path() and is required to allow NVMe-OF
passthru to lookup an NVMe controller cdev from a path.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/char_dev.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 00dfe17871ac..5cc53bd5f654 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -367,12 +367,8 @@ void cdev_put(struct cdev *p)
 	}
 }
 
-/*
- * Called every time a character special file is opened
- */
-static int chrdev_open(struct inode *inode, struct file *filp)
+static struct cdev *cdev_lookup(struct inode *inode)
 {
-	const struct file_operations *fops;
 	struct cdev *p;
 	struct cdev *new = NULL;
 	int ret = 0;
@@ -385,7 +381,7 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 		spin_unlock(&cdev_lock);
 		kobj = kobj_lookup(cdev_map, inode->i_rdev, &idx);
 		if (!kobj)
-			return -ENXIO;
+			return ERR_PTR(-ENXIO);
 		new = container_of(kobj, struct cdev, kobj);
 		spin_lock(&cdev_lock);
 		/* Check i_cdev again in case somebody beat us to it while
@@ -402,7 +398,23 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 	spin_unlock(&cdev_lock);
 	cdev_put(new);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
+
+	return p;
+}
+
+/*
+ * Called every time a character special file is opened
+ */
+static int chrdev_open(struct inode *inode, struct file *filp)
+{
+	const struct file_operations *fops;
+	struct cdev *p;
+	int ret = 0;
+
+	p = cdev_lookup(inode);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = -ENXIO;
 	fops = fops_get(p->ops);
-- 
2.20.1

