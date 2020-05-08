Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4217FC38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 23:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189732184D
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 23:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPxuMMDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgEHXWt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 19:22:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727110AbgEHXWp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 19:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588980164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpHdTC3gwhEr9wVRJUc1Ku1W95y0jfMFFIn5VnQTYpQ=;
        b=YPxuMMDsjXhCkVZryFRIl7UNncb3uBLTFL+/EhRXm5yhMAG4Wb49ExIng+KqeglakidsQ5
        6lGYe0hQw/D7xfpNipetBLXSDULj4LtJneofwHNWm/0YuVSQvVMJvT2AgSgXBb/iT73+As
        d38kixAyDokOoXKevoIOfu7liPk0Ptw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-C6J1zO2PN5WKjnTJY3LGGw-1; Fri, 08 May 2020 19:22:40 -0400
X-MC-Unique: C6J1zO2PN5WKjnTJY3LGGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38A09800687;
        Fri,  8 May 2020 23:22:38 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BCD41C8;
        Fri,  8 May 2020 23:22:27 +0000 (UTC)
Date:   Sat, 9 May 2020 07:22:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Baolin Wang <baolin.wang7@gmail.com>, axboe@kernel.dk,
        ulf.hansson@linaro.org, adrian.hunter@intel.com, arnd@arndb.de,
        linus.walleij@linaro.org, paolo.valente@linaro.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch
 processing
Message-ID: <20200508232222.GA1391368@T590>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
 <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
 <20200427154645.GA1201@infradead.org>
 <e4d47000-f89c-a135-ae58-011f0e9cc39e@grimberg.me>
 <20200508214639.GA1389136@T590>
 <fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sagi,

On Fri, May 08, 2020 at 03:19:45PM -0700, Sagi Grimberg wrote:
> Hey Ming,
> 
> > > Would it make sense to elevate this flag to a request_queue flag
> > > (QUEUE_FLAG_ALWAYS_COMMIT)?
> > 
> > request queue flag usually is writable, however this case just needs
> > one read-only flag, so I think it may be better to make it as
> > tagset/hctx flag.
> 
> I actually intended it to be writable.
> 
> > > I'm thinking of a possibility that an I/O scheduler may be used
> > > to activate this functionality rather than having the driver set
> > > it necessarily...
> > 
> > Could you explain a bit why I/O scheduler should activate this
> > functionality?
> 
> Sure, I've recently seen some academic work showing the benefits
> of batching in tcp/ip based block drivers. The problem with the
> approaches taken is that I/O scheduling is exercised deep down in the
> driver, which is not the direction I'd like to go if we are want
> to adopt some of the batching concepts.
> 
> I spent some (limited) time thinking about this, and it seems to
> me that there is an opportunity to implement this as a dedicated
> I/O scheduler, and tie it to driver specific LLD stack optimizations
> (net-stack for example) relying on the commit_rq/bd->last hints.
> 
> When scanning the scheduler code, I noticed exactly the phenomenon that
> this patchset is attempting to solve and Christoph referred me to it.
> Now I'm thinking if we can extend this batching optimization for both
> use-cases.

Got it, thanks for the sharing.

> 
> > batching submission may be good for some drivers, and currently
> > we only do it in limited way. One reason is that there is extra
> > cost for full batching submission, such as this patch requires
> > one extra .commit_rqs() for each dispatch, and lock is often needed
> > in this callback.
> 
> That is not necessarily the case at all.

So far, all in-tree .commit_rqs() implementation requires lock.

> 
> > IMO it can be a win for some slow driver or device, but may cause
> > a little performance drop for fast driver/device especially in workload
> > of not-batching submission.
> 
> You're mostly correct. This is exactly why an I/O scheduler may be
> applicable here IMO. Mostly because I/O schedulers tend to optimize for
> something specific and always present tradeoffs. Users need to
> understand what they are optimizing for.
> 
> Hence I'd say this functionality can definitely be available to an I/O
> scheduler should one exist.
> 

I guess it is just that there can be multiple requests available from
scheduler queue. Actually it can be so for other non-nvme drivers in
case of none, such as SCSI.

Another way is to use one per-task list(such as plug list) to hold the
requests for dispatch, then every drivers may see real .last flag, so they
may get chance for optimizing batch queuing. I will think about the
idea further and see if it is really doable.


Thanks,
Ming

