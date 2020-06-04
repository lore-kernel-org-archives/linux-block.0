Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDB1C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 07:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19317206DC
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 07:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TndEz72K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgFDHNx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:13:53 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53678 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgFDHNx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 03:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591254833; x=1622790833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=73wzUu0PqPaA5I+UoIjvLyt/GR5xek7lh4xaBv3Gghk=;
  b=TndEz72KcJRELQc2+RfCftZmDbXzLKOYtfq4b2opcvUlCPka1SR1fSVr
   mhPhIBLl+pcZUyWR4oKqEraXkKwSXLMv4Yh3h2UhpQM8QTEV9IdsdGSxv
   Py6u+jjpYdRdJjyQeBT6U6oEtwPn7YJJXWGUjn9Tm55fB6f73SzPbdjSr
   vkUN2IY/OAJL+387YiEjYwLQtpg0YB0syclZTv3x4KQ6t3jjXVrvRfH8w
   vq51YZU/ZU37YJ+FQpT+XSN+o9E9WmAf1IEMcdFN7hP+ZPTsrq5HTCzKx
   NNVMjXfl2YM1gxzbaxO8SIQ+fRRSDhZ2dya0pIAmhnRXYQIrMCAlQvhO1
   A==;
IronPort-SDR: KwZixmmK3N9526+SX7OQx7uUTn4BBFyOIlpc9npoOsKx0C3FLe49ABYdk412HlzPcLaxCEtluM
 3Pv+XU8qIdC7QZ8OTXLbYCMtZkPa6Ao3BwzYQHbRMa+ncLUCBkoO21U7vzEzeLR8we9iscOpqS
 kWeOH/nYNL64wPuJRxAb+8NAGQAT3tjm0tqi6LAzXJUkPfaT5ZbvuEPEV8g/tfo0uyVxUdaBP8
 p/tN7pWr+SNlgOWUFvpjPHafWDRBCWT4k6BUx79I6zFBmpfD3JEFTL2eGnvaK3ATtUXsWshDyB
 XAg=
X-IronPort-AV: E=Sophos;i="5.73,471,1583164800"; 
   d="scan'208";a="140602989"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 15:13:52 +0800
IronPort-SDR: 0CtgE2YsXyQObSBs1/R/c0PP8WcX3eMFmZSbNfABn8oytAbZkZOgEGcqidmKYsQBL/LGo8PKoo
 9xZyYPdipRy2nD2qS5j28f8Qw7Iyx3hyI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 00:03:29 -0700
IronPort-SDR: wK2myttvWPuexbXqoCDBJkKzb55qWHvEspNQyoewY8128WVy7wV9Uehsss5vmFiSKgNrsF3jHr
 sepvDZcU9v2w==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Jun 2020 00:13:52 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 3/3] blktrace: fix endianness for blk_log_remap()
Date:   Thu,  4 Jun 2020 00:13:30 -0700
Message-Id: <20200604071330.5086-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200604071330.5086-1-chaitanya.kulkarni@wdc.com>
References: <20200604071330.5086-1-chaitanya.kulkarni@wdc.com>
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
index 70aebd95f9bf..19e37242d0f5 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1260,17 +1260,6 @@ static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
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
 
@@ -1410,13 +1399,13 @@ static void blk_log_with_error(struct trace_seq *s,
 
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

