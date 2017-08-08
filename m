Return-Path: <mgorman@techsingularity.net>
Date: Tue, 8 Aug 2017 19:27:35 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Switching to MQ by default may generate some bug reports
Message-ID: <20170808182735.olv3lxuraao4szc7@techsingularity.net>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net>
 <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org>
 <20170803110144.vvadm3cc5oetf7up@techsingularity.net>
 <4B181ED1-8605-4156-9BBF-B61A165BE7F5@linaro.org>
 <20170804110103.oljdzsy7bds6qylo@techsingularity.net>
 <34B4C2EB-18B2-4EAB-9BBC-8095603D733D@linaro.org>
 <70979B37-6F91-49C3-9C77-CB3364035DDF@linaro.org>
 <5E507CD1-C88A-4261-8043-75ABD5620054@linaro.org>
 <4D035E5E-3226-426A-8D38-957EE41ABCC8@linaro.org>
 <6520A791-0455-423F-8B16-7D4C369E86B0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <6520A791-0455-423F-8B16-7D4C369E86B0@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 08, 2017 at 07:33:37PM +0200, Paolo Valente wrote:
> > Differently from bfq-sq, setting slice_idle to 0 doesn't provide any
> > benefit, which lets me suspect that there is some other issue in
> > blk-mq (only a suspect).  I think I may have already understood how to
> > guarantee that bfq almost never idles the device uselessly also for
> > this workload.  Yet, since in blk-mq there is no gain even after
> > excluding useless idling, I'll wait for at least Ming's patches to be
> > merged before possibly proposing this contribution.  Maybe some other
> > little issue related to this lack of gain in blk-mq will be found and
> > solved in the meantime.
> > 
> > Moving to the read-write unfairness problem.
> > 
> 
> I've reproduced the unfairness issue (rand reader throttled by heavy
> writers) with bfq, using
> configs/config-global-dhp__io-fio-randread-sync-heavywrite, but with
> an important side problem: cfq suffers from exactly the same
> unfairness (785kB/s writers, 13.4kB/s reader).  Of course, this
> happens in my system, with a HITACHI HTS727550A9E364.
> 

It's interesting that CFQ suffers the same on your system. It's possible
that this is down to luck and the results depend not only on the disk but
the number of CPUs. At absolute minimum we saw different latency figures
from dbench even if the only observation s "different machines behave
differently, news at 11". If the results are inconsistent, then the value of
the benchmark can be dropped as a basis of comparison between IO schedulers
(although I'll be keeping it for detecting regressions between releases).

When the v4 results from Ming's patches complete, I'll double check the
results from this config.

> This discrepancy with your results makes a little bit harder for me to
> understand how to better proceed, as I see no regression.  Anyway,
> since this reader-throttling issue seems relevant, I have investigated
> it a little more in depth.  The cause of the throttling is that the
> fdatasync frequently performed by the writers in this test turns the
> I/O of the writers into a 100% sync I/O.  And neither bfq or cfq
> differentiate bandwidth between sync reads and sync writes.  Basically
> both cfq and bfq are willing to dispatch the I/O requests of each
> writer for a time slot equal to that devoted to the reader.  But write
> requests, after reaching the device, use the latter for much more time
> than reads.  This delays the completion of the requests of the reader,
> and, being the I/O sync, the issuing of the next I/O requests by the
> reader.  The final result is that the device spends most of the time
> serving write requests, while the reader issues its read requests very
> slowly.
> 

That is certainly plausible and implies that the actual results depend
too heavily on random timing factors and disk model to be really useful.

> It might not be so difficult to balance this unfairness, although I'm
> a little worried about changing bfq without being able to see the
> regression you report.  In case I give it a try, could I then count on
> some testing on your machines?
> 

Yes with the caveat that results take a variable amount of time depending
on how many problems I'm juggling in the air and how many of them are
occupying time on the machines.

-- 
Mel Gorman
SUSE Labs
