Return-Path: <gerlitz.or@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180205220316.30236-2-sagi@grimberg.me>
References: <20180205220316.30236-1-sagi@grimberg.me> <20180205220316.30236-2-sagi@grimberg.me>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Tue, 6 Feb 2018 09:43:43 +0200
Message-ID: <CAJ3xEMhcQLL+QiqtLNtPrRcZEGSspipAoX5C_ERVwv1p=vAMHw@mail.gmail.com>
Subject: Re: [PATCH rfc 1/5] irq-am: Introduce library implementing generic
 adaptive moderation
To: Sagi Grimberg <sagi@grimberg.me>, Tal Gilboa <talgi@mellanox.com>
Cc: linux-block@vger.kernel.org,
	RDMA mailing list <linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Idan Burstein <idanb@mellanox.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 6, 2018 at 12:03 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
> irq-am library helps I/O devices implement interrupt moderation in
> an adaptive fashion, based on online stats.
>
> The consumer can initialize an irq-am context with a callback that
> performs the device specific moderation programming and also the number
> of am (adaptive moderation) levels which are also, abstracted and allows
> for device specific tuning.
>
> The irq-am code will sample once every nr_events and will check for significant
> change in workload characteristics (completions per second, events per second)
> and if it detects one, will perform an am level update(called a step).
>
> The irq-am code  assumes that the am levels are sorted in an increasing order when
> the lowest level corresponds to the optimum latency tuning (short time and low
> completion-count) and gradually increasing towards the throughput optimum tuning
> (longer time and higher completion-count). So there is a trend and tuning direction
> tracked by the moderator. When the moderator collects sufficient statistics (also
> controlled by the consumer defining nr_events), it compares the current stats with the
> previous stats and if a significant changed was observed in the load, the moderator
> attempts to increment/decrement its current level (step) and schedules a program
> dispatch work.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  include/linux/irq-am.h | 116 +++++++++++++++++++++++++++++++

Talking to Tal, it seems that this is what landed in upstream as
include/linux/net_dim.h
and can have few adjustments for you, I suggest you take a look
