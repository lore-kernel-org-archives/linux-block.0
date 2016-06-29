Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <576CE200.2040306@suse.de>
References: <576CE200.2040306@suse.de>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 29 Jun 2016 17:29:06 +0800
Message-ID: <CACVXFVMPFBYpt+C52HC3r_1VL7hwRDC0bytkiDSM5pra-4838Q@mail.gmail.com>
Subject: Re: SMP affinity and the blk-mq I/O submission path
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 24, 2016 at 3:32 PM, Hannes Reinecke <hare@suse.de> wrote:
> Hi Jens,
>
> I've taken a pick at your mpt3sas branch, trying to make the mpt3sas
> multiqueue aware. Sadly I've encountered some issues on the way, which
> make me think we _might_ run into a locking issue.
> Which also might be attributed to my imperfect knowledge of multiqueue
> submission and SMP affinity in general, hence my question:
>
> From my understanding blk-mq works due to the fact that I/O submission
> is local to the CPU, and hence we won't need (most) locks.
> However, looking at the code I find that indeed the software queues are
> CPU-local, but the hardware context is not.
> Plus I haven't really seen any provisions for ensure the hardware
> context (and hence the actual I/O submission) is running on any given CPU=
.
> So if I have a device with just one MSI-X vector (bloody mpt2sas
> firmware restriction) I would assign this vector to a specific CPU.
> But then I have the problem that I/O submission can in principle happen
> on _any_ CPU, whereas I/O completion will only happen on a specific CPU.
> Which consequently means that we might run into locking issue if the I/O
> submission happens on another CPU than the I/O completion.

The hardware queue lock needn't in I/O completion path.

> Is this intended?
> Plus, wouldn't we have a cacheline bouncing between those CPUs?
> Shouldn't rather run the I/O submission in the same CPU than the I/O
> completion?

The default mq flag includes QUEUE_FLAG_SAME_COMP, which should
make the completion handler run in same LLC domain with the submission
CPU, please see blk_mq_ipi_complete_request(). But the driver need to
define .complete callback of blk_mq_ops.

Thanks,
Ming

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Teamlead Storage & Networking
> hare@suse.de                                   +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
> HRB 21284 (AG N=C3=BCrnberg)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Ming Lei
