Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F02C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B725020867
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EGWp2JrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B725020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeLAEGs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:06:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40521 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeLAEGs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:06:48 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so10214417ita.5
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2MxFtSFebSJ+ImD4ppk7jV+8mSV4CUk/N9/CLTpskeY=;
        b=EGWp2JrOvq3xeH5hMK13Fm1t7ubF2kGBUiNVxNT/x0448O/YjgUwl+AaRuOBTXrJ6E
         JqfXqgpZleYJQGnRIeX9G7rz0Pm6h50HDW/YrJNyaHysyJv1UScPc16MFHnwU1hRNGZa
         yD400S6xyNyzdoxCdwNkbozW3GAazSh1yE2Em08tfhHNFNAjG7MWQ27g1M67rTFt4dRa
         6vTbmksUsF0VrOKAuezDbYtmFJo4AJurhgFIDInvo8F8+JF92tdAJTKXINtWocLmtzD0
         vnWUYJYolvxaLpDNKdIOgIjVP3wZsWQK3NMInmDJTp/dNy1oIWfiqgW90Wdueh6MoHAy
         aUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2MxFtSFebSJ+ImD4ppk7jV+8mSV4CUk/N9/CLTpskeY=;
        b=Ff9za3O7CTwyaGVa3sySrzQIs268ijRgo/E4rXdEdSDDVRsWBGTvR1lvZfHqTkFNB0
         mbeqms7Zz9AcD5V0mDd+LUbVpEdeeSUuLPaGeIAYMPPV0+9OyMPgfO/OujrW3y+SbanQ
         S+nG4I5YwDoiWk/xQnw9M84F39KK1qzf0W4wNfxUvB52KWZFHGFwzFUh7BaM53uEiAZ8
         qSsqlu2c8FR9NoPklx1iiWstB5uoeg3ENCFkL7FMRDxW9uZl7gK96qnUcD1OVH7gC0P0
         byC+B5FLI3gJ2b9YzKJIQAAFXXcBPNjexThR7RTDCfNsVNX2vD2X23BVwbWuGGlACd5U
         ws/A==
X-Gm-Message-State: AA+aEWZt559osdFxaEItkWT2RdRKqnPx8zZLHGi3AcBmoO46P3185/51
        dppEu/jbkO3dfTwkmND9NaGtn3vy5Rg=
X-Google-Smtp-Source: AFSGD/W404x7YYbrrVgUrwlP+xDC6yoBZYfStOm3eBsulbaFX2IWYNNBfG4HfBxvYpIFUZRBHyfxJw==
X-Received: by 2002:a24:4a95:: with SMTP id k143mr5780360itb.77.1543597011910;
        Fri, 30 Nov 2018 08:56:51 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:56:51 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/27] aio: fix failure to put the file pointer
Date:   Fri, 30 Nov 2018 09:56:20 -0700
Message-Id: <20181130165646.27341-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the ioprio capability check fails, we return without putting
the file pointer.

Fixes: d9a08a9e616b ("fs: Add aio iopriority support")
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/aio.c b/fs/aio.c
index b984918be4b7..205390c0c1bb 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1436,6 +1436,7 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
 		ret = ioprio_check_cap(iocb->aio_reqprio);
 		if (ret) {
 			pr_debug("aio ioprio check cap error: %d\n", ret);
+			fput(req->ki_filp);
 			return ret;
 		}
 
-- 
2.17.1

