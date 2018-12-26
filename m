Return-Path: <SRS0=oKFV=PD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3145C43387
	for <linux-block@archiver.kernel.org>; Wed, 26 Dec 2018 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990C6218EA
	for <linux-block@archiver.kernel.org>; Wed, 26 Dec 2018 14:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeLZOgN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Dec 2018 09:36:13 -0500
Received: from mout.gmx.net ([212.227.15.15]:55581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbeLZOgN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Dec 2018 09:36:13 -0500
Received: from localhost.localdomain ([116.30.192.185]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MRGTX-1gnYXs0vZH-00UacR; Wed, 26 Dec 2018 15:36:11 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: fix a typo in description of ioprio
Date:   Wed, 26 Dec 2018 22:36:00 +0800
Message-Id: <20181226143600.21923-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:lTUZnEsqGzhCYFCyDVrNsGlKpULwRts/+q4Oi9al8ItuoKYjAbM
 tD45kgEUo/6aVLVVoaf5rwE6S8tVkZeO06jqzAHOiUYI8dNctwssHLVOh4+fkRwjGFLDtwb
 5hRPydavhZDzSEEcVFawV/oGaXMLmkIWcj7IN4mWCCjQrdQRWkN4svoQDcClVilBvhuS7dX
 3Bu/q9E5Vzq0MJ+ZwIKrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Tdl0lRlImE=:id9LqXrVdOfDErds65csEp
 K8VV47QGX7Nc9DM/qRfnNygj0D65xpATjYVpV/2apJCPfou52v4v1O7A19uHX+Jyf27NF76Qa
 hde0hGGBmYaajjxYnX8k9/sBWrYjaW3l6IqPLn6/BbbMEVvovyqfeU8uO5FEEB++h8CPT3E5M
 dLFaoA/YQccoWg9gGHVC4+WRo6bZul7QiUBXy87kJ5l4ybPpdom7UVzjcEM6X0asTFKA7mlAq
 +0uawJHt6B4ZSe6Bj8dmt9SG17Qa0q3zzwLYqTBa2vsPCJqSLsa7Xzto+0i3gNt4e0ME0QTT/
 s0DmGYxWur4MYr0DN9r8mDH5ajqmywYsdVvTbJP7Tw5k+Ozj3GuUMCcBMxxDP5mt8gZgWeCYO
 +nNw//ohygCEvJMgjVL4GqvAj1maeFf8bnAFCbVIlMWG2DbicY/0cOndm96wVPgFVrl5HUAnt
 LX0zYQ0G3fGZM3XL2WgnfFpnFXncfhM6gnhkmEsUX7XwhtKre6bIgH2MrlhaZcMQZyAHNgteN
 DjDq9AFf4vm6qTyK4stj3AYyT6ebv/h3aEZC5y+PlaAiZB+/b8j4/1gc+kkpfW2ODTCeW5XyB
 PalI0q9kpsJZsh9noSuEr6Ngk1I7YetjRmOcE2Vn/3ZQJQ9HbhdmDvQfuCEe/rwoUVXUG0SEm
 TI1gAF6I8s90+Y4f+cf8RfLlJixZ+20DhtPXaHciDsq7diIr3KmvAssWuBGsvW0weCmdo+o45
 z5/kk4xHXSSu1/UQ5p4I4Tji3QN54aNc5wE2qjktfTnad2Slf/KmMHPYZh6CcARH3RcvsYCAW
 1aFdZ2z1elcUhgliJWPApCZXWT3Fe6x6dtY6ev08DHmftgy2x7Ulq/ZV0+Jr163yPx/Oi7YNX
 iRcsy/mZfE0L0ljqONXhdbW9s+0sfwjxt87YjkpQI=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just fix a typo in description of ioprio.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/ioprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index f9821080c92c..8c0f971015c9 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2004 Jens Axboe <axboe@kernel.dk>
  *
  * Helper functions for setting/querying io priorities of processes. The
- * system calls closely mimmick getpriority/setpriority, see the man page for
+ * system calls closely mimic getpriority/setpriority, see the man page for
  * those. The prio argument is a composite of prio class and prio data, where
  * the data argument has meaning within that class. The standard scheduling
  * classes have 8 distinct prio levels, with 0 being the highest prio and 7
-- 
2.17.2

