Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 4/5] scsi: Add scsi_restart_hctx()
Date: Tue, 4 Apr 2017 15:56:34 +0000
Message-ID: <BY1PR0401MB15322BB999F894A46F40AE5E810B0@BY1PR0401MB1532.namprd04.prod.outlook.com>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com>
 <20170403232228.11208-5-bart.vanassche@sandisk.com>
 <20170404064252.GD9168@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 04/03/2017 11:42 PM, Christoph Hellwig wrote:=0A=
>> +static void scsi_restart_hctx(struct request_queue *q,=0A=
>> +			      struct blk_mq_hw_ctx *hctx)=0A=
>> +{=0A=
>> +	struct blk_mq_tags *tags =3D hctx->tags;=0A=
>> +	struct blk_mq_tag_set *set =3D q->tag_set;=0A=
>> +	int i;=0A=
>> +=0A=
>> +	rcu_read_lock();=0A=
>> +	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list)=0A=
>> +		queue_for_each_hw_ctx(q, hctx, i)=0A=
>> +			if (hctx->tags =3D=3D tags)=0A=
>> +				blk_mq_sched_restart_hctx(hctx);=0A=
>> +	rcu_read_unlock();=0A=
>> +}=0A=
> =0A=
> This looks like generic block layer code, why is it in SCSI?=0A=
=0A=
Hello Christoph,=0A=
=0A=
That's an excellent question. I assume that you are fine with moving=0A=
this code to the block layer?=0A=
=0A=
Bart.=0A=
=0A=
