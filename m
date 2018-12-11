Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF4FC67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66CB2084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PwW2hgnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66CB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbeLKAQK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46537 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbeLKAQK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so6013670ply.13
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=er4XNTBrDyS5t2gvWJtJjpkVFpAPOC78sIXCy9gEMJ4=;
        b=PwW2hgnrxIOVuuD29APFFaSYxEseZew3vbxJUtXsh5mld5LxEC5rMiWY8nar+GaW9o
         aBU5mAWldf5oR2B3KJ9hWJz86jz0YSyAmEkdvG1pV5yYomEe/3vOI51rnnSWC6eaqmMO
         gFIZUzlDCVLeoP/D+9znfOHbLQoNtwYO6OLg+97JGm99X1Xxj7jmalmwIqYX92yOyeuS
         mnk+eJfuC91aN52qsFCPdaAoaZH2/MBAMHC6g8cy/b0XJ1C/3NNZUQTdliXhBNK+s9f/
         jzPGSb27uo2vajhut1L8N6640bS085HeEhIw8OwEo4mbpvAoxkNL2nYDTF1aBHM9RN5b
         3Esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=er4XNTBrDyS5t2gvWJtJjpkVFpAPOC78sIXCy9gEMJ4=;
        b=njfRWxs6diKmsT1Q+6Cg0wb+Neq8G+176akBx4ilSgrG3JQBBhjQOgFizWigmxXk60
         nCJpHj4baio3NGa8y/ZzIQdxpoUA1x6VwOoRJa5RXfm8VMWJ9e7aHPVoHYoR/jTdbUji
         c2VTi6leDRIfR5NNHsntaN8T5fup2nIFSu6e1mJ3qWijEVJt82Glh/HTO+EDM0SeEGrG
         CClnMFDGJ68JDx6vS9GqDXxfGb77E6hQ61f8AElkIWGEbaowzf4UgU3wjY37gK1+LQqN
         ULtvAFPwCtjeeriVUHIgsYZraykcdw5Hgz0+cNxDmrSCyGpEAYhy9MkZoImJWCbLLuQR
         N6Uw==
X-Gm-Message-State: AA+aEWYOr0i9PZzkfXqOdRkOC9V0nHlgp/f1tu6PXszcXmrFuwypzZgO
        U3QWBJNMUsnr4Q8uQO6XwXkB3oFC8j6chg==
X-Google-Smtp-Source: AFSGD/WWId/7Jtul5ho39W/VYZhn0Ty/AAZrsLtVZtUv8QDdtZ2gTplSXG9q8JFtrBWF3c6sD92Cyg==
X-Received: by 2002:a17:902:6bc4:: with SMTP id m4mr13349724plt.93.1544487369157;
        Mon, 10 Dec 2018 16:16:09 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/27] aio: use assigned completion handler
Date:   Mon, 10 Dec 2018 17:15:28 -0700
Message-Id: <20181211001549.30085-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
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

