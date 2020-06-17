Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE88EC433DF
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 06:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33F2208D5
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 06:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SuR5vlvX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QAkYKp4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgFQGrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:47:41 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58188 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgFQGrk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 02:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592376460; x=1623912460;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DiccMsEWLcLrcC5JyIwRe8CqHplD9Y9iLbzyKbaLxgY=;
  b=SuR5vlvXPTOzC2MAUf9ww6h4lNZ3RR4ytwYODRXqENDwiuEUK3DhI0/9
   4pkyL+lrK3Z5D2BsUKq/8x4b+Zu/hGc3/5JkMZDKZbU6Ot8Z7HleM9phQ
   wdODjivA2EK5Hfp2K1vXa0679/WhTZypXoNc/UTdDiq8x38fghMhrK0xJ
   KERESj3qaLn2dIiA+GLrz+h04owwdxytrOi1dvh4LB9kkLlGjkjPOowi8
   zhqi/kAOwSIg9wEp//3nHdght8j8DE/sEJQDNhWSs82XUz8OF8t+wOvxl
   wfSmwvVBzqqHmVw6rndcKUQO5fj4DUet2bre1zLdSa5A8U/JpNeAHXJKK
   Q==;
IronPort-SDR: r8WjqaKHGZ2uucD62jufY8JRSGK9AQTHmuHO5uSnV/RylNTh83y4EUlZcpQniGY8E63Az/5uqU
 VnXA70LmPZP77C2NMPGy+mb4EmU6M9xtmqMx+HOUAIzZ/KoxOO5nH0/iLVT1lZK3v4PU6CVWOm
 ntdtSNWsUsZESCjuF3fuNX051bJmHUsCaihmFCwHLLyRbM3zuehq0FoAuYvFUxGYRuwcTMNgp6
 mNoAxu+f1kzpPi9P7Y4F/Yev/zQy+X9bLnd61bXJAPBA9rwon1NCdErT891tZXnpQ3lCtwy+lw
 ztc=
X-IronPort-AV: E=Sophos;i="5.73,521,1583164800"; 
   d="scan'208";a="141584792"
Received: from mail-cys01nam02lp2053.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.53])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 14:47:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP27uHcakV7pw6sji7hlRjFPE7KcLmatyDFYJcoaS1RLb8VQ7hLiFxiMkT7B1+aAhZUtpqaMzvrckkJUrUVlhTwLkq4CGiqkoXwPOFDOceH4I6kJnJngp19K+h87w7nPO8r5wqKvWPVaftuSh6pS8cpLC7TSioSLTE0Cypx/hWVfOkgdi7PP2096IM94koA3Wx2JjGfMrltpd269MtENzb9c6DTG+gxmU2zXanHVaM4tz81Y1qN+l60DRWRqdHw08qucuu0wkRE7GhmF7OWm/00GGof0ZHlFzx5i5WGhHRPryUviSc1XE8iNvPlHyWUbTGobTAbwct2ZWsw897gpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpuc+G8mbJfpFxW9StPA7rYmQpPpOGZFO2cGyVfvqlQ=;
 b=NVWGizEQdyhWnkskZEIZg5iYDTlZIvrN7tktI0GhELlhtWdbXnY+v0KTBQGWfax/Of00m2kC4Dyc+Xz9n9d+IWq3MNbgYzvQI0PGYJ5cNCIi9SUAYZFutX6fGJ1mT0fTE8WmzghWnkmwcAMIUPMeinPP9sYhIb6yDagvZWFq/zEp78Xg8GANBvW+tFk4hNIYPpjTN98aT3hHZTNIp5M/7j29wszlvm6OPAw+GFJljDvv1JcZ9trmMeiVf7au+iN+VhvMsdfAmE0QNP7Am16n7mZGf7cP6TId2CSrrei4GaVUVY2kwHAiNm6/gND/7qoSxBHpNQnV4iEA/OcqrBSlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpuc+G8mbJfpFxW9StPA7rYmQpPpOGZFO2cGyVfvqlQ=;
 b=QAkYKp4fUZ02HTS9A0Dds9GpuJx7DMdeP+lBrUpZXO5lWajgiNGx0YtP0/tqtU2Set0no+EH93QFjql0jHBZ2NbtGVq2NACJunH3BAmTp/6XZJwprd2hGfarLWogfLXyUH7pcetssvHYbyT1bonjJkdAMv+lLOTR28MaQ/NmKCY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0728.namprd04.prod.outlook.com (2603:10b6:903:e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Wed, 17 Jun
 2020 06:47:37 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 06:47:37 +0000
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
Date:   Wed, 17 Jun 2020 06:47:37 +0000
Message-ID: <CY4PR04MB375154B897296A3A4C82503DE79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <CY4PR04MB37513B2D2B7AAE343ABF14C1E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617060953.ypviiz75cua4bt25@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6718ce5e-97fa-4668-be57-08d8128a52ed
x-ms-traffictypediagnostic: CY4PR04MB0728:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB072847FA534E7EC7ACD9943EE79A0@CY4PR04MB0728.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMbT2bX2Yw977ZnjFCdMgHm9ID1DJ8ewvGVX3nqFHJ6Fph891mupTihX2jfKADQKEtHISeYqUpiJ4GjoE1ZxQzRc7fLfoecNpAkqvpg8NuzEokZBrcnZksg5s2kqDGpgn0k4T45RGB3hA6nwJlqXgUCGieCOXYlXuQU8+psAl7AzemIrz/zqFuvF1L9NiTwBjinv3t3SEGwg19fnlvogxY5KAmTza6CLn/lQ5ebDXyUzrDvr8JBxZYfW2TZ1jMG42WE5/moxTI2hnYSG/U3XSsmnzGgWbOzMbq4lLS1q4MLp/wfAc8yjOyZWNwn7grDdpso+zfZ2G1FJlxSkuQTvJ4F5+goONo8kCqGfs3kKsCKpnTlcRyXd+MsRPH3CoxMtmrP6Ebu8hSnxUxeg3msFdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(66556008)(64756008)(66446008)(86362001)(26005)(9686003)(5660300002)(186003)(76116006)(966005)(71200400001)(8936002)(66476007)(4326008)(2906002)(478600001)(66946007)(52536014)(55016002)(91956017)(33656002)(316002)(54906003)(8676002)(6506007)(53546011)(6916009)(83380400001)(66574015)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uOG+uhTw+stELk6CpihxoJ6OquAtFCYaFYZeSYRBVfmQjoWwjXpU9jnUMbqPNI1i36SF4Kwoi5obNVYSRNNrtwLEKNhA8nHQvPfFiRup9fGDZuhXPHYG8X5pG5t5oQ7ehOFI1Zd0UQJ5h0XsARN2grDICeQ2d7Si1XDehg1AUHwHTW7fwwdURyARpY6+0t8px5fn0kNpgZ2MhXKqfoTJqMo5QDayruKb9f+UKPzEhdVtgXnOU9mdXWLMq1QPqBHkRnPniQsp+8A+KesuBmOW3pz5A1O6d8+BUgl037XJb2ORcMWg6qsN30H5lvJl1Tbicea5Ewejy6tUQA02StA+uCbqU1/tvsNvKCNCop//OIyrxGjV3/MLADExt4ukmfvrcBZD/oUqUX/Y1+sfT949su24WYd93NBDuXUTzkDY6ywib8QD9o6HV6QOyger0QHEb6GAhNkKymzMXfE5rxlcEuoIuBTMXrvHiFz2VgooqFEmJPBZvvMLD4D2pqJ3ymxd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6718ce5e-97fa-4668-be57-08d8128a52ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 06:47:37.7725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FdM2guLYPLXnZmxOauBLMK+dKU1eOInW0cl90ir1SOCgwIGlRB5q7K4iU8JQsw5K8xIC1H2EvQiRzCj0EZ2QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0728
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/17 15:10, Javier Gonz=E1lez wrote:=0A=
> On 17.06.2020 00:14, Damien Le Moal wrote:=0A=
>> On 2020/06/17 0:02, Javier Gonz=E1lez wrote:=0A=
>>> On 16.06.2020 14:42, Damien Le Moal wrote:=0A=
>>>> On 2020/06/16 23:16, Javier Gonz=E1lez wrote:=0A=
>>>>> On 16.06.2020 12:35, Damien Le Moal wrote:=0A=
>>>>>> On 2020/06/16 21:24, Javier Gonz=E1lez wrote:=0A=
>>>>>>> On 16.06.2020 14:06, Matias Bj=F8rling wrote:=0A=
>>>>>>>> On 16/06/2020 14.00, Javier Gonz=E1lez wrote:=0A=
>>>>>>>>> On 16.06.2020 13:18, Matias Bj=F8rling wrote:=0A=
>>>>>>>>>> On 16/06/2020 12.41, Javier Gonz=E1lez wrote:=0A=
>>>>>>>>>>> On 16.06.2020 08:34, Keith Busch wrote:=0A=
>>>>>>>>>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set=
 defined=0A=
>>>>>>>>>>>> in NVM Express TP4053. Zoned namespaces are discovered based o=
n their=0A=
>>>>>>>>>>>> Command Set Identifier reported in the namespaces Namespace=0A=
>>>>>>>>>>>> Identification Descriptor list. A successfully discovered Zone=
d=0A=
>>>>>>>>>>>> Namespace will be registered with the block layer as a host ma=
naged=0A=
>>>>>>>>>>>> zoned block device with Zone Append command support. A namespa=
ce that=0A=
>>>>>>>>>>>> does not support append is not supported by the driver.=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>> Why are we enforcing the append command? Append is optional on =
the=0A=
>>>>>>>>>>> current ZNS specification, so we should not make this mandatory=
 in the=0A=
>>>>>>>>>>> implementation. See specifics below.=0A=
>>>>>>>>>=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> There is already general support in the kernel for the zone appe=
nd=0A=
>>>>>>>>>> command. Feel free to submit patches to emulate the support. It =
is=0A=
>>>>>>>>>> outside the scope of this patchset.=0A=
>>>>>>>>>>=0A=
>>>>>>>>>=0A=
>>>>>>>>> It is fine that the kernel supports append, but the ZNS specifica=
tion=0A=
>>>>>>>>> does not impose the implementation for append, so the driver shou=
ld not=0A=
>>>>>>>>> do that either.=0A=
>>>>>>>>>=0A=
>>>>>>>>> ZNS SSDs that choose to leave append as a non-implemented optiona=
l=0A=
>>>>>>>>> command should not rely on emulated SW support, specially when=0A=
>>>>>>>>> traditional writes work very fine for a large part of current ZNS=
 use=0A=
>>>>>>>>> cases.=0A=
>>>>>>>>>=0A=
>>>>>>>>> Please, remove this virtual constraint.=0A=
>>>>>>>>=0A=
>>>>>>>> The Zone Append command is mandatory for zoned block devices. Plea=
se=0A=
>>>>>>>> see https://lwn.net/Articles/818709/ for the background.=0A=
>>>>>>>=0A=
>>>>>>> I do not see anywhere in the block layer that append is mandatory f=
or=0A=
>>>>>>> zoned devices. Append is emulated on ZBC, but beyond that there is =
no=0A=
>>>>>>> mandatory bits. Please explain.=0A=
>>>>>>=0A=
>>>>>> This is to allow a single write IO path for all types of zoned block=
 device for=0A=
>>>>>> higher layers, e.g file systems. The on-going re-work of btrfs zone =
support for=0A=
>>>>>> instance now relies 100% on zone append being supported. That signif=
icantly=0A=
>>>>>> simplifies the file system support and more importantly remove the n=
eed for=0A=
>>>>>> locking around block allocation and BIO issuing, allowing to preserv=
e a fully=0A=
>>>>>> asynchronous write path that can include workqueues for efficient CP=
U usage of=0A=
>>>>>> things like encryption and compression. Without zone append, file sy=
stem would=0A=
>>>>>> either (1) have to reject these drives that do not support zone appe=
nd, or (2)=0A=
>>>>>> implement 2 different write IO path (slower regular write and zone a=
ppend). None=0A=
>>>>>> of these options are ideal, to say the least.=0A=
>>>>>>=0A=
>>>>>> So the approach is: mandate zone append support for ZNS devices. To =
allow other=0A=
>>>>>> ZNS drives, an emulation similar to SCSI can be implemented, with th=
at emulation=0A=
>>>>>> ideally combined to work for both types of drives if possible.=0A=
>>>>>=0A=
>>>>> Enforcing QD=3D1 becomes a problem on devices with large zones. In=0A=
>>>>> a ZNS device that has smaller zones this should not be a problem.=0A=
>>>>=0A=
>>>> Let's be precise: this is not running the drive at QD=3D1, it is "at m=
ost one=0A=
>>>> write *request* per zone". If the FS is simultaneously using multiple =
block=0A=
>>>> groups mapped to different zones, you will get a total write QD > 1, a=
nd as many=0A=
>>>> reads as you want.=0A=
>>>>=0A=
>>>>> Would you agree that it is possible to have a write path that relies =
on=0A=
>>>>> QD=3D1, where the FS / application has the responsibility for enforci=
ng=0A=
>>>>> this? Down the road this QD can be increased if the device is able to=
=0A=
>>>>> buffer the writes.=0A=
>>>>=0A=
>>>> Doing QD=3D1 per zone for writes at the FS layer, that is, at the BIO =
layer does=0A=
>>>> not work. This is because BIOs can be as large as the FS wants them to=
 be. Such=0A=
>>>> large BIO will be split into multiple requests in the block layer, res=
ulting in=0A=
>>>> more than one write per zone. That is why the zone write locking is at=
 the=0A=
>>>> scheduler level, between BIO split and request dispatch. That avoids t=
he=0A=
>>>> multiple requests fragments of a large BIO to be reordered and fail. T=
hat is=0A=
>>>> mandatory as the block layer itself can occasionally reorder requests =
and lower=0A=
>>>> levels such as AHCI HW is also notoriously good at reversing sequentia=
l=0A=
>>>> requests. For NVMe with multi-queue, the IO issuing process getting re=
scheduled=0A=
>>>> on a different CPU can result in sequential IOs being in different que=
ues, with=0A=
>>>> the likely result of an out-of-order execution. All cases are avoided =
with zone=0A=
>>>> write locking and at most one write request dispatch per zone as recom=
mended by=0A=
>>>> the ZNS specifications (ZBC and ZAC standards for SMR HDDs are silent =
on this).=0A=
>>>>=0A=
>>>=0A=
>>> I understand. I agree that the current FSs supporting ZNS follow this=
=0A=
>>> approach and it makes sense that there is a common interface that=0A=
>>> simplifies the FS implementation. See the comment below on the part I=
=0A=
>>> believe we see things differently.=0A=
>>>=0A=
>>>=0A=
>>>>> I would be OK with some FS implementations to rely on append and impo=
se=0A=
>>>>> the constraint that append has to be supported (and it would be our j=
ob=0A=
>>>>> to change that), but I would like to avoid the driver rejecting=0A=
>>>>> initializing the device because current FS implementations have=0A=
>>>>> implemented this logic.=0A=
>>>>=0A=
>>>> What is the difference between the driver rejecting drives and the FS =
rejecting=0A=
>>>> the same drives ? That has the same end result to me: an entire class =
of devices=0A=
>>>> cannot be used as desired by the user. Implementing zone append emulat=
ion avoids=0A=
>>>> the rejection entirely while still allowing the FS to have a single wr=
ite IO=0A=
>>>> path, thus simplifying the code.=0A=
>>>=0A=
>>> The difference is that users that use a raw ZNS device submitting I/O=
=0A=
>>> through the kernel would still be able to use these devices. The result=
=0A=
>>> would be that the ZNS SSD is recognized and initialized, but the FS=0A=
>>> format fails.=0A=
>>=0A=
>> I understand your point of view. Raw ZNS block device access by an appli=
cation=0A=
>> is of course a fine use case. SMR also has plenty of these.=0A=
>>=0A=
>> My point is that enabling this regular write/raw device use case should =
not=0A=
>> prevent using btrfs or other kernel components that require zone append.=
=0A=
>> Implementing zone append emulation in the NVMe/ZNS driver for devices wi=
thout=0A=
>> native support for the command enables *all* use cases without impacting=
 the use=0A=
>> case you are interested in.=0A=
>>=0A=
>> This approach is, in my opinion, far better. No one is left out and the =
user=0A=
>> gains a flexible system with different setup capabilities. The user wins=
 here.=0A=
> =0A=
> So, do you see a path where we enable the following:=0A=
> =0A=
>     1. We add the emulation layer to the NVMe driver for enabling FSs=0A=
>        that currently support zoned devices=0A=
>     2. We add a path from user-space (e.g., uring) to enable passthru=0A=
>        commands to the NVMe driver to enable a raw ZNS path from the=0A=
>        application. This path does not require the device to support=0A=
>        append. An initial limitation is that I/Os must be of < 127 bio=0A=
>        segments (same as append) to avod bio splits=0A=
>     3. As per above, the NVMe driver allows ZNS drives without append=0A=
>        support to be initialized and the check moves to the FS=0A=
>        formatting.=0A=
> =0A=
> 2 and 3. is something we have on our end. We need to rebase on top of=0A=
> the patches you guys submitted. 1. is something we can help with after=0A=
> that.=0A=
> =0A=
> Does the above make sense to you?=0A=
=0A=
Doing (1) first will give you a regular nvme namespace block device that yo=
u can=0A=
use to send passthrough commands with ioctl(). So (1) gives you (2).=0A=
=0A=
However, I do not understand what io-uring has to do with passthrough. io-u=
ring=0A=
being a block layer functionality, I do not think you can use it to send=0A=
passthrough commands to the driver. I amy be wrong though, but my understan=
ding=0A=
is that for NVMe, passthrough is either ioctl() to device file or the entir=
e=0A=
driver in user space with SPDK.=0A=
=0A=
As for (3), I do not understand your point. If you have (1), then an FS=0A=
requiring zone append will work.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
