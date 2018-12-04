Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5B6C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE3720850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PQ78I25E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE3720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeLDXhu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:37:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46221 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeLDXhu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:37:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so9063291ply.13
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=er4XNTBrDyS5t2gvWJtJjpkVFpAPOC78sIXCy9gEMJ4=;
        b=PQ78I25EACF4QpvLy2c3RPPg3RGlYaTp356E3BtnPHRUhKnUnNAiREl35+DqWiL9MJ
         wruRA6lo9pj6KoexHWN9W5qh1LCvDsmNYVgHX9MbemBF2ud/QsiKJERpqlEK0sdG9ePp
         znlptHklXgtAk6qe8HEoEkZsewLgg4BK4BmO7JZOVpjt5DamG/jagvUY4mymOUwiAPNv
         CqVqpDOSXcxCP8FCm/yXVsypqtwyyK7wOuDZ4SkR59aONeBebGsxbipUka0udprNnj/l
         WWTeMxuq9TCLdrTK1ghSgkLozJyEQsNC1Cpoq79NQqQAWM65lY8osnVLbxukhaKsdPKg
         vFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=er4XNTBrDyS5t2gvWJtJjpkVFpAPOC78sIXCy9gEMJ4=;
        b=LN2a+w356x26/002yK2XAIn+X1/z/zwYU3vK97AVimHFFXBV7IfZMcsEt98Nw0njc5
         ruQ799DLuX99FTFSZiw2+M4TbWC8zf/A4GIvJNiPLQVk+Oe4p8m2EPmxFi6FOe5jwThz
         iKr4o36YeUIVwshMBtReamiNlxfnezSMDjaYws7OCw6kW+1ym4nEF9ipcPJnMb8+UEEX
         hIEDKn1x/HwoBph8JIUHcahBuR6104GxwQIcBc5MixbZuod4lTHO4qIqGGxhtrrsS4jy
         TtegXGZCeFv52rowKJoccfrZhR3nZD7pBXMCqN6bAe1ajdKUrXotzlIqB7UDE6M7fywH
         Wwig==
X-Gm-Message-State: AA+aEWYKG7QTM9Klh9ViLhsMG3meGkVzQgbeGuxO7pEpQs/vHOYdiboE
        Le1C5OV2nf354AmAVi5EDhX3N0czAQ4=
X-Google-Smtp-Source: AFSGD/U/wShxrZGjTzS5JrlcAERYXLvQHt9ixDXJZmJEejy80uMAUNmjIUmOTaxM3xsIRXl3pK6+qg==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr22135069plr.15.1543966669243;
        Tue, 04 Dec 2018 15:37:49 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:37:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/26] aio: use assigned completion handler
Date:   Tue,  4 Dec 2018 16:37:09 -0700
Message-Id: <20181204233729.26776-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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

