Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A71C433E0
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C73720780
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PKO1KNHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgF2Xns (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:43:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29188 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgF2Xnr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 19:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593474227; x=1625010227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JkqBOl6ByFPNhL3mDt1GE9twMF0WE7QxGGJtc3EklEU=;
  b=PKO1KNHI7yNob6I1QKxUfK31R3zJoPiIxuo9sMww+VfXGmbmJ1DhbZow
   U8ApLayZ9wSypKuMFlKoNwF+JPO88w1L55OWrvNnlkcUNCN6k0Gkqkvgd
   4E/DIMPG4v00TlBKs6914k5mZz/mwWcQImNSeWgQPRXW1fSWhfsLbWMpn
   eph2Yxqk2+/iLWo6o1quxKAYnDLmV2bxhbq3hBmMbZyTZeQz/vLnOCErG
   oSbLkwIMZQ23/kZIH+4jTLgq3J49piEAVfuFmHil5NdKnN1Nzls3V2wKZ
   Y/86FSBB02RoAKnfR0yQPG3wy6do3OG2tmeYvtpeb6CSDlhSPGaj1ngUY
   A==;
IronPort-SDR: 0ZLMGciP4jHZ/bd9JETKs6B6jtv9POYDCqZS6KuNlqSoozRKA804A10ujPvSlJHLgKI+uTyfp5
 igcJfJv5/ZU3GIsLDcH2gRDa1lCVR4TTUcylWVuW79uTgcNv/C55EqpYWO+ON6h+77zEKqnu1E
 XaZlVpbkt4U31tOySXgHuTr4/nb/ZLWMC1W6n0WISvifgJtOt0St5MWCZfwKdDQnT8y2JKuZto
 tTI2HSN2F7vQmg7Cx97zOtGnV9ojHxHEeKpFaHcc+dcLgnREICFLghvU9MbKZX7W97+T3RUwne
 rGU=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="141431395"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 07:43:47 +0800
IronPort-SDR: Te0kU+pbY1z5RcGLdCjtWuxJWrb5CIqrv2tK3XNli5wyhIfm9rhA+s1YZC15inOKcBJxJOvlCA
 VHR/4CZ2TM6hW4v7XqauwZyu4AaWNa2V8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:32:07 -0700
IronPort-SDR: GWpo01VB/dDgqIVJbMjgir3MmktW2jUd980tnAe2STAeEiBIqW3F877xTOSjZFjHfBZPYVTjFl
 4XXqzgO3aVug==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jun 2020 16:43:46 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com
Cc:     jack@suse.czi, rdunlap@infradead.org, sagi@grimberg.me,
        mingo@redhat.com, rostedt@goodmis.org, snitzer@redhat.com,
        agk@redhat.com, axboe@kernel.dk, paolo.valente@linaro.org,
        ming.lei@redhat.com, bvanassche@acm.org, fangguoju@gmail.com,
        colyli@suse.de, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 03/11] block: use block_bio event class for bio_queue
Date:   Mon, 29 Jun 2020 16:43:06 -0700
Message-Id: <20200629234314.10509-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove block_bio_queue trace event which shares the code with block_bio.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/trace/events/block.h | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index b5be387c4115..5e9f46469f50 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -357,32 +357,12 @@ DEFINE_EVENT(block_bio, block_bio_frontmerge,
  *
  * About to place the block IO operation @bio into queue.
  */
-TRACE_EVENT(block_bio_queue,
 
-	TP_PROTO(struct bio *bio),
-
-	TP_ARGS(bio),
-
-	TP_STRUCT__entry(
-		__field( dev_t,		dev			)
-		__field( sector_t,	sector			)
-		__field( unsigned int,	nr_sector		)
-		__array( char,		rwbs,	RWBS_LEN	)
-		__array( char,		comm,	TASK_COMM_LEN	)
-	),
+DEFINE_EVENT(block_bio, block_bio_queue,
 
-	TP_fast_assign(
-		__entry->dev		= bio_dev(bio);
-		__entry->sector		= bio->bi_iter.bi_sector;
-		__entry->nr_sector	= bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
-	),
+	TP_PROTO(struct bio *bio),
 
-	TP_printk("%d,%d %s %llu + %u [%s]",
-		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+	TP_ARGS(bio)
 );
 
 DECLARE_EVENT_CLASS(block_get_rq,
-- 
2.26.0

