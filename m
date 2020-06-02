Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCC7C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 01:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E462E206A4
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 01:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cMMBpKJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgFBBce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:32:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10253 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgFBBce (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 21:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591061553; x=1622597553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LVdDTKYe0jW/7mmJ83E3o37G4o6wcSwxMeRq1VoDK2Y=;
  b=cMMBpKJb1rMuX6qsVC13cuQoVGXaoW9V4mV1cNt48bwl2K6NRq2+vAE8
   IBJqifzpkKd45cZyfFq7eJkqszENiJvqaADZxLNnQklI9aJ/Vj6xRF7ZF
   tOkHvCuHneVMxQRsf9Sc51xeTd0MKM/pBjr4FhyO0zDw3JbRJX/ppamb6
   fMNjsNEGEpHg4uIUjMmdrWlCuyrB7Nu8gqcqT83zu+VtV4XeMy9nYmrTK
   p/4y0U7Sd9T5W4MVl6tBYlppLSl3y7boJDoPj0e4isixqfh6enLOhhrlm
   /aa9V8b1dj+dmydS+SNfXcKCLeT92IND+kTI/ZcljGUwiIdXf3LID9UGr
   w==;
IronPort-SDR: ovQLiLZR2YWLQEjNU/Hxl433YOG1K5DMe0N+vFOPVoofZem/HsOpAVlPTrNz+4i7xsyatfCANu
 wbiY2YOsIBQ3tDVsa99tolYP1RwbeO10YYCfvshUf24FvcbZtnsKecSpGC1Js0UwWM28F3dw3R
 AWNgObj0H3XlVnpluKuQ6chFJ11Jy9+zNSciFhYaoA3vK5BsjifZCNRw+2HWKozxk6FCaA2Dlz
 1TU8b8fpQcvU9Bxmc8gsjW6mra5AsFMDZBQX55PZaapPyk+hO71ZWEht0BfGLRiIQA7bDDWLWN
 c7U=
X-IronPort-AV: E=Sophos;i="5.73,462,1583164800"; 
   d="scan'208";a="248073652"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 09:32:33 +0800
IronPort-SDR: QQoM8rIO9Q+QCybvPrJG+T9qqi5THg+ntsrbH16xfQYIvJpC2SwKERtR8Rqtt/rVm96Wn71bko
 RuA6LRUvyltS/pRwlXCAXYROlMtCgrR2M=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 18:21:41 -0700
IronPort-SDR: YlbtWR5ueFA5cCBVd6ilkhhD1MfVKj98oBvXqmTGyuo17SRhudW13PhtMAQ2vhP9IQ4lbpRNpJ
 vrADZY/ZKzYw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2020 18:32:33 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/4] blktrace: fix endianness in get_pdu_int()
Date:   Mon,  1 Jun 2020 18:32:07 -0700
Message-Id: <20200602013208.4325-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200602013208.4325-1-chaitanya.kulkarni@wdc.com>
References: <20200602013208.4325-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In function get_pdu_len() replace variable type from __u64 to
__be64. This fixes sparse warning.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 44a2678b8f44..01e192a52c9f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1261,7 +1261,7 @@ static inline __u16 t_error(const struct trace_entry *ent)
 
 static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
 {
-	const __u64 *val = pdu_start(ent, has_cg);
+	const __be64 *val = pdu_start(ent, has_cg);
 	return be64_to_cpu(*val);
 }
 
-- 
2.22.1

