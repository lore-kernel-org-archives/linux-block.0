Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Fri, 1 Sep 2017 11:51:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH 3/9] blk-mq: rename blk_mq_freeze_queue as
 blk_freeze_queue
Message-ID: <20170901035121.GF16525@ming.t460p>
References: <20170831172728.15817-1-ming.lei@redhat.com>
 <20170831172728.15817-4-ming.lei@redhat.com>
 <1504218948.31872.67.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504218948.31872.67.camel@wdc.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 31, 2017 at 10:35:50PM +0000, Bart Van Assche wrote:
> On Fri, 2017-09-01 at 01:27 +0800, Ming Lei wrote:
> > This APIs will be used by legacy path too.
> 
> Hello Ming,
> 
> Had you already considered to combine patches 2/9 and 3/9 into a single patch?

Either way is fine for me, and splitting them makes it easier to review.

-- 
Ming
