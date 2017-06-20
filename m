Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497729594-4707-5-git-send-email-axboe@kernel.dk>
 <20170619062706.GC2311@infradead.org>
 <b04642e6-4ecc-f2e8-8184-6fff302d3d0b@kernel.dk>
 <8db675e7-b868-bae1-784a-33cba67d0874@kernel.dk>
 <20170619185805.GC32047@infradead.org>
 <5259a1ba-1c5f-2d89-3b47-3a81cd0a3e4e@kernel.dk>
 <0c3c6a33-77c5-337e-66e0-49fe22d3cc4e@kernel.dk>
 <3e6f7b97-8372-b268-f55a-cc88812c1a68@kernel.dk>
 <20170620085739.GB31386@infradead.org>
 <6f1be22c-b172-3645-f0ab-8124188756df@kernel.dk>
 <20170620124355.GA6199@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6793e5b9-b324-727a-6227-69b5fe233bc4@kernel.dk>
Date: Tue, 20 Jun 2017 06:45:45 -0600
MIME-Version: 1.0
In-Reply-To: <20170620124355.GA6199@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 06:43 AM, Christoph Hellwig wrote:
> On Tue, Jun 20, 2017 at 06:43:10AM -0600, Jens Axboe wrote:
>>> Question:  IFF we can get the per-file hints to propagate to the
>>> writeback code (which I think is pretty easy for ext4/xfs/bdev, not
>>> sure about btrfs) do we even need the per-inode ones at all?
>>
>> How is that possible, the file could be long gone by the time
>> the writeback kicks in?
> 
> each time a page/buffer is dirtied we can propagate the hint.

To the page? Where do you want to find room for that?


-- 
Jens Axboe
