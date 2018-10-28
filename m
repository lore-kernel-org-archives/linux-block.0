Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/28] bsg: pass in desired timeout handler
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
 Benjamin Block <bblock@linux.vnet.ibm.com>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-12-axboe@kernel.dk>
 <20181028155305.GA1559@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e80c6442-0770-9897-bedb-03dd5304911f@kernel.dk>
Date: Sun, 28 Oct 2018 17:05:31 -0600
MIME-Version: 1.0
In-Reply-To: <20181028155305.GA1559@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/28/18 9:53 AM, Christoph Hellwig wrote:
> On Thu, Oct 25, 2018 at 03:10:22PM -0600, Jens Axboe wrote:
>> This will ease in the conversion to blk-mq, where we can't set
>> a timeout handler after queue init.
> 
> On thing I hoped to archive with the last round of bsg cleanups is
> to isolate the users of bsg from even knowing there is a struct
> request underneath.  Based on that it would be nice to pass
> the struct bsg_job to the actual timeout handlers instead of
> struct request.

Makes sense, I can make that change.

-- 
Jens Axboe
