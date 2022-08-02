Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C21C00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 12:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiHBMXy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbiHBMXx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 08:23:53 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3194E60D;
        Tue,  2 Aug 2022 05:23:49 -0700 (PDT)
X-QQ-mid: bizesmtp84t1659442953tp7oel5m
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:22:31 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000000
X-QQ-FEAT: zT6n3Y95oi3YcXScO5TqXcno7fdicyyy+wU9d8QmMtnkqdIp13Jl8Z3kasfLi
        GnUyTS/6vBu6HoIcjHNM59C7h7G1y8s6W+PeJ88V4KPyvdlF5by5bUNneEO6lbzpUIYgcgs
        fF21Kx2PGrT8u7+Ps+zR8USiEwgAkQcPmEDmXIiHOmMWDNb4FEZEmc2BkaV/dw/5gwwEjay
        5NXAghtqUhKL9uLQ/il/weizoLAwZgXbU1E6U5B6v/DZop57E0TjnOvhWhoc8LfptmSUlxM
        T+xQhcviOt0KIqUVAMAdKNEJCaP/ZQasN0ah9RFIdoBLp+uuCTHfEyzCIG0itHnAsDWPqWh
        4iPI/2WWcY8e5hCKmjZiH3J8wnyPBn17qLMrA27j+KEDGctopVLE6ln8YYhn5vuU6b/BkUO
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     axboe@kernel.dk
Cc:     hare@suse.de, martin.petersen@oracle.com, bhelgaas@google.com,
        kch@nvidia.com, john.garry@huawei.com, ming.lei@redhat.com,
        vaibhavgupta40@gmail.com, Julia.Lawall@inria.fr,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] block: Fix comment typo
Date:   Wed,  3 Aug 2022 04:22:30 +0800
Message-Id: <20220802202230.9460-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The double `is' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 562725d222a7..82a4812e74e3 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2487,7 +2487,7 @@ static int mtip_service_thread(void *data)
 
 		/*
 		 * the condition is to check neither an internal command is
-		 * is in progress nor error handling is active
+		 * in progress nor error handling is active
 		 */
 		wait_event_interruptible(port->svc_wait, (port->flags) &&
 			(port->flags & MTIP_PF_SVC_THD_WORK));
-- 
2.35.1

