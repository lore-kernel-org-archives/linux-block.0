Return-Path: <byungchul.park@lge.com>
Date: Wed, 25 Oct 2017 10:01:55 +0900
From: Byungchul Park <byungchul.park@lge.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, axboe@kernel.dk, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, tj@kernel.org,
	johannes.berg@intel.com, oleg@redhat.com, amir73il@gmail.com,
	david@fromorbit.com, darrick.wong@oracle.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, hch@infradead.org, idryomov@gmail.com,
	kernel-team@lge.com
Subject: Re: [PATCH v3 2/8] lockdep: Introduce CROSSRELEASE_STACK_TRACE and
 make it not unwind as default
Message-ID: <20171025010155.GO3310@X58A-UD3R>
References: <1508837889-16932-1-git-send-email-byungchul.park@lge.com>
 <1508837889-16932-3-git-send-email-byungchul.park@lge.com>
 <20171024100516.f2a2uzknqfum77w2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171024100516.f2a2uzknqfum77w2@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 24, 2017 at 12:05:16PM +0200, Ingo Molnar wrote:
> 
> * Byungchul Park <byungchul.park@lge.com> wrote:
> 
> > Johan Hovold reported a performance regression by crossrelease like:
> 
> Pplease add Reported-by and Analyzed-by tags - you didn't even Cc: Johan!

Excuse me but, I am sure, whom is the issue analyzed by? Me?

> Thanks,
> 
> 	Ingo
