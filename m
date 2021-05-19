Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6EDC43461
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248E0611BF
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbhESC4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 22:56:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5175 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbhESC4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 22:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621392932; x=1652928932;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=9QruT97IeweDj477QDeACg0wJl3HA59nYa9eSJPBeQI=;
  b=JTO5Hl1ROgsc1gWhXwkekoZnyrbVhZC3fetUI33P5FC7Ri2WVH68qpwG
   QauvCpesUFnE0Zj46D17rdTgZB4x+hnvXMRIc2yX6qZirTb0S8vGOf6WZ
   3HICLTU2ar9OhV46E/hzDFNDO0k5gFD+i+XZaviCew9i6YPsqhPv9neDk
   L1BlNLeStIMaQrzSc0Z/H7WjnQ+MkWMXZDjeDcgAwlOcxsUZAevBjp0Ii
   vWeDiG2Z5odmwVAqogzBJSEJ7uSvGPMKCu1cj6Opa0KozI3Bzxc1pZ1Zm
   ZQUDTVEhsa4vCxKADQaWsXt0ega0AzOI5sbIUfzApfAxGM+B4WtJDuDp7
   g==;
IronPort-SDR: 7XA4rRzteEEDYzIQi3vxp9xw3wYvJCBxg27ptXDVxwZEReUACaJEAKzoQnkHxgPQj+rg3WtqlA
 rOyjI141oHRfL8XoVIN0F5Qk4dcDeq+6khbIOpazdxCHUPVn4nea6edi6HZ14/KaV7e/UjqIHa
 LaMF96xcqYJsj4gQ46OIkgAQ6/mRWV1SxY0EbNEt0SNSUdRts5oDXfMR5HLQKSkVjElHVaeMsn
 pfCoG4vHv0ISBGCKRsy7THp7Desu5XqsTsbGtldvVRcPaIMFUiBsPknMBNQfplf4Q90+cByRr3
 8Vw=
X-IronPort-AV: E=Sophos;i="5.82,311,1613404800"; 
   d="scan'208";a="173265892"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 10:55:31 +0800
IronPort-SDR: QkP4QJepW0k55r4E2biGRH8Lqes9t461kryLxJuw57+W+tK7DHVYXg3o8ibt/ERtXhdbQRvC+n
 kwT5yqJi7kTdYCEXS2s62dN3p6bneED+TejTmRsgzgsNNx3h/QVcZXdnXSN2MeFOULaBmFe3gm
 LHfcWursNFOQRJpzx6undw5eD/AGme4JWX2lzAyW4mMcyx6DsXGntzARMqC6LJzgxekkjMwK2J
 oGmzzIn34BQtnVI1cjMZV2H6VG5uG0cUqR/4QOmiAKlStn9ZRgYN7/s97EABR3rOCEGNnZ7bhM
 SZvHqc6xI9iJ9fvqPxzBMVN8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 19:35:12 -0700
IronPort-SDR: samlL5UFxB1RcbGFoHukxr1J1+J64hnoMxpDfysdEf4DYBQAlWb2iVCqRdgktdcxOP4Wj1kro1
 EunAY8LYZpf1jez9tTBI1iyVbgnfmQNhvFBQWabQOGN63UIKOG18xY6TqeMJenkcw/IUPbO6CL
 3oO5agsPu2faI8erRG8clFmNEVdDGjyY0TQoRIfoJd1IOeWHgfYIMsaYNrvxP9aWwjkypdVz0d
 sAbzo1lbUX5Fi1j88DzsazrDZfA9u7DpcrNUoc6Uv63/obKlKjbkcuVt2v2IpfBaG9uXN59wn0
 sbs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2021 19:55:32 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/11] block: introduce bio zone helpers
Date:   Wed, 19 May 2021 11:55:20 +0900
Message-Id: <20210519025529.707897-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519025529.707897-1-damien.lemoal@wdc.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
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
index f69c75bd6d27..e74ad1252e78 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1008,6 +1008,18 @@ static inline unsigned int blk_rq_stats_sectors(const struct request *rq)
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
 const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
 
+static inline unsigned int bio_zone_no(struct request_queue *q,
+				       struct bio *bio)
+{
+	return blk_queue_zone_no(q, bio->bi_iter.bi_sector);
+}
+
+static inline unsigned int bio_zone_is_seq(struct request_queue *q,
+					   struct bio *bio)
+{
+	return blk_queue_zone_is_seq(q, bio->bi_iter.bi_sector);
+}
+
 static inline unsigned int blk_rq_zone_no(struct request *rq)
 {
 	return blk_queue_zone_no(rq->q, blk_rq_pos(rq));
-- 
2.31.1

