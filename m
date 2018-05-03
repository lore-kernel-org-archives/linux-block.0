Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3 7/8] nvme: pci: recover controller reliably
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180503031716.31446-1-ming.lei@redhat.com>
 <20180503031716.31446-8-ming.lei@redhat.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <32819b0a-acc8-fa76-5e58-8e75e2bc081b@oracle.com>
Date: Thu, 3 May 2018 17:14:30 +0800
MIME-Version: 1.0
In-Reply-To: <20180503031716.31446-8-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi ming

On 05/03/2018 11:17 AM, Ming Lei wrote:
>  static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
> @@ -1199,7 +1204,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	if (nvme_should_reset(dev, csts)) {
>  		nvme_warn_reset(dev, csts);
>  		nvme_dev_disable(dev, false, true);
> -		nvme_reset_ctrl(&dev->ctrl);
> +		nvme_eh_reset(dev);
>  		return BLK_EH_HANDLED;
>  	}
>  
> @@ -1242,7 +1247,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  			 "I/O %d QID %d timeout, reset controller\n",
>  			 req->tag, nvmeq->qid);
>  		nvme_dev_disable(dev, false, true);
> -		nvme_reset_ctrl(&dev->ctrl);
> +		nvme_eh_reset(dev);

w/o the 8th patch, invoke nvme_eh_reset in nvme_timeout is dangerous.
nvme_pre_reset_dev will send a lot of admin io when initialize the controller.
if this admin ios timeout, the nvme_timeout cannot handle this because the timeout work is sleeping
to wait admin ios.

In addition, even if we take the nvme_wait_freeze out of nvme_eh_reset and put it into another context,
but the ctrl state is still CONNECTING, the nvme_eh_reset cannot move forward.

Actually, I used to report this issue to Keith. I met io hung when the controller die in
nvme_reset_work -> nvme_wait_freeze. As you know, the nvme_reset_work cannot be scheduled because it is waiting.
Here is Keith's commit for this:
http://lists.infradead.org/pipermail/linux-nvme/2018-February/015603.html

Thanks
Jianchao



 
