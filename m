Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57227 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934307AbdDFMV6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Apr 2017 08:21:58 -0400
Subject: Re: [RFC PATCH] loop: set queue logical block size
To: Ming Lei <minlei@redhat.com>, Omar Sandoval <osandov@osandov.com>
References: <07d6b9266284b98aa3a4706062bd135275220d38.1491466688.git.osandov@fb.com>
 <20170406084313.GA4197@ming.t460p> <20170406120309.GA32165@ming.t460p>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57e45bce-8409-b48e-c9ab-90f82a26d9a6@suse.de>
Date: Thu, 6 Apr 2017 14:21:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170406120309.GA32165@ming.t460p>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/06/2017 02:03 PM, Ming Lei wrote:
> On Thu, Apr 06, 2017 at 04:43:18PM +0800, Ming Lei wrote:
>> On Thu, Apr 06, 2017 at 01:19:45AM -0700, Omar Sandoval wrote:
>>> From: Omar Sandoval <osandov@fb.com>
>>>
>>> The request queue created when we create a loop device has the default
>>> logical block size of 512. When we associate the device with an fd, we
>>> set the block size on the block_device but don't update the logical
>>> block size of the request_queue. This makes it impossibe to use direct
>>> I/O with a backing file on a device with a block size >512, as the
>>> following check in __loop_update_dio() fails:
>>>
>>> 	sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev);
>>> 	if (queue_logical_block_size(lo->lo_queue) >= sb_bsize &&
>>> 	    ...
>>>
>>> Fix it by updating the logical block size when we set the fd.
>>>
>>> Signed-off-by: Omar Sandoval <osandov@fb.com>
>>> ---
>>>  drivers/block/loop.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>>> index cc981f34e017..1bb22903ad1a 100644
>>> --- a/drivers/block/loop.c
>>> +++ b/drivers/block/loop.c
>>> @@ -941,6 +941,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>>>  	/* let user-space know about the new size */
>>>  	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
>>>  
>>> +	blk_queue_logical_block_size(lo->lo_queue, lo_blocksize);
>>>  	set_blocksize(bdev, lo_blocksize);
>>>  
>>>  	lo->lo_state = Lo_bound;
>>
>> Looks fine!
>>
>> Reviewed-by: Ming Lei <minlei@redhat.com>
> 
> Turns out I am wrong, and we can't change logical block size in this way
> because we need to support 512 byte sector filesystem image on backing
> device with bigger sector size.
> 
> And we don't support dio in this situation yet, but Hannes Reinecke's
> patch might help this case. So I have to recall the reviewed-by.
> 
Yes, please!

I've been waiting for it far too long.
Should I repost them?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
