Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org
Cc: Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-block@vger.kernel.org, Mike Christie <mchristi@redhat.com>, Ingo Molnar <mingo@redhat.com>, Shaohua Li <shli@fb.com>
Subject: Re: [Y2038] [PATCH] blktrace: avoid using timespec
Date: Mon, 20 Jun 2016 22:01:06 +0200
Message-ID: <9169104.t5FANfdqCe@wuerfel>
In-Reply-To: <x4937o7slcp.fsf@segfault.boston.devel.redhat.com>
References: <20160617145849.3771756-1-arnd@arndb.de> <3667244.FPOaAfVsUJ@wuerfel> <x4937o7slcp.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

On Monday, June 20, 2016 3:37:10 PM CEST Jeff Moyer wrote:
> 
> > Ok. Thanks a lot for the information. I think we can update the
> > comment as in the incremental patch below. Jens, can you fold that
> > into the original patch, or should I submit this as a new (or
> > incremental) patch with an updated description?
> 
> Jens already pulled this fix into for-4.8/core, so you should probably
> just send an incremental patch.
> 
> 

Ok, done. Thanks!

	Arnd
