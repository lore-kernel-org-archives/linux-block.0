Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925AAC64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5579020892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Er+hb6Yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5579020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbeLGWUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:20:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36008 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLGWUq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so2577920pfc.3
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L8yxXuFlKRVZGhU6vByhKAQcKxwaMq31dRwuK5kkt+A=;
        b=Er+hb6Yq8/TZJYcriPO+ne2CT5MTRyzMeNe/cnfSi9cafGzEqBVKW/MnUcyOArxdtU
         OdIAEorCKNtv/3lBtMLONpXbljeVjwseXMlsnUdBqxLeTEEsYZam4GwKeZoL786ZIeSN
         af/FwHXiasB1Qyo1FN/pg/se0xIg9vpLslimDDApRaLuZJJJCgyaRKryOzyybU5hKqsN
         7B83HvNC6kR5WoMOpugnJUFUpt8wz3QyWfgSip1/QpxZUULcBbXhn1drs8chBJnIRH1D
         m6HoJ9XqXy3p6yELMg1ahWKdk5DG2mDR6gdMQAWgyB0RjIXfyrDxic8oKp1NgHgrWwRr
         8P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L8yxXuFlKRVZGhU6vByhKAQcKxwaMq31dRwuK5kkt+A=;
        b=dkd+Fp9HSRCUgqaPIm73FVUUo6lAmLZzSitRBYGLxFWPffKzr11Q0kgr+Qz46o3ZVI
         VBrunHncsbHWtz22ocAKO3IuPTzUiufS33ZKDyUtf9rH5vcSmaIy7prbDgEnqQSkxgCL
         36rLz3XsZ8hNPiWAJCU5mHDwf/kiv2JUrbfNhxGdQvZip6NnujTw8KjgGxPINmbsKXbR
         U8D1mR+yxG+okgdVkjKWRDa1d06I+vQ2emYe3J4nRkaSgfpG1x8YgrJebrb+x12hSkwv
         TiFsE++IDHYQo3sKRACHgH5DI78vxE9hOtKOzoOJOTycdfMxPPEgrcBiU9xd2G+umiRg
         IegA==
X-Gm-Message-State: AA+aEWb5ljRhOOMhCVwsaAXxvvR/VsBFviPl9iQOKJpOz6AdEkpueVQJ
        4/Ibwv/YQqxAAxhP7ISLkU8/VpU+04s=
X-Google-Smtp-Source: AFSGD/UTY46d36ukrZ4o4YP08pwTLo3oBl7YQ7lg/oo5PzxRdBf9yKwn299K7iekdPC6G9nBHy8kEA==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr3921641pfh.151.1544221245263;
        Fri, 07 Dec 2018 14:20:45 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/26] aio: abstract out io_event filler helper
Date:   Fri,  7 Dec 2018 15:20:02 -0700
Message-Id: <20181207222016.29387-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 06c8bcc72496..173f1f79dc8f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1063,6 +1063,15 @@ static inline void iocb_put(struct aio_kiocb *iocb)
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
@@ -1090,10 +1099,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
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

