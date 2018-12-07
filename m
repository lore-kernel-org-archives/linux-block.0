Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAD0C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3112F20892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EDmQ/OxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3112F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeLGWUg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:20:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45817 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLGWUf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so2419716plm.12
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=er4XNTBrDyS5t2gvWJtJjpkVFpAPOC78sIXCy9gEMJ4=;
        b=EDmQ/OxYLLqNzUokUrsNdKb8Phl575uEIHuKF/MdO/zmFqMbe3+HIKPktivzMZfmq+
         0FjGmJcRPa4zQB7zhKfk0dVxmdsyYBwZVGXvt9sAwbTU/oj2vHxvOeZ6ADcrcWWHkMDv
         jTGWqcKtdQq5flsOAuFJPKq+IP+s9Hr0bA/Z7SGOFOmmqHCAc3PyV/gzMQDyJdbSJQlw
         GJXFM6tuvDuIjHAvoZmWYFOx10bVqvBk9Rf7oSyMh/RVBrW3kWkypgETSV12F9WchLYM
         R13pvbJaEFEPzAHlql+EVhweUWoQFEX0gPAVW/nsq9lCHkLeV+Dt6uZ69DhhHIAcUVqk
         dD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=er4XNTBrDyS5t2gvWJtJjpkVFpAPOC78sIXCy9gEMJ4=;
        b=kjMwb8kcamL9K5Lifqv2d4gFXM0PAmUKEvifBLAJ6k0xYZNVycYo4JsDag2w/E5loi
         nBZcR77bJ6kR3cfHeCvCrfnWNoS4Uh9SCGUyEMYTyfVHViOEVNQzVv8KFdzie7tkU30q
         raqmTyXDzweShIooJ2y8P+ChGd+dQ8V2Y+aJWX9w50faYgCfUrwZYGtazYjmBW9pCJHp
         8LwDnKTOJ7FZ10DxIUbaxKUNm2xgoyQNt75CrjB8X0Bkb1Dk6MiqDMottfiHMzBXplbW
         TM5vnHiT5fZ4mBcfh/HahGlEiXqQsAmYpJfI7R0Ipxj8HyFLXwnu16p9MBfPejqORpjr
         1cpg==
X-Gm-Message-State: AA+aEWYKo8pXzVPhjyyVcpZfKfU861PcER+bDBaISTwwFp1vue0NVzxE
        LTxy3SHSauWmXZmpWJTxw2W4CqFe6RQ=
X-Google-Smtp-Source: AFSGD/WvkI1dtS+ZD1xths86jtHnF8YACme2Jv4mmSrxPuRuPvMfeBGklT56Lp04yvxx91TLssnu9g==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr3870976plo.205.1544221234616;
        Fri, 07 Dec 2018 14:20:34 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/26] aio: use assigned completion handler
Date:   Fri,  7 Dec 2018 15:19:56 -0700
Message-Id: <20181207222016.29387-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
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

