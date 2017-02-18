Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:49232 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753035AbdBRQWF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Feb 2017 11:22:05 -0500
Date: Sat, 18 Feb 2017 17:22:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Scott Bauer <sbauer@eng.utah.edu>
Cc: Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@fb.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCHv2 4/5] block/sed: Embed function data into the function
        sequence
Message-ID: <20170218162203.GC17922@lst.de>
References: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com> <1487376029-22662-5-git-send-email-jonathan.derrick@intel.com> <20170218083605.GB11798@lst.de> <d6d1c65a-4422-97d7-8ee8-fef46159b143@eng.utah.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d6d1c65a-4422-97d7-8ee8-fef46159b143@eng.utah.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Feb 18, 2017 at 08:52:19AM -0700, Scott Bauer wrote:
> >> +static int set_mbr_done(struct opal_dev *dev, void *data)
> >>  {
> >> -	u8 mbr_done_tf = *(u8 *)dev->func_data[dev->state];
> >> +	u8 mbr_done_tf = *(u8 *)data;
> > 
> > No need for casts when going from void * to any pointer type.  There are
> > a couple more instance below where the cast should be removed as well.
> 
> In this case he's actually casting & dereferencing the pointer, so it should be fine in this scenario?

Oh, right.  As-is we'll obviously need the casts.  But what we could
do instead is the following:

	u8 *mbr_done_tf = data;

	..

	add_token_u8(&err, dev, *mbr_done_tf); /* Done T or F */

or alternatively just pass the whole struct opal_mbr_data pointer
as the private data.
