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
 <0c3c6a33-77c5-337e-66e0-49fe22d3cc4e@kernel.dk>
 <3e6f7b97-8372-b268-f55a-cc88812c1a68@kernel.dk>
Message-ID: <28118638-9466-4816-2438-1ecf7ba4b756@kernel.dk>
Date: Mon, 19 Jun 2017 20:06:19 -0600
MIME-Version: 1.0
In-Reply-To: <3e6f7b97-8372-b268-f55a-cc88812c1a68@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 02:33 PM, Jens Axboe wrote:
> On 06/19/2017 01:10 PM, Jens Axboe wrote:
>> On 06/19/2017 01:00 PM, Jens Axboe wrote:
>>> On 06/19/2017 12:58 PM, Christoph Hellwig wrote:
>>>> On Mon, Jun 19, 2017 at 10:02:09AM -0600, Jens Axboe wrote:
>>>>> Actually, one good use case is O_DIRECT on a block device. Since I'm
>>>>> not a huge fan of having per-call hints that is only useful for a
>>>>> single case, how about we add the hints to the struct file as well?
>>>>> For buffered IO, just grab it from the inode. If we have a file
>>>>> available, then that overrides the per-inode setting.
>>>>
>>>> Even for buffered I/O per-fіle would seem more useful to be honest.
>>>> For the buffer_head based file systems this could even be done fairly
>>>> easily.
>>>
>>> If I add the per-file hint as well, then anywhere that has the file should
>>> just grab it from there. Unless not set, then grab from inode.
>>>
>>> That does raise an issue with the NONE hint being 0. We can tell right now
>>> if NONE was set, or nothing was set. This becomes a problem if we want the
>>> file hint to override the inode hint. Should probably just bump the values
>>> up by one, so that NONE is 1, SHORT is 2, etc.
>>
>> Actually, we don't have to, as long as the file inherits the inode mask.
>> Then we can just use the file hint if it differs from the inode hint.
> 
> That doesn't work, in case it's cleared, or for checking whether it has
> been set or not. Oh well, I added a NOT_SET variant for this. See below
> for an incremental that adds support for file write hints as well. Use
> the file write hint, if we have it, otherwise use the inode provided
> one.
> 
> Setting hints on a file propagates to the inode, only if the inode doesn't
> currently have a hint set.

I didn't like the special 0x7 for NOT_SET since it hard codes the fact
that we currently use 3 bits, and since we have to initialize the inode
flags to that weird value. Since I sent out a v8 already, I'll just
point at the current branch;

http://git.kernel.dk/cgit/linux-block/log/?h=write-stream

The main change is using 0 as the NOT_SET value, and shifting everything
up by one. I think this is better, since we can also use that value to
clear hints down to the inode. Additionally, if we add more hints in
the future, it's much saner to retain '0' as the NOT_SET value, rather
than having a strange magic value for it.

Let me know what you think. As far as I'm concerned, the core API should
be ready now. For the NVMe bits, I'm fine with removing the stream
allocation.

-- 
Jens Axboe
