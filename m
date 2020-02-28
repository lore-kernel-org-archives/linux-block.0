Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08BFC3F2CD
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDD92469D
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Zhdt7xkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgB1PGv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:06:51 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53261 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB1PGv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 10:06:51 -0500
Received: by mail-pj1-f66.google.com with SMTP id i11so1345561pju.3
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 07:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=voOQUMSUyp79AXPbhWgsmJqdQXnoM8mfKBxzIse2Eeg=;
        b=Zhdt7xkgJ9VZJueyLE++xHiOrxxZQ+G1QS4VkcKKyLRbgB1qxVtL0CY91rKDrZKeAH
         W2y7JT1wQczPoGFCePuFmYI/Wk7IhbjW9mRlBmvfTmg8sSRVGV78UALFwlEJZoSpNyux
         pfcEsMPPJxLuK2ZuXjHwNja6tqrs03dl+1kuw6AtFuJycwjAp/hrcyAOFAFQBhJiyILf
         cldamZX9Udjbm8w7iwMrOiFKXd23K+wvuMjgr8n+SEhhnbX/wTW2dgjbHyulgrKlx4aQ
         HAnhJj0ij+tp2WUpEUUZXBSUXHFqejeKr2Kellxza4PluS4g5+Srg82UuTZpTP3qX/Mn
         cgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=voOQUMSUyp79AXPbhWgsmJqdQXnoM8mfKBxzIse2Eeg=;
        b=cxvQnvYVKmOCyJl4MG5O3iIDxpdNjKHT2I1l1byBLVQ4h/miEHAlYg44NFKEzTTm++
         XcPGB0RRoLIfEFuFM9mNXjwUcBtoSAfLaFK2w3RrzVFrBb0x3psWuuXPYRrPO7+a9iwV
         qZCo6Q9yLT6ioyVFvCItGL9sDyomMzJIOyN9CqzqVe4eTZ4o/CjjkB6ogyhqCnHNw7qz
         i1m6C4um2gIEDvfRyT9md9W6atfrqSc1xzhl9lQ5IOLL6J6QDjfG8S2QVdv/u8qvdt3C
         xHRrnEONxDmPcXRHMhet5kVVKOjLBpn5lvoeF+0C7ZSKoJqeg/R4AVjRbqkL+WUWK4Cw
         MUUg==
X-Gm-Message-State: APjAAAU76OSXOodIGjT/VHYyNwZ7hMrWbn4X6vr0m6CTOFQcpmM2ClcT
        Y5fXdhdHAMRcVVYOnacRE4Kfs559IVvJ64ua
X-Google-Smtp-Source: APXvYqzHfpvAeoRSoHzcdFjuAJlpzhN0oMFqxLB6tBpfEaVxb7vCfstb6AsaMKol4mnXNzC75xs1wA==
X-Received: by 2002:a17:902:7e05:: with SMTP id b5mr4362514plm.219.1582902408945;
        Fri, 28 Feb 2020 07:06:48 -0800 (PST)
Received: from nb01257.pb.local ([240e:82:3:5b12:940:b7e:a31d:58eb])
        by smtp.gmail.com with ESMTPSA id y1sm7621912pgs.74.2020.02.28.07.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:06:48 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 6/6] block: cleanup comment for blk_flush_complete_seq
Date:   Fri, 28 Feb 2020 16:05:18 +0100
Message-Id: <20200228150518.10496-7-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the comment about return value, since it is not valid after
commit 404b8f5a03d84 ("block: cleanup kick/queued handling").

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-flush.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 963ae56d5aae..46fd6e83dd79 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -160,9 +160,6 @@ static void blk_account_io_flush(struct request *rq)
  *
  * CONTEXT:
  * spin_lock_irq(fq->mq_flush_lock)
- *
- * RETURNS:
- * %true if requests were added to the dispatch queue, %false otherwise.
  */
 static void blk_flush_complete_seq(struct request *rq,
 				   struct blk_flush_queue *fq,
-- 
2.17.1

