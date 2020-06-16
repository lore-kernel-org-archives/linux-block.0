Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C06C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 13:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4143206F1
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 13:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="diHTSCAz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dp4fzYxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgFPNeZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:34:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35158 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFPNeZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 09:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592314464; x=1623850464;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=W0fZtd+BaqF4aZnvEMRTSWzkON1JpLVTvjrY4msT+hU=;
  b=diHTSCAzTvWkanBbE3AdDmJB3+D6+s6hm3xdJwhVcm+SmajVdOb9jD0M
   YM45aMTiij5n0Dn8OJXlfWvpksjAMeTgmrXgr+/I1SREf/KVoHH1Gsvjp
   AtHetcFhBURgvwLTKXgorrJiKzx2eLXRzfZt6oyEJFGUSnKiUlGnAwCeM
   +N0o1MvIj03YptdZpyFC99e3nMbOhXbQOZOFg1ViqmuTNDxaRwxz0LKhI
   Kz5gxwNkULwgJLU4s/QalSvEdmWYE76xDOm3GSDNq0bJCnSSL9r+Vbw/l
   yLtzrXDskkdntlY+V4cMPgMj05tKowNK8idJAG9pyvQTsgii2DynCOxUE
   g==;
IronPort-SDR: wlOjqdPxux7EaOi0AsGaDeWA985fbhCAiXk0UaLKl2NEkZjUzfjnvnlHQYnb0AjPz2TBn5Ig0E
 0VSnp2Q/iaolFAeJl/Xfcmndo3SziYLS6avcpGsLL0VeM+fCE8ENj/os+80aci77rD5QE4wLJA
 JqCyhY4UiXzh+zz0sOmx0c5MMIHKnuHunVoL4ClX1vw2QjxCjJc58/mB3r5jmbwARO+IntN3uK
 CuyiUuCh9vTNkI22LnjfCczaUNSahZ9OSanM3LuauXv5TQh5s4MTwA+XBpbIUojy+4OnzrcXTh
 rtI=
X-IronPort-AV: E=Sophos;i="5.73,518,1583164800"; 
   d="scan'208";a="140128745"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 21:34:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Avbi5ePYTMH/r/3EKj5ZDj85arFSx/iFisYojMmDfv+DKeZ/KRXcZoqySLKxkrqQcjMbxLttJzRyk1GoTVIhsfzYqHZdSWtIpQH+6qGEX/iCKXqwCguARDE4f2gJsgAMUmQ7EYLTvf2Ysk+KWIsxSPeVGpgTf/HLXrdzSzk9nUz9fnjzJrZ1MWYpHvDShs0C/DCduWSqXpKhdB5rRV1leEV+27VHJ+3K7HKXqCzLto0jI7o8+Kwv41HaOE8w0gvIL8wnzJVTL/EHRLXVvYMdTtCetbwCWeOG6iRwUfbDY0PhjwIhr//1HqJpdnUfx0IByGoDdLddmz2jDi8/s8e4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTZ53fJwLO80YqijBqnaGAZgI4Jkko4jAf91dUdW4H0=;
 b=dxmlhqV8ziVRXglIE15mGUhQ44qI7CKMAaNCUT6nGm86Kq0xZFhi6tSUB0eolkPc5HhpSdDguXukxl8CjhcvCtKzpq1GelU0YNlrCchkdlA7CPw2j39Na4VVLEcLXiuS3D7r1IWGAYdcpPr3WGBGaX3nWd2u27AM2GS70fi0ovqqMtS/LGNUvT8NZQJH6SC17C1DAnQTDmMyfjVKeY9bCCNb20zXA9z5guQu/+QVytCwsq6hdexNJVk/9kdqqwEs2UOp2/w5hIzjbNGM0lVJN+R5ykq01Por5Hau6jDGgogi9XJsLqajnhnOrPqTLqR8ggJvlJ0dQonssxmurGyawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTZ53fJwLO80YqijBqnaGAZgI4Jkko4jAf91dUdW4H0=;
 b=dp4fzYxhh5BkyuHpqjAg+L6yeHkI3lKh1c2tSmK7oMPZ01sn9RS8APlLnNNLK4SjVuL1FDWPQfpmppyzm7zd5LpDpCfjwv9gZUOpkuPkOLVhrF6btKg35kQpYazFtkk1AQIDEt0eNSQr0zyRp2PvncW/KhSYgy1zfoi3MGbzDYo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1113.namprd04.prod.outlook.com (2603:10b6:903:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 13:34:17 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 13:34:16 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Judy Brock <judy.brock@samsung.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>
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
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWQ22ncHPAnMo9ZkarXHo4UNlnAg==
Date:   Tue, 16 Jun 2020 13:34:16 +0000
Message-ID: <CY4PR04MB375144AFBFD251740412223CE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CGME20200616130815uscas1p1be34e5fceaa548eac31fb30790a689d4@uscas1p1.samsung.com>
 <4a97bb114ece452c80f08b96d6cbc11d@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd1c9e2e-6e48-4e16-3e6d-08d811f9f782
x-ms-traffictypediagnostic: CY4PR04MB1113:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1113EA7298787EA2DAF873AAE79D0@CY4PR04MB1113.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2980CfmsLP7iS4jLTGl96LfDvjiQvBV6VHePiuPzHUOA4pfu+FL7HtT/M8y4ORhxY7aBR9CthoLvaDEKzoqVmh/FfFAXu5hYukImiqza9sfKh8KqWYy/9wRcOMwAoFRyWIvQAZ8ZMtqtUXJPk6uV/l7+vQxB3R9pIv9OdpIQNHKx/DtaXcDxUpcP87M+hzHTgwQ/ms6tr3sy0eLZ3c8VSswg4Y1dXx0UV72kuCr5jqOmOXVZNS7yvmC2V1UXfv//L3GT+HRYT0o+QCZUrDjDUjpAt6Gc5qIW3gUa23UpPTHx5PNxQ6ruelsNswBtoaEHqOQZvIMEDcbiYgL0HHfy1BbVj8NOxmoXzeF8Kdt7tl67DvtKEhwUm//C/Wt4L1po2042Z2lJdvJWF6/3Km5ViQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(71200400001)(5660300002)(33656002)(2906002)(4326008)(7696005)(8676002)(26005)(186003)(8936002)(498600001)(6506007)(86362001)(53546011)(966005)(66946007)(76116006)(9686003)(83380400001)(55016002)(66446008)(52536014)(66574015)(110136005)(66556008)(66476007)(54906003)(64756008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xbeewGPH9/ujo+pdhtNXCRSdbcD783S6Bbj7JEIR3ASRw8P1DFgEjFgVS5SzaH6gkV9txNahVw0hnJxB0FImYp6YrHosrQbjrs1IozMRhn+/FKbrHr8bgW2K/vqa8Co+LDnidWUG82efXzpWmyYAR1Jb1GuHJLf4y2I73yxDkcGTEDyb/bJ6yfSNF5sOXFWDqVVkKVLTlzlk0YYUahlJlYV9XY8C8Y700TqC1jHWmu4G6wFjlKqbDB/bbFmC0VZokTnQ9WmNiinFdYSJ0UldL2yK/X0XEnL5TxbnRW5hIgyrtHFb5+uSro+G6HJxkvlLNzILW+d4TiQVckROqOSTtsRMm0leYx/7Y8CXyu85GOhXAOKfYJRYaLTF491MJpRPFgLi5ABOdRLWhNvvWE4f2SoigmLEWDQcn7UpBBaf4cmkt5umm8qRuzpwD+7eaic7hzKcbXSgM446l6TwvCx/hFw5YeaWhyEBjrmOJDJ/8MmwEXOOmyMKMQsSkwVsmWUE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1c9e2e-6e48-4e16-3e6d-08d811f9f782
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 13:34:16.8582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73qrZwoi3tLjsipYysFZBZRqyMvEN/j/mNIIZ/ROiJcwtKk3RmpofR1THFczYfdxLGhYdrXLCvfsnyabADoZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1113
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/16 22:08, Judy Brock wrote:=0A=
> =0A=
> "The on-going re-work of btrfs zone support for instance now relies 100% =
on=0A=
> zone append being supported.... So the approach is: mandate zone append=
=0A=
> support for ZNS devices.... To allow other ZNS drives, an emulation simil=
ar=0A=
> to SCSI can be implemented, ...  While on a HDD the  performance penalty =
is=0A=
> minimal, it will likely be *significant* on a SSD."=0A=
> =0A=
> Wow. Well as I said, I don't know much about Linux but it sounds like the=
=0A=
> ongoing re-work of btrfs zone support mandating zone append should be=0A=
> revisited.=0A=
> =0A=
> The reality is there will be flavors of ZNS drives in the market that do =
not=0A=
> support Append.  As many of you know, the ZRWA technical proposal is well=
=0A=
> under-way in NVMe ZNS WG.=0A=
> =0A=
> Ensuring that the entire Linux zone support ecosystem deliberately locks=
=0A=
> these devices out / or at best consigns them to a severely=0A=
> performance-penalized path, especially given the MULTIPLE statements that=
=0A=
> have been made in the NVMe ZNS WG by multiple companies regarding the use=
=0A=
> cases for which Zone Append is an absolute disaster (not my words), seems=
=0A=
> pretty darn inappropriate.=0A=
=0A=
The software design decision is not about locking out one class of devices,=
 it=0A=
is about how to deliver high performance implementations of file systems fo=
r=0A=
drives that can actually provide that performance, e.g. SSDs. As I said,=0A=
mandating that zone append is always supported by the storage devices, eith=
er=0A=
natively or through emulation, allows such efficient, and simple, implement=
ation=0A=
of zone support at higher levels in device mapper and file system layers.=
=0A=
=0A=
Without this, the file system has to do the serialization of write commands=
=0A=
*and* protect itself against write command reordering by the block IO stack=
 as=0A=
that layer of the kernel is totally asynchronous and does not give any guar=
antee=0A=
of a particular command execution order. This complicates the file system=
=0A=
implementation significantly and so is not acceptable.=0A=
=0A=
For zoned devices, the block layer can provide *write* command execution or=
der=0A=
guarantees, similarly to what the file system would need to do. That is the=
=0A=
mq-deadline and zone write locking I was referring to. That is acceptable f=
or=0A=
SMR HDDs, but likely will have impact on SSD write performance (that needs =
to be=0A=
checked).=0A=
=0A=
Summary: what needs to be done for correctly processing sequential write=0A=
commands in Linux is the same no matter which layer implements it: writes m=
ust=0A=
be throttled to at most one write per zone. This can be done by a file syst=
em or=0A=
the block layer. Native zone append support by a drive removes all this,=0A=
simplifies the code and enables high performance. Zone append emulation in =
the=0A=
driver gives the same code simplification overall, but *may* suffer from th=
e=0A=
zone write locking penalty.=0A=
=0A=
Overall, we get code simplification at the file system layer, with only a s=
ingle=0A=
area where performance may not be optimal. Any other design choice would re=
sult=0A=
in much worse situations:=0A=
1) complex code everywhere as the file systems would have to support both=
=0A=
regular write and zone append write path to support all class of devices.=
=0A=
2) file system implementing only zone append write path end up rejecting dr=
ives=0A=
that do not have zone append native support=0A=
3) The file system layer supports only regular writes, resulting in complex=
 code=0A=
and potentially degraded write performance for *all* devices=0A=
=0A=
=0A=
=0A=
> =0A=
> =0A=
> =0A=
> =0A=
> =0A=
> -----Original Message----- From: linux-nvme=0A=
> [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Damien Le Mo=
al =0A=
> Sent: Tuesday, June 16, 2020 5:36 AM To: Javier Gonz=E1lez; Matias Bj=F8r=
ling Cc:=0A=
> Jens Axboe; Niklas Cassel; Ajay Joshi; Sagi Grimberg; Keith Busch; Dmitry=
=0A=
> Fomichev; Aravind Ramesh; linux-nvme@lists.infradead.org;=0A=
> linux-block@vger.kernel.org; Hans Holmberg; Christoph Hellwig; Matias=0A=
> Bjorling Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces=0A=
> =0A=
> On 2020/06/16 21:24, Javier Gonz=E1lez wrote:=0A=
>> On 16.06.2020 14:06, Matias Bj=F8rling wrote:=0A=
>>> On 16/06/2020 14.00, Javier Gonz=E1lez wrote:=0A=
>>>> On 16.06.2020 13:18, Matias Bj=F8rling wrote:=0A=
>>>>> On 16/06/2020 12.41, Javier Gonz=E1lez wrote:=0A=
>>>>>> On 16.06.2020 08:34, Keith Busch wrote:=0A=
>>>>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set=0A=
>>>>>>> defined in NVM Express TP4053. Zoned namespaces are discovered=0A=
>>>>>>> based on their Command Set Identifier reported in the namespaces=0A=
>>>>>>> Namespace Identification Descriptor list. A successfully=0A=
>>>>>>> discovered Zoned Namespace will be registered with the block=0A=
>>>>>>> layer as a host managed zoned block device with Zone Append=0A=
>>>>>>> command support. A namespace that does not support append is not=0A=
>>>>>>> supported by the driver.=0A=
>>>>>> =0A=
>>>>>> Why are we enforcing the append command? Append is optional on the =
=0A=
>>>>>> current ZNS specification, so we should not make this mandatory in=
=0A=
>>>>>> the implementation. See specifics below.=0A=
>>>> =0A=
>>>>> =0A=
>>>>> There is already general support in the kernel for the zone append =
=0A=
>>>>> command. Feel free to submit patches to emulate the support. It is =
=0A=
>>>>> outside the scope of this patchset.=0A=
>>>>> =0A=
>>>> =0A=
>>>> It is fine that the kernel supports append, but the ZNS specification =
=0A=
>>>> does not impose the implementation for append, so the driver should=0A=
>>>> not do that either.=0A=
>>>> =0A=
>>>> ZNS SSDs that choose to leave append as a non-implemented optional =0A=
>>>> command should not rely on emulated SW support, specially when =0A=
>>>> traditional writes work very fine for a large part of current ZNS use =
=0A=
>>>> cases.=0A=
>>>> =0A=
>>>> Please, remove this virtual constraint.=0A=
>>> =0A=
>>> The Zone Append command is mandatory for zoned block devices. Please se=
e=0A=
>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lwn.net_Articles=
_818709_&d=3DDwIFAw&c=3DJfeWlBa6VbDyTXraMENjy_b_0yKWuqQ4qY-FPhxK4x8w-TfgRBD=
yeV4hVQQBEgL2&r=3DYJM_QPk2w1CRIo5NNBXnCXGzNnmIIfG_iTRs6chBf6s&m=3D-fIHWuFYU=
2GHiTJ2FuhTBgrypPIJW0FjLUWTaK4cH9c&s=3DkkJ8bJpiTjKS9PoobDPHTf11agXKNUpcw5As=
IEyewZk&e=3D=0A=
>>> for the background.=0A=
>> =0A=
>> I do not see anywhere in the block layer that append is mandatory for zo=
ned=0A=
>> devices. Append is emulated on ZBC, but beyond that there is no mandator=
y=0A=
>> bits. Please explain.=0A=
> =0A=
> This is to allow a single write IO path for all types of zoned block devi=
ce=0A=
> for higher layers, e.g file systems. The on-going re-work of btrfs zone=
=0A=
> support for instance now relies 100% on zone append being supported. That=
=0A=
> significantly simplifies the file system support and more importantly rem=
ove=0A=
> the need for locking around block allocation and BIO issuing, allowing to=
=0A=
> preserve a fully asynchronous write path that can include workqueues for=
=0A=
> efficient CPU usage of things like encryption and compression. Without zo=
ne=0A=
> append, file system would either (1) have to reject these drives that do =
not=0A=
> support zone append, or (2) implement 2 different write IO path (slower=
=0A=
> regular write and zone append). None of these options are ideal, to say t=
he=0A=
> least.=0A=
> =0A=
> So the approach is: mandate zone append support for ZNS devices. To allow=
=0A=
> other ZNS drives, an emulation similar to SCSI can be implemented, with t=
hat=0A=
> emulation ideally combined to work for both types of drives if possible. =
And=0A=
> note that this emulation would require the drive to be operated with=0A=
> mq-deadline to enable zone write locking for preserving write command ord=
er.=0A=
> While on a HDD the performance penalty is minimal, it will likely be=0A=
> significant on a SSD.=0A=
> =0A=
>> =0A=
>>> Please submitpatches if you want to have support for ZNS devices that =
=0A=
>>> does not implement the Zone Append command. It is outside the scope of=
=0A=
>>> this patchset.=0A=
>> =0A=
>> That we will.=0A=
>> =0A=
>> =0A=
>> _______________________________________________ linux-nvme mailing list =
=0A=
>> linux-nvme@lists.infradead.org =0A=
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.or=
g_mailman_listinfo_linux-2Dnvme&d=3DDwIFAw&c=3DJfeWlBa6VbDyTXraMENjy_b_0yKW=
uqQ4qY-FPhxK4x8w-TfgRBDyeV4hVQQBEgL2&r=3DYJM_QPk2w1CRIo5NNBXnCXGzNnmIIfG_iT=
Rs6chBf6s&m=3D-fIHWuFYU2GHiTJ2FuhTBgrypPIJW0FjLUWTaK4cH9c&s=3DHeBnGkcBM5OqE=
SkW8yYYi2KtvVwbdamrbd_X5PgGKBk&e=3D=0A=
>> =0A=
>> =0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
