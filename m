Return-Path: <SRS0=/LTC=27=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13F5C32771
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 01:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DCE2072E
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 01:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXhgzDhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgAJB2W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:28:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60269 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730575AbgAJB2V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Jan 2020 20:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578619700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LSyKA3j/3j2EtToo9WAdYh474h7JYo+Na8uCUw7EHS4=;
        b=WXhgzDhdBAJX0QNA6pwIY/I9/XdWZA+JQq05zBkjs5Ahuq1/vLkUsX2SLTc6fLVCEXFQVM
        Tj6kpnKcBsDvEdsm5R4zF0qbH0AVi2S9sRyiGUZWsoWIYlOQQc79vK0nJhVQVf4+vCIGIF
        pBuVaRHiDuduuImrP0NTa916LsZQ7rE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-ecGkSfZ6Pzy1gJ8MEkslLw-1; Thu, 09 Jan 2020 20:28:19 -0500
X-MC-Unique: ecGkSfZ6Pzy1gJ8MEkslLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFDF9800EBF;
        Fri, 10 Jan 2020 01:28:17 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E613D86CA7;
        Fri, 10 Jan 2020 01:28:06 +0000 (UTC)
Date:   Fri, 10 Jan 2020 09:28:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Xu <peterx@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Ming Lei <minlei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: Kernel-managed IRQ affinity (cont)
Message-ID: <20200110012802.GA4501@ming.t460p>
References: <20191216195712.GA161272@xz-x1>
 <20191219082819.GB15731@ming.t460p>
 <20191219143214.GA50561@xz-x1>
 <20191219161115.GA18672@ming.t460p>
 <87eew8l7oz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eew8l7oz.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Thomas,

On Thu, Jan 09, 2020 at 09:02:20PM +0100, Thomas Gleixner wrote:
> Ming,
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > On Thu, Dec 19, 2019 at 09:32:14AM -0500, Peter Xu wrote:
> >> ... this one seems to be more appealing at least to me.
> >
> > OK, please try the following patch:
> >
> >
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index 6c8512d3be88..0fbcbacd1b29 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -13,6 +13,7 @@ enum hk_flags {
> >  	HK_FLAG_TICK		= (1 << 4),
> >  	HK_FLAG_DOMAIN		= (1 << 5),
> >  	HK_FLAG_WQ		= (1 << 6),
> > +	HK_FLAG_MANAGED_IRQ	= (1 << 7),
> >  };
> >  
> >  #ifdef CONFIG_CPU_ISOLATION
> > diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> > index 1753486b440c..0a75a09cc4e8 100644
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/sched/task.h>
> >  #include <uapi/linux/sched/types.h>
> >  #include <linux/task_work.h>
> > +#include <linux/sched/isolation.h>
> >  
> >  #include "internals.h"
> >  
> > @@ -212,12 +213,33 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
> >  {
> >  	struct irq_desc *desc = irq_data_to_desc(data);
> >  	struct irq_chip *chip = irq_data_get_irq_chip(data);
> > +	const struct cpumask *housekeeping_mask =
> > +		housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
> >  	int ret;
> > +	cpumask_var_t tmp_mask;
> >  
> >  	if (!chip || !chip->irq_set_affinity)
> >  		return -EINVAL;
> >  
> > -	ret = chip->irq_set_affinity(data, mask, force);
> > +	if (!zalloc_cpumask_var(&tmp_mask, GFP_KERNEL))
> > +		return -EINVAL;
> 
> That's wrong. This code is called with interrupts disabled, so
> GFP_KERNEL is wrong. And NO, we won't do a GFP_ATOMIC allocation here.

OK, looks desc->lock is held.

> 
> > +	/*
> > +	 * Userspace can't change managed irq's affinity, make sure
> > +	 * that isolated CPU won't be selected as the effective CPU
> > +	 * if this irq's affinity includes both isolated CPU and
> > +	 * housekeeping CPU.
> > +	 *
> > +	 * This way guarantees that isolated CPU won't be interrupted
> > +	 * by IO submitted from housekeeping CPU.
> > +	 */
> > +	if (irqd_affinity_is_managed(data) &&
> > +			cpumask_intersects(mask, housekeeping_mask))
> > +		cpumask_and(tmp_mask, mask, housekeeping_mask);
> 
> This is duct tape engineering with absolutely no semantics. I can't even
> figure out the intent of this 'managed_irq' parameter.

The intent is to isolate the specified CPUs from handling managed interrupt.

For non-managed interrupt, the isolation is done via userspace because
userspace is allowed to change non-manage interrupt's affinity.

> 
> If the intent is to keep managed device interrupts away from isolated
> cores then you really want to do that when the interrupts are spread and
> not in the middle of the affinity setter code.
> 
> But first you need to define how that mask should work:
> 
>  1) Exclude CPUs from managed interrupt spreading completely
> 
>  2) Exclude CPUs only when the resulting spreading contains
>     housekeeping CPUs
> 
>  3) Whatever ...

We can do that. The big problem is that the RT case can't guarantee that
IO won't be submitted from isolated CPU always. blk-mq's queue mapping
relies on the setup affinity, so un-known behavior(kernel crash, or io
hang, or other) may be caused if we exclude isolated CPUs from interrupt
affinity.

That is why I try to exclude isolated CPUs from interrupt effective affinity,
turns out the approach is simple and doable.


Thanks,
Ming

