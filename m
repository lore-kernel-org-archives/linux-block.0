Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 30 May 2018 09:44:21 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 13/13] Documentation: add a doc for blk-iolatency
Message-ID: <20180530164421.GQ1351649@devbig577.frc2.facebook.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-14-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180529211724.4531-14-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Tue, May 29, 2018 at 05:17:24PM -0400, Josef Bacik wrote:
> diff --git a/Documentation/blk-iolatency.txt b/Documentation/blk-iolatency.txt
> new file mode 100644
> index 000000000000..9dd86f4f64b6
> --- /dev/null
> +++ b/Documentation/blk-iolatency.txt

Can you make it a part of Documentation/cgroup-v2.txt?

> +Interface
> +=========
> +
> +- io.latency.  This takes a similar format as the other controllers
> +
> +	"MAJOR:MINOR target=<target time in microseconds"
                                                        >

> +HOWTO
> +=====
> +
> +The limits are only applied at the peer level in the heirarchy.  This means that
							^hierarchy

Thanks.

-- 
tejun
