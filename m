Return-Path: <SRS0=o2oO=3A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0D7C33CA2
	for <linux-block@archiver.kernel.org>; Sat, 11 Jan 2020 02:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAE620721
	for <linux-block@archiver.kernel.org>; Sat, 11 Jan 2020 02:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vy5ZskNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgAKCsz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jan 2020 21:48:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53385 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728120AbgAKCsy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jan 2020 21:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578710933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yyBF0xPIxCR6ZxPQyowHmzsUIxzVycle+XUdhruB+uU=;
        b=Vy5ZskNf7b933SSZcXVt6XFsLhHPEwa0+yDkG8/hfouYguW37FzIo3qhaG9qkS+0ZHqLyK
        H2NQW/RL8c4gpzEZzgt1n99SYERIqEXaWJLze9pHbkgwOWk+UkTVrDhMqz+zfUPMVU/Y4/
        SJZP7nLm4KuZrwOZx1s5k1i2e83l1ro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-bc-YXPzBO-Grb9vXyF4O6A-1; Fri, 10 Jan 2020 21:48:51 -0500
X-MC-Unique: bc-YXPzBO-Grb9vXyF4O6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 623841800D4E;
        Sat, 11 Jan 2020 02:48:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 617118068F;
        Sat, 11 Jan 2020 02:48:39 +0000 (UTC)
Date:   Sat, 11 Jan 2020 10:48:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Xu <peterx@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Ming Lei <minlei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: Kernel-managed IRQ affinity (cont)
Message-ID: <20200111024835.GA24575@ming.t460p>
References: <20191216195712.GA161272@xz-x1>
 <20191219082819.GB15731@ming.t460p>
 <20191219143214.GA50561@xz-x1>
 <20191219161115.GA18672@ming.t460p>
 <87eew8l7oz.fsf@nanos.tec.linutronix.de>
 <20200110012802.GA4501@ming.t460p>
 <87v9pjrtbh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9pjrtbh.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Thomas,

On Fri, Jan 10, 2020 at 08:43:14PM +0100, Thomas Gleixner wrote:
> Ming,
> 
> Ming Lei <ming.lei@redhat.com> writes:
> > On Thu, Jan 09, 2020 at 09:02:20PM +0100, Thomas Gleixner wrote:
> >> Ming Lei <ming.lei@redhat.com> writes:
> >>
> >> This is duct tape engineering with absolutely no semantics. I can't even
> >> figure out the intent of this 'managed_irq' parameter.
> >
> > The intent is to isolate the specified CPUs from handling managed
> > interrupt.
> 
> That's what I figured, but it still does not provide semantics and works
> just for specific cases.
> 
> > We can do that. The big problem is that the RT case can't guarantee that
> > IO won't be submitted from isolated CPU always. blk-mq's queue mapping
> > relies on the setup affinity, so un-known behavior(kernel crash, or io
> > hang, or other) may be caused if we exclude isolated CPUs from interrupt
> > affinity.
> >
> > That is why I try to exclude isolated CPUs from interrupt effective affinity,
> > turns out the approach is simple and doable.
> 
> Yes, it's doable. But it still is inconsistent behaviour. Assume the
> following configuration:
> 
>   8 CPUs CPU0,1 assigned for housekeeping
> 
> With 8 queues the proposed change does nothing because each queue is
> mapped to exactly one CPU.

That is expected behavior for this RT case, given userspace won't submit
IO from isolated CPUs.

> 
> With 4 queues you get the following:
> 
>  CPU0,1       queue 0
>  CPU2,3       queue 1
>  CPU4,5       queue 2
>  CPU6,7       queue 3
> 
> No effect on the isolated CPUs either.
> 
> With 2 queues you get the following:
> 
>  CPU0,1,2,3   queue 0
>  CPU4,5,6,7   queue 1
> 
> So here the isolated CPUs 2 and 3 get the isolation, but 4-7
> not. That's perhaps intended, but definitely not documented.

That is intentional change, given no IO will be submitted from 4-7
most of times in RT case, so it is fine to select effective CPU from
isolated CPUs in this case. As peter mentioned, IO may just be submitted
from isolated CPUs during booting. Once the system is setup, no IO
comes from isolated CPUs, then no interrupt is delivered to isolated
CPUs, then meet RT's requirement.

We can document this change somewhere.

> 
> So you really need to make your mind up and describe what the intended
> effect of this is and why you think that the result is correct.

In short, if there is at least one housekeeping available in the
interrupt's affinity, we choose effective CPU from housekeeping CPUs.
Otherwise, keep the current behavior wrt. selecting effective CPU.

With this approach, no interrupts can be delivered to isolated CPUs
if no IOs are submitted from these CPUs.

Please let us know if it addresses your concerns.


Thanks,
Ming

