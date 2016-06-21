Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46973 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbcFUMtQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 21 Jun 2016 08:49:16 -0400
Date: Tue, 21 Jun 2016 14:39:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com, shli@fb.com,
	martin.petersen@oracle.com, snitzer@redhat.com, sitsofe@yahoo.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: introduce BLKDEV_DISCARD_ZERO to fix zeroout
Message-ID: <20160621123934.GA1689@lst.de>
References: <1466418523-22552-1-git-send-email-hch@lst.de> <x49d1nbsohs.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <x49d1nbsohs.fsf@segfault.boston.devel.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> >  	if (flags & BLKDEV_DISCARD_SECURE) {
> > +		if (flags & BLKDEV_DISCARD_ZERO)
> > +			return -EOPNOTSUPP;
> 
> Should this be -EINVAL?

BLKDEV_DISCARD_SECURE | BLKDEV_DISCARD_ZERO seems like a theoretically
possible case, but I don't really care..
