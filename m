Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF9EC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0B0205C9
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="bdHFEpv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0B0205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeK1Kmi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:42:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45876 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1Kmi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:42:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so8580184pgc.12
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 15:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8yRl4UeYk7cKaPET9LCRDXTeu0D4mVWJR0LFgJyKNYY=;
        b=bdHFEpv1UbN0eDYPoQp6f/dFCt+BYklw9TxAIu08dl007rPlCdzMHMsUI578u9ppA5
         oSSp3h9LIVptgjMuZczobcNvHhkDbhdidpVaITbLEXyDZ9sPBRFH7WrUd3ckUGWOFu8q
         mXKfZXDlDVYKn6B3r0Dz2XNumYDhs0Gnp23qDzXLDyCJjBKYpaRTeebzzJUf40aMPNcp
         il9vWfJKO6My4lqD23bTMo7sOqkTDGc12nZ2XdCszksBcjktBNf2ol7BOivbAKsdhd7r
         mka1H25rp1ShnBGLz8d5qOwpXQYDXaeFm/Q3n48Ip3tJrQOQWI9dH1sm7wMFC+AhnxLP
         qd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8yRl4UeYk7cKaPET9LCRDXTeu0D4mVWJR0LFgJyKNYY=;
        b=aW3d0XoCcRGz9hurraB8hAO8n4F1ryGYSKuIo9JaqN6PUGsUyiPrQDuIg3WJu6Wa+g
         kaQ3qeqg1m5+Hnl7ndjUpufbnSB4nKRwhIj1H1J0/Ruz1v1HD9S3UevmaRe6bmf5zgvR
         Wsh3NfApbSjG2GW/GO+leW0NJaM/gs5Mw63Wg+2g6mKwokKbmDxh52rjgZWL6iDDmq2t
         sjCcNAJ1Y0Dst3KWcD2VViJxF4IKSvLI7mDInNxIzPLPQXuAR66cofPFv88ZoDtH+TpD
         aI7xiRdNRU7/HAo6xB4e5i4HIbHSxNFPl9LAZu9vVGQbY0p3PxMHa6eRmHEziQMWJU6h
         LNPA==
X-Gm-Message-State: AA+aEWbYNQ8N1gv8OsKKLpNeIg5VrYrS6dvcVwijGrTv4xMdqz6bPAff
        /1B7GWgaE0kQRqbNY+h+6eQGlQ+sLu4=
X-Google-Smtp-Source: AFSGD/VomsZ0Wis3QVav+W6MraKbtRgEWI4vN73JAAxU1KbU3NVCpnEupNDXnFQbfojBXmJBMK007Q==
X-Received: by 2002:a65:50c1:: with SMTP id s1mr30249480pgp.350.1543362185284;
        Tue, 27 Nov 2018 15:43:05 -0800 (PST)
Received: from vader ([2620:10d:c090:200::5:71bd])
        by smtp.gmail.com with ESMTPSA id s84sm12105663pfi.15.2018.11.27.15.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 15:43:04 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:43:03 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/8] blk-mq: add mq_ops->commit_rqs()
Message-ID: <20181127234303.GC846@vader>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126163556.5181-4-axboe@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 09:35:51AM -0700, Jens Axboe wrote:
> blk-mq passes information to the hardware about any given request being
> the last that we will issue in this sequence. The point is that hardware
> can defer costly doorbell type writes to the last request. But if we run
> into errors issuing a sequence of requests, we may never send the request
> with bd->last == true set. For that case, we need a hook that tells the
> hardware that nothing else is coming right now.
> 
> For failures returned by the drivers ->queue_rq() hook, the driver is
> responsible for flushing pending requests, if it uses bd->last to
> optimize that part. This works like before, no changes there.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  include/linux/blk-mq.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index ca0520ca6437..1fd139b65a6e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -117,6 +117,7 @@ struct blk_mq_queue_data {
>  
>  typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
>  		const struct blk_mq_queue_data *);
> +typedef void (commit_rqs_fn)(struct blk_mq_hw_ctx *);
>  /* takes rq->cmd_flags as input, returns a hardware type index */
>  typedef int (rq_flags_to_type_fn)(struct request_queue *, unsigned int);
>  typedef bool (get_budget_fn)(struct blk_mq_hw_ctx *);
> @@ -144,6 +145,15 @@ struct blk_mq_ops {
>  	 */
>  	queue_rq_fn		*queue_rq;
>  
> +	/*
> +	 * If a driver uses bd->last to judge when to submit requests to
> +	 * hardware, it must define this function. In case of errors that
> +	 * make us stop issuing further requests, this hook serves the
> +	 * purpose of kicking the hardware (which the last request otherwise
> +	 * would have done).
> +	 */
> +	commit_rqs_fn		*commit_rqs;
> +
>  	/*
>  	 * Return a queue map type for the given request/bio flags
>  	 */
> -- 
> 2.17.1
> 
