Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86219C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 03:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6F62075E
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 03:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfCSDvD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfCSDvD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 23:51:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C9A63084269;
        Tue, 19 Mar 2019 03:51:03 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 017785D704;
        Tue, 19 Mar 2019 03:50:57 +0000 (UTC)
Date:   Tue, 19 Mar 2019 11:50:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     James Smart <james.smart@broadcom.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Message-ID: <20190319035052.GC22459@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <4563485a-02c6-0bfe-d9ec-49adbd44671c@broadcom.com>
 <20190319010601.GA22459@ming.t460p>
 <606d3477-e7ed-d876-f132-11627a77a760@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <606d3477-e7ed-d876-f132-11627a77a760@broadcom.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 19 Mar 2019 03:51:03 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 18, 2019 at 08:37:35PM -0700, James Smart wrote:
> 
> 
> On 3/18/2019 6:06 PM, Ming Lei wrote:
> > On Mon, Mar 18, 2019 at 10:37:08AM -0700, James Smart wrote:
> > > 
> > > On 3/17/2019 8:29 PM, Ming Lei wrote:
> > > > In NVMe's error handler, follows the typical steps for tearing down
> > > > hardware:
> > > > 
> > > > 1) stop blk_mq hw queues
> > > > 2) stop the real hw queues
> > > > 3) cancel in-flight requests via
> > > > 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
> > > > cancel_request():
> > > > 	mark the request as abort
> > > > 	blk_mq_complete_request(req);
> > > > 4) destroy real hw queues
> > > > 
> > > > However, there may be race between #3 and #4, because blk_mq_complete_request()
> > > > actually completes the request asynchronously.
> > > > 
> > > > This patch introduces blk_mq_complete_request_sync() for fixing the
> > > > above race.
> > > > 
> > > This won't help FC at all. Inherently, the "completion" has to be
> > > asynchronous as line traffic may be required.
> > > 
> > > e.g. FC doesn't use nvme_complete_request() in the iterator routine.
> > Yeah, I saw the FC code, it is supposed to address the asynchronous
> > completion of blk_mq_complete_request() in error handler.
> > 
> > Also I think it is always the correct thing to abort requests
> > synchronously in error handler, isn't it?
> > 
> 
> not sure I fully follow you, but if you're asking shouldn't it always be
> synchronous - why would that be the case ?  I really don't want a blocking
> thread that could block for several seconds on a single io to complete.  The

We are talking error handler, in which all in-flight requests are simply
aborted via blk_mq_tagset_busy_iter(nvme_cancel_request, ...), and there isn't
any waiting for single io to complete. nvme_cancel_request() basically
re-queues the in-flight request to blk-mq's queues, and the time is
pretty short, and I guess blk_mq_complete_request_sync() should be quicker
than blk_mq_complete_request() under this situation.

> controller has changed state and the queues frozen which should have been
> sufficient - but bottom-end io can still complete at any time.

Queues have been quiesced or stopped for recovering, and queue freezing
requires to wait for completion of all in-flight requests, then a new
IO deadlock is made...

Thanks,
Ming
