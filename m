Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008BAC433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E7D2080C
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mSdZMJcO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Pb0o6ooK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgFZHJj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:09:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29142 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFZHJi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 03:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593155378; x=1624691378;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YZL47LhxKha/j6IxyegszydytG/olH1JU+lN53Itppc=;
  b=mSdZMJcOCM9YWZ8qDjrQWoyrl9Vre6iqKNcTFBGC4aXarKeCot+vyOFz
   KTeU695dpvg2PsdWA/yA8s2JVRRH+a63t4UtfkWaHxGYwdq/neIfluUU7
   uiCrLnUva7K2Q58PRH3NEBrlQrdyu5k4sdM+pHNGTvEtqwkHbaQVddIyt
   RCJo7i/RwOJWhmuF+g2azcG/LWjShL1pbsUYu4w7gmUl0/sdO8qqJyUjM
   HZkvEgljKi8j8ZJxi08oafF+3oMOX/Amy0k0hsSNnB8zhYQxnMdx1Zcof
   ygRxfgcsBuJZFbCbCeA3tR0bx8qDM7rfJYOZ0FVJjomm8iwI12bepTm+4
   g==;
IronPort-SDR: 5jyhAScqfFYfHzWJ9t4LkTuEkZmVsWS1S88HfPoa2ACVtiV7CEKEDBBEV40fbb4AKAQZk5KhIy
 zRLScDn3ktRsQSFPm/RHEw2wr4OjIdIrYQUEcVEY4sGObaw0HB1cFSyI6K63CghQ2KpZEVaFm1
 dxlMSZWycNjc8TEYncO5WZnezPUzECjX8Om16xQ9spHq0fpSWuhFpOiiO764+xVafzyfEHes9w
 AU9bHyd/VG5leFs541W+p4syRTYksVFHBgyJvGswwyTL1ETbV9ngPe4GKd4VyJOXJPZw0ojEu8
 g8k=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; 
   d="scan'208";a="250205662"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 15:09:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/OPLwgY5Hxa3iU/55shX8my+3sSaeUZ3/vZpZ25dIuItCVd3cLZI8JnIU8D8VhOOkydDYwPP0jBag7eyCWOgxZCYWX7BYcsSmkaX3N7RdtG3DeiU5Oom+ZvQ6esJ7LIT5drOB8gq4RbAyGIBR9CeenTs4HozRy2emlmV8TXFK6wBkXGrS/+746Vy9tCAyTgd4qixuYf3NrHPN7flALh+GAUi3LFG9pJAd4OoylK2ZgMfKs1el5rMJnvz81U9q4l7oV5r9ZtT4iQ5nARFtMNg6C0PS9s+6Gc+nEDfcgdNJ2FWwBnplq7ZPiic+z1rZbqBcQWgiOZwTDAUT45qMUsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSxBCuVFdW/uq8avUiFxG/vV9SCDK5L2i8jTHBizI44=;
 b=O2fYEdM6Ty+ZAxzdR9FOHvkN8qSd/WLslVPiyHYTJ3hZHRIFReDIlvGxvBcsn6H++vjSwvxrOFMhnvEsM/qR5NMA2NtZvZDsaqg3EbvQcPLvd2vXJ+ejs7xD3rKxUFNTkwGa80jeJTcbaSTanQwHE6AO/8rIKrlqWy1V9Pm7wIgqpun+uNViDzzS1YjbydbKJzhiZR7XX6RAVbiw8M2w3gBxpIbwVXeDjMzx6t7FTaJn+fhl6A3HLe5v7cwriB2/Yor/UZQR4koovPg4XLBSqZDtUDOd1Z3sI0eXP4Xao9Qz0y7v6Zy0r3Gc5an1UEE1NY4zZS4OpSOnDImhLRmr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSxBCuVFdW/uq8avUiFxG/vV9SCDK5L2i8jTHBizI44=;
 b=Pb0o6ooKyt7TdpiMKhh6RwuwjD/JSCkCPpl8Q7G4i6qxsV3758FBqVTbjrk5UIaQdk1CABDwF0EVzIoWYKmX7/SRtHRWU6CYlSEBgim1R7oHaPHZNY4q8MD+84+OkeGgOf4wnls0kbVtfE3b4UVdfqXOZTXMS3iTjiovXbVrpfA=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0344.namprd04.prod.outlook.com (2603:10b6:903:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 07:09:36 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 07:09:35 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Thread-Topic: [PATCH 6/6] nvme: Add consistency check for zone count
Thread-Index: AQHWSutTIAjD46n2JES6Jp1duZEotg==
Date:   Fri, 26 Jun 2020 07:09:35 +0000
Message-ID: <CY4PR04MB3751A7165FC7F068C1ECBB5EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
 <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
 <20200626061310.6invpvs2tzxfbida@mpHalley.localdomain>
 <CY4PR04MB375167CFC4E3CF22324C71B5E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626065546.v266c3zjv2gjoycs@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 723121cb-dbb1-44c8-29e9-08d8199fe247
x-ms-traffictypediagnostic: CY4PR04MB0344:
x-microsoft-antispam-prvs: <CY4PR04MB034466461ACE9742BCD652D5E7930@CY4PR04MB0344.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 60ycxtwBSvgHASeGWFSl4sqBSbECg+ocSqZDNNKv6yPwCIcHbjGxr/jMd8WscY4CVqZKYzERGeSrofSLcBb6BqgbvpsW1RBgZTFm5x/p6hS2nzwkM0Wr7yF6GwltD5hPAw4haq6/IUhmLYRm9+yXI3xpqMtQzIY9sr+NRwnrjVoW0oCXCOx8wn8lG5NL+oxMOpODfWSXyVxGc2d6WQ9xMUkvdsgbDulFZsI2SEdZHNlTcawEYjAepsQK4yPwfp9oUOs2El9Xv1uiSjQZise5q3dqPWUGdIXA73goMz+bkOkTewPs7ktSSpNyxf+hU2Tgk8PM5Cc5A/aC8gAr6vyO9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(66556008)(54906003)(86362001)(316002)(5660300002)(33656002)(4326008)(478600001)(9686003)(66946007)(7696005)(66574015)(91956017)(64756008)(55016002)(83380400001)(6916009)(66476007)(2906002)(71200400001)(76116006)(7416002)(66446008)(6506007)(186003)(8936002)(52536014)(8676002)(26005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SosngR3poDb2XYbFELtUnINe243DHJeU4o1+PIlX5Zhrpun3il2retRfeTEg0OzwII33Dd3FIWqQzkb6QDdQRrfLGSRSIXwVJZ95xWzXvzWL15PqveOSBHKCqmmzjHgFuy5sl1obB8iLFAka1lBFc0BYZ4YnLR41zZgxcnhFnr4AgjY5X3C4wezrJUdDugvKa4jduj0du5Pv0JpkV/VjU9CT+3zZLe6dNKxXSjc8zKZhcyLFyjbEgHOGlm+IknbE0KnxF3IQFaD5rTrIVtk6G3ECG7fJTMe+1E50W57CxUyL+dYLQFIkQXwDeHyHTTFg0TH9JBKs6a5MFBMaCZGqw1hkKCUHsm8Hd8Rk9jzuREeG3Ny08K5QNq/+bFOjnTiQ2ljJgpuDarZoM6haqJ8qKusy/0QpvoPj690cHimC3GUVOGSaVtML6peFAZBjUK8l0xcPEwvIWwI/gB9R1tuOvEHxfje7fTKsZeble7OMaC/fD7maNUJZYUZaxH+Simtk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723121cb-dbb1-44c8-29e9-08d8199fe247
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 07:09:35.8045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4JViS1cBdSeGu5yXGSqAo8Pdtr7PpO8xkb778U15hLhCGoq8WwjtgunvAE+MHlHMq6Q7uXIQMwfvrh4ewPyPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0344
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/26 15:55, Javier Gonz=E1lez wrote:=0A=
> On 26.06.2020 06:49, Damien Le Moal wrote:=0A=
>> On 2020/06/26 15:13, Javier Gonz=E1lez wrote:=0A=
>>> On 26.06.2020 00:04, Damien Le Moal wrote:=0A=
>>>> On 2020/06/26 6:49, Keith Busch wrote:=0A=
>>>>> On Thu, Jun 25, 2020 at 02:21:52PM +0200, Javier Gonz=E1lez wrote:=0A=
>>>>>>  drivers/nvme/host/zns.c | 7 +++++++=0A=
>>>>>>  1 file changed, 7 insertions(+)=0A=
>>>>>>=0A=
>>>>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c=0A=
>>>>>> index 7d8381fe7665..de806788a184 100644=0A=
>>>>>> --- a/drivers/nvme/host/zns.c=0A=
>>>>>> +++ b/drivers/nvme/host/zns.c=0A=
>>>>>> @@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_ns =
*ns, sector_t sector,=0A=
>>>>>>  		sector +=3D ns->zsze * nz;=0A=
>>>>>>  	}=0A=
>>>>>>=0A=
>>>>>> +	if (nr_zones < 0 && zone_idx !=3D ns->nr_zones) {=0A=
>>>>>> +		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",=0A=
>>>>>> +				zone_idx, ns->nr_zones);=0A=
>>>>>> +		ret =3D -EINVAL;=0A=
>>>>>> +		goto out_free;=0A=
>>>>>> +	}=0A=
>>>>>> +=0A=
>>>>>>  	ret =3D zone_idx;=0A=
>>>>>=0A=
>>>>> nr_zones is unsigned, so it's never < 0.=0A=
>>>>>=0A=
>>>>> The API we're providing doesn't require zone_idx equal the namespace'=
s=0A=
>>>>> nr_zones at the end, though. A subset of the total number of zones ca=
n=0A=
>>>>> be requested here.=0A=
>>>>>=0A=
>>>=0A=
>>> I did see nr_zones coming with -1; guess it is my compiler.=0A=
>>=0A=
>> See include/linux/blkdev.h. -1 is:=0A=
>>=0A=
>> #define BLK_ALL_ZONES  ((unsigned int)-1)=0A=
>>=0A=
>> Which is documented in block/blk-zoned.c:=0A=
>>=0A=
>> /**=0A=
>> * blkdev_report_zones - Get zones information=0A=
>> * @bdev:       Target block device=0A=
>> * @sector:     Sector from which to report zones=0A=
>> * @nr_zones:   Maximum number of zones to report=0A=
>> * @cb:         Callback function called for each reported zone=0A=
>> * @data:       Private data for the callback=0A=
>> *=0A=
>> * Description:=0A=
>> *    Get zone information starting from the zone containing @sector for =
at most=0A=
>> *    @nr_zones, and call @cb for each zone reported by the device.=0A=
>> *    To report all zones in a device starting from @sector, the BLK_ALL_=
ZONES=0A=
>> *    constant can be passed to @nr_zones.=0A=
>> *    Returns the number of zones reported by the device, or a negative e=
rrno=0A=
>> *    value in case of failure.=0A=
>> *=0A=
>> *    Note: The caller must use memalloc_noXX_save/restore() calls to con=
trol=0A=
>> *    memory allocations done within this function.=0A=
>> */=0A=
>> int blkdev_report_zones(struct block_device *bdev, sector_t sector,=0A=
>>                        unsigned int nr_zones, report_zones_cb cb, void *=
data)=0A=
>>=0A=
>>>=0A=
>>>>=0A=
>>>> Yes, absolutely. zone_idx is not an absolute zone number. It is the in=
dex of the=0A=
>>>> reported zone descriptor in the current report range requested by the =
user,=0A=
>>>> which is not necessarily for the entire drive (i.e., provided nr zones=
 is less=0A=
>>>> than the total number of zones of the disk and/or start sector is > 0)=
. So=0A=
>>>> zone_idx indicates the actual number of zones reported, it is not the =
total=0A=
>>>=0A=
>>> I see. As I can see, when nr_zones comes undefined I believed we could=
=0A=
>>> assume that zone_idx is absolute, but I can be wrong.=0A=
>>=0A=
>> No. zone_idx is *always* the index of the zone in the current report. Wh=
atever=0A=
>> that report is, regardless of the report starting point and number of zo=
nes=0A=
>> requested. E.g. For a single zone report (nr_zones =3D 1), you will alwa=
ys see=0A=
>> zone_idx =3D 0. For a full report, zone_idx will correspond to the zone =
number.=0A=
>> This is used for example in blk_revalidate_disk_zones() to initialize th=
e zone=0A=
>> bitmaps.=0A=
>>=0A=
>>> Does it make sense to support this check with an additional counter and=
=0A=
>>> a explicit nr_zones initialization when undefined or you=0A=
>>> prefer to just remove it as Matias suggested?=0A=
>>=0A=
>> The check is not needed at all.=0A=
>>=0A=
>> If the device is buggy and reports more zones than the device capacity o=
r any=0A=
>> other bugs, the driver can catch that when it processes the report.=0A=
>> blk_revalidate_disk_zones() also has many checks.=0A=
> =0A=
> I have managed to create a QEMU ZNS device that gave me a headache with=
=0A=
> a little bit of extra capacity that triggered an additional zone report.=
=0A=
> This was the motivation for the patch.=0A=
=0A=
The device emulation sound buggy... If the capacity is wrong, then the repo=
rt=0A=
will be too since zones are all supposed to be sequential (no holes between=
=0A=
zones) and up to the disk capacity only (last zone start + len =3D capacity=
 + 1)=0A=
=0A=
If one or the other is wrong, this should be easy to detect. Normally,=0A=
blk_revalidate_disk_zones() should be able to catch that.=0A=
=0A=
> =0A=
> I will look at the checks to cover this case too then.=0A=
> =0A=
> Thanks,=0A=
> Javier=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
