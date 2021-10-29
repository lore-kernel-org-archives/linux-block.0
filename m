Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E62C433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 10:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53C66113E
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 10:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhJ2KmH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 06:42:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60003 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhJ2Kl4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 06:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635503968; x=1667039968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FeHV+nPR/Sa4soOFiDHHREPz8qUJfvByzu3++hnF21o=;
  b=WDNBiI8i6JqkKeF/4E7QIM8/McgUiykqCyDOQ0gucEVuBH5+v6TGuzFk
   +uuNwpIZv6gUNFQ623Q7MzNOosZKxqvfvrmsVRGZVpTLtJCGQP+5l0y48
   0LaIqQf2JaHpUL12JBXh53+VLdhS8FdHdHWfuQmoIFrhVsLYmRRim4BHx
   SNYcHQJwHILPNEjJXPYmTukrmQXF5RyxX7VWxS23ujQ7nKnSEntdRYMGj
   CNi/5v5GO22ooNIVd/acMYi+w128b9Jg3vKw+eldeXkYgDaq2MT686QKJ
   7m8lyXd0vMr3/t9ocr2culjlUC4dg0jSxSTiaFSsS0puRuYMxOolWmvvT
   g==;
X-IronPort-AV: E=Sophos;i="5.87,192,1631548800"; 
   d="scan'208";a="288062593"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2021 18:39:27 +0800
IronPort-SDR: 0Hm3wR17se/WUo+31kGVrVTQzdJoJHxnkp1RUbC3ZI9wFeRncolxm1p57pPVuxOOQRGJDOIgr2
 3A9dMO8dK5tACfWxvfHQi6hNnUdxVxTXsegIWSbh1Onfp3GiCY/w/bSuDBqhZxUqr32Q0zHb6/
 iI87FmdrOuZJHoOCMSIptwZK6BAyCipWssEFtou90B/5423WzDQXjzXUQ1XZ9T0xhRmi5NZK+8
 L6ntjKZnGDA+xuOFCq67oBW8BNzsCGNLJ/jb7cyGpBedowO21Gi0CdDMNg94+wu9BEpsZBbSCt
 /7Vd6EScp6Jm9RY/nqVvIJPd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 03:14:53 -0700
IronPort-SDR: J/8dWb5abGWKG5FDr6Ij6i8m5JY0/hsUYuPAn3ptuVbcLKA6/auXJBojjEAFtpxV+tJmSM+zbF
 nb0uD0bpRV1Df/iZs5lYY+IlCOjMs8QFI08Su+lsmapvk2e4rV/QOV2X2k46QvMU9AsH8GsdoE
 8+jIa3wDBkYZK2xn5Nm9iNAk5gbdF0J1hB1ks6z1mrWlDpCUELUyzNrYzHCyso94WaO8WCOlG/
 ZZn7U4ZoDFKGmdO/S3dyU6nW9wRQeV8qwzq9/ZU3TO5J9ThmHs6i0gi888mJ7/4LJ7tBP1eltV
 dxs=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2021 03:39:27 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next] null_blk: Fix handling of submit_queues and poll_queues attributes
Date:   Fri, 29 Oct 2021 19:39:26 +0900
Message-Id: <20211029103926.845635-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 0a593fbbc245 ("null_blk: poll queue support") introduced the poll
queue feature to null_blk. After this change, null_blk device has both
submit queues and poll queues, and null_map_queues() callback maps the
both queues for corresponding hardware contexts. The commit also added
the device configuration attribute 'poll_queues' in same manner as the
existing attribute 'submit_queues'. These attributes allow to modify the
numbers of queues. However, when the new values are stored to these
attributes, the values are just handled only for the corresponding
queue. When number of submit_queue is updated, number of poll_queue is
not counted, or vice versa.  This caused inconsistent number of queues
and queue mapping and resulted in null-ptr-dereference. This failure was
observed in blktests block/029 and block/030.

To avoid the inconsistency, fix the attribute updates to care both
submit_queues and poll_queues. Introduce the helper function
nullb_update_nr_hw_queues() to handle stores to the both two attributes.
Add poll_queues field to the struct nullb_device to track the number in
same manner as submit_queues. Add two more fields prev_submit_queues and
prev_poll_queues to keep the previous values before change. In case the
block layer failed to update the nr_hw_queues, refer the previous values
in null_map_queues() to map queues in same manner as before change.

Also add poll_queues value checks in nullb_update_nr_hw_queues() and
null_validate_conf(). They ensure the poll_queues value of each device
is within the range from 1 to module parameter value of poll_queues.

Fixes: 0a593fbbc245 ("null_blk: poll queue support")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c     | 102 +++++++++++++++++++++++++-----
 drivers/block/null_blk/null_blk.h |   2 +
 2 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f4af95c2f9a9..323af5c9c802 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -328,30 +328,69 @@ nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
 }									\
 CONFIGFS_ATTR(nullb_device_, NAME);
 
-static int nullb_apply_submit_queues(struct nullb_device *dev,
-				     unsigned int submit_queues)
+static int nullb_update_nr_hw_queues(struct nullb_device *dev,
+				     unsigned int submit_queues,
+				     unsigned int poll_queues)
+
 {
-	struct nullb *nullb = dev->nullb;
 	struct blk_mq_tag_set *set;
+	int ret, nr_hw_queues;
 
-	if (!nullb)
+	if (!dev->nullb)
 		return 0;
 
+	/*
+	 * Make sure at least one queue exists for each of submit and poll.
+	 */
+	if (!submit_queues || !poll_queues)
+		return -EINVAL;
+
 	/*
 	 * Make sure that null_init_hctx() does not access nullb->queues[] past
 	 * the end of that array.
 	 */
-	if (submit_queues > nr_cpu_ids)
+	if (submit_queues > nr_cpu_ids || poll_queues > g_poll_queues)
 		return -EINVAL;
-	set = nullb->tag_set;
-	blk_mq_update_nr_hw_queues(set, submit_queues);
-	return set->nr_hw_queues == submit_queues ? 0 : -ENOMEM;
+
+	/*
+	 * Keep previous and new queue numbers in nullb_device for reference in
+	 * the call back function null_map_queues().
+	 */
+	dev->prev_submit_queues = dev->submit_queues;
+	dev->prev_poll_queues = dev->poll_queues;
+	dev->submit_queues = submit_queues;
+	dev->poll_queues = poll_queues;
+
+	set = dev->nullb->tag_set;
+	nr_hw_queues = submit_queues + poll_queues;
+	blk_mq_update_nr_hw_queues(set, nr_hw_queues);
+	ret = set->nr_hw_queues == nr_hw_queues ? 0 : -ENOMEM;
+
+	if (ret) {
+		/* on error, revert the queue numbers */
+		dev->submit_queues = dev->prev_submit_queues;
+		dev->poll_queues = dev->prev_poll_queues;
+	}
+
+	return ret;
+}
+
+static int nullb_apply_submit_queues(struct nullb_device *dev,
+				     unsigned int submit_queues)
+{
+	return nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
+}
+
+static int nullb_apply_poll_queues(struct nullb_device *dev,
+				   unsigned int poll_queues)
+{
+	return nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
 }
 
 NULLB_DEVICE_ATTR(size, ulong, NULL);
 NULLB_DEVICE_ATTR(completion_nsec, ulong, NULL);
 NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
-NULLB_DEVICE_ATTR(poll_queues, uint, nullb_apply_submit_queues);
+NULLB_DEVICE_ATTR(poll_queues, uint, nullb_apply_poll_queues);
 NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
@@ -599,7 +638,9 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->size = g_gb * 1024;
 	dev->completion_nsec = g_completion_nsec;
 	dev->submit_queues = g_submit_queues;
+	dev->prev_submit_queues = g_submit_queues;
 	dev->poll_queues = g_poll_queues;
+	dev->prev_poll_queues = g_poll_queues;
 	dev->home_node = g_home_node;
 	dev->queue_mode = g_queue_mode;
 	dev->blocksize = g_bs;
@@ -1465,25 +1506,45 @@ static int null_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nullb *nullb = set->driver_data;
 	int i, qoff;
+	unsigned int submit_queues = g_submit_queues;
+	unsigned int poll_queues = g_poll_queues;
+
+	if (nullb) {
+		struct nullb_device *dev = nullb->dev;
+
+		/*
+		 * Refer nr_hw_queues of the tag set to check if the expected
+		 * number of hardware queues are prepared. If block layer failed
+		 * to prepare them, use previous numbers of submit queues and
+		 * poll queues to map queues.
+		 */
+		if (set->nr_hw_queues ==
+		    dev->submit_queues + dev->poll_queues) {
+			submit_queues = dev->submit_queues;
+			poll_queues = dev->poll_queues;
+		} else if (set->nr_hw_queues ==
+			   dev->prev_submit_queues + dev->prev_poll_queues) {
+			submit_queues = dev->prev_submit_queues;
+			poll_queues = dev->prev_poll_queues;
+		} else {
+			pr_warn("tag set has unexpected nr_hw_queues: %d\n",
+				set->nr_hw_queues);
+			return -EINVAL;
+		}
+	}
 
 	for (i = 0, qoff = 0; i < set->nr_maps; i++) {
 		struct blk_mq_queue_map *map = &set->map[i];
 
 		switch (i) {
 		case HCTX_TYPE_DEFAULT:
-			if (nullb)
-				map->nr_queues = nullb->dev->submit_queues;
-			else
-				map->nr_queues = g_submit_queues;
+			map->nr_queues = submit_queues;
 			break;
 		case HCTX_TYPE_READ:
 			map->nr_queues = 0;
 			continue;
 		case HCTX_TYPE_POLL:
-			if (nullb)
-				map->nr_queues = nullb->dev->poll_queues;
-			else
-				map->nr_queues = g_poll_queues;
+			map->nr_queues = poll_queues;
 			break;
 		}
 		map->queue_offset = qoff;
@@ -1853,6 +1914,13 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->submit_queues = nr_cpu_ids;
 	else if (dev->submit_queues == 0)
 		dev->submit_queues = 1;
+	dev->prev_submit_queues = dev->submit_queues;
+
+	if (dev->poll_queues > g_poll_queues)
+		dev->poll_queues = g_poll_queues;
+	else if (dev->poll_queues == 0)
+		dev->poll_queues = 1;
+	dev->prev_poll_queues = dev->poll_queues;
 
 	dev->queue_mode = min_t(unsigned int, dev->queue_mode, NULL_Q_MQ);
 	dev->irqmode = min_t(unsigned int, dev->irqmode, NULL_IRQ_TIMER);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 90c3eefb3ca3..78eb56b0ca55 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -86,7 +86,9 @@ struct nullb_device {
 	unsigned int zone_max_open; /* max number of open zones */
 	unsigned int zone_max_active; /* max number of active zones */
 	unsigned int submit_queues; /* number of submission queues */
+	unsigned int prev_submit_queues; /* number of submission queues before change */
 	unsigned int poll_queues; /* number of IOPOLL submission queues */
+	unsigned int prev_poll_queues; /* number of IOPOLL submission queues before change */
 	unsigned int home_node; /* home node for the device */
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
-- 
2.31.1

