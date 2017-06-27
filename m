Return-Path: <jhugo@codeaurora.org>
Subject: Re: [BUG] Deadlock due due to interactions of block, RCU, and cpu
 offline
To: paulmck@linux.vnet.ibm.com
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
References: <db9c91f6-1b17-6136-84f0-03c3c2581ab4@codeaurora.org>
 <20170326232843.GA3637@linux.vnet.ibm.com>
 <d23f3f77-8158-24a4-727d-123ec526dffa@codeaurora.org>
 <20170327181711.GF3637@linux.vnet.ibm.com>
 <20170620234623.GA16200@linux.vnet.ibm.com>
 <df080eec-62b8-7d19-c201-e1a44febb96d@codeaurora.org>
 <20170621161853.GB3721@linux.vnet.ibm.com>
 <20170623033456.GA15959@linux.vnet.ibm.com>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <c367a3a4-6fac-957a-5a5e-ac4a68bc4648@codeaurora.org>
Date: Tue, 27 Jun 2017 16:32:09 -0600
MIME-Version: 1.0
In-Reply-To: <20170623033456.GA15959@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 6/22/2017 9:34 PM, Paul E. McKenney wrote:
> On Wed, Jun 21, 2017 at 09:18:53AM -0700, Paul E. McKenney wrote:
>> No worries, and I am very much looking forward to seeing the results of
>> your testing.
> 
> And please see below for an updated patch based on LKML review and
> more intensive testing.
> 

I spent some time on this today.  It didn't go as I expected.  I 
validated the issue is reproducible as before on 4.11 and 4.12 rcs 1 
through 4.  However, the version of stress-ng that I was using ran into 
constant errors starting with rc5, making it nearly impossible to make 
progress toward reproduction.  Upgrading stress-ng to tip fixes the 
issue, however, I've still been unable to repro the issue.

Its my unfounded suspicion that something went in between rc4 and rc5 
which changed the timing, and didn't actually fix the issue.  I will run 
the test overnight for 5 hours to try to repro.

The patch you sent appears to be based on linux-next, and appears to 
have a number of dependencies which prevent it from cleanly applying on 
anything current that I'm able to repro on at this time.  Do you want to 
provide a rebased version of the patch which applies to say 4.11?  I 
could easily test that and report back.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
