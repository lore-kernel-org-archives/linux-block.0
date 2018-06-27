Return-Path: <prvs=70988ebf6=bart.vanassche@wdc.com>
Subject: Re: [blk-mq Bug] race on removing hctx->dispatch_wait from wait queue
To: Ming Lei <ming.lei@redhat.com>
Cc: "hch@lst.de" <hch@lst.de>, "drjones@redhat.com" <drjones@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "osandov@fb.com" <osandov@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <20180624101605.GA32610@ming.t460p>
 <da4a45a9d7764ffee5eea2c6c355dc4b7c23265a.camel@wdc.com>
 <20180625072433.GA23016@ming.t460p>
 <83853e8f-169e-8c0e-a8f5-d830c20158b8@wdc.com>
 <20180627004858.GA9970@ming.t460p>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <9285867f-1534-ddbe-0f9f-62dff527de4b@wdc.com>
Date: Wed, 27 Jun 2018 13:00:08 -0700
MIME-Version: 1.0
In-Reply-To: <20180627004858.GA9970@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/26/18 17:49, Ming Lei wrote:
> Only the waitqueue's lock is held for blk_mq_dispatch_wake(), but this
> hctx->dispatch_wait can be added to another waitqueue, so it isn't
> enough to just hold waitqueue's lock.

Hello Ming,

That makes sense to me. I will post an update that addresses this issue.

Bart.
