Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D695C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 06:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252EF2086C
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 06:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbeLPGIj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 01:08:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:50083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbeLPGIj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 01:08:39 -0500
Received: from localhost.localdomain ([113.87.89.150]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0Lcj9b-1hFPeQ346x-00kBeq; Sun, 16 Dec 2018 07:08:34 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     ed.cashin@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] aoe: add __exit annotation
Date:   Sun, 16 Dec 2018 14:08:18 +0800
Message-Id: <20181216060818.26986-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:aTljckzLamhgD9eIyfJaMoGijhnbpdhKrgd+Us0lAoMpg5HIC8p
 GaIgbkp0/mvKaC54j0ckZniYw/SwCEIe0nz0Q/FembLo/mBk1/ArvUEgpbR5xGZLXml5Oi8
 KQ66o70i3BMRzF3/GjAQZZ5sxYdZPlO1aHJnMmsvmZbEFncyPuhWqSSdZerbM03y5tRrpR9
 eHvdQ4yuD3b1IkA7W8SUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8qEL9PhZTHQ=:jL+k3iHU7m/L0d8lqnBzqg
 zYepbi8k38trR+C34zwIWwv8rEEWf/QnXqSgOStZwW4P2cgySuTYAu1Xs0k0fwPmINvOlcdNT
 W59MbxwspaG05v+q3NotdpiXXdth5m2HWV3tUgLzlDnwuhctKKno2trxRQrqEZlafPDglUdqE
 p2pWGgERIaV+W/Xbm2bbvI5w/7rrhNdhLVJB4CNnb5AA4RZHOMTxyPvfjb9MZLnusFJLun86Z
 2KZJ67iIUtYdOMHLHBJfecm7zIpkSNAO1gaBCqEXsFTeVd/IZHYDYwH/uLxIjx3h++E044/JK
 GX4EGdVxcIZx6vEI+WTkyPOQsCE15md8Mnd2DjZXvKbMQOx907xrlsVmiha5NbVRLfj7glhdq
 zHK8ZxxB+OFdk4jlVmmKZvy8PHvC46ciMVcINY/E11+KztorsqNvkB/F+kAOOeNFe7bpoIoGW
 n5M0f1Vsqtin0l6Kz0479RYW94LvL5Ril340qvJyzCTI+GlLMSTDXR4ax6lY8cGDddZX3sczX
 U9dGkZMryNiqDGXOwr5ZeXP6WqSPSLyEN9mFi9rcNCGzrVcPBe0AVkHGMI7olFx2PTRpXdBh0
 wTdfD4mS1DvgeNtl9eT79biDeFbzPtgIgAzc09OkeBKPjtmJLx/f4UhmrXcUEFH+WXHWBi40F
 jF3nfbit6T0cF/3ZIxo2VTi3h4iXWAs7sgJONxd2MtSJbAbW1TXISx1ZGRS9oXhGFEmBZMZ6T
 S7cUNDdCQC5JH8+N6qJYx5SCQXi7QBMFkrIXE1Q1ED0Sw4oU8epUcRhMI81+Uj9EH2xBGjBLF
 9z8L8R60uYoy0fsqx+0lZQQ/UMUAXx5jV08f9ulrqz9Up852lxCP0Q8iN2hcGizeHzQM0mTWj
 QLeZi2bS0JnARzK66iMP6xuOdJt8tTdN0TzyliKao=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add __exit annotation to cleanup helper which
is only called once in the module.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 drivers/block/aoe/aoemain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
index 251482066977..1e4e2971171c 100644
--- a/drivers/block/aoe/aoemain.c
+++ b/drivers/block/aoe/aoemain.c
@@ -24,7 +24,7 @@ static void discover_timer(struct timer_list *t)
 	aoecmd_cfg(0xffff, 0xff);
 }
 
-static void
+static void __exit
 aoe_exit(void)
 {
 	del_timer_sync(&timer);
-- 
2.17.2

