Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D7CC761A6
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjC0UOO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjC0UOK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:10 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4F61BFB
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:23 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id s12so6188935qtx.11
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8N6ipnCV5hoHhg/CORvER6nf9MSwcb0kouKMhOxJx4=;
        b=nAU6YSBQ7rhroO43s5qQXgewW+numV/72F5Clec5PdwRG5bMYR1nnyCvKKsaa/NQQb
         zMdVv55mwsm8cGV+s0PNRMjq05tB8oi9oIdIKg08t7G03h/SRgH1pbH4nlzpKdTGIVUE
         g7oBCI/f+z4xFPkgUyxOV430XpfoMFnLNfn6DaLcArIuN47NTjxdPdIBtCwaHrCU8eHn
         2v7PUKjYWWlw3x8EoSZ+tAyz8qMvPv1dsVVvGDNH4n05S0STYYKPueuZgQb2hykbXCNq
         2A6t8SjD1TP0ZhbwJNknCp3IFJAxJwv9z9Hbt0ci9/ffpzzIQLIoQwKcUWOEWlTG14s5
         nAUQ==
X-Gm-Message-State: AO0yUKV1VzXuzfOcgxZ/pQFHVJ88URXQEgZtSBmr18n+4UcrMusTucks
        vTiGkx2uWgSGUex1pEcENo6P
X-Google-Smtp-Source: AK7set9+sfwAJb0hRAS53hihYhDVSWnGpR49MCgCFLmIkZazfZgDsImOqvtZXurStI3emQaDQ0Dvkw==
X-Received: by 2002:a05:622a:1315:b0:3d5:500a:4819 with SMTP id v21-20020a05622a131500b003d5500a4819mr22550964qtk.23.1679948003245;
        Mon, 27 Mar 2023 13:13:23 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id y126-20020a376484000000b007468765b411sm11876942qkb.45.2023.03.27.13.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:22 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 10/20] dm bufio: use waitqueue_active in __free_buffer_wake
Date:   Mon, 27 Mar 2023 16:11:33 -0400
Message-Id: <20230327201143.51026-11-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

Save one spinlock by using waitqueue_active. We hold the bufio lock at
this place, so no one can add entries to the waitqueue at this point.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index e5459741335d..cca43ed13fd1 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1665,7 +1665,12 @@ static void __free_buffer_wake(struct dm_buffer *b)
 		c->need_reserved_buffers--;
 	}
 
-	wake_up(&c->free_buffer_wait);
+	/*
+	 * We hold the bufio lock here, so no one can add entries to the
+	 * wait queue anyway.
+	 */
+	if (unlikely(waitqueue_active(&c->free_buffer_wait)))
+		wake_up(&c->free_buffer_wait);
 }
 
 static enum evict_result cleaned(struct dm_buffer *b, void *context)
-- 
2.40.0

