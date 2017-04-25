Return-Path: <juri.lelli@arm.com>
Date: Tue, 25 Apr 2017 10:40:43 +0100
From: Juri Lelli <juri.lelli@arm.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
	"aherrmann@suse.com" <aherrmann@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Joel Fernandes <joelaf@google.com>,
	Andres Oportus <andresoportus@google.com>
Subject: Re: bfq-mq performance comparison to cfq
Message-ID: <20170425094043.GB7959@e106622-lin>
References: <20170410090538.GA11473@suselix.suse.de>
 <82BCEB46-8D05-42DA-AE06-3426895A7842@linaro.org>
 <1491837330.4199.1.camel@sandisk.com>
 <B7819549-81C3-4952-A31D-5E4A0732AB14@linaro.org>
 <CY1PR0401MB15362FAB3D841CDF2C421A2981180@CY1PR0401MB1536.namprd04.prod.outlook.com>
 <4C1ABADD-6751-45E4-8DA1-ACA5A9E1379D@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C1ABADD-6751-45E4-8DA1-ACA5A9E1379D@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi,

sorry if I jump into this interesting conversation, but I felt some people
might have missed this and might be interested as well (even if from a
slightly different POW). Let me Cc them (Patrick, Morten, Peter, Joel,
Andres).

On 19/04/17 09:02, Paolo Valente wrote:
> 
> > Il giorno 19 apr 2017, alle ore 07:01, Bart Van Assche <bart.vanassche@sandisk.com> ha scritto:
> > 
> > On 04/11/17 00:29, Paolo Valente wrote:
> >> 
> >>> Il giorno 10 apr 2017, alle ore 17:15, Bart Van Assche <bart.vanassche@sandisk.com> ha scritto:
> >>> 
> >>> On Mon, 2017-04-10 at 11:55 +0200, Paolo Valente wrote:
> >>>> That said, if you do always want maximum throughput, even at the
> >>>> expense of latency, then just switch off low-latency heuristics, i.e.,
> >>>> set low_latency to 0.  Depending on the device, setting slice_ilde to
> >>>> 0 may help a lot too (as well as with CFQ).  If the throughput is
> >>>> still low also after forcing BFQ to an only-throughput mode, then you
> >>>> hit some bug, and I'll have a little more work to do ...
> >>> 
> >>> Has it been considered to make applications tell the I/O scheduler
> >>> whether to optimize for latency or for throughput? It shouldn't be that
> >>> hard for window managers and shells to figure out whether or not a new
> >>> application that is being started is interactive or not. This would
> >>> require a mechanism that allows applications to provide such information
> >>> to the I/O scheduler. Wouldn't that be a better approach than the I/O
> >>> scheduler trying to guess whether or not an application is an interactive
> >>> application?
> >> 
> >> IMO that would be an (or maybe the) optimal solution, in terms of both
> >> throughput and latency.  We have even developed a prototype doing what
> >> you propose, for Android.  Unfortunately, I have not yet succeeded in
> >> getting support, to turn it into candidate production code, or to make
> >> a similar solution for lsb-compliant systems.
> > 
> > Hello Paolo,
> > 
> > What API was used by the Android application to tell the I/O scheduler 
> > to optimize for latency? Do you think that it would be sufficient if the 
> > application uses the ioprio_set() system call to set the I/O priority to 
> > IOPRIO_CLASS_RT?
> > 
> 
> That's exactly the hack we are using in our prototype.  However, it
> can only be a temporary hack, because it mixes two slightly different
> concepts: 1) the activation of weight raising and other mechanisms for
> reducing latency for the target app, 2) the assignment of a different
> priority class, which (cleanly) means just that processes in a lower
> priority class will be served only when the processes of the target
> app have no pending I/O request.  Finding a clean boosting API would
> be one of the main steps to turn our prototype into a usable solution.
> 

I also need to append here latest Bart's reply (which hasn't all the
context):

On 19/04/17 15:43, Bart Van Assche wrote:
> On Wed, 2017-04-19 at 09:02 +0200, Paolo Valente wrote:
> > > Il giorno 19 apr 2017, alle ore 07:01, Bart Van Assche <bart.vanassche@sandisk.com> ha scritto:
> > > What API was used by the Android application to tell the I/O scheduler 
> > > to optimize for latency? Do you think that it would be sufficient if the 
> > > application uses the ioprio_set() system call to set the I/O priority to 
> > > IOPRIO_CLASS_RT?
> > 
> > That's exactly the hack we are using in our prototype.  However, it
> > can only be a temporary hack, because it mixes two slightly different
> > concepts: 1) the activation of weight raising and other mechanisms for
> > reducing latency for the target app, 2) the assignment of a different
> > priority class, which (cleanly) means just that processes in a lower
> > priority class will be served only when the processes of the target
> > app have no pending I/O request.  Finding a clean boosting API would
> > be one of the main steps to turn our prototype into a usable solution.
> 
> Hello Paolo,
> 
> Sorry but I do not agree that you call this use of I/O priorities a hack.
> I also do not agree that I/O requests submitted by processes in a lower
> priority class will only be served by the I/O scheduler when there are no
> pending requests in a higher class. It wouldn't be that hard to modify I/O
> schedulers that support I/O priorities to avoid the starvation you referred
> to. What I expect that will happen is that sooner or later a Linux
> distributor will start receiving bug reports about the heuristics for
> detecting interactive and streaming applications and that the person who
> will work on that bug report will realize that it will be easier to remove
> those heuristics from BFQ and to modify streaming applications and the
> software that starts interactive applications (e.g. a window manager) to
> use a higher I/O priority.
> 
> Please also note that what I described above may require to introduce
> additional I/O priorities in the Linux kernel next to the existing I/O
> priorities RT, BE and NONE and that this may require to map multiple of
> these priorities onto the same drive priority.

Now, the reason why I got interested into this is that I believe we are
trying to solve a related type of issue from the CPU scheduler and CPU
frequency selection POW. IMHO, an even more holistic approach might
provide us even better benefits.

The interface Patrick is proposing [1] is extending the CPU cgroup
controller; extension which is then used by "informed runtimes" (e.g.,
Android) to influence power/performance decisions of both CPU load
balancing and CPU frequency selection. Android is already using a
similar interface nowadays [2].

OK, enough noise. :)

Thanks,

- Juri

[1] - http://marc.info/?l=linux-kernel&m=148829339631846&w=2
[2] - https://android.googlesource.com/kernel/msm/+/android-7.1.1_r0.20/kernel/sched/tune.c#150
