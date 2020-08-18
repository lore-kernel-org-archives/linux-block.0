Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E09BC433E1
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 06:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682B420639
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 06:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sB3c89ME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgHRGuA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRGuA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 02:50:00 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9685C061389;
        Mon, 17 Aug 2020 23:49:59 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cs12so9066551qvb.2;
        Mon, 17 Aug 2020 23:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+uWNSSjfEEPF2N6+QLJYLMqb6RlZPSAgW0i5xtsCXU=;
        b=sB3c89MEcatZ8Ak0D/Sgweg8Ve+XXVDXoTkdk3tHQBZ3ChicLRVMetA8VSVC++k+tk
         1ZUYNut7Be9Yb92g+i08jBItoEDckQHf83eu8WPD1oZUVTdAmWueX7QS83CxK2Q8BpCV
         MeyVbLXesN89IaosAoFeeAUNhShPQNHbQYBJnNAIikhSnYE2ub315/GfJi/oRnbhTGV3
         L3pkj/hbNLIBIuH/lSdpqJJ5qFq911/5gft9CkXFCbKIkioJ5Kzp0eVs8tXjo2vqLGFI
         NoCzoJCynoyBUl8KIHtIqDWDw8aW/qxWb5ZXHJOppSnVvKEMQdCwrYIhHszj4JGvAVUx
         v7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+uWNSSjfEEPF2N6+QLJYLMqb6RlZPSAgW0i5xtsCXU=;
        b=r6j0ZJvGfAZBgxx+8QUNcLx7Ra3YMJt80/RrPNeNiYS82/a1LR4zZY7q0mTT1yViTY
         gluz7G+QZQ8QwUGS4YNEn+Wzz+C1W8MGMIgQE9W42Uf1UlEi/oB+TogMuzkjExEJQysX
         1yBKcOq/H2XtAMUbrq5A5nm+bmkpCsrq0E9TwhUkgAhEupLJ9azs3uNt7raXjdAvTYDo
         fd2AQJTlHMq/49BkQHGSgq9yAF7ipLP83+FzaFKY5rliTG80e15Moe8F8M2OdaTROrms
         S9u0UKCY181+lo9bepdmJ+EKoAtS05S36gAxYjIDYXJlZ/pn54CGgM0Eu5tZYqCa2KFh
         K8ww==
X-Gm-Message-State: AOAM531DFFTO1OeKQMKcjgjvs1YWpPaGXVjfOh5PduNlBkNuE0p31uQA
        CcKdPjuCmTlIN46X4M/XIvccHlGyICox8K2q
X-Google-Smtp-Source: ABdhPJwFZooO0evVBMH+uwVVRFlmjASkVvrH7K3a+veyT4SrylB4nyAH9GNpcq7A89mCwslT38pXPg==
X-Received: by 2002:ad4:4908:: with SMTP id bh8mr18260285qvb.218.1597733398996;
        Mon, 17 Aug 2020 23:49:58 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id d26sm23367032qtc.51.2020.08.17.23.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 23:49:58 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Brooke Basile <brookebasile@gmail.com>
Subject: [PATCH] block/rnbd: Ensure err is always initialized in process_rdma
Date:   Mon, 17 Aug 2020 23:49:25 -0700
Message-Id: <20200818064924.3984068-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CAMGffE=2m7XOdKS9xG1bNY7MYR2x6AgQm9YZFHm6D4biO860sw@mail.gmail.com>
References: <CAMGffE=2m7XOdKS9xG1bNY7MYR2x6AgQm9YZFHm6D4biO860sw@mail.gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Clang warns:

drivers/block/rnbd/rnbd-srv.c:150:6: warning: variable 'err' is used
uninitialized whenever 'if' condition is true
[-Wsometimes-uninitialized]
        if (IS_ERR(bio)) {
            ^~~~~~~~~~~
drivers/block/rnbd/rnbd-srv.c:177:9: note: uninitialized use occurs here
        return err;
               ^~~
drivers/block/rnbd/rnbd-srv.c:150:2: note: remove the 'if' if its
condition is always false
        if (IS_ERR(bio)) {
        ^~~~~~~~~~~~~~~~~~
drivers/block/rnbd/rnbd-srv.c:126:9: note: initialize the variable 'err'
to silence this warning
        int err;
               ^
                = 0
1 warning generated.

err is indeed uninitialized when this statement is taken. Ensure that it
is assigned the error value of bio before jumping to the error handling
label.

Fixes: 735d77d4fd28 ("rnbd: remove rnbd_dev_submit_io")
Link: https://github.com/ClangBuiltLinux/linux/issues/1134
Reported-by: Brooke Basile <brookebasile@gmail.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/block/rnbd/rnbd-srv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 0fb94843a495..1b71cb2a885d 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -148,7 +148,8 @@ static int process_rdma(struct rtrs_srv *sess,
 	/* Generate bio with pages pointing to the rdma buffer */
 	bio = rnbd_bio_map_kern(data, sess_dev->rnbd_dev->ibd_bio_set, datalen, GFP_KERNEL);
 	if (IS_ERR(bio)) {
-		rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", PTR_ERR(bio));
+		err = PTR_ERR(bio);
+		rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", err);
 		goto sess_dev_put;
 	}
 
-- 
2.28.0

