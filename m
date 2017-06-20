Return-Path: <rgoldwyn@suse.de>
Subject: Re: [PATCH 0/10 v13] merge request: No wait AIO
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, jack@suse.cz, akpm@linux-foundation.org,
 linux-block@vger.kernel.org
References: <20170619163348.15542-1-rgoldwyn@suse.de>
 <a3c9ac14-d04d-2dc5-c656-879c6262aa96@kernel.dk>
 <20170619233439.GL10672@ZenIV.linux.org.uk>
 <1de9d545-8811-4dfa-22db-f5172f122a95@kernel.dk>
 <20170620002428.GM10672@ZenIV.linux.org.uk> <20170620072010.GA8245@lst.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <1c21d544-b5b4-fd81-b2cf-202eab7848c9@suse.de>
Date: Tue, 20 Jun 2017 06:53:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170620072010.GA8245@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 06/20/2017 02:20 AM, Christoph Hellwig wrote:
> On Tue, Jun 20, 2017 at 01:24:28AM +0100, Al Viro wrote:
>> On Mon, Jun 19, 2017 at 05:36:05PM -0600, Jens Axboe wrote:
>>> On 06/19/2017 05:34 PM, Al Viro wrote:
>>>> On Mon, Jun 19, 2017 at 05:15:16PM -0600, Jens Axboe wrote:
>>>>> On 06/19/2017 10:33 AM, Goldwyn Rodrigues wrote:
>>>>>> Jens,
>>>>>>
>>>>>> As Christoph suggested, I am sending the patches against the block
>>>>>> tree for merge since the block layer changes had the most conflicts.
>>>>>> My tree is at https://github.com/goldwynr/linux/tree/nowait-block
>>>>>
>>>>> I can merge it for 4.13, but I need Al to be happy with it first.
>>>>
>>>> FWIW, it's really a matter of who gets more conflicts - I'm OK with the
>>>> general shape of that code and it could go through either tree (or both,
>>>> for that matter, if an immutable branch is promised).
>>>
>>> I'm still hopeful that the write hint patchset will make it as well,
>>> which will definitely conflict with this. So if you don't mind, I'd
>>> like to queue it through the block tree. The block for-4.x/ branches
>>> are not rebased.
>>
>> Fine by me; the only problem I see there at the moment is with ext4 and
>> xfs ->read_iter() not buggering off on nowait (xfs one has
>>         xfs_ilock(ip, XFS_IOLOCK_SHARED);
>> done before it gets to generic_file_read_iter()).
> 
> Something like the patch below should take care of the XFS, free feel
> to fold.
> 

I had missed on the dax support completely so I added a chunk for
xfs_file_dax_write() as well (and also ext4). Patches coming shortly,
after their usual round of testing. They are pushed onto
https://github.com/goldwynr/linux/tree/nowait-block

> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index e159eb381d9f..c74847f71b3d 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -216,7 +216,11 @@ xfs_file_dio_aio_read(
>  
>  	file_accessed(iocb->ki_filp);
>  
> -	xfs_ilock(ip, XFS_IOLOCK_SHARED);
> +	if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED)) {
> +		if (iocb->ki_flags & IOCB_NOWAIT)
> +			return -EAGAIN;
> +		xfs_ilock(ip, XFS_IOLOCK_SHARED);
> +	}
>  	ret = iomap_dio_rw(iocb, to, &xfs_iomap_ops, NULL);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
> @@ -237,7 +241,11 @@ xfs_file_dax_read(
>  	if (!count)
>  		return 0; /* skip atime */
>  
> -	xfs_ilock(ip, XFS_IOLOCK_SHARED);
> +	if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED)) {
> +		if (iocb->ki_flags & IOCB_NOWAIT)
> +			return -EAGAIN;
> +		xfs_ilock(ip, XFS_IOLOCK_SHARED);
> +	}
>  	ret = dax_iomap_rw(iocb, to, &xfs_iomap_ops);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
> 

-- 
Goldwyn
