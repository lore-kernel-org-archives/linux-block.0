Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V5 9/9] nvme: pci: support nested EH
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <20180511122933.27155-10-ming.lei@redhat.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a2580133-f65c-b301-f1b0-672af97f2feb@oracle.com>
Date: Tue, 15 May 2018 18:02:13 +0800
MIME-Version: 1.0
In-Reply-To: <20180511122933.27155-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi ming

On 05/11/2018 08:29 PM, Ming Lei wrote:
> +static void nvme_eh_done(struct nvme_eh_work *eh_work, int result)
> +{
> +	struct nvme_dev *dev = eh_work->dev;
> +	bool top_eh;
> +
> +	spin_lock(&dev->eh_lock);
> +	top_eh = list_is_last(&eh_work->list, &dev->eh_head);
> +	dev->nested_eh--;
> +
> +	/* Fail controller if the top EH can't recover it */
> +	if (!result)
> +		wake_up_all(&dev->eh_wq);
> +	else if (top_eh) {
> +		dev->ctrl_failed = true;
> +		nvme_eh_sched_fail_ctrl(dev);
> +		wake_up_all(&dev->eh_wq);
> +	}
> +
> +	list_del(&eh_work->list);
> +	spin_unlock(&dev->eh_lock);
> +
> +	dev_info(dev->ctrl.device, "EH %d: state %d, eh_done %d, top eh %d\n",
> +			eh_work->seq, dev->ctrl.state, result, top_eh);
> +	wait_event(dev->eh_wq, nvme_eh_reset_done(dev));

decrease the nested_eh before it exits, another new EH will have confusing seq number.
please refer to following log:
[ 1342.961869] nvme nvme0: Abort status: 0x0
[ 1342.961878] nvme nvme0: Abort status: 0x0
[ 1343.148341] nvme nvme0: EH 0: after shutdown, top eh: 1
[ 1403.828484] nvme nvme0: I/O 21 QID 0 timeout, disable controller
[ 1403.828603] nvme nvme0: EH 1: before shutdown
... waring logs are ignored here 
[ 1403.984731] nvme nvme0: EH 0: state 4, eh_done -4, top eh 0  // EH0 go to wait
[ 1403.984786] nvme nvme0: EH 1: after shutdown, top eh: 1
[ 1464.856290] nvme nvme0: I/O 22 QID 0 timeout, disable controller  // timeout again in EH 1
[ 1464.856411] nvme nvme0: EH 1: before shutdown // a new EH has a 1 seq number

Is it expected that the new EH has seq number 1 instead of 2 ?

Thanks
Jianchao
