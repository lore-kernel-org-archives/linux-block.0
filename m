Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9FFC65BAE
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609E020867
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Av/YwMzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609E020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeLAEG7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:06:59 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34200 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeLAEG6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:06:58 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so2412355itd.1
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=er4XNTBrDyS5t2gvWJtJjpkVFpAPOC78sIXCy9gEMJ4=;
        b=Av/YwMzJ8POcTBIy9D5dhiqu9KvU5xSu1GWMV1OEqxgo3hod0BtdP3pKz07UtcSEFL
         lwcZgK+eCg51Yww201FoD3EOh5mDi7VMzppExEHkL1NO41NOmvOmFVnCqjohfKe1Op/B
         OD8pG8Cjw36bZFjhSUNI43CDqgH3dz3DFHVN3ChDE8fIzOu3tFxUdt9xTKueBEUR/9ER
         H507XFCdRTozL0YF+LD2KY/XT/JPJGHmaVw007CXHNR+g8ePhlAzx43Ko9O6vVcfVks3
         FuTi6qnMAKNkYKtd/1TeY05UTLVMgM+frVH7+BjDI32v0+MLTAUMeCoMim5zP+4ot4De
         vGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=er4XNTBrDyS5t2gvWJtJjpkVFpAPOC78sIXCy9gEMJ4=;
        b=e0zEOz6XH7IEFFu7ZhE7QLn5pfMAPVv+NEusnAl7ksZaHyHNvfp5MExnCqwdTiNzoe
         CXLAMNqjSrgXT4iNQnB0aEP6MlVWrLNNK6p3/nkTm1doZhQHtf3x6RAyOnHixsqXotSa
         bJnkRHZpcWB18mr4ZfQcFB4OtVtb2j7py00t0ltr40FiQNitsMg3b7zUVsmHt2DFRiS7
         OsUa4Skticjx1LNH25FT/kWo/qp3FyRKfGop2LAzWA2i4ECm1hEGpWdRNAM+FG6Pb/WX
         DlphqjIHyfU4j9mzLmvajeUzIk+7/8CPnxXbPY66De7osQx2DzCjQ6/H7qBvgF5iVO8V
         5HeQ==
X-Gm-Message-State: AA+aEWbC8zKOcRU2V2WmGaqy15Kyu+KZ9KRU+8NgrDUio4iNMcMp81WU
        /ZBMh3M56qx2qZerA7nlZIQgnXUlews=
X-Google-Smtp-Source: AFSGD/V/mIaMAcaIo+4uRU3IxtsT8MLN47bqMhUgE0te9bDcqM3IUtKtOUw9pEncR4KrUxrR8es7bg==
X-Received: by 2002:a02:8943:: with SMTP id u3mr5622148jaj.92.1543597022850;
        Fri, 30 Nov 2018 08:57:02 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/27] aio: use assigned completion handler
Date:   Fri, 30 Nov 2018 09:56:27 -0700
Message-Id: <20181130165646.27341-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We know this is a read/write request, but in preparation for
having different kinds of those, ensure that we call the assigned
handler instead of assuming it's aio_complete_rq().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 05647d352bf3..cf0de61743e8 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1490,7 +1490,7 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 		ret = -EINTR;
 		/*FALLTHRU*/
 	default:
-		aio_complete_rw(req, ret, 0);
+		req->ki_complete(req, ret, 0);
 	}
 }
 
-- 
2.17.1

