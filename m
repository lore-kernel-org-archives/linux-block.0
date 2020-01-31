Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B48CC33CB2
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2065720707
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="eFZRubqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgAaK0y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:26:54 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:38618 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgAaK0y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 05:26:54 -0500
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jan 2020 05:26:54 EST
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id F0DCE6AE285;
        Fri, 31 Jan 2020 11:20:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1580466060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JyCL1AIFRsZZJc5TqF/kQuvXxI+4j7HIOhnVeMP3yZ4=;
        b=eFZRubqsAd6wKnBlDqS8xYSyzrE/OXUhl4kBSTrY0qR+h8rh3JnjwATOfPykZwc6CTQoSL
        2JrWVkPumzGpxxX08aMeH/Jg6vIfNXjCEwhM4w/r/hHMRvcQaV+vyZTgsvmA9VaIldE/oE
        cTEqSU/csPYUPXaf8360TPtmDbVoMTA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 31 Jan 2020 11:20:59 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bfq-iosched@googlegroups.com,
        patdung100@gmail.com, cevich@redhat.com
Subject: Re: [PATCH BUGFIX 3/6] block, bfq: get extra ref to prevent a queue
 from being freed during a group move
In-Reply-To: <20200131092409.10867-4-paolo.valente@linaro.org>
References: <20200131092409.10867-1-paolo.valente@linaro.org>
 <20200131092409.10867-4-paolo.valente@linaro.org>
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <784c55c0f37a1a448c31e73e28bef6f8@natalenko.name>
X-Sender: oleksandr@natalenko.name
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On 31.01.2020 10:24, Paolo Valente wrote:
> In bfq_bfqq_move(), the bfq_queue, say Q, to be moved to a new group
> may happen to be deactivated in the scheduling data structures of the
> source group (and then activated in the destination group). If Q is
> referred only by the data structures in the source group when the
> deactivation happens, then Q is freed upon the deactivation.
> 
> This commit addresses this issue by getting an extra reference before
> the possible deactivation, and releasing this extra reference after Q
> has been moved.
> 
> Tested-by: Chris Evich <cevich@redhat.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-cgroup.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index e1419edde2ec..8ab7f18ff8cb 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -651,6 +651,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct
> bfq_queue *bfqq,
>  		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
>  				false, BFQQE_PREEMPTED);
> 
> +	/*
> +	 * get extra reference to prevent bfqq from being freed in
> +	 * next possible deactivate
> +	 */
> +	bfqq->ref++;

Shouldn't this be hidden under some macro (bfq_get_queue_ref(), for 
instance) and also converted from int into refcount_t?

> +
>  	if (bfq_bfqq_busy(bfqq))
>  		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
>  	else if (entity->on_st)
> @@ -670,6 +676,8 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct
> bfq_queue *bfqq,
> 
>  	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
>  		bfq_schedule_dispatch(bfqd);
> +	/* release extra ref taken above */
> +	bfq_put_queue(bfqq);
>  }
> 
>  /**

-- 
   Oleksandr Natalenko (post-factum)
