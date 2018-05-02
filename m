Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2 1/5] block: introduce blk_quiesce_timeout() and
 blk_unquiesce_timeout()
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180429154152.16656-1-ming.lei@redhat.com>
 <20180429154152.16656-2-ming.lei@redhat.com>
 <93c4190f-178a-a3b4-5203-bd8c6a0eaef2@oracle.com>
 <20180502033342.GD22363@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <81dd6a4b-c27c-d39e-cccf-68a0ff3d1711@oracle.com>
Date: Wed, 2 May 2018 13:16:46 +0800
MIME-Version: 1.0
In-Reply-To: <20180502033342.GD22363@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 05/02/2018 11:33 AM, Ming Lei wrote:
> No, there isn't such race, the 'mod_timer' doesn't make a difference
> because 'q->timeout_off' will be visible in new work func after
> cancel_work_sync() returns. So even the timer is expired, work func
> still returns immediately.

Yes, you are right.
even if timer is setup , but the timeout work will return.

Thanks
Jianchao
