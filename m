Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A4C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 06:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237222080D
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 06:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KLp3za05";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rFwW6c/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgFQGyd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:54:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26844 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgFQGyd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 02:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592376872; x=1623912872;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XIqut5heZevk6Dg7Q61DXeD0Jr0FS7FB9wAIsvXqB6I=;
  b=KLp3za05EPJvzoMKcPo8bPqlj2im26xS7Hsm9uctETA/l0KmFwwv1bzo
   IKXcf1iXaqrKtLa8SIWPmTMaKz6KW/iQ04EMGjBA4iFp2evn51Qtt9pHe
   lkWpGh/G8jW5VY0Te7QJgXTmI6abYZUXkwYkK5H3/Rm7CAOLcsah+wyMM
   oP/OcGJaH3SIRRJpJDNTdVaEdohtJ9rXgsM+wZ24MiNXbFS9wsGJGkoeK
   Lf2TWWsEE8pXa2qKDy/k+sIXjbn4yxcJ+41oEFUcCAGcUVbRYy1a54Wxb
   gy4YUJO1auaS+vPKM1SQrn2dGROD1PDexHnbjCmfqXyyliSqlDhljBVxg
   g==;
IronPort-SDR: IoHUxdRuYsfhkrwsjs4a5qpUUumwkwIzOPwId3EjujUTa98+sWNxJogX5UmNMGoDQdqb5XkbzH
 g6FKgm8+yExYYQgw+61WlRC+H/9pXXpkCykYpwUP+jfCsRIYXyfBU+8AU3GVkL1i91Sy6o9gHQ
 qSglN1GipGgvzm34PbrL7qRnlnAIFObhaj+BRGnNcfpdup/qiAYPwMvqByOzCtWzq266Js2AOh
 z5fkbghkPeQHSyj21j/PdBNTgPIFN4AQp4aNwzHLhyvmJdCCoRqJbGw0WcTgEFoq4qIGBeJb6J
 lyo=
X-IronPort-AV: E=Sophos;i="5.73,521,1583164800"; 
   d="scan'208";a="144516732"
Received: from mail-cys01nam02lp2052.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.52])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 14:54:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYPY3zzIEWfUxx/yGti4nk6zCHwGyMTtdaPCmSZrUoQUhPuQwuhPb1t3AkEgvQthdC+zTFzkB1zGvijGPi8BOciNpabc5rXcCA21VkDJu1DMvdahC5oLHocA2j+RT9mQouNyoqNExmwYQL0PL7+/+5GIafQgmMVnDTsLFJOAZVa770yS+9AxIU0iKaDag4Qp/iZgwjz5awNoeqqmabQXT+lRnjF2+nVilHL7k9gLNa+Vc3XDLZOGU+3I/L5eL9Rf//EDERAIDw3zS2Uj8b7ktK9h95+37PgtOc3GnEdz8lOWkKcO9rdDMS0qIMQmbp0SkzttZcrzVf4JAU+0bMyw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIqut5heZevk6Dg7Q61DXeD0Jr0FS7FB9wAIsvXqB6I=;
 b=dVrAMzpWOV7jIHygfabISPdm6uhMKjd00B4l8+cU5nZQRgwLFT5fkuOaBpzueQPpIKHt2S98+YRn0HgWPhLd1p+5NCQ6Mj8WwqLwEtV8wUzi9qA7y6OAXI6sjFfxkvw6Tapwnh9DONOcJWRMen8Sj6eRUlRNv9ATA8pfRG0gPjblHhlCa9c0FXb4pDHqg2nIXEvm/jYN6TFTSkbdHFdeFLcyjMFpueRHPT4kIrpu46oRw+Nhf5JDoZkhKVFbJG+0/3XoW3nnYPm9fQ9WsVTCatpc+F2/10akkVewtB/vqGH3tpDBJ4z27G5j3qrj//2iajmLGCLHnhVwB6aJvJuD6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIqut5heZevk6Dg7Q61DXeD0Jr0FS7FB9wAIsvXqB6I=;
 b=rFwW6c/8Wugbg7Kfr1btVvCXyVfQZqbnwv3nq0wMAaLfuM8qPAbtqJVESqTaAK/ZX3QPjDxIPHeOvNVvgwzJW2ToQ07As6LPxeZMvhSd+zWZdvTyLsx5If3Ssn27u3zLsY2FDNrSAkYzhnJwxbBUw2xPy1+IKpk+lf2eblocUWs=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 17 Jun
 2020 06:54:29 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 06:54:29 +0000
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
Date:   Wed, 17 Jun 2020 06:54:29 +0000
Message-ID: <CY4PR04MB3751808DFE9AF00EF172DFCCE79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
 <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616161354.q3p2vy2go6tszs67@mpHalley.localdomain>
 <CY4PR04MB37518F1A34F92049EE8FAF94E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617061814.7syifpwn5sqg5a4w@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e16e900b-2d81-4913-26c0-08d8128b4866
x-ms-traffictypediagnostic: CY4PR04MB0968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0968E3171600091DA74C26CFE79A0@CY4PR04MB0968.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkAM3Eet+I0lRGb/N2JSAEhRg+qYQq1ekLYpZtW/kjqtbR704JecihPfbO/oPG7tYKPDaS4aWZ3/MmoCimUX6KVrq4/sfn9NFz9GjZlDEWpz3aTB3khgVnz3I20H+MUzU77AuDPOfoFQ9qkJnUmaaCekiD8GjIm5rtPU/dx80NIOv7IVnNyjNVXWm9o2q2634Mdm8+iP1hwCknPwE8FIEoy1rRsj4ZtNxDrsNlQLQ8H4QlgbXAPpAtP0LW+jTZa6ScEizux368MwGO4ZxZKTcR6Or8QN9PtXesGnViSA+OXkFKPo70D6GE8rIKKrRUJgjrcuEfAxKYfu2hdGormajfBToB84wHB6DnzGcKtcLMhf9/hbkG/VHDZLmh6eG2jgv0RfijwlFFU9IxfC6oI0tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(5660300002)(64756008)(6916009)(186003)(66476007)(76116006)(8936002)(66946007)(66556008)(54906003)(8676002)(26005)(66446008)(66574015)(4326008)(33656002)(316002)(966005)(91956017)(478600001)(2906002)(71200400001)(9686003)(7696005)(52536014)(86362001)(83380400001)(6506007)(53546011)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /VW4wuxyl/EZvZvkhJegTBPcdiqHxlYUDHTI/lRbuCExcMjSMMdlBecITyDzHNQlO6QASArZ+3ZdE1fL1n/3ce2wBg5d3rR+SNAhjACdUKuhNL/U8Ckh7NHeGNGQIrI4BKV5OM0wsUiMPwRtssci22huf3lvRlUCuIrY5/7HhN+6xSJBpnL8MhBLtuRXVqAWT/59XXQ+dV6uhc0xG4pYPEvJG3vjNSBWsaHkqbPQ0C0W+3lBGmyl4XfTsOTXRWUoM75cPqnS7HOm7E2SmRn+vnOxg3nHZ7D6JbypEiC64qx2HJXSZFdgE4+54VpYxAlHC7fdiLTiKMWgQjZFtv4bPoJAaDPDdQWedcSkecp0L3oT/Jb9//hwaCx3ZBH/s+NNv27lpO6Hh9KwSu6PWGrHRn+wkxuKjizwYjgewHnngeyTgui223Qx4LCWdU0spE2FUrHwc1Ae6jatUXAPFuotc5ly6Sjpwmi2M8cVlAyJRZgSROKQ8z0a2B7MX3gfzmKY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16e900b-2d81-4913-26c0-08d8128b4866
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 06:54:29.6423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /300dF3PdUWHE6xA2b4UK0PAeo6YJHbINJpWk8Gjfy2kJGx6HSm3nPSJ+BXPmE9wqeK0rVKgqNaWnJCdAPwHsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0968
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/17 15:18, Javier Gonz=E1lez wrote:=0A=
> On 17.06.2020 00:38, Damien Le Moal wrote:=0A=
>> On 2020/06/17 1:13, Javier Gonz=E1lez wrote:=0A=
>>> On 16.06.2020 09:07, Keith Busch wrote:=0A=
>>>> On Tue, Jun 16, 2020 at 05:55:26PM +0200, Javier Gonz=E1lez wrote:=0A=
>>>>> On 16.06.2020 08:48, Keith Busch wrote:=0A=
>>>>>> On Tue, Jun 16, 2020 at 05:02:17PM +0200, Javier Gonz=E1lez wrote:=
=0A=
>>>>>>> This depends very much on how the FS / application is managing=0A=
>>>>>>> stripping. At the moment our main use case is enabling user-space=
=0A=
>>>>>>> applications submitting I/Os to raw ZNS devices through the kernel.=
=0A=
>>>>>>>=0A=
>>>>>>> Can we enable this use case to start with?=0A=
>>>>>>=0A=
>>>>>> I think this already provides that. You can set the nsid value to=0A=
>>>>>> whatever you want in the passthrough interface, so a namespace block=
=0A=
>>>>>> device is not required to issue I/O to a ZNS namespace from user spa=
ce.=0A=
>>>>>=0A=
>>>>> Mmmmm. Problem now is that the check on the nvme driver prevents the =
ZNS=0A=
>>>>> namespace from being initialized. Am I missing something?=0A=
>>>>=0A=
>>>> Hm, okay, it may not work for you. We need the driver to create at lea=
st=0A=
>>>> one namespace so that we have tags and request_queue. If you have that=
,=0A=
>>>> you can issue IO to any other attached namespace through the passthrou=
gh=0A=
>>>> interface, but we can't assume there is an available namespace.=0A=
>>>=0A=
>>> That makes sense for now.=0A=
>>>=0A=
>>> The next step for us is to enable a passthrough on uring, making sure=
=0A=
>>> that I/Os do not split.=0A=
>>=0A=
>> Passthrough as in "application issues directly NVMe commands" like for S=
G_IO=0A=
>> with SCSI ? Or do you mean raw block device file accesses by the applica=
tion,=0A=
>> meaning that the IO goes through the block IO stack as opposed to direct=
ly going=0A=
>> to the driver ?=0A=
>>=0A=
>> For the latter case, I do not think it is possible to guarantee that an =
IO will=0A=
>> not get split unless we are talking about single page IOs (e.g. 4K on X8=
6). See=0A=
>> a somewhat similar request here and comments about it.=0A=
>>=0A=
>> https://www.spinics.net/lists/linux-block/msg55079.html=0A=
> =0A=
> At the moment we are doing the former, but it looks like a hack to me to=
=0A=
> go directly to the NVMe driver.=0A=
=0A=
That is what the nvme driver ioctl() is for no ? An application can send an=
 NVMe=0A=
command directly to the driver with it. That is not a hack, but the regular=
 way=0A=
of doing passthrough for NVMe, isn't it ?=0A=
=0A=
> I was thinking that we could enable the second path by making use of=0A=
> chunk_sectors and limit the I/O size just as the append_max_io_size=0A=
> does. Is this the complete wrong way of looking at it?=0A=
=0A=
The block layer cannot limit the size of a passthrough command since the co=
mmand=0A=
is protocol specific and the block layer is a protocol independent interfac=
e.=0A=
SCSI SG does not split passthrough requests, it cannot. For passthrough=0A=
commands, the command buffer can be dma-mapped or it cannot. If mapping=0A=
succeeds, the command is issued. If it cannot, the command is failed. At le=
ast,=0A=
that is my understanding of how the stack is working.=0A=
=0A=
> =0A=
> Thanks,=0A=
> Javier=0A=
> =0A=
> _______________________________________________=0A=
> linux-nvme mailing list=0A=
> linux-nvme@lists.infradead.org=0A=
> http://lists.infradead.org/mailman/listinfo/linux-nvme=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
