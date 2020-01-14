Return-Path: <SRS0=JLuE=3D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE32BC33C9E
	for <linux-block@archiver.kernel.org>; Tue, 14 Jan 2020 23:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC252075B
	for <linux-block@archiver.kernel.org>; Tue, 14 Jan 2020 23:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRomDGNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgANXic (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:38:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728656AbgANXib (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jan 2020 18:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579045111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GUAdJUKTIjqZ8UnAr0WHyyOOhCddPy1gM8C7ltHr6Bc=;
        b=XRomDGNa3xZKv3R/QV35Sx3NO0W54zG1L+h2xGDStdHLOqRoc0fJ5VAO+JFWeJalc+T4gI
        xVRbvBg9mfMWx16mRVzpXdBYFioLD8KlcWoqNmHPix8Gti9FZxFMwDj9atPINNWixgEGsI
        TCK8UjA2R/K+VksF7PnwngdsqpYwGgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-1O9xelYaNtOOPnOOt9HTOw-1; Tue, 14 Jan 2020 18:38:30 -0500
X-MC-Unique: 1O9xelYaNtOOPnOOt9HTOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EFE3801E7B;
        Tue, 14 Jan 2020 23:38:29 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 308F67BA48;
        Tue, 14 Jan 2020 23:38:18 +0000 (UTC)
Date:   Wed, 15 Jan 2020 07:38:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Xu <peterx@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Ming Lei <minlei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: Kernel-managed IRQ affinity (cont)
Message-ID: <20200114233814.GA6281@ming.t460p>
References: <20191216195712.GA161272@xz-x1>
 <20191219082819.GB15731@ming.t460p>
 <20191219143214.GA50561@xz-x1>
 <20191219161115.GA18672@ming.t460p>
 <87eew8l7oz.fsf@nanos.tec.linutronix.de>
 <20200110012802.GA4501@ming.t460p>
 <87v9pjrtbh.fsf@nanos.tec.linutronix.de>
 <20200111024835.GA24575@ming.t460p>
 <87r202b19f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r202b19f.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Thomas,

On Tue, Jan 14, 2020 at 02:45:00PM +0100, Thomas Gleixner wrote:
> Ming,
> 
> Ming Lei <ming.lei@redhat.com> writes:
> > On Fri, Jan 10, 2020 at 08:43:14PM +0100, Thomas Gleixner wrote:
> >> Ming Lei <ming.lei@redhat.com> writes:
> >> > That is why I try to exclude isolated CPUs from interrupt effective affinity,
> >> > turns out the approach is simple and doable.
> >> 
> >> Yes, it's doable. But it still is inconsistent behaviour. Assume the
> >> following configuration:
> >> 
> >>   8 CPUs CPU0,1 assigned for housekeeping
> >> 
> >> With 8 queues the proposed change does nothing because each queue is
> >> mapped to exactly one CPU.
> >
> > That is expected behavior for this RT case, given userspace won't submit
> > IO from isolated CPUs.
> 
> What is _this_ RT case? We really don't implement policy for a specific
> use case. If the kernel implements a policy then it has to be generally
> useful and practical.

Maybe the word of 'RT case' isn't accurate, I thought isolated CPUs is only
used for realtime cases, at least that is Peter's usage, maybe I was
wrong.

But it can be generic for all isolated CPUs cases, in which users
don't want managed interrupts to disturb the isolated CPU cores.

> 
> >> With 4 queues you get the following:
> >> 
> >>  CPU0,1       queue 0
> >>  CPU2,3       queue 1
> >>  CPU4,5       queue 2
> >>  CPU6,7       queue 3
> >> 
> >> No effect on the isolated CPUs either.
> >> 
> >> With 2 queues you get the following:
> >> 
> >>  CPU0,1,2,3   queue 0
> >>  CPU4,5,6,7   queue 1
> >> 
> >> So here the isolated CPUs 2 and 3 get the isolation, but 4-7
> >> not. That's perhaps intended, but definitely not documented.
> >
> > That is intentional change, given no IO will be submitted from 4-7
> > most of times in RT case, so it is fine to select effective CPU from
> > isolated CPUs in this case. As peter mentioned, IO may just be submitted
> > from isolated CPUs during booting. Once the system is setup, no IO
> > comes from isolated CPUs, then no interrupt is delivered to isolated
> > CPUs, then meet RT's requirement.
> 
> Again. This is a specific usecase. Is this generally applicable?

As mentioned above, it can be applied for all isolated CPUs, when users
don't want managed interrupts to disturb these CPU cores.

> 
> > We can document this change somewhere.
> 
> Yes, this needs to be documented very clearly with that command line
> parameter.

OK, will do that in formal post.

Thanks, 
Ming

