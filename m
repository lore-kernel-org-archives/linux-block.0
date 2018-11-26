Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA628C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D2620865
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JsPb2kve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D2620865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeK0Dkz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:55 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44787 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeK0Dky (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:54 -0500
Received: by mail-io1-f67.google.com with SMTP id r200so14453274iod.11
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RA6SARsil7zOqlPTyhrfo176dQaQeNwiqXCQQq9Z3o8=;
        b=JsPb2kveJdT1klVCCo3xKbZcMV24M8JQz4D6n/6ZAqpNT0FtEjlFGPROB1JcYGLUbo
         ESAe/3xykNiR+QDJMS7dCdVCoxAAX58IhggzIE+AMvnIqTYXBKd5ov7V9Jskc0g/89Nl
         OnDLSKkX3+Gx1GUyEuUE1tqmgOwO3L4txi6PiMAT/NmjbcHBKioA8X7RvluS9VrimcSv
         5nCHngBZlwvlK8j684A/xCTIvCV+Iq1L7RwGSCmeum9PAOowv0Lfd4/4HsV8nQ6JAhMZ
         aHRwdbQewEBBP9grneNRl8z8S4JlpjaOEesIWUjBdJcpuRkKINzKqV1bTpO/fVIyIxkX
         aJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RA6SARsil7zOqlPTyhrfo176dQaQeNwiqXCQQq9Z3o8=;
        b=UrCV6W3m/A0qSCG3OXYFZvcvgx/Gl0dQEhf4vJdkOBAMMCTGTJDl0OAPRX9XUabJR9
         o6rfXXU4hgpAQHq1Tf1sAZcd6eog1AiaLfjMI65A27TfZLQUU7cU0rE1G867CPEotUyA
         e1uTjB/OBPXh73CZWl2JOkslhOw0JJMMmGAcgUlDxJuOYP4+yiQIO1chFSJUCaC04gEt
         QtkDPmAv/teV2raMmI8gXRade88km863y+MNyWUqxQMBT72GgF8LwPSzf/HoKKlD3X2O
         wcgdoeusZWyxQpwzVDMc7q5dFbAHfr9iBfFeUxdE8pjXROQfUKszsf7rMsLEffDhomVZ
         0M7Q==
X-Gm-Message-State: AA+aEWYouTfbon7fx0WQeHx0UOF/en6JuU4wXr/nX9Esi0mUPa1/Ob5D
        t4KFEaAZ3FP9quSFjidN9I6KTtA/ni0=
X-Google-Smtp-Source: AFSGD/UnDX38YVgQHt1nUrA2qsJ6OQ34zWViSVIAQY/+3Tl8XGkemiNtfHbE8f5Wbt647Pli3AL06w==
X-Received: by 2002:a5d:970c:: with SMTP id h12mr16911196iol.3.1543250775407;
        Mon, 26 Nov 2018 08:46:15 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:46:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/20] aio: abstract out io_event filler helper
Date:   Mon, 26 Nov 2018 09:45:38 -0700
Message-Id: <20181126164544.5699-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index ba5758c854e8..12859ea1cb64 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1057,6 +1057,15 @@ static inline void iocb_put(struct aio_kiocb *iocb)
 	}
 }
 
+static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
+			   long res, long res2)
+{
+	ev->obj = (u64)(unsigned long)iocb->ki_user_iocb;
+	ev->data = iocb->ki_user_data;
+	ev->res = res;
+	ev->res2 = res2;
+}
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  */
@@ -1084,10 +1093,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	ev_page = kmap_atomic(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 	event = ev_page + pos % AIO_EVENTS_PER_PAGE;
 
-	event->obj = (u64)(unsigned long)iocb->ki_user_iocb;
-	event->data = iocb->ki_user_data;
-	event->res = res;
-	event->res2 = res2;
+	aio_fill_event(event, iocb, res, res2);
 
 	kunmap_atomic(ev_page);
 	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
-- 
2.17.1

