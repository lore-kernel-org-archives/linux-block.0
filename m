Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 16/25] fuse: Convert to separately allocated bdi
To: Jan Kara <jack@suse.cz>
References: <20170412102449.16901-1-jack@suse.cz>
 <20170412102449.16901-17-jack@suse.cz>
 <20170515203400.GA8068@hercules.tuxera.com>
 <20170516104831.GA26782@quack2.suse.cz>
 <20170516183733.GA35685@dhcp-216.srv.tuxera.com>
 <F89ADFF3-C4A4-4BBE-9052-98B1DB72C2C3@kernel.dk>
 <20170517074657.GA22737@quack2.suse.cz>
Cc: Rakesh Pandit <rakesh@tuxera.com>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <acb39b25-ef1e-785a-c5d1-4c38301734c9@kernel.dk>
Date: Wed, 17 May 2017 08:15:17 -0600
MIME-Version: 1.0
In-Reply-To: <20170517074657.GA22737@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/17/2017 01:46 AM, Jan Kara wrote:
> On Tue 16-05-17 17:24:21, Jens Axboe wrote:
>> On May 16, 2017, at 12:37 PM, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>>
>>>> On Tue, May 16, 2017 at 12:48:31PM +0200, Jan Kara wrote:
>>>>> On Mon 15-05-17 23:34:00, Rakesh Pandit wrote:
>>>>> Hi Jan, Miklos,
>>>>>
>>>>>> On Wed, Apr 12, 2017 at 12:24:40PM +0200, Jan Kara wrote:
>>>>>> Allocate struct backing_dev_info separately instead of embedding it
>>>>>> inside the superblock. This unifies handling of bdi among users.
>>>>>>
>>> ....
>>>>>
>>>>> ...
>>>>>
>>>>>> static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
>>>>>> {
>>>>>>    int err;
>>>>>> +    char *suffix = "";
>>>>>>
>>>>>> -    fc->bdi.name = "fuse";
>>>>>> -    fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_SIZE;
>>>>>> -    /* fuse does it's own writeback accounting */
>>>>>> -    fc->bdi.capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
>>>>>> -
>>>>>> -    err = bdi_init(&fc->bdi);
>>>>>> +    if (sb->s_bdev)
>>>>>> +        suffix = "-fuseblk";
>>>>>> +    err = super_setup_bdi_name(sb, "%u:%u%s", MAJOR(fc->dev),
>>>>>> +                   MINOR(fc->dev), suffix);
>>>>>>    if (err)
>>>>>>        return err;
>>>>>>
>>>>>
>>>>> This call to super_setup_bdi_name would only work with "fuse" but not
>>>>> with "fuseblk" as mounting a block device in userspace triggers
>>>>> mount_bdev call which results in set_bdev_super taking a reference
>>>>> from block device's BDI.  But super_setup_bdi_name allocates a new bdi
>>>>> and ignores the already existing reference which triggers:
>>>>>
>>>>> WARN_ON(sb->s_bdi != &noop_backing_dev_info);
>>>>>
>>>>> as sb->s_bdi already has a reference from set_bdev_super.  This works
>>>>> for "fuse" (without a blocking device) for obvious reasons.  I can
>>>>> reproduce this on -rc1 and also found a report on lkml:
>>>>> https://lkml.org/lkml/2017/5/2/445
>>>>>
>>>>> Only sane solution seems to be maintaining a private bdi instace just
>>>>> for fuseblk and let fuse use the common new infrastructure.
>>>>
>>>> Thanks for analysis! Does the attached patch fix the warning for you?
>>>>
>>>
>>> Yes, tested. Feel free to add:
>>> Tested-by: Rakesh Pandit <rakesh@tuxera.com>
>>
>> Jan, want me to add it with the tested-by?
> 
> Yes, please. Thanks!

Done!

-- 
Jens Axboe
