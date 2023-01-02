Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBFBC3DA7A
	for <linux-block@archiver.kernel.org>; Mon,  2 Jan 2023 16:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbjABQA3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Jan 2023 11:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbjABQA1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Jan 2023 11:00:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB8CA479;
        Mon,  2 Jan 2023 08:00:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6BB3C3423B;
        Mon,  2 Jan 2023 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672675225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=covWwXHogk0SjBzjfqzR/6f4alDcYWVTScf/ev1sO8I=;
        b=v/9SqOytHlyO6fqeLbvcY8fziUGg+99T+JPw91KmommYTeeqbLwkrR6WqmknDFnjrIU1ys
        IXl4eaqo+1RGrobSk1Ng02LOcmzCgLyZVgsbzw+67xJePwXpdJRzbRcO+BxMqW9VLestDc
        lZbx2QmBP2UN37FVJzcrOnbLL1cv2s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672675225;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=covWwXHogk0SjBzjfqzR/6f4alDcYWVTScf/ev1sO8I=;
        b=qhEIL6eNQhfXbzpO9DpTrZDgLi2VDBHAtmYWeX5ihbZMblL+usen3zpbO4xvUgtvhTbXDj
        qCEKb8192fJqHxCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D3E7139C8;
        Mon,  2 Jan 2023 16:00:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bJzXEpn/smOneAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 16:00:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7B698A0742; Mon,  2 Jan 2023 17:00:24 +0100 (CET)
Date:   Mon, 2 Jan 2023 17:00:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: Re: [PATCH RESEND v2 09/10] block, bfq: remove unused
 bfq_wr_max_time in struct bfq_data
Message-ID: <20230102160024.s77ugy425npqgz53@quack3>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
 <20221222191641.1643117-10-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222191641.1643117-10-shikemeng@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 23-12-22 03:16:40, Kemeng Shi wrote:
> bfqd->bfq_wr_max_time is set to 0 in bfq_init_queue and is never changed.
> It is only used in bfq_wr_duration when bfq_wr_max_time > 0 which never
> meets, so bfqd->bfq_wr_max_time is not used actually. Just remove it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Nice catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 4 ----
>  block/bfq-iosched.h | 2 --
>  2 files changed, 6 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 195cdc6be087..91bc68fba72d 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -1068,9 +1068,6 @@ static unsigned int bfq_wr_duration(struct bfq_data *bfqd)
>  {
>  	u64 dur;
>  
> -	if (bfqd->bfq_wr_max_time > 0)
> -		return bfqd->bfq_wr_max_time;
> -
>  	dur = bfqd->rate_dur_prod;
>  	do_div(dur, bfqd->peak_rate);
>  
> @@ -7079,7 +7076,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  	 */
>  	bfqd->bfq_wr_coeff = 30;
>  	bfqd->bfq_wr_rt_max_time = msecs_to_jiffies(300);
> -	bfqd->bfq_wr_max_time = 0;
>  	bfqd->bfq_wr_min_idle_time = msecs_to_jiffies(2000);
>  	bfqd->bfq_wr_min_inter_arr_async = msecs_to_jiffies(500);
>  	bfqd->bfq_wr_max_softrt_rate = 7000; /*
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 9fa89577322d..0b1a5438046a 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -719,8 +719,6 @@ struct bfq_data {
>  	 * is multiplied.
>  	 */
>  	unsigned int bfq_wr_coeff;
> -	/* maximum duration of a weight-raising period (jiffies) */
> -	unsigned int bfq_wr_max_time;
>  
>  	/* Maximum weight-raising duration for soft real-time processes */
>  	unsigned int bfq_wr_rt_max_time;
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
