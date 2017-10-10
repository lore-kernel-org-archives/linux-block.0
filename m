Return-Path: <zwp10758@gmail.com>
Return-Path: <zwp10758@gmail.com>
From: weiping zhang <zwp10758@gmail.com>
Date: Wed, 11 Oct 2017 01:35:51 +0800
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, vgoyal@redhat.com, tj@kernel.org,
	axboe@kernel.dk, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V2 3/3] blockcg: export latency info for each cgroup
Message-ID: <20171010173551.GB2924@localhost.didichuxing.com>
References: <cover.1507337347.git.shli@fb.com>
 <c8b704eb77e0b8d1792cde7ca1fefcca09b7684f.1507337347.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c8b704eb77e0b8d1792cde7ca1fefcca09b7684f.1507337347.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 06, 2017 at 05:56:01PM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Export the latency info to user. The latency is a good sign to indicate
> if IO is congested or not. User can use the info to make decisions like
> adjust cgroup settings.
Hi Shaohua,
How to check IO congested or not by latency ? Different SSD has
different latency especially when mixed sequence and random IO
operatons.

> 
> Existing io.stat shows accumulated IO bytes and requests, but
> accumulated value for latency doesn't make much sense. This patch
How to understand "accumulated value for latency doesn't make much
sense" could you give an example? I think iostat's r_await and w_await
are nearly equal to rlat_mean and wlat_mean if there is no too much
request starved.
> exports the latency info in a 100ms interval.
> 
> To reduce overhead, latency info of children is propagated to parents
> every 10ms. This means the parents's latency could lost 10ms info of its
> children in 100ms. This should be ok, as we don't need precise latency
> info.
> 
> A micro benchmark running fio test against null_blk in a sixth level
> cgroup doesn't show obvious regression. perf shows a little bit overhead
> in blk_stat_add (~1%) and blkg_lookup (~1%), which is unavoidable right
> now.
> 
> With this patch, the io.stat will show:
> 8:0 rbytes=7282688 wbytes=0 rios=83 wios=0 rlat_mean=2720 rlat_min=183 rlat_max=14880 wlat_mean=0 wlat_min=0 wlat_max=0
> The new fields will display read/write average/minimum/maximum latency
> within 100ms. The latency is us.
> 

Thanks
Weiping
