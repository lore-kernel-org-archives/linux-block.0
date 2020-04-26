Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0158BC55186
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 02:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA40A2071E
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 02:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoiW6ily"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDZCGl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 22:06:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30128 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726119AbgDZCGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 22:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587866799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x80vlw6KAzuPmxphBRqwYQrzgQHudlcWb8SCuJOiD1o=;
        b=NoiW6ilyelK7hcJ/ofrwZ6q36SZ59ApIp0eNU3eB0Dk06jXiU3+ldmmmOcHSS8FAoon4f8
        h1wbb44A4fJclvaZjWVq5pI2RI6PzUrN5BQX8SeXnTqEMvZzXO5pkx0/to6OEbJqdQaXq0
        EajCNkPvhhRr8xv0YW5d9nzNjiGrYXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-YwXPeGEkMxq4Rj7LC98sew-1; Sat, 25 Apr 2020 22:06:37 -0400
X-MC-Unique: YwXPeGEkMxq4Rj7LC98sew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADBAB1005510;
        Sun, 26 Apr 2020 02:06:35 +0000 (UTC)
Received: from T590 (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8927D10013A1;
        Sun, 26 Apr 2020 02:06:26 +0000 (UTC)
Date:   Sun, 26 Apr 2020 10:06:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        peterz@infradead.org, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200426020621.GA511475@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com>
 <20200424103851.GD28156@lst.de>
 <20200425031723.GC477579@T590>
 <20200425083224.GA5634@lst.de>
 <20200425093437.GA495669@T590>
 <20200425095351.GC495669@T590>
 <20200425154832.GA16004@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425154832.GA16004@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
> FYI, here is what I think we should be doing (but the memory model
> experts please correct me):
> 
>  - just drop the direct_issue flag and check for the CPU, which is
>    cheap enough

That isn't correct because the CPU for running async queue may not be
same with rq->mq_ctx->cpu since hctx->cpumask may include several CPUs
and we run queue in RR style and it is really a normal case.

So I'd rather to keep 'direct_issue' flag given it is just a constant
argument and gcc is smart enough to optimize this case if you don't have
better idea.

>  - replace the raw_smp_processor_id with a get_cpu to make sure we
>    don't hit the tiny migration windows

Will do that.

>  - a bunch of random cleanups to make the code easier to read, mostly
>    by being more self-documenting or improving the comments.

The cleanup code looks fine.


Thanks, 
Ming

