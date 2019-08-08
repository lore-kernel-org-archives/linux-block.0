Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C1CC0650F
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4908D2184E
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDAKTHGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbfHHNLG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:11:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37404 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732645AbfHHNLG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 09:11:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so44078856pfa.4;
        Thu, 08 Aug 2019 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ghbafTZeER7tFVSxKR0FoUNjQNOkuIPxO4zFms6fLUg=;
        b=HDAKTHGLr1vPMQY+1M6UtNpZ4aeffhDs6Ljt9HwWSKX66NP7I8ulEYeU3JHSfA7U4z
         L/lmA+ZPFy8xEfhQY/9tgoRPhcm17M29Hl/cbelWsrzDEtrazQlmLSLHuphKSBes3abF
         5z2hjaD7/BicGKOen58Qi1gnUe69nFMu8mt0alEWPQX8TofJMEePz2LvW7hKz3UQUsfi
         KovTVAtUDnU/If8ePS/euYbFvhO9+A2GThccvjadlmLbouIyYRAgpgnvZTE6zrJSXhjg
         OhZtipnGYL6SJ5EDdw5Urtq4sD/HX8IOppoXkyXh8vlEEwzO6ZQCa2bv5r7x6b+C5sk/
         EcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ghbafTZeER7tFVSxKR0FoUNjQNOkuIPxO4zFms6fLUg=;
        b=UZO+PlRCgNq1Wm0LysUTfNBnEiYe8S2I8IgjmOG/C1OAEbsjGmGrAys5s+1oMOZdjr
         1ie3UnbCgQ1jPtoUw0QP26rrSz/05KZI/WlTM6KMXVJB4iRzVzL2rIfL4Ch0CtgJuqbm
         un2qhric10uJSlKuDMegy3BeIoLnu+KFbmehLTICDl5/YVGNfl2pgp7NYgIEv/1Nn5bj
         e0nofB93vUdNULn878ly0NsRWLSNHgFT+86BDhYje2UKhcnnxK4p7grfFGO4qckNxt1J
         xGD2h0Lif4aLg0ngO75DQxp77RH+I65Ek3WcPjE4M8+cspLqhyh6GmRAHM5BtcFB70gd
         MbQg==
X-Gm-Message-State: APjAAAUUj69VRgwREBjDr47235b5rIiktiAzaMjooqGm9XQ+MF50rzt5
        tYTTbSRfANr1rcIS8C8lWlk=
X-Google-Smtp-Source: APXvYqyXuh6uMII74oJqQCwpZfDp6HK/LdI9I13SlK2HkQifbdw6zcUTOtC0or/jJO1UDnoNYWLCLg==
X-Received: by 2002:a62:5252:: with SMTP id g79mr15208485pfb.18.1565269865807;
        Thu, 08 Aug 2019 06:11:05 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id p67sm118773185pfg.124.2019.08.08.06.11.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 06:11:05 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 3/3] xen/blkback: Use refcount_t for refcount
Date:   Thu,  8 Aug 2019 21:11:00 +0800
Message-Id: <20190808131100.24751-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reference counters are preferred to use refcount_t instead of
atomic_t.
This is because the implementation of refcount_t can prevent
overflows and detect possible use-after-free.
So convert atomic_t ref counters to refcount_t.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/block/xen-blkback/common.h | 7 ++++---
 drivers/block/xen-blkback/xenbus.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1d3002d773f7..9db5f3586fb4 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -35,6 +35,7 @@
 #include <linux/wait.h>
 #include <linux/io.h>
 #include <linux/rbtree.h>
+#include <linux/refcount.h>
 #include <asm/setup.h>
 #include <asm/pgalloc.h>
 #include <asm/hypervisor.h>
@@ -309,7 +310,7 @@ struct xen_blkif {
 	struct xen_vbd		vbd;
 	/* Back pointer to the backend_info. */
 	struct backend_info	*be;
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 	/* for barrier (drain) requests */
 	struct completion	drain_complete;
 	atomic_t		drain;
@@ -362,10 +363,10 @@ struct pending_req {
 			 (_v)->bdev->bd_part->nr_sects : \
 			  get_capacity((_v)->bdev->bd_disk))
 
-#define xen_blkif_get(_b) (atomic_inc(&(_b)->refcnt))
+#define xen_blkif_get(_b) (refcount_inc(&(_b)->refcnt))
 #define xen_blkif_put(_b)				\
 	do {						\
-		if (atomic_dec_and_test(&(_b)->refcnt))	\
+		if (refcount_dec_and_test(&(_b)->refcnt))	\
 			schedule_work(&(_b)->free_work);\
 	} while (0)
 
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 3ac6a5d18071..ecc5f9c5bf3f 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -169,7 +169,7 @@ static struct xen_blkif *xen_blkif_alloc(domid_t domid)
 		return ERR_PTR(-ENOMEM);
 
 	blkif->domid = domid;
-	atomic_set(&blkif->refcnt, 1);
+	refcount_set(&blkif->refcnt, 1);
 	init_completion(&blkif->drain_complete);
 	INIT_WORK(&blkif->free_work, xen_blkif_deferred_free);
 
-- 
2.20.1

