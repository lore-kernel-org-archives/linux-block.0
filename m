Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F63C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 06:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4116F20874
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 06:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeLRGrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:47:41 -0500
Received: from verein.lst.de ([213.95.11.211]:38732 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbeLRGrl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 01:47:41 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9C32D68D7E; Tue, 18 Dec 2018 07:47:39 +0100 (CET)
Date:   Tue, 18 Dec 2018 07:47:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: enable IO poll if .nr_queues of type poll > 0
Message-ID: <20181218064739.GA1219@lst.de>
References: <20181218041529.27787-1-ming.lei@redhat.com> <95d4e41f-24a7-bdb5-e014-994e021f901a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d4e41f-24a7-bdb5-e014-994e021f901a@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 09:34:55PM -0700, Jens Axboe wrote:
> On 12/17/18 9:15 PM, Ming Lei wrote:
> > The queue mapping of type poll only exists when set->map[HCTX_TYPE_POLL].nr_queues
> > is bigger than zero, so enhance the constraint by checking .nr_queues of type poll
> > before enabling IO poll.
> > 
> > Otherwise IO race & timeout can be observed when running block/007.
> 
> Looks good to me, but we might consider having a helper for this, since
> we have this check in 3 places now. But for now this is good, thanks
> Ming.

Jens, if you want this I can drop the nvme patch to set nr_maps to 2
as it wouldn't be needed.  Not sure which one is more elegant, but
I guess Mings version is a little more fool proof.
