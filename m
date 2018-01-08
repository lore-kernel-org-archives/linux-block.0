Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for Linux 4.16
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180108185253.3d4k2wumlm5n4yqd@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <df77dc88-7321-d6ae-7fec-865b60babc23@kernel.dk>
Date: Mon, 8 Jan 2018 12:20:42 -0700
MIME-Version: 1.0
In-Reply-To: <20180108185253.3d4k2wumlm5n4yqd@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/8/18 11:52 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below are the pending nvme updates for Linux 4.16.  Just fixes and
> cleanups from various contributors this time around.
> 
> The following changes since commit fb350e0ad99359768e1e80b4784692031ec340e4:
> 
>   blk-mq: fix race between updating nr_hw_queues and switching io sched (2018-01-06 09:25:36 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.16

Thanks, pulled.

-- 
Jens Axboe
