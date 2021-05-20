Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F0BC43460
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EF86108C
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhETEXx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 00:23:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63405 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETEXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 00:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621484552; x=1653020552;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=fBlyNPaqEFSSoSs+6AtZVHwfafhe/Inr4ytd1alMRuo=;
  b=IOTdSYgj9xv3gy43gOgHPKIGmvB70YlxUnYbrr8Zu8xslOfYMUqk77qr
   kVPK6NdZkqVvXkKPbKNqlPUhsimM+9jtcBRHkdHiu1PFX45zm2J2w7alf
   ihtfskn7vf3y/sEPYsuVTuO0zO2/n0HbT7T2GkbAPBCQ9fgdEiNWc6vB/
   zU9ACyhD/fOyeVH4X6N/qKw+tULiAZwxpn0FHJlu501CL84CjxEZcLwa1
   dAmeDaL4StMaJBCUItqzk7LCnnzIHEW/CPO1J2wCh9ACr8zRuuS3yxIls
   doTT35zGTKi2aTpcykQdrmZ9vJ+8/SLE1kvoU2TNwQ0GbeeKmUC1F6tYG
   w==;
IronPort-SDR: xNHmcVC/GgncsUxlu6sDS3vI70+xmV+YCzuJzHdySrU/pbD6Fa6QRj+XVfVyjDBZ/nmM2H7iy4
 +Sb7j8hP6x+NJwZiY5JNFSJ7kZSMChNhHq7Hae5KbmfHNktREVAEgzKk7GQApMM1MpioeZaZgQ
 R8/F+JdvgzH4qDaFTVIiIWgo0dBuA67CWt8KDXI+0na92i0V6IO7+5YFFCQZAuBqPDxqONcbec
 +5ihSkrOPWEz+nByCeMluIIqrpPuU73FAxLacn/Qy+2TIoSOecJCLhjrG0a4RC38l5wGN5JKxm
 gCA=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168105835"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 12:22:32 +0800
IronPort-SDR: CwgA/NFFAaWGZCsdIsv4G6BeyBNmE8pRmbMIPjYAdRcdbRzGA9uoS9V9OAdj1znRoIgJrKKw30
 eTDukeu0zJOwYuqA3aeudCW77cOVhKbzODz/rNahtd/sQAI4x6SNtTsde+SBD0TqZPhMcRBT8A
 yAAWX5UWVrYMnzp/tVV7XN6EgJoVEWikKxpZ13q4SGeExkWVxgv3K6QtUPbWttSNdoAd3GuvwH
 0mnUBf/GFTsuYrdMtMorvmg7guZI4mI0IEarp4JoD7Qpu5hVmjyEjdJ0u9s9XH86At3xCgKizp
 /A25amfEwezr2UQDE0DqdRAz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 21:02:09 -0700
IronPort-SDR: J/48wiKhHEXS5SbzrB86Ab9A0rGE/5PNyqwr9Kj+Ra6ZBE7KWJmVhqAati3UyEL4cZQYdumb5c
 xO1BgASlgG89rXBU01EAiuIZc4cm4I6vAZ63H5dzpZjU8cpQVIsaNJTQkT0PY7RcEtiJfySMo9
 6UwCfUdDiOMGpgVtJy74bqieMbYN05GgcGptHNQXvpa2pJ8VpJHZMBVlZyJGZNIBMp/E8ui49u
 f0LhLIOqRKRQohOdwylH78Jp1etczoUz+BVjXfQ7/d+viOLe+ETTf2l/mX0IbYWTAjLxeckIq2
 Fxk=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 May 2021 21:22:31 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 02/11] block: introduce bio zone helpers
Date:   Thu, 20 May 2021 13:22:19 +0900
Message-Id: <20210520042228.974083-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520042228.974083-1-damien.lemoal@wdc.com>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
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

