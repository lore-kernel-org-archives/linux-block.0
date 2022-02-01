Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BD0C433EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Feb 2022 13:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiBANjg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Feb 2022 08:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238682AbiBANjf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Feb 2022 08:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643722775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9DCVjlNHRhNbJpSITZj8A26Z89/3dqE9z/E0mwem6k=;
        b=FEvO/se/UZUsMi/SDlxPZeeo7GIVQGJiYBrxeXtRopDt0LKI2yN5kTGTNmPQGmv4G6qhUZ
        l+HsIuZEixjwiNS1tlntlY5YOx6oOknkxemR+bC6MojW8tIsFmY5KanYFBB2GRVJfzyIDs
        0VS0O5gfrK67hMAHtkp/kG2fE7swYBo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-SvjQDG6QMGq8tOFC9MiU7g-1; Tue, 01 Feb 2022 08:39:33 -0500
X-MC-Unique: SvjQDG6QMGq8tOFC9MiU7g-1
Received: by mail-qt1-f199.google.com with SMTP id w25-20020ac84d19000000b002d2966d66a8so12903541qtv.18
        for <linux-block@vger.kernel.org>; Tue, 01 Feb 2022 05:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9DCVjlNHRhNbJpSITZj8A26Z89/3dqE9z/E0mwem6k=;
        b=w5MhGn1L+69C36hJa+dk5spK1cd8BUUMfqIk9mXzw/fVlELKkJhnDQHJkwrFO5jscn
         VE/ccMHCm3HySlVvcC574iIkLPtk46VqfjF1//77RMubb2xyMLxRvCrRcy+2jg4lohoO
         6b4nyi9E90offgDAZktj/kMZ/zGtWoP4T/6+cPjN279eLdAm33Cip2AuC7KPlVLXusEt
         vLxg3TL1vwq/b+mkU8xSjr4Vxw862mIZqFTyZ2Cz1BIUwLp8t/JWTPUG7cqQk98RsONO
         8H6wdmH3US27F/zzFviHYlPv5b28+Jy7PAo1pt4RsZZjc3n8ky5dcNXgp+FGtaEICC5p
         TPBA==
X-Gm-Message-State: AOAM531PAXuotmtYeA+g1op6nxdZXGwETQ+lcT9tleSbUjRFv4C5V5Ex
        73U0C09rlealfxSaaVYOmeS8mLGbxKH+x3fl54RWxEVYss42di9i1IFX2/+O7vWY21Fo4M+kwJK
        lEJtF67Y01jp98OaJIbeNg6g=
X-Received: by 2002:ac8:7a8a:: with SMTP id x10mr18793572qtr.500.1643722773176;
        Tue, 01 Feb 2022 05:39:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLTIfJt67FAuhoZzCpHodW3jAcFnHkV1b2ytu+ZhO01DTtuHGX/eJ0nvgcy2vz04wp5InnBw==
X-Received: by 2002:ac8:7a8a:: with SMTP id x10mr18793548qtr.500.1643722772693;
        Tue, 01 Feb 2022 05:39:32 -0800 (PST)
Received: from loberhel ([2600:6c64:4e7f:cee0:a6c5:9640:fbb9:9e09])
        by smtp.gmail.com with ESMTPSA id i12sm3461360qko.105.2022.02.01.05.39.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Feb 2022 05:39:32 -0800 (PST)
Message-ID: <eda32e49be3d9111fe2ddeddd2155046944ec936.camel@redhat.com>
Subject: Re: [PATCH] blk-mq: avoid extending delays of active hctx from
 blk_mq_delay_run_hw_queues
From:   Laurence Oberman <loberman@redhat.com>
To:     David Jeffery <djeffery@redhat.com>, linux-block@vger.kernel.org
Date:   Tue, 01 Feb 2022 08:39:31 -0500
In-Reply-To: <20220131203337.GA17666@redhat>
References: <20220131203337.GA17666@redhat>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2022-01-31 at 15:33 -0500, David Jeffery wrote:
> When blk_mq_delay_run_hw_queues sets an hctx to run in the future, it
> can
> reset the delay length for an already pending delayed work run_work.
> This
> creates a scenario where multiple hctx may have their queues set to
> run,
> but if one runs first and finds nothing to do, it can reset the delay
> of
> another hctx and stall the other hctx's ability to run requests.
> 
> To avoid this I/O stall when an hctx's run_work is already pending,
> leave it untouched to run at its current designated time rather than
> extending its delay. The work will still run which keeps closed the
> race
> calling blk_mq_delay_run_hw_queues is needed for while also avoiding
> the
> I/O stall.
> 
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---
>  block/blk-mq.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f3bf3358a3bb..ae46eb4bf547 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2177,6 +2177,14 @@ void blk_mq_delay_run_hw_queues(struct
> request_queue *q, unsigned long msecs)
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (blk_mq_hctx_stopped(hctx))
>  			continue;
> +		/*
> +		 * If there is already a run_work pending, leave the
> +		 * pending delay untouched. Otherwise, a hctx can stall
> +		 * if another hctx is re-delaying the other's work
> +		 * before the work executes.
> +		 */
> +		if (delayed_work_pending(&hctx->run_work))
> +			continue;
>  		/*
>  		 * Dispatch from this hctx either if there's no hctx
> preferred
>  		 * by IO scheduler or if it has requests that bypass
> the
> 

Ming is aware of this patch and had asked David to submit it.
David already explained his reasoning internally.
It's for an already reported issue by a customer.

Reviewed-by:
Laurence Oberman <loberman@redhat.com>

