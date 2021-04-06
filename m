Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09413C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80DD613BC
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244155AbhDFHHc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbhDFHHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30524C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h10so15176411edt.13
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+pSKG5MeazyVQaTM4wjfbORD6labF71XC9KX+IrgJ8=;
        b=bdZbLthootjqO5AA271H3cqOI/4UBsiIM2Csmkc+Dj6Fuqi0r0SvOEp6myS3tGOke2
         YK+o6zCapleg+DPUdPposPN9bP4RFGJhYYj1QArb51S+2nGEWu4vpOIGJpBhLQWONSfE
         3W43RSN8C2Gnyh5bbf9Uwt0qSg0ljEZEf0RuSG/2AfzyzK9ymS0uscCtaB0be5DpFc3p
         1WXhetnMtIKjwitcqzfif280hlEkSNvbkgVdZhGxWEschcNNBqob6kyR2/CygdhjOaFf
         Z17d61a0c3F8SgczctJHabIbRykihDn0yzbEWecZyNTQ/XN8BXzI7XRtDsW2knb3HMem
         Qprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+pSKG5MeazyVQaTM4wjfbORD6labF71XC9KX+IrgJ8=;
        b=E/wuaOpVcwL6i7VxTnsxjJSjMdSi9n9OfZ1PNWV1jB3BS19zIPfZ2I818IqRgdlAF5
         54HYSgNZziNekB+aTkhnBMMRbhc4t4wudzjpvOpKReO59gSHr0hXoMkc8pla9Ktnx+ps
         uGGjpbPSQijvOpu1m7L+MgSCr8v4VhaO7Rg4nIST2l/xbJdsWWA8+zm6CerHbNojYryH
         gqgEOGliOxMe3zZ8OB5HQLpkm5k2sJhVXyUp9Q+c/JAmm3H2UbR8va68kura01/h0Oq4
         ClzuoulhAxmI2juKjYhVxRKkY1wRrCRJRBEZvMmhmlLQE5So7y923ReWNQ8RJzZAnAFS
         LMhg==
X-Gm-Message-State: AOAM53079u5vZJRrICwSIku+5aqpAfva/Q5e3nY071Lem7nrJ0PuTXxW
        uIeT5XZvqgMCoUoqnyJQZAfxPE5nkN9QIw==
X-Google-Smtp-Source: ABdhPJxjVtgMbsmRf2HTqiJTFrJ1NT17FLSd8KkMeGZZ3HVN+31Ulw7m0+0QOHmpwUKsYfUsxPwFOg==
X-Received: by 2002:aa7:c3c1:: with SMTP id l1mr36565024edr.208.1617692842911;
        Tue, 06 Apr 2021 00:07:22 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:22 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv3 for-next 04/19] block/rnbd-clt: Remove some arguments from rnbd_client_setup_device
Date:   Tue,  6 Apr 2021 09:07:01 +0200
Message-Id: <20210406070716.168541-5-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@gmx.com>

Remove them since both sess and idx can be dereferenced from dev. And
sess is not used in the function.

Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>
Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 5a5c8dea38dc..ecb83c10013d 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1354,10 +1354,9 @@ static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, dev->queue);
 }
 
-static int rnbd_client_setup_device(struct rnbd_clt_session *sess,
-				     struct rnbd_clt_dev *dev, int idx)
+static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
 {
-	int err;
+	int err, idx = dev->clt_device_id;
 
 	dev->size = dev->nsectors * dev->logical_block_size;
 
@@ -1535,7 +1534,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	mutex_lock(&dev->lock);
 	pr_debug("Opened remote device: session=%s, path='%s'\n",
 		 sess->sessname, pathname);
-	ret = rnbd_client_setup_device(sess, dev, dev->clt_device_id);
+	ret = rnbd_client_setup_device(dev);
 	if (ret) {
 		rnbd_clt_err(dev,
 			      "map_device: Failed to configure device, err: %d\n",
-- 
2.25.1

