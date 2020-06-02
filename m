Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9493CC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 01:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72499206A4
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 01:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EfMsOwiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgFBBcW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:32:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17805 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgFBBcV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 21:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591061542; x=1622597542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sDoybVasoZ04UZixGcW814inlyfwtTam+7XIO/YQipg=;
  b=EfMsOwiv2rA+iz1PWtdzNlzI69GmqTdte9Epw9RaNfWKv0J5JR/QVQEF
   Xdxvfqqf0E6lX+VzM2GAqNY3O6Cm4bFxH933Ztniqlok9imHLeDyjgAYp
   41dp8KhaKOuVlUYlEy3KsQ70VoZrrKIBW3MA9GRo4Vw1Cd3E043QnmTZW
   nPN1TK3KlAG/HOWdCfiOKZwPyV+N5mxZWkPUMl3+dhNYKSwxWBop9+8b4
   P1ikVHvPegaydt/PX+a6hZwoVnRAZI4SCpCeNL0F4NqzGcqkzinxAYsUg
   freXfsEeQoi/EgjhsFI6v1SW/kzouwweh5k8ZKaLQUT0qZQFA4EY8dbdZ
   A==;
IronPort-SDR: 69nkzKnx6jiYAN0DzU/r7DdQTBnsZ6FHxtsHehn+BshtoYH+dc2iPrXN2slasyzApxj4B5Y8RR
 VUTB9gyW6rYGRJ6ooNvEEu/yrNO4wVIKCWQKRjdMscbgnTl3crhMl3YosA4XfGZMTluDuSH2eo
 eI5JwNeOyuUOGLKPZaAm4zROOOcWPOvLaXCO2U5A4pEBfgM65LM3m0QGRWGW/hL/ZLrT3YxZHg
 Qf6AikU25RtziT2jGeGzBAWxuVu2TabRe/Yk7yoijWXkiVPTaoePWgv/2vLf9n4Gd2AnEW1Ukb
 yLY=
X-IronPort-AV: E=Sophos;i="5.73,462,1583164800"; 
   d="scan'208";a="140411677"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 09:32:21 +0800
IronPort-SDR: UqXP/UgT2RsoH2WY+x+sWlhVCFl0VC8e9QOFnLDMAtZCON+q2fvVWMNVTMqWYZ88+RmERPwBvA
 Z2LZ03aqMCwbAJ7GLUzETZnLOjyapp8qY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 18:21:29 -0700
IronPort-SDR: RwuWNjsCEgLwu53fguVc3Rvnw16w5YElhzEMZ6tLc5TDoABcp0qWRizc+Qo/uwyZQkeJEGP/Q0
 cbrHmb9YAmXg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2020 18:32:20 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/4] blktrace: use rcu calls to access q->blk_trace
Date:   Mon,  1 Jun 2020 18:32:05 -0700
Message-Id: <20200602013208.4325-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200602013208.4325-1-chaitanya.kulkarni@wdc.com>
References: <20200602013208.4325-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since request queue's blk_trace member is been markds as __rcu,
replace xchg() and cmdxchg() calls with appropriate rcu API.
This removes the sparse warnings.

The xchg() call is replaced with rcu_replace_pointer() since all the
calls for xchg are protected are q->blk_trace_mutex. On replacing
the pointer rcu_replace_pointer returns the old value if that value is
NULL then existing code returns an error.

In setup functions cmpxchg() call is replaced with calls to
rcu_dereference_pointer() and rcu_replace_pointer(). The first
dereference pointer call returns the existing value. If the value is
not NULL existing code returns an error, otherwise the second call to
replace pointer sets the new value.        

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ea47f2084087..27c19db01ba4 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -344,7 +344,8 @@ static int __blk_trace_remove(struct request_queue *q)
 {
 	struct blk_trace *bt;
 
-	bt = xchg(&q->blk_trace, NULL);
+	bt = rcu_replace_pointer(q->blk_trace, NULL,
+				 lockdep_is_held(&q->blk_trace_mutex));
 	if (!bt)
 		return -EINVAL;
 
@@ -544,9 +545,13 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	bt->trace_state = Blktrace_setup;
 
 	ret = -EBUSY;
-	if (cmpxchg(&q->blk_trace, NULL, bt))
+	if (rcu_dereference_protected(q->blk_trace,
+				      lockdep_is_held(&q->blk_trace_mutex)))
 		goto err;
 
+	rcu_replace_pointer(q->blk_trace, bt,
+			    lockdep_is_held(&q->blk_trace_mutex));
+
 	get_probe_ref();
 
 	ret = 0;
@@ -1637,7 +1642,8 @@ static int blk_trace_remove_queue(struct request_queue *q)
 {
 	struct blk_trace *bt;
 
-	bt = xchg(&q->blk_trace, NULL);
+	bt = rcu_replace_pointer(q->blk_trace, NULL,
+				 lockdep_is_held(&q->blk_trace_mutex));
 	if (bt == NULL)
 		return -EINVAL;
 
@@ -1670,9 +1676,13 @@ static int blk_trace_setup_queue(struct request_queue *q,
 	blk_trace_setup_lba(bt, bdev);
 
 	ret = -EBUSY;
-	if (cmpxchg(&q->blk_trace, NULL, bt))
+	if (rcu_dereference_protected(q->blk_trace,
+				      lockdep_is_held(&q->blk_trace_mutex)))
 		goto free_bt;
 
+	rcu_replace_pointer(q->blk_trace, bt,
+			    lockdep_is_held(&q->blk_trace_mutex));
+
 	get_probe_ref();
 	return 0;
 
-- 
2.22.1

