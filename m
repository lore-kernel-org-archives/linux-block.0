Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35094 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdHIHOe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2017 03:14:34 -0400
Received: by mail-pf0-f179.google.com with SMTP id t86so24390931pfe.2
        for <linux-block@vger.kernel.org>; Wed, 09 Aug 2017 00:14:33 -0700 (PDT)
Date: Wed, 9 Aug 2017 00:14:31 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, brking@linux.vnet.ibm.com,
        bart.vanassche@wdc.com
Subject: Re: [PATCH 5/6] blk-mq: enable checking two part inflight counts at
 the same time
Message-ID: <20170809071431.GB16843@vader>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
 <1501859062-11120-6-git-send-email-axboe@kernel.dk>
 <20170808224800.GG4072@vader.DHCP.thefacebook.com>
 <78566b09-d53c-811e-4bd5-c15cdea2e50a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <78566b09-d53c-811e-4bd5-c15cdea2e50a@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 08, 2017 at 05:47:15PM -0600, Jens Axboe wrote:
> On 08/08/2017 04:48 PM, Omar Sandoval wrote:
> > On Fri, Aug 04, 2017 at 09:04:21AM -0600, Jens Axboe wrote:
> >> Modify blk_mq_in_flight() to count both a partition and root at
> >> the same time. Then we only have to call it once, instead of
> >> potentially looping the tags twice.
> > 
> > Reviewed-by: Omar Sandoval <osandov@fb.com>
> > 
> > One comment below.
> > 
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > [snip]
> > 
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index fe1aa1f5f069..410ed246bc9b 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -98,11 +98,13 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
> >>  		return;
> >>  
> >>  	/*
> >> -	 * Count as inflight if it either matches the partition we asked
> >> -	 * for, or if it's the root
> >> +	 * Count as inflight if it matches the partition, count separately
> >> +	 * (but all) if we got asked for the root
> >>  	 */
> >> -	if (rq->part == mi->part || mi->part->partno)
> >> +	if (rq->part == mi->part)
> >>  		mi->inflight[0]++;
> > 
> > Similar concern as with patch 3, why special case the part0 case below?
> 
> Not sure I follow, both are initialized for this case. Or do you mean
> the increment?

Yeah I mean the increment. If I'm reading this right, for the !part0
case, inflight[0] is the count of in-flight requests for the partition
and inflight[1] is the count of in-flight requests for the whole device.
For the part0 case, inflight[0] is the count of in-flight requests for
the root device and inflight[1] is always 0. Can we make inflight[1] the
same in the part0 and !part0 cases?

> The comment isn't great, I should update that. Basically
> we want to increment [1] if this is a partition, and increment [0] if it
> matches the one that was asked for.
> 
> -- 
> Jens Axboe
> 
