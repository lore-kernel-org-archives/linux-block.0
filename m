Return-Path: <SRS0=4yxV=O7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1176DC43387
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 16:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C9D219FC
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 16:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbeLVQzD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:55:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:57951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732523AbeLVQzD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Dec 2018 11:55:03 -0500
Received: from localhost.localdomain ([116.30.194.149]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MAPoQ-1ggi380GvS-00BZX9; Sat, 22 Dec 2018 13:48:08 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: sunvdc: remvoe redundant code
Date:   Sat, 22 Dec 2018 20:47:56 +0800
Message-Id: <20181222124756.29623-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:n9lQvgm6Q2DIroqpc397YSvTd4xtJiETeaLyyZ8BC6l7qz32eNZ
 yIC9l2tFAHXI89xNCqDYXVVqe2Oa3XysV68UB6cHRT4y8QJnuSQQn9uSYjtTz3qboElL6/d
 DO8fPG4BNdse3kXgEA/5rK1dDWh1NxBez3BMTiozJgSJt4HwpGjPq0NAENu6n+GZyGdzFc3
 E4+padCcX0QDXMX8ddBGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eT41JJ6sM7E=:KOgnxpPyaXz+wWvZkhZN2J
 6eKjOQX4S6rklqODa67Llzp6Fn/Ud184SiwL41UF5Eu7hYqDWuecmhNt0Ey/fWxO9ZZvlAMZ/
 +qTSa+dey9Z84TZYDTJC9jLhSgTa6yuHwF5qSZ1KdupgHr6F7vatyPvvVeO9MqAV073VFInQ3
 xoHKCfquDuXNmal3x/2wnC261JbpS535KVOi82ZWB+ODGkx6DrPS2RJULyXzu7tbZuiX2rQzq
 K2FqJVbHCHnePswTQh5D3lqLh59iSK7IdjmaQ6ck+GTIgww6ajbWjhkEr+dKk63aMzqHP8TwJ
 h3bnAnSyvFT3cbpK2r9zH4inxylzqAiizdObzhWi4q9jwveuaEQOCJgsXPr6uHprR/qIThPYs
 cIOBmIembNwZwYEh4rZYFr4A/2+0HCUqXz6tpBXeKY06oakn7how+8VIT6FWJntpcZA03kDIZ
 8+MNa/w50O3maus6aCPzSm83laWN2AvurY3GvBx4BlCEharvAUJGjeQqA2W0jrG4aLBmOYc9Z
 Z5AHGl7OWztGiw8J2o1s8bokeP8C5RMYuKAJmThm2H0GY3rR85XBNx3iUXGpF1KyS9prDqXzA
 /bJ2eVxhH/DDWrsIaMCnfAUl6BeAA5D6pScl2jnec4WYialFMktI4zF7pqxZak1k5DQKRK2mo
 av4dE+hYZTwVSYWTpFtXGZ7OtiuBpsPQOivt/asu7rsl+PuPZ3rmkRRhauRkpwJYNMhKEBjL2
 9fxnPdec0oXV1JSKJf7E2A95MIgpEtl1fV556yBNzdj8HjDp3oEBAzsuqp+PGBbB67nTKqzhA
 JN6yrTA/a8QPUlC8bNGsLSZGRFQqfFO3DsTnxDXyimJSmGcl+yntIRxra5a95dCffNZ7mXKwC
 qvCYSB6pONcAV7wiLHlFOp5VRx7FEW5608dgMm+Mc=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Code cleanup for removing redundant break in switch case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 drivers/block/sunvdc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index b54fa6726303..c8f3e569296a 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -617,7 +617,6 @@ static int generic_request(struct vdc_port *port, u8 op, void *buf, int len)
 	case VD_OP_GET_EFI:
 	case VD_OP_SET_EFI:
 		return -EOPNOTSUPP;
-		break;
 	};
 
 	map_perm |= LDC_MAP_SHADOW | LDC_MAP_DIRECT | LDC_MAP_IO;
-- 
2.17.2

