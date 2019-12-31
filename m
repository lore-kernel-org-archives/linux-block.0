Return-Path: <SRS0=i4wP=2V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB4BC2D0C8
	for <linux-block@archiver.kernel.org>; Tue, 31 Dec 2019 03:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DAE2072A
	for <linux-block@archiver.kernel.org>; Tue, 31 Dec 2019 03:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+5PW9F0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLaDs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Dec 2019 22:48:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40663 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfLaDs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Dec 2019 22:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577764107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T41TJJpxPYBHJMFuPA9JfcNOm0gemAx83L61y+CFr64=;
        b=H+5PW9F0XJABpeYocp4C9Q3nchlcIDwWE+UdG09Y1VT2OgLzU62JjD5x7x+pth5GFlgPjv
        jGrU13Bnpcm9ex1W5IaNLJssAROXGb2+77f9Hd9mWACVGGbLf4L6XiKCkZryC/trNQ1yZV
        izagSi1bbkAN1T/nQz7SWaGG0OqJxwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-sCfCPpzEO0aHpTQFZqpQ1g-1; Mon, 30 Dec 2019 22:48:23 -0500
X-MC-Unique: sCfCPpzEO0aHpTQFZqpQ1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E47D4800D41;
        Tue, 31 Dec 2019 03:48:20 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9770C5C1D4;
        Tue, 31 Dec 2019 03:48:11 +0000 (UTC)
Date:   Tue, 31 Dec 2019 11:48:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Long Li <longli@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH 2/3] softirq: implement interrupt flood detection
Message-ID: <20191231034806.GB20062@ming.t460p>
References: <20191218071942.22336-1-ming.lei@redhat.com>
 <20191218071942.22336-3-ming.lei@redhat.com>
 <20191218104941.GR2844@hirez.programming.kicks-ass.net>
 <20191219015948.GB6080@ming.t460p>
 <20191219092319.GX2844@hirez.programming.kicks-ass.net>
 <20191219104347.ql6shgh2x7hk6iid@boron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219104347.ql6shgh2x7hk6iid@boron>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 19, 2019 at 11:43:47AM +0100, Daniel Wagner wrote:
> Hi,
> 
> On Thu, Dec 19, 2019 at 10:23:19AM +0100, Peter Zijlstra wrote:
> > On Thu, Dec 19, 2019 at 09:59:48AM +0800, Ming Lei wrote:
> > > > So pray tell, why did you not integrate this with IRQ_TIME_ACCOUNTING ?
> > > > That already takes a timestamp and does most of what you need.
> > > 
> > > Yeah, that was the 1st approach I thought of, but IRQ_TIME_ACCOUNTING
> > > may be disabled, and enabling it may cause observable effect on IO
> > > performance.
> > 
> > Is that an actual concern, are people disabling it?
> 
> In SLE and openSUSE kernels it is disabled for x86_64 at this
> point. And if I am not completely misstaken only x86_64 supports it at
> this point. I was looking at enable_sched_clock_irqtime() which is
> only called from x86_64.
> 
> Another thing I noticed get_util_irq() is defined in
> kernel/sched/sched.h. I don't think the block/blq-mq.c driver should
> include it direclty.

get_util_irq() only works in case of HAVE_SCHED_AVG_IRQ which depends
on IRQ_TIME_ACCOUNTING or PARAVIRT_TIME_ACCOUNTING.

Also rq->avg_irq.util_avg is only updated when there is scheduler
activities. However, when interrupt flood happens, scheduler can't
have chance to be called. Looks get_util_irq() can't be relied on
for this task.

> 
> Thanks,
> Daniel
> 
> ps: A customer observes the same problem as Ming is reporting.

Actually this issue should be more serious on ARM64 system, in which
there are more CPU cores, and each CPU core is often slower than
x86's, and each interrupt is only delivered to single CPU target.

Meantime the storage device performance is same for the two kinds of
systems.


Thanks,
Ming

