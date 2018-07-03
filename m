Return-Path: <rdunlap@infradead.org>
Subject: Re: [PATCH 13/14] Documentation: add a doc for blk-iolatency
To: Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
 tj@kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
 <20180703151503.2549-14-josef@toxicpanda.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5b4d3156-d11c-d256-cd0b-3c4bc0bc9296@infradead.org>
Date: Tue, 3 Jul 2018 15:28:56 -0700
MIME-Version: 1.0
In-Reply-To: <20180703151503.2549-14-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/03/18 08:15, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> A basic documentation to describe the interface, statistics, and
> behavior of io.latency.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 79 +++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 8a2c52d5c53b..569ce27b85e5 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -51,6 +51,9 @@ v1 is available under Documentation/cgroup-v1/.
>       5-3. IO
>         5-3-1. IO Interface Files
>         5-3-2. Writeback
> +       5-3-3. IO Latency
> +         5-3-3-1. How IO Latency Throttling Works
> +         5-3-3-2. IO Latency Interface Files
>       5-4. PID
>         5-4-1. PID Interface Files
>       5-5. Device
> @@ -1446,6 +1449,82 @@ writeback as follows.
>  	vm.dirty[_background]_ratio.
>  
>  
> +IO Latency
> +~~~~~~~~~~
> +
> +This is a cgroup v2 controller for IO workload protection.  You provide a group
> +with a latency target, and if the average latency exceeds that target the
> +controller will throttle any peers that have a lower latency target than the
> +protected workload.
> +
> +The limits are only applied at the peer level in the hierarchy.  This means that
> +in the diagram below, only groups A, B, and C will influence each other, and
> +groups D and F will influence each other.  Group G will influence nobody.
> +
> +			[root]
> +		/	   |		\
> +		A	   B		C
> +	       /  \        |
> +	      D    F	   G
> +
> +
> +So the ideal way to configure this is to set io.latency in groups A, B, and C.
> +Generally you do not want to set a value lower than the latency your device
> +supports.  Experiment to find the value that works best for your workload.
> +Start at higher than the expected latency for your device and watch the
> +total_lat_avg value in io.stat for your workload group to get an idea of the
> +latency you see during normal operation.  Use this value as a basis for your
> +real setting, setting at 10-15% higher than the value in io.stat.
> +Experimentation is key here because total_lat_avg is a running total, so is the
> +"statistics" portion of "lies, damned lies, and statistics."
> +
> +How IO Latency Throttling Works
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +io.latency is work conserving; so as long as everybody is meeting their latency
> +target the controller doesn't do anything.  Once a group starts missing its
> +target it begins throttling any peer group that has a higher target than itself.
> +This throttling takes 2 forms:
> +
> +- Queue depth throttling.  This is the number of outstanding IO's a group is
> +  allowed to have.  We will clamp down relatively quickly, starting at no limit
> +  and going all the way down to 1 IO at a time.
> +
> +- Artificial delay induction.  There are certain types of IO that cannot be
> +  throttled without possibly adversely affecting higher priority groups.  This
> +  includes swapping and metadata IO.  These types of IO are allowed to occur
> +  normally, however they are "charged" to the originating group.  If the
> +  originating group is being throttled you will see the use_delay and delay
> +  fields in io.stat increase.  The delay value is how many microseconds that are
> +  being added to any process that runs in this group.  Because this number can
> +  grow quite large if there is a lot of swapping or metadata IO occurring we
> +  limit the individual delay events to 1 second at a time.
> +
> +Once the victimized group starts meeting its latency target again it will start
> +unthrottling any peer groups that were throttled previously.  If the victimized
> +group simply stops doing IO the global counter will unthrottle appropriately.
> +
> +IO Latency Interface Files
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +  io.latency
> +	This takes a similar format as the other controllers.
> +
> +		"MAJOR:MINOR target=<target time in microseconds"

(repeat comment:)                                in microseconds>"

> +
> +  io.stat
> +	If the controller is enabled you will see extra stats in io.stat in
> +	addition to the normal ones.
> +
> +	  depth
> +		This is the current queue depth for the group.
> +
> +	  avg_lat
> +		The running average IO latency for this group in microseconds.
> +		Running average is generally flawed, but will give an
> +		administrator a general idea of the overall latency they can
> +		expect for their workload on the given disk.
> +
>  PID
>  ---
>  
> 


-- 
~Randy
