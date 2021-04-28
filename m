Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4975FC43461
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 06:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DBD461418
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 06:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhD1GO7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbhD1GO7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 02:14:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE35CC061574
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 23:14:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g10so4788624edb.0
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 23:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RBjJPVpwnGK5cg4roDydc/Hj/MwSuec8jWll2zwOld0=;
        b=WuwpLWjcjsg6+IVAFmfIg8shQuA0tBg5pO4ceBTFqkE+eFjyZCANFdh0bxpksHjj2n
         XM71I/BsOULMF5rRSUDUwPUJHYebDN9nW2jv30ZukpK78Naa6L+2+U56XAkQM1JY9Sp2
         yNF1lTwm/Y+9soRTxjmppvIKJ5wUu/1ys/RJ9GB1PnWifesAbCVHl61Js1xaO7REylkL
         mGy5NnmubTBjNRop3L7y5/0p8HDsh0hXAAKu7R2tABqqdZve1ik3y+p8JPqiNNzY9GAA
         lRY2G50X8xRqt3V6eyYcQ7MFQtROdTBPT7LJJXOfpxdjObg/q8u4M6orGcSPhe245/uX
         e5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RBjJPVpwnGK5cg4roDydc/Hj/MwSuec8jWll2zwOld0=;
        b=GkiUhs+Io84SeqssHxfZc1owpzb55BEa9Pvdq+NctS8HttLhZH2gE+w1qmhSgAdxcX
         +clB+EZOHOaJ3AjS7LzfXFCdMtCAspZCfobsXDckjgSu8YMnbW8BnbkCAC23nUcyxuCh
         JGSqQXtJEpWe8bviZPMk7BtEVmGdiZqEdAbNcBBIYoLXTUTwaNnkhXnugg9C+T/R3jxl
         zvC/CcVls7wgQeBK+zV2qqnWUtgcg+ZsOwMSocTfqxhcpNwodezLFYR6vtM65i1KE9RT
         EHmmSDWbhJlbVH9QoOti7LhCwdy6PD7frb1AbML1teKrdl9UonqHMva6fzzci4G3vd28
         yo1w==
X-Gm-Message-State: AOAM531yxJMFOioQ5rxDpImcC7GKfmzUkteecX9D021m5G94u20aojG9
        JV76g0B/1P6Y0wRpx7C7BgEE2NsBzwOdfg==
X-Google-Smtp-Source: ABdhPJw1qAnZ9A08QGoS7UZRZUSYESjYAdS/CTSn7s7Z6HvczqErb4CjEPUTlP1qlBh25b7n3aKMow==
X-Received: by 2002:a05:6402:5189:: with SMTP id q9mr8793912edd.168.1619590453324;
        Tue, 27 Apr 2021 23:14:13 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5ae8b9.dynamic.kabel-deutschland.de. [95.90.232.185])
        by smtp.googlemail.com with ESMTPSA id t4sm3970322edd.6.2021.04.27.23.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 23:14:13 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 4/4] block/rnbd: Remove all likely and unlikely
Date:   Wed, 28 Apr 2021 08:13:59 +0200
Message-Id: <20210428061359.206794-5-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428061359.206794-1-gi-oh.kim@ionos.com>
References: <20210428061359.206794-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The IO performance test with fio after removing the likely and
unlikely macros in all if-statement shows no performance drop.
They do not help for the performance of rnbd.

The fio test did random read on 32 rnbd devices and 64 processes.
Test environment:
- AMD Opteron(tm) Processor 6386 SE
- 125G memory
- kernel version: 5.4.86
- gcc version: gcc (Debian 8.3.0-6) 8.3.0
- Infiniband controller: InfiniBand: Mellanox Technologies MT26428
[ConnectX VPI PCIe 2.0 5GT/s - IB QDR / 10GigE] (rev b0)

before
read: IOPS=549k, BW=2146MiB/s
read: IOPS=544k, BW=2125MiB/s
read: IOPS=553k, BW=2158MiB/s
read: IOPS=535k, BW=2089MiB/s
read: IOPS=543k, BW=2122MiB/s
read: IOPS=552k, BW=2154MiB/s
average: IOPS=546k, BW=2132MiB/s

after
read: IOPS=556k, BW=2172MiB/s
read: IOPS=561k, BW=2191MiB/s
read: IOPS=552k, BW=2156MiB/s
read: IOPS=551k, BW=2154MiB/s
read: IOPS=562k, BW=2194MiB/s
-----------
average: IOPS=556k, BW=2173MiB/s

The IOPS and bandwidth got better slightly after removing
likely/unlikely. (IOPS= +1.8% BW= +1.9%) But we cannot make sure
that removing the likely/unlikely help the performance because it
depends on various situations. We only make sure that removing the
likely/unlikely does not drop the performance.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 24 ++++++++++++------------
 drivers/block/rnbd/rnbd-srv.c |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index f855bf1fa8d5..c604a402cd5c 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -241,7 +241,7 @@ static bool rnbd_rerun_if_needed(struct rnbd_clt_session *sess)
 	     cpu_q = rnbd_get_cpu_qlist(sess, nxt_cpu(cpu_q->cpu))) {
 		if (!spin_trylock_irqsave(&cpu_q->requeue_lock, flags))
 			continue;
-		if (unlikely(!test_bit(cpu_q->cpu, sess->cpu_queues_bm)))
+		if (!test_bit(cpu_q->cpu, sess->cpu_queues_bm))
 			goto unlock;
 		q = list_first_entry_or_null(&cpu_q->requeue_list,
 					     typeof(*q), requeue_list);
@@ -320,7 +320,7 @@ static struct rtrs_permit *rnbd_get_permit(struct rnbd_clt_session *sess,
 	struct rtrs_permit *permit;
 
 	permit = rtrs_clt_get_permit(sess->rtrs, con_type, wait);
-	if (likely(permit))
+	if (permit)
 		/* We have a subtle rare case here, when all permits can be
 		 * consumed before busy counter increased.  This is safe,
 		 * because loser will get NULL as a permit, observe 0 busy
@@ -355,7 +355,7 @@ static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_session *sess,
 		return NULL;
 
 	permit = rnbd_get_permit(sess, con_type, wait);
-	if (unlikely(!permit)) {
+	if (!permit) {
 		kfree(iu);
 		return NULL;
 	}
@@ -1050,7 +1050,7 @@ static int rnbd_client_xfer_request(struct rnbd_clt_dev *dev,
 	};
 	err = rtrs_clt_request(rq_data_dir(rq), &req_ops, rtrs, permit,
 			       &vec, 1, size, iu->sgt.sgl, sg_cnt);
-	if (unlikely(err)) {
+	if (err) {
 		rnbd_clt_err_rl(dev, "RTRS failed to transfer IO, err: %d\n",
 				 err);
 		return err;
@@ -1081,7 +1081,7 @@ static bool rnbd_clt_dev_add_to_requeue(struct rnbd_clt_dev *dev,
 	cpu_q = get_cpu_ptr(sess->cpu_queues);
 	spin_lock_irqsave(&cpu_q->requeue_lock, flags);
 
-	if (likely(!test_and_set_bit_lock(0, &q->in_list))) {
+	if (!test_and_set_bit_lock(0, &q->in_list)) {
 		if (WARN_ON(!list_empty(&q->requeue_list)))
 			goto unlock;
 
@@ -1093,7 +1093,7 @@ static bool rnbd_clt_dev_add_to_requeue(struct rnbd_clt_dev *dev,
 			 */
 			smp_mb__before_atomic();
 		}
-		if (likely(atomic_read(&sess->busy))) {
+		if (atomic_read(&sess->busy)) {
 			list_add_tail(&q->requeue_list, &cpu_q->requeue_list);
 		} else {
 			/* Very unlikely, but possible: busy counter was
@@ -1121,7 +1121,7 @@ static void rnbd_clt_dev_kick_mq_queue(struct rnbd_clt_dev *dev,
 
 	if (delay != RNBD_DELAY_IFBUSY)
 		blk_mq_delay_run_hw_queue(hctx, delay);
-	else if (unlikely(!rnbd_clt_dev_add_to_requeue(dev, q)))
+	else if (!rnbd_clt_dev_add_to_requeue(dev, q))
 		/*
 		 * If session is not busy we have to restart
 		 * the queue ourselves.
@@ -1138,12 +1138,12 @@ static blk_status_t rnbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	int err;
 	blk_status_t ret = BLK_STS_IOERR;
 
-	if (unlikely(dev->dev_state != DEV_STATE_MAPPED))
+	if (dev->dev_state != DEV_STATE_MAPPED)
 		return BLK_STS_IOERR;
 
 	iu->permit = rnbd_get_permit(dev->sess, RTRS_IO_CON,
 				      RTRS_PERMIT_NOWAIT);
-	if (unlikely(!iu->permit)) {
+	if (!iu->permit) {
 		rnbd_clt_dev_kick_mq_queue(dev, hctx, RNBD_DELAY_IFBUSY);
 		return BLK_STS_RESOURCE;
 	}
@@ -1165,9 +1165,9 @@ static blk_status_t rnbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 	err = rnbd_client_xfer_request(dev, rq, iu);
-	if (likely(err == 0))
+	if (err == 0)
 		return BLK_STS_OK;
-	if (unlikely(err == -EAGAIN || err == -ENOMEM)) {
+	if (err == -EAGAIN || err == -ENOMEM) {
 		rnbd_clt_dev_kick_mq_queue(dev, hctx, 10/*ms*/);
 		ret = BLK_STS_RESOURCE;
 	}
@@ -1584,7 +1584,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	struct rnbd_clt_dev *dev;
 	int ret;
 
-	if (unlikely(exists_devpath(pathname, sessname)))
+	if (exists_devpath(pathname, sessname))
 		return ERR_PTR(-EEXIST);
 
 	sess = find_and_get_or_create_sess(sessname, paths, path_cnt, port_nr, nr_poll_queues);
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 899dd9d7c10b..aafecfe97055 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -104,7 +104,7 @@ rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
 
 	rcu_read_lock();
 	sess_dev = xa_load(&srv_sess->index_idr, dev_id);
-	if (likely(sess_dev))
+	if (sess_dev)
 		ret = kref_get_unless_zero(&sess_dev->kref);
 	rcu_read_unlock();
 
-- 
2.25.1

