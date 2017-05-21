Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Sun, 21 May 2017 08:42:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 08/18] block: Make scsi_req_init() calls implicit
Message-ID: <20170521064235.GA12755@lst.de>
References: <20170519183016.12646-1-bart.vanassche@sandisk.com> <20170519183016.12646-9-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170519183016.12646-9-bart.vanassche@sandisk.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, May 19, 2017 at 11:30:06AM -0700, Bart Van Assche wrote:
> Instead of explicitly calling scsi_req_init(), let
> blk_get_request() call that function from inside blk_rq_init().
> Add an .initialize_rq_fn() callback function to the block drivers
> that need it.

Thanks Bart,

this looks like a very nice cleanup.

> Merge the IDE .init_rq_fn() function into
> .initialize_rq_fn() because it is too small to keep it as a
> separate function.

Although we can't do this IFF we don't call .initialize_rq_fn from
the fast path (which I think we should).
