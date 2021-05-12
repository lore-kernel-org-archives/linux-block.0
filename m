Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3E7C433ED
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 22:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75B2613FB
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 22:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhELW7q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 18:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1442814AbhELWN4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 18:13:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F339E61406;
        Wed, 12 May 2021 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620857560;
        bh=krzwbY3LekAl7s/TmTn3XHRBie3mv+RrBA2O+8MCYYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Du+rilF0mutiHpRWqh2IKZGM5oINNki8qMrcvvEiO6Oc6HuK9adwU15rUd079Jp8P
         eSWikb5pGJ7nslJYmKJP2Jm/r/4ubswpXolmhlTKyv7pfq4NbkkkFn4eh6Rjle+30A
         dhf+WjtCDnMHtzgJwf/wS0jlIc8asLLUaZVIolVyImSEHevhGENmsEKkpIl3DP3cBP
         Bf//pzlKtnha++TmHKclYnsSWsTRuVZ+t37mnHOCd58LG4+QxduIvJbOJ+MAtX0U9w
         hv1440XGt9cFhE3cemp1dk4njKVuGoE4btKu8TR8VikGWaC3feh/oQV4npnNrg84Dy
         WcP1WEP577ZfQ==
Date:   Wed, 12 May 2021 15:12:37 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/15] block: switch polling to be bio based
Message-ID: <20210512221237.GA2270434@dhcp-10-100-145-180.wdc.com>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-13-hch@lst.de>
 <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 12, 2021 at 03:03:40PM -0700, Sagi Grimberg wrote:
> On 5/12/21 6:15 AM, Christoph Hellwig wrote:
> > + *
> > + * Note: the caller must either be the context that submitted @bio, or
> > + * be in a RCU critical section to prevent freeing of @bio.
> > + */
> > +int bio_poll(struct bio *bio, unsigned int flags)
> > +{
> > +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> > +	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> > +
> > +	if (cookie == BLK_QC_T_NONE ||
> > +	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> > +		return 0;
> > +
> > +	if (current->plug)
> > +		blk_flush_plug_list(current->plug, false);
> > +
> > +	/* not yet implemented, so this should not happen */
> > +	if (WARN_ON_ONCE(!queue_is_mq(q)))
> 
> What happens if the I/O wasn't (yet) queued to the bottom device
> (i.e. no available path in nvme-mpath)?
> 
> In this case the disk would be the mpath device node (which is
> not mq...)

The bi_cookie should remain BLK_QC_T_NONE in that case, so we wouldn't
get to the warning. But if that does happen, it doesn't appear that
anyone is going to wake up thread that needs to poll for this bio's
completion when a path becomes available for dispatch. I think it would
make sense for nvme-mpath to just clear the REQ_POLLED flag if it
doesn't immediately have viable path.
