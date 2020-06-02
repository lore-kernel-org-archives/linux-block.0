Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C940C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 01:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA25206A4
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 01:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YK1HzSKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgFBBck (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:32:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:23320 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgFBBck (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 21:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591061559; x=1622597559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZIStS7QK3y/yf+e+Le1HUW+ifkiVvMBbmge90umbnHI=;
  b=YK1HzSKkewwTN9THsC4x648P16/nlFoIzF5wvf3A+Z4ZdzoBeIZHfvDZ
   HdVLJTjOgCuHqdV/RU+5EXeMt/CpVe7zAR2nDSYZTv+mRNDNJtnTlm+p1
   AbwMxjpHlzaAnBqJ1BcYiUtn/u6914cijZDtU9SmSAzMiLf304Cw5dV8J
   5Jn45UpwN6yfEb9mGpcsIGPzgJNL1ZKN4wbTSOGp+/SdyRvOr5TexFXIs
   Wpf6eiX7Z3c7YeEmobLt8pcuidYI2hCsgMxHQx21R9IBZYPlxqLPaW/kk
   sppYQlBXvkCpx1Scp7uVdGjtUJjeex4G8OY5JkeXcsknQRtDNH6wHFRmA
   w==;
IronPort-SDR: 57hvK0+e1PKyfbNN1XLGeFSqtP3SG8/N4nj+ANBeBoSIYY1vxE8nBKGtgaWdyBWdhOn79vtCFj
 pbnVm5ydhMTmiN4hkiCXcCaEqRSvTD5alpXLzDEJYMUmSTv0sZ3A2ch4F/p1dN1viUUoEAc65f
 dx0d/uCqFyMh7UYu9ov/O3K6YOfbXYY+tpjtpLjELvLXT4lCi7PBO7bnDJMZupNr0SDHRUqXvm
 rjPIehn/W+kB7JaCsiI61Wc/+ReMAV/s7EayaJ6fHctgItazpXh4kkczm1AxNly/JA6p4O5XCL
 gFs=
X-IronPort-AV: E=Sophos;i="5.73,462,1583164800"; 
   d="scan'208";a="143316969"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 09:32:39 +0800
IronPort-SDR: Oh2jWmirCPV66n7FXG/aqrFNI2Upb4Rz25LD/mxpHdVnPpjhoQK3ldNEvSwAsvpOFqdo6Ydm8t
 Q6zXxH5O8mXvrT+8zMV6f9cqliHrNwBOI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 18:21:47 -0700
IronPort-SDR: kRUQIeOnFhpZd90KBOnn61pXNVawD6TAaYARaU+ZQfT82QeLeTLzYYDSIlM+5Kai6VsnXzMaDX
 z8q1ostJdXsg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2020 18:32:38 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/4] blktrace: fix endianness for blk_log_remap()
Date:   Mon,  1 Jun 2020 18:32:08 -0700
Message-Id: <20200602013208.4325-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200602013208.4325-1-chaitanya.kulkarni@wdc.com>
References: <20200602013208.4325-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function blk_log_remap() can be simplified by removing the
call to get_pdu_remap() that copies the values into extra variable to
print the data, which also fixes the endiannness warning reported by
sparse.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 01e192a52c9f..7cfc293f9697 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1265,17 +1265,6 @@ static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
 	return be64_to_cpu(*val);
 }
 
-static void get_pdu_remap(const struct trace_entry *ent,
-			  struct blk_io_trace_remap *r, bool has_cg)
-{
-	const struct blk_io_trace_remap *__r = pdu_start(ent, has_cg);
-	__u64 sector_from = __r->sector_from;
-
-	r->device_from = be32_to_cpu(__r->device_from);
-	r->device_to   = be32_to_cpu(__r->device_to);
-	r->sector_from = be64_to_cpu(sector_from);
-}
-
 typedef void (blk_log_action_t) (struct trace_iterator *iter, const char *act,
 	bool has_cg);
 
@@ -1415,13 +1404,13 @@ static void blk_log_with_error(struct trace_seq *s,
 
 static void blk_log_remap(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
-	struct blk_io_trace_remap r = { .device_from = 0, };
+	const struct blk_io_trace_remap *__r = pdu_start(ent, has_cg);
 
-	get_pdu_remap(ent, &r, has_cg);
 	trace_seq_printf(s, "%llu + %u <- (%d,%d) %llu\n",
 			 t_sector(ent), t_sec(ent),
-			 MAJOR(r.device_from), MINOR(r.device_from),
-			 (unsigned long long)r.sector_from);
+			 MAJOR(be32_to_cpu(__r->device_from)),
+			 MINOR(be32_to_cpu(__r->device_from)),
+			 be64_to_cpu(__r->sector_from));
 }
 
 static void blk_log_plug(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
-- 
2.22.1

