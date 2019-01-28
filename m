Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF4C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7962175B
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690700;
	bh=1KhOWK4e3/oNkTXhksJ7qnXQEeF37QcoX3OmQbgIr0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mbOaWuDgF8dntmQVidSadf5ACzuJNJdasPiLeUu1PfI4yL2owzwL6i9VgiMwUhlUl
	 P/6w2tRl1iuyfu54wpTsj4QTQKwBz05qNKEvJ/Us9dGifqRbm9U0suW1dzqO687jic
	 JWYPWa9xh6yXVAM53wiyYwJkVVObYko/NdMb+sNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfA1Pvi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:51:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbfA1Pvi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 10:51:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3F712177E;
        Mon, 28 Jan 2019 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690697;
        bh=1KhOWK4e3/oNkTXhksJ7qnXQEeF37QcoX3OmQbgIr0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qCZ6Fq5M/s+YnRzaGzeMvD7b5yGKGIY9SMMKF/d3OpIpaYv0r1O0yUn2ffFsnfF0r
         155SqMfdu88pLa/rA753lvXx2Pc7iDtSCYFqB5ty6ynNqNtKtQkm5cBH3GCHrS9TvC
         7Cj3okCcL2g8ETC08u/5cbnOe/1AFFKz9ERoWGJg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 167/304] lightnvm: Fix uninitialized return value in nvm_get_chunk_meta()
Date:   Mon, 28 Jan 2019 10:41:24 -0500
Message-Id: <20190128154341.47195-167-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit 55e58c5e78aad9d3246f57e7718cf5ee7adde9e3 ]

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
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/lightnvm/core.c      | 2 +-
 drivers/nvme/host/lightnvm.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index efb976a863d2..73ab3cf26868 100644
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
2.19.1

