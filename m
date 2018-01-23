Return-Path: <ming.lei@redhat.com>
Date: Tue, 23 Jan 2018 22:16:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
	Laurence Oberman <loberman@redhat.com>,
	Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH V2] blk-mq: introduce BLK_STS_DEV_RESOURCE
Message-ID: <20180123141626.GB9792@ming.t460p>
References: <20180123105611.7389-1-ming.lei@redhat.com>
 <yq1zi54hfcu.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1zi54hfcu.fsf@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 23, 2018 at 08:30:41AM -0500, Martin K. Petersen wrote:
> 
> Ming,
> 
> > + * Block layer and block driver specific status, which is ususally returnd
>                                                                       ^^^^^^^
> > + * from driver to block layer in IO path.
> 
> Given that the comment blurb is long and the flag not defined until
> later, it is not entirely obvious that you are documenting
> BLK_STS_DEV_RESOURCE. So please make that clear at the beginning of the
> comment.
> 
> > + * If driver isn't sure if the queue can be run again for dealing with the
> > + * current request after this kind of resource is available, please return
> > + * BLK_STS_SOURCE, for example, when memory allocation, DMA Mapping or other
>       ^^^^^^^^^^^^^^

This one is correct, just try to describe their difference.


-- 
Ming
