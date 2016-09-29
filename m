Return-Path: <hare@suse.de>
Subject: Re: [PATCH 2/3] block: require write_same and discard requests align
 to logical block size
To: "Darrick J. Wong" <darrick.wong@oracle.com>, axboe@kernel.dk,
 akpm@linux-foundation.org
References: <147510957066.8940.13803086684642725401.stgit@birch.djwong.org>
 <147510958448.8940.14280630935441533825.stgit@birch.djwong.org>
Cc: linux-block@vger.kernel.org, tytso@mit.edu, martin.petersen@oracle.com,
 snitzer@redhat.com, linux-api@vger.kernel.org, bfoster@redhat.com,
 xfs@oss.sgi.com, hch@infradead.org, dm-devel@redhat.com,
 linux-fsdevel@vger.kernel.org, bart.vanassche@sandisk.com,
 Christoph Hellwig <hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <01403e58-6638-7c60-c195-5ab413f4ceb4@suse.de>
Date: Thu, 29 Sep 2016 07:56:31 +0200
MIME-Version: 1.0
In-Reply-To: <147510958448.8940.14280630935441533825.stgit@birch.djwong.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/29/2016 02:39 AM, Darrick J. Wong wrote:
> Make sure that the offset and length arguments that we're using to
> construct WRITE SAME and DISCARD requests are actually aligned to the
> logical block size.  Failure to do this causes other errors in other
> parts of the block layer or the SCSI layer because disks don't support
> partial logical block writes.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  block/blk-lib.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
