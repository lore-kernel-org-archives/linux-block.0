Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24748C6379F
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 23:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBNXAZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 18:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjBNXAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 18:00:24 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADA0C29161;
        Tue, 14 Feb 2023 15:00:21 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id EF34E7A0401;
        Wed, 15 Feb 2023 00:00:18 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/18] pata_parport: fix EPAT C7/C8 Kconfig
Date:   Tue, 14 Feb 2023 23:59:53 +0100
Message-Id: <20230214230010.20318-2-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230214230010.20318-1-linux@zary.sk>
References: <20230214230010.20318-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

CONFIG_PARIDE_EPATC8 was renamed to CONFIG_PATA_PARPORT_EPATC8 but
epat.c was not updated to reflect that. Update it.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/epat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index 6ce2dee7657f..93ee91d9338b 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -324,7 +324,7 @@ static struct pi_protocol epat = {
 
 static int __init epat_init(void)
 {
-#ifdef CONFIG_PARIDE_EPATC8
+#ifdef CONFIG_PATA_PARPORT_EPATC8
 	epatc8 = 1;
 #endif
 	return paride_register(&epat);
-- 
Ondrej Zary

