Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CF6C433DF
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 00:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A332C207C4
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 00:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gLlXzDUq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ymrk2r62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFQAOk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:14:40 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64488 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQAOj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 20:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592352943; x=1623888943;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xEDOOS/SbyyLeKHaA0sBBG3ojEABobXNDrxtTbN/2eU=;
  b=gLlXzDUqjBv4Ez7hoKvQqj7wfOPAQMo7bcCdFyJvC93N4BGxsLiH5Lic
   zPcy+jYzeMkiYIQO/RJrkr+1fctqILVgDjkRFTPVnJ92gmZdIB9hi1GXe
   toqz45m/NXlue1dj/HYGB8AlGGo/LwChXXkz7uaba1noHViaDqs6xEG1N
   UjuR2oxK9ScIt2WCuzK88OJQGh82GWhX9uU9+nTVC2JYyLoW+aoHHNAm6
   pVd/8i9xFOoX/oCKA0Evrl7xzKdD/jBmJI/ZM8VK/oIHwkyizGwR3uHoq
   IBYU+kK5787HyFNLDuLx5NIqRSsLRZpeUAqf/7/159lDlQLvmXz4OqKeD
   Q==;
IronPort-SDR: LccTIkO5vGHTCtqjdr80PzB22w92/ENIzUqroPgqXL/l7NsJgbAXaVeRp15kWglwVtHkJJ4WIO
 W4w32vxaVjqD735EJkqs82+5iB7iGd9QsBoMaoYb/k9EJVHWL21u/qAVgK2YPKrhMulPdxDIgl
 0WDgDRemCrQUzt2cEA5jFe7ONwYo+mJQfrXpWLKYuTcVVh8R9PuGBUHkoSbsuKMjk7Hr0rGGZ2
 4F+dSAVcMzQ0G/AeX87brnsujamV43cuwZGna4kwf2kgj4uGwmDA+2uXIplmNTonBInk+vY8SD
 /T8=
X-IronPort-AV: E=Sophos;i="5.73,520,1583164800"; 
   d="scan'208";a="243125272"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 08:15:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atG9/Ztlcf8pdnQPHuUjeXff+RelSCOHW8cx/vLQx+Lt5jGnw85zmpQTXaEol568Eq7g2NFnfw7lhGJPGNaUoTeXBHm1ZSwiNucMiBZJON9zP7/vG4QB98UFMwEKlO/hDp7D9SVLRFT8DDmjsqahI4I4+e6uLzv0ZFR8kTEAY/4LwYD0Mm9YedNVpObyTOqdF2qMI7saQ9kL/8xgrydlAE0KD93gdhGj+I/Kmc3vlthtDtfWmGeTdfAn5efxICNyo919nH2ziNd3+9NDN53ZS/ZEiFFlfgPDHmEtVVg6fT1T3C7jnEeOXF5ZKgNpYX9TAaY1wjOBLl4Mt7F4mGTFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEDOOS/SbyyLeKHaA0sBBG3ojEABobXNDrxtTbN/2eU=;
 b=U9m1zia3iDEG+QCHoh5tQyuQEUq65vEZAZFI06sDoMz/hX7It2G0MulnDWHdIaL1msfq+/NeWdruQWbYuUNFoCzOawjsbPvngrBPW2xN9RKMe7BdE7KLn/EaYi7/6v1kJmo+u/SRAQw8Pzlk20UpDb+8BOPtz5gcztVmLS79VO4Ygb2ketZvmUiojkRmJ8MrxI209/OXon2BPzktG72WPUuXT1kWLd2Nv5q95m3FO6593wofBw10bmpMC8/dJjbSn1fAzM+i8LTyRUFsu9J1UF398gUR7J3KP+3VRvuNe/zvjsgFinvCpu/T0e1wdoOm15xY3PlLB3VrBAHYh5GXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEDOOS/SbyyLeKHaA0sBBG3ojEABobXNDrxtTbN/2eU=;
 b=Ymrk2r62Smod28M1Svwp/R7oVqBXZR+DP+qWQv4qjjJlAcoR0vyyXWgCGXiTZ4ZR7g4nZ+NIJlwMig4LWO/qusc+Xb7nqhchqbI6GEqZH17BgLQ4hof3Dy0rnICRUeRNDq/aYDmyd8LHlHfCxYL2ox3tnWpJxIt+eFSPZDp6Nz4=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1032.namprd04.prod.outlook.com (2603:10b6:910:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.26; Wed, 17 Jun
 2020 00:14:35 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 00:14:35 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <Keith.Busch@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWQ22ncHPAnMo9ZkarXHo4UNlnAg==
Date:   Wed, 17 Jun 2020 00:14:35 +0000
Message-ID: <CY4PR04MB37513B2D2B7AAE343ABF14C1E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3a17d33-c7c2-4993-21aa-08d812536af5
x-ms-traffictypediagnostic: CY4PR04MB1032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1032F0149503157417311896E79A0@CY4PR04MB1032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSp+p5rFzuK4KzSUMi61T2b+5Z3UgThsYTFJBdbjw0kX/PQg91m2XykGZpkoyOMsAYSKY0QKnPAwdXKUFf9sYsLeForcV12u8Ji4kN/j81lBYX607x6icLsT4Skz5JVl7XyPxjdgv8tVC9Z5ZSYA+jrET5X7yOXld/0mokT6I8yfCoX9j8TNaogiEISACb5wf7fhmhIFzF87/wqAIDhaAs1p6TamIxjYV3Cu+CZwVKXHIIpZGL9MjYh76lTGSEK94fki7ccexk3Faz/++B4Olc+EPD0t/dWBppblnTJPp/QN2gzh7FN1yEc2d0HppXRHWH+kvbAUMZBVKcGFYMHzbkKAFBxZozMtYREjVL2zXF1M1SYrPEHuYcHtGIznwohTFhXiDUzTrYb4ue5+Kkvtyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39850400004)(396003)(376002)(136003)(346002)(966005)(6916009)(55016002)(66446008)(64756008)(91956017)(76116006)(66556008)(66476007)(26005)(66946007)(8676002)(54906003)(83380400001)(9686003)(8936002)(33656002)(478600001)(6506007)(52536014)(53546011)(71200400001)(2906002)(66574015)(5660300002)(4326008)(186003)(316002)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qA9Rl/qM+rmS3CzQuzLO/R4HWdrGU7Uoka2CY8jdJ/w2b+N4b7DpqyeAE897T/gsC7FUtxPJ/184SfOrn+gOADICUofayhrse/YGq8/6BioNTIP2yp+hSydCMqPSe+9uD2OaOsfygH8laxVTuqWx2Og5EAyfEh6gxLNHUCA3HHpkvjGIOLh+8+ocJiuXoJCe6lWZUSuG+Sh6DdFORxBV62JovswIB1px/Gih/bHrCpRvAni0QyZTHRi7C/pZbFXy5fEbLz4Y6+uU7aTWuLGiNPUjNhlcQ64FBR7iYqG+z85yOAUsATlEIW4hZT0f6ndL8qgBhiIpdvwj813YEHDkLlV6W8a7mjRkNs3uszwh9np7klHK/mH6rncbc9ZsKwIF9Rv7vBQH1WciguUyY2VtMslKwxCSDz7bdFdyNwMm+c0ph7fdzNDYkYVotg58QYbzhYxkaxoNGTB4fsMweOjixlr7jJrOAQqAIJtvnEpGcQ3EbK3sbCl3qJ2bLPDpau4K
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a17d33-c7c2-4993-21aa-08d812536af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 00:14:35.7321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBuLmNDf9KTnyrSiRttAHjJzAPFjUhsIqqY56LOr30Afxy+BUPSFsPsW3OJqZ5EpjJnFYQyzngl0DleD2TwcVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1032
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/17 0:02, Javier Gonz=E1lez wrote:=0A=
> On 16.06.2020 14:42, Damien Le Moal wrote:=0A=
>> On 2020/06/16 23:16, Javier Gonz=E1lez wrote:=0A=
>>> On 16.06.2020 12:35, Damien Le Moal wrote:=0A=
>>>> On 2020/06/16 21:24, Javier Gonz=E1lez wrote:=0A=
>>>>> On 16.06.2020 14:06, Matias Bj=F8rling wrote:=0A=
>>>>>> On 16/06/2020 14.00, Javier Gonz=E1lez wrote:=0A=
>>>>>>> On 16.06.2020 13:18, Matias Bj=F8rling wrote:=0A=
>>>>>>>> On 16/06/2020 12.41, Javier Gonz=E1lez wrote:=0A=
>>>>>>>>> On 16.06.2020 08:34, Keith Busch wrote:=0A=
>>>>>>>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set d=
efined=0A=
>>>>>>>>>> in NVM Express TP4053. Zoned namespaces are discovered based on =
their=0A=
>>>>>>>>>> Command Set Identifier reported in the namespaces Namespace=0A=
>>>>>>>>>> Identification Descriptor list. A successfully discovered Zoned=
=0A=
>>>>>>>>>> Namespace will be registered with the block layer as a host mana=
ged=0A=
>>>>>>>>>> zoned block device with Zone Append command support. A namespace=
 that=0A=
>>>>>>>>>> does not support append is not supported by the driver.=0A=
>>>>>>>>>=0A=
>>>>>>>>> Why are we enforcing the append command? Append is optional on th=
e=0A=
>>>>>>>>> current ZNS specification, so we should not make this mandatory i=
n the=0A=
>>>>>>>>> implementation. See specifics below.=0A=
>>>>>>>=0A=
>>>>>>>>=0A=
>>>>>>>> There is already general support in the kernel for the zone append=
=0A=
>>>>>>>> command. Feel free to submit patches to emulate the support. It is=
=0A=
>>>>>>>> outside the scope of this patchset.=0A=
>>>>>>>>=0A=
>>>>>>>=0A=
>>>>>>> It is fine that the kernel supports append, but the ZNS specificati=
on=0A=
>>>>>>> does not impose the implementation for append, so the driver should=
 not=0A=
>>>>>>> do that either.=0A=
>>>>>>>=0A=
>>>>>>> ZNS SSDs that choose to leave append as a non-implemented optional=
=0A=
>>>>>>> command should not rely on emulated SW support, specially when=0A=
>>>>>>> traditional writes work very fine for a large part of current ZNS u=
se=0A=
>>>>>>> cases.=0A=
>>>>>>>=0A=
>>>>>>> Please, remove this virtual constraint.=0A=
>>>>>>=0A=
>>>>>> The Zone Append command is mandatory for zoned block devices. Please=
=0A=
>>>>>> see https://lwn.net/Articles/818709/ for the background.=0A=
>>>>>=0A=
>>>>> I do not see anywhere in the block layer that append is mandatory for=
=0A=
>>>>> zoned devices. Append is emulated on ZBC, but beyond that there is no=
=0A=
>>>>> mandatory bits. Please explain.=0A=
>>>>=0A=
>>>> This is to allow a single write IO path for all types of zoned block d=
evice for=0A=
>>>> higher layers, e.g file systems. The on-going re-work of btrfs zone su=
pport for=0A=
>>>> instance now relies 100% on zone append being supported. That signific=
antly=0A=
>>>> simplifies the file system support and more importantly remove the nee=
d for=0A=
>>>> locking around block allocation and BIO issuing, allowing to preserve =
a fully=0A=
>>>> asynchronous write path that can include workqueues for efficient CPU =
usage of=0A=
>>>> things like encryption and compression. Without zone append, file syst=
em would=0A=
>>>> either (1) have to reject these drives that do not support zone append=
, or (2)=0A=
>>>> implement 2 different write IO path (slower regular write and zone app=
end). None=0A=
>>>> of these options are ideal, to say the least.=0A=
>>>>=0A=
>>>> So the approach is: mandate zone append support for ZNS devices. To al=
low other=0A=
>>>> ZNS drives, an emulation similar to SCSI can be implemented, with that=
 emulation=0A=
>>>> ideally combined to work for both types of drives if possible.=0A=
>>>=0A=
>>> Enforcing QD=3D1 becomes a problem on devices with large zones. In=0A=
>>> a ZNS device that has smaller zones this should not be a problem.=0A=
>>=0A=
>> Let's be precise: this is not running the drive at QD=3D1, it is "at mos=
t one=0A=
>> write *request* per zone". If the FS is simultaneously using multiple bl=
ock=0A=
>> groups mapped to different zones, you will get a total write QD > 1, and=
 as many=0A=
>> reads as you want.=0A=
>>=0A=
>>> Would you agree that it is possible to have a write path that relies on=
=0A=
>>> QD=3D1, where the FS / application has the responsibility for enforcing=
=0A=
>>> this? Down the road this QD can be increased if the device is able to=
=0A=
>>> buffer the writes.=0A=
>>=0A=
>> Doing QD=3D1 per zone for writes at the FS layer, that is, at the BIO la=
yer does=0A=
>> not work. This is because BIOs can be as large as the FS wants them to b=
e. Such=0A=
>> large BIO will be split into multiple requests in the block layer, resul=
ting in=0A=
>> more than one write per zone. That is why the zone write locking is at t=
he=0A=
>> scheduler level, between BIO split and request dispatch. That avoids the=
=0A=
>> multiple requests fragments of a large BIO to be reordered and fail. Tha=
t is=0A=
>> mandatory as the block layer itself can occasionally reorder requests an=
d lower=0A=
>> levels such as AHCI HW is also notoriously good at reversing sequential=
=0A=
>> requests. For NVMe with multi-queue, the IO issuing process getting resc=
heduled=0A=
>> on a different CPU can result in sequential IOs being in different queue=
s, with=0A=
>> the likely result of an out-of-order execution. All cases are avoided wi=
th zone=0A=
>> write locking and at most one write request dispatch per zone as recomme=
nded by=0A=
>> the ZNS specifications (ZBC and ZAC standards for SMR HDDs are silent on=
 this).=0A=
>>=0A=
> =0A=
> I understand. I agree that the current FSs supporting ZNS follow this=0A=
> approach and it makes sense that there is a common interface that=0A=
> simplifies the FS implementation. See the comment below on the part I=0A=
> believe we see things differently.=0A=
> =0A=
> =0A=
>>> I would be OK with some FS implementations to rely on append and impose=
=0A=
>>> the constraint that append has to be supported (and it would be our job=
=0A=
>>> to change that), but I would like to avoid the driver rejecting=0A=
>>> initializing the device because current FS implementations have=0A=
>>> implemented this logic.=0A=
>>=0A=
>> What is the difference between the driver rejecting drives and the FS re=
jecting=0A=
>> the same drives ? That has the same end result to me: an entire class of=
 devices=0A=
>> cannot be used as desired by the user. Implementing zone append emulatio=
n avoids=0A=
>> the rejection entirely while still allowing the FS to have a single writ=
e IO=0A=
>> path, thus simplifying the code.=0A=
> =0A=
> The difference is that users that use a raw ZNS device submitting I/O=0A=
> through the kernel would still be able to use these devices. The result=
=0A=
> would be that the ZNS SSD is recognized and initialized, but the FS=0A=
> format fails.=0A=
=0A=
I understand your point of view. Raw ZNS block device access by an applicat=
ion=0A=
is of course a fine use case. SMR also has plenty of these.=0A=
=0A=
My point is that enabling this regular write/raw device use case should not=
=0A=
prevent using btrfs or other kernel components that require zone append.=0A=
Implementing zone append emulation in the NVMe/ZNS driver for devices witho=
ut=0A=
native support for the command enables *all* use cases without impacting th=
e use=0A=
case you are interested in.=0A=
=0A=
This approach is, in my opinion, far better. No one is left out and the use=
r=0A=
gains a flexible system with different setup capabilities. The user wins he=
re.=0A=
=0A=
> =0A=
>>=0A=
>>> We can agree that a number of initial customers will use these devices=
=0A=
>>> raw, using the in-kernel I/O path, but without a FS on top.=0A=
>>>=0A=
>>> Thoughts?=0A=
>>>=0A=
>>>> and note that=0A=
>>>> this emulation would require the drive to be operated with mq-deadline=
 to enable=0A=
>>>> zone write locking for preserving write command order. While on a HDD =
the=0A=
>>>> performance penalty is minimal, it will likely be significant on a SSD=
.=0A=
>>>=0A=
>>> Exactly my concern. I do not want ZNS SSDs to be impacted by this type=
=0A=
>>> of design decision at the driver level.=0A=
>>=0A=
>> But your proposed FS level approach would end up doing the exact same th=
ing with=0A=
>> the same limitation and so the same potential performance impact. The bl=
ock=0A=
>> layer generic approach has the advantage that we do not bother the highe=
r levels=0A=
>> with the implementation of in-order request dispatch guarantees. File sy=
stems=0A=
>> are complex enough. The less complexity is required for zone support, th=
e better.=0A=
> =0A=
> This depends very much on how the FS / application is managing=0A=
> stripping. At the moment our main use case is enabling user-space=0A=
> applications submitting I/Os to raw ZNS devices through the kernel.=0A=
> =0A=
> Can we enable this use case to start with?=0A=
=0A=
Yes, see above. Again, we should not have to choose one *or* the other. The=
 user=0A=
should be able to use both raw accesses *and* file systems that require zon=
e=0A=
append. The initial patch set enables the latter. For the former, additiona=
l=0A=
patches are needed. And the work done in SCSI already simplifies that task.=
 The=0A=
block layer is already wired to handle zone append emulation.=0A=
=0A=
> =0A=
> Thanks,=0A=
> Javier=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
