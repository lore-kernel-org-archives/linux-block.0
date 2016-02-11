Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Feb 2016 17:28:24 -0500
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling
 and cgroups support
Message-ID: <20160211222824.GD3741@mtj.duckdns.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org>
 <1454364778-25179-11-git-send-email-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454364778-25179-11-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Mon, Feb 01, 2016 at 11:12:46PM +0100, Paolo Valente wrote:
> From: Arianna Avanzini <avanzini.arianna@gmail.com>
> 
> Complete support for full hierarchical scheduling, with a cgroups
> interface. The name of the added policy is bfq.
> 
> Weights can be assigned explicitly to groups and processes through the
> cgroups interface, differently from what happens, for single
> processes, if the cgroups interface is not used (as explained in the
> description of the previous patch). In particular, since each node has
> a full scheduler, each group can be assigned its own weight.

* It'd be great if how cgroup support is achieved is better
  documented.

* How's writeback handled?

* After all patches are applied, both CONFIG_BFQ_GROUP_IOSCHED and
  CONFIG_CFQ_GROUP_IOSCHED exist.

* The default weight and weight range don't seem to follow the defined
  interface on the v2 hierarchy.  The default value should be 100.

* With all patches applied, booting triggers a RCU context warning.
  Please build with lockdep and RCU debugging turned on and fix the
  issue.

* I was testing on the v2 hierarchy with two top-level cgroups one
  hosting sequential workload and the other completely random.  While
  they eventually converged to a reasonable state, starting up the
  sequential workload while the random workload was running was
  extremely slow.  It crawled for quite a while.

* And "echo 100 > io.weight" hung the writing process.

Thanks.

-- 
tejun
