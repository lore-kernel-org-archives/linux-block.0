Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6A0C7618E
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 22:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjDUWZk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 18:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDUWZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 18:25:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707F21BD7
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 15:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E45DB61D17
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 22:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2868FC433D2;
        Fri, 21 Apr 2023 22:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682115936;
        bh=aztXhwASyfgflV18P/QZkWPrYQjfBGm5Igcp2VRfdlw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=icVZzHcK0+Unkl27BtbzIclYgE6q5KAxRXo6VSsrNVt+FQvnK6Hs/N3OHtoCl1wHC
         ZGAHwp0Mobg8Ubi5uFhsFwjnptTltA/era5o4pzcrXHxwYj1cI+PYX0NvD8xPP7AiZ
         HIoEaduKaFwXPiNXZJlkJqod8KKmu8qIOna1A6egeRJCCsZZAfQMV2L6AXh3lb5Dts
         wZXQzpG7SRcI/bGVE5m/9aK+msixKW8ig7qVQ4A0HI9mmE/81OWCxMw0uIUKDaQgfb
         rBffxHkW/YrRJ6/b5SZ8a2X7OGX1U2tSHLpygK6rvBGv0MhBNNpFC4GE6XdejTa6QU
         zsX57Oto9GgZw==
Message-ID: <335b63b0-5a9e-472d-2cce-c0158ae93cf3@kernel.org>
Date:   Sat, 22 Apr 2023 07:25:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity concept
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <nks@flawful.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20230418224002.1195163-11-bvanassche@acm.org>
 <ZEEEm/5+i7x2i8a5@x1-carbon> <f9d35d19-d0ba-fcb7-e44b-f0b8c55ba399@acm.org>
 <141aee35-4288-1670-6424-e6c41c8ef4c9@kernel.org>
 <ec7cdc7d-9eb7-65a4-6ba9-1ae6cf6f43d2@acm.org>
 <a5d9a370-6264-ebdf-f9f8-7b3263c2b6f0@kernel.org>
 <490ed061-6d82-f9fb-2050-4a386e2e4c8e@acm.org>
 <c4a52bff-5cab-5029-ad7f-e5f9452bc0e2@kernel.org>
 <ZEHY2PIRCCLOZsC4@google.com>
 <c12582e0-f2c8-d001-1fc1-6f7e17eeba7c@kernel.org>
 <ZELu0yKwnGg3iBmA@google.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZELu0yKwnGg3iBmA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/23 05:15, Jaegeuk Kim wrote:
> On 04/21, Damien Le Moal wrote:
>> On 4/21/23 09:29, Jaegeuk Kim wrote:
>>> On 04/21, Damien Le Moal wrote:
>>>> On 4/21/23 08:44, Bart Van Assche wrote:
>>>>> On 4/20/23 16:37, Damien Le Moal wrote:
>>>>>> Why would you need to handle the max active zone number restriction in the
>>>>>> scheduler ? That is the user responsibility. btrfs does it (that is still buggy
>>>>>> though, working on it).
>>>>>
>>>>> Hi Damien,
>>>>>
>>>>> If the user (filesystem) restricts the number of active zones, the code 
>>>>> for restricting the number of active zones will have to be duplicated 
>>>>> into every filesystem that supports zoned devices. Wouldn't it be better 
>>>>> if the I/O scheduler tracks the number of active zones?
>>>>
>>>> I do not think so. The reason is that for a file system, the block allocator
>>>> must be aware of any active zone limit of the underlying device to make the best
>>>> decision possible regarding where to allocate blocks for files and metadata. For
>>>
>>> Well, I'm wondering what kind of decision FS can make when allocating zones?
>>
>> Not sure what you mean... It is very similar to regular block device case. The
>> FS does block allocation based on whatever block placement policy it wants/need
>> to implement. With zoned devices, the FS block management object are mapped to
>> zones (btrfs: block group == zone, f2fs: section == zone) and the active zone
>> limits simply adds one more constraint regarding the selection of block groups
>> for allocating blocks. This is a resource management issue.
> 
> Ok, so it seems I overlooked there might be something in the zone allocation
> policy. So, f2fs already manages 6 open zones by design.

Yes, so as long as the device allows for at least 6 active zones, there are no
issues with f2fs.

>>>> btrfs, we added "active block groups" management for that purpose. And we have
>>>> tracking of a block group active state so that the block allocator can start
>>>> using new block groups (inactive ones) when previously used ones become full. We
>>>> also have a "finish block group" for cases when there is not enough remaining
>>>> free blocks in a group/zone (this does a finish zone operation to make a
>>>> non-full zone full, that is, inactive).
>>>>
>>>> Even if the block IO scheduler were to track active zones, the FS would still
>>>> need to do its own tracking (e.g. to be able to finish zones when needed). So I
>>>
>>> Why does FS also need to track the # of open zones redundantly? I have two
>>
>> Because the FS should not be issuing writes to a zone that cannot be activated
>> on the device, e.g. starting writing to an empty zone when there are already N
>> zones being written or partly written, with N >= max active zones, will result
>> in IO failures. Even if you have active zone tracking in the block IO scheduler,
>> there is absolutely NOTHING that the scheduler can do to prevent such errors.
>> E.g. think of this simple case:
>> 1) Let's take a device with max active zones = N (N != 0)
>> 2) The FS implements a block allocation policy which results in new files being
>> written to empty block groups, with 1 block group == 1 zone
>> 3) User writes N files of 4KB
>>
>> After step 3, the device has N active zones. So if the user tries to write a new
>> file, it will fail (cannot write to an empty zone as that will result in an
>> error because that zone cannot be activated by the device). AND the FS cannot
>> write metadata for these files into a metadata block group.
> 
> I think it needs to consider block allocation vs. data writes separately. That
> being said,

That mostly depends on the FS design.

> 
> 1) FS zone allocation: as you described, FS needs to allocate blocks per zone,
> and should finish to *allocate* blocks entirely in the zone, when allocating a
> new one if it meets the limit. Fortunately, F2FS is doing that by design, so
> I don't see any need to manage the open zone limitation.

Correct for f2fs case. btrfs is different in that respect.

> 2) data writes: IO scheduler needs to control write pipeline to get the best
> performance while just checking the max open zones seamlessly.

There is absolutely no need for the IO scheduler to check open/active zones
state. More below.

> With that, FS doesn't need to wait for IO completion when allocating a new
> zone.

Incorrect. I showed you a simple example of why. You can also consider a more
complex scenario and think about what can happen: multiple writers doing
buffered IOs through the page cache and suddenly doing an fsync. If you have
more writers than can have active zones, depending on how blocks are allocated,
you'll need to wait before issuing writes for some to ensure that zones can be
activated. This is *NOT* a performance impact as this synchronization is needed,
it means that you already are pounding the drive hard. Issuing more IOs will not
make the drive go faster.

>> There is nothing that the IO scheduler can do about all this. The FS has to be
>> more intelligent and do block allocation also based on the current
>> active/inactive state of the zones used by block groups.
> 
> TBH, I can't find any benefit to manage such the active/inactive states in FS.
> Am I mssing something in btrfs especially?

btrfs block management is a little more complex than f2fs. For one thing, btrfs
is 100% copy on write (unlike f2fs), which means that we absolutely MUST ensure
that we can always write metadata block groups and the super block (multiple
copies). So we need some "reserved" active zone resources for that. And for file
data, given the that block allocation may work much faster than actually writing
the device, you need to control the writeback process to throttle it within the
available active zone resources. This is naturally done in f2fs given that there
are at most only 6 segments/zones used at any time for writing. But btrfs needs
additional code.

>>> concerns if FS needs to force it:
>>> 1) performance - waiting for finish_zone before allocating a new zone can break
>>> the IO pipeline and block FS operations.
>>
>> The need to perform a zone finish is purely an optimization if, for instance,
>> you want to reduce fragmentation. E.g., if there is only 4K of free space left
>> in a zone and need to write a 1MB extent, you can write the last 4K of that
>> zone, making it inactive and write the remaining 1MB - 4KB in another zone and
>> you are guaranteed that this other zone can be written since you just
>> deactivated one zone.
>>
>> But if you do not want to fragment that 1MB extent, then you must finish that
>> zone with only 4KB left first, to ensure that another zone can be activated.
> 
> So, why should FS be aware of that? I was expecting, once FS submitted 1MB
> extent, block or IO scheduler will gracefully finish the old zone and open a
> new one which is matched to the in-disk write pointers.

The block IO scheduler is just that, a scheduler. It should NEVER be the source
of a new command. You cannot have the block IO scheduler issue commands. That is
not how the block layer works.

And it seems that you are assuming that block IOs make it to the scheduler in
about the same order as issued by the FS. There are no guarantees of that
happening when considering a set of different zones as the various issuers may
block on request allocation, or due to a device mapper between FS and device,
etc. Plenty of reasons for the overall write pattern to change between FS and
device. Not per zone for regular writes though, that is preserved. But that is
not the case for zone append writes that btrfs uses.

And you are forgetting the case of applications using the drive directly. You
cannot rely on the application working correctly and have the IO scheduler do
some random things about open/active zones. That will never work.

