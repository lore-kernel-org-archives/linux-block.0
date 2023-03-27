Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29C3C76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjC0UOD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjC0UOC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:02 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62021FE9
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:13 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id cr18so5981373qtb.0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679947993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmqlLAmAcoDYlM73GWg+waCa1PP8Bn6cws6QITx68xo=;
        b=ScCmgyHA2M/AS8xpVObhUJXpXwjXBbm4S5OJaXCOvvcRwiiKMFOZxhJ+mVvGQLIyMR
         vkM0RxyZRY4+1gVW4OzY6SysNkU0pRpcVj2tV6VSzb3Sx9mmPKq9XYu7UUoC+BgQVI36
         pgZM67ei1Hr9OtFgtGOktYOIFNPx/uolhIs5LXzT2wAiyUAlxXe6JCJS79XWw8h+ZCCh
         TT7rtuGKf+vsc2J3dBKDnf/N/4MPfX2kBflakgThAb5kkxFjVro24rjD5nSse0mx2vl0
         rsAspN8/CsJ/qxkI3lDjFk9k7/2Mr3VWXxv/wsQGQo/zq7AxOLBeeWCyG+2hNeQfFIvX
         vmJg==
X-Gm-Message-State: AAQBX9dZUOlRgPDeWbB5dT5T93dBulf+BtcIqlAJkxGdKxOqoAGJCOlp
        bDCMHmCIDSvdsDXC2UiCeoZib5aLh5uYVJfv7RGT
X-Google-Smtp-Source: AKy350b9yynzcGT7R923zG1Nqhk3Mn4VUNQG7FVDF/2AYEYBKvcrKmzGtyrZXsaF2wG0qO6dp7ngxQ==
X-Received: by 2002:a05:622a:1002:b0:3e4:dbfa:ee2b with SMTP id d2-20020a05622a100200b003e4dbfaee2bmr15465044qte.17.1679947992941;
        Mon, 27 Mar 2023 13:13:12 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id 141-20020a370793000000b0074672975d5csm12784571qkh.91.2023.03.27.13.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:12 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 04/20] dm bufio: don't bug for clear developer oversight
Date:   Mon, 27 Mar 2023 16:11:27 -0400
Message-Id: <20230327201143.51026-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reasonable to relax to WARN_ON because these are easily avoided but do
offer some assurance future coding mistakes won't occur (if changes
tested properly).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index d63f94ab1d9f..64fb5fd39bd9 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -378,8 +378,10 @@ static void adjust_total_allocated(struct dm_buffer *b, bool unlink)
  */
 static void __cache_size_refresh(void)
 {
-	BUG_ON(!mutex_is_locked(&dm_bufio_clients_lock));
-	BUG_ON(dm_bufio_client_count < 0);
+	if (WARN_ON(!mutex_is_locked(&dm_bufio_clients_lock)))
+		return;
+	if (WARN_ON(dm_bufio_client_count < 0))
+		return;
 
 	dm_bufio_cache_size_latch = READ_ONCE(dm_bufio_cache_size);
 
@@ -1536,7 +1538,8 @@ static void drop_buffers(struct dm_bufio_client *c)
 	int i;
 	bool warned = false;
 
-	BUG_ON(dm_bufio_in_request());
+	if (WARN_ON(dm_bufio_in_request()))
+		return; /* should never happen */
 
 	/*
 	 * An optimization so that the buffers are not written one-by-one.
@@ -1556,7 +1559,7 @@ static void drop_buffers(struct dm_bufio_client *c)
 			      (unsigned long long)b->block, b->hold_count, i);
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 			stack_trace_print(b->stack_entries, b->stack_len, 1);
-			/* mark unclaimed to avoid BUG_ON below */
+			/* mark unclaimed to avoid WARN_ON below */
 			b->hold_count = 0;
 #endif
 		}
@@ -1567,7 +1570,7 @@ static void drop_buffers(struct dm_bufio_client *c)
 #endif
 
 	for (i = 0; i < LIST_SIZE; i++)
-		BUG_ON(!list_empty(&c->lru[i]));
+		WARN_ON(!list_empty(&c->lru[i]));
 
 	dm_bufio_unlock(c);
 }
-- 
2.40.0

