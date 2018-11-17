Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D6AC43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 02:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6422075B
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 02:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6422075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbeKQMt0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:49:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbeKQMt0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Nov 2018 07:49:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33F123082AFB;
        Sat, 17 Nov 2018 02:34:29 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D10176051E;
        Sat, 17 Nov 2018 02:34:23 +0000 (UTC)
Date:   Sat, 17 Nov 2018 10:34:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V2 for-4.21 2/2] blk-mq: alloc q->queue_ctx as normal
 array
Message-ID: <20181117023417.GC8872@ming.t460p>
References: <20181116112311.4117-1-ming.lei@redhat.com>
 <20181116112311.4117-3-ming.lei@redhat.com>
 <20181116140623.GC4595@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116140623.GC4595@kroah.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sat, 17 Nov 2018 02:34:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 06:06:23AM -0800, Greg Kroah-Hartman wrote:
> On Fri, Nov 16, 2018 at 07:23:11PM +0800, Ming Lei wrote:
> > Now q->queue_ctx is just one read-mostly table for query the
> > 'blk_mq_ctx' instance from one cpu index, it isn't necessary
> > to allocate it as percpu variable. One simple array may be
> > more efficient.
> 
> "may be", have you run benchmarks to be sure?  If so, can you add the
> results of them to this changelog?  If there is no measurable
> difference, then why make this change at all?

__blk_mq_get_ctx() is used in fast path, what do you think about which
one is more efficient?

- *per_cpu_ptr(q->queue_ctx, cpu);

- q->queue_ctx[cpu]

At least the latter isn't worse than the former.

Especially q->queue_ctx is just a read-only look-up table, it doesn't
make sense to make it percpu any more.

Not mention q->queue_ctx[cpu] is more clean/readable.

Thanks,
Ming
