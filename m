Return-Path: <SRS0=Yh1G=6Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF692C3A5A9
	for <linux-block@archiver.kernel.org>; Sat,  2 May 2020 23:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B917A20721
	for <linux-block@archiver.kernel.org>; Sat,  2 May 2020 23:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y23fFyub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgEBXzz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 May 2020 19:55:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725798AbgEBXzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 May 2020 19:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588463753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4cYmu8u7Su/YfxI55lR2XgTo3nEgPIwvTivtINlM90A=;
        b=Y23fFyubpw4a2l7oMEAY1mLXNpdflMGQfJZUcNGXkzdPh8vt1yVlAT09Zx5fZXyX+3GawI
        cylVJ5KZdDs6WvckiIo4HhF55/80hdzur0NmHq0SwNY+S0U4gFt564CiGOtnhM2vAZt0vu
        4OTsyVj/B4ULRTX6Vg6soamY8rpc3FA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-4OzhKVm1OW2QX_uy5z9-1g-1; Sat, 02 May 2020 19:55:47 -0400
X-MC-Unique: 4OzhKVm1OW2QX_uy5z9-1g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65AEB87308F;
        Sat,  2 May 2020 23:55:46 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8610260612;
        Sat,  2 May 2020 23:55:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V9 06/11] blk-mq: prepare for draining IO when hctx's all CPUs are offline
Date:   Sun,  3 May 2020 07:54:49 +0800
Message-Id: <20200502235454.1118520-7-ming.lei@redhat.com>
In-Reply-To: <20200502235454.1118520-1-ming.lei@redhat.com>
References: <20200502235454.1118520-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c     |  1 +
 block/blk-mq.c             | 19 +++++++++++++++++++
 drivers/block/loop.c       |  2 +-
 drivers/md/dm-rq.c         |  2 +-
 include/linux/blk-mq.h     |  3 +++
 include/linux/cpuhotplug.h |  1 +
 6 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 96b7a35c898a..ddec58743e88 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -239,6 +239,7 @@ static const char *const hctx_flag_name[] =3D {
 	HCTX_FLAG_NAME(TAG_SHARED),
 	HCTX_FLAG_NAME(BLOCKING),
 	HCTX_FLAG_NAME(NO_SCHED),
+	HCTX_FLAG_NAME(NO_MANAGED_IRQ),
 };
 #undef HCTX_FLAG_NAME
=20
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6569d802e0d8..54c107be7a47 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2273,6 +2273,16 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, s=
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
+static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_nod=
e *node)
+{
+	return 0;
+}
+
 /*
  * 'cpu' is going away. splice any existing rq_list entries from this
  * software queue to the hw queue dispatch list, and ensure that it
@@ -2309,6 +2319,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu=
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
@@ -2368,6 +2381,9 @@ static int blk_mq_init_hctx(struct request_queue *q=
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
@@ -3621,6 +3637,9 @@ static int __init blk_mq_init(void)
 {
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
+	cpuhp_setup_state_multi(CPUHP_AP_BLK_MQ_ONLINE, "block/mq:online",
+				blk_mq_hctx_notify_online,
+				blk_mq_hctx_notify_offline);
 	return 0;
 }
 subsys_initcall(blk_mq_init);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da693e6a834e..784f2e038b55 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2037,7 +2037,7 @@ static int loop_add(struct loop_device **l, int i)
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
index d7307795439a..3763207d88eb 100644
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
@@ -391,6 +393,7 @@ struct blk_mq_ops {
 enum {
 	BLK_MQ_F_SHOULD_MERGE	=3D 1 << 0,
 	BLK_MQ_F_TAG_SHARED	=3D 1 << 1,
+	BLK_MQ_F_NO_MANAGED_IRQ	=3D 1 << 2,
 	BLK_MQ_F_BLOCKING	=3D 1 << 5,
 	BLK_MQ_F_NO_SCHED	=3D 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT =3D 8,
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 77d70b633531..24b3a77810b6 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -152,6 +152,7 @@ enum cpuhp_state {
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
+	CPUHP_AP_BLK_MQ_ONLINE,
 	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
 	CPUHP_AP_X86_INTEL_EPB_ONLINE,
 	CPUHP_AP_PERF_ONLINE,
--=20
2.25.2

