Return-Path: <SRS0=Rcc/=XO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98211C3A5A6
	for <linux-block@archiver.kernel.org>; Thu, 19 Sep 2019 13:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7789A21D7C
	for <linux-block@archiver.kernel.org>; Thu, 19 Sep 2019 13:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbfISN5l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:57:41 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46881 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbfISN5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Sep 2019 09:57:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MgwBv-1hj3F420FB-00hMbl; Thu, 19 Sep 2019 15:57:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] block: t10-pi: fix -Wswitch warning
Date:   Thu, 19 Sep 2019 15:57:19 +0200
Message-Id: <20190919135725.1287963-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tN+XsyXJdHFnCMzPxDFyb2EBaVVp1Ivx2u5rxFBl8O1rODBEDdc
 2hdSU18cmnE1oADZvswr6ov0IvJhK4PJ3oQytoaedrt4HErtAJstzaERKzuZLIsVTvNQDtk
 MfHohPUVH457DDV34tAXV7jci0NIoFYd8ff9+pWhQMC9cORkOyXB/FePCN+chvUfRGco8JE
 l2dmid2zR9cFKxtAi1wvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PpQaXfdWnT0=:y8V8FK+UtJq3wztlx/VtDA
 jj8iXXuPCb+8dqOo2iliOmpthow8uIC9XPEx+E+Himl+CVCdfdP1XhFgpZQvCtu2exravP8or
 6MTI68uzb3UdUxN9gvUwz+mhwnDO6ih/CmfwFrXai/oJu17MXNwf42utsidpvcP90ljXebSXj
 DhQW//YvpbMGAuQZ8qxvJrMnquZmnwqXr1Y94dSd990E+4jAc2dSskPqUlQRPnGfI4McpTsO5
 qxRwuXWTBi1V5hh2wf5yzXTQuJ6tt0JbcCX1uffctTx0OAef5XdIe+hwj8s/Rk5w8OKikGsz5
 stIb76l8Vs0y5M3Do8hwDlRaG098jIAXSISlgqy16Bq8VAiUsL5N0qxKj1zrafcPVHasSbz0v
 OKuI0sloaWE6j8LHdP8uRnNLqcPs7IXBQoYK4K+NZZe8s9ytFACuItItmR29D1uDZ/gqkcYTN
 aeHj26hLt1DR8xyDBwCpf3zGNxQLy+lzkROnt+X+EOu5zfjnu0Tzo3hJamuAZ1tPee+WO0Hy0
 J2nhenYRyhUGyYYKNYqJmDj55J95j3iA3/wx5FmcL4ZY3glim165FXHu+eVfp3AchjV2DJarg
 HppSTRquBBxSRFMKQDdiyezsWhmC4u3Eqbm4eJrC99vLBdRzTNgvldrqRlL8v68qv1cY2+e2S
 1HIIDUV9yQTqL0bju2M2H4TNqZHBzr7pGBofabq+IKg+rZMzmesVAaVBAuFfEYAxrKk2ItSG3
 3TzoCv5I/HJgEpHbXYmwj/4b5/P+D+Y16pBsUugZJjx6llQ+FyiRT6t6jxoVgTgp9a28v1t20
 gv/ag0HjpdgKqVxN733GTt6FFmAfYkBQ95nBqz4HywIUwP2DcfR0pwDTmR3z/S6eOjDtre1lC
 BEdEHyy85AO+1+gjiQnQ==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changing the switch() statement to symbolic constants made
the compiler (at least clang-9, did not check gcc) notice that
there is one enum value that is not handled here:

block/t10-pi.c:62:11: error: enumeration value 'T10_PI_TYPE0_PROTECTION' not handled in switch [-Werror,-Wswitch]

Add another case for the missing value and do nothing there
based on the assumption that the code was working correctly
already.

Fixes: 9b2061b1a262 ("block: use symbolic constants for t10_pi type")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/t10-pi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c0120a672f9..055fac923946 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -60,6 +60,8 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 		__be16 csum;
 
 		switch (type) {
+		case T10_PI_TYPE0_PROTECTION:
+			break;
 		case T10_PI_TYPE1_PROTECTION:
 		case T10_PI_TYPE2_PROTECTION:
 			if (pi->app_tag == T10_PI_APP_ESCAPE)
-- 
2.20.0

