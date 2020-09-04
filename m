Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F10AC43461
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 09:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEF920791
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 09:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmR8l2V5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgIDJP5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbgIDJPz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Sep 2020 05:15:55 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E90C061245;
        Fri,  4 Sep 2020 02:15:53 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e23so7667886eja.3;
        Fri, 04 Sep 2020 02:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NEfgg+DDlfqzQBPz0P9WGlQbszfNCAP2l3dg5MsL0gY=;
        b=hmR8l2V5bNd8O4XRQlSzk9uDugXK/lxgFMy+JdhRvO1gqMEVhszyFxx6EnYmMk3d5h
         4+I6XnfO0Ob2mcxGn9CQwo4djzuQrdym/MbqyFTy6zkmklgleZKbU5dQwZrUDS6HpoRN
         pKffqzyWwCJst08Ccy4Rr9sTWtuSRaDEKHEi6t/k8DIHzEAhhGVw7j2wZ203Xm19wztF
         JL93vnmlEXb25gpMei4Y97DHJuYPdD0cYfm4dZRiA8jzYT4w4WaY167DdsITtQJGFLU2
         Jl4uLjdwDLEqmPFy9mQW9wOEqFN2oJshFu0lCsYgidFR0/FxyCpLWM5HONpev4KRkmWo
         gnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NEfgg+DDlfqzQBPz0P9WGlQbszfNCAP2l3dg5MsL0gY=;
        b=o8JhQwq2YVeTcFTP/SliMl8LDhsJZRiw8WELLx1h+69Y5rMyjonAzsqnKq/frTcaAH
         0AKZkzlX+sJXYpJ3KadipQCCZfSr/GhRuUt6m/y7/QZh3/vWABdCNdWm+ppcvNQr0d6x
         s4sslPmHYCmpH40ESXe5MBlVkxpFYfUDL1zS8airfviB7DW5Is5l6hXyqiGmNhGo5gpW
         FX5MaXRp1Wq0DJ2yXFV37AFHCo3fwADz/8ERMjDbwtB8b8QVzqwFG9u9mIcJq5oErHKW
         84cugFV81/HUBYj9l++djGNvGwwo4S2UjLkSj70nKTVsxCFWiIGFD7wrPM0HtQFoWceB
         z3MQ==
X-Gm-Message-State: AOAM532RfUB8fZjx4cobGRiP8eSBHiGsZ6sxpTTiqMKn4aD9nZ6YrGdT
        mn2T28Uzz/hhK8hm9WtOUAY=
X-Google-Smtp-Source: ABdhPJxNbfTXeoYhBNmNnvds82JLA57Ur4/SGZtBbf3nYwc8xdDvT3ICdMf4uVSlAJyTHywkhGFu3w==
X-Received: by 2002:a17:906:af53:: with SMTP id ly19mr6159476ejb.503.1599210951891;
        Fri, 04 Sep 2020 02:15:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b904:9293:1d41:83f0:a723:a7e3])
        by smtp.gmail.com with ESMTPSA id a26sm5562066ejk.66.2020.09.04.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 02:15:51 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH 2/2] fs: isofs: use generic_file_buffered_read()
Date:   Fri,  4 Sep 2020 11:13:41 +0200
Message-Id: <20200904091341.28756-3-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904091341.28756-1-huobean@gmail.com>
References: <20200904091341.28756-1-huobean@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

do_generic_file_read() has been renamed to generic_file_buffered_read()
since commit 47c27bc46946 ("fs: pass iocb to do_generic_file_read").

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 fs/isofs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index bc12ac7e2312..7541581c1064 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -312,7 +312,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
 	end_index = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	/*
 	 * If this page is wholly outside i_size we just return zero;
-	 * do_generic_file_read() will handle this for us
+	 * generic_file_buffered_read() will handle this for us
 	 */
 	if (index >= end_index) {
 		SetPageUptodate(page);
-- 
2.17.1

