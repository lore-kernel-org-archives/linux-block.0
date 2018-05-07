Return-Path: <sebott@linux.ibm.com>
Date: Mon, 7 May 2018 16:48:38 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
cc: linux-block@vger.kernel.org
Subject: Re: lockdep splats with blk-mq drivers
In-Reply-To: <alpine.LFD.2.21.1804191404540.17056@schleppi>
References: <alpine.LFD.2.21.1804191404540.17056@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1805071646480.1835@schleppi>
List-ID: <linux-block@vger.kernel.org>

Hi,

On Thu, 19 Apr 2018, Sebastian Ott wrote:
> Since commit 1d9bd5161ba3 ("blk-mq: replace timeout synchronization with a
> RCU and generation based scheme") I observe lockdep complaints (full
> message attached):
> 
> [   21.763369]        CPU0                    CPU1
> [   21.763370]        ----                    ----
> [   21.763371]   lock(&rq->gstate_seq);
> [   21.763374]                                local_irq_disable();
> [   21.763375]                                lock(&(&dq->lock)->rlock);
> [   21.763377]                                lock(&rq->gstate_seq);
> [   21.763379]   <Interrupt>
> [   21.763380]     lock(&(&dq->lock)->rlock);
> [   21.763382] 
>                 *** DEADLOCK ***
> 
> 
> This only happens in combination with DASD (s390 specific) and another
> blk-mq driver (scsi, null_blk). The distinctive behavior of DASD is that
> it calls blk_mq_start_request with irqs disabled.
> 
> This is a false positive since gstate_seq on CPU0 is from a different
> request queue / block driver than gstate_seq on CPU1.
> 
> Possible fixes are to use local_irq_save/restore in blk_mq_start_request.
> Or, since it's a false positive, teach lockdep that these are different
> locks - like below:

Something we can do here? I've send 2 proposals to address this. Do they
make sense?

Regards,
Sebastian
