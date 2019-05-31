Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD5DC28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436C825F06
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEaC2f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:28:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaC2f (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:28:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BE12E1EF7;
        Fri, 31 May 2019 02:28:35 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D109D6FC02;
        Fri, 31 May 2019 02:28:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/9] block: null_blk: introduce module parameter of 'g_host_tags'
Date:   Fri, 31 May 2019 10:27:54 +0800
Message-Id: <20190531022801.10003-3-ming.lei@redhat.com>
In-Reply-To: <20190531022801.10003-1-ming.lei@redhat.com>
References: <20190531022801.10003-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 31 May 2019 02:28:35 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduces parameter of 'g_host_tags' for testing hostwide tags.

Not observe performance drop in the following test:

1) no 'host_tags', hw queue depth is 16, and 1 hw queue
modprobe null_blk queue_mode=2 nr_devices=4 shared_tags=1 host_tags=0 submit_queues=1 hw_queue_depth=16

2) 'host_tags', global hw queue depth is 16, and 8 hw queues
modprobe null_blk queue_mode=2 nr_devices=4 shared_tags=1 host_tags=1 submit_queues=8 hw_queue_depth=16

3) fio test command:

fio --bs=4k --ioengine=libaio --iodepth=16 --filename=/dev/nullb0:/dev/nullb1:/dev/nullb2:/dev/nullb3 --direct=1 --runtime=30 --numjobs=16 --rw=randread --name=test --group_reporting --gtod_reduce=1

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/null_blk_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 447d635c79a2..3c04446f3649 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -91,6 +91,10 @@ static int g_submit_queues = 1;
 module_param_named(submit_queues, g_submit_queues, int, 0444);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
+static int g_host_tags = 0;
+module_param_named(host_tags, g_host_tags, int, S_IRUGO);
+MODULE_PARM_DESC(host_tags, "All submission queues share one tags");
+
 static int g_home_node = NUMA_NO_NODE;
 module_param_named(home_node, g_home_node, int, 0444);
 MODULE_PARM_DESC(home_node, "Home node for the device");
@@ -1554,6 +1558,8 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (g_no_sched)
 		set->flags |= BLK_MQ_F_NO_SCHED;
+	if (g_host_tags)
+		set->flags |= BLK_MQ_F_HOST_TAGS;
 	set->driver_data = NULL;
 
 	if ((nullb && nullb->dev->blocking) || g_blocking)
-- 
2.20.1

