Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5 0/3] Ensure that a request queue is dissociated from
 the cgroup controller
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180809145338.6160-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9aaf1e67-c01f-8b0a-f312-6a216681f460@kernel.dk>
Date: Thu, 9 Aug 2018 09:13:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180809145338.6160-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/9/18 8:53 AM, Bart Van Assche wrote:
> Hello Jens,
> 
> Several block drivers call alloc_disk() followed by put_disk() if something
> fails before device_add_disk() is called without calling blk_cleanup_queue().
> Make sure that also for this scenario a request queue is dissociated from the
> cgroup controller. This patch avoids that loading the parport_pc, paride and
> pf drivers trigger a kernel crash. Since this patch series fixes a regression,
> please consider these patches for kernel v4.19.

Thanks, applied for 4.19.

-- 
Jens Axboe
