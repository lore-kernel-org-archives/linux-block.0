Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8975BC46466
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4493220831
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NK8DNXI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4493220831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbeKUDvI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:51:08 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45547 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeKUDuR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 22:50:17 -0500
Received: by mail-io1-f65.google.com with SMTP id w7so1926767iom.12
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 09:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NZHrUuNmmD/8Ezs95ryDGAkFRBh7DIEuoppRHZCFEdE=;
        b=NK8DNXI5wUhTjs+EA/1neL8dFcOk0uff8oGqKaMruDr4vLI54uoclLeZOov+f/83+/
         gTJioW6b97bEnS+YR0IJnac36bLdyBR+DKJCANC3RAMULLzPUV3kkzBeS2ESNfcNGpyl
         HgGPgXKG00NA3GLJSj1nH5H0NgPZU5MSZ/7zBm6N7b5qwHXwvX0wKyERsafVfsElS8jj
         hppSZPoFOE79C7Qo08ZmfP0+i92cePjK015jMdBaAWKJOog+ji8EWVkHc2IMpuUF/a2T
         GYFQ1HzsEigfHsAaJDb6ZmYBMwl0xocOw2/Ej2iaIIgH1qTOAKi0AMmV6KGaMu86heRZ
         lvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NZHrUuNmmD/8Ezs95ryDGAkFRBh7DIEuoppRHZCFEdE=;
        b=bIaSaxJu5sB8FEPV5kqFwtepGH9LaHXs7W/mspWdiPi3c1vmVx6yCll143gTUT71/7
         /QHAjfOG7glx+1bvsXTBekTtaJcAOo0+FwShTTRaKDc+nl3Xko/r5m1DiPm3q+rAlCht
         6PdbdI5tdkF1lV5t+dbNB8yuhTllgwDIIBIt1L3Z3wt5SkbK4tukaA04pqqv945ACkEa
         5fAq6Lvi86az/XmC16Fg0JaO86vwO5MpNG/Nj3vQ5yu14/aam6SArqig3jJmYksG7qLA
         H+z3pbmsZPKP8swujs80fmCx596x04pRjYnwnDosims0gABk3P5rh1m+/5i43hlt5GwV
         E6wQ==
X-Gm-Message-State: AA+aEWbemNUgk0ngNBw0yZDAEXPLaG0x2zFcelG16cEp7dkaWQLHLVLJ
        j694B1v4disXQjQ9hUFgFT9IY1uOAus=
X-Google-Smtp-Source: AFSGD/UZkhBBUS4oWCrP51Bt68Fe5DTEgyCIRuRaCfbQ6DeZjlipSvMTiIhZ5PJNZDlw2qfuWx92fg==
X-Received: by 2002:a6b:620d:: with SMTP id f13-v6mr2187530iog.11.1542734403636;
        Tue, 20 Nov 2018 09:20:03 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 186-v6sm15751530itf.11.2018.11.20.09.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:20:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/8] aio: use assigned completion handler
Date:   Tue, 20 Nov 2018 10:19:49 -0700
Message-Id: <20181120171953.1258-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120171953.1258-1-axboe@kernel.dk>
References: <20181120171953.1258-1-axboe@kernel.dk>
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
index b984918be4b7..574a14b43037 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1484,7 +1484,7 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 		ret = -EINTR;
 		/*FALLTHRU*/
 	default:
-		aio_complete_rw(req, ret, 0);
+		req->ki_complete(req, ret, 0);
 	}
 }
 
-- 
2.17.1

