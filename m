Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A04C48BD3
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 02:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4429321852
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 02:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MDFDqWWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfF0C7o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:59:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52735 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfF0C7o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 22:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561604412; x=1593140412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k88Jxm6UjOcpOAysM42/2nMwgTKJ8DZeNJDi00vUgkg=;
  b=MDFDqWWBVY5DLyFg7ad3YfnUMlxb4qJ2JZPiysLKHvYyZESXgd0iLo8R
   TlqY01oJOvNIC/fBPtfmr1eXT7z5tYrSi43w5UB416h+zMkyB24zIYsx3
   Gp4Tk4BGfCRV1MKsn3z2gaBa+wh0VeIFGehRfYIQR5pq8AvcmNra2Bhwf
   6YnBEAE84jiIcTVISaXXYQx1p1MfooiyvgCGg1F25EV+VBYNF5sL2bUYQ
   CQ6AiW4lOQSFNRz07I+FyKYKEkLTPe+LXn+/QkSbSWilCizlVbL4N5p65
   Sit04iH8pgwR5zXmDL6Nh6HfcJMpkRnPoDajj+wllb3EEZLNV4x/nsq2t
   g==;
X-IronPort-AV: E=Sophos;i="5.63,422,1557158400"; 
   d="scan'208";a="211457393"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 11:00:12 +0800
IronPort-SDR: R1CRBbuKUb/MFMVxE/9MRliz4KQZqZs7cmgZDK++a9w+bAdMaLqV23rJA4pZqq9xvcpcRaq9jQ
 KjS6lHjA8Xxn5hQd/kMfKNG05BV5P6rON7WJU5JrMf9FNp8l/EddEXEi3GQmaBko8FVvh9Z6xp
 M9aq6YVi0YH6Rg/1CiE0HOsdTsGKepPbcKnKOij4sMhlb+WQTexuzGehLLtwcuz8IC4bhK9GU4
 hHytPb1Try+DQcvKWr0HoWpLNrNVSZVmf6FCBh5yOLtNk9NK7/xTTxQCBnbpD6VHgy7IBXSIhP
 ay2cbkabLyUoORMIzxOD4YN+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 26 Jun 2019 19:58:57 -0700
IronPort-SDR: yGnUfJNHWZ1eb1bPB2qNwZiVWeCrYPrjQPvZbu5TIoVZDJDVN4xEMJweXePM9iAd86bDXx0CW9
 MXGrvl9nvIliSs7bhhAY5hRzJwmxVyFVwFpa5L6oC2kEyaQhab+4q/yw2ipFJIZoQKCxcWfWrB
 LuM5B0yK0vJ3bvSZqB7TV24qW8nbul3oQAcsTwlM7F3TdFGl+Js4oVUQZcAsxwq70Ql843CxKF
 2j+Gzx9o9pp1AmR444tNXctZdawoVTPrCpLkA8qh0Czwx9t5sXVefc7Kc5gW0cOa1eYBVmZO/s
 tp0=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jun 2019 19:59:42 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: Remove unused code
Date:   Thu, 27 Jun 2019 11:59:41 +0900
Message-Id: <20190627025941.32262-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_flush_dcache_pages() is unused. Remove it.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/bio.c         | 12 ------------
 include/linux/bio.h | 11 -----------
 2 files changed, 23 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1c21d1e7f1b8..85a9abe9cf21 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1816,18 +1816,6 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
 }
 EXPORT_SYMBOL(generic_end_io_acct);
 
-#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
-void bio_flush_dcache_pages(struct bio *bi)
-{
-	struct bio_vec bvec;
-	struct bvec_iter iter;
-
-	bio_for_each_segment(bvec, bi, iter)
-		flush_dcache_page(bvec.bv_page);
-}
-EXPORT_SYMBOL(bio_flush_dcache_pages);
-#endif
-
 static inline bool bio_remaining_done(struct bio *bio)
 {
 	/*
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f87abaa898f0..34e05a6e139c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -444,17 +444,6 @@ void generic_end_io_acct(struct request_queue *q, int op,
 				struct hd_struct *part,
 				unsigned long start_time);
 
-#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
-# error	"You should define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE for your platform"
-#endif
-#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
-extern void bio_flush_dcache_pages(struct bio *bi);
-#else
-static inline void bio_flush_dcache_pages(struct bio *bi)
-{
-}
-#endif
-
 extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 			       struct bio *src, struct bvec_iter *src_iter);
 extern void bio_copy_data(struct bio *dst, struct bio *src);
-- 
2.21.0

