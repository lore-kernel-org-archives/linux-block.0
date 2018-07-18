Return-Path: <raghuhack78@gmail.com>
Return-Path: <raghuhack78@gmail.com>
Date: Wed, 18 Jul 2018 23:25:53 +0530
From: RAGHU H <raghuhack78@gmail.com>
To: Joe Perches <joe@perches.com>, m=@raghu-VirtualBox,
	Bart.VanAssche@wdc.com
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] pktcdvd:checkpatch:fix pointer declaration
Message-ID: <20180718175553.GA5532@raghu-VirtualBox>
References: <20180718155855.4949-1-raghuhack78@gmail.com>
 <5ad3cf3212c434e73375eeb22d2f67fd70702744.camel@wdc.com>
 <47fc6920ec365a11b06f7c44f4a3f8d73d177e67.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47fc6920ec365a11b06f7c44f4a3f8d73d177e67.camel@perches.com>
List-ID: <linux-block@vger.kernel.org>

Bart,

I'm starter in kernel contribution & I guess cleanup of certain files
which have more than 50+ checkpatch errors is good start.

Also one of the patch was accepted by Jens Axboe & he responded back to
resend one of the patch which was not getting applied.

But I get your point ,I'll restrict my checkpatch fixes to drivers/staging files

Thanks Joe for followup.

On Wed, Jul 18, 2018 at 11:43:11AM -0700, Joe Perches wrote:
> On Wed, 2018-07-18 at 18:06 +0000, Bart Van Assche wrote:
> > On Wed, 2018-07-18 at 21:28 +0530, RAGHU Halharvi wrote:
> > > * Fix all pointer declaration which causes
> > >    "ERROR: "foo* bar" should be "foo *bar""
> > 
> > Hello Raghu,
> > 
> > If you would not be aware of this, checkpatch is a tool that is intended to
> > verify patches before submission and not to verify code that is already
> > upstream. A detailed explanation of why patches like this one should not be
> > submitted is available in "A quick guide to why stand-alone checkpatch
> > patches suck"
> > (https://lists.kernelnewbies.org/pipermail/kernelnewbies/2014-September/012296.html).
> 
> Read more of the whole thread.
> Varying opinions exist.
> 
