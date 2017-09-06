Return-Path: <jthumshirn@suse.de>
Date: Wed, 6 Sep 2017 17:12:59 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>, mb@lightnvm.io,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>
Subject: Re: [PATCH 1/6] lightnvm: pblk: check for failed mempool alloc.
Message-ID: <20170906151259.ld5ccbidelbulfc7@linux-x5ow.site>
References: <1504710066-4699-1-git-send-email-javier@cnexlabs.com>
 <1504710066-4699-2-git-send-email-javier@cnexlabs.com>
 <20170906150811.sa3vrrkbpv5rffeb@linux-x5ow.site>
 <d8295f1b-5021-e20b-ffcf-4fbbbe7c70b4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <d8295f1b-5021-e20b-ffcf-4fbbbe7c70b4@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 06, 2017 at 09:09:29AM -0600, Jens Axboe wrote:
> On 09/06/2017 09:08 AM, Johannes Thumshirn wrote:
> > On Wed, Sep 06, 2017 at 05:01:01PM +0200, Javier Gonz�lez wrote:
> >> Check for failed mempool allocations and act accordingly.
> > 
> > Are you sure it is needed? Quoting from mempool_alloc()s Documentation:
> > "[...] Note that due to preallocation, this function *never* fails when called
> > from process contexts. (it might fail if called from an IRQ context.) [...]"
> 
> It's not needed, mempool() will never fail if __GFP_WAIT is set in the
> mask. The use case here is GFP_KERNEL, which does include __GFP_WAIT.

Exactly. Maybe I shouldn't have it phrased as a question though... 

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
