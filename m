Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A9FC64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6C820892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hEIAIA57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6C820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeLGWUm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:20:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33929 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeLGWUm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so2578488pfg.1
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=46YCPSjyTrlcpzDW0Ukbp5ofhNBoK9a5mtdA0d9T/5Q=;
        b=hEIAIA57YvM6T49z4nRuyqivgkx339NE0Is7F8EdC6VGpeWDszYovlYGGrhvY4SMGR
         sU8ASN6Ecg3VH8BPxiYsIEhx1wiCu0tRRMPkHFgR9O19xGot9pkheEXp6CpL7aIobacu
         BPoQ1BcpcDNN+PLk1jxH0m0/den4TPQ8J4EkE2i623VtLWRLMzEvkzPGPrVRfiz94nYO
         4vtqal+sSIT0Jgf+i6dy92KAi5KdS0ct1KpvfHYLSffwCtlo/SBzGrXQ92Odsy5lUPQy
         WLHbwaKtQKOXS8WftqXoV1DegvF5NLa3Z7OcISu2Q+gsIx5athvMdlamTQ5zH7vjcyJk
         WcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=46YCPSjyTrlcpzDW0Ukbp5ofhNBoK9a5mtdA0d9T/5Q=;
        b=kk8An2c9iScAzu/1aam5vIPspc4RuFVaWvl8lfJhCPB4wSwapw+r0PMbhQRPjudR2f
         WDTo/F9d8V4vCcRhRB8rwWLrxUDdOmei1qzK3FTesOAlbNc70L/enWSZWhvd7yfRxc8E
         XDzsjiSP35Sda04kXCM3/etapgggoFP2Cs8cwPoVlrsKlc3TF7o7jHQqv0vK3NBWfbqn
         ZgO11QwVHGE/pSagSc6Rgw3Tq2a6DgM/BISpaEWs/B/P+e0ZAgpO45B0uHGaFHUpdHy2
         HcAVlfd/LnxasoYcJ2jHAsUQVO2gTN6X0uidud4+6/6tOB/DDe4DglEMpcLnHIAXoT5q
         GWTg==
X-Gm-Message-State: AA+aEWaHEoOLsg4Z5ExbXWlDo1Hqzjyb/IC4y3akMszniuFO66K01OmK
        sc/gEFYWioNbPMStSQHFtQJLxwaHKUo=
X-Google-Smtp-Source: AFSGD/XYpuAO/UtIXwV9OMIiUAOwFkuwGINGLpYrd1WPe1j9FE0emBxGfQLSTjjT+JJ/6BhL0pDM+g==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr3590368pgv.438.1544221241575;
        Fri, 07 Dec 2018 14:20:41 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/26] aio: use iocb_put() instead of open coding it
Date:   Fri,  7 Dec 2018 15:20:00 -0700
Message-Id: <20181207222016.29387-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the percpu_ref_put() + kmem_cache_free() with a call to
iocb_put() instead.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index ed6c3914477a..cf93b92bfb1e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1884,10 +1884,9 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		goto out_put_req;
 	return 0;
 out_put_req:
-	percpu_ref_put(&ctx->reqs);
 	if (req->ki_eventfd)
 		eventfd_ctx_put(req->ki_eventfd);
-	kmem_cache_free(kiocb_cachep, req);
+	iocb_put(req);
 out_put_reqs_available:
 	put_reqs_available(ctx, 1);
 	return ret;
-- 
2.17.1

