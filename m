Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388C5C433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E34864F3C
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbhBDPiI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:38:08 -0500
Received: from verein.lst.de ([213.95.11.211]:56504 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237449AbhBDPhS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Feb 2021 10:37:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5FD9C6736F; Thu,  4 Feb 2021 16:36:32 +0100 (CET)
Date:   Thu, 4 Feb 2021 16:36:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, kbusch@kernel.org,
        sagi@grimberg.me, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v5 1/3] blk-mq: introduce blk_mq_set_request_complete
Message-ID: <20210204153631.GA30261@lst.de>
References: <20210201034940.18891-1-lengchao@huawei.com> <20210201034940.18891-2-lengchao@huawei.com> <3b75b43c-638b-b5ac-eb5e-e37314d25ce1@fb.com> <20210204153014.GA29736@lst.de> <70bdb0b1-c7aa-af25-4b28-f8f6675c73ae@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70bdb0b1-c7aa-af25-4b28-f8f6675c73ae@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 04, 2021 at 08:32:17AM -0700, Jens Axboe wrote:
> On 2/4/21 8:30 AM, Christoph Hellwig wrote:
> > On Thu, Feb 04, 2021 at 08:27:46AM -0700, Jens Axboe wrote:
> >> On 1/31/21 8:49 PM, Chao Leng wrote:
> >>> nvme drivers need to set the state of request to MQ_RQ_COMPLETE when
> >>> directly complete request in queue_rq.
> >>> So add blk_mq_set_request_complete.
> >>
> >> This is a bit iffy, but looks ok for the intended use case. We just have
> >> to be careful NOT to add frivolous users of it...
> > 
> > Yes, that is my main issue with it.  The current use case looks fine,
> > but I suspect every time someone else uses it it's probly going to be
> > as misuse.  I've applied this to nvme-5.12 with the rest of the patches,
> > it should be on its way to you soon.
> 
> Might benefit from a big fat comment on why you probably shouldn't
> be using it...

I actually reworded the comment a bit, this is the current version:

http://git.infradead.org/nvme.git/commitdiff/bdd2a4a61460a341c1f8462e5caf63195e960623
