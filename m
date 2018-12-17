Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22426C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBBE206A2
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeLQLI7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:08:59 -0500
Received: from verein.lst.de ([213.95.11.211]:33632 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbeLQLI7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 06:08:59 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2602968DD3; Mon, 17 Dec 2018 12:08:57 +0100 (CET)
Date:   Mon, 17 Dec 2018 12:08:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 3/4] blk-mq: fix dispatch from sw queue
Message-ID: <20181217110857.GA5995@lst.de>
References: <20181217104248.5828-1-ming.lei@redhat.com> <20181217104248.5828-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217104248.5828-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Mon, Dec 17, 2018 at 06:42:47PM +0800, Ming Lei wrote:
> When requst is added to rq list of sw queue(ctx), the rq may be from
> different hctx, after multi queue mapping is introduced.
> 
> So we have to put the request into one per-queue-type list inside
> sw queue, otherwise the request may be dispatched to wrong hw queue.

Hmm.  For one I don't think splitting the lock makes sense even for
split lists.  Second, do we really need different lists, or just take
the type into account when dispatching from rq_list?  I'm not really
sure about that one, but a rationale for splitting might be worth
adding to the changelog if you want to stick to the split lists.
