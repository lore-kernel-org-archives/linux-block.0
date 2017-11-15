Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 Nov 2017 15:30:18 -0800
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Kernel-team@fb.com
Subject: Re: [PATCH] blk-throttle: allow configure 0 for some settings
 --resend
Message-ID: <20171115233018.GC983427@devbig577.frc2.facebook.com>
References: <74e04440fa46aca5488912050395f2bc406f7afa.1510787708.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <74e04440fa46aca5488912050395f2bc406f7afa.1510787708.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 15, 2017 at 03:27:29PM -0800, Shaohua Li wrote:
> For io.low, latency target 0 is legit. 0 for rbps/wbps/rios/wios is ok
> too. And we use 0 to clear io.low settings.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
