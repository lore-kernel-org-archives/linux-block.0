Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0604C33CB1
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 11:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6921622522
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 11:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5qhpW5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgAOLpm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 06:45:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42251 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729841AbgAOLpl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 06:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579088740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ajIlPESgBrh1KWK3hts6HUKkW3AJfbbvRA8AzJsWt5c=;
        b=M5qhpW5GppyHV5iSXn+pj500ITTkl+EXBXnx1hvq3JjFBrcnOiOTlMQYKgGXUMm0GKOvTO
        D+V5tdo1ka8quUFmqpN7qKsRl3PcZHk/yF20Rn6xu+7PhLOoAzMkq7bnRBq6/KaXgGqv8R
        9Cb3tfgrzf143gotYM4P8Tfrl+HRxLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-7eYry7NhPxSttv1jW0H-4w-1; Wed, 15 Jan 2020 06:45:36 -0500
X-MC-Unique: 7eYry7NhPxSttv1jW0H-4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CF421005512;
        Wed, 15 Jan 2020 11:45:35 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E60CF5C1D6;
        Wed, 15 Jan 2020 11:45:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/6] blk-mq: prepare for draining IO when hctx's all CPUs are offline
Date:   Wed, 15 Jan 2020 19:44:05 +0800
Message-Id: <20200115114409.28895-3-ming.lei@redhat.com>
In-Reply-To: <20200115114409.28895-1-ming.lei@redhat.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
up queue mapping. Thomas mentioned the following point[1]:

"
 That was the constraint of managed interrupts from the very beginning:

  The driver/subsystem has to quiesce the interrupt line and the associat=
ed
  queue _before_ it gets shutdown in CPU unplug and not fiddle with it
  until it's restarted by the core when the CPU is plugged in again.
"

However, current blk-mq implementation doesn't quiesce hw queue before
the last CPU in the hctx is shutdown. Even worse, CPUHP_BLK_MQ_DEAD is
one cpuhp state handled after the CPU is down, so there isn't any chance
to quiesce hctx for blk-mq wrt. CPU hotplug.

Add new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE for blk-mq to stop queues
and wait for completion of in-flight requests.

We will stop hw queue and wait for completion of in-flight requests
when one hctx is becoming dead in the following patch. This way may
cause dead-lock for some stacking blk-mq drivers, such as dm-rq and
loop.

Add blk-mq flag of BLK_MQ_F_NO_MANAGED_IRQ and mark it for dm-rq and
loop, so we needn't to wait for completion of in-flight requests from
dm-rq & loop, then the potential dead-lock can be avoided.

[1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.180=
2@nanos.tec.linutronix.de/

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c     |  1 +
 block/blk-mq.c             | 13 +++++++++++++
 drivers/block/loop.c       |  2 +-
 drivers/md/dm-rq.c         |  2 +-
 include/linux/blk-mq.h     |  3 +++
 include/linux/cpuhotplug.h |  1 +
 6 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index d6de4f7f38cb..b62390918ca5 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -240,6 +240,7 @@ static const char *const hctx_flag_name[] =3D {
 	HCTX_FLAG_NAME(TAG_SHARED),
 	HCTX_FLAG_NAME(BLOCKING),
 	HCTX_FLAG_NAME(NO_SCHED),
+	HCTX_FLAG_NAME(NO_MANAGED_IRQ),
 };
 #undef HCTX_FLAG_NAME
=20
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a12b1763508d..0f55bb92b16f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2244,6 +2244,11 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, s=
truct blk_mq_tags *tags,
 	return -ENOMEM;
 }
=20
+static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node=
 *node)
+{
+	return 0;
+}
+
 /*
  * 'cpu' is going away. splice any existing rq_list entries from this
  * software queue to the hw queue dispatch list, and ensure that it
@@ -2280,6 +2285,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu=
, struct hlist_node *node)
=20
 static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
 {
+	if (!(hctx->flags & BLK_MQ_F_NO_MANAGED_IRQ))
+		cpuhp_state_remove_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+						    &hctx->cpuhp_online);
 	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
 					    &hctx->cpuhp_dead);
 }
@@ -2339,6 +2347,9 @@ static int blk_mq_init_hctx(struct request_queue *q=
,
 {
 	hctx->queue_num =3D hctx_idx;
=20
+	if (!(hctx->flags & BLK_MQ_F_NO_MANAGED_IRQ))
+		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+				&hctx->cpuhp_online);
 	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
=20
 	hctx->tags =3D set->tags[hctx_idx];
@@ -3585,6 +3596,8 @@ static int __init blk_mq_init(void)
 {
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
+	cpuhp_setup_state_multi(CPUHP_AP_BLK_MQ_ONLINE, "block/mq:online",
+				NULL, blk_mq_hctx_notify_online);
 	return 0;
 }
 subsys_initcall(blk_mq_init);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..651dadd9be12 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2012,7 +2012,7 @@ static int loop_add(struct loop_device **l, int i)
 	lo->tag_set.queue_depth =3D 128;
 	lo->tag_set.numa_node =3D NUMA_NO_NODE;
 	lo->tag_set.cmd_size =3D sizeof(struct loop_cmd);
-	lo->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
+	lo->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_MANAGED_IRQ;
 	lo->tag_set.driver_data =3D lo;
=20
 	err =3D blk_mq_alloc_tag_set(&lo->tag_set);
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 3f8577e2c13b..5f1ff70ac029 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -547,7 +547,7 @@ int dm_mq_init_request_queue(struct mapped_device *md=
, struct dm_table *t)
 	md->tag_set->ops =3D &dm_mq_ops;
 	md->tag_set->queue_depth =3D dm_get_blk_mq_queue_depth();
 	md->tag_set->numa_node =3D md->numa_node_id;
-	md->tag_set->flags =3D BLK_MQ_F_SHOULD_MERGE;
+	md->tag_set->flags =3D BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_MANAGED_IRQ;
 	md->tag_set->nr_hw_queues =3D dm_get_blk_mq_nr_hw_queues();
 	md->tag_set->driver_data =3D md;
=20
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b669e776d4cb..ca2201435a48 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -140,6 +140,8 @@ struct blk_mq_hw_ctx {
 	 */
 	atomic_t		nr_active;
=20
+	/** @cpuhp_online: List to store request if CPU is going to die */
+	struct hlist_node	cpuhp_online;
 	/** @cpuhp_dead: List to store request if some CPU die. */
 	struct hlist_node	cpuhp_dead;
 	/** @kobj: Kernel object for sysfs. */
@@ -388,6 +390,7 @@ struct blk_mq_ops {
 enum {
 	BLK_MQ_F_SHOULD_MERGE	=3D 1 << 0,
 	BLK_MQ_F_TAG_SHARED	=3D 1 << 1,
+	BLK_MQ_F_NO_MANAGED_IRQ	=3D 1 << 2,
 	BLK_MQ_F_BLOCKING	=3D 1 << 5,
 	BLK_MQ_F_NO_SCHED	=3D 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT =3D 8,
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e51ee772b9f5..48b7cb04224a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -149,6 +149,7 @@ enum cpuhp_state {
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
+	CPUHP_AP_BLK_MQ_ONLINE,
 	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
 	CPUHP_AP_X86_INTEL_EPB_ONLINE,
 	CPUHP_AP_PERF_ONLINE,
--=20
2.20.1

