Subject: Re: split scsi passthrough fields out of struct request
To: Christoph Hellwig <hch@lst.de>
References: <1485185361-29786-1-git-send-email-hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <ab371cbe-9abc-877e-b529-a7a3c39ff229@fb.com>
Date: Mon, 23 Jan 2017 08:39:44 -0700
MIME-Version: 1.0
In-Reply-To: <1485185361-29786-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/23/2017 08:29 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series splits the support for SCSI passthrough commands from the
> main struct request used all over the block layer into a separate
> scsi_request structure that drivers that want to support SCSI passthough
> need to embedded as the first thing into their request-private data,
> similar to how we handle NVMe passthrough commands.
> 
> To support this I've added support for that the private data after
> request structure to the legacy request path instead, so that it can
> be treated the same way as the blk-mq path.  Compare to the current
> scsi_cmnd allocator that actually is a major simplification.
> 
> Compared to the previous RFC version the major change is that dm-mpath
> works with this version.  To make it work I've switched the legacy
> request dm-rq to use the same clone and map method as the blk-mq version.

I'd like to get this in sooner rather than later, so I'll spend some
time reviewing and testing it start this week. I'm assuming you are
targeting 4.11 with this change, right?

-- 
Jens Axboe
