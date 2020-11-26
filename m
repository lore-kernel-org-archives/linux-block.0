Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BE4C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DBC207BC
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AbymjKwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbgKZCl4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 21:41:56 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45550 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732808AbgKZCl4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 21:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606358516; x=1637894516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hUhzJ651cVoNvniIQeg3wff/FCoz1DE77FDFCSJt0Zk=;
  b=AbymjKwbriq99Wl5+l3BtZxFiC5rdvEl1/51whE2+r2BFhQp9pfjClop
   pXdOdP2Uv4O+P5IvhpTrVe2iMAtPTTSlcggugWxsA2Lt6APuwJFbaLQf/
   obK3VW3vIEa2P5McV9XFDPZcRtJsZwr8g2etuQZurBVmz/y/bSALXyxGI
   Rl0N90rBLcw4CEfjPjJ/1KIq1Lao4v7Z1EQoDzKj1ibqEGPzX/rzjRt/R
   S8RK8GhPg3xVCgOhMJq2T7FDQtJM9rp8UHd5WRZIIvgYXtAlVrpS2UOC9
   xWoGPvbkc+N++upAVsljkGEun7T5dOilnO9garjLq1nJO8lWbtG23ZKQq
   A==;
IronPort-SDR: 4ZyCK2pCEC3NuGoZq4GDMfasXQaAjrT26tbqjD7pQM6AHxOTYacSsqApYJD8ZqcxrBD7oCjnU6
 EKEr7/MW2eR0uSPDemthjIDFHpUT9a2rY0WfZKM9Xg/jsmcLiDZOrPCiTi7dk19kTEJZiphakS
 8vccOaB+UiX0zgl5zWuPG+E2OR3tL45qv37KmVP+8U0iFvl18x3Yc0+G6Zo7RR8vP+EqmuLBR2
 nYqOqqFlX5Awytm53RbtDsPEYFVgvLNNUIY+QmPyRXbS24+ZH7YA7m889rvotJAaHSuV3TJdT1
 DGM=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="153586939"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:41:56 +0800
IronPort-SDR: Cpz6QEw6r6NLt9JC8Q93CW12ac8EfdCpijyexasu0m3+a3zj0L+uWNV6HYMZlq1g6jiEWt4CeD
 CYH2C4Mx2fC6ZlaX4mZslSZZqyW4lydxM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 18:26:18 -0800
IronPort-SDR: OQvfIqn9EiwcYC7awggW4nUlJ1jJ8l8UvELmdegT05BX7QVx4OJyNRt0t/Ln3dOxKG4z0K6RKU
 OXzggKKmNl7Q==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:41:55 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 7/9] nvmet: add zns cmd effects to support zbdev
Date:   Wed, 25 Nov 2020 18:40:41 -0800
Message-Id: <20201126024043.3392-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
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

