Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8114C2BA19
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B337D208E4
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYxb5Bzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDYDlf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:41:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32927 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgDYDle (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 23:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587786093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BjgTu9oFvJfopnPd/N0KzmpbHdaIp3ACNuNPM6lQW8=;
        b=HYxb5BzjAw/4w4I80vZuRqtINiZD+6rDbBimfAozlXhhb++0/WvgnkdSY0H9QB6Au/sOXZ
        yAlaboDpSpVJzWgfHeySU8XFAnD/w6abKirhtDe8uVVGsQjFJeGy4BS56JabQOeY+BMDZn
        g3qn81w6rUcvmyF1fQmjgCIYxnUh2DI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-cMXnxJecN_GKAwk1nQJcRg-1; Fri, 24 Apr 2020 23:41:29 -0400
X-MC-Unique: cMXnxJecN_GKAwk1nQJcRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BD14107ACF3;
        Sat, 25 Apr 2020 03:41:27 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0945E5D714;
        Sat, 25 Apr 2020 03:41:19 +0000 (UTC)
Date:   Sat, 25 Apr 2020 11:41:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200425034113.GF477579@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com>
 <bce125a3-0e27-5077-c441-8056307da0b9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bce125a3-0e27-5077-c441-8056307da0b9@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 02:42:06PM +0100, John Garry wrote:
> On 24/04/2020 11:23, Ming Lei wrote:
> >   static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
> >   {
> > +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> > +			struct blk_mq_hw_ctx, cpuhp_online);
> > +
> > +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> > +		return 0;
> > +
> > +	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu) ||
> > +	    (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids))
> > +		return 0;
> 
> 
> nit: personally I prefer what we had previously, as it was easier to read,
> even if it did cause the code to be indented:
> 
> 	if ((cpumask_next_and(-1, cpumask, online_mask) == cpu) &&
> 	    (cpumask_next_and(cpu, cpumask, online_mask) >= nr_cpu_ids)) {
> 		// do deactivate
> 	}

I will document what the check does, given it can save us one level of
indentation.

> 
> 	return 0	
> 
> and it could avoid the cpumask_test_cpu() test, unless you want that as an
> optimisation. If so, a comment could help.

cpumask_test_cpu() is more readable, and should be pattern for doing
this stuff in cpuhp handler, cause the handler is called for any CPU
to be offline.


Thanks, 
Ming

