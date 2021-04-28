Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20367C433ED
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 06:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC0A61418
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 06:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhD1GO6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbhD1GO6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 02:14:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F61DC061574
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 23:14:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n2so92827589ejy.7
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdCRKoX+xuUkB22a7Io1lxLMTt7m0TByGtjMv3RTyrg=;
        b=ELksowDicNNOCWG16xfEzZBpBAIYLfJaOrLpCO8okNpTNIi48yqFBN3N1CHhdl+DQi
         AXg6S89k/3nYK4qaCUqpO8+jvH/ZSWffGGp2Po8YM9DSeR05ripP5fbpk1QuEn4I+BPW
         2LgmtLT5qESprami2ilBkzm0svJJVP5mzRD3LaJHDQDnazKujCIQpsmW3awY8wbgOHfn
         O2ZdXg5m81M3/aqU+vjlokHxes+IAQIftldH2/BlKGba8vDRJmNq96yQZA30ZQvG3gqC
         y3Tmpq+9DhcI3x3e1lXQsKNRh44YqECGsL1UrTwENWC0ApsNCzkVdHb4GWviKpx7Utf+
         7eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LdCRKoX+xuUkB22a7Io1lxLMTt7m0TByGtjMv3RTyrg=;
        b=gVsQjMogcMlba2G+MWVH2wTm12k64aY8XELYr7M0rd6FD/jG4JLnNEljKQfBFskUjo
         mux1pGnaTXHT9mp1gDgT7KomP65A63Ydu8iyrAEl4S57/a2QKSvSV70A8xcdcRo6do0S
         pkVBfGVBqMCjFjgoeepyK/vtFSDeMQViunIWNHjocyV7FzSQJaPrStghLb/El1/an3Ac
         E4fZn7qU9dqORQFHMo0rzLr4GkSJBFQeEo7ipYrtrEVI+C5fiROIxnhZLPA1uii906wt
         xqQSuL2ij4nx08NIc3roTKEBtnXNcAGgNJEx81fmajNtKAeiw9BhPDtLrurkPix0SSMK
         mIiQ==
X-Gm-Message-State: AOAM533jAhnfAVHC09soh9RDynaCCp7+sX2Z/D5TtwMCO62bbVzwYHz8
        DloCmWsqa9KdctI64L5JC0/pEpPls9sukQ==
X-Google-Smtp-Source: ABdhPJxoP8104/RU2hNpkLs0ZKSu1Lx2ot6WPRmbMPADTT2EUd+Syo9x7/4q7b5p0oDAh93yddqvAw==
X-Received: by 2002:a17:906:564f:: with SMTP id v15mr16159958ejr.96.1619590452041;
        Tue, 27 Apr 2021 23:14:12 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5ae8b9.dynamic.kabel-deutschland.de. [95.90.232.185])
        by smtp.googlemail.com with ESMTPSA id t4sm3970322edd.6.2021.04.27.23.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 23:14:11 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Dima Stepanov <dmitrii.stepanov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 2/4] block/rnbd: Fix style issues
Date:   Wed, 28 Apr 2021 08:13:57 +0200
Message-Id: <20210428061359.206794-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428061359.206794-1-gi-oh.kim@ionos.com>
References: <20210428061359.206794-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>

This patch fixes some style issues detected by scripts/checkpatch.pl
* Resolve spacing and tab issues
* Remove extra braces in rnbd_get_iu
* Use num_possible_cpus() instead of NR_CPUS in alloc_sess
* Fix the comments styling in rnbd_queue_rq

Signed-off-by: Dima Stepanov <dmitrii.stepanov@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index c01786afe1b1..15f831159c31 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -88,7 +88,7 @@ static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
 	dev->discard_alignment	    = le32_to_cpu(rsp->discard_alignment);
 	dev->secure_discard	    = le16_to_cpu(rsp->secure_discard);
 	dev->rotational		    = rsp->rotational;
-	dev->wc 		    = !!(rsp->cache_policy & RNBD_WRITEBACK);
+	dev->wc			    = !!(rsp->cache_policy & RNBD_WRITEBACK);
 	dev->fua		    = !!(rsp->cache_policy & RNBD_FUA);
 
 	dev->max_hw_sectors = sess->max_io_size / SECTOR_SIZE;
@@ -351,9 +351,8 @@ static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_session *sess,
 	struct rtrs_permit *permit;
 
 	iu = kzalloc(sizeof(*iu), GFP_KERNEL);
-	if (!iu) {
+	if (!iu)
 		return NULL;
-	}
 
 	permit = rnbd_get_permit(sess, con_type, wait);
 	if (unlikely(!permit)) {
@@ -805,7 +804,7 @@ static struct rnbd_clt_session *alloc_sess(const char *sessname)
 	mutex_init(&sess->lock);
 	INIT_LIST_HEAD(&sess->devs_list);
 	INIT_LIST_HEAD(&sess->list);
-	bitmap_zero(sess->cpu_queues_bm, NR_CPUS);
+	bitmap_zero(sess->cpu_queues_bm, num_possible_cpus());
 	init_waitqueue_head(&sess->rtrs_waitq);
 	refcount_set(&sess->refcount, 1);
 
@@ -1148,7 +1147,8 @@ static blk_status_t rnbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	iu->sgt.sgl = iu->first_sgl;
 	err = sg_alloc_table_chained(&iu->sgt,
 				     /* Even-if the request has no segment,
-				      * sglist must have one entry at least */
+				      * sglist must have one entry at least.
+				      */
 				     blk_rq_nr_phys_segments(rq) ? : 1,
 				     iu->sgt.sgl,
 				     RNBD_INLINE_SG_CNT);
-- 
2.25.1

