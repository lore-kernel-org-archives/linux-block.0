Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3825CC47086
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E99361417
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhEYV0h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 17:26:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36430 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhEYV0g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 17:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621977906; x=1653513906;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cnqRYx2R05sP7V9ec2jM+bey4sRJDAw/pWEMU80Ln+I=;
  b=G+dbrM+Fg2vGmhVAAB9GeDwzXwFqcERUqntOnbqeB81ubRlxzdM93mpc
   Nzi6Bs/IeBdBxH4ynnJ5lzFoY3tJLWQldpFVDYroKH5v9haabgX/uu5Av
   GEtK6l/sbeKg/iSPmL/bawXhsEZN2CAuCZ8xn99a4nG0WPOXDZPLMOOWH
   +avfVWXv5dsioDaKOrZvpF3KWcBDZJ5yn608wnXZca+0KbfRRP8CjPkfc
   HyBNVagoy3Qld2K8moevGdevlED6ODaNUxENQ/EMoleelT3N26Fv6nOia
   ELxrr3D3QZWjFhFYJFjbtcd3rYBPX4qqGjgJ3Si+taYrExPq1pISTeB/D
   w==;
IronPort-SDR: DiQEplpgH98rnY+MufPYr8le1uBP1276f+8s94+kOrCBGYsqeJVZx4a1lI3rADf1ld9wjcmD14
 DwwSlfQyXTtrdOmkXU7ukGs0pp8YCxVoIdlLdDEJyZtHlbN/XSN0AyGmPsI61yIOLYobanpH5K
 o5o3c7/nClafJycWBAjo5W6E9uvsR7qjaLHkEuYd+b4vYiyEKrhDMYv+IJfPsCNvELkfSRokUP
 a5c7OUn74amp9zx8f6RpKOxgD/aRqlqYRA2GcCCLKUCyQgTyLqCOzwl1tBoGD1FdOUPN6v8KOk
 wmg=
X-IronPort-AV: E=Sophos;i="5.82,329,1613404800"; 
   d="scan'208";a="168717514"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 05:25:06 +0800
IronPort-SDR: 5nyBrgiom04S+WKdZ8HNv/EMYxN8Qkdp2kjrIvNtjxHgm+vWhMg7IgOJQ0tjgijEzHcWAxhqx8
 u5fGBkgiQ5avUq73/3N9vpHD7tKX0Yr0Pma4AGcEJEVMz+G9/08IjstV4jdM4U2MpImfDOLnsj
 lYZfKvM752VHS8xMKIoxZ+kVwON3RjqYR6ef+L25GkIy0ikB3ZHOoj2PMcUnEDzCtK0aHhPEph
 pgMkghAmxqetyIAlF2Xc98rMjFb95TnfV73KRvLsT3vYx4oHwJzcuz0vXJXpVlXqmFaKtQwz0r
 HuIY3cdNQULJ4rm6UE6JXpZa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 14:04:34 -0700
IronPort-SDR: METJ6JkdC2rJw/wpyWsuv8N7jzQudGNSY6gML668bluLFD0tIn3SFp/V7/AIqHqY5r/YKPpWT1
 ffZP6HcvFV9i86+tGzvlNZgDn8pYS/GPJlWGyJrsT8WG9WguRKrNn4/BVLuRzbWQyCYvV35AIf
 U3ViBdYghgNAik5M0yR/oT3KumOT3izeUi/wtl2SsJUVq8U1+8wI1wXG6DGg8sgWiV10y+7J2i
 N3WZbNOukAt11JGUP0Qqd5LK4qwunBjY+JZ7pNkb77xSZJW/o8oC8c1Ke3CH9ArYD+qZFiQjjY
 ciw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 May 2021 14:25:06 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 02/11] block: introduce bio zone helpers
Date:   Wed, 26 May 2021 06:24:52 +0900
Message-Id: <20210525212501.226888-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525212501.226888-1-damien.lemoal@wdc.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
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
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
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

