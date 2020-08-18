Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E1DC433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 15:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6ABF2076E
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 15:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COhmgM0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgHRPUk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:20:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56851 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726685AbgHRPUh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 11:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597764032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lF7OS5wvPX0P7QFOyOVg3yQ8kZhM3x54esdnLGPKe3M=;
        b=COhmgM0RJpuwEk5j0quM5pZ+gDWTitppgpgK3EcoVy5WXrToo0SusgUjWqonnovbCL0X3N
        8o5IB9g/CkDu8U7f7nvym0IYqvP31GuiHtw0dw0wmZJ1bzCEtBvKOKWpqfdhNAY6V/N+4g
        dwsREyBOMRo5AotDB5kOBtVg9mj0cDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-WDOTJKkfNK6f0eukdHCSMQ-1; Tue, 18 Aug 2020 11:20:30 -0400
X-MC-Unique: WDOTJKkfNK6f0eukdHCSMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81007640C1;
        Tue, 18 Aug 2020 15:20:29 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9379D7C0AC;
        Tue, 18 Aug 2020 15:20:23 +0000 (UTC)
Date:   Tue, 18 Aug 2020 11:20:22 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, dm-devel@redhat.com
Subject: Re: [PATCH RESEND] blk-mq: insert request not through ->queue_rq
 into sw/scheduler queue
Message-ID: <20200818152022.GB6842@redhat.com>
References: <20200818090728.2696802-1-ming.lei@redhat.com>
 <92162ee6-0fa0-dafd-69b1-af285ee61044@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92162ee6-0fa0-dafd-69b1-af285ee61044@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18 2020 at 10:50am -0400,
Jens Axboe <axboe@kernel.dk> wrote:

> On 8/18/20 2:07 AM, Ming Lei wrote:
> > c616cbee97ae ("blk-mq: punt failed direct issue to dispatch list") supposed
> > to add request which has been through ->queue_rq() to the hw queue dispatch
> > list, however it adds request running out of budget or driver tag to hw queue
> > too. This way basically bypasses request merge, and causes too many request
> > dispatched to LLD, and system% is unnecessary increased.
> > 
> > Fixes this issue by adding request not through ->queue_rq into sw/scheduler
> > queue, and this way is safe because no ->queue_rq is called on this request
> > yet.
> > 
> > High %system can be observed on Azure storvsc device, and even soft lock
> > is observed. This patch reduces %system during heavy sequential IO,
> > meantime decreases soft lockup risk.
> 
> Applied, thanks Ming.

Hmm, strikes me as strange that this is occurring given the direct
insertion into blk-mq queue (bypassing scheduler) is meant to avoid 2
layers of IO merging when dm-mulipath is stacked on blk-mq path(s).  The
dm-mpath IO scheduler does all merging and underlying paths' blk-mq
request_queues are meant to just dispatch the top-level's requests.

So this change concerns me.  Feels like this design has broken down.

Could be that some other entry point was added for the
__blk_mq_try_issue_directly() code?  And it needs to be untangled away
from the dm-multipath use-case?

Apologies for not responding to this patch until now.

Mike

