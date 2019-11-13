Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6262C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 13:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D6A222D0
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 13:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="KflpJlhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKMNCf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:02:35 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:39748 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfKMNCe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 08:02:34 -0500
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 08:02:33 EST
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 3DA9F628C1D;
        Wed, 13 Nov 2019 13:57:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1573649839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5lJHmk092HI/n/t3HGbtqhY5NJJ/zYeiYOZoPfSWoV8=;
        b=KflpJlhUhEVlin+lNNHQWX1kTlF4c1gNrPhtrV2UqmrK1UcmXVlG2RYGtHWbje5+kkNlwy
        h/aTjcodHZEpUULAbfWhbcb/TBRdAB35NNB66MvZQDpCIAufvyGAcweYUFPWk68ULOSyXU
        oCWqgAA4vFV0FXjE4ISYmMmPPrWmbg0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Nov 2019 13:57:19 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        Chris Evich <cevich@redhat.com>,
        Patrick Dung <patdung100@gmail.com>,
        Thorsten Schubert <tschubert@bafh.org>
Subject: Re: [PATCH BUGFIX] block, bfq: deschedule empty bfq_queues not
 referred by any process
In-Reply-To: <20191112074856.40433-1-paolo.valente@linaro.org>
References: <20191112074856.40433-1-paolo.valente@linaro.org>
User-Agent: Roundcube Webmail/1.4.0
Message-ID: <bb393dcaa426786e0963cf0e70f0b062@natalenko.name>
X-Sender: oleksandr@natalenko.name
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi.

On 12.11.2019 08:48, Paolo Valente wrote:
> Since commit 3726112ec731 ("block, bfq: re-schedule empty queues if
> they deserve I/O plugging"), to prevent the service guarantees of a
> bfq_queue from being violated, the bfq_queue may be left busy, i.e.,
> scheduled for service, even if empty (see comments in
> __bfq_bfqq_expire() for details). But, if no process will send
> requests to the bfq_queue any longer, then there is no point in
> keeping the bfq_queue scheduled for service.
> 
> In addition, keeping the bfq_queue scheduled for service, but with no
> process reference any longer, may cause the bfq_queue to be freed when
> descheduled from service. But this is assumed to never happen, and
> causes a UAF if it happens. This, in turn, caused crashes [1, 2].
> 
> This commit fixes this issue by descheduling an empty bfq_queue when
> it remains with not process reference.
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1767539
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=205447
> 
> Fixes: 3726112ec731 ("block, bfq: re-schedule empty queues if they
> deserve I/O plugging")
> Reported-by: Chris Evich <cevich@redhat.com>
> Reported-by: Patrick Dung <patdung100@gmail.com>
> Reported-by: Thorsten Schubert <tschubert@bafh.org>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0319d6339822..ba68627f7740 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2713,6 +2713,27 @@ static void bfq_bfqq_save_state(struct bfq_queue 
> *bfqq)
>  	}
>  }
> 
> +
> +static
> +void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue 
> *bfqq)
> +{
> +	/*
> +	 * To prevent bfqq's service guarantees from being violated,
> +	 * bfqq may be left busy, i.e., queued for service, even if
> +	 * empty (see comments in __bfq_bfqq_expire() for
> +	 * details). But, if no process will send requests to bfqq any
> +	 * longer, then there is no point in keeping bfqq queued for
> +	 * service. In addition, keeping bfqq queued for service, but
> +	 * with no process ref any longer, may have caused bfqq to be
> +	 * freed when dequeued from service. But this is assumed to
> +	 * never happen.
> +	 */
> +	if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list))
> +		bfq_del_bfqq_busy(bfqd, bfqq, false);
> +
> +	bfq_put_queue(bfqq);
> +}
> +
>  static void
>  bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
>  		struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
> @@ -2783,8 +2804,7 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct
> bfq_io_cq *bic,
>  	 */
>  	new_bfqq->pid = -1;
>  	bfqq->bic = NULL;
> -	/* release process reference to bfqq */
> -	bfq_put_queue(bfqq);
> +	bfq_release_process_ref(bfqd, bfqq);
>  }
> 
>  static bool bfq_allow_bio_merge(struct request_queue *q, struct 
> request *rq,
> @@ -4899,7 +4919,7 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd,
> struct bfq_queue *bfqq)
> 
>  	bfq_put_cooperator(bfqq);
> 
> -	bfq_put_queue(bfqq); /* release process reference */
> +	bfq_release_process_ref(bfqd, bfqq);
>  }
> 
>  static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
> @@ -5001,8 +5021,7 @@ static void bfq_check_ioprio_change(struct
> bfq_io_cq *bic, struct bio *bio)
> 
>  	bfqq = bic_to_bfqq(bic, false);
>  	if (bfqq) {
> -		/* release process reference on this queue */
> -		bfq_put_queue(bfqq);
> +		bfq_release_process_ref(bfqd, bfqq);
>  		bfqq = bfq_get_queue(bfqd, bio, BLK_RW_ASYNC, bic);
>  		bic_set_bfqq(bic, bfqq, false);
>  	}
> @@ -5963,7 +5982,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct
> bfq_queue *bfqq)
> 
>  	bfq_put_cooperator(bfqq);
> 
> -	bfq_put_queue(bfqq);
> +	bfq_release_process_ref(bfqq->bfqd, bfqq);
>  	return NULL;
>  }

I'm not sure if I see things right, but this commit along with v5.3.11 
kernel causes almost all boots to hang (for instance, on mounting the 
FS). Once the scheduler is changed to something else than BFQ (I set the 
I/O scheduler early via udev rule), multiple reboots go just fine.

Is this commit also applicable to 5.3 kernels? Or I'm testing a dumb 
thing?

Thanks.

-- 
   Oleksandr Natalenko (post-factum)
