Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6C6C433DF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 05:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEDDB207CD
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 05:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HL/f2zXV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n6wsD4h3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGCFUt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:20:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63546 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCFUs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jul 2020 01:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593753649; x=1625289649;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IH2Q4/471OJ53S022secirMIUArKbh/PfBE1+cfUt8k=;
  b=HL/f2zXV4BEYv+gupaGpFXQn32pTRLKyGCa0lJ/84EMOwZT9+7Lpbqce
   /N6M2HR2pmbGNLBe3pMlZXC1Ymnhavwx2nEKmSEyPnl+Tk0lI9YDJedWc
   nO+BGr3cwgb0bnHCeG4+adcJrAOJ9UpA3QQBbQKXE0sN1oTCMSVYQ7/Yt
   vRVZuG547qJ7lt5yjrl2/18lN44BisAlGuYOQE4Qerulewzr10UIrbowu
   b/rpG+w426YKsZ3jKszOYaoiF3TaBo2VdYdDXDwMs6pw+avK0r3lMoadR
   /7Lt4lFUpXK72zUbabgZkSy2ATxt9og4jiucJ0akROrCcZMEeII4jSimN
   w==;
IronPort-SDR: uwuKW/kWYRxA518xUICVcYWzG0UQfLMPrNhAej8qckWl+elc9fvzrfFxN9ZxUqJvRILZRVEJ/n
 BZyWirqq7nK8UWaofYhT850jFGWYgyI0nPm2HPULoYEUn/nQdBiAzDHwSSGyD726MGrkn3ULXx
 7PbVpbVLMZ7sniUVS+eBv1KY2UnWsnKpBzc2lg4ZQfwRRQundmho82ARJ2B2GQ1oXj8jKUq16U
 7C/yWz82xiKDyVb7KQhKjC5I6x3EQeejnAfAXQvB5yS0E0d/84LV4l98aUgzgwu+F4iVP3JOSw
 ryQ=
X-IronPort-AV: E=Sophos;i="5.75,307,1589212800"; 
   d="scan'208";a="141744755"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 13:20:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRCgdf/r0dSQUthsazrzunFfGtBAoecbN79fwXGO9pvTQugHq8BA/JaDNvTA1CMd1joA1UJEIJnojnbsyLx5OTKu/Luwpdk/VP4Ul+rvvHfa/BUGer7v9xn1Eq/u3DAW4T8VhO+TQOCORlDfSEh2FEFG5+laAL+COPpPt6+fOMDAGwbeVXIKckKnpjc9QDC65Q1wBFxWQ1S8xV+FgJlN0h18+Wyvthsumq0GZ8geY9GxOt3u7eiYVpORLsONTh6uLIbX4q7s5N11m7IbPWdGCVdL56ihVsZ2T1IBvU3qj29SS1XU+9QFgx51ikuCTUq06oCp/j7gqkVIYNSnBeIXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utOg4SIMtVhMpoXaDsVGktL4hxGEqy1uwXPI44XDS2k=;
 b=k+OTRCl3lELPbiGbcsjwUor47RSMs5LDzxGzMADGwj5lmvBCKlGd8uPQrDatT/xjZDrO//BrD5DcHzzzLgV2a2YKSSj+i2H5aj0wFlMr4f6Nibi1gFLMw3wLVfocBUopJMxhbvpjKuVo25o3PIAdpEXBgFYnb3HQwoW7sOq5DKn4QMfJ53vvwD6WL8Zt5178lRxNcz/HvfIDDanUMqc1Vd54inB6HjU+oXNL1NQ3IyEJr2WhbTYG04NZQju3RujKnpT1Q9FrXyZmjUBWhWD0I3OWCGEPEZ0NRkJFRuZEIA4WsCGyOXQxqJQp9jkTq0XdhW9vRbZwB4Y4g9WfwUY0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utOg4SIMtVhMpoXaDsVGktL4hxGEqy1uwXPI44XDS2k=;
 b=n6wsD4h32d4P9/Qg8oqDLcO6lEHEiGvXIJhsnSc841AvDhHUo6tyAbxe9Hc1UOq/LnuTHTK+8EF/OdAwc2At8bSGkyJ1DP54G0sPRvNS/VWQyAv5XLXvoWFVsC3taBiFzSiidRFGu3JYxTDLErOTk0108u76HiP6lY7kGGutpWA=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (10.172.142.14) by
 CY4PR0401MB3586.namprd04.prod.outlook.com (52.132.99.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.25; Fri, 3 Jul 2020 05:20:45 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Fri, 3 Jul 2020
 05:20:45 +0000
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
Date:   Fri, 3 Jul 2020 05:20:45 +0000
Message-ID: <CY4PR04MB3751F621B2D32B5A47332644E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-2-javier@javigon.com>
 <CY4PR04MB37511008EEBF1A77DB4F423BE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702083430.miax2cd44mkhc5fb@mpHalley.local>
 <CY4PR04MB375100663B25D1E1D8490758E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702102714.d5igoqcvcavlunmv@mpHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b763f177-60b7-4f0e-e7c9-08d81f10d6c8
x-ms-traffictypediagnostic: CY4PR0401MB3586:
x-microsoft-antispam-prvs: <CY4PR0401MB35865BA27C40FD724DE8EF9EE76A0@CY4PR0401MB3586.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MDhQFUAziOahTw9N/JzeG0z0yxYomh6KX0KIFq7niStA26bHFRGLz/OBseJz3cLLFP3ERixP+QkURKxmqUC2oiFdVS1Xli+OkDARwLacgDC8+eAkuoEV1H2cLdLOhLYHqjS8qAjIPGAFQ2OYx24oPsIknPoDE4RO7kzef3cdiVcey7SlFGw+mfogmaTg+10CK8hSzH5P7GbgR5ruIuLWKpwVn8jwWNqxtt3yW4v30Np6lgFyc6Im6+6vZ5A9IS5Kaf02ZnQrz1uZn3eVBMveef7WCmVuoLnCWKdC4VBj2UsulUitHSrYDjPRsZrUbKBLmqv5c2ySsv1WxCBL/VRIiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(66946007)(53546011)(86362001)(33656002)(8676002)(8936002)(55016002)(6916009)(9686003)(5660300002)(7416002)(478600001)(2906002)(4326008)(7696005)(83380400001)(52536014)(64756008)(66476007)(91956017)(66446008)(66556008)(76116006)(6506007)(186003)(26005)(66574015)(316002)(54906003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aSTfz6F9U6X0/7WmT+TBGYAq3MvVif6Tyj/knQ/9x5NauJT1A1ODh/9Rau9KNmteA2qnyZXN5GbyGvssZOFFioKSNucMCdN0SxObbvv34rEFagx4zR9Y3cd5mR2Xi5yi+iIOICINsHLufSxwtPqyKCWiDbcIP0fQuwmXRrR4wf8JhIlbjY4/3Z4AOKXntXteKa9ifZl7YpnDcEJiuROf9hRT4kh7EH/eWj9Pu90eh5p4FMhcJDup27XVHWoZdwijOqjCa52Fmx34XXE55e7WQrHKtupeB2jwQ6mNLrt7/GugCKwQnmdEvkE8YvH+34rMQCtL0JhPPIzAV/BQcZtMFDKF4TCgU2uX35bE6By8ePTEwoF0g2gwmZrDuwvwaVeN3CfJRVmHojh1j7xA2T2th1psBpk26YK4FkTXGnacMNGmlPk/Sl5rdgEwNJ1dfFqvqztwj51anLJWudQnHrDcRtTa4zwiaeu0BZpz8FFEIFaOrG/nspVo/TGT0qFbmaxB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b763f177-60b7-4f0e-e7c9-08d81f10d6c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 05:20:45.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRuF5GZLsLhVJ5IYkRrfCkAfB9OmED3x8ZUBtYxDOWi7tduUPrc4l5Hj9SOdaGgsN+AJKUcQniDEdW6wxuOUeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3586
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/02 19:27, Javier Gonz=E1lez wrote:=0A=
> On 02.07.2020 08:49, Damien Le Moal wrote:=0A=
>> On 2020/07/02 17:34, Javier Gonz=E1lez wrote:=0A=
>>> On 02.07.2020 07:54, Damien Le Moal wrote:=0A=
>>>> On 2020/07/02 15:55, Javier Gonz=E1lez wrote:=0A=
>>>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>>>=0A=
>>>>> As the zoned block device will have to deal with features that are=0A=
>>>>> optional for the backend device, add a flag field to inform the block=
=0A=
>>>>> layer about supported features. This builds on top of=0A=
>>>>> blk_zone_report_flags and extendes to the zone report code.=0A=
>>>>>=0A=
>>>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
>>>>> ---=0A=
>>>>>  block/blk-zoned.c              | 3 ++-=0A=
>>>>>  drivers/block/null_blk_zoned.c | 2 ++=0A=
>>>>>  drivers/nvme/host/zns.c        | 1 +=0A=
>>>>>  drivers/scsi/sd.c              | 2 ++=0A=
>>>>>  include/linux/blkdev.h         | 3 +++=0A=
>>>>>  5 files changed, 10 insertions(+), 1 deletion(-)=0A=
>>>>>=0A=
>>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
>>>>> index 81152a260354..0f156e96e48f 100644=0A=
>>>>> --- a/block/blk-zoned.c=0A=
>>>>> +++ b/block/blk-zoned.c=0A=
>>>>> @@ -312,7 +312,8 @@ int blkdev_report_zones_ioctl(struct block_device=
 *bdev, fmode_t mode,=0A=
>>>>>  		return ret;=0A=
>>>>>=0A=
>>>>>  	rep.nr_zones =3D ret;=0A=
>>>>> -	rep.flags =3D BLK_ZONE_REP_CAPACITY;=0A=
>>>>> +	rep.flags =3D q->zone_flags;=0A=
>>>>=0A=
>>>> zone_flags seem to be a fairly generic flags field while rep.flags is =
only about=0A=
>>>> the reported descriptors structure. So you may want to define a=0A=
>>>> BLK_ZONE_REP_FLAGS_MASK and have:=0A=
>>>>=0A=
>>>> 	rep.flags =3D q->zone_flags & BLK_ZONE_REP_FLAGS_MASK;=0A=
>>>>=0A=
>>>> to avoid flags meaningless for the user being set.=0A=
>>>>=0A=
>>>> In any case, since *all* zoned block devices now report capacity, I do=
 not=0A=
>>>> really see the point to add BLK_ZONE_REP_FLAGS_MASK to q->zone_flags, =
especially=0A=
>>>> considering that you set the flag for all zoned device types, includin=
g scsi=0A=
>>>> which does not have zone capacity. This makes q->zone_flags rather con=
fusing=0A=
>>>> instead of clearly defining the device features as you mentioned in th=
e commit=0A=
>>>> message.=0A=
>>>>=0A=
>>>> I think it may be better to just drop this patch, and if needed, intro=
duce the=0A=
>>>> zone_flags field where it may be needed (e.g. OFFLINE zone ioctl suppo=
rt).=0A=
>>>=0A=
>>> I am using this as a way to pass the OFFLINE support flag to the block=
=0A=
>>> layer. I used this too for the attributes. Are you thinking of a=0A=
>>> different way to send this?=0A=
>>>=0A=
>>> I believe this fits too for capacity, but we can just pass it in=0A=
>>> all report as before if you prefer.=0A=
>>=0A=
>> The point is that this patch as is does nothing and is needed as a prepa=
ratory=0A=
>> patch if we want to have the offline flag set in the report. But:=0A=
>> 1) As commented in the offline ioctl patch, I am not sure the flag makes=
 a lot=0A=
>> of sense. sysfs or nothing at all may be OK as well. When we introduced =
the new=0A=
>> open/close/finish ioctls, we did not add flags to signal that the device=
=0A=
>> supports them. Granted, it was for nullblk and scsi, and both had the su=
pport.=0A=
>> But running an application using these on an old kernel, and you will ge=
t=0A=
>> -ENOTTY, meaning, not supported. So simply introducing the offline ioctl=
 without=0A=
>> any flag would be OK I think.=0A=
> =0A=
> I see. My understanding after some comments from Christoph was that we=0A=
> should use these bits to signal any optional features / capabilities=0A=
> that would depend on the underlying driver, just as it is done with the=
=0A=
> capacity flag today.=0A=
> =0A=
> If not for the offline transition, for the attributes, I see it exactly=
=0A=
> as the same use case as capacity, where we signal that a new field is=0A=
> reported in the report structure.=0A=
> =0A=
> Am I missing something here?=0A=
=0A=
Using the report flags for reporting supported operations/features is fine,=
 but=0A=
as already mentioned, then document that by changing the description of enu=
m=0A=
blk_zone_report_flags. Right now, it still says:=0A=
=0A=
 * enum blk_zone_report_flags - Feature flags of reported zone descriptors.=
=0A=
=0A=
Which kind of really point to things the zone descriptor itself has compare=
d to=0A=
earlier versions of the descriptor rather than what the device can do or no=
t.=0A=
=0A=
And as I argued already, using a flag is fine only for letting a user know =
about=0A=
a supported feature, but that is far from ideal to have device-mapper easil=
y=0A=
discover what a target can support or not. For that, stacked queue limits a=
re=0A=
much simpler. Which leads to exporting that limit in sysfs rather than usin=
g a=0A=
flag for the user interface.=0A=
=0A=
>> Since DM support for this would be nice too and we now are in a situatio=
n where=0A=
>> not all devices support the  ioctl, instead of a report flag (a little o=
ut of=0A=
>> place), a queue limit exported through sysfs may be a cleaner way to bot=
h=0A=
>> support DM correctly (stacked limits) and signal the support to the user=
. If you=0A=
>> choose this approach, then this patch is not needed. The zoned_flags, or=
 a=0A=
>> regular queue flag like for RESET_ALL can be added in the offline ioctl =
patch.=0A=
> =0A=
> I see. If we can reach an agreement that the above is a bad=0A=
> understanding on my side, I will be happy to translate this into a sysfs=
=0A=
> entry. If it is OK, I'll give it this week in the mailing list and send=
=0A=
> a V4 next week.=0A=
=0A=
It is all about device mapper support... How are you planning to do it usin=
g a=0A=
queue flag without said flags being stackable as queue limits ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
