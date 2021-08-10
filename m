Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3F1C43214
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A4DB61051
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhHJFuH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:50:07 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9539 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhHJFuG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 01:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628574585; x=1660110585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N9HTUe3fPenLFb7TILYqOuQ90dOIPTNwU0OUTxnf8fo=;
  b=U3xbJfERL0Um5mrhrvlTqwzzB6SPox/8qUoRKjxbwwlC8pwTiIWCGfcv
   jG3olqAsHw9v6W+RKCT+GSQHr3vG8W5NXi9JhAhn61Zf8lYdw0Fwr98xe
   UXhZehO7TcUx50BrkWx0oK3+K1iMnpQoKhBpXw65PHNRgVTySYiU44Hcu
   PSp31BdCtDL51oOG3W+c8L4rTn666471Ez7mcAOELHcmytox1XOUMd3Kk
   4tDGYSHIeQhczILPicVQ3xhL5z2CbKpm/g6KZ4DGQO2r1wDrWLclSGkQF
   HXC+hmyb7kACe0aer7zt37RtuF9pnDl3Tgvdx06Iv5BrLPVP0Uiki7xRf
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,309,1620662400"; 
   d="scan'208";a="288340180"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 13:49:45 +0800
IronPort-SDR: IrjvkJPznNtalmOYfwRfbeiWq5reqwR6PaP1n83SqeEVOoB0zWNEgSRHHcIDKL42m5Ewj/ZNxv
 7cAu+4nN4xKhcnlxKIlgGXTGEaqzQNcnlj9Jzbyn4JSNvzH2Sbfn80mtqr5z1CxLw2zAGlMbiZ
 vMkrJABM+LNx+kmOh376OCogjgZk2b1pxoKi982ev/8FM8Yz5pU2ZtVmJ1PCaFVg9sXxOOfj5w
 AcXHwhirwBkbUgBB/OUBKU+rCB8104fPRAadhkT+PBUsokyffFta04wpNHyLy0PbRNZdFimyww
 V6kCxLVdWNILJL7R6ya8JnbI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 22:27:07 -0700
IronPort-SDR: 79zRLzMH4X+kgTkweewrXnwysFpygZK9ky41KR3sDSm3FyGpdcX6+74D9ySlhwbz/IxFSzLc9W
 SYTqvzfs3h46q5kGUgwK7ImgLyY35/v+BmCtn+RFh3b1aSL1AQMvecBQKx2G7EzY3DQ5DU6rcv
 Ed6XJLwkoYeY/zLIRUcupUgQzqRSPKqk3HZMgbPeTblNRwd/gCcvU+MHa03NdQM2MlEVKYF0jc
 QtYe26zmE9ilX4bNmmNkiVFzNQg6gNu/23I4aLa7XgNh+Wd8ZzB5CtLfjvoLkm7Rv8EWn9d76r
 REQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2021 22:49:44 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v5 1/9] libata: fix ata_host_alloc_pinfo()
Date:   Tue, 10 Aug 2021 14:49:31 +0900
Message-Id: <20210810054939.30760-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810054939.30760-1-damien.lemoal@wdc.com>
References: <20210810054939.30760-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Avoid static checkers warnings about a potential NULL pointer
dereference for the port info variable pi. To do so, test that at least
one port info is available on entry to ata_host_alloc_pinfo() and start
the ata port initialization for() loop with pi initialized to the first
port info passed as argument (which is already checked to be non NULL).
Within the for() loop, get the next port info, if it is not NULL,
after initializing the ata port using the previous port info.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/ata/libata-core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 61c762961ca8..b237a718ea0f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5441,16 +5441,17 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 	struct ata_host *host;
 	int i, j;
 
+	/* We must have at least one port info */
+	if (!ppi[0])
+		return NULL;
+
 	host = ata_host_alloc(dev, n_ports);
 	if (!host)
 		return NULL;
 
-	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++) {
+	for (i = 0, j = 0, pi = ppi[0]; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
-		if (ppi[j])
-			pi = ppi[j++];
-
 		ap->pio_mask = pi->pio_mask;
 		ap->mwdma_mask = pi->mwdma_mask;
 		ap->udma_mask = pi->udma_mask;
@@ -5460,6 +5461,15 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 
 		if (!host->ops && (pi->port_ops != &ata_dummy_port_ops))
 			host->ops = pi->port_ops;
+
+		/*
+		 * Check that the next port info is not NULL.
+		 * If it is, keep using the current one.
+		 */
+		if (j < n_ports - 1 && ppi[j + 1]) {
+			j++;
+			pi = ppi[j];
+		}
 	}
 
 	return host;
-- 
2.31.1

