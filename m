Return-Path: <axboe@kernel.dk>
Subject: Re: drop abort sequence, kill BLK_EH_HANDLED v2
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180529135239.27005-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eaf15734-1d44-9adb-2de6-0a29bcef9da0@kernel.dk>
Date: Tue, 29 May 2018 09:12:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180529135239.27005-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/29/18 7:52 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes the BLK_EH_HANDLED return value, and instead places
> responsibility of timed out commands entirely on the drivers.  Except
> for some odd layering vilations in libiscsi this actually is
> surprisingly simple.   Some of the grunt work here is from Keith and
> Bart, just repackaged up

Survives my basic smoke testing, including timeout triggering with
null_blk and SCSI. I have applied this, it's much cleaner and simpler.
And we shrink the request a lot, which is great. Note I applied a
followup patch that kills two holes in struct request, and I fixed
a trailing whitespace in patch #3.

-- 
Jens Axboe
