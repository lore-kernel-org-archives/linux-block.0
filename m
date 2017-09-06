Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] lightnvm: pblk: check for failed mempool alloc.
To: Johannes Thumshirn <jthumshirn@suse.de>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <jg@lightnvm.io>
Cc: mb@lightnvm.io, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@cnexlabs.com>, =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>
References: <1504710066-4699-1-git-send-email-javier@cnexlabs.com>
 <1504710066-4699-2-git-send-email-javier@cnexlabs.com>
 <20170906150811.sa3vrrkbpv5rffeb@linux-x5ow.site>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d8295f1b-5021-e20b-ffcf-4fbbbe7c70b4@kernel.dk>
Date: Wed, 6 Sep 2017 09:09:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170906150811.sa3vrrkbpv5rffeb@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/06/2017 09:08 AM, Johannes Thumshirn wrote:
> On Wed, Sep 06, 2017 at 05:01:01PM +0200, Javier González wrote:
>> Check for failed mempool allocations and act accordingly.
> 
> Are you sure it is needed? Quoting from mempool_alloc()s Documentation:
> "[...] Note that due to preallocation, this function *never* fails when called
> from process contexts. (it might fail if called from an IRQ context.) [...]"

It's not needed, mempool() will never fail if __GFP_WAIT is set in the
mask. The use case here is GFP_KERNEL, which does include __GFP_WAIT.

-- 
Jens Axboe
