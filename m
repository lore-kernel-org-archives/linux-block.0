Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FDDC433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143D961074
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 07:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhETHWy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 03:22:54 -0400
Received: from mail.itouring.de ([85.10.202.141]:58404 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231142AbhETHWy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 03:22:54 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 May 2021 03:22:53 EDT
Received: from tux.applied-asynchrony.com (p5b07e8e5.dip0.t-ipconnect.de [91.7.232.229])
        by mail.itouring.de (Postfix) with ESMTPSA id 10C9FE0;
        Thu, 20 May 2021 09:15:43 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id AA65BF01624;
        Thu, 20 May 2021 09:15:42 +0200 (CEST)
Subject: Re: [PATCH BUGFIX] block, bfq: fix delayed stable merge check
To:     Luca Mariotti <mariottiluca1@hotmail.it>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>
References: <DB8PR01MB59647C41BF6C964467EAFE0D882C9@DB8PR01MB5964.eurprd01.prod.exchangelabs.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <f23f8090-4a55-3c16-1bdd-f86634cd6f3b@applied-asynchrony.com>
Date:   Thu, 20 May 2021 09:15:42 +0200
MIME-Version: 1.0
In-Reply-To: <DB8PR01MB59647C41BF6C964467EAFE0D882C9@DB8PR01MB5964.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-05-18 12:43, Luca Mariotti wrote:
> When attempting to schedule a merge of a given bfq_queue with the currently
> in-service bfq_queue or with a cooperating bfq_queue among the scheduled
> bfq_queues, delayed stable merge is checked for rotational or non-queueing
> devs. For this stable merge to be performed, some conditions must be met.
> If the current bfq_queue underwent some split from some merged bfq_queue,
> one of these conditions is that two hundred milliseconds must elapse from
> split, otherwise this condition is always met.
> 
> Unfortunately, by mistake, time_is_after_jiffies() was written instead of
> time_is_before_jiffies() for this check, verifying that less than two
> hundred milliseconds have elapsed instead of verifying that at least two
> hundred milliseconds have elapsed.
> 
> Fix this issue by replacing time_is_after_jiffies() with
> time_is_before_jiffies().
> 
> Signed-off-by: Luca Mariotti <mariottiluca1@hotmail.it>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Pietro Pedroni <pedroni.pietro.96@gmail.com>
> ---
>   block/bfq-iosched.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index acd1f881273e..2adb1e69c9d2 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2697,7 +2697,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>   	if (unlikely(!bfqd->nonrot_with_queueing)) {
>   		if (bic->stable_merge_bfqq &&
>   		    !bfq_bfqq_just_created(bfqq) &&
> -		    time_is_after_jiffies(bfqq->split_time +
> +		    time_is_before_jiffies(bfqq->split_time +
>   					  msecs_to_jiffies(200))) {
>   			struct bfq_queue *stable_merge_bfqq =
>   				bic->stable_merge_bfqq;
> 

Not sure why but with this patch I quickly got a division-by-zero in BFQ and
complete system halt. Unfortunately I couldn't capture the exact stack trace,
but it read something like bfq_calc_weight() or something ike that.
I looked through the code and found bfq_delta(), so maybe weight got
reduced to 0?

-h
