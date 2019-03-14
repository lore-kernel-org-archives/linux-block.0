Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E675C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 08:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FB021872
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 08:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaxSro7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfCNI2v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:28:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36479 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfCNI2v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 04:28:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id n22so3346501pfa.3;
        Thu, 14 Mar 2019 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+FO0Ge5x2R+otL95bBriY+e3z2BrwSY1bxTvsVVnwo=;
        b=DaxSro7G2utPJRtoA014+s6MMe1CIM2L7Tv+hSbLnfPryawAol6n2QuguzhVCUzbVO
         Q7kPtgtNId0BMdjbdGtgOkyX63RY8O5ZRWZJObBEsoU3J9N6hRJg5NmE4IgkSu/4Mw5w
         tXIl+tyQzxgLNYd9cEBp6lDGrHlqexiCVT+zUkSxBeqM7zlZijOz45x4PGBxozXjarcb
         z6xevAmLIBpmRp14y7Fc6dpq+g5VnINLtwBckL5p+w4fNwq/tS3F2dj17EptHiL4ZhjG
         nof4auJN7x8b1uJwQXYtJ+s7G0LHp8Goj8/Fb1Qx7UsQFGnVbWukbtBcPnnJbcKr4O17
         zYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+FO0Ge5x2R+otL95bBriY+e3z2BrwSY1bxTvsVVnwo=;
        b=kbdBQ8gGLewlajTsGDkGAMXmRY51DByOFKmrFVIpNOEgdlPGMQtEpMQ/x2dcLjYDw3
         O6KAGZmONwHn73lmcK8F7ntqHmVgo1CivyPiNo9k2/FvgXYCjFy3xQZ06E4tPovZMtwv
         15uVY5vaw1ryI/7B3DZMpJESzqbVN42OvbnGjmkRGcrJPfc6d8Cl7V+q5wAKIW29QOS8
         dKQaj+4tNDfqyMjhR/XMBXlg02eEI2mRVQCST8z+2ztNBVeSP7YsgAM2lk0uux0mq8dg
         LwwyJayXBxYygV9gyyFXbHGF8RviLFEzDLhv53T1AAam+a+1aXUvdhdwEUh4KqD5s2xK
         dg+w==
X-Gm-Message-State: APjAAAVGWSxD1MY4LS9xs+CQV1eSI/bjudvj5U1rclV6fnftvjeuHltm
        htD0x85Lonh9E1rk74lM3VY=
X-Google-Smtp-Source: APXvYqxYd/TA16EBmfT9nnV8MByf55XUP4NQ11MKp3Rfjo697utVklLvIsJaGOf4D7fJln6SPc9OkA==
X-Received: by 2002:a63:cc43:: with SMTP id q3mr44497290pgi.387.1552552130354;
        Thu, 14 Mar 2019 01:28:50 -0700 (PDT)
Received: from localhost.localdomain ([175.223.23.218])
        by smtp.gmail.com with ESMTPSA id a2sm18655957pgq.89.2019.03.14.01.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 01:28:49 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Ed Cashin <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] aoe: do not use __constant_cpu_to_be16
Date:   Thu, 14 Mar 2019 17:28:42 +0900
Message-Id: <20190314082842.21965-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A trivial patch.

cpu_to_be16() is capable enough to detect __builtin_constant_p()
and to use an appropriate compile time ___constant_swahbXX()
function.

So we can use cpu_to_be16() instead of __constant_cpu_to_be16().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/block/aoe/aoecmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 3cf9bc5d8d95..bc5bdef65868 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -132,7 +132,7 @@ aoehdr_atainit(struct aoedev *d, struct aoetgt *t, struct aoe_hdr *h)
 
 	memcpy(h->src, t->ifp->nd->dev_addr, sizeof h->src);
 	memcpy(h->dst, t->addr, sizeof h->dst);
-	h->type = __constant_cpu_to_be16(ETH_P_AOE);
+	h->type = cpu_to_be16(ETH_P_AOE);
 	h->verfl = AOE_HVER;
 	h->major = cpu_to_be16(d->aoemajor);
 	h->minor = d->aoeminor;
@@ -436,7 +436,7 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff_head *qu
 
 		memset(h->dst, 0xff, sizeof h->dst);
 		memcpy(h->src, ifp->dev_addr, sizeof h->src);
-		h->type = __constant_cpu_to_be16(ETH_P_AOE);
+		h->type = cpu_to_be16(ETH_P_AOE);
 		h->verfl = AOE_HVER;
 		h->major = cpu_to_be16(aoemajor);
 		h->minor = aoeminor;
-- 
2.21.0

