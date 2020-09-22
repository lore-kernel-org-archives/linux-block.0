Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F2AC4346E
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E14521D91
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ/J74mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgIVCc5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 22:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgIVCc5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 22:32:57 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEFEC061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:32:57 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g72so17577317qke.8
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bWaXIov8TtAl/0XsAvHxYfnPFbq37XOvCLuYhpc0zL0=;
        b=KQ/J74mqJZmGoH1fobR6T1qCrxdGhSWMn1sKtfCwg5//U5YamDPraAjCc+zWeVyyPf
         5pqA4MIH0X5ZqUKRkcBsQaY+ZHbS35/6zVCGui6fWPOrtaKvUkCbRxxFl0n3vMYeN4un
         QSPdxS0bd9H/rMm2Z01biPpDs4So8gnN2o2LVHUDMSpXaaj/BjtnY/VfTYzZzIzAqVXl
         5QL93DGFqaLOVILjy9hDGzFHIvEmxQLizngOLwCcXmpmi6hJ/nxFFVK3zDijvk/AGPy7
         BQculOdzL2vTlBZjV0xUFN/i6Ce4fnRjKChVJ+0ACJ/vIpm6mHQix+4N4UYFrdNRUMHW
         q9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=bWaXIov8TtAl/0XsAvHxYfnPFbq37XOvCLuYhpc0zL0=;
        b=GRA9Oasru/C7PcIrbZ4cX9QLBAPW4gI/eNQkxSup3HTKGXR9Vi0POBI7RWbJrg4U9l
         fUATE+UD1Np5JQarSuEa1OodHYqByVTJk4PnJ/hjd06dY1EtuKk3jg+X5U7HJnwsSKmQ
         /QQy4dvNxOnWPeu9piwFAlN/WZrPHtyd2c9aUyy0HmlHiSoGZT5BoRjgy29+vZeDY+bF
         Qqy6tR9dRL827woU5xZIrKptZROXwbeK8IjhHVclPXFb0f7RAf3/XGmOlv9iOln6dxPo
         qJBIQuXPzEt3JEws+D0Sai8GBLBQ34HJeIT09WuGdD4WTyg8Gpjr0XWK7jk8jjCizJcp
         EJQg==
X-Gm-Message-State: AOAM531Ie2f9PC1KZGG9agT1cRIKAuIBeOl0IVswCugQ9cKgunIwdG11
        TfM+QVA/GTx0GGbxjFPAh3c=
X-Google-Smtp-Source: ABdhPJy6JO/cMS6eyzyES62A6ssN7ZfRrD419Tdfay1OexLN53AAgSYU1/Gv5s6SDuBxiWcxprI+gQ==
X-Received: by 2002:a37:c09:: with SMTP id 9mr2892321qkm.471.1600741976270;
        Mon, 21 Sep 2020 19:32:56 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id m6sm10685774qkh.106.2020.09.21.19.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 19:32:55 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v3 2/6] dm: fix comment in dm_process_bio()
Date:   Mon, 21 Sep 2020 22:32:47 -0400
Message-Id: <20200922023251.47712-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200922023251.47712-1-snitzer@redhat.com>
References: <20200922023251.47712-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Refer to the correct function (->submit_bio instead of ->queue_bio).
Also, add details about why using blk_queue_split() isn't needed for
dm_wq_work()'s call to dm_process_bio().

Fixes: c62b37d96b6eb ("block: move ->make_request_fn to struct block_device_operations")
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d948cd522431..6ed05ca65a0f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1744,9 +1744,11 @@ static blk_qc_t dm_process_bio(struct mapped_device *md,
 	}
 
 	/*
-	 * If in ->queue_bio we need to use blk_queue_split(), otherwise
+	 * If in ->submit_bio we need to use blk_queue_split(), otherwise
 	 * queue_limits for abnormal requests (e.g. discard, writesame, etc)
 	 * won't be imposed.
+	 * If called from dm_wq_work() for deferred bio processing, bio
+	 * was already handled by following code with previous ->submit_bio.
 	 */
 	if (current->bio_list) {
 		if (is_abnormal_io(bio))
-- 
2.15.0

