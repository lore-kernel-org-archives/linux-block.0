Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F3CC4727C
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 15:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F54206C1
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 15:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNb0TCAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgJAPi3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 11:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732104AbgJAPi3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Oct 2020 11:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601566707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JgrEZ8j9/nFRaKvjMm0r5U5f27doNCfVkl4QLjZxDI4=;
        b=MNb0TCAvryeES+5s+u00uJWDR3/GA4/03M6HQUcxc251ons1gsFAPLnqGsuQFYPpg7ZDeV
        mkxkUtqp8A+9EDj1T8vASArhDmMnlAXhooy2p6aOx7YSeg9Os1FRwh8wAkXSZiYfXn9AN+
        PTHwle0bkJ6kIdalVlHQ6zVcECBGuxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-ZMUhCtafNMmLsDo3SeWcpw-1; Thu, 01 Oct 2020 11:38:24 -0400
X-MC-Unique: ZMUhCtafNMmLsDo3SeWcpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C504B803654;
        Thu,  1 Oct 2020 15:38:17 +0000 (UTC)
Received: from T590 (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB4E178807;
        Thu,  1 Oct 2020 15:38:10 +0000 (UTC)
Date:   Thu, 1 Oct 2020 23:38:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Veronika Kabatova <vkabatov@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V6 1/2] percpu_ref: reduce memory footprint of percpu_ref
 in fast path
Message-ID: <20201001153806.GA23222@T590>
References: <20200930082657.3305143-1-ming.lei@redhat.com>
 <20200930082657.3305143-2-ming.lei@redhat.com>
 <20200930160015.GC4441@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930160015.GC4441@mtj.duckdns.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 30, 2020 at 12:00:15PM -0400, Tejun Heo wrote:
> On Wed, Sep 30, 2020 at 04:26:56PM +0800, Ming Lei wrote:
> > diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> > index 87d8a38bdea1..1d6ed9ca23dd 100644
> > --- a/include/linux/percpu-refcount.h
> > +++ b/include/linux/percpu-refcount.h
> > @@ -92,18 +92,23 @@ enum {
> >  	PERCPU_REF_ALLOW_REINIT	= 1 << 2,
> >  };
> >  
> > -struct percpu_ref {
> > +struct percpu_ref_data {
> >  	atomic_long_t		count;
> > -	/*
> > -	 * The low bit of the pointer indicates whether the ref is in percpu
> > -	 * mode; if set, then get/put will manipulate the atomic_t.
> > -	 */
> > -	unsigned long		percpu_count_ptr;
> >  	percpu_ref_func_t	*release;
> >  	percpu_ref_func_t	*confirm_switch;
> >  	bool			force_atomic:1;
> >  	bool			allow_reinit:1;
> >  	struct rcu_head		rcu;
> > +	struct percpu_ref	*ref;
> > +};
> > +
> > +struct percpu_ref {
> > +	/*
> > +	 * The low bit of the pointer indicates whether the ref is in percpu
> > +	 * mode; if set, then get/put will manipulate the atomic_t.
> > +	 */
> > +	unsigned long		percpu_count_ptr;
> > +	struct percpu_ref_data  *data;
> >  };
> 
> Can you please add a comment explaining why the two structs are split?

Sure, will do that in next version.

Thanks,
Ming

