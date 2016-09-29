Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH v2 3/3] block: implement (some of) fallocate for block
 devices
To: "Darrick J. Wong" <darrick.wong@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <147510957066.8940.13803086684642725401.stgit@birch.djwong.org>
 <147510959149.8940.2897845352082568677.stgit@birch.djwong.org>
 <20160929021900.GA4901@birch.djwong.org>
CC: "hch@infradead.org" <hch@infradead.org>, "tytso@mit.edu" <tytso@mit.edu>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"snitzer@redhat.com" <snitzer@redhat.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "bfoster@redhat.com" <bfoster@redhat.com>,
	"xfs@oss.sgi.com" <xfs@oss.sgi.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <423d057c-d2cc-9039-d8ee-c6526be3ae46@sandisk.com>
Date: Thu, 29 Sep 2016 13:08:57 -0700
MIME-Version: 1.0
In-Reply-To: <20160929021900.GA4901@birch.djwong.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 09/28/2016 07:19 PM, Darrick J. Wong wrote:
> After much discussion, it seems that the fallocate feature flag
> FALLOC_FL_ZERO_RANGE maps nicely to SCSI WRITE SAME; and the feature
> FALLOC_FL_PUNCH_HOLE maps nicely to the devices that have been
> whitelisted for zeroing SCSI UNMAP.  Punch still requires that
> FALLOC_FL_KEEP_SIZE is set.  A length that goes past the end of the
> device will be clamped to the device size if KEEP_SIZE is set; or will
> return -EINVAL if not.  Both start and length must be aligned to the
> device's logical block size.
>
> Since the semantics of fallocate are fairly well established already,
> wire up the two pieces.  The other fallocate variants (collapse range,
> insert range, and allocate blocks) are not supported.

For the FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | 
FALLOC_FL_NO_HIDE_STALE case, it's probably safer not to try to send a 
discard to block devices that do not support discard in order not to hit 
block driver bugs. But that's something we can still discuss later. Hence:

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
