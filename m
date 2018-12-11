Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E05C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1262087F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="iOk4yw4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1262087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeLKTS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:18:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46452 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeLKTRE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so13992650ljh.13
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHnAI6INNpfEyeoVrs4hGgZP5NaC4/R4lNfx3MHbEtg=;
        b=iOk4yw4GWJBIdDmIg6btixhc/royuqRtuMz1DggZ82XcXGZV+Xj+oWkCnURBzyKqOO
         tjTRNdNWF8THoDdALsqaEEfkU/fhv0xVpUT6XUvOzAqhVJkTl4u5f45iaN/ZNcMSvL7l
         vLpZ89PwNpzE9KAiNJtUNCLMV/xGyv8r0XkqnWxxEYL7nXf5GMWzmnoYcY2U9HbcsUb+
         F3vmxLcYr37ddYtmGzuk42pc9CZP/o4rEg9wFpi4QiabKe525dbfBUfwrNxbtI1KwYnB
         v0ZO/PHuuIuCI/0qQscuEnzLwUveCOXa7OPzgJl3cPo+3nxsy9zGCUD/sSaj4uAfUFNC
         txKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHnAI6INNpfEyeoVrs4hGgZP5NaC4/R4lNfx3MHbEtg=;
        b=HCRQc9W91CVnLjq4E9J+XT6WjM4sZBcKjMDtJeCgmgbEib7n3vMdYhkhxBcNYCX/Ms
         fIGVublvoSrkY1HYe1berJfb3hH6HqnUStLwbczACUj63MiPFlNdy+vKNNEQ/1fR0Xvk
         E7P2a6SOm0cAw3vB8DSXwbhBC+6xSp+IhJQH6RNm8u3Ve7HWhoDjtghetsMHDt6F9s1X
         39+sR/DZdy1CiAnNOfPRdeg02FjdHgNUucxgL9Gfalgj5wp+5fyZKAL3jhOBceOldHpx
         uGQHoXROD8+oDWMel/WHEL5WFX6x3kL2bAUOzbtk91l9JXu6lQ9ftylN9N/NaMIfVUvl
         3Ymw==
X-Gm-Message-State: AA+aEWZ9Mfe2INJSsDXFrhIEzK2F2pwgl9KyLdWSxliV63yDlKim3ryw
        9mWrRu6R+iwA0VKhwAbo+Ej+dA==
X-Google-Smtp-Source: AFSGD/UQ1PMhMoNRwjuZb8wv1xRZROqMX6+ALeQZ928+6fgXZVxIIQqjwjqmnngPlI/m2PNFaj9OFg==
X-Received: by 2002:a2e:82d7:: with SMTP id n23-v6mr9194727ljh.143.1544555821617;
        Tue, 11 Dec 2018 11:17:01 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:00 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 02/21] lightnvm: Fix uninitialized return value in nvm_get_chunk_meta()
Date:   Tue, 11 Dec 2018 20:16:08 +0100
Message-Id: <20181211191627.15542-3-mb@lightnvm.io>
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

From: Geert Uytterhoeven <geert@linux-m68k.org>

With gcc 4.1:

    drivers/lightnvm/core.c: In function ‘nvm_get_bb_meta’:
    drivers/lightnvm/core.c:977: warning: ‘ret’ may be used uninitialized in this function

and

    drivers/nvme/host/lightnvm.c: In function ‘nvme_nvm_get_chk_meta’:
    drivers/nvme/host/lightnvm.c:580: warning: ‘ret’ may be used uninitialized in this function

Indeed, if (for the former) the number of channels or LUNs is zero, or
(for both) the passed number of chunks is zero, ret will be returned
uninitialized.

Fix this by preinitializing ret to zero.

Fixes: aff3fb18f957de93 ("lightnvm: move bad block and chunk state logic to core")
Fixes: a294c199455187d1 ("lightnvm: implement get log report chunk helpers")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c      | 2 +-
 drivers/nvme/host/lightnvm.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 60ab11fcc81c..10e541cb8dc3 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -974,7 +974,7 @@ static int nvm_get_bb_meta(struct nvm_dev *dev, sector_t slba,
 	struct ppa_addr ppa;
 	u8 *blks;
 	int ch, lun, nr_blks;
-	int ret;
+	int ret = 0;
 
 	ppa.ppa = slba;
 	ppa = dev_to_generic_addr(dev, ppa);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a4f3b263cd6c..d64805dc8efb 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -577,7 +577,8 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	struct ppa_addr ppa;
 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
 	size_t log_pos, offset, len;
-	int ret, i, max_len;
+	int i, max_len;
+	int ret = 0;
 
 	/*
 	 * limit requests to maximum 256K to avoid issuing arbitrary large
-- 
2.17.1

