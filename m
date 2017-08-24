Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbdHXECk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 00:02:40 -0400
Date: Thu, 24 Aug 2017 12:02:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "osandov@fb.com" <osandov@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 02/20] sbitmap: introduce __sbitmap_for_each_set()
Message-ID: <20170824040225.GB12966@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-3-ming.lei@redhat.com>
 <1503427020.2508.8.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503427020.2508.8.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 22, 2017 at 06:37:02PM +0000, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > -static inline void sbitmap_for_each_set(struct sbitmap *sb, sb_for_each_fn fn,
> > -					void *data)
> > +static inline void __sbitmap_for_each_set(struct sbitmap *sb,
> > +					  unsigned int off,
> > +					  sb_for_each_fn fn, void *data)
> >  {
> 
> An additional comment: if a function name starts with a double underscore
> usually that either means that it should be called with a specific lock
> held or that it is an implementation function that should not be called by
> other modules. Since neither is the case for __sbitmap_for_each_set(),
> please consider to use another name for this function.

We have lots of this kind of naming, please see __blk_mq_end_request(),
__free_pages(), ....

-- 
Ming
