Return-Path: <ming.lei@redhat.com>
Date: Mon, 25 Sep 2017 10:38:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v3 1/6] md: Make md resync and reshape threads freezable
Message-ID: <20170925023804.GD6434@ming.t460p>
References: <20170922221405.22091-1-bart.vanassche@wdc.com>
 <20170922221405.22091-2-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170922221405.22091-2-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 22, 2017 at 03:14:00PM -0700, Bart Van Assche wrote:
> Some people use the md driver on laptops and use the suspend and
> resume functionality. Since it is essential that submitting of
> new I/O requests stops before device quiescing starts, make the
> md resync and reshape threads freezable.
> 

Why is this patch part of this patchset? I don't think
MD is special enough wrt. the SCSI quiesce issue.


-- 
Ming
