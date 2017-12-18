Return-Path: <vgoyal@redhat.com>
Date: Mon, 18 Dec 2017 13:29:34 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Khazhismel Kumykov <khazhy@google.com>
Cc: Shaohua Li <shli@kernel.org>, shli@fb.com, tj@kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [RFC PATCH] blk-throttle: add burst allowance.
Message-ID: <20171218182934.GB7474@redhat.com>
References: <20171114231022.42961-1-khazhy@google.com>
 <20171116165033.4noofd6gkaj6x3yl@kernel.org>
 <CACGdZY+OdN-yfTGFgd1qmXBn+z3OkKMX3FeCnwSdYVHj7HdQyw@mail.gmail.com>
 <20171117192614.4knf72v26iir6tpi@kernel.org>
 <CACGdZYLo+EBC-1Q03YVJjwd=TVEMH9zErKJE2ebtEtLpqLyqjQ@mail.gmail.com>
 <CACGdZYL3rXUyEEbxJMcYp+q86fD=D0N06MQfmXQCfF3CGBqLiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACGdZYL3rXUyEEbxJMcYp+q86fD=D0N06MQfmXQCfF3CGBqLiw@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Dec 18, 2017 at 10:16:02AM -0800, Khazhismel Kumykov wrote:
> On Mon, Nov 20, 2017 at 8:36 PM, Khazhismel Kumykov <khazhy@google.com> wrote:
> > On Fri, Nov 17, 2017 at 11:26 AM, Shaohua Li <shli@kernel.org> wrote:
> >> On Thu, Nov 16, 2017 at 08:25:58PM -0800, Khazhismel Kumykov wrote:
> >>> On Thu, Nov 16, 2017 at 8:50 AM, Shaohua Li <shli@kernel.org> wrote:
> >>> > On Tue, Nov 14, 2017 at 03:10:22PM -0800, Khazhismel Kumykov wrote:
> >>> >> Allows configuration additional bytes or ios before a throttle is
> >>> >> triggered.
> >>> >>
> >>> >> This allows implementation of a bucket style rate-limit/throttle on a
> >>> >> block device. Previously, bursting to a device was limited to allowance
> >>> >> granted in a single throtl_slice (similar to a bucket with limit N and
> >>> >> refill rate N/slice).
> >>> >>
> >>> >> Additional parameters bytes/io_burst_conf defined for tg, which define a
> >>> >> number of bytes/ios that must be depleted before throttling happens. A
> >>> >> tg that does not deplete this allowance functions as though it has no
> >>> >> configured limits. tgs earn additional allowance at rate defined by
> >>> >> bps/iops for the tg. Once a tg has *_disp > *_burst_conf, throttling
> >>> >> kicks in. If a tg is idle for a while, it will again have some burst
> >>> >> allowance before it gets throttled again.
> >>> >>
> >>> >> slice_end for a tg is extended until io_disp/byte_disp would fall to 0,
> >>> >> when all "used" burst allowance would be earned back. trim_slice still
> >>> >> does progress slice_start as before and decrements *_disp as before, and
> >>> >> tgs continue to get bytes/ios in throtl_slice intervals.
> >>> >
> >>> > Can you describe why we need this? It would be great if you can describe the
> >>> > usage model and an example. Does this work for io.low/io.max or both?
> >>> >
> >>> > Thanks,
> >>> > Shaohua
> >>> >
> >>>
> >>> Use case that brought this up was configuring limits for a remote
> >>> shared device. Bursting beyond io.max is desired but only for so much
> >>> before the limit kicks in, afterwards with sustained usage throughput
> >>> is capped. (This proactively avoids remote-side limits). In that case
> >>> one would configure in a root container io.max + io.burst, and
> >>> configure low/other limits on descendants sharing the resource on the
> >>> same node.
> >>>
> >>> With this patch, so long as tg has not dispatched more than the burst,
> >>> no limit is applied at all by that tg, including limit imposed by
> >>> io.low in tg_iops_limit, etc.
> >>
> >> I'd appreciate if you can give more details about the 'why'. 'configuring
> >> limits for a remote shared device' doesn't justify the change.
> >
> > This is to configure a bursty workload (and associated device) with
> > known/allowed expected burst size, but to not allow full utilization
> > of the device for extended periods of time for QoS. During idle or low
> > use periods the burst allowance accrues, and then tasks can burst well
> > beyond the configured throttle up to the limit, afterwards is
> > throttled. A constant throttle speed isn't sufficient for this as you
> > can only burst 1 slice worth, but a limit of sorts is desirable for
> > preventing over utilization of the shared device. This type of limit
> > is also slightly different than what i understand io.low does in local
> > cases in that tg is only high priority/unthrottled if it is bursty,
> > and is limited with constant usage
> >
> > Khazhy
> 
> Hi Shaohua,
> 
> Does this clarify the reason for this patch? Is this (or something
> similar) a good fit for inclusion in blk-throttle?
> 

So does this brust have to be per cgroup. I mean if thortl_slice was
configurable, that will allow to control the size of burst. (Just that
it will be for all cgroups). If that works, that might be a simpler
solution.

Vivek
