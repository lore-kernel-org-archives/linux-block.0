Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbcKNIvx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 03:51:53 -0500
Date: Mon, 14 Nov 2016 00:51:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: "creative" bio usage in the RAID code
Message-ID: <20161114085151.GA8405@infradead.org>
References: <20161110194636.GA32241@infradead.org>
 <87shqvj83r.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87shqvj83r.fsf@notabene.neil.brown.name>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 14, 2016 at 10:03:20AM +1100, NeilBrown wrote:
> I would suggest adding a "bi_dev_private" field to the bio which is for
> use by the lowest-level driver (much as bi_private is for use by the
> top-level initiator).
> That could be in a union with any or all of:
> 	unsigned int		bi_phys_segments;
> 	unsigned int		bi_seg_front_size;
> 	unsigned int		bi_seg_back_size;
> 
> (any driver that needs those, would see a 'request' rather than a 'bio'
> and so could use rq->special)
> 
> raid5.c could then use bi_dev_private (or bi_special, or whatever it is call).

All the three above fields are those that could go away with a full
implementation of the multipage bvec scheme.  So any field for driver
use would still be be overhead.  If it's just for raid5 it could
be a smaller 16 bit (or maybe even just 8 bit) one.
