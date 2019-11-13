Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D62C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 15:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58F3222D0
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 15:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfKMPAX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:00:23 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:9071 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727550AbfKMPAX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 10:00:23 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 10:00:20 EST
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 13 Nov 2019 20:24:11 +0530
IronPort-SDR: nfwpYCTyb7jxhcWPk9Ne0HbimTn/ODm9c8uNO+x6e3J3vbaHqZukz4/HwYpt9DKetcVEWNOpz7
 Dkl9dC467EA5myn3hqhpNN3cj0kPqonoros1JDbNqPuKtLkyJY1wW6+KoY3nan53T1TWM7nR3c
 V3uRDvl9YtxMMQtP4RTsgrwEgYobNSuUWAVwzQXeYjglfM0JtBpxxMA42Rxvpdijs1rmk7hAck
 pQRLuAKqxd9kzhPJPFIgQG4EEWyHsSpT5xJR3q04wFVKK94IJcivXtB/Dkj+4UCal19ySk7g79
 Yq9nLb/2SU60+FOCeLdhU21T
Received: from c-ppvk-linux.qualcomm.com ([10.206.24.34])
  by ironmsg02-blr.qualcomm.com with ESMTP; 13 Nov 2019 20:23:55 +0530
Received: by c-ppvk-linux.qualcomm.com (Postfix, from userid 2304101)
        id 288D4496F; Wed, 13 Nov 2019 20:23:54 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     stummala@codeaurora.org, sayalil@codeaurora.org,
        rampraka@codeaurora.org, vbadigan@codeaurora.org, axboe@kernel.dk,
        paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pradeep P V K <ppvk@codeaurora.org>
Subject: [PATCH v1] block, bfq: set default slice_idle to zero for SSDs
Date:   Wed, 13 Nov 2019 20:23:20 +0530
Message-Id: <1573656800-14815-1-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With default 8ms as a slice idle time, we seen few time bounded
applications(sensors) on v4.19 kernel are getting timedout during
multimedia tests (audio, video playbacks etc) with Reboots and
leading to crash. The timeout configured for these applications
(sensors) are 20sec.

In crash dumps, we seen few synchronous requests from sensors/other
applications were in their bfq_queues for more than 12-20sec.

Idling due to anticipation of future near-by IO requests and wait on
completion of submitted requests, will effect in choosing the next
bfq-queue and its scheduling. There by it effecting some time bounded
applications.

After making the slice idle to zero, we didn't seen any crash during
our 72hrs of testing and also it increases the IO throughput.

Following FIO benchmark results were taken on a local SSD run:

RandomReads that were taken on v4.19 kernel:

 Idling   iops    avg-lat(us)    stddev       bw
 ----------------------------------------------------
 On       4136    1189.07        17221.65    16.9MB/s
 Off      7246     670.11        1054.76     29.7MB/s

    fio --name=temp --size=5G --time_based --ioengine=sync \
	--randrepeat=0 --direct=1 --invalidate=1 --verify=0 \
	--verify_fatal=0 --rw=randread --blocksize=4k \
	--group_reporting=1 --directory=/data --runtime=10 \
	--iodepth=64 --numjobs=5

Following code changes were made based on [1],[2] and [3].

[1] https://lkml.org/lkml/2018/11/1/1285
[2] Commit 41c0126b3f22 ("block: Make CFQ default to IOPS mode on
    SSDs")
[3] Commit 0bb979472a74 ("cfq-iosched: fix the setting of IOPS mode on
    SSDs")

Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
---
 Documentation/block/bfq-iosched.rst |  7 ++++---
 block/bfq-iosched.c                 | 13 +++++++++++++
 block/elevator.c                    |  2 ++
 include/linux/elevator.h            |  1 +
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/block/bfq-iosched.rst b/Documentation/block/bfq-iosched.rst
index 0d237d4..244f4ca 100644
--- a/Documentation/block/bfq-iosched.rst
+++ b/Documentation/block/bfq-iosched.rst
@@ -329,9 +329,10 @@ slice_idle
 
 This parameter specifies how long BFQ should idle for next I/O
 request, when certain sync BFQ queues become empty. By default
-slice_idle is a non-zero value. Idling has a double purpose: boosting
-throughput and making sure that the desired throughput distribution is
-respected (see the description of how BFQ works, and, if needed, the
+slice_idle is a non-zero value for rotational devices.
+Idling has a double purpose: boosting throughput and making
+sure that the desired throughput distribution is respected
+(see the description of how BFQ works, and, if needed, the
 papers referred there).
 
 As for throughput, idling can be very helpful on highly seeky media
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0319d63..9c994d1 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6514,6 +6514,18 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	return -ENOMEM;
 }
 
+static void bfq_registered_queue(struct request_queue *q)
+{
+	struct elevator_queue *e = q->elevator;
+	struct bfq_data *bfqd = e->elevator_data;
+
+	/*
+	 * Default to IOPS mode with no idling for SSDs
+	 */
+	if (blk_queue_nonrot(q))
+		bfqd->bfq_slice_idle = 0;
+}
+
 static void bfq_slab_kill(void)
 {
 	kmem_cache_destroy(bfq_pool);
@@ -6761,6 +6773,7 @@ static ssize_t bfq_low_latency_store(struct elevator_queue *e,
 		.init_hctx		= bfq_init_hctx,
 		.init_sched		= bfq_init_queue,
 		.exit_sched		= bfq_exit_queue,
+		.elevator_registered_fn = bfq_registered_queue,
 	},
 
 	.icq_size =		sizeof(struct bfq_io_cq),
diff --git a/block/elevator.c b/block/elevator.c
index 076ba73..b882d25 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -504,6 +504,8 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 			kobject_uevent(&e->kobj, KOBJ_ADD);
 
 		e->registered = 1;
+		if (e->type->ops.elevator_registered_fn)
+			e->type->ops.elevator_registered_fn(q);
 	}
 	return error;
 }
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 901bda3..23dcc35 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -50,6 +50,7 @@ struct elevator_mq_ops {
 	struct request *(*next_request)(struct request_queue *, struct request *);
 	void (*init_icq)(struct io_cq *);
 	void (*exit_icq)(struct io_cq *);
+	void (*elevator_registered_fn)(struct request_queue *q);
 };
 
 #define ELV_NAME_MAX	(16)
-- 
1.9.1

