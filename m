Return-Path: <SRS0=HzVw=UO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A04C31E52
	for <linux-block@archiver.kernel.org>; Sat, 15 Jun 2019 16:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A39720644
	for <linux-block@archiver.kernel.org>; Sat, 15 Jun 2019 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560617566;
	bh=UsK22JUeOOMcfS5ld8YBMJJSkveqxnB6s9i7jkbQthk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZmHadBE/M5ZUecCo+33L8r2v2jqsnWRvlv3DJHVMLXuhpIRoehTFkJxEXOUFPa6SQ
	 mxlUYuqRspdWQ62E1DpiFGif3mNk2kz18TxYiTe9r2Uow0Jl1EVQkFoOgzu3PVh+FR
	 JpyMQ8aP7zAMml72Yq7R11cFUeMCpCIGaI9+BKFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfFOQvz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Jun 2019 12:51:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33359 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfFOQvz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Jun 2019 12:51:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id x2so6224647qtr.0;
        Sat, 15 Jun 2019 09:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a4xhiw6iLiAdxawJ0gBqdsCUibLnDDLzmKzkX2M7ao4=;
        b=JR/JSimc8wJkIyVGtrW8sddXIfoe51hLBfp76OQqLiXdj11v+ornlvGger8tCUHvDf
         BAzCuAHwv2IojYL+dU6W7gdp7Z6BDFoZaq0dlIwg2Q6y1HK7vJfGi0O++eHTp3CpIUMS
         g2bXbJOMYH/1pqAxP6xdKG2cjxzJu0y7oNmUMmaFpIkSiPpN/RwcZ5zesrEiDhxZMhZy
         eSUAVlM8t9Tw69Iux3GpDjqGs5kxZLMANJJ2DkE3MfzJMlqGsORsNZ54ggxuDjQW2jFp
         /9ToF+h5i4wkYYY0lbRYpC0PffPkjMefXTaY0muJHOX9Y4C3N3PhXLnrF9cjI1jS2/AE
         oMdQ==
X-Gm-Message-State: APjAAAUqeRqxWx7F/IzIDW7wdIZbDJ4AvaMS9EHJrLbYiscqMmz3H7zo
        LxlSmeY9TblWT/51yidhbsk=
X-Google-Smtp-Source: APXvYqzBaYFiNiMPaxJNo97WoRGxTucecswQCzfAVfZQ0cDMNOlT7per50nEv+L1BMYtPqZ0jchW0g==
X-Received: by 2002:aed:3535:: with SMTP id a50mr88458459qte.237.1560617514471;
        Sat, 15 Jun 2019 09:51:54 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:480::3822])
        by smtp.gmail.com with ESMTPSA id v4sm1288871qtq.15.2019.06.15.09.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 09:51:53 -0700 (PDT)
Date:   Sat, 15 Jun 2019 12:51:49 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-iolatency: only account submitted bios
Message-ID: <20190615165149.GA96756@dennisz-mbp.dhcp.thefacebook.com>
References: <20190523201018.49615-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523201018.49615-1-dennis@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On Thu, May 23, 2019 at 04:10:18PM -0400, Dennis Zhou wrote:
> As is, iolatency recognizes done_bio and cleanup as ending paths. If a
> request is marked REQ_NOWAIT and fails to get a request, the bio is
> cleaned up via rq_qos_cleanup() and ended in bio_wouldblock_error().
> This results in underflowing the inflight counter. Fix this by only
> accounting bios that were actually submitted.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> ---
>  block/blk-iolatency.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 507212d75ee2..58bac44ba78a 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -599,6 +599,10 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
>  	if (!blkg || !bio_flagged(bio, BIO_TRACKED))
>  		return;
>  
> +	/* We didn't actually submit this bio, don't account it. */
> +	if (bio->bi_status == BLK_STS_AGAIN)
> +		return;
> +
>  	iolat = blkg_to_lat(bio->bi_blkg);
>  	if (!iolat)
>  		return;
> -- 
> 2.17.1
> 

Can you please take a look at this?

Thanks,
Dennis
