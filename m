Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13784C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D6520892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 15:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D6520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLGPPN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:15:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeLGPPN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Dec 2018 10:15:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDFBC87621;
        Fri,  7 Dec 2018 15:15:12 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E94F479D62;
        Fri,  7 Dec 2018 15:15:08 +0000 (UTC)
Date:   Fri, 7 Dec 2018 10:15:08 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3] blk-mq: punt failed direct issue to dispatch list
Message-ID: <20181207151507.GA20544@redhat.com>
References: <aa6abfa7-30c3-57d7-7369-754d514584f5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6abfa7-30c3-57d7-7369-754d514584f5@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 07 Dec 2018 15:15:12 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 07 2018 at 12:17am -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> After the direct dispatch corruption fix, we permanently disallow direct
> dispatch of non read/write requests. This works fine off the normal IO
> path, as they will be retried like any other failed direct dispatch
> request. But for the blk_insert_cloned_request() that only DM uses to
> bypass the bottom level scheduler, we always first attempt direct
> dispatch. For some types of requests, that's now a permanent failure,
> and no amount of retrying will make that succeed. This results in a
> livelock.
> 
> Instead of making special cases for what we can direct issue, and now
> having to deal with DM solving the livelock while still retaining a BUSY
> condition feedback loop, always just add a request that has been through
> ->queue_rq() to the hardware queue dispatch list. These are safe to use
> as no merging can take place there. Additionally, if requests do have
> prepped data from drivers, we aren't dependent on them not sharing space
> in the request structure to safely add them to the IO scheduler lists.
> 
> This basically reverts ffe81d45322c and is based on a patch from Ming,
> but with the list insert case covered as well.
> 
> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
> Cc: stable@vger.kernel.org
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good, thanks!

Acked-by: Mike Snitzer <snitzer@redhat.com>
