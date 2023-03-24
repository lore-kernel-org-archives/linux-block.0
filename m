Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F26C6FD20
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 18:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCXSAE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjCXR7o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 13:59:44 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB4623137
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:58:11 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id cu4so2177243qvb.3
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zqo5mDL6nva3zDOWLYglj1LiFa9S7ZuvdxIC0/waJHU=;
        b=nGhEoSOfP+llcZcGEp9AyP3VZbsTTJ36crNgnuMUcCpPzwTwgDUrm9zKjMk2LETIfI
         yoczT8VT2ABE+8SlLCVycuW3n3JKuwJRi2NluTXSHrUQpljZp8+abNDsU8vcyepnmufJ
         Ej2oH76HcXxEBPMjUo8gZSYIS2BMLNM2X2CSvr7JoiZgwEqevLQor2uwIm0qQmtTQy7q
         cztYvDMdfjrMM6K4EIKQ4/3rXDnH3I1AZguqXyPA0dfOFL8WRr+Xga6Xkjb/uCxt912J
         /FUxGCsnT5Wx3ZbJCauCqmMpJXiiT/lNYC8Qci5FH0FKijqBExhL1fIkkADqgKVOpbk/
         px2g==
X-Gm-Message-State: AAQBX9c/j1oGtXWAPOG+kuFbVMv5r9Ew6E+TVD11LipNcLpspyzGnTw+
        TCDzQYlKEufV9kRd/KceRLWD
X-Google-Smtp-Source: AKy350YkDjOVwxQq5CsRXiq/M1DJwMWot5uR1CYpqeERo5DD5gy1/o7k1G+5FpU3S2CJjb8y2fcZ6Q==
X-Received: by 2002:a05:6214:62e:b0:56e:a96a:2bdc with SMTP id a14-20020a056214062e00b0056ea96a2bdcmr4564204qvx.40.1679680627786;
        Fri, 24 Mar 2023 10:57:07 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id kr15-20020a0562142b8f00b005dd8b93456csm843213qvb.4.2023.03.24.10.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:57:07 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, ejt@redhat.com, mpatocka@redhat.com,
        heinzm@redhat.com, nhuck@google.com, ebiggers@kernel.org,
        keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v2 5/9] dm bufio: use waitqueue_active in __free_buffer_wake
Date:   Fri, 24 Mar 2023 13:56:52 -0400
Message-Id: <20230324175656.85082-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324175656.85082-1-snitzer@kernel.org>
References: <20230324175656.85082-1-snitzer@kernel.org>
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
index 929685011e02..b638ddd161b4 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1669,7 +1669,12 @@ static void __free_buffer_wake(struct dm_buffer *b)
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

