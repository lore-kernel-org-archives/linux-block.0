Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170922221405.22091-1-bart.vanassche@wdc.com>
References: <20170922221405.22091-1-bart.vanassche@wdc.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 25 Sep 2017 10:36:04 +0800
Message-ID: <CACVXFVNCcij6RNNxZ77iDMc_82j_qpfso+g+NqpfgN3Cs9=FpQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Make SCSI device suspend and resume work reliably
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>,
	"=Oleksandr Natalenko" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 23, 2017 at 6:13 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> Hello Jens,
>
> It is known that during the resume following a hibernate sometimes the
> system hangs instead of coming up properly. This patch series fixes this
> problem. This patch series is an alternative for Ming Lei's "[PATCH V5
> 0/10] block/scsi: safe SCSI quiescing" patch series. The advantages of
> this patch series are:

No, your patch doesn't fix scsi quiesce on block legacy, so not an alternative
of my patchset at all.

> - Easier to review because no new race conditions are introduced between
>   queue freezing and blk_cleanup_queue(). As the discussion that followed
>   Ming's patch series shows the correctness of the new code is hard to
>   verify.

I don't agree that my code is hard to verify. I have replied all your comments,
and the only thing you pay special attention to is that the race between preempt
quiesce and blk_cleanup_queue():

    - that is simply not a race
    - we have depended on drivers(legacy or blk-mq) to handle request correctly
   after queue is set as dying for long long time


-- 
Ming Lei
