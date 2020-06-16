Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131BCC433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 12:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E0F2080D
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 12:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H4fEzKI9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Dw7j7YY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgFPMfu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:35:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30333 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPMft (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 08:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592310949; x=1623846949;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DHfJA+QOByrgGTlFWuaFRjUD08hIaKm7gxZDs62ia0E=;
  b=H4fEzKI9N1q74Ug870RWDlnsTFKwVxvuRLUrVO0RIySgzk0rbsmfWxLJ
   ODxl1enX9qG9rnKexLFkZtGsoXZs/DIXeFHZEhIvqHIBHk4CNRKm+Tmg+
   T848Ln6IJ1OpT3MUqufx1dUicETqarAFVv0B7IidXpafWc1WRjfjUmcI5
   Clbc8UptsFULXzmB3rWy9QvXcFgiB6rX+BDMOqK7Lb9tQEkOCmDyPJE9K
   UHgg9CP5X5nfs6WBptmmAQ2auW4Z2bH4d0B7VUuFgCkUxcrSTwcJP+BV9
   0mUPhKroy1E96yVZQl/hpzfsFqUyo+cPTgilRTFSaLObpQyojk56+N84F
   w==;
IronPort-SDR: rhMeaPpHnQH5dFBiO/GAUvy1XbDlD0uCi1O37s2y48nu0sY9JD+K6AUstniOG7orTAXY6Lombf
 IoWDPWpRDZXMWBJtbJ3IB3FdsRaEeWd30+ZbRPOZdHWPAQLoo4Fjqxqh+3tcobjP6KMNNtDJLN
 CH7vflaif6n45dH7u9H9i8E4qRn7yILNsh+Adpn7UU91xaRvtsl+hJyMnc/O3Y5vDCKrLDZPJL
 95kGED2yN2W1bZAkX1fR5Ie6+ND1kNrNINC4aVNE9junZxkvjZY6XBh9/HuAVL/LzDFwyxkjgk
 M78=
X-IronPort-AV: E=Sophos;i="5.73,518,1583164800"; 
   d="scan'208";a="140124731"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 20:35:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRTnbj1NkV2jF+eKSErrPkCl+YVhwLEFE1uIBvRQXCHjaLmAbCW2Utd9nn3EDItXxkVS7BaoV87kcfGTZlcMPEGUrUb00aCNMwig2kvtT+02e2siuirLsBEfJFZc6wDWOgvJdDPxH4YxKOgeDSndI7D67GygIV2ilnSZOopkOdd1y2NR5CjiYRf7Re+pNSHPbawnfDJouaW5DkSIBI5CFLKTnRmtov0LWH9GO9LU5H7aPf3dNiZP1Sa6TbNlDBNfE+Z0hbR4cRryUBUgDdd4LzE9DdrQiVZ2jhRoCfl4U1xApBkCUwrdzJbkSmkV4p0pWfFFbIQ0jX4optx3OCuUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHfJA+QOByrgGTlFWuaFRjUD08hIaKm7gxZDs62ia0E=;
 b=djryypoDLX9vyIaPbIzzpxeDXGRmTTxTqY81Y1P3ywi+7DVRTQOSVyk8ZeUe6sSlXik+0ItOMMsbjN4ryOFM5p1KOL5UYWdVheReIcTbHJXfYVMGMkWFUMz9LdCKcfFqDzK2OSrg7e9g1J6JV+YbZl2K7KEQdZq6Zxjca6ODaGCIHUiyKBUIwYSV2BTILmPWnJ2vtxRaiLmNHGT0Y8DpB4QeXf84WrqcOrwknbFrqMUB7N0d+aEMS900vCosrP6+PvT9vuqW7ZbtMp0rNhP8E8QhoKNukfN2u2GyqvfTXzANdQ+vGw2CF2m6A+yAkv8eT5DGwQt+7IIwC/YYye0a+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHfJA+QOByrgGTlFWuaFRjUD08hIaKm7gxZDs62ia0E=;
 b=Dw7j7YY7aDycik0udnXJPkU0FtdM8fkLrHFNUrfWRHH8K/vLQas0Su3wDk5I5vFwwRVBG/EzXwqCP7wHxbhTawfnjyOxLe9e9Y2+t86BIZYxfxk1BlKtTbr8HNpQLqCVGJ5GhZ7ZUCM6+lICcaU+uitTqFB8Q0JKYPxYwUctoSo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0246.namprd04.prod.outlook.com (2603:10b6:903:38::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 12:35:46 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 12:35:46 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
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
Date:   Tue, 16 Jun 2020 12:35:46 +0000
Message-ID: <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 870f9c0d-184f-467c-b905-08d811f1cb2d
x-ms-traffictypediagnostic: CY4PR04MB0246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB02461909885AF22E4ABB9BF1E79D0@CY4PR04MB0246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4BkSQqB24HxlRDUeHXgiZ9vEjvFOZRdpjtxfP3InBeIkyavii6RagJsGWgjQ8yQ0Q3ShYjgtjNzM2EQjuKK7JwqFfoaKbxoHZtCvN/ir+E1x4Daw7JvSomWb6noZmzf7wTlEyH/kzi0Lb1fMTxH5ystWBCKMwg+dFS71wS3oQzKMSkJGDtoRlA7ydcdOvViax5MhS2Op6d4dHNLgU9gQTR0MftO89zo1nTHMJbtVhOCQbuAB+MgU4wLczX78UCY79+pw/q4jTSRTg0QYnrcw3sN+/PfOI7sMl0S+TkvgUvSkvSBhtSO9tkxjxF8p+BLAdWGOUZwsMZZQPmXrLydICNJLr6g6s62cUkhlmKkvQ82Eshl64w6Dqc9EU1UqkhadYXvlYvxFVSGlmqUJ3xrnwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(86362001)(54906003)(2906002)(6506007)(66946007)(53546011)(66556008)(55016002)(8676002)(76116006)(52536014)(91956017)(64756008)(66476007)(110136005)(66446008)(9686003)(8936002)(71200400001)(966005)(186003)(7696005)(5660300002)(33656002)(498600001)(66574015)(83380400001)(26005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gV0wUAcR0k4ywNaRMSMPluTnu1RQswTV72NMoAij8CmYA28MdLiC/A0xJwxL182gkuQWPcv9el3mhR2Pzpqs3z4d4umE6mCwUt8PX6WcEPc7yOKrbENEIQ10gDJK78Zjjv4LFRPVqNcuGlIF3tNuji9zb7BwUwnsdz6NzN0lXH1OCEKhB3iRDIlZr/Eni1TfiR66/LsI1T0oKhOD9oxU+sLlVkrh+JhlBQ5OKe78v0i0qV9MJuYDzPzUsTkd08tKJMDrQ9Ax1wLfz5aonKLQYjQmmrM/qVsyrx0YKRK1nQS9TsD+d2wR9Bz/iL9kG3x0Ui5xpBgDsjPLcssUm3dly0jHno6VRzvyhsMj4EojyitErBXFPJ11FX0CNJWLnV1jMCuhmOxyddlnYVxjMR0nZL2n5wLaNbg0rClCHrDS8flQdB71q0ZS18XwZxzHJP/xM8vK+12oJCM/euV9JWI77AD6yUelJm/wXQir1QnVr5FgpeFri+tI4x7UCaIzHPFx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870f9c0d-184f-467c-b905-08d811f1cb2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 12:35:46.5057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXUqY8rYgpoCDeP/in1ZYpOCAsvZNnVJamqoA2KymDeUys8Zh6uggLI+cywCvtsRLiGYuaRR4naZYXuqN40+Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0246
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/16 21:24, Javier Gonz=E1lez wrote:=0A=
> On 16.06.2020 14:06, Matias Bj=F8rling wrote:=0A=
>> On 16/06/2020 14.00, Javier Gonz=E1lez wrote:=0A=
>>> On 16.06.2020 13:18, Matias Bj=F8rling wrote:=0A=
>>>> On 16/06/2020 12.41, Javier Gonz=E1lez wrote:=0A=
>>>>> On 16.06.2020 08:34, Keith Busch wrote:=0A=
>>>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set defin=
ed=0A=
>>>>>> in NVM Express TP4053. Zoned namespaces are discovered based on thei=
r=0A=
>>>>>> Command Set Identifier reported in the namespaces Namespace=0A=
>>>>>> Identification Descriptor list. A successfully discovered Zoned=0A=
>>>>>> Namespace will be registered with the block layer as a host managed=
=0A=
>>>>>> zoned block device with Zone Append command support. A namespace tha=
t=0A=
>>>>>> does not support append is not supported by the driver.=0A=
>>>>>=0A=
>>>>> Why are we enforcing the append command? Append is optional on the=0A=
>>>>> current ZNS specification, so we should not make this mandatory in th=
e=0A=
>>>>> implementation. See specifics below.=0A=
>>>=0A=
>>>>=0A=
>>>> There is already general support in the kernel for the zone append =0A=
>>>> command. Feel free to submit patches to emulate the support. It is =0A=
>>>> outside the scope of this patchset.=0A=
>>>>=0A=
>>>=0A=
>>> It is fine that the kernel supports append, but the ZNS specification=
=0A=
>>> does not impose the implementation for append, so the driver should not=
=0A=
>>> do that either.=0A=
>>>=0A=
>>> ZNS SSDs that choose to leave append as a non-implemented optional=0A=
>>> command should not rely on emulated SW support, specially when=0A=
>>> traditional writes work very fine for a large part of current ZNS use=
=0A=
>>> cases.=0A=
>>>=0A=
>>> Please, remove this virtual constraint.=0A=
>>=0A=
>> The Zone Append command is mandatory for zoned block devices. Please =0A=
>> see https://lwn.net/Articles/818709/ for the background.=0A=
> =0A=
> I do not see anywhere in the block layer that append is mandatory for=0A=
> zoned devices. Append is emulated on ZBC, but beyond that there is no=0A=
> mandatory bits. Please explain.=0A=
=0A=
This is to allow a single write IO path for all types of zoned block device=
 for=0A=
higher layers, e.g file systems. The on-going re-work of btrfs zone support=
 for=0A=
instance now relies 100% on zone append being supported. That significantly=
=0A=
simplifies the file system support and more importantly remove the need for=
=0A=
locking around block allocation and BIO issuing, allowing to preserve a ful=
ly=0A=
asynchronous write path that can include workqueues for efficient CPU usage=
 of=0A=
things like encryption and compression. Without zone append, file system wo=
uld=0A=
either (1) have to reject these drives that do not support zone append, or =
(2)=0A=
implement 2 different write IO path (slower regular write and zone append).=
 None=0A=
of these options are ideal, to say the least.=0A=
=0A=
So the approach is: mandate zone append support for ZNS devices. To allow o=
ther=0A=
ZNS drives, an emulation similar to SCSI can be implemented, with that emul=
ation=0A=
ideally combined to work for both types of drives if possible. And note tha=
t=0A=
this emulation would require the drive to be operated with mq-deadline to e=
nable=0A=
zone write locking for preserving write command order. While on a HDD the=
=0A=
performance penalty is minimal, it will likely be significant on a SSD.=0A=
=0A=
> =0A=
>> Please submitpatches if you want to have support for ZNS devices that=0A=
>> does not implement the Zone Append command. It is outside the scope=0A=
>> of this patchset.=0A=
> =0A=
> That we will.=0A=
> =0A=
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
