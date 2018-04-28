Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 1/2] nvme: pci: simplify timeout handling
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-2-ming.lei@redhat.com>
 <b8dd2c24-a011-7e66-feca-502b0a6b10c0@oracle.com>
 <20180426155722.GA3597@ming.t460p>
 <325688af-3ae2-49db-3a59-ef3903adcdf6@oracle.com>
 <20180427145708.GA2767@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <18b7ab23-f0d6-6765-021a-28c225f8a990@oracle.com>
Date: Sat, 28 Apr 2018 22:00:17 +0800
MIME-Version: 1.0
In-Reply-To: <20180427145708.GA2767@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi ming

On 04/27/2018 10:57 PM, Ming Lei wrote:
> I may not understand your point, once blk_sync_queue() returns, the
> timer itself is deactivated, meantime the synced .nvme_timeout() only
> returns EH_NOT_HANDLED before the deactivation.
> 
> That means this timer won't be expired any more, so could you explain
> a bit why timeout can come again after blk_sync_queue() returns

Please consider the following case:

blk_sync_queue
  -> del_timer_sync          
                          blk_mq_timeout_work
                            -> blk_mq_check_expired // return the timeout value
                            -> blk_mq_terninate_expired
                              -> .timeout //return EH_NOT_HANDLED
                            -> mod_timer // setup the timer again based on the result of blk_mq_check_expired
  -> cancel_work_sync
So after the blk_sync_queue, the timer may come back again, then the timeout work.

Thanks
Jianchao
