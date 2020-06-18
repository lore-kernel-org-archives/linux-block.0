Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34CCC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 16:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8695620776
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 16:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgFRQNf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:13:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:35226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgFRQNd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 12:13:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5D02ADC9;
        Thu, 18 Jun 2020 16:13:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 040BF1E12A6; Thu, 18 Jun 2020 18:13:32 +0200 (CEST)
Date:   Thu, 18 Jun 2020 18:13:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] blktrace: Provide event for request merging
Message-ID: <20200618161331.GD9664@quack2.suse.cz>
References: <20200617135823.980-1-jack@suse.cz>
 <20200618065359.GA24943@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618065359.GA24943@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 17-06-20 23:53:59, Christoph Hellwig wrote:
> On Wed, Jun 17, 2020 at 03:58:23PM +0200, Jan Kara wrote:
> >  	blk_account_io_merge_request(next);
> >  
> > +	trace_block_rq_merge(q, next);
> 
> q can be derived from next, no need to explicitly pass it.  And yes,
> I know a lot of existing tracepoints do so, but I plan to fix that up
> as well.

I had a look into it now and I could do this but that would mean that
block_rq_merge trace event would now differ from all other similar events
and we couldn't use block_rq event class and have to define our own and so
overall it would IMO make future conversion to get rid of 'q' argument more
difficult, not simpler. So I can do this but are you really sure?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
