Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41F9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 23:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B779560F6D
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 23:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbhIWX2k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 19:28:40 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:56258 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243400AbhIWX2j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 19:28:39 -0400
Received: by mail-pj1-f41.google.com with SMTP id t20so5502240pju.5
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 16:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3Nr7yvQYh2LhcnHCVBvuOZMF01yI2XYwV6hRDodYkE=;
        b=cpczxnr+aM/IODNBiu+VzF++R8q2fA+r/fB/CY0Z/bAKFzwjtZVFoQNq7cWmfxRZjH
         pEBmyAfhhxFFinih3t5AoDQd6MFnlio6SgwmS6Jak7fJsdIk17odbzywKQ1zs0ex5ika
         ClZRge1mJ8YEPtMyW1xwGqnXfrmib3ZJWQ6MhsFzrhXuIgPHDb+qcn/15jcBc/DHNFqL
         pPD+zXkBr6Yv6AnpAlQoNm7Rt89Gl/CGIU8Ca4pHJlGB5cT2kEdH3OrkirumzXyBLQDp
         TetASywe0PrDZcpH7PTx/3ee3URdLPTDKAyoo965PiTx2bjgHRRPm+HNmOBtOpARQgxH
         D5qA==
X-Gm-Message-State: AOAM532ZQkM3HrdoOmgj3R/rC0g1ccozcVZw4vaBhGwoi3OFT1dIxkYm
        dG2rg/1Gr1Or0RXptbGTME8=
X-Google-Smtp-Source: ABdhPJxGL6HPjJXtujEN85Qcj9GHCOY0R7an/4R87Enuf9Mvj2cfgw5oQqDbENRUE0oUTPIy0leJAQ==
X-Received: by 2002:a17:902:8ec5:b0:13a:2789:cbb0 with SMTP id x5-20020a1709028ec500b0013a2789cbb0mr6459965plo.60.1632439627131;
        Thu, 23 Sep 2021 16:27:07 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:bf91:ebe7:eabf:7473])
        by smtp.gmail.com with ESMTPSA id o14sm6969807pfh.84.2021.09.23.16.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 16:27:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/4] block/mq-deadline: Add an invariant check
Date:   Thu, 23 Sep 2021 16:26:53 -0700
Message-Id: <20210923232655.3907383-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210923232655.3907383-1-bvanassche@acm.org>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Check a statistics invariant at module unload time. When running
blktests, the invariant is verified every time a request queue is
removed and hence is verified at least once per test.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b1175e4560ad..6deb4306bcf3 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -270,6 +270,12 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	deadline_remove_request(rq->q, per_prio, rq);
 }
 
+/* Number of requests queued for a given priority level. */
+static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
+{
+	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
+}
+
 /*
  * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
  * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
@@ -539,6 +545,12 @@ static void dd_exit_sched(struct elevator_queue *e)
 
 		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
 		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
+		WARN_ONCE(dd_queued(dd, prio) != 0,
+			  "statistics for priority %d: i %u m %u d %u c %u\n",
+			  prio, dd_sum(dd, inserted, prio),
+			  dd_sum(dd, merged, prio),
+			  dd_sum(dd, dispatched, prio),
+			  dd_sum(dd, completed, prio));
 	}
 
 	free_percpu(dd->stats);
@@ -950,12 +962,6 @@ static int dd_async_depth_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-/* Number of requests queued for a given priority level. */
-static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
-{
-	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
-}
-
 static int dd_queued_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
