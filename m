Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529F8C64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABC222202
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgLBGZ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 01:25:27 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64091 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgLBGZ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 01:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606890326; x=1638426326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hUhzJ651cVoNvniIQeg3wff/FCoz1DE77FDFCSJt0Zk=;
  b=rLEMdLap0W/Be1VwHL+UzTWsWSPnSLQodKLTA1kPpiWPtaCIsQbQY7Ka
   3vvWHC0FyHMSfR29g/iOASRTMxFRT78pCQkMziW1AlUFg4FFAHW8eL1Tf
   kPs/MlWdUIdvr6UJ/temKnwwwmt5+iO5Bggjo+25+/AB2ZekGHBkr3Our
   KF00zWUYzM8ULvm6wqwWoJObdxC5qHNLGWR9kY7yAEGUQUNvLPQt0JlIO
   C026rgtFUr5Eff941Ybpbaj7GBfRWk5ig7wMk+wrqhegi7fVU+6nuV+Ze
   ApOKnKGG5bMpqov/i4OPkNSegzAIjAK7PebdA8rHfRU+bGQHKEONFm9Xc
   Q==;
IronPort-SDR: tafnyYNOnsVE+vFkuQC3HpZTh8uOfONCn9mKmmyIwh5RwvIXOSa61xOqpDE0f4Li6gCDnahVDC
 LnpDHDC1Bh2HFdRRpRe/wDzXxx3c85vxpPjpwCvKvaiYDY6UrtF/7rhOFcDlarcIVlkHWFFT/5
 lPhQVrxVrHeZ3ZuNvm5lm4Xn8SZRFSnMgZfDCWNgIdItcT/2IANgzL0gUcwAe99DRFTnludF/P
 4xc9+MyTLNmR4pYiDsJ26P/N2wWYpXsPDCdf7owUtt9oe+jw6WK2dnPrZ7WkfGxs7jjfBrqbye
 BBI=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="153932893"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:23:47 +0800
IronPort-SDR: i3pe/2HMEW0e5E6fk73A1r9l0PW+aMnS39VJm7R0hP7U52MAYVuD86N2wPyuVHsEJpZQ/66mAJ
 cM34BzK2avdkPZeJsfP5LE2SKgOyEhaFw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 22:07:59 -0800
IronPort-SDR: vZR7hBErOwRxhih13IvEpZq+gcAzgtYTdIRxvmOm7ikZiQAm+GML9an6SmLs58wrffQTxMazfu
 BFeyHTE0AVmQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:23:47 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        johannes.thumshirn@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 7/9] nvmet: add zns cmd effects to support zbdev
Date:   Tue,  1 Dec 2020 22:22:25 -0800
Message-Id: <20201202062227.9826-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update the target side command effects logs with support for
ZNS commands for zbdev.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index cd368cbe3855..0099275951da 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -191,6 +191,8 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
 	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
 
+	nvmet_zns_add_cmd_effects(log);
+
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 
 	kfree(log);
-- 
2.22.1

