Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531B8C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153BA20659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z3FyYJ5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153BA20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeK0Dkb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:31 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45314 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeK0Dkb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:31 -0500
Received: by mail-io1-f67.google.com with SMTP id w7so14459865iom.12
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NbaVNkMyxvwaepZlvQFQJrgWkKKIKk5aWR0maYoyXOs=;
        b=z3FyYJ5q8+IqGRiv1IFmR7COSEdIAkh0a/45cbNar4425z8lglyvqTL8jLTTDCsx9k
         76ygE/wUOaHNFHSPBnzoK8onwPvjwCg9PCcHpF21PQAHTK+yFbVVhgScw8hi2Iex2AD8
         RVGBQc6s6UY+bmBCmukFhQLMP/B/7DLet7STVsXttUQbTyQS2PLbEmfN9CrfyPK0OHRT
         MF/FLPh/KFUOL8dyX/WezJ7mVEgDIXJlkFX9Ed0r+JlqSblTVMcoDAJKKjwiVNDsdjc/
         cCo0sCncRXUSCjfsQiUqC3HLIUTWX07oGTWm2lv7/Gbz2/zjXC8vsq1P8fgdsL5YCtgL
         oXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NbaVNkMyxvwaepZlvQFQJrgWkKKIKk5aWR0maYoyXOs=;
        b=Jm/ECHAVbpSxKlJHCEWigruYTyLYIoYGnCVsa7URLnQEkFGCijoGkoxUN0IOVBvrJx
         NbiGAS4sQPZ6mlUnu+G+6Peb8CjtIb1KH4kEEzjzzVqKVJSDNXFnaDt7Woq9/uC4ON25
         KcM9X7HpqN1zYiupIhIKVGZkq8Qh0Phd775KJpQd7bsUbLHZOllYPUHOITwe12X0kOMz
         T5orj056HI9N4XJzbTvBWgC6YmbzLINIYfgqJC3v56g2Nhsb4LvfjCkMYC8YhnsvkM7M
         3HXdqH2SFtN8wtQQZEZvWYbM9s2qFelTbCLtV6o5wc3ZeK8XqVjrTROLXbCo6NGh5hQl
         bvZQ==
X-Gm-Message-State: AA+aEWZFqw/Kik07y/Rm6XuhaBZYElMWKFBQf125BWqiUnU3auXIqlbA
        HbsTMLGtDvRX7maEevW8qBU4QUAQ+XY=
X-Google-Smtp-Source: AFSGD/XebPi3O7CTyBzvm/N/uzGpQkCtOKAaWJ/jPn78/jX5dFwaVoc9uC+SzYsWFKOKnnba/yvzpg==
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr20644103iob.170.1543250751799;
        Mon, 26 Nov 2018 08:45:51 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:45:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/20] aio: clear IOCB_HIPRI
Date:   Mon, 26 Nov 2018 09:45:26 -0700
Message-Id: <20181126164544.5699-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
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

