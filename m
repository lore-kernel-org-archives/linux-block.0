Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-5-git-send-email-axboe@kernel.dk>
 <20170619062706.GC2311@infradead.org>
 <b04642e6-4ecc-f2e8-8184-6fff302d3d0b@kernel.dk>
 <8db675e7-b868-bae1-784a-33cba67d0874@kernel.dk>
 <20170619185805.GC32047@infradead.org>
 <5259a1ba-1c5f-2d89-3b47-3a81cd0a3e4e@kernel.dk>
Message-ID: <0c3c6a33-77c5-337e-66e0-49fe22d3cc4e@kernel.dk>
Date: Mon, 19 Jun 2017 13:10:24 -0600
MIME-Version: 1.0
In-Reply-To: <5259a1ba-1c5f-2d89-3b47-3a81cd0a3e4e@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 01:00 PM, Jens Axboe wrote:
> On 06/19/2017 12:58 PM, Christoph Hellwig wrote:
>> On Mon, Jun 19, 2017 at 10:02:09AM -0600, Jens Axboe wrote:
>>> Actually, one good use case is O_DIRECT on a block device. Since I'm
>>> not a huge fan of having per-call hints that is only useful for a
>>> single case, how about we add the hints to the struct file as well?
>>> For buffered IO, just grab it from the inode. If we have a file
>>> available, then that overrides the per-inode setting.
>>
>> Even for buffered I/O per-fіle would seem more useful to be honest.
>> For the buffer_head based file systems this could even be done fairly
>> easily.
> 
> If I add the per-file hint as well, then anywhere that has the file should
> just grab it from there. Unless not set, then grab from inode.
> 
> That does raise an issue with the NONE hint being 0. We can tell right now
> if NONE was set, or nothing was set. This becomes a problem if we want the
> file hint to override the inode hint. Should probably just bump the values
> up by one, so that NONE is 1, SHORT is 2, etc.

Actually, we don't have to, as long as the file inherits the inode mask.
Then we can just use the file hint if it differs from the inode hint.

-- 
Jens Axboe
