Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB7FC433C1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 07:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6738619F6
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 07:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhCXHLc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 03:11:32 -0400
Received: from verein.lst.de ([213.95.11.211]:35681 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235723AbhCXHLW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 03:11:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F7C868B02; Wed, 24 Mar 2021 08:11:20 +0100 (CET)
Date:   Wed, 24 Mar 2021 08:11:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] block: support zone append bvecs
Message-ID: <20210324071119.GA647@lst.de>
References: <739a96e185f008c238fcf06cb22068016149ad4a.1616497531.git.johannes.thumshirn@wdc.com> <20210323123002.GA30758@lst.de> <PH0PR04MB7416CEB0FE5E8E56370A0A1D9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416CEB0FE5E8E56370A0A1D9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 24, 2021 at 07:07:27AM +0000, Johannes Thumshirn wrote:
> >>  	if (iov_iter_is_bvec(iter)) {
> >> -		if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
> >> -			return -EINVAL;
> >> +		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> >> +			struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> >> +			unsigned int max_append =
> >> +				queue_max_zone_append_sectors(q) << 9;
> >> +
> >> +			if (WARN_ON_ONCE(iter->count > max_append))
> >> +				return -EINVAL;
> >> +		}
> > 
> > That is not correct.  bio_iov_iter_get_pages just fills the bio as far
> > as we can, and then returns 0 for the next call to continue.  Basically
> > what you want here is a partial version of bio_iov_bvec_set.
> > 
> 
> Isn't that what I did? The above is checking if we have REQ_OP_ZONE_APPEND and
> then returns EINVAL if iter->count is bigger than queue_max_zone_append_sectors().
> If the check doesn't fail, its going to call bio_iov_bvec_set().

And that is the problem.  It should not fail, the payload is decoupled
from the max_append size.

Doing the proper thing is not too hard as described above - make sure
the bi_iter points to only the chunk of iter passed in that fits, and
only advance the passed in iter by that amount.
