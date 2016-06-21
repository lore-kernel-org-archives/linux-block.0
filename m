Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34187 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbcFUOCd (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 21 Jun 2016 10:02:33 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, shli@fb.com, martin.petersen@oracle.com,
	snitzer@redhat.com, sitsofe@yahoo.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: introduce BLKDEV_DISCARD_ZERO to fix zeroout
References: <1466418523-22552-1-git-send-email-hch@lst.de>
	<x49d1nbsohs.fsf@segfault.boston.devel.redhat.com>
	<20160621123934.GA1689@lst.de>
Date: Tue, 21 Jun 2016 10:02:30 -0400
In-Reply-To: <20160621123934.GA1689@lst.de> (Christoph Hellwig's message of
	"Tue, 21 Jun 2016 14:39:34 +0200")
Message-ID: <x494m8mabd5.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

>> >  	if (flags & BLKDEV_DISCARD_SECURE) {
>> > +		if (flags & BLKDEV_DISCARD_ZERO)
>> > +			return -EOPNOTSUPP;
>> 
>> Should this be -EINVAL?
>
> BLKDEV_DISCARD_SECURE | BLKDEV_DISCARD_ZERO seems like a theoretically
> possible case, but I don't really care..

I agree, that is a possible combination.  EOPNOTSUPP is fine.

-Jeff
