Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:53752 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdJNGEZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Oct 2017 02:04:25 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [GIT PULL 02/58] lightnvm: prevent bd removal if busy
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javigon.napster@gmail.com>
In-Reply-To: <A09D1991-FDAF-4098-A654-8B6A0750C98E@gmail.com>
Date: Sat, 14 Oct 2017 08:04:21 +0200
Cc: Christoph Hellwig <hch@infradead.org>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, axboe@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <DDBBB62C-8D94-48AB-B800-7E1D137790C3@gmail.com>
References: <20171013124647.32668-1-m@bjorling.me> <20171013124647.32668-3-m@bjorling.me> <20171013145809.GA16745@infradead.org> <20171013153513.GA3755@hercules.tuxera.com> <A09D1991-FDAF-4098-A654-8B6A0750C98E@gmail.com>
To: Rakesh Pandit <rakesh@tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 13 Oct 2017, at 17.58, Javier Gonz=C3=A1lez <javigon.napster@gmail.com>=
 wrote:
>=20
>=20
>>> On 13 Oct 2017, at 17.35, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>>=20
>>>> On Fri, Oct 13, 2017 at 07:58:09AM -0700, Christoph Hellwig wrote:
>>>> On Fri, Oct 13, 2017 at 02:45:51PM +0200, Matias Bj=C3=B8rling wrote:
>>>> From: Rakesh Pandit <rakesh@tuxera.com>
>>>>=20
>>>> When a virtual block device is formatted and mounted after creating
>>>> with "nvme lnvm create... -t pblk", a removal from "nvm lnvm remove"
>>>> would result in this:
>>>>=20
>>>> 446416.309757] bdi-block not registered
>>>> [446416.309773] ------------[ cut here ]------------
>>>> [446416.309780] WARNING: CPU: 3 PID: 4319 at fs/fs-writeback.c:2159
>>>> __mark_inode_dirty+0x268/0x340
>>>>=20
>>>> Ideally removal should return -EBUSY as block device is mounted after
>>>> formatting.  This patch tries to address this checking if whole device
>>>> or any partition of it already mounted or not before removal.
>>>=20
>>> How is this different from any other block device that can be
>>> removed even if a file system is mounted?
>>=20
>> One can create many virtual block devices on top of physical using:
>> nvme lnvm create ... -t pblk
>>=20
>> And remove them using:
>> nvme lnvm remove
>>=20
>> Because the block devices are virtual in nature created by a program I wa=
s
>> expecting removal to tell me they are busy instead of bdi-block not regis=
tered
>> following by a WARNING (above).  My use case was writing automatic test c=
ase
>> but I assumed this is useful in general.
>>=20
>>>=20
>>>>=20
>>>> Whole device is checked using "bd_super" member of block device.  This
>>>> member is always set once block device has been mounted using a
>>>> filesystem.  Another member "bd_part_count" takes care of checking any
>>>> if any partitions are under use.  "bd_part_count" is only updated
>>>> under locks when partitions are opened or closed (first open and last
>>>> release).  This at least does take care sending -EBUSY if removal is
>>>> being attempted while whole block device or any partition is mounted.
>>>>=20
>>>=20
>>> That's a massive layering violation, and a driver has no business
>>> looking at these fields.
>>=20
>> Okay, I didn't consider this earlier.  I would suggest a revert for this.=

>=20
> The use case is still valid, since a block device typically does not disap=
pear under a file system - at least not because of a script suddenly removin=
g it by mistake.=20
>=20
> Any suggestion on how we can do this better?
>=20

Thinking about it, it does not seem like we have any checks now when removin=
g a fabrics block device?

Would it make sense to have a common way to let drivers know if they are in u=
se, at least to give a warning?

Javier=
