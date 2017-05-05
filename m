Return-Path: <hch@lst.de>
Date: Fri, 5 May 2017 10:57:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	target-devel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
	dm-devel@redhat.com
Subject: Re: remove REQ_OP_WRITE_SAME
Message-ID: <20170505085713.GA5008@lst.de>
References: <20170412084809.8245-1-hch@lst.de> <yq1mvbjwwvl.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1mvbjwwvl.fsf@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 13, 2017 at 10:23:10PM -0400, Martin K. Petersen wrote:
> The other thing that keeps me a bit on the fence is that a bunch of the
> plumbing to handle a bio with a payload different from bi_size is needed
> for the copy offload token. I'm hoping to have those patches ready for
> 4.13. Right now there are a bunch of places where handling of
> REQ_OP_COPY_IN and REQ_OP_COPY_OUT share conditionals with WRITE SAME.

Any chance to get a sneak preview of that work?
