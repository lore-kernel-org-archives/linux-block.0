Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0957EC433DB
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 03:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91CD64FBC
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 03:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBEDwZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 22:52:25 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26691 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBEDwY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 22:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612497143; x=1644033143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RwSG67ACNLCwVXwgmCiXvQu1KQSR5+t16hNQS7JHeOY=;
  b=kEAfFIO8+7a0qFic3dCBQN8Po2KeiazqcoBYLWV7eI42E04VICZVG04L
   5ar2Q7wPFysUyl1dEXhtae8IRSyVgxig4tAGT5PrXm6BIsDlRmqjssXXy
   U0yy5ktudkToHz9vLPMkhAgNaWSQ8lt47baSahUmC809Ae0/pT5m/qFCc
   RWLmW3ewcdHqGOTpQd09o2ku/y7THi8R4M1fUlDQuMjYx0gwlWQbM5BB0
   RY8jIB9ppB4nRg94C6TV/eZkeDU2mF9ww3Ak+zsmEtPzflETu+EkmoYya
   Grf/NMpIhUHf28xOpUTfU2Kh5a+R8azx5EA0L4reunFcXmP8vudDixC63
   Q==;
IronPort-SDR: DYlN++uRKBEmnkN8xmuvVpCTm/27JMZuVzjgB/BP8r60yQJ0b+JY0TDv5ej8glwhORRbGHWDBG
 vNlx1RwrySyGeS1KrE8kb85s9+GweM3weEo2WnV5cvumGYuBJdLSUkosZspbMayojxaEJD/Jqe
 ZWFOgHlMajeOuUnnfDHiKQhofAn+xcE4UeLJl27eOK9Xb8QzTCpe9UKtDPdEn+qeKRJviBt777
 89eXhzsde672rDJFRRyPSpXkMV84HTVy+7i+DlsDFtiLlr5Vo0WEM0MRApX90Dj16XgZP+ZaIR
 zZs=
X-IronPort-AV: E=Sophos;i="5.81,154,1610380800"; 
   d="scan'208";a="163645290"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 11:51:18 +0800
IronPort-SDR: TFD9gs+33eyAeoAjrwZKY4GBrZuG64F819fH3C4T92ZlTB+gdLhuvPIUE0AAxq+QJbCWKwcmpg
 7GpMWhHp8NZp8OL+fdwQSTgmzYds+MfLA+qaM1j0hNqg6IKUtxfD0aSfC9YLkzXijSPvL0fhx2
 qDjlkq9GFZxdTG1SvWTCv/FtoIkqLvVcIDExjZxFB5u1jLHbLR+/l2Y8GYR4hm+Ynd7YY3o/xj
 OwoDH94IwhK8D1nOKUCQoFb45jry3C+4lWFYNR3fBdlPTEVr3cJ33XxD/kVm5EhD5a2sYd0O5J
 R3yD9pBYTj/0zuVAy1wyGdps
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 19:35:16 -0800
IronPort-SDR: CO+PaLAyqHKpp6ParyOFGHUGgdkzGAiWghJ60jfD8gUbOhmXL+vs/poa1G4qCcqlWzUhR4A+pE
 HjrxfWXhlSEJT+mZO6iTFZAuM4VH9W6+/dndWJ1/PHraYEUla8s5lYhSE1QiiPXNfJJ+bjdk3s
 PKQblPpb/N3op2fmH1FLOGchiey2sRdo5xoOcG+NtZc78/XRec0JgAlRpe1HK+RryteIBrx5HG
 TPqU63FMGCmYwe+dZEXmJ5+t0Ei+glycLfLka9jAy1MyURGp5vs4yMXDI5ntQZbVtgPNKejA9U
 VM4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 19:51:18 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, aravind.ramesh@wdc.com,
        joshi.k@samsung.com, niklas.cassel@wdc.com, hare@suse.de,
        colyli@suse.de, tj@kernel.org, rdunlap@infradead.org, jack@suse.cz,
        hch@lst.de
Subject: [PATCH V2 4/5] blktrace: fix blk_rq_merge documentation
Date:   Thu,  4 Feb 2021 19:50:43 -0800
Message-Id: <20210205035044.5645-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210205035044.5645-1-chaitanya.kulkarni@wdc.com>
References: <20210205035044.5645-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit f3bdc62fd82e ("blktrace: Provide event for request merging")
added the comment for blk_rq_merge() tracepoint. Remove the duplicate
word from the tracepoint documentation.

Fixes: f3bdc62fd82e ("blktrace: Provide event for request merging")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/trace/events/block.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 004cfe34ef37..cc5ab96a7471 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -210,7 +210,7 @@ DEFINE_EVENT(block_rq, block_rq_issue,
 
 /**
  * block_rq_merge - merge request with another one in the elevator
- * @rq: block IO operation operation request
+ * @rq: block IO operation request
  *
  * Called when block operation request @rq from queue @q is merged to another
  * request queued in the elevator.
-- 
2.22.1

