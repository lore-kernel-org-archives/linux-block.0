Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78326C43214
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E63F6101E
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhHLCob (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 22:44:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHLCoa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 22:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628736245; x=1660272245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N9HTUe3fPenLFb7TILYqOuQ90dOIPTNwU0OUTxnf8fo=;
  b=Ge0cg1uOTP2VCjPW6Z8DXp0NV1RkhZpYhgOqSoYHYEQvRFXyxgbf7iUj
   RNgRsUOewPxgmi4GoxqyHqbmA6DbwDNgTLy0hxc4jMiecGIa47ighWCHO
   rbWX0LQgCY3NaEclOwV8CR8E2GStDwbCwVU62YRfgfLTBbGNZWM+fAu1s
   nTL+K9r1wBfRPL3YyNwFuWoi9EKTnrk3rGdWMsHyQhtclmEHy9McPa3Ph
   TlIiUq8Bw4m5FAkQgCSg9TD9A9amWD/PkCO1EmRmpw9M1gqD7dbSG5bsG
   AOUCN4c1eTfAa4zwZAnrhGAyBTgLPyWK7+kkcxOFksKji7JFQhjKDoUyr
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,314,1620662400"; 
   d="scan'208";a="176999856"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2021 10:44:05 +0800
IronPort-SDR: Lq4VrNoeBoXhnGlSjftFi0Tmg9MK2WTGuTo/2qTeaRacYBMdtFiudl5feYd17qbsO0BPLVkEGs
 zk6LZE4kX4WTeV1Kgh8BM5rIQDIr+6mvQFvE6MsY2gUgJ1WXMpVffmAaXCIA0VxWN7C1lde08m
 p7y117LcMFkM/nyI9DfWIE4s86bncw97tzZYrx3LrPxI8zKjQFqRi51H6XKzSNnbwtTKQ8DB1b
 EZhghUpVFKON6HuVvQ2s9PHYY9QpBsxsvmLRedgUEHG69WFb1STi43flztguTBRLxWSfNxp05j
 BstFBBoClTSkLvZ7NO+Mfk/I
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 19:19:35 -0700
IronPort-SDR: 8SseMKCTyzRJjk+0sDVc/tZ+R+fllLBeOROh7bGCJqBrL3bAsum6xcG8ZjvLkGJ11nIlGrS6u1
 u93kMcliPJ8Ogd5YBi9lCchTJE3G32HLLMOjZJh0wftFRq5Apbj5P0OGSlRCPZN7+Xj3kFazpX
 idJFZ9Pw2Z2igaPZswQOy1pijS5syETEs4BozmcrJn0UPjKXNhGKSYbndZyE0R/L7VS/ygsB4Z
 Q8k+8hqDUiEe5LwV1s6TLmqL/KF9C+TzpM+M6GqdBe09Q39kxPl9OkWTiIjTAlrX0N+aPvssU9
 L1c=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 19:44:05 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v6 1/9] libata: fix ata_host_alloc_pinfo()
Date:   Thu, 12 Aug 2021 11:43:55 +0900
Message-Id: <20210812024403.765819-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210812024403.765819-1-damien.lemoal@wdc.com>
References: <20210812024403.765819-1-damien.lemoal@wdc.com>
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

