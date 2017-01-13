Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbdAMIZE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 03:25:04 -0500
Date: Fri, 13 Jan 2017 09:25:00 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@fb.com>
Cc: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 07/10] blk-mq: abstract out helpers for
 allocating/freeing tag maps
Message-ID: <20170113082500.GB3409@linux-x5ow.site>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-8-git-send-email-axboe@fb.com>
 <1484256526.2720.19.camel@sandisk.com>
 <20170112215438.GA25197@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170112215438.GA25197@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 12, 2017 at 02:54:38PM -0700, Jens Axboe wrote:
> On Thu, Jan 12 2017, Bart Van Assche wrote:
> > On Wed, 2017-01-11 at 14:40 -0700, Jens Axboe wrote:
> > > @@ -2392,12 +2425,12 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
> > >  	if (set->nr_hw_queues > nr_cpu_ids)
> > >  		set->nr_hw_queues = nr_cpu_ids;
> > >  
> > > +	ret = -ENOMEM;
> > >  	set->tags = kzalloc_node(nr_cpu_ids * sizeof(struct blk_mq_tags *),
> > >  				 GFP_KERNEL, set->numa_node);
> > >  	if (!set->tags)
> > >  		return -ENOMEM;
> > >  
> > > -	ret = -ENOMEM;
> > >  	set->mq_map = kzalloc_node(sizeof(*set->mq_map) * nr_cpu_ids,
> > >  			GFP_KERNEL, set->numa_node);
> > >  	if (!set->mq_map)
> > 
> > Not that it matters to me, but this change probably isn't needed?
> 
> Huh oops no, I'll move that back where it belongs.

Maybe even:

+ ret = -ENOMEM;
  set->tags = kzalloc_node(nr_cpu_ids * sizeof(struct blk_mq_tags *),
  			 GFP_KERNEL, set->numa_node);
  if (!set->tags)
-  	return -ENOMEM;
+	return ret;

- ret = -ENOMEM;

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
