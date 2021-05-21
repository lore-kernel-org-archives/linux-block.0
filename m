Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55135C433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398526121E
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhEUDCq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 23:02:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25389 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhEUDCq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 23:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621566083; x=1653102083;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=x1WpI3Z+8cyaMWROHXaks7b5keOWUGnB3d9FR3KBb4M=;
  b=S+i0c/yQtYgjgirUQ8aIrgBmq6bD+3rviHTsFlJ5a+50BLrEiW9dXCMN
   A6EdV5Q6br3Fi2Cu5Fluqm2NI/ucGrUNxYBODFLOdjfD2aP6dhPXgvoTg
   qbKIyy1Pep/kQVuaF3+M3pbsUbnymz0WEg0rmVbd/a3sQ2Of4jqH4tGNv
   Oq6GwpOzjqlCoXvVtVB4SQeTfp8HTPdmFxLytcwLYxnjmHvR4iFrKcPaJ
   1npGek+mNg5a/I8fcz5i4PevqWaU+UuoDR7GKH9gK1t25Z9giT+CQxOLs
   ndSPDt3xmKumQRUJbRrh+U8AKeHO1LdKFJlL21b9HtGDNKryTfV00X7He
   Q==;
IronPort-SDR: 7hlujYTfXI242d7q/HR7Jk1XzfNZa9D4+Hzs5hIH7N68QN7y1DIk+j2tGZfSLA9cIIiHYIeZCc
 O1t23FpYEaqjYdJWGsPBHjMIgH3XZysxuWUDUJkl4wuIuyM5JRlw4AtIUHgcVzeoR0zGKLMMnX
 JWl5VFHdhx/Uyghd5aBMPC6yZHViEu7qfdWDDp/OSk8S1D0QyxHfZFAzESbGt4soH3op9X43xz
 bxAKiwTE8raBrH9rRc47iJfiMGNRUWvZgo7kzu0b0vtAhxBqYIOvgQxXnrLtzQj4JuHf0e84pv
 oDw=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168943804"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 11:01:23 +0800
IronPort-SDR: +TtpdBLNLMnRQaIFOtjAkt+qybqBnCaPVy9uP8SYYURUmSAMREI5sZ5qWSSbYze1iZtubkKV/t
 vxGiswtPDJQVTj5iYAJ7VT2qg64m0VzvNRxa2IeRZIPo034n2GB285VBOALYvgCbSwMS2jMIHk
 aZBcQParPqb5XWEeOUg7FBvF3GubqicpcZeu+rsteAAfR5nrzypEFXjeCz8yLG93RSV17hBidp
 oFDEURttxGAz2KWrEMIGBRfltClga1hz7Y5zl3b89g3Wo+N6reI+ZFfRvRUa0zjREuETouDYWb
 NoqBh2KYrJK1dmtP7sHnZv2z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:40:59 -0700
IronPort-SDR: eWE035UCu7Mks9ONY6f7nljDD8+7jYU6zjDemN2JpwWJFMSe/S67w+4WR+rDth3H/WR2gT/hhQ
 iJcLtA02Z/cObCMfSnvmnlE64WjzemeoOMN5fvfoaCbrsWKym3JxyqoWA+h07lvOPqa6emT9Fb
 VG8WP9ZumCyBDPclidyMt09I47nJddBJCuozI4dghjhV0mNkvRT+2WiGTj5reahz8wZkIPHXCU
 8G6gbbAFOtJtvgBoMohnJA/+QYw35B3Y0KCNwyOgijdgych/BR7Aadj4vwd2vwYoPy8s6gDZFd
 cmM=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 20:01:23 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 02/11] block: introduce bio zone helpers
Date:   Fri, 21 May 2021 12:01:10 +0900
Message-Id: <20210521030119.1209035-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521030119.1209035-1-damien.lemoal@wdc.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the helper functions bio_zone_no() and bio_zone_is_seq().
Both are the BIO counterparts of the request helpers blk_rq_zone_no()
and blk_rq_zone_is_seq(), respectively returning the number of the
target zone of a bio and true if the BIO target zone is sequential.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/blkdev.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f69c75bd6d27..2db0f376f5d9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1008,6 +1008,18 @@ static inline unsigned int blk_rq_stats_sectors(const struct request *rq)
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
 const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
 
+static inline unsigned int bio_zone_no(struct bio *bio)
+{
+	return blk_queue_zone_no(bdev_get_queue(bio->bi_bdev),
+				 bio->bi_iter.bi_sector);
+}
+
+static inline unsigned int bio_zone_is_seq(struct bio *bio)
+{
+	return blk_queue_zone_is_seq(bdev_get_queue(bio->bi_bdev),
+				     bio->bi_iter.bi_sector);
+}
+
 static inline unsigned int blk_rq_zone_no(struct request *rq)
 {
 	return blk_queue_zone_no(rq->q, blk_rq_pos(rq));
-- 
2.31.1

