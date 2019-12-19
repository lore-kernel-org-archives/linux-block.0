Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7B6C2D0C1
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 09:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEC8222C2
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 09:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6O/ELJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLSJxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:53:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40038 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbfLSJxM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 04:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576749190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6eLS+RD3PrF/L2GmRewPcpKSXS+7zr3MRzumDCPi/Y=;
        b=O6O/ELJ9lufhZx5lvy4qVbkFmP4RZAcInRNyR/q0E0NE6cRfEpCHqohpi8g+i+ml+s1m97
        gR0UH0JF5RpxRwLRfzXAq3Ryznvr9raPqXZVLONqdOKITwBegToOkmONjNla8dQFhlYoz/
        o7EiUkoKrJf0GRALf5ybfLKbCQuoffM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-tFWlbq_WMWqg9cmdtTmDdw-1; Thu, 19 Dec 2019 04:53:04 -0500
X-MC-Unique: tFWlbq_WMWqg9cmdtTmDdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F10ADB60;
        Thu, 19 Dec 2019 09:53:02 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B32F60BC7;
        Thu, 19 Dec 2019 09:52:54 +0000 (UTC)
Date:   Thu, 19 Dec 2019 17:52:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Long Li <longli@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH 2/3] softirq: implement interrupt flood detection
Message-ID: <20191219095249.GA30537@ming.t460p>
References: <20191218071942.22336-1-ming.lei@redhat.com>
 <20191218071942.22336-3-ming.lei@redhat.com>
 <20191218104941.GR2844@hirez.programming.kicks-ass.net>
 <20191219015948.GB6080@ming.t460p>
 <20191219092319.GX2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219092319.GX2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 19, 2019 at 10:23:19AM +0100, Peter Zijlstra wrote:
> On Thu, Dec 19, 2019 at 09:59:48AM +0800, Ming Lei wrote:
> > > So pray tell, why did you not integrate this with IRQ_TIME_ACCOUNTING ?
> > > That already takes a timestamp and does most of what you need.
> > 
> > Yeah, that was the 1st approach I thought of, but IRQ_TIME_ACCOUNTING
> > may be disabled, and enabling it may cause observable effect on IO
> > performance.
> 
> Is that an actual concern, are people disabling it?

For example, it is only enabled for x86 on RHEL8.

And the interrupt flood issue is easier to trigger on other ARCH,
for example, John reported the issue on arm64:

https://lore.kernel.org/lkml/a7ef3810-31af-013a-6d18-ceb6154aa2ef@huawei.com/

> 
> > > > @@ -356,6 +512,7 @@ void irq_enter(void)
> > > >  	}
> > > >  
> > > >  	__irq_enter();
> > > > +	irq_interval_update();
> > > >  }
> > > 
> > > Arggh.. you're going to make every single interrupt take at least 2
> > > extra cache misses for this gunk?!?
> > 
> > Could you explain it a bit why two cache misses are involved?
> > 
> > I understand at most one miss is caused, which should only happen in
> > irq_interval_update(), and what is the other one?
> 
> The rq clock thing IIRC.

OK.

But task is often waken up by interrupt event, I guess the rq clock
thing should be fine.


Thanks, 
Ming

