Return-Path: <jthumshirn@suse.de>
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,  Ming Lei <ming.lei@redhat.com>,  lsf-pc@lists.linux-foundation.org,  Linux-scsi@vger.kernel.org,  linux-block@vger.kernel.org,  linux-nvme@lists.infradead.org, Mel Gorman <mgorman@suse.com>
Subject: Re: [LSF/MM TOPIC] Two blk-mq related topics
References: <20180129154455.GB17176@ming.t460p>
	<1517259390.3969.41.camel@HansenPartnership.com>
	<fc833da8-f9de-d577-e1d3-c46d8c061d35@kernel.dk>
Date: Tue, 30 Jan 2018 11:08:28 +0100
In-Reply-To: <fc833da8-f9de-d577-e1d3-c46d8c061d35@kernel.dk> (Jens Axboe's
	message of "Mon, 29 Jan 2018 14:00:11 -0700")
Message-ID: <mqdzi4vlkv7.fsf@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

[+Cc Mel]
Jens Axboe <axboe@kernel.dk> writes:
> On 1/29/18 1:56 PM, James Bottomley wrote:
>> On Mon, 2018-01-29 at 23:46 +0800, Ming Lei wrote:
>> [...]
>>> 2. When to enable SCSI_MQ at default again?
>>=20
>> I'm not sure there's much to discuss ... I think the basic answer is as
>> soon as Christoph wants to try it again.
>
> FWIW, internally I've been running various IO intensive workloads on
> what is essentially 4.12 upstream with scsi-mq the default (with
> mq-deadline as the scheduler) and comparing IO workloads with a
> previous 4.6 kernel (without scsi-mq), and things are looking
> great.
>
> We're never going to iron out the last kinks with it being off
> by default, I think we should attempt to flip the switch again
> for 4.16.

The 4.12 sounds interesting. I remember Mel ran some test with 4.12 as
we where considering to flip the config option for SLES and it showed
several road blocks.

I'm not sure whether he re-evaluated 4.13/4.14 on his grid though.

But I'm definitively interested in this discussion and can even possibly
share some benchmark results we did in our FC Lab.

Byte,
        Johannes
--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
