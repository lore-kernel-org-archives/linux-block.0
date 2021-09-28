Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BC0C433F5
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 05:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C7D6108F
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 05:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbhI1Fss (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 01:48:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43032 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhI1Fss (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 01:48:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65D7C201B8;
        Tue, 28 Sep 2021 05:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632808028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBMvJQWujYEAJ72DVPpiIBZ8MlEvwrCLnMZ6tCL4YHo=;
        b=dQ7SW8AfgY2W8cD2csGbLeaDx2MGAVuOvmxjr7cCRHeRkhaXfSDA9xr3Ll6zpTO1l7wpAh
        2zLkfGnte4irU89hhK4QJ36TKHCYy4jOIwOcoJvJPi8xRVqrg/9gxLROJDGHC12gk1tOji
        dGAlMOo2nOOEP6DU/1L+5I+fQe/uFac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632808028;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBMvJQWujYEAJ72DVPpiIBZ8MlEvwrCLnMZ6tCL4YHo=;
        b=3gDOgEFJtXfo2Cr3e+n+lqQnMc9x6Qj+C7nonrasOynTOZLJyTcfWS4WLHU90veiNCa+h9
        67Kiy4TFRdR8XFDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4405E13A98;
        Tue, 28 Sep 2021 05:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Bwl5D1ysUmHXOAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 28 Sep 2021 05:47:08 +0000
Subject: Re: [PATCH v2 2/4] block/mq-deadline: Add an invariant check
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20210927220328.1410161-1-bvanassche@acm.org>
 <20210927220328.1410161-3-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0d3317b4-2e94-d206-4860-c2d39bc8471e@suse.de>
Date:   Tue, 28 Sep 2021 07:47:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210927220328.1410161-3-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/21 12:03 AM, Bart Van Assche wrote:
> Check a statistics invariant at module unload time. When running
> blktests, the invariant is verified every time a request queue is
> removed and hence is verified at least once per test.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index c27b4347ca91..2586b3f8c7e9 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -270,6 +270,12 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>   	deadline_remove_request(rq->q, per_prio, rq);
>   }
>   
> +/* Number of requests queued for a given priority level. */
> +static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> +{
> +	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
> +}
> +
>   /*
>    * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
>    * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
> @@ -539,6 +545,12 @@ static void dd_exit_sched(struct elevator_queue *e)
>   
>   		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
>   		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
> +		WARN_ONCE(dd_queued(dd, prio) != 0,
> +			  "statistics for priority %d: i %u m %u d %u c %u\n",
> +			  prio, dd_sum(dd, inserted, prio),
> +			  dd_sum(dd, merged, prio),
> +			  dd_sum(dd, dispatched, prio),
> +			  dd_sum(dd, completed, prio));
>   	}
>   
>   	free_percpu(dd->stats);
> @@ -950,12 +962,6 @@ static int dd_async_depth_show(void *data, struct seq_file *m)
>   	return 0;
>   }
>   
> -/* Number of requests queued for a given priority level. */
> -static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> -{
> -	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
> -}
> -
>   static int dd_queued_show(void *data, struct seq_file *m)
>   {
>   	struct request_queue *q = data;
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
