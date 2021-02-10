Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B335CC433E6
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 15:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764C764DE1
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 15:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhBJPiZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:38:25 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:45870 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhBJPiV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 10:38:21 -0500
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D30FD983220;
        Wed, 10 Feb 2021 16:37:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1612971458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ztM47SWFgv+hKg/NIGl3WD1OYgEOYWgwUcs7WbDNz7s=;
        b=cwAmA4pK/5aTcdGwWMVT17brIeyxzM8uEu1doKiebNa3MuM/4zbxVHn94WRrcXHMVQO1g1
        unAl513N9DbYcqVTE06c/8Zmd+Sw4E8mAnvrZJ3JknwzZu1ecFn8LvN16rBn1Di1w4BNU0
        rB11IH6kZS6N5OEuNHWK3b8HzLAl0lU=
Date:   Wed, 10 Feb 2021 16:37:38 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Chunguang Xu <brookxu.cn@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bfq: amend the function name of
 bfq_may_expire_for_budg_timeout()
Message-ID: <20210210153738.pdsiqnmucq5v5cck@spock.localdomain>
References: <1611917485-584-1-git-send-email-brookxu@tencent.com>
 <1611917485-584-2-git-send-email-brookxu@tencent.com>
 <0A676DC9-E730-460A-8C39-9E1851343339@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0A676DC9-E730-460A-8C39-9E1851343339@linaro.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 10, 2021 at 12:13:59PM +0100, Paolo Valente wrote:
> 
> 
> > Il giorno 29 gen 2021, alle ore 11:51, Chunguang Xu <brookxu.cn@gmail.com> ha scritto:
> > 
> > From: Chunguang Xu <brookxu@tencent.com>
> > 
> > The function name bfq_may_expire_for_budg_timeout() may be misspelled,
> > try to fix it.
> > 
> 
> Ok for me to make this name longer.
> 
> Thanks,
> Paolo
> 
> > Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> > ---
> > block/bfq-iosched.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > index 9e4eb0f..4f40c61 100644
> > --- a/block/bfq-iosched.c
> > +++ b/block/bfq-iosched.c
> > @@ -4061,7 +4061,7 @@ static bool bfq_bfqq_budget_timeout(struct bfq_queue *bfqq)
> >  * condition does not hold, or if the queue is slow enough to deserve
> >  * only to be kicked off for preserving a high throughput.
> >  */
> > -static bool bfq_may_expire_for_budg_timeout(struct bfq_queue *bfqq)
> > +static bool bfq_may_expire_for_budget_timeout(struct bfq_queue *bfqq)
> > {
> > 	bfq_log_bfqq(bfqq->bfqd, bfqq,
> > 		"may_budget_timeout: wait_request %d left %d timeout %d",
> > @@ -4350,7 +4350,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
> > 	 * on the case where bfq_bfqq_must_idle() returns true, in
> > 	 * bfq_completed_request().
> > 	 */
> > -	if (bfq_may_expire_for_budg_timeout(bfqq) &&
> > +	if (bfq_may_expire_for_budget_timeout(bfqq) &&
> > 	    !bfq_bfqq_must_idle(bfqq))
> > 		goto expire;
> > 
> > @@ -5706,7 +5706,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
> > 			 * of its reserved service guarantees.
> > 			 */
> > 			return;
> > -		} else if (bfq_may_expire_for_budg_timeout(bfqq))
> > +		} else if (bfq_may_expire_for_budget_timeout(bfqq))
> > 			bfq_bfqq_expire(bfqd, bfqq, false,
> > 					BFQQE_BUDGET_TIMEOUT);
> > 		else if (RB_EMPTY_ROOT(&bfqq->sort_list) &&
> > -- 
> > 1.8.3.1
> > 
> 

Was this sent to some mailing list? I don't see an original email with
this patch.

-- 
  Oleksandr Natalenko (post-factum)
