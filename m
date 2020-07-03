Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A17C433DF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 08:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA66F206DF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 08:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B8+vs2tV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="i7XiW8RR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGCIfx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:35:53 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65507 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCIfw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jul 2020 04:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593765352; x=1625301352;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UdhxYqoXNFymH2taaXaow1fKkDP/Y5TtDNqjca6rW1I=;
  b=B8+vs2tVCBlBhrlZrhJ6uAd9hzmyKtrosnSvNYJ885jskw5jBk82tlGt
   UTrXXw5bUcgKLefA79IEL1ljBWQ13/9k2yAiUTpkSTQO7OnRl8MIzbe5W
   URlfAcYflqZMh/FCupkwmP8bX+8OFXW6FM4NmgNLnkpKV5KCB3zHDahkE
   F1fDkYNpQTSZvMd0iiJt6EXKOE9+HaQfvwn5cO917fx/amyvDmvTKcuIU
   I6LGB8RpDH0T7TxxkCM6IpXUjJlHTR3IpHYaoRPNEk7Gu8zKNtOGJ3W/Q
   +Hq+sqEq53rOylXG+GK662Xhk/Vk3f9munMvbt4npJU98PNES5zoO06Ni
   w==;
IronPort-SDR: OEGNoiowuIEfxw98RNX7mgefr4RX025NRIK+Vf7AqVnSf5625CiTTM7dxXjuYhZhLYIvE93Bcf
 rCjDKAWhz3EM4sI1UOkWV1Oyc2djdCE2ngtF1VLjlHAbA3rkrK9MVwnPoBj6fbL/BuB5Ks5fye
 0TXrfEKBbG1iymbiZQiCy1Ys99ZjEUSuld3dhcPo0/ofnYxhdf5aD9u9eP1rf5052qWWn0al9E
 WNjqfQHYdMXSXm2tUwN1QAnk9P4Uhey6d9dbxCWxUiSqjKxPhq2fomIESJV6TT/3PQbb6EvYDV
 RaI=
X-IronPort-AV: E=Sophos;i="5.75,307,1589212800"; 
   d="scan'208";a="250799897"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 16:35:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCEEQA7pGsg4Z66cBZZEUbeh8i2hgr4ekEEryvIbacpdSBfLeJb6W9To7QB8/tW12BgNVqZ+XD0mjl7lFRF6/gDBTuKVgOQ05681NvFoGMSNJGOP5bS6DYphkjBVfnIRXhannuPeJ6NmMcvA+xg40UxpXHTcDtLzWLwIf3wV7YsCpzAwGmEYuaCU/i7qAd4SZvi6FVOPUVjB9QN1PUBc7jUhgf42D/RGpHNIUDgpF5Ecxj1J/43Vvj2iKIwRu10AqqkGVx9SeoP+P3Lp/2DbrdtM3RlOXChUwxgYL0ZuXrQqNFtZagqjuRhWDfQ/qEVyhyV3+ZBLQ7PKUzPiXOuDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBPs77Zo62e7OIlyfmTx1N7Rj0Du7vjkHeGzZzXtnbI=;
 b=CP9DTzk/iRM1AtjGdKaCzl1qtfZK9jK1mmUZFXz7rBi/B4DFdPnGao3cZD/J5EgsUzyTKmlaP+m3sCsStAYinSnFU8wtawSTeu3Xu9GG45Ykc/JW5mg/2qhxyAPgp1sfxFLpGOkdKydzYk53Rot0qH4u4vjgEhB69MMQbAgDudS+AyTTiXo4BkaqnWowsa016pt+dy4NGy6IF2wbnAIThm+WnDl/3WJpHhj1d+wz9BADlEDMBmpZpShNqKy+39EvhIUeFhWeQbgQFdFrXVmkNK3+P2ei1oVMyw/b+UOerX75qYjkglFEG7Y79K6EUx3mizwWoPfaGWInbH2AsTDpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBPs77Zo62e7OIlyfmTx1N7Rj0Du7vjkHeGzZzXtnbI=;
 b=i7XiW8RRfL+HLOxFdkQtAZNtStb0JUD5RdtLCXJT/OOAetwXfQPWwqul0s8ru/fx+QcHE/zQSWyBTqpEc/tKkaOX78jOKHcoIPigNaWHT/2+OZGIGSMFGqAmhCRi9ZVoxWR+KIN4fk9dtmKpWTxzvkJbrl7b62w+q5E9xxr8XuQ=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0726.namprd04.prod.outlook.com (2603:10b6:903:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Fri, 3 Jul
 2020 08:35:48 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Fri, 3 Jul 2020
 08:35:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 1/4] block: Add zone flags to queue zone prop.
Thread-Topic: [PATCH 1/4] block: Add zone flags to queue zone prop.
Thread-Index: AQHWUD25/vKGWWSejEep48tajSAGnw==
Date:   Fri, 3 Jul 2020 08:35:48 +0000
Message-ID: <CY4PR04MB3751C8F2A0ECAFD045B30AA7E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-2-javier@javigon.com>
 <CY4PR04MB37511008EEBF1A77DB4F423BE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702083430.miax2cd44mkhc5fb@mpHalley.local>
 <CY4PR04MB375100663B25D1E1D8490758E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702102714.d5igoqcvcavlunmv@mpHalley.local>
 <CY4PR04MB3751F621B2D32B5A47332644E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200703062815.qfo7tvonmgqqfcha@mpHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 595c59d3-4bff-419e-803e-08d81f2c162f
x-ms-traffictypediagnostic: CY4PR04MB0726:
x-microsoft-antispam-prvs: <CY4PR04MB0726144B4201E9484E54BFB8E76A0@CY4PR04MB0726.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M857AIYTb6hL4e1FI8LZ0S/9hHYvla+N/XMA+e+uvyaGa3nAVPrsOjeLd22scS6wqPSMu7+sTxI/mx9SJRqspMvHiG3JFC0mgkzff07Jb+X7u2FJu8K3/8jnUb3yVVYBzq+xPMTrNPr7evL/Qj2sE8Qv4XY70VeFy+YCwv871gqNqAxz7IAcCWafQDkeUzMWoSnfCUxyMkbLCCm/Qrk/R3g3sH2Kv3tNfXeBpUo5zVLgwkwz7PeOyKlMmkKOCcfhaLUXuZrTI0ZAshqP6ZV+qFaSjflWuCj84Km7SuQQM9xNcSxDaiw3oKoZpG1aCtSrCewdHji+da/EhvYrG0biLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(66946007)(33656002)(52536014)(55016002)(66556008)(66476007)(5660300002)(9686003)(26005)(186003)(53546011)(64756008)(86362001)(8936002)(7416002)(7696005)(6506007)(91956017)(2906002)(83380400001)(66446008)(4326008)(6916009)(478600001)(71200400001)(316002)(76116006)(54906003)(8676002)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PROHB+0JOC7zJGgxQ82oTZEDBZD7i57DE/Z+u79KNPqybxLRD2KDP2tADoi3QQ9fRVV0FJ86pboNtKCfwW08rXiDnC9mtroxzJ0fJiXW9flSIUB4GECmVU8anUB3XuZ1nAE4asYA6BYL0oySP6Rv1TzoAEHSP+SjcCzM4VTuxJoN2iznwKxAltKWdKcRISSfmlbO5bQWbWWnsam5GSmWYDvE0CeEGOZfql60IohAGqDf4R4uipPJkKmGL5VWHCuG+4JnooSjco0D1V7Tu9WWwspLAYkgaXBO1BWw+78FKq4ofIAbmg4/lI074DvsnjN6zkTremXBtbg8zbJmFiBrgFL2UtOaDlp/ERxZV4Tk1oYgoB0lwU0C590Jm1NCAD5OP5XZJB5DUwd7QSm8RTFvl/FpSUqMr1DbrCncMwvVsc9sR644f7Z2w9QxKgwckq1ZbpB0eVPFy+PVJ0qy3iBl/xzg7+vtpYCnJ5ufobuH68lkVp2UUlyoD9Xrt8VvK6AQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595c59d3-4bff-419e-803e-08d81f2c162f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 08:35:48.2869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qr57P60q27fpgHO3rhUXxKrlfJr9pDiesufmHCgsy8UKCleicL25GaZxTx5zIZ/W03Wji6Y2NYqSIngl6c7jJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0726
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/03 15:28, Javier Gonz=E1lez wrote:=0A=
> On 03.07.2020 05:20, Damien Le Moal wrote:=0A=
>> On 2020/07/02 19:27, Javier Gonz=E1lez wrote:=0A=
>>> On 02.07.2020 08:49, Damien Le Moal wrote:=0A=
>>>> On 2020/07/02 17:34, Javier Gonz=E1lez wrote:=0A=
>>>>> On 02.07.2020 07:54, Damien Le Moal wrote:=0A=
>>>>>> On 2020/07/02 15:55, Javier Gonz=E1lez wrote:=0A=
>>>>>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>>>>>=0A=
>>>>>>> As the zoned block device will have to deal with features that are=
=0A=
>>>>>>> optional for the backend device, add a flag field to inform the blo=
ck=0A=
>>>>>>> layer about supported features. This builds on top of=0A=
>>>>>>> blk_zone_report_flags and extendes to the zone report code.=0A=
>>>>>>>=0A=
>>>>>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
>>>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
>>>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
>>>>>>> ---=0A=
>>>>>>>  block/blk-zoned.c              | 3 ++-=0A=
>>>>>>>  drivers/block/null_blk_zoned.c | 2 ++=0A=
>>>>>>>  drivers/nvme/host/zns.c        | 1 +=0A=
>>>>>>>  drivers/scsi/sd.c              | 2 ++=0A=
>>>>>>>  include/linux/blkdev.h         | 3 +++=0A=
>>>>>>>  5 files changed, 10 insertions(+), 1 deletion(-)=0A=
>>>>>>>=0A=
>>>>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
>>>>>>> index 81152a260354..0f156e96e48f 100644=0A=
>>>>>>> --- a/block/blk-zoned.c=0A=
>>>>>>> +++ b/block/blk-zoned.c=0A=
>>>>>>> @@ -312,7 +312,8 @@ int blkdev_report_zones_ioctl(struct block_devi=
ce *bdev, fmode_t mode,=0A=
>>>>>>>  		return ret;=0A=
>>>>>>>=0A=
>>>>>>>  	rep.nr_zones =3D ret;=0A=
>>>>>>> -	rep.flags =3D BLK_ZONE_REP_CAPACITY;=0A=
>>>>>>> +	rep.flags =3D q->zone_flags;=0A=
>>>>>>=0A=
>>>>>> zone_flags seem to be a fairly generic flags field while rep.flags i=
s only about=0A=
>>>>>> the reported descriptors structure. So you may want to define a=0A=
>>>>>> BLK_ZONE_REP_FLAGS_MASK and have:=0A=
>>>>>>=0A=
>>>>>> 	rep.flags =3D q->zone_flags & BLK_ZONE_REP_FLAGS_MASK;=0A=
>>>>>>=0A=
>>>>>> to avoid flags meaningless for the user being set.=0A=
>>>>>>=0A=
>>>>>> In any case, since *all* zoned block devices now report capacity, I =
do not=0A=
>>>>>> really see the point to add BLK_ZONE_REP_FLAGS_MASK to q->zone_flags=
, especially=0A=
>>>>>> considering that you set the flag for all zoned device types, includ=
ing scsi=0A=
>>>>>> which does not have zone capacity. This makes q->zone_flags rather c=
onfusing=0A=
>>>>>> instead of clearly defining the device features as you mentioned in =
the commit=0A=
>>>>>> message.=0A=
>>>>>>=0A=
>>>>>> I think it may be better to just drop this patch, and if needed, int=
roduce the=0A=
>>>>>> zone_flags field where it may be needed (e.g. OFFLINE zone ioctl sup=
port).=0A=
>>>>>=0A=
>>>>> I am using this as a way to pass the OFFLINE support flag to the bloc=
k=0A=
>>>>> layer. I used this too for the attributes. Are you thinking of a=0A=
>>>>> different way to send this?=0A=
>>>>>=0A=
>>>>> I believe this fits too for capacity, but we can just pass it in=0A=
>>>>> all report as before if you prefer.=0A=
>>>>=0A=
>>>> The point is that this patch as is does nothing and is needed as a pre=
paratory=0A=
>>>> patch if we want to have the offline flag set in the report. But:=0A=
>>>> 1) As commented in the offline ioctl patch, I am not sure the flag mak=
es a lot=0A=
>>>> of sense. sysfs or nothing at all may be OK as well. When we introduce=
d the new=0A=
>>>> open/close/finish ioctls, we did not add flags to signal that the devi=
ce=0A=
>>>> supports them. Granted, it was for nullblk and scsi, and both had the =
support.=0A=
>>>> But running an application using these on an old kernel, and you will =
get=0A=
>>>> -ENOTTY, meaning, not supported. So simply introducing the offline ioc=
tl without=0A=
>>>> any flag would be OK I think.=0A=
>>>=0A=
>>> I see. My understanding after some comments from Christoph was that we=
=0A=
>>> should use these bits to signal any optional features / capabilities=0A=
>>> that would depend on the underlying driver, just as it is done with the=
=0A=
>>> capacity flag today.=0A=
>>>=0A=
>>> If not for the offline transition, for the attributes, I see it exactly=
=0A=
>>> as the same use case as capacity, where we signal that a new field is=
=0A=
>>> reported in the report structure.=0A=
>>>=0A=
>>> Am I missing something here?=0A=
>>=0A=
>> Using the report flags for reporting supported operations/features is fi=
ne, but=0A=
>> as already mentioned, then document that by changing the description of =
enum=0A=
>> blk_zone_report_flags. Right now, it still says:=0A=
>>=0A=
>> * enum blk_zone_report_flags - Feature flags of reported zone descriptor=
s.=0A=
>>=0A=
>> Which kind of really point to things the zone descriptor itself has comp=
ared to=0A=
>> earlier versions of the descriptor rather than what the device can do or=
 not.=0A=
> =0A=
> I see how the offline transition collides with this model. But can we=0A=
> agree that the zone attributes is something that fits here?=0A=
=0A=
Flags may be fine. I still do not see it though due to your patches missing=
=0A=
device mapper support. Please send patches that cover all zoned block devic=
e=0A=
types, including device mapper to show that this is a good approach.=0A=
=0A=
>> And as I argued already, using a flag is fine only for letting a user kn=
ow about=0A=
>> a supported feature, but that is far from ideal to have device-mapper ea=
sily=0A=
>> discover what a target can support or not. For that, stacked queue limit=
s are=0A=
>> much simpler. Which leads to exporting that limit in sysfs rather than u=
sing a=0A=
>> flag for the user interface.=0A=
> =0A=
> See below=0A=
> =0A=
>>=0A=
>>>> Since DM support for this would be nice too and we now are in a situat=
ion where=0A=
>>>> not all devices support the  ioctl, instead of a report flag (a little=
 out of=0A=
>>>> place), a queue limit exported through sysfs may be a cleaner way to b=
oth=0A=
>>>> support DM correctly (stacked limits) and signal the support to the us=
er. If you=0A=
>>>> choose this approach, then this patch is not needed. The zoned_flags, =
or a=0A=
>>>> regular queue flag like for RESET_ALL can be added in the offline ioct=
l patch.=0A=
>>>=0A=
>>> I see. If we can reach an agreement that the above is a bad=0A=
>>> understanding on my side, I will be happy to translate this into a sysf=
s=0A=
>>> entry. If it is OK, I'll give it this week in the mailing list and send=
=0A=
>>> a V4 next week.=0A=
>>=0A=
>> It is all about device mapper support... How are you planning to do it u=
sing a=0A=
>> queue flag without said flags being stackable as queue limits ?=0A=
> =0A=
> I guess what I am struggle with here is that you see the capacity=0A=
> feature as a different extension than the attributes and the offline=0A=
> transition.=0A=
> =0A=
> The way I see it, there are things the device supports and things that=0A=
> the driver supports. ZAC/ZBC does not support a size !=3D capacity, but=
=0A=
> the driver sets these values to be the same. One thing I struggle with=0A=
> is that saying that we support capacity and setting size =3D capacity put=
s=0A=
> the burden in the user to check these values across all zones to=0A=
> determine if they can support the driver or not. I think it would be=0A=
> clear to have a feature explicitly stating that capacity !=3D size.=0A=
=0A=
From the user (application or in-kernel) perspective, *all* zoned device no=
w=0A=
have a zone capacity. I do not think it matters if that comes from the devi=
ce or=0A=
from the driver. It is unconditionally supported. The report flag=0A=
BLK_ZONE_REP_CAPACITY exist to signal to user applications that the zone=0A=
descriptor has the capactiy field, to allow for backward compatibility with=
=0A=
older kernels. See patches for fio or util-linux blkzone posted to see its =
use.=0A=
=0A=
Having a flag that explicitly states that zone capacity !=3D zone size woul=
d be=0A=
useful only and only if *all* zones of the device have that property. What =
if=0A=
only some zones have a capacity lower than the zone size ? The user would s=
till=0A=
need a zone report to sort things out.=0A=
=0A=
> For the attributes, this is very similar - some apply, some don't, and=0A=
> we only report the ones that make sense for each driver. I do not see=0A=
> how device mappers are treated differently here than in the existing=0A=
> capacity features.=0A=
=0A=
The capacity feature is supported by *all* zoned block device. Support comi=
ng=0A=
from the device or from the driver does not matter. The API is consistent f=
or=0A=
all device types. So in my opinion, there is no need to consider zone capac=
ity=0A=
as an attribute. It is supported by everything, it is now part of the API,=
=0A=
signaled with BLK_ZONE_REP_CAPACITY for backward compatibility handling.=0A=
=0A=
You are mixing up the report flags describing the structure of the zone=0A=
descriptor API with optional device features attributes. Adding an attribut=
e=0A=
field to the report zones descriptors is fine. The presence of that field c=
an be=0A=
signaled with a BLK_ZONE_REP_ATTR report flag as you already proposed. No p=
roblem.=0A=
=0A=
But then, imagine a device mapper target using multiple devices with differ=
ent=0A=
optional features. How do you propose that the device mapper target sorts t=
his=0A=
out and come up with a coherent set of attributes for its target report zon=
es ?=0A=
Please propose a solution for that. Your patches so far are all missing tha=
t.=0A=
=0A=
> For the offline transition, I see that the current patches do not set=0A=
> flags properly and we would need to inherit the underlying device if we=
=0A=
> want to do it this way. I can understand from your comments that this is=
=0A=
> not a good way of doing it. I see in one of your comments from V1 that=0A=
> we could deal with this transition in the scsi driver and keep it in=0A=
> memory (i.e., device is still read-only, but driver transitions to=0A=
> offline) - can you comment on this?=0A=
=0A=
That would not be persistent across reboot, unlike for ZNS drive. So forget=
=0A=
about this. That was wishful thinking from me. This will not work.=0A=
=0A=
Explicit zone offlining is truly an optional feature of the device. Signali=
ng=0A=
its support to the user is necessary, but again, I would like that to be do=
ne in=0A=
a way that does not force device mapper targets to forever report nothing f=
or=0A=
the optional features. A flag field can certainly be used, but it has to  b=
e=0A=
handled in blk_queue_stack_limits(). That may be as simple as taking a bitw=
ise=0A=
AND of each device zone attribute flags.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
