Return-Path: <mingo.kernel.org@gmail.com>
Return-Path: <mingo.kernel.org@gmail.com>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 25 Oct 2017 07:55:27 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Byungchul Park <byungchul.park@lge.com>
Cc: peterz@infradead.org, axboe@kernel.dk, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, tj@kernel.org,
	johannes.berg@intel.com, oleg@redhat.com, amir73il@gmail.com,
	david@fromorbit.com, darrick.wong@oracle.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, hch@infradead.org, idryomov@gmail.com,
	kernel-team@lge.com
Subject: Re: [PATCH v3 8/8] block: Assign a lock_class per gendisk used for
 wait_for_completion()
Message-ID: <20171025055527.jm5scb5vr26g63un@gmail.com>
References: <1508837889-16932-1-git-send-email-byungchul.park@lge.com>
 <1508837889-16932-9-git-send-email-byungchul.park@lge.com>
 <20171024101551.sftqsy5mk34fxru7@gmail.com>
 <20171025002612.GN3310@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171025002612.GN3310@X58A-UD3R>
List-ID: <linux-block@vger.kernel.org>


* Byungchul Park <byungchul.park@lge.com> wrote:

> > Isn't lockdep_map a zero size structure that is always defined? If yes then 
> > there's no need for an #ifdef.
> 
> No, a zero size structure for lockdep_map is not provided yet.
> There are two options I can do:
> 
> 1. Add a zero size structure for lockdep_map and remove #ifdef
> 2. Replace CONFIG_LOCKDEP_COMPLETIONS with CONFIG_LOCKDEP here.
> 
> Or something else?
> 
> Which one do you prefer?

Ok, could we try #1 in a new patch and re-spin the simplified block layer patch on 
top of that?

The less ugly a debug facility's impact on unrelated kernel is, the better - 
especially when it comes to annotating false positives.

Thanks,

	Ingo
