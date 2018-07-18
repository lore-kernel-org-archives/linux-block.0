Return-Path: <joe@perches.com>
Message-ID: <47fc6920ec365a11b06f7c44f4a3f8d73d177e67.camel@perches.com>
Subject: Re: [PATCH] pktcdvd:checkpatch:fix pointer declaration
From: Joe Perches <joe@perches.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "raghuhack78@gmail.com"
 <raghuhack78@gmail.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>
Date: Wed, 18 Jul 2018 11:43:11 -0700
In-Reply-To: <5ad3cf3212c434e73375eeb22d2f67fd70702744.camel@wdc.com>
References: <20180718155855.4949-1-raghuhack78@gmail.com>
	 <5ad3cf3212c434e73375eeb22d2f67fd70702744.camel@wdc.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-07-18 at 18:06 +0000, Bart Van Assche wrote:
> On Wed, 2018-07-18 at 21:28 +0530, RAGHU Halharvi wrote:
> > * Fix all pointer declaration which causes
> >    "ERROR: "foo* bar" should be "foo *bar""
> 
> Hello Raghu,
> 
> If you would not be aware of this, checkpatch is a tool that is intended to
> verify patches before submission and not to verify code that is already
> upstream. A detailed explanation of why patches like this one should not be
> submitted is available in "A quick guide to why stand-alone checkpatch
> patches suck"
> (https://lists.kernelnewbies.org/pipermail/kernelnewbies/2014-September/012296.html).

Read more of the whole thread.
Varying opinions exist.
