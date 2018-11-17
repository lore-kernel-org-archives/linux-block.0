Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF40C04EBF
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 23:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889522080D
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 23:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vl/E9nBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889522080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeKRKLv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 05:11:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37997 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeKRKLv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 05:11:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so5100798pfi.5
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 15:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X6wOS/+eVTbC/nSMIJLdTrgTKcgZ05UsIHVprCBYDgI=;
        b=vl/E9nBtuvhd0y2G6D/skp8Ig13YMasWWbYqZ84tp8Ytj3nK31lF/F9uf+mdg+dr63
         E/zFyjTwp4X5RY98Fn6QO0i5IQdtrN/mvX7YIwqWY05l5PHr7Gypwu7/sQq8CXJEUiIB
         sAzPfGtc97ZD3to6XNf/QZ37tnvpDgIvLSixvCKoL1NWBnLbZTeOI4V1No0fHa2GvAG0
         migYmvPxMh7YLUJiN4XWOXWbre1Zwn9YJq+KJ8zjJ26Zsy9QKDOhkKSFcMdu/CjwBhru
         dJo0rg4hk1g9MS+5he9NgVqtdbn7bfbMHCnQybh/N4rZK3yCNm/YNOX/GdV5NyvjmAYi
         uyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X6wOS/+eVTbC/nSMIJLdTrgTKcgZ05UsIHVprCBYDgI=;
        b=TfQDWaiMNrvTliBsf36TokO8ap2Rhqew4njo6ipRTAltN8QiSFrVYpt0W3S9SQK91+
         8BpZ1PvB/0wjygltw2u+kxM8llo/2y3C3BtnRrF4WFfoOF1gXzg/evywsEoI4ZnxF6Ns
         yZWWxJacphGTHs5MPBjJFhFtLSV8NNNMnMrmGnSlW3SvUQHa0ih6Y63l4d05t/CAV30l
         YeiwONRjkKv9Sl12CBwy++eGMAETFbsoRzjJK3JUZxEbOYoKIVKg2BEafsSYqkayy2yw
         hg4BSaIZAlVYsill72x2MVwBrOTRbqmWjOJK4bNDbnx1UOsKHh/nJV5M3U1C1ODQO4Gt
         IyaQ==
X-Gm-Message-State: AGRZ1gKvno5W8sccI5Dc7tnESTibnc080x6VMaa0C4CXfSG/ahm75U2n
        rIolqk7oHz0V8c9K6WB6Laj9vQ7IQLQ=
X-Google-Smtp-Source: AJdET5fWtMzmleztKkWele3Aqvs+2xzeofjyokN7jGgO1nlbyVwbTnlEK03iwKn6825AU3Erz6eb7w==
X-Received: by 2002:a62:ae12:: with SMTP id q18mr9863587pff.126.1542498805211;
        Sat, 17 Nov 2018 15:53:25 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m1sm15812345pgn.9.2018.11.17.15.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 15:53:24 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] aio: use assigned completion handler
Date:   Sat, 17 Nov 2018 16:53:13 -0700
Message-Id: <20181117235317.7366-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117235317.7366-1-axboe@kernel.dk>
References: <20181117235317.7366-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We know this is a read/write request, but in preparation for
having different kinds of those, ensure that we call the assigned
handler instead of assuming it's aio_complete_rq().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 301e6314183b..b36691268b6c 100644
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

