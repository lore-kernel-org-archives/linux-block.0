Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33567 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755297AbdAJB76 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 20:59:58 -0500
Received: by mail-oi0-f49.google.com with SMTP id w204so32614261oiw.0
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2017 17:59:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hvdtJ9v9XLARAY+Es8pPYEVP76ht6TLyWC=T_vqGwxWA@mail.gmail.com>
References: <148366547505.38941.646379357860772670.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20170106102330.GB3533@quack2.suse.cz> <CAPcyv4gmvGkAbse619WOBsEd8DDn8Fe4kVJ7r+iYug8DEg+cEg@mail.gmail.com>
 <20170108194614.GA18227@quack2.suse.cz> <CAPcyv4hvdtJ9v9XLARAY+Es8pPYEVP76ht6TLyWC=T_vqGwxWA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 9 Jan 2017 17:59:57 -0800
Message-ID: <CAPcyv4j_xaQeJq93tygRFJ8+wpEyToZB6spf1L_UBLQdmuDRDA@mail.gmail.com>
Subject: Re: [PATCH] block: fix blk_get_backing_dev_info() crash, use bdev->bd_queue
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@fb.com>, Andi Kleen <ak@linux.intel.com>,
        Rabin Vincent <rabinv@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Wei Fang <fangwei1@huawei.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jan 8, 2017 at 12:50 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Sun, Jan 8, 2017 at 11:46 AM, Jan Kara <jack@suse.cz> wrote:
>> On Fri 06-01-17 09:45:45, Dan Williams wrote:
>>> On Fri, Jan 6, 2017 at 2:23 AM, Jan Kara <jack@suse.cz> wrote:
>>> > On Thu 05-01-17 17:17:55, Dan Williams wrote:
>>> >> The ->bd_queue member of struct block_device was added in commit
>>> >> 87192a2a49c4 ("vfs: cache request_queue in struct block_device") in
>>> >> v3.3. However, blk_get_backing_dev_info() has been using
>>> >> bdev_get_queue() and grabbing the request_queue through the gendisk
>>> >> since before the git era.
>>> >>
>>> >> At final __blkdev_put() time ->bd_disk is cleared while ->bd_queue is
>>> >> not. The queue remains valid until the final put of the parent disk.
>>> >>
>>> >> The following crash signature results from blk_get_backing_dev_info()
>>> >> trying to lookup the queue through ->bd_disk after the final put of the
>>> >> block device. Simply switch bdev_get_queue() to use ->bd_queue directly
>>> >> which is guaranteed to still be valid at invalidate_partition() time.
>>> >>
>>> >>  BUG: unable to handle kernel NULL pointer dereference at 0000000000000568
>>> >>  IP: blk_get_backing_dev_info+0x10/0x20
>>> >>  [..]
>>> >>  Call Trace:
>>> >>   __inode_attach_wb+0x3a7/0x5d0
>>> >>   __filemap_fdatawrite_range+0xf8/0x100
>>> >>   filemap_write_and_wait+0x40/0x90
>>> >>   fsync_bdev+0x54/0x60
>>> >>   ? bdget_disk+0x30/0x40
>>> >>   invalidate_partition+0x24/0x50
>>> >>   del_gendisk+0xfa/0x230
>>> >
>>> > So we have a similar reports of the same problem. E.g.:
>>> >
>>> > http://www.spinics.net/lists/linux-fsdevel/msg105153.html
>>> >
>>> > However I kind of miss how your patch would fix all those cases. The
>>> > principial problem is that inode_to_bdi() called on block device inode
>>> > wants to get the backing_dev_info however on last close of a block device
>>> > we do put_disk() and thus the request queue containing backing_dev_info
>>> > does not have to be around at that time. In your case you are lucky enough
>>> > to have the containing disk still around but that's not the case for all
>>> > inode_to_bdi() users (see e.g. the report I referenced) and your patch
>>> > would change relatively straightforward NULL pointer dereference to rather
>>> > subtle use-after-free issue
>>>
>>> True. If there are other cases that don't hold their own queue
>>> reference this patch makes things worse.
>>>
>>> > so I disagree with going down this path.
>>>
>>> I still think this patch is the right thing to do, but it needs to
>>> come after the wider guarantee that having an active bdev reference
>>> guarantees that the queue and backing_dev_info are still allocated.
>>>
>>> > So what I think needs to be done is that we make backing_dev_info
>>> > independently allocated structure with different lifetime rules to gendisk
>>> > or request_queue - definitely I want it to live as long as block device
>>> > inode exists. However it needs more thought what the exact lifetime rules
>>> > will be.
>>>
>>> Hmm, why does it need to be separately allocated?
>>>
>>> Something like this, passes the libnvdimm unit tests: (non-whitespace
>>> damaged version attached)
>>
>> So the problem with this approach is that request queue will be pinned while
>> bdev inode exists. And how long that is is impossible to predict or influence
>> from userspace so e.g. you cannot remove device driver from memory and even
>> unplugging USB after it has been unmounted would suddently go via a path of
>> "device removed while it is used" which can have unexpected consequences. I
>> guess Jens or Christoph will know more about the details...
>
> We do have the "block, fs: reliably communicate bdev end-of-life"
> effort that I need to revisit:
>
>    http://www.spinics.net/lists/linux-fsdevel/msg93312.html
>
> ...but I don't immediately see how keeping the request_queue around
> longer makes the situation worse?
>

Well the 0day kbuild robot and further testing with the libnvdimm unit
tests shows that bdi code is not ready for this release timing change.
So I retract it, sorry for the noise.
