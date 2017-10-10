Return-Path: <shli@kernel.org>
Date: Tue, 10 Oct 2017 11:23:40 -0700
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org, vgoyal@redhat.com, tj@kernel.org,
	axboe@kernel.dk, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V2 3/3] blockcg: export latency info for each cgroup
Message-ID: <20171010182340.rpqkzgx6pmmlplin@kernel.org>
References: <cover.1507337347.git.shli@fb.com>
 <c8b704eb77e0b8d1792cde7ca1fefcca09b7684f.1507337347.git.shli@fb.com>
 <20171010173551.GB2924@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171010173551.GB2924@localhost.didichuxing.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 11, 2017 at 01:35:51AM +0800, weiping zhang wrote:
> On Fri, Oct 06, 2017 at 05:56:01PM -0700, Shaohua Li wrote:
> > From: Shaohua Li <shli@fb.com>
> > 
> > Export the latency info to user. The latency is a good sign to indicate
> > if IO is congested or not. User can use the info to make decisions like
> > adjust cgroup settings.
> Hi Shaohua,
> How to check IO congested or not by latency ? Different SSD has
> different latency especially when mixed sequence and random IO
> operatons.

There is no magic here, you should know the SSD characteristics first. The idea
is observing the latency when the system isn't overcommited, for example,
running the workload in a one-cgroup setup, then using the observed latency to
guide configuration for multi-cgroup settings or check if IO is healthy in
cgroups.
 
> > 
> > Existing io.stat shows accumulated IO bytes and requests, but
> > accumulated value for latency doesn't make much sense. This patch
> How to understand "accumulated value for latency doesn't make much
> sense" could you give an example? 

rbytes and wbytes in io.stat are accumulated value. If such value of latency
isn't valuable.

> I think iostat's r_await and w_await
> are nearly equal to rlat_mean and wlat_mean if there is no too much
> request starved.

yes, pretty similar. io.stat is per-cgroup though

Thanks,
Shaohua
