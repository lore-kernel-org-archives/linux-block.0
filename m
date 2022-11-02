Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB66C4321E
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 15:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKBPUU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiKBPTr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 11:19:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F80228719
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 08:19:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id y16so25013154wrt.12
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYX5VxLpbP1y6B9vClLwT36AajgL5l3hqA33mKwDa80=;
        b=Dyvhz/y6n4d8Ycbw/UyTmAyy/UB2ocHmfyo0fIzIwDnsvcEgdEhOUorn0ggeI0ToxS
         lMKqE+B4+VvFq6OzO3P91IZ9yW2n1g6f/KFW5Y8eyi+yUklJmmXsqiso1IdxsARE3QAJ
         QmswKil8IZ6AKAHgh28e4ZAkyhmr+lrLnL7OVfeZhVVfmupi7Oae/Tm5298Xa9k1yaeD
         UEeMh0HFdvAFWmNGcf5dg50LA8dplZR+YVLIZe242JN/sGOiUsHvfah08bzMSObvFHuc
         FR6elDM/lYaIiU36+FwWq+5AwH3X/vXDgP9FTZBRxx+lXF3wnS8JE+RarirVnqtmlcz1
         ClXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYX5VxLpbP1y6B9vClLwT36AajgL5l3hqA33mKwDa80=;
        b=ASI1Tyl4Xlc9PjkD0Kk47xhOQZSDws46jjnYWgcxBW+7UHjZyD0JDRk/OkgsJDMoSo
         piMqcdbbWwB/oqnlwF1Rhe3IjbOIXyqbFOGGLV2SrY9Sj1WMYbLv0zg/KJo9Ueqg40VP
         PeaX0PPq2JmqoDAYsUCuvY7tEc92wl7yztoP2k+dioWccKe//5F6DUroXwu6xNd0Jmln
         a92p8tK+x0wFAFpKRO2zyIxa0MWwp/1PkuClC83ou5+TroYbRuWS7TYKbA5WlbotQjww
         pomcy1Xj+lRIIx2P5eHtjGtrfgDQeiGsgAckLE4zxFpR2Isit7uDWmZmbG0esC1lc+bO
         gdDw==
X-Gm-Message-State: ACrzQf2DOhpLW8SRgqOulqj+BhVfts+TGDTqq2CZCs9msIlOermqstlk
        9fJIHiL27o1nCToLUzScjuNoSVK3BeE=
X-Google-Smtp-Source: AMsMyM5BSSsNeoQSsriMoKxz+H2CiX+1AiBmPZbQ1SMx2gUn7/uFGk/0UpAtTq8t9Gtr4s5ohHuc+Q==
X-Received: by 2002:a05:6000:10a:b0:236:6a79:f5cf with SMTP id o10-20020a056000010a00b002366a79f5cfmr15066385wrx.470.1667402384629;
        Wed, 02 Nov 2022 08:19:44 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.186.241])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0022e66749437sm13043232wrq.93.2022.11.02.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:19:44 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-next v4 6/6] io_uring/rw: enable bio caches for IRQ rw
Date:   Wed,  2 Nov 2022 15:18:24 +0000
Message-Id: <fb8bd092ed5a4a3b037e84e4777074d07aa5639a.1667384020.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1667384020.git.asml.silence@gmail.com>
References: <cover.1667384020.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now we can use IOCB_ALLOC_CACHE not only for iopoll'ed reads/write but
also for normal IRQ driven I/O.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index bb47cc4da713..5c91cc80b348 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -665,6 +665,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
 	ret = kiocb_set_rw_flags(kiocb, rw->flags);
 	if (unlikely(ret))
 		return ret;
+	kiocb->ki_flags |= IOCB_ALLOC_CACHE;
 
 	/*
 	 * If the file is marked O_NONBLOCK, still allow retry for it if it
@@ -680,7 +681,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
 			return -EOPNOTSUPP;
 
 		kiocb->private = NULL;
-		kiocb->ki_flags |= IOCB_HIPRI | IOCB_ALLOC_CACHE;
+		kiocb->ki_flags |= IOCB_HIPRI;
 		kiocb->ki_complete = io_complete_rw_iopoll;
 		req->iopoll_completed = 0;
 	} else {
-- 
2.38.0

