Return-Path: <SRS0=4yxV=O7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EB0C43387
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 16:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA5A219FC
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 16:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeLVQyg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:54:36 -0500
Received: from mout.gmx.net ([212.227.17.20]:54221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbeLVQyg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Dec 2018 11:54:36 -0500
Received: from localhost.localdomain ([116.30.194.149]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LpwZn-1h4Ebk2jCB-00flgo; Sat, 22 Dec 2018 13:47:24 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: loop: remvoe redundant code
Date:   Sat, 22 Dec 2018 20:47:15 +0800
Message-Id: <20181222124715.29051-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:xFNEeEXKssKrcdcl2IVKFcm9hoVDkh/RghvYDX7CWaL2fIDcrO/
 1sTd/KG+hNEviu7ykeSvmesSR+2qwPJyqSkH8VNbbVyUjNB+q0qyE/b7DvxpgvT/333htV/
 ZmyF/4mycN9vi/3VIar+Dph84TUWuZ45EfTW1FZ28/fZdr6zqV89SLR4sjnANx/yW4ZlK/P
 59gs7C5Xq95LkWVSJraLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BrSANh5ronE=:RFb1cwllVCDxsWq5EyUbrv
 RzGpB/3L4ccitE1njccvlnc7ACDhE/VvFHp5gbErxAhIo/hlXjwLDBKAjRMs7y8klQReNy82w
 uArfj1KXTdx2/7O+ZuDa5thmTzt/heVDQrG5Q94DJFHkPQkS7xP5YCxIrVW44yg0V3nH+pC9C
 glKnniOOdGdU0HwrmQXHCiP7xAkVPj+OrBuVB/l2lNgi9kF/Zbbt/gPZwhAp3aTDFFkiqPNl8
 LEdwRyj71wmNGJSLexDKLVtjt+O+qa7PDW67+h1KCo5NSxCa8QCsX4+x7aJ1WVc2rYFoYfiZB
 GPFx8yNDyclNkAbft93MWcLxvGUV7NpuBz+yFcILBOIHqhVTNMq1FQgwxi6r8L9xYQ36pQSOQ
 K94pqSTU9sU32WNi/NfH9eUBEzGFAL7zyBlMHeqFlY7jp9KgJZfaDTZ9/5SyWAuNrQas3ZOQ1
 hudV//s2YpuGiXTECORLC7t+1sBpKLhDaAQnwI3GwNWaE0jtIHGq/XzC9LdYjBbMRzcuhX1DG
 EO7CpFTZVG8CBJIt1AJ2jEjJn0l3UT4squjmJJEbOtf7lLrzHRZXvh6i6d6yD3es+bhyi/tmd
 RZ2Yc+p8soQOyp3b+kmUwIRbSg5nhvpplifgtcqcatWAMnzNr+4MBk4c7o8vK+a1DJBxLABlJ
 k40LVUzZ2mmliDuVlE24nJV1XuAcF0nh0RfyU5OtWNkv0KFkeS9SxuLJ86CrnudrLhk1gH1OL
 iVd9c1dRpIyJjM++Wrchyq6wf08zdm1DQTWyh8z70c/gjeDLa8cap/pRdjSDdS3sndF8EMrDj
 lggpekH+nj7PGCKksujmsLC+wjmZd1/0nkVUSRJ0xaG0qHjzvVjCQgHNG1sl1GdU7/Aj7TxX8
 CCxM2eda4EyJHfjsBQJRzXWMEjm/KpSBTyIuWc+nc=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Code cleanup for removing redundant break in switch case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 drivers/block/loop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cb0cc8685076..4e1d8aa6e1e9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -615,7 +615,6 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	default:
 		WARN_ON_ONCE(1);
 		return -EIO;
-		break;
 	}
 }
 
-- 
2.17.2

