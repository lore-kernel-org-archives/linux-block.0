Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <x49d1op982x.fsf@segfault.boston.devel.redhat.com>
References: <1463074986-3070-1-git-send-email-jonathan.derrick@intel.com>
	<1463074986-3070-2-git-send-email-jonathan.derrick@intel.com>
	<CAA9_cmeaa6qGKeDfRXWm-BkNtw0hJrbc9kqsLfOEJ2ZE-Mubgw@mail.gmail.com>
	<x49d1op982x.fsf@segfault.boston.devel.redhat.com>
Date: Fri, 13 May 2016 10:53:37 -0700
Message-ID: <CAPcyv4j-ioz0FensEkBWR1QyYwSe2rjJ9N+gY+qV7+Y8KzM+Dg@mail.gmail.com>
Subject: Re: [RFC 1/2] block: allow other bd i_node flags when DAX is disabled
From: Dan Williams <dan.j.williams@intel.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Stephen Bates <stephen.bates@microsemi.com>,
	Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, May 13, 2016 at 10:33 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
>
>> On Thu, May 12, 2016 at 10:43 AM, Jon Derrick
>> <jonathan.derrick@intel.com> wrote:
>>> When DAX is not compiled into the kernel or the device does not support
>>> direct-access, the block device file's inode flags are fully cleared.
>>> This patch changes it to only clear the S_DAX flag when DAX is disabled.
>>>
>>> This reverts to i_flags behavior prior to
>>> bbab37ddc20bae4709bca8745c128c4f46fe63c5
>>>
>>> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
>>> ---
>>>  fs/block_dev.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>>> index 20a2c02..d4fa725 100644
>>> --- a/fs/block_dev.c
>>> +++ b/fs/block_dev.c
>>> @@ -1208,7 +1208,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>>>                 if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops->direct_access)
>>>                         bdev->bd_inode->i_flags = S_DAX;
>>>                 else
>>> -                       bdev->bd_inode->i_flags = 0;
>>> +                       bdev->bd_inode->i_flags &= ~S_DAX;
>>
>> Setting S_DAX is atomic, but the above change makes it a non-atomic
>> read-modify-write.  Do we need exclusion / locking in this path?
>
> First, I don't see how you'd ever get a read-modify-write here, as S_DAX
> surely won't ever be set if direct_access isn't supported.  Second,
> there is existing code that already does this very thing.  See further
> down in __blkdev_get:
>
>                         if (!ret) {
>                                 bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
>                                 if (!blkdev_dax_capable(bdev))
>                                         bdev->bd_inode->i_flags &= ~S_DAX;
>                         }
>
> What relies on S_DAX being set or cleared atomically?

So, when I wrote the above "&= ~S_DAX" I was worried about the
non-atomic update with respect to the BLKDAXSET ioctl, but we killed
BLKDAXSET so the worry went away.  Now an inode flag setting ioctl is
back for the S_HIPRI case.  Can that collide with these other flag
touches?
