Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868F6C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEDE20867
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X/Dk8qhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEDE20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLAEGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:06:50 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38758 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeLAEGt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:06:49 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so10224987ith.3
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wp0ipsqt9//y3KPR0Mr4TZVsJyq1DbTfCdimy2bEq90=;
        b=X/Dk8qhh1Dbxk7/1nGYTf0bkALGSSBx3f8nLIzu3GKGfIwXRicVJWkg3rR1LrW2jax
         oMdlWti47RAdM3r5+Ez1aXYrYyWwh44ki/VVmkEeJINVeDUiyBYL7Ut+wbxf/q8RGRIh
         iesDk4yZ/+pwiRU7lWriqrvMU3x2CPWzSUK1vzBzmh+Yx9plFSkw/tfPX6qMd5IH4+9Y
         PNNxqbvSe4k6auQH8SS53FArnp88lNPfmNS/blaxSDduTLGbcsE+bFBElHEHESoSk3ZG
         sZfx5/GMJhDrR1eSS6/iY4Zhk1oFsovfxc15KM01bVf1L3KanMnz31TZs91tOqSW46//
         TgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wp0ipsqt9//y3KPR0Mr4TZVsJyq1DbTfCdimy2bEq90=;
        b=BvaVKRM6zQMwsFmCyYbeL8qrUuhXKgp2Jolj7DasszcOf/EfISKUrw5+a+UOZvXZhH
         arP+Lrtkiqx+XKsWuz65933GmMKc6zQom85IJ6OcGkAenvkQyjUL1QbyNHP0vlqZQHQu
         11+IztNmTRGg06ePBf24X/5cs6iDuonQeRq+zfCcXQJhlGAIPMUmOfwshzxUEWkr2jU5
         o7dgQMlWxCVxCsL0+TU+gDL3dfNz8WlEk/W28MG6iMBITvGxRpbeatiPJTymEcouoIsK
         sbEagMxXTT2VkVyQKyN61ol3sXxyGMo6LX9JT6L1WeXicf8JSTiUmJ+TJaleglZ4R0jK
         1gyA==
X-Gm-Message-State: AA+aEWZDc3uRdVhG4KCSjQcDyHCGvd5N6UsqhqHQG5pfZ/T2w7diP2R0
        0kPD9XrBLLWkMzLyH/cucik5D3NpaoE=
X-Google-Smtp-Source: AFSGD/WOc2KTlSy1yXDqNsH7W7ePMUqavv70PNiYG28NJv83SHfK5wkGHTJ7g75cNUbWdm9sIwd+tA==
X-Received: by 2002:a24:d08d:: with SMTP id m135mr5738482itg.89.1543597013565;
        Fri, 30 Nov 2018 08:56:53 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:56:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/27] aio: clear IOCB_HIPRI
Date:   Fri, 30 Nov 2018 09:56:21 -0700
Message-Id: <20181130165646.27341-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

No one is going to poll for aio (yet), so we must clear the HIPRI
flag, as we would otherwise send it down the poll queues, where no
one will be polling for completions.

Signed-off-by: Christoph Hellwig <hch@lst.de>

IOCB_HIPRI, not RWF_HIPRI.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 205390c0c1bb..05647d352bf3 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1436,8 +1436,7 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
 		ret = ioprio_check_cap(iocb->aio_reqprio);
 		if (ret) {
 			pr_debug("aio ioprio check cap error: %d\n", ret);
-			fput(req->ki_filp);
-			return ret;
+			goto out_fput;
 		}
 
 		req->ki_ioprio = iocb->aio_reqprio;
@@ -1446,7 +1445,13 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
 
 	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
 	if (unlikely(ret))
-		fput(req->ki_filp);
+		goto out_fput;
+
+	req->ki_flags &= ~IOCB_HIPRI; /* no one is going to poll for this I/O */
+	return 0;
+
+out_fput:
+	fput(req->ki_filp);
 	return ret;
 }
 
-- 
2.17.1

