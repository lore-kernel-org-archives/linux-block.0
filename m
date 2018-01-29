Return-Path: <axboe@kernel.dk>
Subject: Re: [LSF/MM TOPIC] Two blk-mq related topics
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Ming Lei <ming.lei@redhat.com>, lsf-pc@lists.linux-foundation.org,
 Linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20180129154455.GB17176@ming.t460p>
 <1517259390.3969.41.camel@HansenPartnership.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fc833da8-f9de-d577-e1d3-c46d8c061d35@kernel.dk>
Date: Mon, 29 Jan 2018 14:00:11 -0700
MIME-Version: 1.0
In-Reply-To: <1517259390.3969.41.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/29/18 1:56 PM, James Bottomley wrote:
> On Mon, 2018-01-29 at 23:46 +0800, Ming Lei wrote:
> [...]
>> 2. When to enable SCSI_MQ at default again?
> 
> I'm not sure there's much to discuss ... I think the basic answer is as
> soon as Christoph wants to try it again.

FWIW, internally I've been running various IO intensive workloads on
what is essentially 4.12 upstream with scsi-mq the default (with
mq-deadline as the scheduler) and comparing IO workloads with a
previous 4.6 kernel (without scsi-mq), and things are looking
great.

We're never going to iron out the last kinks with it being off
by default, I think we should attempt to flip the switch again
for 4.16.

-- 
Jens Axboe
