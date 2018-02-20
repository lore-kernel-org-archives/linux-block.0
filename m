Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Tue, 20 Feb 2018 09:27:37 -0700
From: Keith Busch <keith.busch@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-block@vger.kernel.org, axboe@fb.com,
        linux-nvme@lists.infradead.org, joshi.k@samsung.com
Subject: Re: [PATCH] blk: optimization for classic polling
Message-ID: <20180220162737.GC7076@localhost.localdomain>
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
 <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
 <20180220132137.GG25314@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180220132137.GG25314@hirez.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 20, 2018 at 02:21:37PM +0100, Peter Zijlstra wrote:
> Also, set_current_state(TASK_RUNNING) is dodgy (similarly in
> __blk_mq_poll), why do you need that memory barrier?

You're right. The subsequent revision that was committed removed the
barrier. The commit is here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=67b4110f8c8d16e588d7730db8e8b01b32c1bd8b

I hope the code at least looks more reasonable. The changelog isn't much
different, though.
