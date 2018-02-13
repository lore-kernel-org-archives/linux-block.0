Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 RESENT] blk: optimization for classic polling
To: Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, joshi.k@samsung.com
References: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
 <CGME20180213082701epcas1p4d92a86f127a0918fb9d62120bd121cb6@epcas1p4.samsung.com>
 <1518548206-4766-1-git-send-email-nj.shetty@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <620867e2-2a0c-5c32-10c6-7cc5268ac944@kernel.dk>
Date: Tue, 13 Feb 2018 07:42:20 -0700
MIME-Version: 1.0
In-Reply-To: <1518548206-4766-1-git-send-email-nj.shetty@samsung.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/13/18 11:56 AM, Nitesh Shetty wrote:
> This removes the dependency on interrupts to wake up task. Set task
> state as TASK_RUNNING, if need_resched() returns true,
> while polling for IO completion.
> Earlier, polling task used to sleep, relying on interrupt to wake it up.
> This made some IO take very long when interrupt-coalescing is enabled in
> NVMe.

__set_current_state() should suffice here.

-- 
Jens Axboe
