Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1A1C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 02:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA82F60F92
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 02:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242967AbhH0CXi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 22:23:38 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:38841 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbhH0CX3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 22:23:29 -0400
Received: by mail-pf1-f180.google.com with SMTP id a21so4398185pfh.5
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 19:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4U4flyACKgZlu8CovgHCWn5oQfGf8JWy5/o78NqD2x4=;
        b=ggiFtPB4vZOeWDvwO151dQY+5cz6rFJRXRiEDlyFTP2gqoI1ceifU5YhGo1CwUgoyY
         WmH0TRjm26cQJPSIT+Kr6HvXyoLulsi3uNZy4PpziFi9Xwyi4GMXAgtzm/a9Pm5BB/L3
         zWHcwg54UCE52JzGF4APAbibvPAbZdHS4uVbIkOQRYaj5cQPh/DgpzlKM2dhx3k5Epir
         xq3Jut3LkGQ/VsQ+AKTsjdpLUJGf7XHe0oaSxx8pMy+cKBpWmNoTJKyRjn9ax1SUBjM5
         GgMDFleKNdKyU/RzFw5tNUhzQsJIVPZc/CsrvKC/N6/VUZk0vgUut21lsCsYxliWP5xY
         hmkQ==
X-Gm-Message-State: AOAM533NXuE7jhvkI+1hb4SHvMiP3nuhgOvhEzfiWFih1RBkVcrQC1nu
        tvQGMJqzUHCZQrMkL7W2wwI=
X-Google-Smtp-Source: ABdhPJzo9okpRck3dkxDResb3ytqA67UOqAebZmFicN0nIqKa4jZDh8VUKDAdyfosvx51md+s/JF0A==
X-Received: by 2002:a63:4614:: with SMTP id t20mr5928353pga.372.1630030961142;
        Thu, 26 Aug 2021 19:22:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:4949:2f:2d87:ed91? ([2601:647:4000:d7:4949:2f:2d87:ed91])
        by smtp.gmail.com with ESMTPSA id q26sm4270461pff.174.2021.08.26.19.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 19:22:40 -0700 (PDT)
Subject: Re: [PATCH] mq-deadline: Fix request accounting
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210824170520.1659173-1-bvanassche@acm.org>
 <YSVmEWtARsGyrEW2@x1-carbon>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <18594aff-4a94-8a48-334c-f21ae32120c6@acm.org>
Date:   Thu, 26 Aug 2021 19:22:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSVmEWtARsGyrEW2@x1-carbon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/21 2:35 PM, Niklas Cassel wrote:
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> Tested-by: Niklas Cassel <niklas.cassel@wdc.com>

Hi Niklas,

Thank you for the help, that's really appreciated. Earlier today I discovered
that this patch does not handle requeuing correctly so I have started testing
the patch below.

---
 block/mq-deadline.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index dbd74bae9f11..c4c3c2e3f446 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -712,7 +712,10 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	blk_req_zone_write_unlock(rq);

 	prio = ioprio_class_to_prio[ioprio_class];
-	dd_count(dd, inserted, prio);
+	if (!rq->elv.priv[0]) {
+		dd_count(dd, inserted, prio);
+		rq->elv.priv[0] = (void *)(uintptr_t)1;
+	}

 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
 		blk_mq_free_requests(&free);
@@ -761,12 +764,10 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 	spin_unlock(&dd->lock);
 }

-/*
- * Nothing to do here. This is defined only to ensure that .finish_request
- * method is called upon request completion.
- */
+/* Callback from inside blk_mq_rq_ctx_init(). */
 static void dd_prepare_request(struct request *rq)
 {
+	rq->elv.priv[0] = NULL;
 }

 /*
@@ -793,6 +794,14 @@ static void dd_finish_request(struct request *rq)
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];

+	/*
+	 * The block layer core may call dd_finish_request() without having
+	 * called dd_insert_requests(). Skip requests that bypassed I/O
+	 * scheduling. See also blk_mq_request_bypass_insert().
+	 */
+	if (!rq->elv.priv[0])
+		return;
+
 	dd_count(dd, completed, prio);

 	if (blk_queue_is_zoned(q)) {
