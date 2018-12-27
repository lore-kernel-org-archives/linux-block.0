Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E78C43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 00:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB27208E4
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 00:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeL0AT2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Dec 2018 19:19:28 -0500
Received: from mout.gmx.net ([212.227.17.20]:41297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbeL0AT2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Dec 2018 19:19:28 -0500
Received: from localhost.localdomain ([116.30.192.185]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0M4Wwq-1hYnCb1ksO-00yiNA; Thu, 27 Dec 2018 01:19:26 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: add prio data check for IOPRIO_CLASS_IDLE
Date:   Thu, 27 Dec 2018 08:19:10 +0800
Message-Id: <20181227001910.3343-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:JThDEjnOgXHf6KdnL/T3Xw0U9KAfODddczp7kW/JqCX9FCw4Zz8
 qWio5h69bDB6cMaCOTOrWNdSS8kSsC2W7HX3aawrmInMGrAWcCJ7ygU8c++hSErVkivHpTX
 fxJ19hPSz0EF/Oe3OeG3TU2xjLJZxHp2jA4aywtnJiQSAaCRBTWfB+6cn5AVZKpDkyGpfCQ
 gY6S2zUBgi+5cLG9NXxYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ZH4BwxDMMw=:cGESbTdZCJittE9GgKEruN
 Cljk4E3XDABPJ7FgcbCUZ+/UtRsHblmXr3fk33hKcKnNMr3WR6fFUk9o5wwVmDid9o5IYP4Jn
 /AZCSBhwSQnU+LZDLX1TIKR1IrPF1qsi3hCLO0Um/foJ4xcnVlMXemwDrPgnmEqejhU+6VI5o
 FZQlMLEWMCH47lHASSWoY/iNLuoZjuwgsEpgQiOKT9rRCrjkCoCoQ0f0YbxdgMjym72D2+lCK
 9l+StxYt7nW5hsX0l3ZsR5XxjQsYPR4a4k4t5/9KdYGGxut6n7akXS6Wc6wMB3k8uuEnvT4PE
 zNZJ8MyZq0dm0MkII2CpZR7L6O6RLtFt5WrJ8co7/FfmXgStmGp6nlvApH//TDQhm0gRpAJy1
 9ILOyhSkFKfmRk/Y6dyprQ0bn3kP1nYLZ3bwA3oFNrE4evLESJDFBZ5r7gBZQVNm7LREnykJT
 UmbkOPO+cUZ6SJPmndQglqgIF1+q8sKGQPajS7LTgUebgXNIpxTJPRqefa2HAUe2dGAXS281O
 t/Pte9Fl7oQUwjIVA9qaLpIlpgD6aQfnlemnHw0MLQf1y9XRUDJi3MhjEyWuMsed9Js+ZLzHM
 L0NYiMsSnddCMnOCcG8HxCLjn6Nte9qRq5lBuc4Rgyq6jGQEulvfl+nffTws0tgyQevMSYGdR
 YieiwqrnMjZ2LqlejVceIoWI/Gj0nIjcAzaHSNT8R2iuuFfk5Ee5foPE6rOLRxo8Np3/zTqSv
 u0Mbo4+0Ic1KpDBDNqU+iAwaV/cVgDm6KyspnCBCWw/gpFRkGPzlTKLwcyGOud2jhPK0QLasX
 WBTHMOZYvBJnFkQwAphoqrlX7eHKKASnD2LJjKXLIR8JlH62zVSoY+pcblp80Lr7SXp/v/edp
 MKgqauBI4AxA/GHH3n3ezkvMhMoLDqhz7OYg80DfQ=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The idle class does not have class data, so let's
fall through to case IOPRIO_CLASS_NONE to check
the specification of data field.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/ioprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 8c0f971015c9..63db916f86fb 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -78,7 +78,7 @@ int ioprio_check_cap(int ioprio)
 
 			break;
 		case IOPRIO_CLASS_IDLE:
-			break;
+			/* fall through */
 		case IOPRIO_CLASS_NONE:
 			if (data)
 				return -EINVAL;
-- 
2.17.2

