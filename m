Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3262FC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4DD60041
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFVXW5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 19:22:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62383 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFVXW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 19:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624404040; x=1655940040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=daMI8xz3xkwQtAbMLhZwGVIJc5mfksDozBereM86/uU=;
  b=BIK2npv8GsooO0z0Nau4T/R9Hf90bm2xpu6NnlisznPxIwp4K8YYo+Ga
   RpHtaVBQXVQvewQRvFlXh3U1eMNJNHCgs+gzsU077meDd9pG7NmVwc742
   vMhpoMj+b5ihVpjHaU7KdnIjxONQRx6ZkDkpnw5fRKNoEifJAIkzUUygk
   z12QeF73Ycpsw2jpRINFc07NQz72AuI5jKfEeRhLI7LW5oQi2bzemKuJO
   ZXOPmCol8or5rVgmHGOqew2vnFnEqUDxhEKHTP7h2WEaOMgaSeYaqINy9
   X2pIkRt19J26n5yiBD2JVV5FvRuDDX7jQcqyj/5IAhrWCKdeUU644Hc4J
   g==;
IronPort-SDR: +eyf6RP7RZ+/+kbiz/JE3QtnyLbAirTX29krHRpA2LGFz3AmIewkLy2R/0tnUvRhzfPM3iz8ms
 fsqtT2dsNdh4BNScp37yftwj/j9FiNbw8mGIXFrsS4TNraySq8VNZgOe/9GszGgjY1pX6auByN
 dcQpVmXRBCthj2MSv0jfZexOrLFZphil4HmiVt34nvO9tgDmbniWn2c4TMQvpYmXf1PMae/N+R
 QImnbp0Q2UF7VKb1W8SqG13y4huaI84IOM15f3rOVcAy4oFwg3KYFyEIoCmYnHLm3WNRnnkW29
 UIQ=
X-IronPort-AV: E=Sophos;i="5.83,292,1616428800"; 
   d="scan'208";a="171883455"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2021 07:20:40 +0800
IronPort-SDR: Hr7jiv2mxzSO4cvLkRcg+WwwDcqhxcf+aagJS2KGRVSTQEZmKv7cEPMR1ruJsmb11/tr/McoDW
 M2vH4KG4KZ/YYnezRMyJSVWODTn1oeF0sHmTIt5xhXeCPXV5CVl7spRNhQRWmYHgAdZaM7g7/2
 xyomkEjT3OVUUHtiR99BVoIHCJk50K/FKQJ4Jj4V4geYrO+gt2vO0+AVkT11n9RZLPu/fxTmCN
 BPm8OcPv0UyIAZCxwO2Wj/+7CRUHptimZa1pIVXT+l1DWxE3C+SUV2d3TqP1yf+8RvbhdKXumF
 tENy6vInm0FOPRLCiKGcfK4W
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:59:17 -0700
IronPort-SDR: NmVdKf1AujvDdVmMmWpGJsMzjepTBjgrqx7xJk+p0qsthJDNAZ4Aci2v3keYTtuP9SLWOy0ISk
 5OnWjdjBn3ZvC8z1eRkUIjtx/Hd7636th2eXhV7GzEWOb9mTKa5FdLFPjlEGRIj4unG//NLXfB
 9ZJvp61jbHWHj8MX1LInEu8xrEU/PLPAglKtksJaLt1pESZFswQgFFeGKaiM/YnSveE8PLqGeR
 ZUeCZxoJEGzt9IVrNV9JMWknZ7SXFHTWAakrJZLFS8Xm0eT064uHksiQ33W2LSBg0udZIm0J4X
 pH0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Jun 2021 16:20:40 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/9] loop: use sysfs_emit() in the sysfs partscan show
Date:   Tue, 22 Jun 2021 16:19:46 -0700
Message-Id: <20210622231952.5625-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done for partscan
attribute.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3b11d9f21018..96bc4544328f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -826,7 +826,7 @@ static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
 {
 	int partscan = (lo->lo_flags & LO_FLAGS_PARTSCAN);
 
-	return sprintf(buf, "%s\n", partscan ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", partscan ? "1" : "0");
 }
 
 static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
-- 
2.22.1

