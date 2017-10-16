Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45932 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753616AbdJPPOX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2017 11:14:23 -0400
Received: by mail-qt0-f196.google.com with SMTP id p1so32351985qtg.2
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2017 08:14:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171013153513.GA3755@hercules.tuxera.com>
References: <20171013124647.32668-1-m@bjorling.me> <20171013124647.32668-3-m@bjorling.me>
 <20171013145809.GA16745@infradead.org> <20171013153513.GA3755@hercules.tuxera.com>
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
Date: Mon, 16 Oct 2017 17:14:22 +0200
Message-ID: <CAOu_J6n91BqsKu4DqG8X1UweLmqwi=RUzuqwj0mGEut43D4_uA@mail.gmail.com>
Subject: Re: [GIT PULL 02/58] lightnvm: prevent bd removal if busy
To: Rakesh Pandit <rakesh@tuxera.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Oct 13, 2017 at 5:35 PM, Rakesh Pandit <rakesh@tuxera.com> wrote:
> On Fri, Oct 13, 2017 at 07:58:09AM -0700, Christoph Hellwig wrote:
>> On Fri, Oct 13, 2017 at 02:45:51PM +0200, Matias Bj=C3=B8rling wrote:
>> > From: Rakesh Pandit <rakesh@tuxera.com>
>> >
>> > When a virtual block device is formatted and mounted after creating
>> > with "nvme lnvm create... -t pblk", a removal from "nvm lnvm remove"
>> > would result in this:
>> >
>> > 446416.309757] bdi-block not registered
>> > [446416.309773] ------------[ cut here ]------------
>> > [446416.309780] WARNING: CPU: 3 PID: 4319 at fs/fs-writeback.c:2159
>> >   __mark_inode_dirty+0x268/0x340
>> >
>> > Ideally removal should return -EBUSY as block device is mounted after
>> > formatting.  This patch tries to address this checking if whole device
>> > or any partition of it already mounted or not before removal.
>>
>> How is this different from any other block device that can be
>> removed even if a file system is mounted?
>
> One can create many virtual block devices on top of physical using:
> nvme lnvm create ... -t pblk
>
> And remove them using:
> nvme lnvm remove
>
> Because the block devices are virtual in nature created by a program I wa=
s
> expecting removal to tell me they are busy instead of bdi-block not regis=
tered
> following by a WARNING (above).  My use case was writing automatic test c=
ase
> but I assumed this is useful in general.
>
>>
>> >
>> > Whole device is checked using "bd_super" member of block device.  This
>> > member is always set once block device has been mounted using a
>> > filesystem.  Another member "bd_part_count" takes care of checking any
>> > if any partitions are under use.  "bd_part_count" is only updated
>> > under locks when partitions are opened or closed (first open and last
>> > release).  This at least does take care sending -EBUSY if removal is
>> > being attempted while whole block device or any partition is mounted.
>> >
>>
>> That's a massive layering violation, and a driver has no business
>> looking at these fields.
>
> Okay, I didn't consider this earlier.  I would suggest a revert for this.

I see you've already done it. Thanks Jens.
