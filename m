Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA4FC433ED
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 21:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C542E610CD
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 21:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhDPVpK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344518AbhDPVpJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 17:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618609484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLTgqRnP5TXoefl7vOZVal90OzLfQP2dBhM4AZR7Wj8=;
        b=i7SImWpHHYWHNsA9m+Cf/fSSZo4Ekp3powCdUHra9E+gzgLjK+ekNHPwcI/hY49aixgO/J
        lvV2Q4+CkRW7dHEKlNw4mxN4FVR4lW02V3sB8wiT8Ftq5WL7it2dZNw7t67BFejxFZ0Hd3
        T/vFomPnvSfR0hg0fqDImCXesKOxqQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-OgsOzGilOvyktH6l0E66vQ-1; Fri, 16 Apr 2021 17:44:42 -0400
X-MC-Unique: OgsOzGilOvyktH6l0E66vQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D13283DD20;
        Fri, 16 Apr 2021 21:44:41 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48E715D6D3;
        Fri, 16 Apr 2021 21:44:41 +0000 (UTC)
Date:   Fri, 16 Apr 2021 17:44:40 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     "Ewan D. Milne" <emilne@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/4] nvme: introduce FAILUP handling for
 REQ_FAILFAST_TRANSPORT
Message-ID: <20210416214440.GA21540@redhat.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-4-snitzer@redhat.com>
 <d679b46e86ee719deb87bd151f01563b2af223d3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d679b46e86ee719deb87bd151f01563b2af223d3.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 16 2021 at  4:52pm -0400,
Ewan D. Milne <emilne@redhat.com> wrote:

> On Thu, 2021-04-15 at 19:15 -0400, Mike Snitzer wrote:
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
> >  static inline enum nvme_disposition nvme_decide_disposition(struct
> > request *req)
> > @@ -318,10 +319,11 @@ static inline enum nvme_disposition
> > nvme_decide_disposition(struct request *req)
> >  	    nvme_req(req)->retries >= nvme_max_retries)
> >  		return COMPLETE;
> >  
> > -	if (req->cmd_flags & REQ_NVME_MPATH) {
> > +	if (req->cmd_flags & (REQ_NVME_MPATH | REQ_FAILFAST_TRANSPORT))
> > {
> >  		if (nvme_is_path_error(nvme_req(req)->status) ||
> >  		    blk_queue_dying(req->q))
> > -			return FAILOVER;
> > +			return (req->cmd_flags & REQ_NVME_MPATH) ?
> > +				FAILOVER : FAILUP;
> >  	} else {
> >  		if (blk_queue_dying(req->q))
> >  			return COMPLETE;
> > @@ -330,10 +332,8 @@ static inline enum nvme_disposition
> > nvme_decide_disposition(struct request *req)
> >  	return RETRY;
> >  }
> >  
> > -static inline void nvme_end_req(struct request *req)
> > +static inline void __nvme_end_req(struct request *req, blk_status_t
> > status)
> >  {
> > -	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> > -
> >  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> >  	    req_op(req) == REQ_OP_ZONE_APPEND)
> >  		req->__sector = nvme_lba_to_sect(req->q->queuedata,
> > @@ -343,6 +343,24 @@ static inline void nvme_end_req(struct request
> > *req)
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
> > +		pr_debug("Request meant for failover but blk_status_t
> > (errno=%d) was not retryable.\n",
> > +			 blk_status_to_errno(status));
> > +		status = BLK_STS_IOERR;
> > +	}
> > +
> > +	__nvme_end_req(req, status);
> 
> It seems like adding __nvme_end_req() was unnecessary, since
> nvme_end_req() just calls it and does nothing else?

The __nvme_end_req helper allowed the status to be passed in, making it
easy to override status for unlikley edge-case where the BLK_STS is
!blk_path_error() but should be given nvme_is_path_error() returned
true.

Anyway, I can avoid the need to factor out __nvme_end_req() and just:
  nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
  nvme_end_req(req);

Thanks,
Mike

