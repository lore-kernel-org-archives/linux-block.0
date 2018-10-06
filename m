Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4450 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeJFLFb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Oct 2018 07:05:31 -0400
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Mike Snitzer <snitzer@redhat.com>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: dm: Fix report zone remapping
Date: Sat, 6 Oct 2018 04:03:43 +0000
Message-ID: <BN3PR0401MB164048A8F408C67EDE5B82B6E7E40@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181005103452.7134-1-damien.lemoal@wdc.com>
 <20181005182948.GA5628@redhat.com>
 <BN3PR0401MB1640B2763051334D011B0111E7E40@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <20181006034946.GA7891@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Mike,=0A=
=0A=
On 2018/10/06 12:49, Mike Snitzer wrote:=0A=
> On Fri, Oct 05 2018 at  9:24pm -0400,=0A=
> Damien Le Moal <Damien.LeMoal@wdc.com> wrote:=0A=
> =0A=
>> Mike,=0A=
>>=0A=
>> On 2018/10/06 3:29, Mike Snitzer wrote:=0A=
>>> On Fri, Oct 05 2018 at  6:34am -0400,=0A=
>>> Damien Le Moal <damien.lemoal@wdc.com> wrote:=0A=
>>>=0A=
>>>> If dm-linear or dm-flakey have targets on top of a partition of a zone=
d=0A=
>>>> block device, remapping of the start sector and write pointer position=
=0A=
>>>> of the zones reported by a report zones BIO must be modified to not=0A=
>>>> only account for the target table entry mapping, but also to account=
=0A=
>>>> for the partition first sector. This start sector must be substracted=
=0A=
>>>> to the start sector of all zones reported. The write pointer position=
=0A=
>>>> of sequential zones must also be reduced by this offset.=0A=
>>>>=0A=
>>>> Since there is no easy way to access the underlying bdev of the target=
=0A=
>>>> table entry from the dm_target or dm_target_io pointers, modify the=0A=
>>>> interface of the function dm_remap_zone_report() to allow a target to=
=0A=
>>>> pass the partition block device starting sector (offset).=0A=
>>>>=0A=
>>>> Fixes: 10999307c14e ("dm: introduce dm_remap_zone_report()")=0A=
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>>> Cc: <stable@vger.kernel.org>=0A=
>>>=0A=
>>> [dropping the actual stable cc from the mail, please don't cc stable in=
=0A=
>>> the mail header, could be that git-send-email just pulled it in but...]=
=0A=
>>=0A=
>> My apologies about that. It was indeed git-send-email. Will fix that.=0A=
>>=0A=
>>> This needs a different fix.  There should be absolutely no need to pass=
=0A=
>>> in a start offset for a device that is already supposed to be described=
=0A=
>>> within the 'struct bio' passed to dm_remap_zone_report().=0A=
>>>=0A=
>>> Why can't you just use the bio->bi_bdev ?  Err, since commit=0A=
>>> 74d46992e0d9d, I mean bio->bi_disk to get the start sector?=0A=
>>>=0A=
>>> You should be able to get it from:=0A=
>>>=0A=
>>> struct hd_struct *part =3D disk_get_part(bio->bi_disk, bio->bi_partno);=
=0A=
>>> part->start_sect;=0A=
>>> disk_put_part(part);=0A=
>>>=0A=
>>> or:=0A=
>>>=0A=
>>> struct block_device *bdev =3D bdget_disk(bio->bi_disk, bio->bi_partno);=
=0A=
>>> get_start_sect(fc->dev->bdev);=0A=
>>> bdput(bdev);=0A=
>>=0A=
>> I am afraid this does not work. The original bio disk is of course /dev/=
dm-xx so=0A=
>> not the partition (partno =3D=3D 0), and the mapped bio passed as argume=
nt to the=0A=
>> remap zone function (clone of the orig bio) is pointing to the entire un=
derlying=0A=
>> disk, not the partition disk used in dmsetup. bi_partno is 0 for both BI=
Os.=0A=
>> Which seems weird, __bio_clone_fast() does copy the disk and part number=
 as is.=0A=
>> The disk is of course correctly changed from the orig dm disk to the act=
ual=0A=
>> physical disk in the clone, but the partition number stays the same. In =
the end,=0A=
>> only the target has the correct bdev (disk+partno) information it seems.=
=0A=
> =0A=
> OK, that is a bug that must to be found then.=0A=
=0A=
Nope. No bug. I figured it out: after the bio remapping in the target (whic=
h=0A=
calls bio_set_dev() to indicate the partition bdev target for the bio), the=
=0A=
block core will remap that bio to the container bdev (the entire disk) whic=
h is=0A=
partition 0. So the partition number is lost when the bio completes and zon=
e=0A=
remap cannot get the starting physical sector for the adjustment of the zon=
e=0A=
start and wp position.=0A=
=0A=
>> It looks like the partno gets lost, which does not seem correct. I must =
be=0A=
>> missing something, but I fail to see what it is. Any suggestion ?=0A=
> =0A=
> Not at the moment but I'll have a closer look early next week.=0A=
=0A=
Now, I see 2 solutions:=0A=
* have the target add to the "start" argument passed to dm_remap_zone_repor=
t()=0A=
the offset (start sector) of the block device. The calculation match what n=
eeds=0A=
to be done, so it works. It is a little ugly though as the target has to be=
=0A=
"partition aware" in a sense.=0A=
* Add a "struct dm_dev *dev" argument to dm_remap_zone_report(). The device=
=0A=
start sector is simply "get_start_sect(dev->bdev)" with that.=0A=
=0A=
I prefer the second solution... What do you think ?=0A=
=0A=
Note that I have a zoned block device series in the work which improves zon=
e=0A=
report and simplifies all of this remapping business in dm. But the current=
 code=0A=
still needs fixing.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
