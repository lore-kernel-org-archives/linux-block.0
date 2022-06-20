Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C331C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 03:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiFTDuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 23:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiFTDuJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 23:50:09 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C15260D5
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 20:50:08 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655697007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSvZ1x3ZVz8afg9wrnyoQ7JqW9Pkom0vDzE0WuJYBPM=;
        b=GWE98LsAiyIgNvIHOvmpFg8LXvsNkSFDBWFXTM93jRlNGwz4jUB8eaAtV+B7F8qyI+LS7z
        ZHGJkQdyGViR4EfN0dO1Vz1y0h4IUngIbzK+sKnFUQalQ0jwYirTbsrivqC3jx3GSsNkA1
        iPfI3Iya5s9SZQ+mDUnysCTOH61vS4E=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [RFC PATCH 5/6] rnbd-clt: adjust the layout of struct rnbd_clt_dev
Date:   Mon, 20 Jun 2022 11:49:22 +0800
Message-Id: <20220620034923.35633-6-guoqing.jiang@linux.dev>
In-Reply-To: <20220620034923.35633-1-guoqing.jiang@linux.dev>
References: <20220620034923.35633-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While at it, let re-arrange the struct to remove holes.

Before, pahole reports

	/* size: 232, cachelines: 4, members: 17 */
	/* sum members: 224, holes: 2, sum holes: 8 */
	/* last cacheline: 40 bytes */

After the change, the report changes to

	/* size: 224, cachelines: 4, members: 17 */
	/* last cacheline: 32 bytes */

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 7520272541b1..df237d2ea0d9 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -106,6 +106,7 @@ struct rnbd_queue {
 };
 
 struct rnbd_clt_dev {
+	struct kobject		kobj;
 	struct rnbd_clt_session	*sess;
 	struct request_queue	*queue;
 	struct rnbd_queue	*hw_queues;
@@ -114,15 +115,14 @@ struct rnbd_clt_dev {
 	u32			clt_device_id;
 	struct mutex		lock;
 	enum rnbd_clt_dev_state	dev_state;
+	refcount_t		refcount;
 	char			*pathname;
 	enum rnbd_access_mode	access_mode;
 	u32			nr_poll_queues;
 	u64			size;		/* device size in bytes */
 	struct list_head        list;
 	struct gendisk		*gd;
-	struct kobject		kobj;
 	char			*blk_symlink_name;
-	refcount_t		refcount;
 	struct work_struct	unmap_on_rmmod_work;
 };
 
-- 
2.34.1

