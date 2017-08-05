Return-Path: <mgorman@techsingularity.net>
Date: Sat, 5 Aug 2017 12:54:04 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Switching to MQ by default may generate some bug reports
Message-ID: <20170805115404.vsrb3zuapskes3zi@techsingularity.net>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net>
 <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org>
 <20170803110144.vvadm3cc5oetf7up@techsingularity.net>
 <4B181ED1-8605-4156-9BBF-B61A165BE7F5@linaro.org>
 <20170804110103.oljdzsy7bds6qylo@techsingularity.net>
 <34B4C2EB-18B2-4EAB-9BBC-8095603D733D@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <34B4C2EB-18B2-4EAB-9BBC-8095603D733D@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Sat, Aug 05, 2017 at 12:05:00AM +0200, Paolo Valente wrote:
> > 
> > True. However, the difference between legacy-deadline mq-deadline is
> > roughly around the 5-10% mark across workloads for SSD. It's not
> > universally true but the impact is not as severe. While this is not
> > proof that the stack change is the sole root cause, it makes it less
> > likely.
> > 
> 
> I'm getting a little lost here.  If I'm not mistaken, you are saying,
> since the difference between two virtually identical schedulers
> (legacy-deadline and mq-deadline) is only around 5-10%, while the
> difference between cfq and mq-bfq-tput is higher, then in the latter
> case it is not the stack's fault.  Yet the loss of mq-bfq-tput in the
> above test is exactly in the 5-10% range?  What am I missing?  Other
> tests with mq-bfq-tput not yet reported?
> 

Unfortunately it's due to very broad generalisations. 10 configurations
from mmtests were used in total when I was checking this. Multiply those by
4 for each tested filesystem and then multiply again for each io scheduler
on a total of 7 machines taking 3-4 weeks to execute all tests. The deltas
between each configuration on different machines varies a lot. It also
is an impractical amount of information to present and discuss and the
point of the original mail was to highlight that switching the default
may create some bug reports so as not be too surprised or panic.

The general trend observed was that legacy-deadline vs mq-deadline generally
showed a small regression switching to mq-deadline but it was not universal
and it wasn't consistent. If nothing else, IO tests that are borderline
are difficult to test for significance as distributions are multimodal.
However, it was generally close enough to conclude "this could be tolerated
and more mq work is on the way". However, it's impossible to give a precise
range of how much of a hit it would take but it generally seemed to be
around the 5% mark.

CFQ switching to BFQ was often more dramatic. Sometimes it doesn't really
matter and sometimes turning off low_latency helped enough. bonnie, which
is a single IO issuer didn't show much differences in throughput. It had
a few problems with file create/delete but the absolute times there are
so small that tiny differences look relatively large and were ignored.
For the moment, I'll be temporarily ignoring bonnie because it was a
sniff-test only and I didn't expect many surprises from a single IO issuer.

The workload that cropped up as being most alarming was dbench was is ironic
given that it's not actually that IO intensive and tends to be limited by
fsync times. The benchmark has a number of other weaknesses.  It's more
often dominated by scheduler performance, can be gamed by starving all
but one threads from IO to give "better" results and is sensitive to the
exact timing of when writeback occurs which mmtests tries to mitigate by
reducing the loadfile size. If it turns out that it's the only benchmark
that really suffers then I think we would live with or find ways of tuning
around it but fio concerned me.

The fio ones were a concern because of different read/write throughputs
and the fact it was not consistent read or write that was favoured. These
changes are not necessary good or bad but I've seen in the past that writes
that get starved tend to impact workloads that periodically fsync dirty
data (think databases) and had to be tuned by reducing dirty_ratio. I've
also seen cases where syncing of metadata on some filesystems would cause
large stalls if there was a lot of write starvation. I regretted not adding
pgioperf (basic simulator of postgres IO behaviour) to the original set
of tests because it tends to be very good at detecting fsync stalls due
to write starvation.

> > <SNIP>
> > Sure, but if during those handful of seconds the throughput is 10% of
> > what is used to be, it'll still be noticeable.
> > 
> 
> I did not have the time yet to repeat this test (I will try soon), but
> I had the time think about it a little bit.  And I soon realized that
> actually this is not a responsiveness test against background
> workload, or, it is at most an extreme corner case for it.  Both the
> write and the read thread start at the same time.  So, we are
> mimicking a user starting, e.g., a file copy, and, exactly at the same
> time, an app(in addition, the file copy starts to cause heavy writes
> immediately).
> 

Yes, although it's not entirely unrealistic to have light random readers
and heavy writers starting at the same time. A write-intensive database
can behave like this.

Also, I wouldn't panic about needing time to repeat this test. This is
not blocking me as such as all I was interested in was checking if the
switch could be safely made now or should it be deferred while keeping an
eye on how it's doing. It's perfectly possible others will make the switch
and find the majority of their workloads are fine. If others report bugs
and they're using rotary storage then it should be obvious to ask them
to test with the legacy block layer and work from there. At least then,
there should be better reference workloads to look from. Unfortunately,
given the scope and the time it takes to test, I had little choice except
to shotgun a few workloads and see what happened.

> BFQ uses time patterns to guess which processes to privilege, and the
> time patterns of the writer and reader are indistinguishable here.
> Only tagging processes with extra information would help, but that is
> a different story.  And in this case tagging would help for a
> not-so-frequent use case.
> 

Hopefully there will not be a reliance on tagging processes. If we're
lucky, I just happened to pick a few IO workloads that seemed to suffer
particularly badly.

> In addition, a greedy random reader may mimick the start-up of only
> very simple applications.  Even a simple terminal such as xterm does
> some I/O (not completely random, but I guess we don't need to be
> overpicky), then it stops doing I/O and passes the ball to the X
> server, which does some I/O, stops and passes the ball back to xterm
> for its final start-up phase.  More and more processes are involved,
> and more and more complex I/O patterns are issued as applications
> become more complex.  This is the reason why we strived to benchmark
> application start-up by truly starting real applications and measuring
> their start-up time (see below).
> 

Which is fair enough, can't argue with that. Again, the intent here is
not to rag on BFQ. I had a few configurations that looked alarming which I
sometimes use as an early warning that complex workloads may have problems
that are harder to debug. It's not always true. Sometimes the early warnings
are red herrings. I've had a long dislike for dbench4 too but each time I
got rid of it, it showed up again on some random bug report which is the
only reason I included it in this evaluation.

> > I did have something like this before but found it unreliable because it
> > couldn't tell the difference between when an application has a window
> > and when it's ready for use. Evolution for example may start up and
> > start displaing but then clicking on a mail may stall for a few seconds.
> > It's difficult to quantify meaningfully which is why I eventually gave
> > up and relied instead on proxy measures.
> > 
> 
> Right, that's why we looked for other applications that were as
> popular, but for which we could get reliable and precise measures.
> One such application is a terminal, another one a shell.  On the
> opposite end of the size spectrum, another other such applications are
> libreoffice/openoffice.
> 

Seems reasonable.

> For, e.g, gnome-terminal, it is enough to invoke "time gnome-terminal
> -e /bin/true".  By the stopwatch, such a command measures very
> precisely the time that elapses from when you start the terminal, to
> when you can start typing a command in its window.  Similarly, "xterm
> /bin/true", "ssh localhost exit", "bash -c exit", "lowriter
> --terminate-after-init".  Of course, these tricks certainly cause a
> few more block reads than the real, bare application start-up, but,
> even if the difference were noticeable in terms of time, what matters
> is to measure the execution time of these commands without background
> workload, and then compare it against their execution time with some
> background workload.  If it takes, say, 5 seconds without background
> workload, and still about 5 seconds with background workload and a
> given scheduler, but, with another scheduler, it takes 40 seconds with
> background workload (all real numbers, actually), then you can draw
> some sound conclusion on responsiveness for the each of the two
> schedulers.
> 

Again, that is a fair enough methodology and will work in many cases.
It's somewhat impractical for myself. When I'm checking patches (be they new
patches I developed, am backporting or looking at new kernels), I usually
am checking a range of workloads across multiple machines and it's only
when I'm doing live analysis of a problem that I'm directly using a machine.

> In addition, as for coverage, we made the empiric assumption that
> start-up time measured with each of the above easy-to-benchmark
> applications gives an idea of the time that it would take with any
> application of the same size and complexity.  User feedback confirmed
> this assumptions so far.  Of course there may well be exceptions.
> 

FWIW, I also have anecdotal evidence from at least one user that using
BFQ is way better on their desktop than CFQ ever was even under the best
of circumstances. I've had problems directly measuring it empirically but
this was also the first time I switched on BFQ to see what fell out so
it's early days yet.

-- 
Mel Gorman
SUSE Labs
