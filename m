Return-Path: <hch@lst.de>
Date: Wed, 10 May 2017 09:56:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, hch@lst.de,
	sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [linux-next][bock] [bisected c20cfc27a] WARNING: CPU: 22 PID:
	0 at block/blk-core.c:2655 .blk_update_request+0x4f8/0x500
Message-ID: <20170510075642.GA10943@lst.de>
References: <1493965539.7355.44.camel@abdul.in.ibm.com> <15a0a50a-d57d-736b-634c-4d0131ec5af3@kernel.dk> <1494227599.2983.2.camel@abdul.in.ibm.com> <f1a1ced1-6f3c-8fec-2e2d-4db4c09e31fc@kernel.dk> <1494343101.11532.4.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494343101.11532.4.camel@abdul.in.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 09, 2017 at 08:48:21PM +0530, Abdul Haleem wrote:
> A bisection for the above suspects resulted a bad commit;
> 
> c20cfc27a47307e811346f85959cf3cc07ae42f9 is the first bad commit
> commit c20cfc27a47307e811346f85959cf3cc07ae42f9
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Apr 5 19:21:07 2017 +0200
> 
>     block: stop using blkdev_issue_write_same for zeroing

And this effectively switches us to use the write_zeroes for SCSI.



>     
>     We'll always use the WRITE ZEROES code for zeroing now.
>     
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>     Reviewed-by: Hannes Reinecke <hare@suse.com>
>     Signed-off-by: Jens Axboe <axboe@fb.com>
> 
> 
> @Christoph FYI, the machine configured with 64K page size
> > 
> > WARNING: CPU: 12 PID: 0 at block/blk-core.c:2651 .blk_update_request+0x4cc/0x4e0

Can you decode which warning this is?  Is it:

	WARN_ON_ONCE(req->rq_flags & RQF_SPECIAL_PAYLOAD);

?  In which case your setup did a partial completion of a WRITE SAME
command, which is perfectly legal according to SCSI, but a bit unusual.
