Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F83EC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C842145D
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeLQLPr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:15:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbeLQLPr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 06:15:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40C88C07998E;
        Mon, 17 Dec 2018 11:15:47 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D71F18682;
        Mon, 17 Dec 2018 11:15:27 +0000 (UTC)
Date:   Mon, 17 Dec 2018 19:15:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH V2 3/4] blk-mq: fix dispatch from sw queue
Message-ID: <20181217111520.GD1329@ming.t460p>
References: <20181217104248.5828-1-ming.lei@redhat.com>
 <20181217104248.5828-4-ming.lei@redhat.com>
 <20181217110857.GA5995@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217110857.GA5995@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 17 Dec 2018 11:15:47 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 12:08:57PM +0100, Christoph Hellwig wrote:
> 
> 
> On Mon, Dec 17, 2018 at 06:42:47PM +0800, Ming Lei wrote:
> > When requst is added to rq list of sw queue(ctx), the rq may be from
> > different hctx, after multi queue mapping is introduced.
> > 
> > So we have to put the request into one per-queue-type list inside
> > sw queue, otherwise the request may be dispatched to wrong hw queue.
> 
> Hmm.  For one I don't think splitting the lock makes sense even for
> split lists.
> Second, do we really need different lists, or just take

It depends if the driver/existed blk-mq code can work well if one
request is dispatched to wrong hctx.

> the type into account when dispatching from rq_list?  I'm not really

This way may be inefficient since the whole list has to be iterated once
for finding all requests aimed to one specific hctx.


Thanks,
Ming
