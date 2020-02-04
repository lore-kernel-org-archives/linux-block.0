Return-Path: <SRS0=vwZl=3Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0932DC3524A
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 08:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2B420730
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 08:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rcUBrj5w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dlwO78ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgBDIcD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:32:03 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63587 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgBDIcC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Feb 2020 03:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580805121; x=1612341121;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CUa9PlIsrj49nWxUq/0ozrxRJxWFshVPJIWnFcV8TFU=;
  b=rcUBrj5wd9ctfUiGiqz8KvyCT7YhVG9oI/p0eFioJrjsfE/LqhtBEzHI
   sQJlwtsWufqLS7bdu/XUFRm0Tt37NUV/Ni/GzxtsMiS558ZAaQAKe5xO/
   6mwGsGt9GAZkBR8crFN+hkh3DXfa8piWzmkLr5LGISswk7PFLf5rVGjrC
   4OfJ+DButZsOKj2mKnY+QEJKwnYOlE+Ju7qFg9f9H/e6FVr8UyENLkHIg
   LBnrKFqE+bh8klu57cS0NG0kiQ57/T1OKuwiqTkfXH4wle3OjBCvnQTJ2
   5iyz7xrSzvaE4OXuELQkNH7bgY7gplLiSWOWmur1EwRQQoJcvcf/FFiPn
   g==;
IronPort-SDR: G4ABP2NAAFSm08hKAi6GnjCDENGgc6wCCAElazrweMze3G15y4kchCC0Ncji8/V+nM1CtKORNh
 Q22MiFRiWYAA6MuI3o6GBfWqcj1FS4ovlAzZfbJp57ne7QXt1pNREnx8C0rnZcVwQkxZ5fdRNb
 Cs6i2bPg6OFyintsc6AUGPDnxkIfuc9BD5mOk59bzzr+WSpsouQbhWAE1E2amhxgZA0Rwlzjaa
 jk4Z12RTid0qrjPrxOeZynHLVjtx4rjKTbNwpl/uBXpUvU0NX7KsbsqRqRj+/oxcfphwlu7H62
 K5U=
X-IronPort-AV: E=Sophos;i="5.70,398,1574092800"; 
   d="scan'208";a="237007611"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2020 16:32:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwvk5oK3bEtaTbYZxJ5/oWMjqjt3tfeQRPQvGF6IxvAFF/SN8SZGBy7SAmXbYhXAzMwo8PvaD66jYo+zPUEFJWtd7nxcoDlHyRafBiq+1N3gmzbRVeChfKG1JyQPIhD2BCX9cv16VXgFASSgGARQuhFbv/UDwmQRqjdlPYRbhQ7horH5Klt5nGNB2sX0ay1Bt/US0tX8s73uanHk3l0Sz2Wl3lrqWROdING3SSh/+WbirqORajNajDrqANUi2/C7Jn/+4MHDH48brPYXtKooi01vQJlONu74jSYc7G6S6nfJk2RFtjhjDTJ81nIAhdMYEvv5ZXk9vgaCOKKnhOZQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUa9PlIsrj49nWxUq/0ozrxRJxWFshVPJIWnFcV8TFU=;
 b=SfqXgqoUuBprL4kTWZFBHY7rn1hvPaLo80jXdJjsk2noR+sXCIhq5pqx/Qumcomf48kDPitHOl6EfkBf4WufVQUElgDNN2LnsGwQcvqBV2H3qXqQ7vYXJzBCNZcQ/Sb+kl31zwTcpvgETJ4aY+taz826zUng39nncVjx1k5OEHlLhTcQ+fioDTxU0NjpTPc7J1/aVLvj1Mx+HCWGYPoSciYb3e057otWOGXWogrn8JyTSl0AFZK3EoJcpwwPG0MIuTk16DHaujreQRueJ3ljNnOfrZJpD8Xn6uQ9L7JXoU6DVV3ZmORORXMUVM1vQA6nSa7BSDEv2O+1o/87G4h6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUa9PlIsrj49nWxUq/0ozrxRJxWFshVPJIWnFcV8TFU=;
 b=dlwO78htISqEEdWY/vmoJMjmHyUSCgKdUg80JyuqUbK1uX6VijFT/newfeZR9RiwjppyLfjgeCi+OrclqA/t9sQlPBOO1t9YcLW8Z72ZEYp2SWNBY5R04AYM3vPG/SdoMQ/FxkhgPOkzblDk32bK3RiJG5xnTZAfoQokPRgK3Hs=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB3893.namprd04.prod.outlook.com (52.135.214.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 08:32:00 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 08:32:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bob Liu <bob.liu@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [RFC PATCH] dm-zoned: extend the way of exposing zoned block
 device
Thread-Topic: [RFC PATCH] dm-zoned: extend the way of exposing zoned block
 device
Thread-Index: AQHVxfMPtnSx9ygQV0yw4PguyV00/g==
Date:   Tue, 4 Feb 2020 08:31:59 +0000
Message-ID: <BYAPR04MB5816821A996DC2DF7F3830A0E7030@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200108071212.27230-1-Nobody@nobody.com>
 <BYAPR04MB5816BA749332D2FC6CE3993AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <c4ba178c-f5cf-4dd1-784b-e372d6b09f62@oracle.com>
 <BYAPR04MB5816B2967735225FB37D627BE7000@BYAPR04MB5816.namprd04.prod.outlook.com>
 <bc772b99-b629-1979-7ce9-b685242b86d0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [210.160.37.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41e4ac4d-639a-4abe-d28d-08d7a94cb41b
x-ms-traffictypediagnostic: BYAPR04MB3893:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3893366455E7EFD38967C59DE7030@BYAPR04MB3893.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(53546011)(2906002)(6506007)(86362001)(7696005)(71200400001)(8676002)(8936002)(81166006)(81156014)(4326008)(54906003)(110136005)(26005)(186003)(52536014)(5660300002)(316002)(33656002)(55016002)(66446008)(76116006)(9686003)(66946007)(64756008)(66556008)(66476007)(478600001)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3893;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQ4xzug2v24m6YLOxhGLWXzZqe0+tV2fAz5F7piVHzZx/0O6d0fTZ7VRQzEHXhSjR7hBsHBNhvTgJ3Lqs+qXX22ZrcANYQRCMe4obrEMLa6eqC+aFHPQ+mcDFuu/B1XGosCITsLSZWbpGdwKVb+vjLM6vcc4jNnSuEzqcsbWxmgeA2pNKeMk+IsnvfJShahqr92i6d5S4BWaHiU+swujVadGtLDTL1pfPoUrUGQISSqUKJBn25rIAfP0UqMVNkZWlIHuJi6yXF2yPRu2IfMarJ6rRwFoAIsQjWHkQMdrYgxZL2g/Vs2FMZNfFbQemeX0yv07UX+Hnecr43qocpSe1NoryQUxe210jnKvNi7Zmwt6p8+ChxfoBSZfVnSj52cZwI8UcHQ9SG3TWiUMEfBqRc7ySFcbkL2xVL6K7B3v7ibWVbig6EKMoy4KAGu1egOe
x-ms-exchange-antispam-messagedata: EpLv3sbW7P7erMO1tUfPScP4w085b60WTFnIjhHsycmPKELoNdJnGNyCeWUBMwFT3dgfEtWt35fCmfsE+UxKwdvASvbwTDfvnC4SgY8s3meqlWmboRPAa5yRu6FcS1hphOXjcRF/qu50Zs8qf2ctQA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e4ac4d-639a-4abe-d28d-08d7a94cb41b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 08:31:59.8716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1Hhdv/a1x0T3W1Aqg+cmUu6sroB5vaA8K0MKiGwz9Mm5dW95Uix6ZqmD/Jec7POqkz1AabkBbBS4faAxRVsAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3893
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/02/04 12:57, Bob Liu wrote:=0A=
> On 2/3/20 11:06 PM, Damien Le Moal wrote:=0A=
>> On 2020/02/03 21:47, Bob Liu wrote:=0A=
>>> On 1/8/20 3:40 PM, Damien Le Moal wrote:=0A=
>>>> On 2020/01/08 16:13, Nobody wrote:=0A=
>>>>> From: Bob Liu <bob.liu@oracle.com>=0A=
>>>>>=0A=
>>>>> Motivation:=0A=
>>>>> Now the dm-zoned device mapper target exposes a zoned block device(ZB=
C) as a=0A=
>>>>> regular block device by storing metadata and buffering random writes =
in=0A=
>>>>> conventional zones.=0A=
>>>>> This way is not very flexible, there must be enough conventional zone=
s and the=0A=
>>>>> performance may be constrained.=0A=
>>>>> By putting metadata(also buffering random writes) in separated device=
 we can get=0A=
>>>>> more flexibility and potential performance improvement e.g by storing=
 metadata=0A=
>>>>> in faster device like persistent memory.=0A=
>>>>>=0A=
>>>>> This patch try to split the metadata of dm-zoned to an extra block=0A=
>>>>> device instead of zoned block device itself.=0A=
>>>>> (Buffering random writes also in the todo list.)=0A=
>>>>>=0A=
>>>>> Patch is at the very early stage, just want to receive some feedback =
about=0A=
>>>>> this extension.=0A=
>>>>> Another option is to create an new md-zoned device with separated met=
adata=0A=
>>>>> device based on md framework.=0A=
>>>>=0A=
>>>> For metadata only, it should not be hard at all to move to another=0A=
>>>> conventional zone device. It will however be a little more tricky for=
=0A=
>>>> conventional zones used for data since dm-zoned assumes that this rand=
om=0A=
>>>> write space is also zoned. Moving this space to a conventional device=
=0A=
>>>> requires implementing a zone emulation (fake zones) for the regular=0A=
>>>> drive, using a zone size that matches the size of sequential zones.=0A=
>>>>=0A=
>>>> Beyond this, dm-zoned also needs to be changed to accept partial drive=
s=0A=
>>>> and the dm core code to accept mixing of regular and zoned disks (that=
=0A=
>>>> is forbidden now).=0A=
>>>>=0A=
>>>> Another approach worth exploring is stacking dm-zoned as is on top of =
a=0A=
>>>> modified dm-linear with the ability to emulate conventional zones on t=
op=0A=
>>>> of a regular block device (you only need report zones method=0A=
>>>> implemented). =0A=
>>>=0A=
>>> Looks like the only way to do this emulation is in user space tool(dm-z=
oned-tools).=0A=
>>> Write metadata(which contains emulated zone information constructed by =
dm-zoned-tools)=0A=
>>> into regular block device.=0A=
>>=0A=
>> User space tool will indeed need some modifications to allow the new=0A=
>> format. But I would not put this as "doing the emulation" since at that=
=0A=
>> level, zones are only an information checked for alignment of metadata=
=0A=
>> space and overall capacity of the target. With a regular disk holding th=
e=0A=
>> metadata, all that needs to be done is assume that this drive is ion fac=
t=0A=
>> composed solely of conventional zones with the same size as the larger S=
RM=0A=
>> disk backend. The total set of zones "assumed" + "real zones from SMR"=
=0A=
>> consitute the set of zones that dmzadm will work with for determining th=
e=0A=
>> overall format, while currently it only uses the set of real zones.=0A=
>>=0A=
>>> It's impossible to add code to every regular block device for emulating=
 conventional zones. =0A=
>>=0A=
>> There is no need to do that. dm-zoned can emulate fake conventional zone=
s=0A=
> =0A=
> Oh, what I intend to say is it's impossible adding "BLKREPORTZONE" to reg=
ular block device driver.=0A=
> We have to construct fake zone information for regular device all by dmza=
dm, based on current information=0A=
> we can get from regular device.=0A=
=0A=
OK. We are in sync. I misunderstood you. Yes, there is no need to emulate=
=0A=
completely a zone disk at the driver level. dmzadm (and dm-zoned module)=0A=
can generate a list of fake conventional zones very easily for the regular=
=0A=
drive.=0A=
=0A=
> =0A=
> $ dmzadm --format `regular device` `real zoned device` --force =0A=
> =0A=
>> for the regular device (disk or ssd) holding the metadata. Since=0A=
>> conventional zones do not have any IO restriction nor do they need any z=
one=0A=
>> management command (no zone reset), dm-zoned only needs to create a set =
of=0A=
>> struct dm_zone for the emulated zones of the regular disk and "manually"=
=0A=
>> fill the zone information. This initialization is done in dmz_init_zones=
().=0A=
>> Some changes there to create these struct dm_zone and all the remaining=
=0A=
>> metadata and write buffering code should not need any change at all (mod=
ulo=0A=
>> the different bdev reference). Do you see the idea ?=0A=
>>=0A=
>> The only place that will need some care is sync processing as 2 devices=
=0A=
>> will need to be issued flushes instead of one. The reference to the=0A=
>> different bdev depending on the zone being accessed will need some care =
in=0A=
>> many places too, including reclaim. But dm-kcopy being used there, this=
=0A=
>> should be fairly easy.=0A=
>>=0A=
>> Adding a bdevid (an index) field to struct dm_zone, together with an arr=
ay=0A=
>> of bdev pointers in struct dmz_dev, should do the trick to simplify=0A=
>> zone-to-bdev or block-to-bdev conversions (helper functions needed for t=
hat).=0A=
>>=0A=
>> Thoughts ?=0A=
>>=0A=
> =0A=
> Thank you for all these suggestions.=0A=
> =0A=
> Regards,=0A=
> Bob=0A=
> =0A=
> =0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
