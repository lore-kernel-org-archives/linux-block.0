Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5886DC2BBCD
	for <linux-block@archiver.kernel.org>; Sun, 20 Dec 2020 16:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA8723A9D
	for <linux-block@archiver.kernel.org>; Sun, 20 Dec 2020 16:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgLTQrt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Dec 2020 11:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgLTQrs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Dec 2020 11:47:48 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4490EC061282;
        Sun, 20 Dec 2020 08:47:06 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v29so4852120pgk.12;
        Sun, 20 Dec 2020 08:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3GGwcqj5QcILd/o4zZQ2OFy6KS5ZUG4l14PNl55Tprs=;
        b=oSCmzqV69zAMP1/pKLOrLgQE4KYhHzfyRoe/HeFolWkAjXYZiWCsKs04JdDyyF5+2N
         9gnYS1IzSbWUT6nceIrNj7YeK+TeKnxPN6QpR7ejDi4Qs2nVxmFwA63EGE8pwvSNNEuR
         n9RpUuBdhQw2zvQAn9TQkLqy9W8IndPUk/UBvv9h0OUVQgFgP9E2X8vZb93BWbj1evl2
         0okyreoBSiLJbidNQqJiFV1mpfbQ2viLFo9uUmKa3BWVTK7u2Z4RDu2rCr7l0S9RkgG9
         k92Hf+KAJ1Z915GnkVAcf8LrDV0EOjaAomYsSdsz+POjnOC7sFGbposlrlvwtoPS6EMb
         sCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3GGwcqj5QcILd/o4zZQ2OFy6KS5ZUG4l14PNl55Tprs=;
        b=oy4fqRNuvOAr/fFi3Anf1ZHRaFoNK3cbiwCMuyxFR9efnZW7pxRin5nf0zV2QoF9Ce
         cgfy8LOWYSjEjDZiWO9IpeZ+/q4kUM9dbDvOR2p0iHi8yjcjvKGqPzsbsreT3QTbNjdg
         67CLLMufHeMWXuPYGmsZ6q2nMUMSPvBRagcXrJti8w8qudh9ta+ev4PSmbC5nrYNMRsc
         HcRohrHOKCSCI/XouXYQPsv0N7btKocdOH/zRBJwF1hg0Z1C90V1ew/Br859QGK6kCql
         cW/glXBUkdm3jJpyCyIx/g4WEAEltiPXFdALTES+AnVpKu26RXbYeADwZjtIygWc+daF
         xUJg==
X-Gm-Message-State: AOAM531QEH0BMchSK2/VoVW9EyllR2/gWIrNbdRgRQLpb9XweBc3sYyI
        RHlF5USCKtMtGaYj5Mso43AxDibGEd0P2Q==
X-Google-Smtp-Source: ABdhPJxlNREJvZUznnH4W081+kh22BPYoFhgcylego25mbEk1tDClbAHM/SobAZpcBsxprer5OLqww==
X-Received: by 2002:a63:131a:: with SMTP id i26mr12129440pgl.232.1608482825985;
        Sun, 20 Dec 2020 08:47:05 -0800 (PST)
Received: from localhost.localdomain ([103.248.31.152])
        by smtp.googlemail.com with ESMTPSA id q23sm14715473pfg.18.2020.12.20.08.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 08:47:05 -0800 (PST)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     justin@coraid.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH] block: aoe: replace use of __constant_htons to htons
Date:   Sun, 20 Dec 2020 22:16:25 +0530
Message-Id: <20201220164625.94105-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The macro htons expands to __swab16 which has special
case for constants in little endian case. In big
endian case both __constant_htons and htons macros
expand to the same code. So, replace __constant_htons
with htons to get rid of the definition of __constant_htons
completely.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/block/aoe/aoecmd.c | 2 +-
 drivers/block/aoe/aoenet.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 313f0b946fe2..7a5374a57b55 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -69,7 +69,7 @@ new_skb(ulong len)
 		skb_reserve(skb, MAX_HEADER);
 		skb_reset_mac_header(skb);
 		skb_reset_network_header(skb);
-		skb->protocol = __constant_htons(ETH_P_AOE);
+		skb->protocol = htons(ETH_P_AOE);
 		skb_checksum_none_assert(skb);
 	}
 	return skb;
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 63773a90581d..2532e35774e0 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -192,7 +192,7 @@ aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt,
 }

 static struct packet_type aoe_pt __read_mostly = {
-	.type = __constant_htons(ETH_P_AOE),
+	.type = htons(ETH_P_AOE),
 	.func = aoenet_rcv,
 };

@@ -220,4 +220,3 @@ aoenet_exit(void)
 	skb_queue_purge(&skbtxq);
 	dev_remove_pack(&aoe_pt);
 }
-
--
2.29.2
