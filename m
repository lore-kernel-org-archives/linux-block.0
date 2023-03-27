Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7B1C77B60
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjC0UN7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjC0UN7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:13:59 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E0B359C
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:10 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id cu4so7692645qvb.3
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679947990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6rad/3rQ5uNwjgAbrRZn8viSEaiHhaJsk57wekX4Yc=;
        b=wVstvHlM3mXjpfnzeRKpiVOg4slUAX7toeFE8xNnbrThgO9z5p9BIfLNafqKCmv4fB
         B4mT3lm/qZU9ouwApFL7H5+VoNM3Ymh81+dis1/fG6bAOi6qm6nGH9izCn+OSzDtS/C9
         gWe4wxvNQmkU54rGwkoljPll6hub/WQ8L4xwIoMYToTAJxBLRD+MaU8atsN0Cc5k13Q7
         10gcdGgezTLFg8rrVLzxwFGH6buFOCdu/8OasZN/BrGPXg09OKXzkkjEZxomPSiiCAXj
         El4QXpaQ8mUCoa5P+ZBv/TNVowyT2BYpftvOlNx7A2xf3NNDH5y2Zla3qmRkTGdRrz0o
         QkLA==
X-Gm-Message-State: AAQBX9c2UPS8f/8f8JxUnGb1DTBGOAyDXI5pdQBt6TosWe2i/E/XMtZI
        BmaxjZtkSfpJRLAHCQzKkFmQ
X-Google-Smtp-Source: AKy350aGPv+m7+Nvtksg720HQ297PPqoxtEn/b3IGQEXHEExxXsRvNIRRAb6T0t3WIyj8iHk9azUFg==
X-Received: by 2002:a05:6214:b64:b0:5b8:1f61:a20 with SMTP id ey4-20020a0562140b6400b005b81f610a20mr25404563qvb.35.1679947989792;
        Mon, 27 Mar 2023 13:13:09 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id f16-20020ac86ed0000000b003e390b48958sm4723408qtv.55.2023.03.27.13.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:09 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 02/20] dm bufio: use WARN_ON in dm_bufio_client_destroy and dm_bufio_exit
Date:   Mon, 27 Mar 2023 16:11:25 -0400
Message-Id: <20230327201143.51026-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Using BUG_ON when tearing down is excessive. Relax these to WARN_ONs.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 79434b38f368..dac9f1f84c34 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1828,8 +1828,8 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
 
 	mutex_unlock(&dm_bufio_clients_lock);
 
-	BUG_ON(!RB_EMPTY_ROOT(&c->buffer_tree));
-	BUG_ON(c->need_reserved_buffers);
+	WARN_ON(!RB_EMPTY_ROOT(&c->buffer_tree));
+	WARN_ON(c->need_reserved_buffers);
 
 	while (!list_empty(&c->reserved_buffers)) {
 		struct dm_buffer *b = list_entry(c->reserved_buffers.next,
@@ -1843,7 +1843,7 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
 			DMERR("leaked buffer count %d: %ld", i, c->n_buffers[i]);
 
 	for (i = 0; i < LIST_SIZE; i++)
-		BUG_ON(c->n_buffers[i]);
+		WARN_ON(c->n_buffers[i]);
 
 	kmem_cache_destroy(c->slab_cache);
 	kmem_cache_destroy(c->slab_buffer);
@@ -2082,7 +2082,7 @@ static void __exit dm_bufio_exit(void)
 		bug = 1;
 	}
 
-	BUG_ON(bug);
+	WARN_ON(bug); /* leaks are not worth crashing the system */
 }
 
 module_init(dm_bufio_init)
-- 
2.40.0

