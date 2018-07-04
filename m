Return-Path: <ming.lei@redhat.com>
Date: Wed, 4 Jul 2018 17:08:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [RFC] bypass scheduler for no sched is set
Message-ID: <20180704090801.GA19175@ming.t460p>
References: <CAHsXFKHdhOE_USCASpiRd6dHzcNvo29ipeJ2LhVbEsxnyMow1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHsXFKHdhOE_USCASpiRd6dHzcNvo29ipeJ2LhVbEsxnyMow1A@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 04, 2018 at 01:29:50PM +0530, Kashyap Desai wrote:
> Hi,
> 
> Ming Lei posted below patch series and performance improved for
> megaraid_sas driver. I used the same kernel base and figure out some more
> possible performance improvement in block layer. This RFC improves
> performance as well as CPU utilization. If this patch fits the design
> aspect of the blk-mq and scsi-mq, I can convert it into PATCH and submit
> the same/modified version.
> 
> https://marc.info/?l=linux-block&m=153062994403732&w=2
> 
> Description of change -
> 
> Do not insert request into software queue if BLK_MQ_F_NO_SCHED is set.
> Submit request from blk_mq_make_request to low level driver directly as
> depicted through below function call.
> 
> blk_mq_try_issue_directly
> 
> 
> __blk_mq_try_issue_directly
> 
>                  scsi_queue_rq

Hi Kashyap,

When I sent you the patches[1] which include 'global tags' support, MegaRAID
is converted to per-node queues and becomes real MQ(q->nr_hw_queues > 1), IO
should have been issued direclty, please see the branch of '(plug &&
!blk_queue_nomerges(q))' and '(q->nr_hw_queues > 1 && is_sync)' in
blk_mq_make_request().

But looks not see any improvement from your test result, even though huge
improvement can be observed on null_blk/scsi_debug. Maybe somewhere is wrong,
and days ago I talked with Laurence about doing this kind of test again.

I will double check the 'global tags' patches, meantime could you or
Laurence help to check if global tags[2] works in expected way if
you'd like to?

[1] https://github.com/ming1/linux/commits/v4.16-rc-host-tags-v5
[2] https://github.com/ming1/linux/commits/v4.18-rc-host-tags-v8
> 
> Low level driver attached to scsi.mq can set BLK_MQ_F_NO_SCHED,  If they do
> not want benefit from io scheduler (e.a in case of SSDs connected to IT/MR
> controller). In case of HDD drives connected to HBA, driver can avoid
> setting BLK_MQ_F_NO_SCHED so that default elevator is set to mq-deadline.

That might be one way for improving megaraid_sas.

However, even for modern high performance device, such as NVMe, turns out
IO scheduler(such as kyber) may play a big role for improving latency or
throughput.


Thanks,
Ming
