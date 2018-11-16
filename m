Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AB3C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 07:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A4D208E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 07:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A4D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeKPSDr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:03:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeKPSDr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:03:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1878285BB;
        Fri, 16 Nov 2018 07:52:32 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D9FD17CD6;
        Fri, 16 Nov 2018 07:52:11 +0000 (UTC)
Date:   Fri, 16 Nov 2018 15:52:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: not embed .mq_kobj and ctx->kobj into queue
 instance
Message-ID: <20181116075205.GC5520@ming.t460p>
References: <20181116032826.11901-1-ming.lei@redhat.com>
 <20181116032826.11901-2-ming.lei@redhat.com>
 <64abb411-f4af-a169-e878-2119f7c792d5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64abb411-f4af-a169-e878-2119f7c792d5@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 16 Nov 2018 07:52:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 02:11:07PM +0800, jianchao.wang wrote:
> 
> 
> On 11/16/18 11:28 AM, Ming Lei wrote:
> ...
> >  
> > +struct blk_mq_kobj {
> > +	struct kobject kobj;
> > +};
> > +
> >  static void blk_mq_sysfs_release(struct kobject *kobj)
> >  {
> > +	struct blk_mq_kobj *mq_kobj = container_of(kobj, struct blk_mq_kobj,
> > +						   kobj);
> > +	kfree(mq_kobj);
> > +}
> > +
> ...
> >  
> > -void blk_mq_sysfs_init(struct request_queue *q)
> > +int blk_mq_sysfs_init(struct request_queue *q)
> >  {
> >  	struct blk_mq_ctx *ctx;
> >  	int cpu;
> > +	struct blk_mq_kobj *mq_kobj;
> > +
> > +	mq_kobj = kzalloc(sizeof(struct blk_mq_kobj), GFP_KERNEL);
> > +	if (!mq_kobj)
> > +		return -ENOMEM;
> >  
> > -	kobject_init(&q->mq_kobj, &blk_mq_ktype);
> > +	kobject_init(&mq_kobj->kobj, &blk_mq_ktype);
> >  
> >  	for_each_possible_cpu(cpu) {
> > -		ctx = per_cpu_ptr(q->queue_ctx, cpu);
> > +		ctx = kzalloc_node(sizeof(*ctx), GFP_KERNEL, cpu_to_node(cpu));
> > +		if (!ctx)
> > +			goto fail;
> > +		*per_cpu_ptr(q->queue_ctx, cpu) = ctx;
> >  		kobject_init(&ctx->kobj, &blk_mq_ctx_ktype);
> >  	}
> > +	q->mq_kobj = &mq_kobj->kobj;
> > +	return 0;
> > +
> > + fail:
> > +	for_each_possible_cpu(cpu) {
> > +		ctx = *per_cpu_ptr(q->queue_ctx, cpu);
> > +		if (ctx)
> > +			kobject_put(&ctx->kobj);
> > +	}
> > +	kobject_put(&mq_kobj->kobj);
> > +	return -ENOMEM;
> >  }
> 
> 
> blk_mq_kobj looks meaningless, why do we need it, or do I miss something ?

Right, it should have been allocated directly.

> And maybe we should allocate ctx in blk_mq_init_allocated_queue.

Looks either way is fine.


Thanks,
Ming
