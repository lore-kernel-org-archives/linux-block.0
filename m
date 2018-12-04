Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF558C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D1520850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iIOYrDG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D1520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbeLDXiA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38400 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeLDXiA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so9079028plb.5
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=46YCPSjyTrlcpzDW0Ukbp5ofhNBoK9a5mtdA0d9T/5Q=;
        b=iIOYrDG1w21bEIhxrVmcfUuIG9VXHhcogcg/cq1Gt9ZqZRTpydmQBC14v9zhevMLCh
         e6l1w6XYqIBYTUjZQ2N+stYk9KYQPmrVfqyws6i1HGuBa2ppJutarQ10T+ZgRKTmVYoQ
         Oy7U0uk2PtG22JANA132fuiQbqifl9MnbyHOErzBI8EkG6vL47TBlVyXr5UXV1ax4hAP
         pMOPToAUTqdUjNJ+fmCjnDZI75Yt/BWH2KKbkIjGkvSwwLSkI7kWoUeoAPNo63twvvVn
         YNBH2fI7Vg4fr2S4vbb/boz2/0KXdz8icZmUHeozFMg57o0wQWLFIST2dGt40VGV8l+x
         BGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=46YCPSjyTrlcpzDW0Ukbp5ofhNBoK9a5mtdA0d9T/5Q=;
        b=R2+F4gqcnuMa1v894R7Orq3mM30dVRm/lscrJdNG3bf1tPFJ+oqaZFxsxk7FllUE0X
         +ClCFdvlvyxipZ7CtkqgIZhls61nhfgMo9/ozCwmQSsgkhZEv1iyiXbb0QL6tNfd+rTZ
         lVZ+gSQ/2oW1SSjQmUhpzT7hJI1Prp/Rj6C5vGCKToKCql0Cllgq8zR+vvL1sTajq97b
         L4kHqfopJSFNbcfWkjf+bx0Su7x8vVPSkyniiaaPIqPG4EUfADH7ykFRLiw5VZ3qpXTg
         F1sb3QVmRd49eokwFOq8at9yHs9dn2aa8tsoYQyUzNuZcwlGOpw3zFe76isePsz0QoA5
         AANQ==
X-Gm-Message-State: AA+aEWasZRdfNS+uTVL7pTMAkeohRd/9O3KsPlF7EuDhlwAJ1c5QH1WN
        o/OcOIB8fckmS98kmqKyC2rYqx5unvU=
X-Google-Smtp-Source: AFSGD/UByFXnwmtPsEbw4UOJJ15sI+ebt+u8iHRY3wQ2xSWWc9vAfal2jXUYSmX3RM3NmyowY9q6jA==
X-Received: by 2002:a17:902:541:: with SMTP id 59mr22448986plf.88.1543966679118;
        Tue, 04 Dec 2018 15:37:59 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:37:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/26] aio: use iocb_put() instead of open coding it
Date:   Tue,  4 Dec 2018 16:37:13 -0700
Message-Id: <20181204233729.26776-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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

