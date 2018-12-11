Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A205C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230A620880
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="vM938xQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230A620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeLKTRg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37784 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeLKTR3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so14040116lja.4
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvwDy0B0eo5bm6LRb1HjRis5IhBlsMJInML918QqRcI=;
        b=vM938xQL7ND4aTGOdQfsGOLI74Bmt+xRgpD/LmfzRFOIWxMKFi8Nwx1GgOu4yS7UHM
         yu3QdfzqkeSBIa08QhLDnXPK+889Q8j0qu73A3K5zXjwhXkoJlcT5x0lHj12fWB0smdE
         nRQp2djUoylvLvOUZ9Bq5ZZgC4bRyvcd3rfS+cvZneAWyWPJmMzseOf1h1QzS+eRPd2M
         lHUdKfODEReYQYktbriLJEQY5yzo/nQuJ/9RT5krzH5ONs9kbMzomcZxV1EC9Ijc1QD6
         U+p0LZgaBjH4YBuOnjx2vnYqS5fkptC/8snckZ/pFxCwgI5T3K+35Ywrz5dYxvHmmBad
         q3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvwDy0B0eo5bm6LRb1HjRis5IhBlsMJInML918QqRcI=;
        b=DzTtUsFThde1FhxzG/iaJZTnKgp2xSqKDXY13ZlAD57uHeRA7E+JAdSAjvyRJj9tPP
         kwLjqfoO83uxZz2CAoKHvuGL325gbTN8PzxvYuPfxfKvDQFV8NKGgOIQMnmAE1e+7Lsy
         +5nP+Nh2qw6aUE73j9UVaQr32DTUjhAwETEynRxjl2NHnHivSYOzmfACGJpRbd1hvybE
         SlZUCHnkD+11/8l6d9x4DligqNsvm4GFdxXj1MsMJF13Po3ml3d0D4TEkGy/G3rQ8G5z
         CXlVMCB/KuvYAtXS+CL88EEzP8FwhFXptkP6bxY4Jbib37ctiW1PxD9PwnN0g8VJhNTq
         OGtw==
X-Gm-Message-State: AA+aEWZjrFN9O+9VBIchLX0Qc+eujrj8k/I3s8lQnr4k4pWMDHIphHIw
        Y/wlxENnZBaD6DYHdjYu5I6fEg==
X-Google-Smtp-Source: AFSGD/X2FZZSird9B30Rmu6F4xIUeCKcjjHIR1xy85BHr0k2QDIAxSgUKJa+uwol1MgbawPjoFSVeQ==
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr10526948lja.58.1544555846450;
        Tue, 11 Dec 2018 11:17:26 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:25 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 21/21] lightnvm: pblk: do not overwrite ppa list with meta list
Date:   Tue, 11 Dec 2018 20:16:27 +0100
Message-Id: <20181211191627.15542-22-mb@lightnvm.io>
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

From: Igor Konopko <igor.j.konopko@intel.com>

Ehen using pblk with 0 sized metadata both ppa list and meta list
points to the same memory since pblk_dma_meta_size() returns 0 in
that case.

This patch fix that issue by ensuring that pblk_dma_meta_size()
always returns space equal to sizeof(struct pblk_sec_meta) and thus
ppa list and meta list points to different memory address.

Even that in that case drive does not really care about meta_list
pointer, this is the easiest way to fix that issue without introducing
changes in many places in the code just for 0 sized metadata case.

The same approach needs to be also done for pblk_get_sec_meta()
since we also cannot point to the same memory address in meta buffer
when we are using it for pblk recovery process

Reported-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Tested-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index bc40b1381ff6..85e38ed62f85 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1388,12 +1388,15 @@ static inline unsigned int pblk_get_min_chks(struct pblk *pblk)
 static inline struct pblk_sec_meta *pblk_get_meta(struct pblk *pblk,
 							 void *meta, int index)
 {
-	return meta + pblk->oob_meta_size * index;
+	return meta +
+	       max_t(int, sizeof(struct pblk_sec_meta), pblk->oob_meta_size)
+	       * index;
 }
 
 static inline int pblk_dma_meta_size(struct pblk *pblk)
 {
-	return pblk->oob_meta_size * NVM_MAX_VLBA;
+	return max_t(int, sizeof(struct pblk_sec_meta), pblk->oob_meta_size)
+	       * NVM_MAX_VLBA;
 }
 
 static inline int pblk_is_oob_meta_supported(struct pblk *pblk)
-- 
2.17.1

