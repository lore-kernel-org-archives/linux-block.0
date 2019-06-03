Return-Path: <SRS0=uYlv=UC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3073FC04AB6
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 07:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7C626A4F
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 07:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oXsGFbPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFCHrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:47:41 -0400
Received: from m12-15.163.com ([220.181.12.15]:49394 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfFCHrl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Jun 2019 03:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=ZMvxb
        kJPxCc8aQHOrl2raNoEWpWe+R9L0eWNMBdWvcM=; b=oXsGFbPowlb8huIJzdfH5
        5+aQE3vvfQgcsrIhboBnXjczmRUmNWdu50VwRKgr+H28dkVZPyMafl+155mGU7at
        x9BicSAC3j0fCsYjJvQhwk9IUqD/57yQQGE4WHBMMS+oTQ773mQlednzk9Rok+3w
        saUZitPUbJO3b3Ayu6r4xI=
Received: from tero-machine (unknown [124.16.85.241])
        by smtp11 (Coremail) with SMTP id D8CowACHNJpu0PRcTYzGBA--.5677S3;
        Mon, 03 Jun 2019 15:46:54 +0800 (CST)
Date:   Mon, 3 Jun 2019 15:46:53 +0800
From:   Lin Yi <teroincn@163.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, liujian6@iie.ac.cn, csong@cs.ucr.edu,
        zhiyunq@cs.ucr.edu, yiqiuping@gmail.com, teroincn@163.com
Subject: [PATCH] block :blk-sysfs: fix refcount imbalance on the error path
Message-ID: <20190603074653.GA12767@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CM-TRANSID: D8CowACHNJpu0PRcTYzGBA--.5677S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcs2-UUUUU
X-Originating-IP: [124.16.85.241]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiwBjIElXllQyp8wAAsx
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kobject_add takes a refcount to the object dev->kobj, but forget to
release it on the error path, lead to a memory leak.

Signed-off-by: Lin Yi <teroincn@163.com>
---
 block/blk-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 75b5281..539b7cb 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -971,6 +971,7 @@ int blk_register_queue(struct gendisk *disk)
 	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
 	if (ret < 0) {
 		blk_trace_remove_sysfs(dev);
+		kobject_put(&dev->kobj);
 		goto unlock;
 	}
 
-- 
1.9.1


