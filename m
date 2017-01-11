Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43697 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933306AbdAKI4F (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 03:56:05 -0500
Date: Wed, 11 Jan 2017 09:56:01 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH 14/15] block/bsg: move queue creation into bsg_setup_queue
Message-ID: <20170111085601.GC6286@linux-x5ow.site>
References: <1484060780-15592-1-git-send-email-hch@lst.de>
 <1484060780-15592-15-git-send-email-hch@lst.de>
 <20170111084218.GB6286@linux-x5ow.site>
 <20170111084512.GA6937@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170111084512.GA6937@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 11, 2017 at 09:45:12AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 11, 2017 at 09:42:44AM +0100, Johannes Thumshirn wrote:
> > On Tue, Jan 10, 2017 at 04:06:19PM +0100, Christoph Hellwig wrote:
> > > Simply the boilerplate code needed for bsg nodes a bit.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > 
> > that reminds me of posting my SAS bsg-lib patch...
> 
> Yes.  Having SAS use bsg-lib, and bsg-lib switched away from abusing
> struct request_queue would make this series a lot cleaner.
> 
> So maybe we should get that into the scsi tree for 4.10 together
> with the prep patches in this series as a priority and defer the actual
> struct request changes once again.  That should also give us some more
> time to sort out the dm-mpath story..

I'll dig it up and RFC post it. It's currently untested though as I
currently don't have a SMP capable SAS HBA here.

Do you have an mptXsas available? 

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
