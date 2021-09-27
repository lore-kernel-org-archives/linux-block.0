Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E6AC43219
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F121D61178
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbhI0WFd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:05:33 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:36770 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbhI0WFR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:05:17 -0400
Received: by mail-pj1-f44.google.com with SMTP id u1-20020a17090ae00100b0019ec31d3ba2so252201pjy.1
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 15:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyvehF4LvBk5lZK2Cm+maqg7XX2XBF0POzoT7z70NMY=;
        b=waPIebSC91ZTie/O6s6HQLCIb4tJzDJ4v88BaFK4Ph5S4nOA7foegx6xdgKuv+KOlk
         Lclmt3Q3cMnp46Md0AWVrPg7697EkxPwma2rbC77sn1dSBmyKB5nkXV8oE/qUefbCU7p
         3krvi/zJtjXwvHc0RCq9vTF+5E+5YZBG6V6Dh34m+P78g5QH36ZQOMFJaEEdU5rZgMAM
         c+zVs2zX5FRiFH8+4DLT8veUd3DqU12Z90PDOfkNUoQ2MaOxF8rr9O3E5x+wKxZ6e/2T
         wNNTHaoA5gs2vdei+X/6uSo2YSUYOi7RkY/VwHtTCD4WNmfZxG3sjG9YQFyqurJ0cgq6
         gi8Q==
X-Gm-Message-State: AOAM531EJrn5TxhphQw45ru8b/JXoqsPWDZYMhTNeekPiRAhwdW+0mNW
        KwSfuwipPdT6jXAApvvOc7kphYmoulbYCg==
X-Google-Smtp-Source: ABdhPJwyk98BzBfdwJvr2PWla9Wq6QZMobVPccjernPS/ajj5fPvNgBvaGbbLe/xP/diMpZMYnymtw==
X-Received: by 2002:a17:902:8b86:b0:13d:d600:789f with SMTP id ay6-20020a1709028b8600b0013dd600789fmr1800351plb.73.1632780218863;
        Mon, 27 Sep 2021 15:03:38 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3e98:6842:383d:b5b2])
        by smtp.gmail.com with ESMTPSA id y13sm381587pjm.5.2021.09.27.15.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:03:38 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 2/4] block/mq-deadline: Add an invariant check
Date:   Mon, 27 Sep 2021 15:03:26 -0700
Message-Id: <20210927220328.1410161-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210927220328.1410161-1-bvanassche@acm.org>
References: <20210927220328.1410161-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Check a statistics invariant at module unload time. When running
blktests, the invariant is verified every time a request queue is
removed and hence is verified at least once per test.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index c27b4347ca91..2586b3f8c7e9 100644
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
