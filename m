Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B4FC433E0
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0AAF20780
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h8xKnXlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgF2Xni (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:43:38 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44062 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgF2Xnh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 19:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593474217; x=1625010217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jsU245lIDaILp34LuMNXdbl72QdPFqclivvIUwUwwdg=;
  b=h8xKnXljvfbwDzFJZgwSw1WNDwKFm0vLCid/h6Obv6GVWH4X0fIQdans
   yPQ3CSYAcukQaM7Vk7TuLLd1NhGudbcTOPAwxirAD6plNWo6ytcsLt/aD
   DE+KrPYXOOgyFeg9ske1e3wQfjoWfVyO0pjrlMT56Nc3RYNxYAQ0aVD0T
   n9OHU7luZINKYFqnkijq7dT53WV8kfU+Qw+bYYfcGBjNNGl+9qDCQzdoH
   dkFNfJaz8wOgQiditIEbpmoNbbORFZckWy+v9PQee48B2WT9ilGiUpHnH
   rBDKBXcHK1leSvKLpvcG2R7MAkrtauOtS7eUpyc9MDA60Icpc9xWR9JO1
   A==;
IronPort-SDR: F1Coerj3qfTpYWB5usOeHkjigattSWjrspp5mFOy3wtfLkIgA+1mroFv89uZ1uDm2zDgttd3DF
 FsbqRmn4sfOD/z7wCS6+8nTkaPjizQ59SG7/pFu8lOTqPT2wsRCY/NZ2litfi1bkmYVEsawaAM
 4pgz6wpue9paJ1OsqWDcYjmLFp2m1AtPriA5YZnUNotjXQf0NXDbGHoHyEQ+3TfKN1/H7ZFfa+
 kpR3Gai9zI27e5BefI4ta0SlLUAOdg8dfm6JbnZHKdD+QUVupdXAVgObUh7cZX3VTB3uy3w2sp
 xc0=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="145544718"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 07:43:37 +0800
IronPort-SDR: gxvn98cM/J2zFbRV0K8mvJwcXF4VViRZkJt3GdDl8mRH6WVAHLoL/TuO5wYwuH7L1ypDzxisw4
 5GbwitwmR9UgL9eZ2Lj+pVrxBTFgweiUo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:32:29 -0700
IronPort-SDR: TxSS+fRz0Jce2zgM3RsllAdgIl3rG5wnJxH46xqhp7x9Qs8459WU1bBxhoOsNSoV8SD7hkEBrG
 UuIG+hqqogAA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jun 2020 16:43:36 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com
Cc:     jack@suse.czi, rdunlap@infradead.org, sagi@grimberg.me,
        mingo@redhat.com, rostedt@goodmis.org, snitzer@redhat.com,
        agk@redhat.com, axboe@kernel.dk, paolo.valente@linaro.org,
        ming.lei@redhat.com, bvanassche@acm.org, fangguoju@gmail.com,
        colyli@suse.de, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 02/11] block: rename block_bio_merge class to block_bio
Date:   Mon, 29 Jun 2020 16:43:05 -0700
Message-Id: <20200629234314.10509-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are identical TRACE_EVENTS presents which can now take an
advantage of the block_bio_merge trace event class.

This is a prep patch which renames block_bio_merge to block_bio so
that the next patches in this series will be able to resue it.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/trace/events/block.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 237d40a48429..b5be387c4115 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -295,7 +295,7 @@ TRACE_EVENT(block_bio_complete,
 		  __entry->nr_sector, __entry->error)
 );
 
-DECLARE_EVENT_CLASS(block_bio_merge,
+DECLARE_EVENT_CLASS(block_bio,
 
 	TP_PROTO(struct bio *bio),
 
@@ -330,7 +330,7 @@ DECLARE_EVENT_CLASS(block_bio_merge,
  * Merging block request @bio to the end of an existing block request
  * in queue.
  */
-DEFINE_EVENT(block_bio_merge, block_bio_backmerge,
+DEFINE_EVENT(block_bio, block_bio_backmerge,
 
 	TP_PROTO(struct bio *bio),
 
@@ -344,7 +344,7 @@ DEFINE_EVENT(block_bio_merge, block_bio_backmerge,
  * Merging block IO operation @bio to the beginning of an existing block
  * operation in queue.
  */
-DEFINE_EVENT(block_bio_merge, block_bio_frontmerge,
+DEFINE_EVENT(block_bio, block_bio_frontmerge,
 
 	TP_PROTO(struct bio *bio),
 
-- 
2.26.0

