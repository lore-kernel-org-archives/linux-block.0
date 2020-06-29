Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3035C433E0
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2B720780
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VaF30aVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgF2Xoz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:44:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41344 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgF2Xoy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 19:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593474293; x=1625010293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G8cNsqQKCATReJdtqjxr6XXjJG7W1w3O1NvqRQNG84Y=;
  b=VaF30aVyYrsUcxO+lHhvByfO+SeFN3VMnJddHDpuLhsX/hp2GOkrQFAY
   Zgdu3IfLypdQlkbD0qZts/sSavUb34Bek0KHoGwVugI8NMwc4tKlL6Zd7
   D7fTjsbv96/iyH7PapZyEtZMLahhCgTKlz86Fu+lahWXX3YNBtMZrPQy8
   XObIvL70P0GoOC2CKsITLuPjHqX6/N4l0rnN7YjZlVgGM3t1i0Edrt26O
   Bem3E7MPbtVTRiQ1SSPFd6+k5ARXlRSzjLyAAur3vHWhFuY8jjdh63ilH
   yowvrloa5a35nABWhFz5ABjXvKs7bX189np9AfWOGVC9KAo+/tNjZh0Ii
   g==;
IronPort-SDR: TjA3YxFW1Z67Ch4L91EJ5LtAgVFHWvgT62pszMujQEdAG4n8xVjNjrMzDnJcdVvNaXhCcXHGeP
 iJhZjtDvE06pVT/Ex7X4LgpfVnLCF3q5d2/2ofIAvSGtkyFYXbH1lxN1jVKLlD6wXBb9RKL/yf
 Z7gQIUo0KxBtUXwekL4I5H7t1pHiy9z5dTtCu9vqkpWJQA2CVt2iS9a0Mefxh34DCrWPksC4hX
 yorJkkydsgHKhJIaHo5ADdZHGUKk/U0alhtAymgKSxy3PLp3/WAZ74vae8SW2GJ0wvz+KKl7RG
 cLU=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="141220134"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 07:44:53 +0800
IronPort-SDR: 1pMZPj6ShBQRD43Mkyi6PCu5OrTlUnMuc9U/Amk/ghWrsbtWbvTNR6GC0P6EOf7CpJ+d3xy7bu
 L1GkMwiB09nmGHKCS+a3G9vDtrIVoW16E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:33:13 -0700
IronPort-SDR: XOE0qzV3gOcUVjTZqV2zR0gAt4486Qd0+ZKTtGC+7TEtI4APUPn2jB3lLbTrA7WSNmPLQxX+9i
 /fwMiZj37B2w==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jun 2020 16:44:52 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com
Cc:     jack@suse.czi, rdunlap@infradead.org, sagi@grimberg.me,
        mingo@redhat.com, rostedt@goodmis.org, snitzer@redhat.com,
        agk@redhat.com, axboe@kernel.dk, paolo.valente@linaro.org,
        ming.lei@redhat.com, bvanassche@acm.org, fangguoju@gmail.com,
        colyli@suse.de, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 10/11] block: use block_bio class for getrq and sleeprq
Date:   Mon, 29 Jun 2020 16:43:13 -0700
Message-Id: <20200629234314.10509-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The only difference in block_get_rq and block_bio was the last param
passed  __entry->nr_sector & bio->bi_iter.bi_size respectively. Since
that is not the case anymore replace block_get_rq class with block_bio
for block_getrq and block_sleeprq events, also adjust the code to handle
null bio case in block_bio.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/trace/events/block.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index d191d2cd1070..21f1daaf012b 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -272,11 +272,19 @@ DECLARE_EVENT_CLASS(block_bio,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= bio_dev(bio);
-		__entry->sector		= bio->bi_iter.bi_sector;
-		__entry->nr_sector	= bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		if (bio) {
+			__entry->dev		= bio_dev(bio);
+			__entry->sector		= bio->bi_iter.bi_sector;
+			__entry->nr_sector	= bio_sectors(bio);
+			blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
+			memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		} else {
+			__entry->dev		= 0;
+			__entry->sector		= 0;
+			__entry->nr_sector	= 0;
+			blk_fill_rwbs(__entry->rwbs, 0);
+			memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		}
 	),
 
 	TP_printk("%d,%d %s %llu + %u [%s]",
@@ -380,7 +388,7 @@ DECLARE_EVENT_CLASS(block_get_rq,
  * A request struct for queue has been allocated to handle the
  * block IO operation @bio.
  */
-DEFINE_EVENT(block_get_rq, block_getrq,
+DEFINE_EVENT(block_bio, block_getrq,
 
 	TP_PROTO(struct bio *bio),
 
@@ -396,7 +404,7 @@ DEFINE_EVENT(block_get_rq, block_getrq,
  * available.  This tracepoint event is generated each time the
  * process goes to sleep waiting for request struct become available.
  */
-DEFINE_EVENT(block_get_rq, block_sleeprq,
+DEFINE_EVENT(block_bio, block_sleeprq,
 
 	TP_PROTO(struct bio *bio),
 
-- 
2.26.0

