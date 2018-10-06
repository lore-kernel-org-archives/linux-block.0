Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48370 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbeJFOkC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Oct 2018 10:40:02 -0400
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Mike Snitzer <snitzer@redhat.com>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: dm: Fix report zone remapping
Date: Sat, 6 Oct 2018 07:37:38 +0000
Message-ID: <BN3PR0401MB16405173B75BE630E8894600E7E40@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181005103452.7134-1-damien.lemoal@wdc.com>
 <20181005182948.GA5628@redhat.com>
 <BN3PR0401MB1640B2763051334D011B0111E7E40@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <20181006034946.GA7891@redhat.com>
 <BN3PR0401MB164048A8F408C67EDE5B82B6E7E40@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <20181006053211.GB7891@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/10/06 14:32, Mike Snitzer wrote:=0A=
> On Sat, Oct 06 2018 at 12:03am -0400,=0A=
> Damien Le Moal <Damien.LeMoal@wdc.com> wrote:=0A=
> =0A=
>> Mike,=0A=
>>=0A=
>> On 2018/10/06 12:49, Mike Snitzer wrote:=0A=
>>> On Fri, Oct 05 2018 at  9:24pm -0400,=0A=
>>> Damien Le Moal <Damien.LeMoal@wdc.com> wrote:=0A=
>>>=0A=
>>>> Mike,=0A=
>>>>=0A=
>>>> On 2018/10/06 3:29, Mike Snitzer wrote:=0A=
>>>>> On Fri, Oct 05 2018 at  6:34am -0400,=0A=
>>>>> Damien Le Moal <damien.lemoal@wdc.com> wrote:=0A=
>>>>>=0A=
>>>>>> If dm-linear or dm-flakey have targets on top of a partition of a zo=
ned=0A=
>>>>>> block device, remapping of the start sector and write pointer positi=
on=0A=
>>>>>> of the zones reported by a report zones BIO must be modified to not=
=0A=
>>>>>> only account for the target table entry mapping, but also to account=
=0A=
>>>>>> for the partition first sector. This start sector must be substracte=
d=0A=
>>>>>> to the start sector of all zones reported. The write pointer positio=
n=0A=
>>>>>> of sequential zones must also be reduced by this offset.=0A=
>>>>>>=0A=
>>>>>> Since there is no easy way to access the underlying bdev of the targ=
et=0A=
>>>>>> table entry from the dm_target or dm_target_io pointers, modify the=
=0A=
>>>>>> interface of the function dm_remap_zone_report() to allow a target t=
o=0A=
>>>>>> pass the partition block device starting sector (offset).=0A=
>>>>>>=0A=
>>>>>> Fixes: 10999307c14e ("dm: introduce dm_remap_zone_report()")=0A=
>>>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>>>>> Cc: <stable@vger.kernel.org>=0A=
>>>>>=0A=
>>>>> [dropping the actual stable cc from the mail, please don't cc stable =
in=0A=
>>>>> the mail header, could be that git-send-email just pulled it in but..=
.]=0A=
>>>>=0A=
>>>> My apologies about that. It was indeed git-send-email. Will fix that.=
=0A=
>>>>=0A=
>>>>> This needs a different fix.  There should be absolutely no need to pa=
ss=0A=
>>>>> in a start offset for a device that is already supposed to be describ=
ed=0A=
>>>>> within the 'struct bio' passed to dm_remap_zone_report().=0A=
>>>>>=0A=
>>>>> Why can't you just use the bio->bi_bdev ?  Err, since commit=0A=
>>>>> 74d46992e0d9d, I mean bio->bi_disk to get the start sector?=0A=
>>>>>=0A=
>>>>> You should be able to get it from:=0A=
>>>>>=0A=
>>>>> struct hd_struct *part =3D disk_get_part(bio->bi_disk, bio->bi_partno=
);=0A=
>>>>> part->start_sect;=0A=
>>>>> disk_put_part(part);=0A=
>>>>>=0A=
>>>>> or:=0A=
>>>>>=0A=
>>>>> struct block_device *bdev =3D bdget_disk(bio->bi_disk, bio->bi_partno=
);=0A=
>>>>> get_start_sect(fc->dev->bdev);=0A=
>>>>> bdput(bdev);=0A=
>>>>=0A=
>>>> I am afraid this does not work. The original bio disk is of course /de=
v/dm-xx so=0A=
>>>> not the partition (partno =3D=3D 0), and the mapped bio passed as argu=
ment to the=0A=
>>>> remap zone function (clone of the orig bio) is pointing to the entire =
underlying=0A=
>>>> disk, not the partition disk used in dmsetup. bi_partno is 0 for both =
BIOs.=0A=
>>>> Which seems weird, __bio_clone_fast() does copy the disk and part numb=
er as is.=0A=
>>>> The disk is of course correctly changed from the orig dm disk to the a=
ctual=0A=
>>>> physical disk in the clone, but the partition number stays the same. I=
n the end,=0A=
>>>> only the target has the correct bdev (disk+partno) information it seem=
s.=0A=
>>>=0A=
>>> OK, that is a bug that must to be found then.=0A=
>>=0A=
>> Nope. No bug. I figured it out: after the bio remapping in the target (w=
hich=0A=
>> calls bio_set_dev() to indicate the partition bdev target for the bio), =
the=0A=
>> block core will remap that bio to the container bdev (the entire disk) w=
hich is=0A=
>> partition 0.=0A=
> =0A=
> I just fully explored the bdev lookup aspect of the DM code (thinking=0A=
> somehow we were dropping the partno on the floor).=0A=
> =0A=
> That aspect all looks fine, so I didn't send an email detailing my=0A=
> findings.=0A=
> =0A=
>> So the partition number is lost when the bio completes and zone=0A=
>> remap cannot get the starting physical sector for the adjustment of the =
zone=0A=
>> start and wp position.=0A=
> =0A=
> I didn't think to look at block core's partition remapping having a=0A=
> side-effect of losing the partition info.  Nasty.  But even if that is=0A=
> the case, shouldn't the bio have been updated to reflect the proper=0A=
> offset into the device?=0A=
> =0A=
>>>> It looks like the partno gets lost, which does not seem correct. I mus=
t be=0A=
>>>> missing something, but I fail to see what it is. Any suggestion ?=0A=
>>>=0A=
>>> Not at the moment but I'll have a closer look early next week.=0A=
>>=0A=
>> Now, I see 2 solutions:=0A=
>> * have the target add to the "start" argument passed to dm_remap_zone_re=
port()=0A=
>> the offset (start sector) of the block device. The calculation match wha=
t needs=0A=
>> to be done, so it works. It is a little ugly though as the target has to=
 be=0A=
>> "partition aware" in a sense.=0A=
>> * Add a "struct dm_dev *dev" argument to dm_remap_zone_report(). The dev=
ice=0A=
>> start sector is simply "get_start_sect(dev->bdev)" with that.=0A=
>>=0A=
>> I prefer the second solution... What do you think ?=0A=
> =0A=
> I think: I hate block core's partition code! ;)=0A=
> =0A=
> The 2nd option seems better, but I still need to get to the bottom of=0A=
> _why_ the completing bio isn't properly describing the IO that was=0A=
> issued.  It cannot have it both ways.  If it strips the partition info=0A=
> (and just maps IO relative to front of entire disk) then the bio should=
=0A=
> to be updated reflect this.=0A=
> =0A=
> Too late here now, will look tomorrow.=0A=
=0A=
I sent a v2 using the dm_dev before reading this email...=0A=
=0A=
On completion, the bio sector will be the sector when issued + completed se=
ctors=0A=
and the BIO size will indicate the remaining bytes to do, which is always 0=
 for=0A=
zone report BIOs. So looking only at the completed "bio" passed as argument=
, the=0A=
actual sector that was used is lost because the BIO original length is lost=
 too.=0A=
=0A=
Thinking of it now, we do not need an additional argument. Since a zone rep=
ort=0A=
bio clone is ALWAYS the entire original BIO (zone reports are never split),=
=0A=
report_bio is storing the original length of the request. Using that, we ca=
n=0A=
find out the actual sector used for execution, and accounting for the targe=
t=0A=
start offset in the device and its mapping, we can do this to get the parti=
tion=0A=
offset (bio is the clone, report_bio is the original):=0A=
=0A=
dev_offset =3D bio->bi_iter.bi_sector + ti->begin=0A=
		- (start + bio_end_sector(report_bio));=0A=
=0A=
Which is super not obvious and will need to be documented with a nice comme=
nt. I=0A=
just tested, and everything works fine with this. If you are OK with this=
=0A=
change, I will send a v3.=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
