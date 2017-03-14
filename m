Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1488848390.3125.14.camel@sandisk.com>
Date: Tue, 14 Mar 2017 16:35:36 +0100
Cc: "tj@kernel.org" <tj@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "broonie@kernel.org" <broonie@kernel.org>
Message-Id: <81048010-02AB-4A7A-8C10-FAF7E3242DCC@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org> <1488848390.3125.14.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 07 mar 2017, alle ore 02:00, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Sat, 2017-03-04 at 17:01 +0100, Paolo Valente wrote:
>> Finally, a few details on the patchset.
>>=20
>> The first two patches introduce BFQ-v0, which is more or less the
>> first version of BFQ submitted a few years ago [1].  The remaining
>> patches turn progressively BFQ-v0 into BFQ-v8r8, the current version
>> of BFQ.
>=20
> Hello Paolo,
>=20

Hi Bart,

> Thank you for having done the work to improve, test, fix and post the
> BFQ scheduler as a patch series. However, from what I have seen in the
> patches there is a large number of tunable constants in the code for
> which no scientific approach exists to chose an optimal value.

I'm very sorry about that, I have exported those parameters over the
years, just as an aid for debugging and tuning.  Then I have forgot to
remove them :(

They'll disappear in my next submission.

> Additionally, the complexity of the code is huge. Just like for CFQ,
> sooner or later someone will run into a bug or a performance issue
> and will post a patch to fix it. However, the complexity of BFQ is
> such that a source code review alone won't be sufficient to verify
> whether or not such a patch negatively affects a workload or device
> that has not been tested by the author of the patch. This makes me
> wonder what process should be followed to verify future BFQ patches?
>=20

I've a sort of triple reply for that.

First, I've developed BFQ in a sort of
first-the-problem-then-the-solution way.  That is, each time, I have
first implemented a benchmark that enabled me to highlight the problem
and get all relevant statistics on it, then I have worked on BFQ to
try to solve that problem, using the benchmark as a support.  All
those benchmarks are in the public S suite now.  In particular, by
running one script, and waiting at most one hour, you get graphs of
- throughput with read/write/random/sequential workloads
- start-up times of bash, xterm, gnome terminal and libreoffice, when
all the above combinations of workloads are executed in the background
- frame drop rate for the playback of a movie, again with both all the
above combinations of workloads and the recurrent start of a bash
shell in the background
- kernel-task execution times (compilation, merge, ...), again with
all the above combinations of workloads in the background
- fairness with various combinations of weights and processes
- throughput against interleaved I/O, with a number of readers ranging
from 2 to 9

Every time I fix a bug, add a new feature or port BFQ to a new kernel
version, I just run that script and compare new graphs with previous
ones.  Any regression shows up immediately.  We already have a
similar, working script for Android too, although covering only
throughput, responsiveness and frame drops for the moment.  Of course,
the coverage of these scripts is limited to only the goals for which I
have devised and tuned BFQ so far.  But I hope that it won't be too
hard to extend them to other important use cases (e.g., dbms).

Second, IMO BFQ is complex also because it contains a lot of features.
We have adopted the usual approach for handling this type of
complexity: find clean cuts to get independent pieces, and put each
piece in a separate file, plus one header glue file.  The pieces were:
scheduling engine, hierarchical-scheduling support (allowing the
engine to scheduler generic nodes in the hierarchy), cgroups support.
Yet, Tejun last year, and Jens more recently, have asked to put
everything in one file; for other good reasons of course.  If you do
think that turning back to multiple files may somehow help, and there
are no strong objections from others, then I'm willing to resume this
option and possibly find event better splits.

Third and last, a proposal: why don't we discuss this issue at LSF
too?  In particular, we could talk about the parts of BFQ that seem
more complex to understand, until they become clearer to you.  Then I
could try to understand what helped make them clearer, and translate
it into extra comments in the code or into other, more radical
changes.

Thanks,
Paolo

> Thanks,
>=20
> Bart.
