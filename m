Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35739 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbcG2IAO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 29 Jul 2016 04:00:14 -0400
Received: by mail-oi0-f49.google.com with SMTP id l72so96579785oig.2
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2016 01:00:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <yq1h9b92pfc.fsf@sermon.lab.mkp.net>
References: <CAHJVUehBe1zKvp==CUs0YkmRt5sT8qOES6bPnaeNKKsfuZ3Zrw@mail.gmail.com>
 <yq1shv1bh75.fsf@sermon.lab.mkp.net> <CAHJVUejnP=sxzrryZDPz4Y_PutF8yAV3LJSdQJGnvD+Cy==08g@mail.gmail.com>
 <yq1oa5j7sqx.fsf@sermon.lab.mkp.net> <CAHJVUejV6d0qk-Yrjqu+OfUoLrus8JctXuzwsNgMyfumUs6_+g@mail.gmail.com>
 <yq1h9b92pfc.fsf@sermon.lab.mkp.net>
From: =?UTF-8?Q?Florian=2DEwald_M=C3=BCller?=
	<florian-ewald.mueller@profitbricks.com>
Date: Fri, 29 Jul 2016 09:59:54 +0200
Message-ID: <CAHJVUeik5+3mYSFqaONu50XF9sV5+tMpTXqM-Kcijzwj+f6vDg@mail.gmail.com>
Subject: Re: [PATCH linux-4.7-rc7] blk_stack_limits() setting discard_granularity
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Martin,

I'm trying to solve this "squaring the circle" problem:
- my distributed block device "distributes" the data with the
configured block size (e.g. 64K) to different of the many underlying
slave block devices (here: dm-cache).
- my block device evaluates the discard for logically discarding the
specified block (it doesn't have more than 64K in a row) for some
specific (logical) slave device.
- that's why, I have to consider splitting the discard myself (if the
block layer doesn't do it) for treating each 64K chunk on different
(logical) slave devices.
- on the underlying block device (e.g. dm-cache) the data is placed
also in 64K chunks (there is not more in row).
- that's why, ignoring this size and sending the original big size to
it will probably delete unrelated data.

Now my experiments show that, at least, dm-cache doesn't complain nor
rejects those smaller discards than its discard_granularity, but
possibly turning them into noop (?).
May be that the needed functionality of accumulating small discards to
a big one covering its own granularity (similar to SSDs block erasure)
should be done at that driver level.

What do you think ?

Florian

On Fri, Jul 29, 2016 at 3:39 AM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Florian-Ewald" == Florian-Ewald Müller <florian-ewald.mueller@profitbricks.com> writes:
>
> Florian-Ewald,
>
>> My (new developed) distributed block device uses a block size of 64K.
>
>> So, because of the distribution functionality to different underlying
>> slave (dm-cache) block devices, it has:
>> - max_discard_sectors: 128 (64K)
>> - discard_granularity: 65536 (64K)
>
>> The discard sizes of the (underlying) dm-cache devices are:
>> - max_discard_sectors: 536870912 (256G)
>> - discard_granularity: 268435456 (256M)
>
> Why do you set max_discard_sectors for your device to 128? To my
> knowledge dm-cache does not do partial allocation. And consequently any
> discard less than an aligned 256MB will be a nop anyway.
>
> --
> Martin K. Petersen      Oracle Linux Engineering



-- 
Florian-Ewald Mueller

Architecture Board


ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin


Tel:       +49 30 577 008 331
Fax:      +49 30 577 008 598
Email:   florian-ewald.mueller@profitbricks.com
URL:     http://www.profitbricks.de

Sitz der Gesellschaft: Berlin.
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B.
Geschäftsführer: Andreas Gauger, Achim Weiss.

Please consider the environment before printing this email.
