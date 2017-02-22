Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32547 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932493AbdBVQX1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 11:23:27 -0500
Date: Wed, 22 Feb 2017 09:13:31 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Rafael Antognolli <rafael.antognolli@intel.com>
Subject: Re: [PATCHv4 4/4] block/sed: Embed function data into the function
 sequence
Message-ID: <20170222161331.GA2696@sbauer-Z170X-UD5>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
 <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
 <20170222071342.GA17472@lst.de>
 <22a94611-3cbd-792f-8347-3b1c1f200944@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22a94611-3cbd-792f-8347-3b1c1f200944@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Feb 22, 2017 at 09:10:31AM -0700, Jens Axboe wrote:
> On 02/22/2017 12:13 AM, Christoph Hellwig wrote:
> >> +	if (!lock_held)
> >> +		mutex_lock(&dev->dev_lock);
> > 
> > No conditional locking, please.  I guess I causesd this by asking you
> > to remove __opal_lock_unlock, but it seems we'd either need to keep it
> > in the end.
> > 
> > Except for that the series looks fine to me.
> > 
> > Jens: given that 1-3 are the important fixes how about you pick those
> > up ASAP?  They all also had my Reviewed-by for previous postings.
> 
> I picked up 1-3, and re-added your reviewed by. #4 should be sorted
> before -rc1, though.
> 

#4 Is good to go as well. It was resent this morning under
[PATCH] block/sed: Embed function data into the function sequence
And contains the changes Christoph requested, I'll re-add my sign-off.
Once that gets In I can rebase mine and get them out today too.
