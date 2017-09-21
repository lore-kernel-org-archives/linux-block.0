Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50281 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbdIULN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 07:13:56 -0400
Received: by mail-wm0-f48.google.com with SMTP id b195so755584wmb.5
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2017 04:13:55 -0700 (PDT)
Subject: Re: [PATCH V2] lightnvm: prevent bd removal if busy
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        Rakesh Pandit <rakesh@tuxera.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170910190712.GA7010@hercules.tuxera.com>
 <EEE26368-B800-4483-AFA7-36E84773C401@lightnvm.io>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <041e9eb6-aaf5-14a4-5c8e-98efbc446262@lightnvm.io>
Date: Thu, 21 Sep 2017 13:13:53 +0200
MIME-Version: 1.0
In-Reply-To: <EEE26368-B800-4483-AFA7-36E84773C401@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/12/2017 03:22 PM, Javier González wrote:
>> On 10 Sep 2017, at 21.07, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>
>> When a virtual block device is formatted and mounted after creating
>> with "nvme lnvm create... -t pblk", a removal from "nvm lnvm remove"
>> would result in this:
>>
>> 446416.309757] bdi-block not registered
>> [446416.309773] ------------[ cut here ]------------
>> [446416.309780] WARNING: CPU: 3 PID: 4319 at fs/fs-writeback.c:2159 __mark_inode_dirty+0x268/0x340
>>
>> Ideally removal should return -EBUSY as block device is mounted after
>> formatting.  This patch tries to address this checking if whole device
>> or any partition of it already mounted or not before removal.
>>
>> Whole device is checked using "bd_super" member of block device.  This
>> member is always set once block device has been mounted using a
>> filesystem.  Another member "bd_part_count" takes care of checking any
>> if any partitions are under use.  "bd_part_count" is only updated
>> under locks when partitions are opened or closed (first open and last
>> release).  This at least does take care sending -EBUSY if removal is
>> being attempted while whole block device or any partition is mounted.
>>
>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>> ---
>>
>> V2: Take a different approach. Instead of checking bd_openers use
>> bd_super and bd_part_count.  This should address the removal of bdevs
>> which are mounted from removal.
>>
>> drivers/lightnvm/core.c | 14 ++++++++++++++
>> 1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index c39f87d..9f9a137 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -373,6 +373,7 @@ static void __nvm_remove_target(struct nvm_target *t)
>> static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
>> {
>> 	struct nvm_target *t;
>> +	struct block_device *bdev;
>>
>> 	mutex_lock(&dev->mlock);
>> 	t = nvm_find_target(dev, remove->tgtname);
>> @@ -380,6 +381,19 @@ static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
>> 		mutex_unlock(&dev->mlock);
>> 		return 1;
>> 	}
>> +	bdev = bdget_disk(t->disk, 0);
>> +	if (!bdev) {
>> +		pr_err("nvm: removal failed, allocating bd failed\n");
>> +		mutex_unlock(&dev->mlock);
>> +		return -ENOMEM;
>> +	}
>> +	if (bdev->bd_super || bdev->bd_part_count) {
>> +		pr_err("nvm: removal failed, block device busy\n");
>> +		bdput(bdev);
>> +		mutex_unlock(&dev->mlock);
>> +		return -EBUSY;
>> +	}
>> +	bdput(bdev);
>> 	__nvm_remove_target(t);
>> 	mutex_unlock(&dev->mlock);
>>
>> --
>> 2.7.4
> 
> Looks good.
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> 

Thanks Rakesh. I pulled it in for 4.15.
