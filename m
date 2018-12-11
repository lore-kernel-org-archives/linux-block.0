Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572F0C67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218C72087F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="q+Olj5kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218C72087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbeLKTRH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:07 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:34356 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeLKTRH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:07 -0500
Received: by mail-lf1-f46.google.com with SMTP id p6so11656253lfc.1
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQ124e7M0okPx5I+QhLHPxJc1tUUmdIdflct8erdRes=;
        b=q+Olj5kvTE4ByeL30fchZHkXLJ2PTZE+WB+OrJFgxnSQzEAMQFWo+0TU/ZC99Z8oWq
         idd/rlOM0uewK1snwCEn3Uj8+D0l7ZP4/2RlN0ukxIGMP8wDKpl1ktlsUCvNABcFibY7
         Kc2ffqeSgFP/WlBAhlmMphkwi/Nnk4aITAOSvvwTN6ozypoILIa54tM43Xbn9UQonN25
         K1yLp+MFjS4XPhG5PUaloTsbn6fvOFzXR1X2np5yG0O1UHzvERgCHYoKdQSANXnr2Mmo
         S1nCEIlm4NippRNTb1MAIE+3+r5gnSDCL42TJj+PNKdd7izC5bIKfFER1Eoi2psWmop1
         0kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQ124e7M0okPx5I+QhLHPxJc1tUUmdIdflct8erdRes=;
        b=BSaEeLBDFaU2vV4Cz8qrfA7n7s/VAfZ6lnmrGJv7BIdXz9BNiNJDJ95sGwsA4mkWCD
         wsfo0hDcW3vTjxpPCbrf28RHp8FB2pyqgVuDAo0Fdh8IVIXutEpodI3i09Bl2pudfV1O
         9w6cpqvbdgKZ77dBT9vfZnjp+tKIA0dee6vcG9UYLjdnKczouWMY5ghT1tnM8ZolbzIB
         2CxkCXykI6Kd9jGyf57+civggUddVoZerxSMNIPpJz3d3nTpJpFQmrNBGgXUt0HT0TSD
         zx7jf7I6G2i435xAxhe6/AjFH8WRTM5XXanVsKm87UsK0tNuizJaq7LduUqXGPlw7Hrl
         ygbQ==
X-Gm-Message-State: AA+aEWac72Pkmt9YjEBS0AUHaoJhR34x1jG82b1wgQMLWlRie+iiSTL/
        CJjTkDCzEJEVhJfkJP/IRy7vD/bCYDQ=
X-Google-Smtp-Source: AFSGD/X/JXvteVlP10+SWJfpPcxlmAkbHu+WnrggffruESNsqI/uZxjquLRCVXTE58u0eWIa1ZX6Dw==
X-Received: by 2002:a19:f89:: with SMTP id 9mr9853449lfp.10.1544555824238;
        Tue, 11 Dec 2018 11:17:04 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:03 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 04/21] lightnvm: pblk: fix resubmission of overwritten write err lbas
Date:   Tue, 11 Dec 2018 20:16:10 +0100
Message-Id: <20181211191627.15542-5-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Make sure we only look up valid lba addresses on the resubmission path.

If an lba is invalidated in the write buffer, that sector will be
submitted to disk (as it is already mapped to a ppa), and that write
might fail, resulting in a crash when trying to look up the lba in the
mapping table (as the lba is marked as invalid).

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index fa8726493b39..3ddd16f47106 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -148,9 +148,11 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		w_ctx = &entry->w_ctx;
 
 		/* Check if the lba has been overwritten */
-		ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
-		if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
-			w_ctx->lba = ADDR_EMPTY;
+		if (w_ctx->lba != ADDR_EMPTY) {
+			ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
+			if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
+				w_ctx->lba = ADDR_EMPTY;
+		}
 
 		/* Mark up the entry as submittable again */
 		flags = READ_ONCE(w_ctx->flags);
-- 
2.17.1

