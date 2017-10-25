Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Invalidate cache on discard v2
To: Omar Sandoval <osandov@osandov.com>,
 Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, hch@lst.de,
 Nishita Borkar <nishita.borkar@oracle.com>, linux-block@vger.kernel.org
References: <1490210965-28861-1-git-send-email-dmonakhov@openvz.org>
 <20171024213353.GA13084@vader.DHCP.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d0465b48-61be-ecbf-a979-2fc61e7cbb61@kernel.dk>
Date: Tue, 24 Oct 2017 18:46:09 -0600
MIME-Version: 1.0
In-Reply-To: <20171024213353.GA13084@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/24/2017 03:33 PM, Omar Sandoval wrote:
> On Wed, Mar 22, 2017 at 11:29:25PM +0400, Dmitry Monakhov wrote:
>> It is reasonable drop page cache on discard, otherwise that pages may
>> be written by writeback second later, so thin provision devices will
>> not be happy. This seems to be a  security leak in case of secure discard case.
>>
>> Also add check for queue_discard flag on early stage.
>>
>> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> ---
>>  block/ioctl.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index 7b88820..336610d 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -202,10 +202,16 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
>>  {
>>  	uint64_t range[2];
>>  	uint64_t start, len;
>> +	struct request_queue *q = bdev_get_queue(bdev);
>> +	struct address_space *mapping = bdev->bd_inode->i_mapping;
>> +
>>  
>>  	if (!(mode & FMODE_WRITE))
>>  		return -EBADF;
>>  
>> +	if (!blk_queue_discard(q))
>> +		return -EOPNOTSUPP;
>> +
>>  	if (copy_from_user(range, (void __user *)arg, sizeof(range)))
>>  		return -EFAULT;
>>  
>> @@ -216,12 +222,12 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
>>  		return -EINVAL;
>>  	if (len & 511)
>>  		return -EINVAL;
>> -	start >>= 9;
>> -	len >>= 9;
>>  
>> -	if (start + len > (i_size_read(bdev->bd_inode) >> 9))
>> +	if (start + len > i_size_read(bdev->bd_inode))
>>  		return -EINVAL;
>> -	return blkdev_issue_discard(bdev, start, len, GFP_KERNEL, flags);
>> +	truncate_inode_pages_range(mapping, start, start + len);
>> +	return blkdev_issue_discard(bdev, start >> 9, len >> 9,
>> +				    GFP_KERNEL, flags);
>>  }
>>  
>>  static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
>> -- 
>> 2.9.3
>>
> 
> Hey, Jens, Dmitry didn't send this patch to linux-block so looks like
> you missed it. Christoph reviewed it and Nishita sent up a blktest for
> it so we should probably pull it in.

Definitely missed it, block patches should be cc'ed linux-block always
or I will never see them. Especially if I'm not cc'ed either.

I've applied it for 4.15.

-- 
Jens Axboe
