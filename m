Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1096DC41536
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688B720C01
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h15ovWOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688B720C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbeKUDuT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:50:19 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36457 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbeKUDuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 22:50:19 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so1959372ioh.3
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 09:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YHmOeb+nH1WLQpjM9QAPFM+mPW2s3h03b5WAhc+cvsI=;
        b=h15ovWOimmTtizENiBaIZ5BjiSfy8UWj803Ap2T0SRzjQuKa/SihYM0ViFTKmFPAHa
         3k6dB4BBpygC6ovEpH60uSmewYPG+pRSjjDbURYn7RljV5I1avOViRDyY7houNqTgkKI
         rDEvPYuLkNCmtOuZ2/QD/GoTCgk8IDhHyGjw03gtF716gJq38t9c12OfKsvJGWV2qL1z
         fAqLggSuVNmE6sNf2xcD9LIWVWJdkSsKt0yuNmYeqeEhGAoCcPuynY1WGK2tQMt7+tXA
         xsvVj7VuXppmn0BbFKebUwx6RVn5YRG6eciUOUxqjHw3BJ8HPs3kI+TzkaYpKLISKQ5o
         PL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YHmOeb+nH1WLQpjM9QAPFM+mPW2s3h03b5WAhc+cvsI=;
        b=Y8JdGEBlGpWCKXz6l8BBjg1v6xxbCvC0xY4bPIyB/sEMxsrmwpn18tHjGC0BeCdfFp
         1mo4AYXo2xtJqAO8Gi1/rqRpjXxaUsmSlvR0AItmoy4bCGGiYyBbm0ksH4HLQzB5PZdE
         to+qmyV2Iqk1gagFR5+b89D3JiwUoTRPsgkmlNyRBWKUeG4eZLnJDYJPm22pIHgaqPmu
         nPTrIlvH1tuxit7l3G17vLMyFcbDegV6+uzk5KaFTpzvqD3cTYkzaQ39uVIWn6BgmXkS
         +aKhp/9dptS4jppIiJxzm1cUOFzfHyb8XgrGJ5cSMAJezH5yrQTV+sZjnERJKDdgVX7Q
         1m1A==
X-Gm-Message-State: AA+aEWZbho2acpFeP2S6BSP6uiNjnm0gQdBz3DQW4D/CFO0JXzFNmnnF
        97hQL3mHJ4sulMp0wzYHE0QsoDQwtss=
X-Google-Smtp-Source: AFSGD/V2qXqWP0/zwHJeZ7/ImPlRZfI+Veh8Y2O8IfFFygAuaPRqNVSu3B0zPzEguW05xdbjRPZWyg==
X-Received: by 2002:a6b:37c2:: with SMTP id e185-v6mr2201152ioa.173.1542734405305;
        Tue, 20 Nov 2018 09:20:05 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 186-v6sm15751530itf.11.2018.11.20.09.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:20:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/8] aio: fix failure to put the file pointer
Date:   Tue, 20 Nov 2018 10:19:50 -0700
Message-Id: <20181120171953.1258-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120171953.1258-1-axboe@kernel.dk>
References: <20181120171953.1258-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the ioprio capability check fails, we return without putting
the file pointer.

Fixes: d9a08a9e616b ("fs: Add aio iopriority support")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/aio.c b/fs/aio.c
index 574a14b43037..611e9824279d 100644
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

