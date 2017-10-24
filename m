Return-Path: <byungchul.park@lge.com>
Date: Wed, 25 Oct 2017 08:45:38 +0900
From: Byungchul Park <byungchul.park@lge.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, axboe@kernel.dk, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, tj@kernel.org,
	johannes.berg@intel.com, oleg@redhat.com, amir73il@gmail.com,
	david@fromorbit.com, darrick.wong@oracle.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, hch@infradead.org, idryomov@gmail.com,
	kernel-team@lge.com
Subject: Re: [PATCH v3 4/8] lockdep: Add a kernel parameter,
 crossrelease_fullstack
Message-ID: <20171024234538.GM3310@X58A-UD3R>
References: <1508837889-16932-1-git-send-email-byungchul.park@lge.com>
 <1508837889-16932-5-git-send-email-byungchul.park@lge.com>
 <20171024100858.2rw7wnhtj7d3iyzk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171024100858.2rw7wnhtj7d3iyzk@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 24, 2017 at 12:08:58PM +0200, Ingo Molnar wrote:
> This is really unnecessarily complex.

I mis-understood your suggestion. I will change it.

> The proper logic is to introduce the crossrelease_fullstack boot parameter, and to 
> also have a Kconfig option that enables it: 
> 
> 	CONFIG_BOOTPARAM_LOCKDEP_CROSSRELEASE_FULLSTACK=y
> 
> No #ifdefs please - just an "if ()" branch dependent on the current value of 
> crossrelease_fullstack.

Ok. I will.

Thanks,
Byungchul

> Thanks,
> 
> 	Ingo
