Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBCFC2B9F7
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DFA6141F
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhEYC1M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 22:27:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34067 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhEYC1L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 22:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621909542; x=1653445542;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=24PAAoOmT724oNWtauCM1gI/ZykcUIUfra8Qktvr20Y=;
  b=Zn4ItAskBO7RTmVvxqbntjGWQSn6S4DeGOREdZJKVQP4sQ3B3bI/7+J9
   oPzAQdzigy4ehO0QfLITgkXKvtYlXxRC3ixkziKpcO3hxZhYgEZBY3Jjx
   KMmJhI9P/XhZvZ5IGMvom1BBi0Tkeu7VxAD6XtrnqL1LbCoxf5IESdMS8
   TkpWwSxBI5FCzNCvM1W7bvd/CKqBNkMhCyuLZMGO2M6q/ylN1kMZZSAkD
   rfYum4tE9HeH/ZEukEPENn2lUZc/zVcCoIOoHfDpStILQxe1+AJlnyFMT
   JynSIEk+9KeD/5FKeEnlC7EAZicVeVyCRXOXcn1gudcCPHeZexfEsXEze
   w==;
IronPort-SDR: D4vAOYa/3YbcfRqnveV0tT6jCqegHIX7GnokZ4N9vnK+emMcHIsrlrFlLyDDFRz4OeI50zLbgS
 tUmxF3+prCs/w2WJIiStgTZovOeXR1c0toiM0A1VNFgTPRAiXh8zczQbXUQjcLnVEGUFxI5mZj
 Xc235LKkZynRzO4K/C5nelqXwzmJm8hohQT9Ber07QAA8Pd8jJV0M0DCAWCn/TWH+ROMtwSS0a
 W7vJAAigr6qWQmBW1BpVPCSjBfQJVUvpubRVdxjp1qqOE9iEYJD8YrTrpwdG0pMCAdcx+A8A0m
 jUo=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="173981321"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 10:25:42 +0800
IronPort-SDR: Vvwd5TqWEt4N4IqPz80KbpR37Vyh9ZZOmXbT1niPQMQ6zJHtYYD+SntgVxx5Gb8kWRbv4kK+WB
 qsAESw5/15drwOJ60xIga/tDys/aacUHLP/ipurXEgHr+aaGzZPyatQHrxoN/+t1quSc1yOXxj
 deHn6/ysm5qb3u1dUZ3k9y7obL3SRqP19gMPMgvI2DxVFSjar8uypu0I3O/uooFGFXj5eUZytn
 8S1hItpoLLmH+179yFcFeCx1A8r6jAr+9FsZ7FFWlWRx4gY41XheP6ATh/Q03sZjQiZCa2p4rY
 uUbyXGTyeDU9ebLVHaaWhnD3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:03:57 -0700
IronPort-SDR: NHHM0i1sJS3FHaVrSYdGlgfhUUIKd/cnRyMYpUNwNCcLGZ3UptgvhlRrPKZpAqwNLaSOs6oaOA
 04lB0OgTsfG5zsCdUENSZFXBEIDdUJ+fKHM6y7d2DOJajY3vi161k91tJO33+m3qFEEs1Edx6Y
 Y1bFSHFxmZWPS1EJaELtyRL8dlgm566w04LpoiPCV/GMBsqjm/mvcqXL0kKMyKzqI05LijKAQ2
 Lnv7YpXYjsBLcN/7HmCiV6+/B8ZC043SEP+JmYNxbFa6//RbtGiMHcyK6hZN97VvRGoBOHAXGN
 VVA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2021 19:25:42 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 02/11] block: introduce bio zone helpers
Date:   Tue, 25 May 2021 11:25:30 +0900
Message-Id: <20210525022539.119661-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525022539.119661-1-damien.lemoal@wdc.com>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
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

