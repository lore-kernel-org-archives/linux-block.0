Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD4FC433ED
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4095D611ED
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 15:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245708AbhDPPDh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 11:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243051AbhDPPDg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 11:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618585391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nAwLTTBiOSaO2ampe3YpvQbW2lPPm7lXf6s0XEc69Ps=;
        b=aOM2RZ8xrmpn6p3hdAxcP1yQwf2rj/Lb9f6ul+31dB1uPlhnl2+xeScGHjrKGtY/SC09Ur
        iBIEt0JfenCUFU8qGcmYg8JT9ymzflRJfa1kZpEe8oIhFaYhBwrIxAFnBVa8zzHE/vzHba
        vAan1gC4fw/zJuzB6v4OQEw24jsz8Rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-9JhHFIbOOhSvfnHJan341w-1; Fri, 16 Apr 2021 11:03:07 -0400
X-MC-Unique: 9JhHFIbOOhSvfnHJan341w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4F2A106BBE9;
        Fri, 16 Apr 2021 15:03:05 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C784A5D751;
        Fri, 16 Apr 2021 15:03:01 +0000 (UTC)
Date:   Fri, 16 Apr 2021 11:03:01 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/4] nvme: introduce FAILUP handling for
 REQ_FAILFAST_TRANSPORT
Message-ID: <20210416150301.GC16047@redhat.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-4-snitzer@redhat.com>
 <6185100e-89e6-0a7f-8901-9ce86fe8f1ac@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6185100e-89e6-0a7f-8901-9ce86fe8f1ac@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 16 2021 at 10:07am -0400,
Hannes Reinecke <hare@suse.de> wrote:

> On 4/16/21 1:15 AM, Mike Snitzer wrote:
> > If REQ_FAILFAST_TRANSPORT is set it means the driver should not retry
> > IO that completed with transport errors. REQ_FAILFAST_TRANSPORT is
> > set by multipathing software (e.g. dm-multipath) before it issues IO.
> > 
> > Update NVMe to allow failover of requests marked with either
> > REQ_NVME_MPATH or REQ_FAILFAST_TRANSPORT. This allows such requests
> > to be given a disposition of either FAILOVER or FAILUP respectively.
> > FAILUP handling ensures a retryable error is returned up from NVMe.
> > 
> > Introduce nvme_failup_req() for use in nvme_complete_rq() if
> > nvme_decide_disposition() returns FAILUP. nvme_failup_req() ensures
> > the request is completed with a retryable IO error when appropriate.
> > __nvme_end_req() was factored out for use by both nvme_end_req() and
> > nvme_failup_req().
> > 
> > Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> > ---
> >  drivers/nvme/host/core.c | 31 ++++++++++++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 4134cf3c7e48..10375197dd53 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -299,6 +299,7 @@ enum nvme_disposition {
> >  	COMPLETE,
> >  	RETRY,
> >  	FAILOVER,
> > +	FAILUP,
> >  };
> >  
> >  static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
> > @@ -318,10 +319,11 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
> >  	    nvme_req(req)->retries >= nvme_max_retries)
> >  		return COMPLETE;
> >  
> > -	if (req->cmd_flags & REQ_NVME_MPATH) {
> > +	if (req->cmd_flags & (REQ_NVME_MPATH | REQ_FAILFAST_TRANSPORT)) {
> >  		if (nvme_is_path_error(nvme_req(req)->status) ||
> >  		    blk_queue_dying(req->q))
> > -			return FAILOVER;
> > +			return (req->cmd_flags & REQ_NVME_MPATH) ?
> > +				FAILOVER : FAILUP;
> >  	} else {
> >  		if (blk_queue_dying(req->q))
> >  			return COMPLETE;
> > @@ -330,10 +332,8 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
> >  	return RETRY;
> >  }
> >  
> > -static inline void nvme_end_req(struct request *req)
> > +static inline void __nvme_end_req(struct request *req, blk_status_t status)
> >  {
> > -	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> > -
> >  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> >  	    req_op(req) == REQ_OP_ZONE_APPEND)
> >  		req->__sector = nvme_lba_to_sect(req->q->queuedata,
> > @@ -343,6 +343,24 @@ static inline void nvme_end_req(struct request *req)
> >  	blk_mq_end_request(req, status);
> >  }
> >  
> > +static inline void nvme_end_req(struct request *req)
> > +{
> > +	__nvme_end_req(req, nvme_error_status(nvme_req(req)->status));
> > +}
> > +
> > +static void nvme_failup_req(struct request *req)
> > +{
> > +	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> > +
> > +	if (WARN_ON_ONCE(!blk_path_error(status))) {
> > +		pr_debug("Request meant for failover but blk_status_t (errno=%d) was not retryable.\n",
> > +			 blk_status_to_errno(status));
> > +		status = BLK_STS_IOERR;
> > +	}
> > +
> > +	__nvme_end_req(req, status);
> > +}
> > +
> >  void nvme_complete_rq(struct request *req)
> >  {
> >  	trace_nvme_complete_rq(req);
> > @@ -361,6 +379,9 @@ void nvme_complete_rq(struct request *req)
> >  	case FAILOVER:
> >  		nvme_failover_req(req);
> >  		return;
> > +	case FAILUP:
> > +		nvme_failup_req(req);
> > +		return;
> >  	}
> >  }
> >  EXPORT_SYMBOL_GPL(nvme_complete_rq);
> > 
> 
> Hmm. Quite convoluted, methinks.

Maybe you didn't read the header or patch?

I'm cool with critical review when it is clear the reviewer fully
understands the patch but... ;)

> Shouldn't this achieve the same thing?
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e89ec2522ca6..8c36a2196b66 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -303,8 +303,10 @@ static inline enum nvme_disposition
> nvme_decide_disposition(struct request *req)
>         if (likely(nvme_req(req)->status == 0))
>                 return COMPLETE;
> 
> -       if (blk_noretry_request(req) ||
> -           (nvme_req(req)->status & NVME_SC_DNR) ||
> +       if (blk_noretry_request(req))
> +               nvme_req(req)->status |= NVME_SC_DNR;
> +
> +       if ((nvme_req(req)->status & NVME_SC_DNR) ||
>             nvme_req(req)->retries >= nvme_max_retries)
>                 return COMPLETE;

Definitely won't achieve the same. And especially not with patch 1/4
("nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set") that you
gave your Reviewed-by to earlier.

Instead of "FAILUP", I thought about using "FAILUP_AND_OVER" to convey
that this is a variant of failover.  Meaning it takes the same patch as
nvme "FAILOVER" until the very end; where it does REQ_FAILFAST_TRANSPORT
specific work detailed in nvme_failup_req().

And then patch 4/4 makes further use of nvme_failup_req() by adding a
call to the factored out nvme_update_ana().

Mike

