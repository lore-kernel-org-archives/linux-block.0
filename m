Return-Path: <paulmck@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 17:18:55 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        pprakash@codeaurora.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Cochran <rcochran@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [BUG] Deadlock due due to interactions of block, RCU, and cpu
 offline
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170326232843.GA3637@linux.vnet.ibm.com>
 <d23f3f77-8158-24a4-727d-123ec526dffa@codeaurora.org>
 <20170327181711.GF3637@linux.vnet.ibm.com>
 <20170620234623.GA16200@linux.vnet.ibm.com>
 <df080eec-62b8-7d19-c201-e1a44febb96d@codeaurora.org>
 <20170621161853.GB3721@linux.vnet.ibm.com>
 <20170623033456.GA15959@linux.vnet.ibm.com>
 <c367a3a4-6fac-957a-5a5e-ac4a68bc4648@codeaurora.org>
 <20170628001130.GB3721@linux.vnet.ibm.com>
 <d64c9d16-3b91-2081-0633-7f6a5196fd45@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d64c9d16-3b91-2081-0633-7f6a5196fd45@codeaurora.org>
Message-Id: <20170630001855.GL2393@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 29, 2017 at 10:29:12AM -0600, Jeffrey Hugo wrote:
> On 6/27/2017 6:11 PM, Paul E. McKenney wrote:
> >On Tue, Jun 27, 2017 at 04:32:09PM -0600, Jeffrey Hugo wrote:
> >>On 6/22/2017 9:34 PM, Paul E. McKenney wrote:
> >>>On Wed, Jun 21, 2017 at 09:18:53AM -0700, Paul E. McKenney wrote:
> >>>>No worries, and I am very much looking forward to seeing the results of
> >>>>your testing.
> >>>
> >>>And please see below for an updated patch based on LKML review and
> >>>more intensive testing.
> >>>
> >>
> >>I spent some time on this today.  It didn't go as I expected.  I
> >>validated the issue is reproducible as before on 4.11 and 4.12 rcs 1
> >>through 4.  However, the version of stress-ng that I was using ran
> >>into constant errors starting with rc5, making it nearly impossible
> >>to make progress toward reproduction.  Upgrading stress-ng to tip
> >>fixes the issue, however, I've still been unable to repro the issue.
> >>
> >>Its my unfounded suspicion that something went in between rc4 and
> >>rc5 which changed the timing, and didn't actually fix the issue.  I
> >>will run the test overnight for 5 hours to try to repro.
> >>
> >>The patch you sent appears to be based on linux-next, and appears to
> >>have a number of dependencies which prevent it from cleanly applying
> >>on anything current that I'm able to repro on at this time.  Do you
> >>want to provide a rebased version of the patch which applies to say
> >>4.11?  I could easily test that and report back.
> >
> >Here is a very lightly tested backport to v4.11.
> >
> 
> Works for me. Always reproduced the lockup within 2 minutes on stock
> 4.11.  With the change applied, I was able to test for 2 hours in
> the same conditions, and 4 hours with the full system and not
> encounter an issue.
> 
> Feel free to add:
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>

Applied, thank you!

> I'm going to go back to 4.12-rc5 and see if I can get either repro
> the issue, or identify what changed.  Hopefully I can get to
> linux-next and double check the original version of the change as
> well.

Looking forward to hearing what you find!

							Thanx, Paul
