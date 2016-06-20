Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, y2038@lists.linaro.org,
        Hannes Reinecke <hare@suse.com>, Mike Christie <mchristi@redhat.com>,
        Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: avoid using timespec
References: <20160617145849.3771756-1-arnd@arndb.de>
	<3744206.k1Hv7RyTzG@wuerfel>
	<x49lh1zucsd.fsf@segfault.boston.devel.redhat.com>
	<3667244.FPOaAfVsUJ@wuerfel>
Date: Mon, 20 Jun 2016 15:37:10 -0400
In-Reply-To: <3667244.FPOaAfVsUJ@wuerfel> (Arnd Bergmann's message of "Mon, 20
	Jun 2016 17:18:52 +0200")
Message-ID: <x4937o7slcp.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> writes:

> On Monday, June 20, 2016 10:59:14 AM CEST Jeff Moyer wrote:
>> struct timespec         abs_start_time;
[snip]
> I assume that abs_start_time is a timespec, implying that

It is.  You didn't have to assume that, though, as I also included its
definition above.  ;-)

> Ok. Thanks a lot for the information. I think we can update the
> comment as in the incremental patch below. Jens, can you fold that
> into the original patch, or should I submit this as a new (or
> incremental) patch with an updated description?

Jens already pulled this fix into for-4.8/core, so you should probably
just send an incremental patch.

Cheers,
Jeff
