Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: bfq-mq performance comparison to cfq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170425094043.GB7959@e106622-lin>
Date: Wed, 26 Apr 2017 10:18:36 +0200
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
Message-Id: <AA9E8536-4CD0-4A67-80F4-90445C331C90@linaro.org>
References: <20170410090538.GA11473@suselix.suse.de> <82BCEB46-8D05-42DA-AE06-3426895A7842@linaro.org> <1491837330.4199.1.camel@sandisk.com> <B7819549-81C3-4952-A31D-5E4A0732AB14@linaro.org> <CY1PR0401MB15362FAB3D841CDF2C421A2981180@CY1PR0401MB1536.namprd04.prod.outlook.com> <4C1ABADD-6751-45E4-8DA1-ACA5A9E1379D@linaro.org> <20170425094043.GB7959@e106622-lin>
To: Juri Lelli <juri.lelli@arm.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 25 apr 2017, alle ore 11:40, Juri Lelli <juri.lelli@arm.com> =
ha scritto:
>=20
> Hi,
>=20
> sorry if I jump into this interesting conversation, but I felt some =
people
> might have missed this and might be interested as well (even if from a
> slightly different POW). Let me Cc them (Patrick, Morten, Peter, Joel,
> Andres).
>=20
> On 19/04/17 09:02, Paolo Valente wrote:
>>=20
>>> Il giorno 19 apr 2017, alle ore 07:01, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>>>=20
>>> On 04/11/17 00:29, Paolo Valente wrote:
>>>>=20
>>>>> Il giorno 10 apr 2017, alle ore 17:15, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>>>>>=20
>>>>> On Mon, 2017-04-10 at 11:55 +0200, Paolo Valente wrote:
>>>>>> That said, if you do always want maximum throughput, even at the
>>>>>> expense of latency, then just switch off low-latency heuristics, =
i.e.,
>>>>>> set low_latency to 0.  Depending on the device, setting =
slice_ilde to
>>>>>> 0 may help a lot too (as well as with CFQ).  If the throughput is
>>>>>> still low also after forcing BFQ to an only-throughput mode, then =
you
>>>>>> hit some bug, and I'll have a little more work to do ...
>>>>>=20
>>>>> Has it been considered to make applications tell the I/O scheduler
>>>>> whether to optimize for latency or for throughput? It shouldn't be =
that
>>>>> hard for window managers and shells to figure out whether or not a =
new
>>>>> application that is being started is interactive or not. This =
would
>>>>> require a mechanism that allows applications to provide such =
information
>>>>> to the I/O scheduler. Wouldn't that be a better approach than the =
I/O
>>>>> scheduler trying to guess whether or not an application is an =
interactive
>>>>> application?
>>>>=20
>>>> IMO that would be an (or maybe the) optimal solution, in terms of =
both
>>>> throughput and latency.  We have even developed a prototype doing =
what
>>>> you propose, for Android.  Unfortunately, I have not yet succeeded =
in
>>>> getting support, to turn it into candidate production code, or to =
make
>>>> a similar solution for lsb-compliant systems.
>>>=20
>>> Hello Paolo,
>>>=20
>>> What API was used by the Android application to tell the I/O =
scheduler=20
>>> to optimize for latency? Do you think that it would be sufficient if =
the=20
>>> application uses the ioprio_set() system call to set the I/O =
priority to=20
>>> IOPRIO_CLASS_RT?
>>>=20
>>=20
>> That's exactly the hack we are using in our prototype.  However, it
>> can only be a temporary hack, because it mixes two slightly different
>> concepts: 1) the activation of weight raising and other mechanisms =
for
>> reducing latency for the target app, 2) the assignment of a different
>> priority class, which (cleanly) means just that processes in a lower
>> priority class will be served only when the processes of the target
>> app have no pending I/O request.  Finding a clean boosting API would
>> be one of the main steps to turn our prototype into a usable =
solution.
>>=20
>=20
> I also need to append here latest Bart's reply (which hasn't all the
> context):
>=20
> On 19/04/17 15:43, Bart Van Assche wrote:
>> On Wed, 2017-04-19 at 09:02 +0200, Paolo Valente wrote:
>>>> Il giorno 19 apr 2017, alle ore 07:01, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>>>> What API was used by the Android application to tell the I/O =
scheduler=20
>>>> to optimize for latency? Do you think that it would be sufficient =
if the=20
>>>> application uses the ioprio_set() system call to set the I/O =
priority to=20
>>>> IOPRIO_CLASS_RT?
>>>=20
>>> That's exactly the hack we are using in our prototype.  However, it
>>> can only be a temporary hack, because it mixes two slightly =
different
>>> concepts: 1) the activation of weight raising and other mechanisms =
for
>>> reducing latency for the target app, 2) the assignment of a =
different
>>> priority class, which (cleanly) means just that processes in a lower
>>> priority class will be served only when the processes of the target
>>> app have no pending I/O request.  Finding a clean boosting API would
>>> be one of the main steps to turn our prototype into a usable =
solution.
>>=20
>> Hello Paolo,
>>=20
>> Sorry but I do not agree that you call this use of I/O priorities a =
hack.
>> I also do not agree that I/O requests submitted by processes in a =
lower
>> priority class will only be served by the I/O scheduler when there =
are no
>> pending requests in a higher class. It wouldn't be that hard to =
modify I/O
>> schedulers that support I/O priorities to avoid the starvation you =
referred
>> to. What I expect that will happen is that sooner or later a Linux
>> distributor will start receiving bug reports about the heuristics for
>> detecting interactive and streaming applications and that the person =
who
>> will work on that bug report will realize that it will be easier to =
remove
>> those heuristics from BFQ and to modify streaming applications and =
the
>> software that starts interactive applications (e.g. a window manager) =
to
>> use a higher I/O priority.
>>=20
>> Please also note that what I described above may require to introduce
>> additional I/O priorities in the Linux kernel next to the existing =
I/O
>> priorities RT, BE and NONE and that this may require to map multiple =
of
>> these priorities onto the same drive priority.
>=20
> Now, the reason why I got interested into this is that I believe we =
are
> trying to solve a related type of issue from the CPU scheduler and CPU
> frequency selection POW. IMHO, an even more holistic approach might
> provide us even better benefits.
>=20
> The interface Patrick is proposing [1] is extending the CPU cgroup
> controller; extension which is then used by "informed runtimes" (e.g.,
> Android) to influence power/performance decisions of both CPU load
> balancing and CPU frequency selection. Android is already using a
> similar interface nowadays [2].
>=20

Hi Juri,
let me reply first to last Bart comments, and then to the
suggestions/information you provide.

First, as for using the RT class as a way to tell BFQ which processes
to privilege, I have three main concerns.

The first is, as I already said, is that we would overload a simple
and clean priority scheme (RT > BE > NONE) with a set of complex
mechanisms: weight raising, much longer idling periods, tendency to
deny idling to non-privileged processes when there are privileged
process.  Doing so doesn't sound clean to me.  But, if it is only a
problem of my personal taste, and we all agree that it is fine to
proceed this way, then I would be ok with this sort of overloading.

The second is that, if we use I/O classes, and not groups, to decide
privileges, then, perhaps, the way to get a hierarchical privileging
scheme becomes confusing?  For example, suppose we have two groups
that share I/O bandwidth, one with a high share, say 80%, the other
with the remaining low 20% share.  Suppose then that we have a process
to privilege in each group.  The process to privilege in the second
group must get all 20% of the bandwidth, but no more.  Yet, if we use
the RT-class interface to decide whom to privilege, would it be it
clear and ok for everybody that these two processes get,
asymmetrically, 80% and 20% of the bandwidth?  I mean, per-process I/O
classes seem a rather orthogonal concept with respect to groups.  Or,
are they are already assumed to be well encapsulated in groups?

I guess that both the above issues may not be dramatic.  In contrast,
the following last issue seems harder to address: BFQ uses two
different privileging schemes, one suitable for interactive
applications, and one suitable for soft real-time applications.  So,
what scheme should BFQ enable for processes in the RT I/O class?

Because of these concerns, also for I/O I would find much clearer and
flexible an ad-hoc, complete and explicit solution like the one(s)
Juri reports (I've already nagged some of the recipients here to get
support and collaboration on such sort of extensions of the basic
benefits of a good I/O scheduler).

As for using a more holistic scheme, or at least user interface, I
think it may make users and sysadmins very happy.  In the first place,
they could just flag some app as latency sensitive, and have it served
as quickly as possible, whatever the app wants to do.  Then, for
applications with real-timish requirements, they could set such
requirements and have them met, as well as possible, regardless of
whether the app is CPU-boud, I/O-bound, or both.

Thanks,
Paolo

> OK, enough noise. :)
>=20
> Thanks,
>=20
> - Juri
>=20
> [1] - http://marc.info/?l=3Dlinux-kernel&m=3D148829339631846&w=3D2
> [2] - =
https://android.googlesource.com/kernel/msm/+/android-7.1.1_r0.20/kernel/s=
ched/tune.c#150
