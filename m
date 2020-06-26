Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88358C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F65920775
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q25V+G0R";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="N+xIG145"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgFZHmJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:42:09 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:57414 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgFZHmH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 03:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593157327; x=1624693327;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iBx2cSpOpLuILOUqSnNlDC+GHkTPAR7wFFCcjC+RAr0=;
  b=Q25V+G0R/p8BiRHlDbWOBeLwJC2M89xC1ahYZo/X1eh8b2+gGPCubbqW
   vg4bGyCztwVwc/o6V8UXl7BftTzO9PlAbaSITciWFxwAbqc4J0mHX/Eja
   VI7zcp0u7mJYk4IhpAK2t6koz06f2a116mcA1uX4me7dfOUAB8CmMWGAv
   Xir2Z2RJ2gtNSBxnWKWqaDdRH8qquSTLjP2HQwQSAxhOdhz20F+mou0+l
   +Lv/atN5qSEuNrm0UwO/CLcFJefgyC6z0/SFDnHhMsA/efFLE+WCNOnWL
   u5hFbV3u/1QhBVERg38TGhMi/Yxhz+KYJn9zrvzQDmUCmbz3I959Y6q87
   w==;
IronPort-SDR: S76pyCHXM0bp129IUo6BqTM8rKeEo85+QcSgGZG2Z20RjumNCzwckNoRb7Lwa3aFGuHhAZEgap
 +ANthTzPZsCAxoHfMximcGvxV0iMwPDGKl4GOScg+stflo6rZJI90zEExDJrXBVSIY8IGec2uf
 MVUVSF5t1zsxehssoybmjbKnr/NAAIdK38mKXw72zmlSV5SyNU1F8yI+HYNdWdblnIDVF2BqHw
 THfw9JlqSM0JanutkxHS+jjsEqIxZi0Nq6nhtjihjVQVDzwzpycUSePEossjIW1HFrDeRGNXTB
 ybc=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; 
   d="scan'208";a="250207772"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 15:42:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TruXa7r93kqvdyYPRuCpSJLd7Byf6Gnhc2+Va3xHfO+OUPhWoPoiF0XIIqnNmSaTTBWS6i9gtkUkOa0i87hr8cfbDjp2B/+9y2PNDMxjtuZzXnWequGXzsK9qRAYe+h8wT7pfkFczKi65SXcni6+KmAmVLZc7MENr/yK9WMDInfEbANR6EbRq+koQW6/emybbFvav+xZJHOo/W/sHDjKqXAiY089qEmRVRLisZNIWqMVsfo6DaaLWIz5GmfTySCdDHQnUBzrbF1HQx2D0SXIKDAVXtAMqQwdmWfVQWacINdA6MK1Pui8I+CaES5kT99scFbmou0GriZQ+B35WJ8rdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuAp4Xe4aofiEF8mzcXd8LpBNCM8uk7Q7d0Wf4g3bC8=;
 b=Gvl2eZKnsVA+eG5bdspQKBTClz/rpT9/HjrCWQjDfzgnMM/swzNqvU69TvbozLvTPVSb8HLlZ8xmt8ZbNyldRqH7X25EYBpIw4AOmZGbydhY5RjuV3/TQVt4EfQs9hjfnQgaLjKQyn6UWLy8+4VGjMQxKf2nlcG1jHj3KBXymyS3r+RcNznmRxaZuS26tRfE+q1wCn4eCznzNxALEPkurl8Yafh/3z/rJRlkWlZP+dMtib8u6Eotg6LN8ZKF/rTpdP8RKWiBGerVmWRlXmTeDjxyc7aU8DXzmMJ82xAKLOPzabRgP/YoxE66KsE7S8uqS5FodYhSmUBy76bMYdcrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuAp4Xe4aofiEF8mzcXd8LpBNCM8uk7Q7d0Wf4g3bC8=;
 b=N+xIG145eEgPVQ+cPyUqoVT52XL3UCzvrHNxQOe/TyQiSuTxmu5Do1RnAPE2ch/yNxD1KgoaJTu9UYBdkHFsKdF+LmXcWNJXEw9+EoiKLzGoHLvWilY+rO6jVcgRdwi1WpYyQK99PHKLxxvR/F2Uo812m7URBDFqM0YmiyJLnSs=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0760.namprd04.prod.outlook.com (2603:10b6:903:ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 07:42:04 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 07:42:04 +0000
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
Date:   Fri, 26 Jun 2020 07:42:04 +0000
Message-ID: <CY4PR04MB3751D51C40A39FF0ACC79DE0E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
 <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
 <20200626061310.6invpvs2tzxfbida@mpHalley.localdomain>
 <CY4PR04MB375167CFC4E3CF22324C71B5E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626065546.v266c3zjv2gjoycs@mpHalley.localdomain>
 <CY4PR04MB3751A7165FC7F068C1ECBB5EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626072900.rjigm3wiya4sdufv@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc387304-04a9-45e8-d93f-08d819a46ba8
x-ms-traffictypediagnostic: CY4PR04MB0760:
x-microsoft-antispam-prvs: <CY4PR04MB07605ABB1F2DB709F7294B2DE7930@CY4PR04MB0760.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LK/brx4ND8ieMkIM1tiKF59V/OF3Ed7ZF200a+ODCH1g3Qq4PBA/ctiuZV+Fq7KlcfOuE3Svds449hRYrWtUi0LRVlo7atGF3VD7GIMFRPEke6jFNoPcblT6rd8aC9kwQDpcYJKYH5an3zPJoJWGfdRbgNBjzaVg88qJKACPua+dBsBabYiopHu7azslCV94EWmcOYwc0a2gppRVq5AxRDApSAeS1jAB4cyfUFMMoRjAm+rIDswgeOrkHyABhuzwMShelaPi5hAnstVBijFNU1/mX6PpyadpTynHQr5CSeZiI92kLY0bNCQkVEQpyIj2QCoZJhm3q3bWqTEIb0gZQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(52536014)(2906002)(7416002)(4326008)(9686003)(71200400001)(478600001)(6916009)(55016002)(53546011)(66556008)(66446008)(66946007)(64756008)(66476007)(26005)(7696005)(91956017)(86362001)(6506007)(76116006)(186003)(5660300002)(33656002)(8936002)(316002)(66574015)(8676002)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vAbNFbXI/SFtpcvHINP4IkjENrQmemRP2lRRs3jme1QNbAFIL/h4uVw7yoCV7WWOQNHD3lLOEY6J+Xd4+U0OW0cluUaDTi4bIWM+P0MtoAG73M2rNARzsR2GmK42WkNo4hJz7Z001sjymQN6Xx1tymBdwnlGE61+v7xsiQ8qpTpYh97YtRrZ7XZ2Yp+LYHE9owWWa4Jt0KxKtpCXqauR9C8wmETDncQcdYgQq7F6spUCAL2vIqL/gleVTSxT5OLJCIcMAq80abax/j49/KsdzSLW1T5O8t+fRcZ3lZkTvBXexf2ePDLpg6Xj7szxMPcIWrLJUz6NyTY2RND33HN/M7BfvXafWpal8rzVzKK7d9zaT86q5q3ClqSNDnv1VK4h0+htkRUv/ZX7LRxZcDc13cxZ5vb1xl+xQHGZ5O3jW4ZyFKyz/ar8nJa4vy0G1tdiiZsXwKe4XKN3DnXc9uAGf3bqtFZH7Km8e1unA1DRrvevUWJNiOPI9IXjKojfdl6d
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc387304-04a9-45e8-d93f-08d819a46ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 07:42:04.3004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1I9KkcyaJv7n+IceBWJ6mhBaGY3bLeJ53yGK8Ou9gU9Nt6F8moyVqRj5P9/9VCeu0vvHoE9iY95lBd1i0kO8Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0760
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/26 16:29, Javier Gonz=E1lez wrote:=0A=
> On 26.06.2020 07:09, Damien Le Moal wrote:=0A=
>> On 2020/06/26 15:55, Javier Gonz=E1lez wrote:=0A=
>>> On 26.06.2020 06:49, Damien Le Moal wrote:=0A=
>>>> On 2020/06/26 15:13, Javier Gonz=E1lez wrote:=0A=
>>>>> On 26.06.2020 00:04, Damien Le Moal wrote:=0A=
>>>>>> On 2020/06/26 6:49, Keith Busch wrote:=0A=
>>>>>>> On Thu, Jun 25, 2020 at 02:21:52PM +0200, Javier Gonz=E1lez wrote:=
=0A=
>>>>>>>>  drivers/nvme/host/zns.c | 7 +++++++=0A=
>>>>>>>>  1 file changed, 7 insertions(+)=0A=
>>>>>>>>=0A=
>>>>>>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c=0A=
>>>>>>>> index 7d8381fe7665..de806788a184 100644=0A=
>>>>>>>> --- a/drivers/nvme/host/zns.c=0A=
>>>>>>>> +++ b/drivers/nvme/host/zns.c=0A=
>>>>>>>> @@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_n=
s *ns, sector_t sector,=0A=
>>>>>>>>  		sector +=3D ns->zsze * nz;=0A=
>>>>>>>>  	}=0A=
>>>>>>>>=0A=
>>>>>>>> +	if (nr_zones < 0 && zone_idx !=3D ns->nr_zones) {=0A=
>>>>>>>> +		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",=0A=
>>>>>>>> +				zone_idx, ns->nr_zones);=0A=
>>>>>>>> +		ret =3D -EINVAL;=0A=
>>>>>>>> +		goto out_free;=0A=
>>>>>>>> +	}=0A=
>>>>>>>> +=0A=
>>>>>>>>  	ret =3D zone_idx;=0A=
>>>>>>>=0A=
>>>>>>> nr_zones is unsigned, so it's never < 0.=0A=
>>>>>>>=0A=
>>>>>>> The API we're providing doesn't require zone_idx equal the namespac=
e's=0A=
>>>>>>> nr_zones at the end, though. A subset of the total number of zones =
can=0A=
>>>>>>> be requested here.=0A=
>>>>>>>=0A=
>>>>>=0A=
>>>>> I did see nr_zones coming with -1; guess it is my compiler.=0A=
>>>>=0A=
>>>> See include/linux/blkdev.h. -1 is:=0A=
>>>>=0A=
>>>> #define BLK_ALL_ZONES  ((unsigned int)-1)=0A=
>>>>=0A=
>>>> Which is documented in block/blk-zoned.c:=0A=
>>>>=0A=
>>>> /**=0A=
>>>> * blkdev_report_zones - Get zones information=0A=
>>>> * @bdev:       Target block device=0A=
>>>> * @sector:     Sector from which to report zones=0A=
>>>> * @nr_zones:   Maximum number of zones to report=0A=
>>>> * @cb:         Callback function called for each reported zone=0A=
>>>> * @data:       Private data for the callback=0A=
>>>> *=0A=
>>>> * Description:=0A=
>>>> *    Get zone information starting from the zone containing @sector fo=
r at most=0A=
>>>> *    @nr_zones, and call @cb for each zone reported by the device.=0A=
>>>> *    To report all zones in a device starting from @sector, the BLK_AL=
L_ZONES=0A=
>>>> *    constant can be passed to @nr_zones.=0A=
>>>> *    Returns the number of zones reported by the device, or a negative=
 errno=0A=
>>>> *    value in case of failure.=0A=
>>>> *=0A=
>>>> *    Note: The caller must use memalloc_noXX_save/restore() calls to c=
ontrol=0A=
>>>> *    memory allocations done within this function.=0A=
>>>> */=0A=
>>>> int blkdev_report_zones(struct block_device *bdev, sector_t sector,=0A=
>>>>                        unsigned int nr_zones, report_zones_cb cb, void=
 *data)=0A=
>>>>=0A=
>>>>>=0A=
>>>>>>=0A=
>>>>>> Yes, absolutely. zone_idx is not an absolute zone number. It is the =
index of the=0A=
>>>>>> reported zone descriptor in the current report range requested by th=
e user,=0A=
>>>>>> which is not necessarily for the entire drive (i.e., provided nr zon=
es is less=0A=
>>>>>> than the total number of zones of the disk and/or start sector is > =
0). So=0A=
>>>>>> zone_idx indicates the actual number of zones reported, it is not th=
e total=0A=
>>>>>=0A=
>>>>> I see. As I can see, when nr_zones comes undefined I believed we coul=
d=0A=
>>>>> assume that zone_idx is absolute, but I can be wrong.=0A=
>>>>=0A=
>>>> No. zone_idx is *always* the index of the zone in the current report. =
Whatever=0A=
>>>> that report is, regardless of the report starting point and number of =
zones=0A=
>>>> requested. E.g. For a single zone report (nr_zones =3D 1), you will al=
ways see=0A=
>>>> zone_idx =3D 0. For a full report, zone_idx will correspond to the zon=
e number.=0A=
>>>> This is used for example in blk_revalidate_disk_zones() to initialize =
the zone=0A=
>>>> bitmaps.=0A=
>>>>=0A=
>>>>> Does it make sense to support this check with an additional counter a=
nd=0A=
>>>>> a explicit nr_zones initialization when undefined or you=0A=
>>>>> prefer to just remove it as Matias suggested?=0A=
>>>>=0A=
>>>> The check is not needed at all.=0A=
>>>>=0A=
>>>> If the device is buggy and reports more zones than the device capacity=
 or any=0A=
>>>> other bugs, the driver can catch that when it processes the report.=0A=
>>>> blk_revalidate_disk_zones() also has many checks.=0A=
>>>=0A=
>>> I have managed to create a QEMU ZNS device that gave me a headache with=
=0A=
>>> a little bit of extra capacity that triggered an additional zone report=
.=0A=
>>> This was the motivation for the patch.=0A=
>>=0A=
>> The device emulation sound buggy... If the capacity is wrong, then the r=
eport=0A=
>> will be too since zones are all supposed to be sequential (no holes betw=
een=0A=
>> zones) and up to the disk capacity only (last zone start + len =3D capac=
ity + 1)=0A=
>>=0A=
>> If one or the other is wrong, this should be easy to detect. Normally,=
=0A=
>> blk_revalidate_disk_zones() should be able to catch that.=0A=
> =0A=
> We have the capability to select the reported device capacity manually=0A=
> for a number of reasons. One of the different test configurations in our=
=0A=
> CI did go through.=0A=
=0A=
If you change the drive capacity on the fly (e.g. with a low level format ?=
),=0A=
you must revalidate the disk/drive to get the changed capacity. A lot of th=
ings=0A=
will break otherwise This is not just report zones that will be incorrect.=
=0A=
=0A=
> =0A=
> But it is OK, I will remove the check on V2.=0A=
> =0A=
> Javier=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
