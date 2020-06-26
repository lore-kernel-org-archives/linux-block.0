Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF32C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B40E207E8
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RM6mK4Iz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nsjAN+Ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgFZGuK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:50:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37100 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFZGuJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593154227; x=1624690227;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=h0lMljOTuTe1yDuhnO5QxUdBVR4/rSXnNfF9yBRROxk=;
  b=RM6mK4IzikW1eDwQogBs0DES51F3REPmJnt2Z2SDNE2kP0eotmux5MN6
   dqPYnUGVki0JmBis/JR+osnSr89zhwp8ALxfp0IkqsiwbX0p1WtT8t6iT
   0s9ck2UgVND9l8V/Zc5a+AcA54C3cSMTcqxxmNsfM3lztobplCgK5kXL6
   +dw2HV4zXYhVcsltEDBcWZrtmV/z+Ttux/QYz9sdQgLCX/tFzJdg4NVFI
   dVbAMAWdGB54izbU3PYh5SZsKkd0AQY6B9uTc1iMmsnZKh8akcTuQHCaX
   WC5YKD4DHlVUeUge4VIKQzhvcqicSn3m773ivEF9c/7qiGGHUE9dY2w/Y
   Q==;
IronPort-SDR: mPtrLh0ZuuMoVKUgOyA7d74+nT2fe3cvxFLi1KyhqwheUpqIjg1n7+VGqimM9cRTvLQNA9rQnG
 eJMCZ63twQpSIOpDAG7hx6m33gNp8dbGiB32h83zPq6HakAVBRkguw25iViVkSTVFVfze5uz/f
 mlPaVl8Rri3B0YeZsFC4IWTEVwpnQDGnLK5YmCdmDO0daVpe66tZDBSycoDGruUJgAtuJTd0VZ
 mcvkDtA5tzZ12fD/7eNgp5aDaQw0OeBc7IdfyOzUu3bOL1QCxSDw/5c2raOZ65D6ouMCSkLCKN
 Dks=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; 
   d="scan'208";a="243991843"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 14:50:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5ELu9ELcWuFaaREjtSgg0olUVRSgTz1DqD5xZ4yTG7kIvrRmGCLKFyYAmsMs/a6oIP3kdWtsSuqPtI9FSG2WITo35cwFucrs6FYMX/JU5u7ZABYJx8FIXUJ6LQAdsBWPM9woJVAveVEK/sonflLSjgZU9mQ8OLJzFuZJJitvm7JIL+7gCyFgCfuP/JTiy6ayGGgTsmyK/YYLPPk9vqyEDmBJei2flPSKRa5+4B5Zf8ByzhjSwehnvSPTBXz0NcdsKKOlDOMKLnW/BvjtFHzsseDSYHDdExq3mjwcVpZXgGdhXXwb/BrwuA/xyAzrIXf/WAk+3r1bIJrSGRwm+xCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktxgc1k/RjJprr0k89lhJ5d65T5RBbhTon/NsJl/b4g=;
 b=c68tGjabNOK/7WwuOjIEbjjYJ4L8htYFM4I3dbSo9afJfPGBRGUI8j74p12FSxQPbkVuxh523c3JPm8VyUv1vhuGBP1KDf47fKMm4UZxCUZJq2GtVFc/vRflfEv+OkOLOfb3qdHTjWANHXyClZwoQpq6u33sNDpvC2oH5KJ6yZZ8B/wFa0/PrFHWbU9D5o0JgZkRLL0S3JRxam4BurJPk7LG2xwZN+gdEKD1HNnBRd/I/n0Mr4V+BoLuhiN15VnOPGkS2Pb0Fijr+TZAJRefoY0yT7GjzleLgKrP8aE9lkW2gjC4GgxsT8d7NcqPsUUjN3b2sYGwHQF4FOXnOPK/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktxgc1k/RjJprr0k89lhJ5d65T5RBbhTon/NsJl/b4g=;
 b=nsjAN+JuU9vgWyGwhmuiLwDX6l65tvENs8xD3RXgZJz5oFkkyWLlaUk/UIBh4hWQno9VOrizfxP1aaEZdBvA3on/0xN8ClWCpIVgMz6Xu/2fGt11hCgyLqqWaTGpttk6/m7p9XJjlVVRDD/rrQTQskXpUjd44rwoCVaxBNjlWRY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0760.namprd04.prod.outlook.com (2603:10b6:903:ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 06:49:53 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 06:49:53 +0000
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
Date:   Fri, 26 Jun 2020 06:49:53 +0000
Message-ID: <CY4PR04MB375167CFC4E3CF22324C71B5E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
 <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
 <20200626061310.6invpvs2tzxfbida@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd38f34d-9726-4c30-36c4-08d8199d21a6
x-ms-traffictypediagnostic: CY4PR04MB0760:
x-microsoft-antispam-prvs: <CY4PR04MB07603C85B8E91D5ECD68DE23E7930@CY4PR04MB0760.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ClkwLBrRHCWnKJztonipv+gqzDhB7TEDceQ8CSdwR9JSF8zmhIkCN+k5Z4+kv3FtTXV0WL3lMXoiJ6fygzadxunboDZZJ5+dAMS7DNBcxL3/ad1ynGvjSgCDrImntfuiccdbP41PmQ26oZX2kEqy0UGi5kEaq9O34VDIm/e1usi66cOKUfxqoQfvELsgi/tkJbfbsAjvyxnvHG8lCsjWAEvKltmfNDFJd+kQhQqXsT15KGrPtTwz9HM3OuEXEgoJlOfFfybxJKt92QxnURE3sGLpyTrCJ6gARvdeUh4HHOrXRl/K9iihqft0Ov5bnFzcMPAWbCavvkmQphVH7JMPJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(52536014)(2906002)(7416002)(4326008)(9686003)(71200400001)(478600001)(6916009)(55016002)(53546011)(66476007)(64756008)(66556008)(66446008)(91956017)(26005)(7696005)(6506007)(86362001)(66946007)(76116006)(186003)(5660300002)(33656002)(8936002)(316002)(66574015)(8676002)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UXGokKeHet/v2kgBKQBY0YTXnXUB7TslW0p4BCfs+b6tl6pZU+KM2v+4DUrUd8gVkRp1FW5HZgYWDmikb8Tjp33A0cQMZRnYzLYnyk5033C4vzTjHyF0rY2shxk/GfPzuAq5UR5yQjOwRGMXU/iCFk5r3NeTI5r5QCzzFJpfMXHCtLczO6n3xrkXIRtnKjDH4DhTjrasrWGpaeoowGR42uhkuMA42R2p4sCrhjkiQIwM/2xBXQrssKNECdsknlHm3F6q62Iy9v4EwH/3+//N8JnICJBNxDgYByNeATRVzOy4QLyrQX3mpGPQp/qX7w7RAA/wSGeU56VtvBak4eH2NFHSbbbsyH8bI2y9Y2hE4QfyiIsOyU8jQ7dY0MvLK4Lqz/etSq+Pv4X0W+BPmrHPXsNqWnkplx6ROzz4DoISqdMN+KRd4kAabN444VTpYa0whD/UcWD67UshYQqnSccTucahKRfQkwK+koviV2OIYvEEnODvGwLgxpHzjUS+5diI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd38f34d-9726-4c30-36c4-08d8199d21a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 06:49:53.7056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C30CJpu0ryL1xW3Xm8yePj/WIB/pWq7ZzXC1Z/rpniRRvoXZqNSNbdIvd8uQBNdJHCj9KJYkT6er8JqXQrT0gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0760
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/26 15:13, Javier Gonz=E1lez wrote:=0A=
> On 26.06.2020 00:04, Damien Le Moal wrote:=0A=
>> On 2020/06/26 6:49, Keith Busch wrote:=0A=
>>> On Thu, Jun 25, 2020 at 02:21:52PM +0200, Javier Gonz=E1lez wrote:=0A=
>>>>  drivers/nvme/host/zns.c | 7 +++++++=0A=
>>>>  1 file changed, 7 insertions(+)=0A=
>>>>=0A=
>>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c=0A=
>>>> index 7d8381fe7665..de806788a184 100644=0A=
>>>> --- a/drivers/nvme/host/zns.c=0A=
>>>> +++ b/drivers/nvme/host/zns.c=0A=
>>>> @@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_ns *n=
s, sector_t sector,=0A=
>>>>  		sector +=3D ns->zsze * nz;=0A=
>>>>  	}=0A=
>>>>=0A=
>>>> +	if (nr_zones < 0 && zone_idx !=3D ns->nr_zones) {=0A=
>>>> +		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",=0A=
>>>> +				zone_idx, ns->nr_zones);=0A=
>>>> +		ret =3D -EINVAL;=0A=
>>>> +		goto out_free;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>>  	ret =3D zone_idx;=0A=
>>>=0A=
>>> nr_zones is unsigned, so it's never < 0.=0A=
>>>=0A=
>>> The API we're providing doesn't require zone_idx equal the namespace's=
=0A=
>>> nr_zones at the end, though. A subset of the total number of zones can=
=0A=
>>> be requested here.=0A=
>>>=0A=
> =0A=
> I did see nr_zones coming with -1; guess it is my compiler.=0A=
=0A=
See include/linux/blkdev.h. -1 is:=0A=
=0A=
#define BLK_ALL_ZONES  ((unsigned int)-1)=0A=
=0A=
Which is documented in block/blk-zoned.c:=0A=
=0A=
/**=0A=
 * blkdev_report_zones - Get zones information=0A=
 * @bdev:       Target block device=0A=
 * @sector:     Sector from which to report zones=0A=
 * @nr_zones:   Maximum number of zones to report=0A=
 * @cb:         Callback function called for each reported zone=0A=
 * @data:       Private data for the callback=0A=
 *=0A=
 * Description:=0A=
 *    Get zone information starting from the zone containing @sector for at=
 most=0A=
 *    @nr_zones, and call @cb for each zone reported by the device.=0A=
 *    To report all zones in a device starting from @sector, the BLK_ALL_ZO=
NES=0A=
 *    constant can be passed to @nr_zones.=0A=
 *    Returns the number of zones reported by the device, or a negative err=
no=0A=
 *    value in case of failure.=0A=
 *=0A=
 *    Note: The caller must use memalloc_noXX_save/restore() calls to contr=
ol=0A=
 *    memory allocations done within this function.=0A=
 */=0A=
int blkdev_report_zones(struct block_device *bdev, sector_t sector,=0A=
                        unsigned int nr_zones, report_zones_cb cb, void *da=
ta)=0A=
=0A=
> =0A=
>>=0A=
>> Yes, absolutely. zone_idx is not an absolute zone number. It is the inde=
x of the=0A=
>> reported zone descriptor in the current report range requested by the us=
er,=0A=
>> which is not necessarily for the entire drive (i.e., provided nr zones i=
s less=0A=
>> than the total number of zones of the disk and/or start sector is > 0). =
So=0A=
>> zone_idx indicates the actual number of zones reported, it is not the to=
tal=0A=
> =0A=
> I see. As I can see, when nr_zones comes undefined I believed we could=0A=
> assume that zone_idx is absolute, but I can be wrong.=0A=
=0A=
No. zone_idx is *always* the index of the zone in the current report. Whate=
ver=0A=
that report is, regardless of the report starting point and number of zones=
=0A=
requested. E.g. For a single zone report (nr_zones =3D 1), you will always =
see=0A=
zone_idx =3D 0. For a full report, zone_idx will correspond to the zone num=
ber.=0A=
This is used for example in blk_revalidate_disk_zones() to initialize the z=
one=0A=
bitmaps.=0A=
=0A=
> Does it make sense to support this check with an additional counter and=
=0A=
> a explicit nr_zones initialization when undefined or you=0A=
> prefer to just remove it as Matias suggested?=0A=
=0A=
The check is not needed at all.=0A=
=0A=
If the device is buggy and reports more zones than the device capacity or a=
ny=0A=
other bugs, the driver can catch that when it processes the report.=0A=
blk_revalidate_disk_zones() also has many checks.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
