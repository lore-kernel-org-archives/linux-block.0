Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Apr 2016 15:24:36 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling
 and cgroups support
Message-ID: <20160425192436.GE7822@mtj.duckdns.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org>
 <1454364778-25179-11-git-send-email-paolo.valente@linaro.org>
 <20160211222824.GD3741@mtj.duckdns.org>
 <57174CA7.5000706@linaro.org>
 <20160422181321.GV7822@mtj.duckdns.org>
 <ABE90C54-FE45-4713-87D8-6CD591CB04A2@linaro.org>
 <20160422184110.GX7822@mtj.duckdns.org>
 <C1A89D63-CBC4-4C92-8D5A-9FB55A53FBCF@linaro.org>
 <20160422193221.GY7822@mtj.duckdns.org>
 <57F65679-CD8E-43BA-8C46-C165B4C20677@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <57F65679-CD8E-43BA-8C46-C165B4C20677@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Paolo.

On Sat, Apr 23, 2016 at 09:07:47AM +0200, Paolo Valente wrote:
> There is certainly something I don’t know here, because I don’t
> understand why there is also a workqueue containing root-group I/O
> all the time, if the only process doing I/O belongs to a different
> (sub)group.

Hmmm... maybe metadata updates?

> Anyway, if this is expected, then there is no reason to bother you
> further on it. In contrast, the actual problem I see is the
> following. If one third or half of the bios belong to a different
> group than the writer that one wants to isolate, then, whatever
> weight is assigned to the writer group, we will never be able to let
> the writer get the desired share of the time (or of the bandwidth
> with bfq and all quasi-sequential workloads). For instance, in the
> scenario that you told me to try, the writer will never get 50% of
> the time, with any scheduler. Am I missing something also on this?

While a worker may jump across different cgroups, the IOs are still
coming from somewhere and if the only IO generator on the machine is
the test dd, the bios from that cgroup should dominate the IOs.  I
think it'd be helpful to investigate who's issuing the root cgroup
IOs.

Thanks.

-- 
tejun
