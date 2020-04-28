Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE8C83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 08:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757D8206D7
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 08:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgD1IFk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:05:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:49462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgD1IFj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 04:05:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E1B89AC4A;
        Tue, 28 Apr 2020 08:05:37 +0000 (UTC)
Subject: Re: [PATCH 1/2] block: add blk_default_io_timeout() for avoiding task
 hung in sync IO
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200428074657.645441-1-ming.lei@redhat.com>
 <20200428074657.645441-2-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <71710192-1262-6f08-e38b-565ec6a32858@suse.de>
Date:   Tue, 28 Apr 2020 10:05:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428074657.645441-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/20 9:46 AM, Ming Lei wrote:
> Add helper of blk_default_io_timeout(), so that the two current users
> can benefit from it.
> 
> Also direct IO users will use it in the following patch, so define the
> helper in public header.
> 
> Cc: Salman Qazi <sqazi@google.com>
> Cc: Jesse Barnes <jsbarnes@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/bio.c            |  9 +++------
>   block/blk-exec.c       |  8 +++-----
>   include/linux/blkdev.h | 10 ++++++++++
>   3 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 21cbaa6a1c20..f67afa159de7 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1069,18 +1069,15 @@ static void submit_bio_wait_endio(struct bio *bio)
>   int submit_bio_wait(struct bio *bio)
>   {
>   	DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
> -	unsigned long hang_check;
> +	unsigned long timeout = blk_default_io_timeout();
>   
>   	bio->bi_private = &done;
>   	bio->bi_end_io = submit_bio_wait_endio;
>   	bio->bi_opf |= REQ_SYNC;
>   	submit_bio(bio);
>   
> -	/* Prevent hang_check timer from firing at us during very long I/O */
> -	hang_check = sysctl_hung_task_timeout_secs;
> -	if (hang_check)
> -		while (!wait_for_completion_io_timeout(&done,
> -					hang_check * (HZ/2)))
> +	if (timeout)
> +		while (!wait_for_completion_io_timeout(&done, timeout))
>   			;
>   	else
>   		wait_for_completion_io(&done);
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index e20a852ae432..17b5cf07e1a3 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -80,15 +80,13 @@ void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
>   		   struct request *rq, int at_head)
>   {
>   	DECLARE_COMPLETION_ONSTACK(wait);
> -	unsigned long hang_check;
> +	unsigned long timeout = blk_default_io_timeout();
>   
>   	rq->end_io_data = &wait;
>   	blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);
>   
> -	/* Prevent hang_check timer from firing at us during very long I/O */
> -	hang_check = sysctl_hung_task_timeout_secs;
> -	if (hang_check)
> -		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
> +	if (timeout)
> +		while (!wait_for_completion_io_timeout(&wait, timeout));
>   	else
>   		wait_for_completion_io(&wait);
>   }
This probably just shows my ignorance, but why don't we check for 
rq->timeout here?
I do see that not all requests have a timeout, but what about those who 
have?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
