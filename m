Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA3C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C007220850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="I0fiKTp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C007220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbeLDXiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41256 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbeLDXiE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so9065312plm.8
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L8yxXuFlKRVZGhU6vByhKAQcKxwaMq31dRwuK5kkt+A=;
        b=I0fiKTp97lWAptjPCAJ8bghiFPuKgt5x2fcBaV7748QwKc7zzf4m4DfGDe942PAQic
         zBBx1+lC5KaXPKmpoOdHPxTW9utb1ekRhc9z89V0DYtU71ZX4Ps8HASp1uAI15onLctU
         QyJ5hIkTzm8t4ZZ4q7p0aYpa+yjpSq54ovVx1/X0mUyVpUIlwPE7XpPfV17gavUEUAX2
         wpuUO1RSmxyj30V0Idkzk7Osz4hvVoRXGOajE08JYmUYxRCX6RvqpOAIgfviMS8Wp5UZ
         58QjIGEIOgpq9LkKn5iwLKfFl1G2hOiLxrT8J2k2iKlZNsZIH6bWwe574r292S0UJ/Gj
         5P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L8yxXuFlKRVZGhU6vByhKAQcKxwaMq31dRwuK5kkt+A=;
        b=RRAkOuxOpdnYemhAiz4fywaM4GladzxHw0YQXyAOudGND9Skr4Gghqi0JdYb69SD9M
         J58V7A40Ec8dgMVp1z5HqNqgEQos3j+ky4CCL3XVPSmWodLijnwGQD1qSDr8uHmB6fgV
         AlxVhKLJSr5csS93wDD3KRlMrWCXeDTUcAdAQbc9kW65p1cfsWK8WGY8VcBzETui600N
         1HnjSp6ihbkN3WQprKKR15s7+jB48VzSXmuT8Il0QCsFU4BxWPaXp2sD3f6NYa5m8gHw
         PPbv8U9qTw8FLtcQ5z5HMQ1o07pg4ZCIfhsGPG+SxWE4aQNaY4oV/n0PhaBOhNqR/qvO
         t2Ag==
X-Gm-Message-State: AA+aEWYCHKr354p934hwOxS2CzcdnWqLHfHC+4YulLJkAwaBtEQJQn7Z
        sBVTjc6E2b1QFTVap10HdKPWU0m+8y0=
X-Google-Smtp-Source: AFSGD/VnjMZuzmOf/CuJrjb3quTvbHG8WmRQRAYgkuLMvn4Hf7iAjytZlj5cSIt4aZIq1aXjBKGoXA==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3mr12422871plq.117.1543966683426;
        Tue, 04 Dec 2018 15:38:03 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:38:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/26] aio: abstract out io_event filler helper
Date:   Tue,  4 Dec 2018 16:37:15 -0700
Message-Id: <20181204233729.26776-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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

