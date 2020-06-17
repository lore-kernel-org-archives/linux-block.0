Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E370C433DF
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 07:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE99320786
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 07:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cp6fFgLP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="J0rb5MOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgFQH3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:29:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15146 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgFQH3c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 03:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592378972; x=1623914972;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Oo4afJFBQ6sC+7tpYaxUQDr2S6twc+oEND6LbZQOcp8=;
  b=Cp6fFgLPCHgB3smr0DoaVLLnOTrfkE7RkaK9iJU0EuQdY+74tt9X2MDZ
   1mptM8K7n6iJA5efHNxKZsP/rxXyCMN4BCRxu0n9tylww7wUQV4/ahMho
   pDeikmaGDUu0ezK8+SsuDoWXCjDiC6oCOjbskqLIGPzxscjqWqaaYu9zs
   DlMKbhG5akGhbx8n6IIXLd4UdShh//sel6GDgHiqlxlSGuyAJn6xwr63B
   jmfm6EGUc7O6g1fZmzy1vr3vvNuGjH8dxZupYUgBKeOYubzdiclsT+nWf
   A7wBdcVMhY/SKJUYuz85tohI8Cro0NsiGlnBfiDsV9RZ3wP0I034PQBlF
   g==;
IronPort-SDR: lFWP7UonQncRbbY/bMqg9FbcYYxvrHVA4TshCmYGF9POhTV7zkaHdmwopyBe2zdNjPqNUcnTML
 ClmEs4WiDpFcXFefvi54V2PN29srf9Clgr4hHJXSatkAIpUob+Xo0wnVnebn4rwvflf4VDEfMz
 QYAbmcM1wXwnWYUx+Vqy2wdlEJU4YlwiXddQwzmR7KtZijTkIezgEFR977ph/mj/ckAfNL53PM
 Lcbyhrzgc4VvIjrY/KC36YB4m+JzVs+htCz51oRP4lJGrq6vbs65yuT85McQknp7zSeFlQrFV6
 zG8=
X-IronPort-AV: E=Sophos;i="5.73,521,1583164800"; 
   d="scan'208";a="141587512"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 15:29:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDiLhmbQeT8m/xJ86GjmZatgaWDYqkHTyTaTX+aCr7+/41wuXc1zS0FDdqstc2qxjPlQj5iLsr2tyVmAePHsMeDlQgU7z0p7RgFQ4zSTunIjEuD8NlxavTfUAIh3yOeFU4eHFxsCTQB/b9j87bbVLK2gmiR7+IFBM1/oGbujPmcPiNHTS/IidCWU5XWKiqTHhtkroXNl5fwMB8Ms4qnfH5ox45GLQ5tRFBHOXNbggiIKvmdK9BeWpEedHLvcYr7fzMR/kdB0SkbY4sZD3b/8Eh1z6D1EzzNRRm7ZXy/ukmpDsYgUWPF7jrboEwzXLXsgX+mUAyMr3dYECVZqrQtHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo4afJFBQ6sC+7tpYaxUQDr2S6twc+oEND6LbZQOcp8=;
 b=hfT2jY/FwWuoy7IzGjnWLz9Q72z5ZbOgkPYDbUSinDCEd/JwZkCsu76MrjARjU4VoGwNTj8ZMgtcDdH6PJ25kXUJxMfCBHD8NWQG/OMWtaU/2dzTBQ40awUm42Lwcl63993Nbh5qNs4OC7nYK8fEBWdR/3LXxh7Db7b+XkldK8aG2Uq7567IcC34C8md2Ke1O2+4xi++nS/jxQEbWhHOhCQwizT6YuS+bPfTwf3hP0uLUQfqbj0K1vacJus4L2PURy+UC4guqktLwqx69O3iOMWQTRH6yMZ3Ryd+28r0zdRVgSFn145QyF2Dmc1B5iwGFVm5iNDB+3pTCslyThPF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo4afJFBQ6sC+7tpYaxUQDr2S6twc+oEND6LbZQOcp8=;
 b=J0rb5MOEQH8BTTTzFdAWsEWkqhoZE8u+q3AP+8H0rJ0RVnxE+AX/4hYQiEEX64INJvPggARGjhVHx6cJqoJq84mkT0EOnuWwBz7vSSBo1NKIoNPDlaot0i0FbO4qyCMpN4E4yTwmsGhSWS/k8ZCKsGTU3Je/Rs0tyBmNlFXm3lk=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0761.namprd04.prod.outlook.com (2603:10b6:903:e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 17 Jun
 2020 07:29:29 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 07:29:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <Keith.Busch@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWQ22ncHPAnMo9ZkarXHo4UNlnAg==
Date:   Wed, 17 Jun 2020 07:29:29 +0000
Message-ID: <CY4PR04MB375134A3B37A43AD6AF07815E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
 <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616161354.q3p2vy2go6tszs67@mpHalley.localdomain>
 <CY4PR04MB37518F1A34F92049EE8FAF94E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617061814.7syifpwn5sqg5a4w@mpHalley.localdomain>
 <CY4PR04MB3751808DFE9AF00EF172DFCCE79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617071141.rfy545k2vlzkroby@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cab9b2a-090d-485a-c01a-08d812902bd1
x-ms-traffictypediagnostic: CY4PR04MB0761:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0761637E7CA78BDF9C3944D5E79A0@CY4PR04MB0761.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E6RL4nt22eTTcbrIXWY/dPq5KRSBLR07w4vXwhmrT2HesqXLllWBr+/CC6x4k1dTx+JILhwqh/ByTG0FsJhglv9BgY8GpCqnHob/FSUo1qcqPUImpWRHAWMwl0VGP/GjcvW3nfi7Kg4rm6pfW11pTIDocPaOCxSBfiMak5uMowvMoyQ0AaYBoPnSqnBOR6oiKV9jpE2JX1pXGi3T0yQ6taXoCr5b8emeRzBZvy4oeROqwAPvvgYl2yLs+4x9k7nUmXIS/WQznPc77z7tt2nIwXn5sAy6XbPekiMFMCwq3irQVy8FRwOz2NcQMfTBAAmzWWfMCs3OM4nIfBogW6yn6R3IWFvnCnpnfkI4EUwWZYQ47SSSH6ueHqFtyoj861e816wDgjmlvtUs7bi6xhPSgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(52536014)(5660300002)(6916009)(71200400001)(66574015)(33656002)(26005)(6506007)(7696005)(53546011)(54906003)(316002)(186003)(478600001)(966005)(91956017)(86362001)(4326008)(76116006)(2906002)(66446008)(64756008)(66476007)(66556008)(66946007)(8936002)(8676002)(83380400001)(9686003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1kFR/1h3nLMIPjRZH833XAI8fwBLKFpWLBHYtzYM/L3ZCUNBu8jA65X4CtPV3j2GJPUlTac33FaekaibBayIdBVH7E99Lp7qlg42j5C8LVB+DJ6g4MKZ2kUiUVstsApYgjn6MrHQi5qi/EQYeRiJDzJmoMJwjDhfem9JVBq8w0Yf/IGHLJjuCOIawlT2F+dpT40CMJkav2NttAzbjP5M4vb5igGHmKwehGXO8/n8TytzoAZZ1D23ErmYclx2CY3VznDJ4lJmqKxNLRRfoJhoz1Bu7/oivL5M3G6GYyzaSEnS4BAibcvY5IMjc2/JDeEoXgUWTTx7zVk9kBDAi87mk/AC5Ar7VO0bDV0VcmzzNo2mzYPw3fY7lGKk6pt8+OLkAR4HA21ZL2DZq1riypRGnVwrvecSSo0v4QPV9RUaVZh4NJVfGC60hudnhmdy6zVN7WVqbiN945sFRh2Mq9mhrHthrcSrtrqBlOLKtN/KUQb5jLBAwE9l5p1B0BsLKQ7g
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cab9b2a-090d-485a-c01a-08d812902bd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 07:29:29.1472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GyZwxelrxItZEKKTCLMOY5J2khBnieVJg/UnKF9LjlK+fxuG2F6VdcDnUGlxlt5yb21Dl3BCXbHNTj3gi6hAvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0761
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/17 16:11, Javier Gonz=E1lez wrote:=0A=
> On 17.06.2020 06:54, Damien Le Moal wrote:=0A=
>> On 2020/06/17 15:18, Javier Gonz=E1lez wrote:=0A=
>>> On 17.06.2020 00:38, Damien Le Moal wrote:=0A=
>>>> On 2020/06/17 1:13, Javier Gonz=E1lez wrote:=0A=
>>>>> On 16.06.2020 09:07, Keith Busch wrote:=0A=
>>>>>> On Tue, Jun 16, 2020 at 05:55:26PM +0200, Javier Gonz=E1lez wrote:=
=0A=
>>>>>>> On 16.06.2020 08:48, Keith Busch wrote:=0A=
>>>>>>>> On Tue, Jun 16, 2020 at 05:02:17PM +0200, Javier Gonz=E1lez wrote:=
=0A=
>>>>>>>>> This depends very much on how the FS / application is managing=0A=
>>>>>>>>> stripping. At the moment our main use case is enabling user-space=
=0A=
>>>>>>>>> applications submitting I/Os to raw ZNS devices through the kerne=
l.=0A=
>>>>>>>>>=0A=
>>>>>>>>> Can we enable this use case to start with?=0A=
>>>>>>>>=0A=
>>>>>>>> I think this already provides that. You can set the nsid value to=
=0A=
>>>>>>>> whatever you want in the passthrough interface, so a namespace blo=
ck=0A=
>>>>>>>> device is not required to issue I/O to a ZNS namespace from user s=
pace.=0A=
>>>>>>>=0A=
>>>>>>> Mmmmm. Problem now is that the check on the nvme driver prevents th=
e ZNS=0A=
>>>>>>> namespace from being initialized. Am I missing something?=0A=
>>>>>>=0A=
>>>>>> Hm, okay, it may not work for you. We need the driver to create at l=
east=0A=
>>>>>> one namespace so that we have tags and request_queue. If you have th=
at,=0A=
>>>>>> you can issue IO to any other attached namespace through the passthr=
ough=0A=
>>>>>> interface, but we can't assume there is an available namespace.=0A=
>>>>>=0A=
>>>>> That makes sense for now.=0A=
>>>>>=0A=
>>>>> The next step for us is to enable a passthrough on uring, making sure=
=0A=
>>>>> that I/Os do not split.=0A=
>>>>=0A=
>>>> Passthrough as in "application issues directly NVMe commands" like for=
 SG_IO=0A=
>>>> with SCSI ? Or do you mean raw block device file accesses by the appli=
cation,=0A=
>>>> meaning that the IO goes through the block IO stack as opposed to dire=
ctly going=0A=
>>>> to the driver ?=0A=
>>>>=0A=
>>>> For the latter case, I do not think it is possible to guarantee that a=
n IO will=0A=
>>>> not get split unless we are talking about single page IOs (e.g. 4K on =
X86). See=0A=
>>>> a somewhat similar request here and comments about it.=0A=
>>>>=0A=
>>>> https://www.spinics.net/lists/linux-block/msg55079.html=0A=
>>>=0A=
>>> At the moment we are doing the former, but it looks like a hack to me t=
o=0A=
>>> go directly to the NVMe driver.=0A=
>>=0A=
>> That is what the nvme driver ioctl() is for no ? An application can send=
 an NVMe=0A=
>> command directly to the driver with it. That is not a hack, but the regu=
lar way=0A=
>> of doing passthrough for NVMe, isn't it ?=0A=
> =0A=
> We have enabled it through uring to get async() passthru submission.=0A=
> Looks like a hack at the moment, but we might just send a RFC to have=0A=
> something concrete to based the discussion on.=0A=
=0A=
Yes, that would clarify things.=0A=
=0A=
>>> I was thinking that we could enable the second path by making use of=0A=
>>> chunk_sectors and limit the I/O size just as the append_max_io_size=0A=
>>> does. Is this the complete wrong way of looking at it?=0A=
>>=0A=
>> The block layer cannot limit the size of a passthrough command since the=
 command=0A=
>> is protocol specific and the block layer is a protocol independent inter=
face.=0A=
> =0A=
> Agree. This work depend in the application being aware of a max I/O size=
=0A=
> at the moment. Down the road, we will remove (or at least limit a lot)=0A=
> this constraint for ZNS devices that can eventually cache out-of-order=0A=
> I/Os.=0A=
=0A=
I/Os with a data buffer all need mapping for DMA, no matter the device=0A=
functionalities or the command being executed. With passthrough, I do not t=
hink=0A=
it is possible to have the block layer limit anything. It will likely alway=
s be=0A=
pass-or-fail. With passthrough, the application needs to understand what it=
 is=0A=
doing.=0A=
=0A=
> =0A=
>> SCSI SG does not split passthrough requests, it cannot. For passthrough=
=0A=
>> commands, the command buffer can be dma-mapped or it cannot. If mapping=
=0A=
>> succeeds, the command is issued. If it cannot, the command is failed. At=
 least,=0A=
>> that is my understanding of how the stack is working.=0A=
> =0A=
> I am not familiar with SCSI SG. This looks like how the ioctl() passthru=
=0A=
> works in NVMe, but as mentioned above, we would like to enable an=0A=
> async() passthru path.=0A=
=0A=
That is done with bsg for SCSI I believe. You may want to have a look aroun=
d=0A=
there. The SG driver used to have the write() system call mapped to "issuin=
g a=0A=
command" and read() for "getting a command result". That was removed howeve=
r.=0A=
But I think bsg has a replacement for that defunct async passthrough interf=
ace.=0A=
Not sure. I have not looked at that for a while.=0A=
=0A=
=0A=
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
