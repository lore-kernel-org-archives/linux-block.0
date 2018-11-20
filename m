Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59FFC43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B352080C
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ELHz3zVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B352080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbeKTMT3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:19:29 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40409 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbeKTMT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 07:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542678772; x=1574214772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PqsRyv7c9EpA5+rWoMDfypmdvWAN47Krw7kw/Y2Oin8=;
  b=ELHz3zVqv5vbsqKH49vDhVmA71FICkhPBWdjg2SAPGLDU0lAqb3jHvsf
   hQ99k36B9lxxMwvyJWg4/MYmEHO1RAWG30T8VwYOFghbENmMfPMQVNtaG
   rjhMQWeS21UPRNOtf7QrSETXOpf0l33HznbFamYzOc3COns53OiHTPAUp
   0X4YepeWYbLIkRsVMMJbzlcdozkaW9HDoufNWUXgbfOD5YUrs7kFnAANL
   kLNmXi88cPS89Q2QLN2rSq3LQuJYFab1VDRIW2k8UYpD6TQ4IPFSEYyOU
   hUW/upYmAv6GYPCfzDSJ8h6SIRLf2ENrsyUcZBVcMYzYygiAPGpsW4RJN
   g==;
X-IronPort-AV: E=Sophos;i="5.56,255,1539619200"; 
   d="scan'208";a="95813285"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 09:52:52 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Nov 2018 17:36:07 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2018 17:52:50 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/6] aio: Fix fallback I/O priority value
Date:   Tue, 20 Nov 2018 10:52:36 +0900
Message-Id: <20181120015238.26467-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120015238.26467-1-damien.lemoal@wdc.com>
References: <20181120015238.26467-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For cases when the application does not specify aio_reqprio for an aio,
fallback to use get_current_ioprio() to obtain the task I/O priority
last set using ioprio_set() rather than the hardcoded IOPRIO_CLASS_NONE
value.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Adam Manzanares <adam.manzanares@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 301e6314183b..b984918be4b7 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1441,7 +1441,7 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
 
 		req->ki_ioprio = iocb->aio_reqprio;
 	} else
-		req->ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+		req->ki_ioprio = get_current_ioprio();
 
 	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
 	if (unlikely(ret))
-- 
2.19.1

