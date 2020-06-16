Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64008C433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 14:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209EF20882
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 14:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TgdmUBQ8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FbYah9er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgFPOmc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:42:32 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28063 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgFPOma (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 10:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592318556; x=1623854556;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Yk9GJWqVSX15frRiqXt4m/xHXxZKHqdIHisxKUAdoH4=;
  b=TgdmUBQ8Ed85TYta4FPK5lp7BeMSW6omsw1+K+k3FIkzup/41SXmWo1w
   b0p4hSRfeKEV95HDq5HT3NTiP35Kjoo2JOi3jBtW8P0afCCXnL2qTTukg
   bwLaubhy0JBX/dUrGofcMIlRGGx8gzJXIsXfqTiKwal3qyu8YQL5v4rZT
   dgduWEzSsIz6ZHpNCVD8jBB/RihGHL0olWhXQbeW30tfH0dRAyBccQ2x7
   sDC9yu17JU0UsAkXe/Vc9nNhBceM1qYOCnasiF1NO8wVQswyMmFIUsUVg
   Air7oNzg6g3i5J8PFC3yPQ7sfKEdlKQ8pZ5V9zR9djdVdoZqhFKFt89n6
   A==;
IronPort-SDR: g++QtOy2ppufalfPdRJJ4BlJJKQ0BZUpiDDiJHowsWF0z/vuzUI1IAoWMYh+1gg2NedYzDf9Mb
 lc9Zxi+qgaFwWyfkMvFn875J8SS+5K5jWL2/ryMqAqLAs85F13jZFUaQ1tTkrDOS/EX8uVhdB3
 l4m2QwcTgl35zBsKUHi6dpt3yXGCvMsmoFuLV00+U1nGRvSZWRwHgGY8jzIHnGvMNW6mz+dPV3
 0Hb4+r6KNj+36rn9IrbJdSNbd0Gymr3Mr+T4WfZFKu530LVhbCC2mW9BTzbU712JwL08UP9dHL
 N34=
X-IronPort-AV: E=Sophos;i="5.73,518,1583164800"; 
   d="scan'208";a="243086624"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 22:42:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g46SEJg3ciBAF/96wxQcGlB2RB2pfWWjvnP7f4piQRAUlngvJSTXxqAVGldAlJHVHH3dG2WQcIjycTW57AAfQw9xGvQYepFUt04iznQtTHNXdMN8AtyNCiKy8PBH3y/zFUz+nvkZ4SIPfOnOusbIB5AMtmZfrGP9Mz5ZbJLE3T2wfv6Io8SuDZlJ6FYqmTPc/74yPtukSopkbfcQh4jT7HMJSEluHjL7g0jdw8SZMUADyDNmB3CQeuIMWCyTu/je/wVN3RWdo0jZeQvq+wpEnkb6G6Itd1WDwVX2H4jFWHSozY15jHsM4ImCE+8i/OgGkErQ/xK1fJEh0S0mbOIGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk9GJWqVSX15frRiqXt4m/xHXxZKHqdIHisxKUAdoH4=;
 b=cfXs8PG5luf1XungT+V2+vusDmtcI9hzyIRu59ga+SuCsEAppVPIxjVSUZ6FWBi3seY6Y8GGMAUhNQ8u32J46+O+LtxFQz5kv6JnaLheitD8zU5LoIbOy6SUIJOoJpvonSjgH72cFVA3qt5cJtSDRVbenHSwMXL7FrGJXRvLx7BtZ/qXVarYKOWepQ48EKljE/5f84sHRMrLUJIN5ouCqlSzYiLPqm8SC28YIoNSmkacj25MWU39KiuXfpy9lzfJa1YiCUoXILpz1Ci06arbBdtPQc/wAamjQGVTRWR521lPncSQ7564Hjzn1q7Bg71XJRr1k1/WMotSfa8GjP5WxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk9GJWqVSX15frRiqXt4m/xHXxZKHqdIHisxKUAdoH4=;
 b=FbYah9erlB3nR5zH2kjHR61UmbiQOwhFeiBFJmSNl1iEnqK8zFg3a3Acy8eppKSJUMVs+UOxUK6y/VyILf7qX/WbG83e6ni7R86sPhZnElKR2oPgYj3L35RErvL18Tef1nWGNILHGplM2obszw0mBhZedwEnMCVgm7bjj4HV0fE=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1033.namprd04.prod.outlook.com (2603:10b6:910:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.29; Tue, 16 Jun
 2020 14:42:27 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 14:42:26 +0000
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
Date:   Tue, 16 Jun 2020 14:42:26 +0000
Message-ID: <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23608418-0f95-4a70-3fe5-08d812037d54
x-ms-traffictypediagnostic: CY4PR04MB1033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1033B1CD6ADBC1BB8C90D627E79D0@CY4PR04MB1033.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sZ2T1zMVXnywxsVQzKiGVnVUJnX3qXpM3hvxn0KGqpLy/Ohi2BNOFwGHBQS62LDBXlbNSbB2yN7qRIpeImwat1QNMRZKZfTVc3UJw64xruWGZVa15WeCyBagit9DQUr3cKPEQFoLBXvbEsLXNx/VPPsk+8eS/dnV2KmhDP5gt74txIlfpt66BLa3G6540k6iRovHYEXZCZi1vKG8sNjXAASr461BRwZsAl8LHssYa8QiHMIbJhEskHMC3zZNAsgNxo+S+pAGItX3HofxsHacFjoGPrLr5x5+WH4WAob0A3NtlX0Jvsl7FFt5xl4uxsZfRRE665U2bTl9b4YZfofUDqYq61opREjtNfT5zHhZLgM0h4M8jRbX2sZN5FlNolZx+tLRd79Zeq6Wt1OkOtBeCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(5660300002)(9686003)(83380400001)(55016002)(66946007)(26005)(52536014)(66556008)(64756008)(6916009)(66574015)(2906002)(76116006)(186003)(91956017)(6506007)(66476007)(66446008)(53546011)(54906003)(8676002)(86362001)(8936002)(33656002)(7696005)(498600001)(966005)(4326008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: M+wCltmgoEIAVAf/0aP+X74NKFX92oXRomzK2K9YedDgK8XQJ7hYrjKHfvHk0gI/bftHHpjcd8DEr2iOMAyU7Gl9vN28fEZPBrVR8qG/Bp3/6INkmIqICy4ODZRPZz/yiSGhUivc7nRqDzk1qIhenHmtkYDR8r3x/m3xx/oSkaUkRs7PP7tKwsR/bQiXSZwjSIk8obBaX2GyWtM1qqnLv3/LjDAE9vYZwpp9Fk5TljAxpOydFQTeRcr8JWPNW5MUzLnzRx7dtkXFL5pLtzdzC1uLWXj3P/DNiTRddwJIt8kRQiIV2Yr71OJ4xrAXaN5PkwffNcGYIiUYo6yZgYCtUcgIXSY6r5WALshhFGVL4oqzM87vJQW0QEdv/XZ4X7VJfnVvcDM2UoBuOUIGZ1AOtlasMGZy/WpCcyIAUyny/1NX6ftDjvrxgtbX4x3qeCHopQOlp+nqeK46EIW3PJzshLoiWAfg0o0gjMpbpfKgCu9lGuJK4Kry5opk2BHwyHxu
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23608418-0f95-4a70-3fe5-08d812037d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 14:42:26.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RU4abKMKbQdamOmPJEoFsQOEvXVIkQKqd+otU+5Lga2RbIhmGRfYR+Y6P4OfSxnzsOC2+96PFiAmHAtxbHhfNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1033
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/16 23:16, Javier Gonz=E1lez wrote:=0A=
> On 16.06.2020 12:35, Damien Le Moal wrote:=0A=
>> On 2020/06/16 21:24, Javier Gonz=E1lez wrote:=0A=
>>> On 16.06.2020 14:06, Matias Bj=F8rling wrote:=0A=
>>>> On 16/06/2020 14.00, Javier Gonz=E1lez wrote:=0A=
>>>>> On 16.06.2020 13:18, Matias Bj=F8rling wrote:=0A=
>>>>>> On 16/06/2020 12.41, Javier Gonz=E1lez wrote:=0A=
>>>>>>> On 16.06.2020 08:34, Keith Busch wrote:=0A=
>>>>>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set def=
ined=0A=
>>>>>>>> in NVM Express TP4053. Zoned namespaces are discovered based on th=
eir=0A=
>>>>>>>> Command Set Identifier reported in the namespaces Namespace=0A=
>>>>>>>> Identification Descriptor list. A successfully discovered Zoned=0A=
>>>>>>>> Namespace will be registered with the block layer as a host manage=
d=0A=
>>>>>>>> zoned block device with Zone Append command support. A namespace t=
hat=0A=
>>>>>>>> does not support append is not supported by the driver.=0A=
>>>>>>>=0A=
>>>>>>> Why are we enforcing the append command? Append is optional on the=
=0A=
>>>>>>> current ZNS specification, so we should not make this mandatory in =
the=0A=
>>>>>>> implementation. See specifics below.=0A=
>>>>>=0A=
>>>>>>=0A=
>>>>>> There is already general support in the kernel for the zone append=
=0A=
>>>>>> command. Feel free to submit patches to emulate the support. It is=
=0A=
>>>>>> outside the scope of this patchset.=0A=
>>>>>>=0A=
>>>>>=0A=
>>>>> It is fine that the kernel supports append, but the ZNS specification=
=0A=
>>>>> does not impose the implementation for append, so the driver should n=
ot=0A=
>>>>> do that either.=0A=
>>>>>=0A=
>>>>> ZNS SSDs that choose to leave append as a non-implemented optional=0A=
>>>>> command should not rely on emulated SW support, specially when=0A=
>>>>> traditional writes work very fine for a large part of current ZNS use=
=0A=
>>>>> cases.=0A=
>>>>>=0A=
>>>>> Please, remove this virtual constraint.=0A=
>>>>=0A=
>>>> The Zone Append command is mandatory for zoned block devices. Please=
=0A=
>>>> see https://lwn.net/Articles/818709/ for the background.=0A=
>>>=0A=
>>> I do not see anywhere in the block layer that append is mandatory for=
=0A=
>>> zoned devices. Append is emulated on ZBC, but beyond that there is no=
=0A=
>>> mandatory bits. Please explain.=0A=
>>=0A=
>> This is to allow a single write IO path for all types of zoned block dev=
ice for=0A=
>> higher layers, e.g file systems. The on-going re-work of btrfs zone supp=
ort for=0A=
>> instance now relies 100% on zone append being supported. That significan=
tly=0A=
>> simplifies the file system support and more importantly remove the need =
for=0A=
>> locking around block allocation and BIO issuing, allowing to preserve a =
fully=0A=
>> asynchronous write path that can include workqueues for efficient CPU us=
age of=0A=
>> things like encryption and compression. Without zone append, file system=
 would=0A=
>> either (1) have to reject these drives that do not support zone append, =
or (2)=0A=
>> implement 2 different write IO path (slower regular write and zone appen=
d). None=0A=
>> of these options are ideal, to say the least.=0A=
>>=0A=
>> So the approach is: mandate zone append support for ZNS devices. To allo=
w other=0A=
>> ZNS drives, an emulation similar to SCSI can be implemented, with that e=
mulation=0A=
>> ideally combined to work for both types of drives if possible.=0A=
> =0A=
> Enforcing QD=3D1 becomes a problem on devices with large zones. In=0A=
> a ZNS device that has smaller zones this should not be a problem.=0A=
=0A=
Let's be precise: this is not running the drive at QD=3D1, it is "at most o=
ne=0A=
write *request* per zone". If the FS is simultaneously using multiple block=
=0A=
groups mapped to different zones, you will get a total write QD > 1, and as=
 many=0A=
reads as you want.=0A=
=0A=
> Would you agree that it is possible to have a write path that relies on=
=0A=
> QD=3D1, where the FS / application has the responsibility for enforcing=
=0A=
> this? Down the road this QD can be increased if the device is able to=0A=
> buffer the writes.=0A=
=0A=
Doing QD=3D1 per zone for writes at the FS layer, that is, at the BIO layer=
 does=0A=
not work. This is because BIOs can be as large as the FS wants them to be. =
Such=0A=
large BIO will be split into multiple requests in the block layer, resultin=
g in=0A=
more than one write per zone. That is why the zone write locking is at the=
=0A=
scheduler level, between BIO split and request dispatch. That avoids the=0A=
multiple requests fragments of a large BIO to be reordered and fail. That i=
s=0A=
mandatory as the block layer itself can occasionally reorder requests and l=
ower=0A=
levels such as AHCI HW is also notoriously good at reversing sequential=0A=
requests. For NVMe with multi-queue, the IO issuing process getting resched=
uled=0A=
on a different CPU can result in sequential IOs being in different queues, =
with=0A=
the likely result of an out-of-order execution. All cases are avoided with =
zone=0A=
write locking and at most one write request dispatch per zone as recommende=
d by=0A=
the ZNS specifications (ZBC and ZAC standards for SMR HDDs are silent on th=
is).=0A=
=0A=
> I would be OK with some FS implementations to rely on append and impose=
=0A=
> the constraint that append has to be supported (and it would be our job=
=0A=
> to change that), but I would like to avoid the driver rejecting=0A=
> initializing the device because current FS implementations have=0A=
> implemented this logic.=0A=
=0A=
What is the difference between the driver rejecting drives and the FS rejec=
ting=0A=
the same drives ? That has the same end result to me: an entire class of de=
vices=0A=
cannot be used as desired by the user. Implementing zone append emulation a=
voids=0A=
the rejection entirely while still allowing the FS to have a single write I=
O=0A=
path, thus simplifying the code.=0A=
=0A=
> We can agree that a number of initial customers will use these devices=0A=
> raw, using the in-kernel I/O path, but without a FS on top.=0A=
> =0A=
> Thoughts?=0A=
> =0A=
>> and note that=0A=
>> this emulation would require the drive to be operated with mq-deadline t=
o enable=0A=
>> zone write locking for preserving write command order. While on a HDD th=
e=0A=
>> performance penalty is minimal, it will likely be significant on a SSD.=
=0A=
> =0A=
> Exactly my concern. I do not want ZNS SSDs to be impacted by this type=0A=
> of design decision at the driver level.=0A=
=0A=
But your proposed FS level approach would end up doing the exact same thing=
 with=0A=
the same limitation and so the same potential performance impact. The block=
=0A=
layer generic approach has the advantage that we do not bother the higher l=
evels=0A=
with the implementation of in-order request dispatch guarantees. File syste=
ms=0A=
are complex enough. The less complexity is required for zone support, the b=
etter.=0A=
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
