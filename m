Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 5 Oct 2017 10:25:16 -0700
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, vgoyal@redhat.com, axboe@kernel.dk,
	Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [RFC 2/2] blockcg: export latency info for each cgroup
Message-ID: <20171005172515.GV3301751@devbig577.frc2.facebook.com>
References: <cover.1507138530.git.shli@fb.com>
 <7f592647e6c30b6eb7cb1cef4892bca060a73d78.1507138530.git.shli@fb.com>
 <20171004180438.GQ3301751@devbig577.frc2.facebook.com>
 <20171005164505.sbreklcta6rs4acd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171005164505.sbreklcta6rs4acd@kernel.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Shaohua.

On Thu, Oct 05, 2017 at 09:45:05AM -0700, Shaohua Li wrote:
> Looks that is similar to how io.stat exposes bytes/ios. It does the
> propagation at the time when user read the status file. However, doing the same
> for latency is meaningless, we shouldn't accumulate latency for a long time. If
> we want to do it lazily, alternatives are:
> - export total requests and total latency. User can calculate the average in
>   any interval. We can't export min/max latency then.
> - export avg/min/max since last time when user reads io.stat. We clear all
>   statistics once user reads io.stat and re-account from scratch.

I think there are more options than the above, especially given that
the propagation up the tree doens't have to be completely accurate.
For example, you can combine multiple averages values after the fact
if you also remember the relative weights each should carry and
combining after the fact is trivial for min/max.

Can you please take a look at how loadavg does calculations lazily and
look into a bit more about how the propagation up the tree can be
lazily done?

Thanks.

-- 
tejun
