Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09233C433E0
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E8B2078A
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HVi3e2/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgF2XpB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:45:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21972 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgF2XpA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 19:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593474301; x=1625010301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rvpgBSd7W4OQS0M7YIDi1QQcSbETeYvKomDK5mWrwfk=;
  b=HVi3e2/dKX5Xz6qGZgGOKB4RjlqxdtsX49kb8UlBKu/YmCScKN+Gwa2r
   ItMaayJkx6flVtqj9x4v4JCHEm5wh45tkQYP2vCfWdeE03TFAn+bP/TqC
   um12BwZ3mZIilnkMQqONWbz6uyBeoJ43atZVZX14309j6jWi1RxEq8RkE
   OXHmU3Ue+Fj9GCLrjpslmZFG0jKYJc23LB4iQ63Yg0hnSLVkyU7Ojmqb8
   HoixVob272d1n59cbXFuZ5O56mSNYUuHjLGOUmrcv69i9zoLekwST3u0g
   7MmU7PIlpbA8xxhi3GgRYGRa1mHRlDVYDAw95CR0rNJDdLdQJi3HNJXRw
   A==;
IronPort-SDR: X7VTcvIrDUSSeAebf/fY/nzBdFSJWBaGZ7gDe1WED/4dNsFaVNTiHOS8nk6X6dyAaLIjornkNz
 KdTdV4neYON1bkkHsuXu+DbOoc/59Q6KSSBkM0IkY64dCw9eziClkkj8ONwVdi7Ea3nZ7KdGi2
 3NsE26WREQRQMTzYt1MrJr+bzDHxzTumirb4HOYfbvhWrL+u/lCq7zwFSiWaH+KX4+TxULFx0N
 Q6p9mBiaM/kstWUM3TSL8i2Y2cCp/kIfSgO2sWOYKrtDCxqQ/BeT86sVgJ8jpRN0Kb0uGD0/A2
 ogY=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="142577176"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 07:45:00 +0800
IronPort-SDR: 2x6Fh3gxLg99SJ7KGP77CkXv4KRY27PuQSsBsMjPqkiev1FprvGrweOqnPo04TZf+e6ypI5eA0
 ewTsxDRi0Y/98hcZh+nsMOALYI4X9N9zQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:33:53 -0700
IronPort-SDR: 6lJvjQXfWa7Clf3GSzVOBFEGRf7qj96erZRiTrcownPOnxcf3VeOT+CS0b4eeudQVMs5ebyHky
 3Yp09SaAptIg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jun 2020 16:44:59 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com
Cc:     jack@suse.czi, rdunlap@infradead.org, sagi@grimberg.me,
        mingo@redhat.com, rostedt@goodmis.org, snitzer@redhat.com,
        agk@redhat.com, axboe@kernel.dk, paolo.valente@linaro.org,
        ming.lei@redhat.com, bvanassche@acm.org, fangguoju@gmail.com,
        colyli@suse.de, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 11/11] block: remove block_get_rq event class
Date:   Mon, 29 Jun 2020 16:43:14 -0700
Message-Id: <20200629234314.10509-12-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that there are no users for the block_get_rq event class remove the
event class.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/trace/events/block.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 21f1daaf012b..dc1834250baa 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -353,34 +353,6 @@ DEFINE_EVENT(block_bio, block_bio_queue,
 	TP_ARGS(bio)
 );
 
-DECLARE_EVENT_CLASS(block_get_rq,
-
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
-        ),
-
-	TP_fast_assign(
-		__entry->dev		= bio ? bio_dev(bio) : 0;
-		__entry->sector		= bio ? bio->bi_iter.bi_sector : 0;
-		__entry->nr_sector	= bio ? bio_sectors(bio) : 0;
-		blk_fill_rwbs(__entry->rwbs, bio ? bio->bi_opf : 0);
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
-        ),
-
-	TP_printk("%d,%d %s %llu + %u [%s]",
-		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
-);
-
 /**
  * block_getrq - get a free request entry in queue for block IO operations
  * @bio: pending block IO operation (can be %NULL)
-- 
2.26.0

