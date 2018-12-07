Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CADC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CE920892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CE920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbeLGDyv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:54:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbeLGDyv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 22:54:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3511C0528D3;
        Fri,  7 Dec 2018 03:54:50 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C34F5C1A1;
        Fri,  7 Dec 2018 03:54:50 +0000 (UTC)
Date:   Thu, 6 Dec 2018 22:54:49 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2] block/dm: fix handling of busy off direct dispatch
 path
Message-ID: <20181207035449.GB17585@redhat.com>
References: <e6024b99-579a-ce20-ca3a-a9983582ea36@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6024b99-579a-ce20-ca3a-a9983582ea36@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 07 Dec 2018 03:54:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06 2018 at  9:49pm -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> After the direct dispatch corruption fix, we permanently disallow direct
> dispatch of non read/write requests. This works fine off the normal IO
> path, as they will be retried like any other failed direct dispatch
> request. But for the blk_insert_cloned_request() that only DM uses to
> bypass the bottom level scheduler, we always first attempt direct
> dispatch. For some types of requests, that's now a permanent failure,
> and no amount of retrying will make that succeed.
> 
> Use the driver private RQF_DONTPREP to track this condition in DM. If
> we encounter a BUSY condition from blk_insert_cloned_request(), then
> flag the request with RQF_DONTPREP. When we next time see this request,
> ask blk_insert_cloned_request() to bypass insert the request directly.
> This avoids the livelock of repeatedly trying to direct dispatch a
> request, while still retaining the BUSY feedback loop for blk-mq so
> that we don't over-dispatch to the lower level queue and mess up
> opportunities for merging on the DM queue.
> 
> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> This passes my testing as well, like the previous patch. But unlike the
> previous patch, we retain the BUSY feedback loop information for better
> merging.

But it is kind of gross to workaround the new behaviour to "permanently
disallow direct dispatch of non read/write requests" by always failing
such requests back to DM for later immediate direct dispatch.  That
bouncing of the request was acceptable when there was load-based
justification for having to retry (and in doing so: taking the cost of
freeing the clone request gotten via get_request() from the underlying
request_queues).

Having to retry like this purely because the request isn't a read or
write seems costly.. every non-read-write will have implied
request_queue bouncing.  In multipath's case: it could select an
entirely different underlying path the next time it is destaged (with
RQF_DONTPREP set).  Which you'd think would negate all hope of IO
merging based performance improvements -- but that is a tangent I'll
need to ask Ming about (again).

I really don't like this business of bouncing requests as a workaround
for the recent implementation of the corruption fix.

Why not just add an override flag to _really_ allow direct dispatch for
_all_ types of requests?

(just peeked at linux-block and it is looking like you took 
jianchao.wang's series to avoid this hack... ;)

Awesome.. my work is done for tonight!

Mike
