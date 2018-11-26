Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7B6C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE3020855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X7yj5lXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE3020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeK0Dkn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42259 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbeK0Dkn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:43 -0500
Received: by mail-io1-f65.google.com with SMTP id x6so14475591ioa.9
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=er4XNTBrDyS5t2gvWJtJjpkVFpAPOC78sIXCy9gEMJ4=;
        b=X7yj5lXzUhsMWy+CnAJoPhk33lrLTk7/RULRQTYaLro+GeoZwGIMOVH8bq5zHYf1sr
         /F6SsVasfH96v6P+hY8Y68obhZrHdB+zvqECwbKGnYIoNzfHCR57tRoV0A+zQj12EqjR
         5Fx78m1ba/mNAnpUdVXEGRQgwmiDjM9cr9Qytw/XsQsa6hBpbRzDlzllq/le4IXliqC/
         TV6C+Y8aqDwKRe0G/nlEHbxEMr/DXsAh3tdDinBqlp+yGd4pnnvlQorfoOh2tjvMpgb3
         IrWknMWXZJYI5VgiftefMQPq7+6QfVecz6RSO2tAmpOG8GLPi4RBbVWWoYB1+kTTrqAY
         p8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=er4XNTBrDyS5t2gvWJtJjpkVFpAPOC78sIXCy9gEMJ4=;
        b=VuBYjbQp2vstEfgDgYEnOGLsLGxZwyZy9Upqa6T1pZuA3FwxeJR8/6s9M1F9uWUr39
         WugBTQuZUtOmx3zDC8n37o8XyjPzdZsLY7SQke0LWwVGkxwneWOrlEyslfQD/zSk4l4D
         gY8mmoJtSswlah8ZMbjoOlBQU5Ur6//GSr5LYlZ9vx9JMhFqCnec1Lvi1a1vbNWSrRxs
         8su8rriMJzhiQ8H7e8PKt+S5pLbr2MFwA3NIkZunYvjj7UhmX+66dAcD7+oWrD57S/KM
         YS9VDM0/V0QtYiv0ICs1yDqod1lQceSY7m1anB2TBbL7HTDtJ2AVTCmEeo2bFTL7AbAf
         h5kA==
X-Gm-Message-State: AA+aEWba0hgm3SL8YL1HW6ugr6WO9wErTfYYP5UoQHo0dPjN5hntU8vF
        H5KIYH63az4h2AMRJGTXvpw8HzMGctY=
X-Google-Smtp-Source: AFSGD/VyjPChe8c8fQzhIk+QLnEMJOTZTCBhCuZroLZiWlymSlrug7H25N+HcWRNpd3Jx2b1lIhMIA==
X-Received: by 2002:a5e:d702:: with SMTP id v2mr20014535iom.17.1543250763394;
        Mon, 26 Nov 2018 08:46:03 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:46:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/20] aio: use assigned completion handler
Date:   Mon, 26 Nov 2018 09:45:32 -0700
Message-Id: <20181126164544.5699-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
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

