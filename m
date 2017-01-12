Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751064AbdALVyn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 16:54:43 -0500
Date: Thu, 12 Jan 2017 14:54:38 -0700
From: Jens Axboe <axboe@fb.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 07/10] blk-mq: abstract out helpers for
 allocating/freeing tag maps
Message-ID: <20170112215438.GA25197@kernel.dk>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-8-git-send-email-axboe@fb.com>
 <1484256526.2720.19.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1484256526.2720.19.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 12 2017, Bart Van Assche wrote:
> On Wed, 2017-01-11 at 14:40 -0700, Jens Axboe wrote:
> > @@ -2392,12 +2425,12 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
> >  	if (set->nr_hw_queues > nr_cpu_ids)
> >  		set->nr_hw_queues = nr_cpu_ids;
> >  
> > +	ret = -ENOMEM;
> >  	set->tags = kzalloc_node(nr_cpu_ids * sizeof(struct blk_mq_tags *),
> >  				 GFP_KERNEL, set->numa_node);
> >  	if (!set->tags)
> >  		return -ENOMEM;
> >  
> > -	ret = -ENOMEM;
> >  	set->mq_map = kzalloc_node(sizeof(*set->mq_map) * nr_cpu_ids,
> >  			GFP_KERNEL, set->numa_node);
> >  	if (!set->mq_map)
> 
> Not that it matters to me, but this change probably isn't needed?

Huh oops no, I'll move that back where it belongs.

-- 
Jens Axboe

