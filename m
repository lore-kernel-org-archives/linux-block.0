Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7269EC5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3742086D
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Bm9xtJPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3742086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbeLKAQH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38360 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbeLKAQG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so5762078pgc.5
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CoUoLVQhZCk01wz0SKdc8zjKvmVqwUz+894lpbana7A=;
        b=Bm9xtJPPma2afEHR7Uw+wyVoc5D9mA1PINhDlZYbNCKG5O3Bhd2oRHvxsQqFHOZees
         3jL8TOEwpXd5fbjqezrDkcJQ6703z0iCl9dmC5fixjCSfzj7mNWLam62HWqNR2Jv/DTT
         0ON/t4aRDgpztUTeupnrzc9cuZUUmOhZ67D9WXDtgnDfT/dHguLdDrljTpUSTB21FoKO
         hp6RefsmKTRzzKeBFkQaQvAzQTj3qsy4YtReRYrZpl1BYsfIUmy4Y8gcth34Z6yftbmP
         yNku9YoYdBOgORk/7zi3TY8HNnDFHz4+KT24QygRDnBIf83/hR4zoGUeECXG9PFrM0xG
         ujNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CoUoLVQhZCk01wz0SKdc8zjKvmVqwUz+894lpbana7A=;
        b=mwj07DumEltyX6uWzipzLigivEsw5QSvn/Aps364l7P/n9vrzaFd9cUtJhwUBjoASH
         3ToiJSO0bu/owDVk24/Gly/O3yNy8KFH7bfqicgxloF9y1DSP4n0UAaXU7sGrBSiIctm
         vZMNlsrCauEb/ft5MrIfu/YZdV7WF2tYcZmxprmfzPuwtexmeaFeYLRRNs64m9sRntHV
         IxqK2glYh5tvtfIry7wSyGHOXdM272OYUQQ/2ckLvteEqjYkMVO9aErBp4B5fetADLh7
         GgZ4Z3TwMV27l8kS9DxaK343J4t8QqFzq9wjt5oZb8SnsP6d+rbhlec0ZN2Dj8WCPysJ
         y1Kw==
X-Gm-Message-State: AA+aEWYHYpyo/ySdLPHrgBJdeu2ASyVDE01rU8EdKJXsYIBoz2jRTp06
        4BlGPgdI+L24Q/9Je32GdgQjWeQPeO6+zw==
X-Google-Smtp-Source: AFSGD/UNZQ1afBnp8asHleyZXkzzeaKWBXN1R4fRXQ0/mDOZNSBPW2NFMeMgsWbNT1nJeGvTydGhow==
X-Received: by 2002:a63:7418:: with SMTP id p24mr12804149pgc.196.1544487365517;
        Mon, 10 Dec 2018 16:16:05 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/27] block: use REQ_HIPRI_ASYNC for non-sync polled IO
Date:   Mon, 10 Dec 2018 17:15:26 -0700
Message-Id: <20181211001549.30085-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tell the block layer if it's a sync or async polled request, so it can
do the right thing.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6de8d35f6e41..b8f574615792 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -402,8 +402,12 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
 		if (!nr_pages) {
-			if (iocb->ki_flags & IOCB_HIPRI)
-				bio->bi_opf |= REQ_HIPRI;
+			if (iocb->ki_flags & IOCB_HIPRI) {
+				if (!is_sync)
+					bio->bi_opf |= REQ_HIPRI_ASYNC;
+				else
+					bio->bi_opf |= REQ_HIPRI;
+			}
 
 			qc = submit_bio(bio);
 			WRITE_ONCE(iocb->ki_cookie, qc);
-- 
2.17.1

