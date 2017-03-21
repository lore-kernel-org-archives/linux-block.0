Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/4] blk-mq: improve blk_mq_try_issue_directly
Date: Tue, 21 Mar 2017 01:35:09 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA0F96ED@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <20170320203930.12533-1-hch@lst.de>
 <20170320203930.12533-4-hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 03/20/2017 04:39 PM, Christoph Hellwig wrote:=0A=
> Rename blk_mq_try_issue_directly to __blk_mq_try_issue_directly and add a=
=0A=
> new wrapper that takes care of RCU / SRCU locking to avoid having=0A=
> boileplate code in the caller which would get duplicated with new callers=
.=0A=
=0A=
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=0A=
