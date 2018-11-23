Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E68BC43610
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F6C20824
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="k01RBKiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F6C20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395347AbeKXFTu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:19:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43226 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395303AbeKXFTt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Nov 2018 00:19:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so3364286pgk.10
        for <linux-block@vger.kernel.org>; Fri, 23 Nov 2018 10:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MzbWbo9n2Y/u3PwfH0Qv5yW2T3HdVyOokQf5GbAztyc=;
        b=k01RBKiyGd5Uc6Lx4XrGzKH448UFAMA0Rxwb7vM8CWgBhCqFVhBInOP9Gm8z4ySj0r
         tQ8QhZzsSZRm777rpJN9OGcq23gpg6SlMtIS18LlH5uISLaQoJWC6uQNDODUo50iKyLz
         kiWjnr5H3MyGRnwGDCj+Tvb7nplcJk1C122oCxivaIDf46NCWRcDjbFciPXSIfpEVgMf
         8bZ1l65Ieu5BST7FWbZ27Cb8f+qV0hq3vDfyEAEXfrgHB9EXN8viviX/2z+yDNUcixjt
         A2OPGg+B1lXg31u8Dmp8RNUR02y8AkpAvdUby18etzza1IKOZ1D1G3J3cWlW6+5nNr6D
         d+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MzbWbo9n2Y/u3PwfH0Qv5yW2T3HdVyOokQf5GbAztyc=;
        b=Ka/GU4Xp8uT0uIu9WOiKnTktHX58nrW+8HJgmdCxGz6HW0vpCNBokzTAW2WBsM1gTm
         fColf2qvMq1Mhggr6QEfeql1FIiZSPuEmxFVuro5/8XztGCI4400mK5qBZOnZ4POvyuf
         Ia6PC3p9I8PpgDFSZ0TojVQVRV1h1oJDkOmv+73ynS1FK8/LXrK+GJOc+CWJygIrsW5V
         eWZ5AF4ZdZVAtY//fwgii+mqUWd5G1QE6/jP0/WLmcYvJjfKOn/+NGqQR/mKikV7lv67
         uUCaVsKqG836NrnDZFavPr3f9S/r05BbBXQawumYBEfHoNL+EjqJUG5Wox70i9iXXdsC
         dedA==
X-Gm-Message-State: AA+aEWZ9I3kEFk2xdQWTcuPCudEAKZvRecEpVH66GNItqjzydYhqeTrt
        fT3teSKqhFw2MvgU0ApGdtJCDCScp3s=
X-Google-Smtp-Source: AFSGD/Vaf0Iq7EynLoS+OLdv+SeJGy+7MwcUJV2WiVsVquFe6eJibD6oml5hSNocpKGAyWXd2L6Spg==
X-Received: by 2002:a63:5b48:: with SMTP id l8mr15193444pgm.80.1542998063787;
        Fri, 23 Nov 2018 10:34:23 -0800 (PST)
Received: from x1.thefacebook.com (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s37sm52294260pgm.19.2018.11.23.10.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 10:34:22 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] blk-mq: ensure mq_ops ->poll() is entered at least once
Date:   Fri, 23 Nov 2018 11:34:10 -0700
Message-Id: <20181123183411.8708-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123183411.8708-1-axboe@kernel.dk>
References: <20181123183411.8708-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we immediately bail if need_resched() is true, but
we need to do at least one loop in case we have entries waiting.
So just invert the need_resched() check, putting it at the
bottom of the loop.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2751f0a3ccc..ba3c7b6476b7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3375,7 +3375,7 @@ static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	hctx->poll_considered++;
 
 	state = current->state;
-	while (!need_resched()) {
+	do {
 		int ret;
 
 		hctx->poll_invoked++;
@@ -3395,7 +3395,7 @@ static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 		if (ret < 0 || !spin)
 			break;
 		cpu_relax();
-	}
+	} while (!need_resched());
 
 	__set_current_state(TASK_RUNNING);
 	return 0;
-- 
2.17.1

