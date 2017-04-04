Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 2/5] blk-mq: Make it safe to use RCU to iterate over
 blk_mq_tag_set.tag_list
Date: Tue, 4 Apr 2017 15:55:44 +0000
Message-ID: <BY1PR0401MB1532593CCC571410AD79918B810B0@BY1PR0401MB1532.namprd04.prod.outlook.com>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com>
 <20170403232228.11208-3-bart.vanassche@sandisk.com>
 <20170404064038.GB9168@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 04/03/2017 11:40 PM, Christoph Hellwig wrote:=0A=
> On Mon, Apr 03, 2017 at 04:22:25PM -0700, Bart Van Assche wrote:=0A=
>> A later patch in this series will namely use RCU to iterate over=0A=
>> this list.=0A=
> =0A=
> It also adds a couple lockdep_assert_held calls, which might be worth=0A=
> mentioning.=0A=
> =0A=
> Otherwise looks good:=0A=
> =0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
=0A=
Thanks for the review. I will update the patch description.=0A=
=0A=
Bart.=0A=
=0A=
