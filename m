Return-Path: <mgorman@techsingularity.net>
Date: Thu, 10 Aug 2017 09:44:08 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Switching to MQ by default may generate some bug reports
Message-ID: <20170810084408.dddjjzp6w6jxd3lr@techsingularity.net>
References: <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org>
 <20170803110144.vvadm3cc5oetf7up@techsingularity.net>
 <4B181ED1-8605-4156-9BBF-B61A165BE7F5@linaro.org>
 <20170804110103.oljdzsy7bds6qylo@techsingularity.net>
 <34B4C2EB-18B2-4EAB-9BBC-8095603D733D@linaro.org>
 <70979B37-6F91-49C3-9C77-CB3364035DDF@linaro.org>
 <5E507CD1-C88A-4261-8043-75ABD5620054@linaro.org>
 <4D035E5E-3226-426A-8D38-957EE41ABCC8@linaro.org>
 <6520A791-0455-423F-8B16-7D4C369E86B0@linaro.org>
 <E82B7A0A-43EA-463A-95A0-50608562494C@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <E82B7A0A-43EA-463A-95A0-50608562494C@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 09, 2017 at 11:49:17PM +0200, Paolo Valente wrote:
> > This discrepancy with your results makes a little bit harder for me to
> > understand how to better proceed, as I see no regression.  Anyway,
> > since this reader-throttling issue seems relevant, I have investigated
> > it a little more in depth.  The cause of the throttling is that the
> > fdatasync frequently performed by the writers in this test turns the
> > I/O of the writers into a 100% sync I/O.  And neither bfq or cfq
> > differentiate bandwidth between sync reads and sync writes.  Basically
> > both cfq and bfq are willing to dispatch the I/O requests of each
> > writer for a time slot equal to that devoted to the reader.  But write
> > requests, after reaching the device, use the latter for much more time
> > than reads.  This delays the completion of the requests of the reader,
> > and, being the I/O sync, the issuing of the next I/O requests by the
> > reader.  The final result is that the device spends most of the time
> > serving write requests, while the reader issues its read requests very
> > slowly.
> > 
> > It might not be so difficult to balance this unfairness, although I'm
> > a little worried about changing bfq without being able to see the
> > regression you report.  In case I give it a try, could I then count on
> > some testing on your machines?
> > 
> 
> Hi Mel,
> I've investigated this test case a little bit more, and the outcome is
> unfortunately rather drastic, unless I'm missing some important point.
> It is impossible to control the rate of the reader with the exact
> configuration of this test. 

Correct, both are simply competing for access to IO. Very broadly speaking,
it's only checking for loose (but not perfect) fairness with different IO
patterns.  While it's not a recent problem, historically (2+ years ago) we
had problems whereby a heavy reader or writer could starve IO completely. It
had odd effects like some multi-threaded benchmarks being artifically good
simply because one thread would dominate and artifically complete faster and
exit prematurely. "Fixing" it had a tendency to help real workloads while
hurting some benchmarks so it's not straight-forward to control for properly.
Bottom line, I'm not necessarily worried if a particular benchmark shows
an apparent regression once I understand why and can convince myself that a
"real" workload benefits from it (preferably proving it).

> In fact, since iodepth is equal to 1, the
> reader issues one I/O request at a time.  When one such request is
> dispatched, after some write requests have already been dispatched
> (and then queued in the device), the time to serve the request is
> controlled only by the device.  The longer the device makes the read
> request wait before being served, the later the reader will see the
> completion of its request, and then the later the reader will issue a
> new request, and so on.  So, for this test, it is mainly the device
> controller to decide the rate of the reader.
> 

Understood. It's less than ideal but not a completely silly test either.
That said, the fio tests are relatively new compared to some of the tests
monitored by mmtests looking for issues. It can take time to finalise a
test configuration before it's giving useful data 100% of the time.

> On the other hand, the scheduler can gain again control of the
> bandwidth of the reader, if the reader issues more than one request at
> a time. 

Ok, I'll take it as a todo item to increase the depth as a depth of 1 is
not that interesting as such. It's also on my todo list to add fio
configs that add think time.

> Anyway, before analyzing this second, controllable case, I
> wanted to test responsiveness with this heavy write workload in the
> background.  And it was very bad!  After some hour of mild panic, I
> found out that this failure depends on a bug in bfq, bug that,
> luckily, happens to be triggered by these heavy writes as a background
> workload ...
> 
> I've already found and am testing a fix for this bug. Yet, it will
> probably take me some week to submit this fix, because I'm finally
> going on vacation.
> 

This is obviously both good and bad. Bad in that the bug exists at all,
good in that you detected it and a fix is possible. I don't think you have
to panic considering that some of the pending fixes include Ming's work
which won't be merged for quite some time and tests take a long time anyway.
Whenever you get around to a fix after your vacation, just cc me and I'll
queue it across a range of machines so you have some independent tests.
A review from me would not be worth much as I haven't spent the time to
fully understand BFQ yet.

If the fixes do not hit until the next merge window or the window after that
then someone who cares enough can do a performance-based -stable backport. If
there are any bugs in the meantime (e.g. after 4.13 comes out) then there
will be a series for the reporter to test. I think it's still reasonably
positive that issues with MQ being enabled by default were detected within
weeks with potential fixes in the pipeline. It's better than months passing
before a distro picked up a suitable kernel and enough time passed for a
coherent bug report to show up that's better than "my computer is slow".

Thanks for the hard work and prompt research. 

-- 
Mel Gorman
SUSE Labs
