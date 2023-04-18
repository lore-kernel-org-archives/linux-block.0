Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C15C77B7C
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 22:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjDRWkc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjDRWkZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 18:40:25 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEE7A251
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:18 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1a667067275so21583045ad.1
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857618; x=1684449618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/M3kPY105uxj/j0StHX/h+c4QrQKm3SykbAKuiTRN4=;
        b=Zy0ZZqGNsxvwBa30k6O3j+i7rXbJVo/Uh4mXLbmdSaX1MoNaAt5HCy7CZxyjcRPaxK
         uzRoImRxFDMZE0/CCrCkF08sQeRHYH128geUDnTsqkYoFw9tYaJp7POw9m29oqoLvv2b
         UiZnaf6kISnHg9NqM5ZxVN2mC4HajWrBpuLB/YxJ0+IpnPb6EZxwUaWffgtAnOGoQSZ1
         4Lvt3qGfx7rUHfzS8/ECr8cx4iZypV8kwn9YcdQdj5z9MJv7aafbzgVuY854LSFtaNrw
         KTB1kRJdoaCIeVkNb3I36dwZawG0aPJyhRaurlj27JX1jbMdT9wguS5ggMr8kQOmphk9
         TDbQ==
X-Gm-Message-State: AAQBX9dprDx+Bp59QONv6BvFVmlUmbiSETgTQI9nJcSob+Qduf0HWCYe
        mYJCwNciSrI/UVkEf1PszKg=
X-Google-Smtp-Source: AKy350ZM5JgJLZpbNShiS1m9wBb3HvzDmtcWXUXbBpD22Hf2jEoH++DdE/M9fLGS0mlcYLsCMp8a7g==
X-Received: by 2002:a17:902:e802:b0:19f:8ad5:4331 with SMTP id u2-20020a170902e80200b0019f8ad54331mr3959933plg.38.1681857618044;
        Tue, 18 Apr 2023 15:40:18 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm8285646plb.137.2023.04.18.15.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:40:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 08/11] block: mq-deadline: Fix a race condition related to zoned writes
Date:   Tue, 18 Apr 2023 15:39:59 -0700
Message-ID: <20230418224002.1195163-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418224002.1195163-1-bvanassche@acm.org>
References: <20230418224002.1195163-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let deadline_next_request() only consider the first zoned write per
zone. This patch fixes a race condition between deadline_next_request()
and completion of zoned writes.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3122c471f473..32a2cc013ed3 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -302,6 +302,7 @@ static bool deadline_is_seq_write(struct deadline_data *dd, struct request *rq)
 	return blk_rq_pos(prev) + blk_rq_sectors(prev) == blk_rq_pos(rq);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
 /*
  * Skip all write requests that are sequential from @rq, even if we cross
  * a zone boundary.
@@ -318,6 +319,7 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
 
 	return rq;
 }
+#endif
 
 /*
  * For the specified data direction, return the next request to
@@ -386,9 +388,25 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	 */
 	spin_lock_irqsave(&dd->zone_lock, flags);
 	while (rq) {
+		unsigned int zno __maybe_unused;
+
 		if (blk_req_can_dispatch_to_zone(rq))
 			break;
+
+#ifdef CONFIG_BLK_DEV_ZONED
+		zno = blk_rq_zone_no(rq);
+
 		rq = deadline_skip_seq_writes(dd, rq);
+
+		/*
+		 * Skip all other write requests for the zone with zone number
+		 * 'zno'. This prevents that this function selects a zoned write
+		 * that is not the first write for a given zone.
+		 */
+		while (rq && blk_rq_zone_no(rq) == zno &&
+		       blk_rq_is_seq_zoned_write(rq))
+			rq = deadline_latter_request(rq);
+#endif
 	}
 	spin_unlock_irqrestore(&dd->zone_lock, flags);
 
