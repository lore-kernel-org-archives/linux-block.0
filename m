Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33712 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752778AbcJDSuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2016 14:50:22 -0400
Date: Tue, 4 Oct 2016 14:50:18 -0400
From: Tejun Heo <tj@kernel.org>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@fb.com, Kernel-team@fb.com,
        jmoyer@redhat.com
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161004185018.GE4205@htj.duckdns.org>
References: <cover.1475529372.git.shli@fb.com>
 <20161004132805.GB28808@redhat.com>
 <20161004155616.GB4205@htj.duckdns.org>
 <20161004181245.GC25323@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161004181245.GC25323@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Vivek.

On Tue, Oct 04, 2016 at 02:12:45PM -0400, Vivek Goyal wrote:
> Agreed that we don't have a good basic unit to measure IO cost. I was
> thinking of measuring cost in terms of sectors as that's simple and
> gets more accurate on faster devices with almost no seek penalty. And

If this were true, we could simply base everything on bandwidth;
unfortunately, even highspeed ssds perform wildly differently
depending on the specifics of workloads.

> in fact this proposal is also providing fairness in terms of bandwitdh.
> One extra feature seems to be this notion of minimum bandwidth for each
> cgroup and until and unless all competing groups have met their minimum,
> other cgroups can't cross their limits.

Haven't read the patches yet but it should allow regulating in terms
of both bandwidth and iops.

> (BTW, should we call io.high, io.minimum instead. To say, this is the
>  minimum bandwidth group should get before others get to cross their
>  minimum limit till max limit).

The naming convetion is min, low, high, max but I'm not sure "min",
which means hard minimum amount (whether guaranteed or best-effort),
quite makes sense here.

> > It mostly defers the burden to the one who's configuring the limits
> > and expects it to know the characteristics of the device and workloads
> > and configure accordingly.  It's quite a bit more tedious to use but
> > should be able to cover good portion of use cases without being overly
> > complicated.  I agree that it'd be nice to have a simple proportional
> > control but as you said can't see a good solution for it at the
> > moment.
> 
> Ok, so idea is that if we can't provide something accurate in kernel,
> then expose a very low level knob, which is harder to configure but
> should work in some cases where users know their devices and workload
> very well. 

Yeah, that's the basic idea for this approach.  It'd be great if we
eventually end up with proper proportional control but having
something low level is useful anyway, so...

> > I don't think it's catering to specific use cases.  It is a generic
> > mechanism which demands knowledge and experimentation to configure.
> > It's more a way for the kernel to cop out and defer figuring out
> > device characteristics to userland.  If you have a better idea, I'm
> > all ears.
> 
> I don't think I have a better idea as such. Once we had talked and you
> mentioned that for faster devices we should probably do some token based
> mechanism (which I believe would probably mean sector based IO
> accounting). 

That's more about the implementation strategy and doesn't affect
whether we support bw, iops or combined configurations.  In terms of
implementation, I still think it'd be great to have something token
based with per-cpu batch to lower the cpu overhead on highspeed
devices but that shouldn't really affect the semantics.

Thanks.

-- 
tejun
