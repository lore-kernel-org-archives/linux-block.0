Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1862FA373D
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 01:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiJYBxy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJYBxw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 21:53:52 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630025FD2
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 18:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666662831; x=1698198831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=soZBHdOTLbFMeuTnKg2s+iYVTgO2QV8Q0b2VomM898I=;
  b=BaQsIObWnEOQKO+RXiFWRpzFxKOwESiIj3yucPCErPZzNGF3IJqmZbyI
   wjsvz44ExqKhBKHykMX3fPQwmS9JhYK3Z5CKPEYBu6ApZ1hmrhsEJpOjn
   qISiDwwAupjVIZWJhFWT2s3lWgkt8y9HOLMbZ4fCykVq61fCnOq5uogzo
   LsIFcRs8fXXz2jCDrJZqcWRdYU6shbEzCEUC2c2UT6UxvfHo6YSJfL3mF
   Cd1MGeKNW3+f6tN1XDzuCjyDpR3T4V68Vj1dDdMHXz9rkGXW/GACMmjSs
   WvWgNSvHvZM87IR6LA1oJTO/HgdSJrWpVVpGRh1qsT+Afsl5VKjeKnx6m
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,210,1661788800"; 
   d="scan'208";a="326754385"
Received: from mail-mw2nam04lp2174.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2022 09:53:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYVq7E+9C6JX9Kb6mg+qQL6JMbTFUGKcvkAtFMWWvHZ5MH0LTDcZiK+/clQ8WdLa+IV7yF9m69h6vxUV38ZPuE9lt79/wceBFUqMNop8p1mJPMKJOazh0mG5FUxLic0HTt+zB+eIFQld9LkTHf20JHghzbb5+4sUvvBNUcT96TyZuDir0k6BZoH87U+Mqke8pgXGnanhkljJ8M6tVbysZZ1n71gqj2dQezE2dTWeGh+GG93HV4qGhCoIbJFIrs71xvbzHg0hszG7Wp2cwErPHd7djKIqvcjzw8Dftlg64z4U14EqllU8MSyzqkYnJ5n1OSpJbCic5PO2rAV69Smm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZfWPSfUsBnUVPc2BhTBsSZ5K1UihKx4QYAEFHS1qPg=;
 b=POB/eNdeR0P9jFgzN2KwmQW+bkEpwqEzU3TJJKx5/VMmfcxAotdN8JwTa4Z1aBe7yESuXw2fjV1PlH8ohlcE/Q1+Dzl+LcFGUAmlopcw/ByiCmvz8RgoC1JUKauhhm6dSxeHienuL1c4UWYIEL1U1w0SyLFXX8OKBUWfCPxJ3hst/O7Eo2FgVFJqBTnFOzbTejskMaCqqUQ3Q9TtrXPDkyXJ91mF17FhpiHaUf+LxQAxygHhngBclscFl4YfNNKoUpp/QTb+cg5Dp1CZECWTOZGUdsUyl9Fkup+or3KNtmA+S0zVBqGYmeDSd4ni+eTZ95dM/UDps2EQHjbhV4+LYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZfWPSfUsBnUVPc2BhTBsSZ5K1UihKx4QYAEFHS1qPg=;
 b=QPnFVAANOi6kjf1THs7YF6by+/X6v0ufJZGStjD4nGXlP86d8LOpk8nplh9j1celG52lr0anA0wpza++XjgzpdrtEa80yyiQY+WY7rzCAJwKDHmZa9S86NtjnzoemJktL+GZCdzhI9xRWb4uikY5g5r0pfcPkdCat/NVfEZLoZI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB5860.namprd04.prod.outlook.com (2603:10b6:408:a4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Tue, 25 Oct 2022 01:53:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 01:53:47 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Yi Zhang <yi.zhang@redhat.com>, Eric Sandeen <sandeen@sandeen.net>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Topic: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Index: AQHY43l6J1B4S//4t0qObxFCSR9tRq4VPZSAgACG/YCAAFOEAIACd3OAgADVjYCAACWRAIAClmaAgACdFwCAAZAogIAAE/+A
Date:   Tue, 25 Oct 2022 01:53:47 +0000
Message-ID: <20221025015347.yue2qkawlgfmb6v2@shindev>
References: <20221019051244.810755-1-yi.zhang@redhat.com>
 <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
 <306b38d1-3098-91e0-9ddc-f4a8660fa386@sandeen.net>
 <d3688d8d-bcf7-9cbf-7c99-74cb1a05a9dc@nvidia.com>
 <20221021085809.zkzw23ewnv6ul3b4@shindev>
 <0f2957e1-2b05-73ec-85b1-91cb643ccb54@nvidia.com>
 <20221021235656.fxl7k4x3zjbbaiul@shindev>
 <CAHj4cs-Vx0+QBF5cSNh4iHEhPao8iJ2gtfE_W7XHKwUh6eFNPg@mail.gmail.com>
 <20221024005000.givqygw4jyjzjp7q@shindev>
 <be4f5e32-7a7f-7b83-b36f-eb3eb5b464b6@nvidia.com>
In-Reply-To: <be4f5e32-7a7f-7b83-b36f-eb3eb5b464b6@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN8PR04MB5860:EE_
x-ms-office365-filtering-correlation-id: 4e0a89cc-d008-4b40-c052-08dab62bc1dc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4DF6jA+o9VrTNitEyDRZ9CznNTaTdrwaHJMNIouw345462mKk+yndht9n1u/0TCZpLvvOfnop7iZuM6xB9hF4D2ihscsNaSpHTmiTYg0XwIF/XtTi0B6hfxIvKfZXaT9fLrl5gmnjhALqQmFZFzsvnQGXUavvu0kgverC2jO5Vxq2xtjaL4UV+/nsLEUx/v6s9mf2FX8Lg8O8CCZ+XBksFgEYdnNcXC0xCKruwXyoZhgRH6vqaF2mQFro6FgJvaSlH0utAK2nCUn2OM5rPIOd6xI1qN4bjidHBdTnlEiXMMyLNjW61LSGuDnRBawWFeA/WY6WdRvq7Li/77MpfiSAw0l+r33igvvbpemu+k0srBSppoMlIFWO65bj0YYPmS1nKkLU088UA3/XsmPOAI1Df2xTWbcGdd+IwYNPiHhUI6JjEwhW+SahaMKrAI5j16P0CFBcV2ij7jabmu38yq3Zn2kjWgOHVAUx/ZUIX4cMmMipJ8+0spkS6joEZOud9QTkzS8oSo3iRn1RdH6//HTv4ehGWymUvOcGV9RQH0owWocTXe4lJNAvmCqKFBvu5r14Yr7mTyiFaTNCflbBnKcs6waz8IvE5XkpnYmiYzfC+ch7Eq/pnOr2LVfG1MgRbx77/G47MvoRy63csQDtaEnr3NSzNYG0442rwgKZHYPNDOpLEqxeExfJeHIICt4yWfqav6v2xTS2oFlfX1U93/QrDzdFeEqV3SVtaTUQ3bpnpqHsFEujP49vk5w7MC+UTujPt7RGymm+NLM5Uwm8WqKud2gI8qNNOKvmY9GKj7RNE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(54906003)(66556008)(38100700002)(66899015)(33716001)(5660300002)(83380400001)(6916009)(316002)(82960400001)(6486002)(478600001)(8676002)(71200400001)(122000001)(966005)(86362001)(44832011)(38070700005)(1076003)(76116006)(41300700001)(66946007)(64756008)(8936002)(2906002)(4326008)(186003)(66476007)(66446008)(53546011)(6506007)(91956017)(26005)(6512007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uyLJoeX9rJw/6mvR9Cs0B+Yfwyq073khzfFFS6EkB6OPh1YVryxLFj6dxXra?=
 =?us-ascii?Q?hiQhxxt3cZ3STW0TuONHxeFohFPqr23oEnrYQTQDk2OqSpiAqyYt7b22muPn?=
 =?us-ascii?Q?5GLqKAIsR83UUscKqkmS5sd/e9u+WMabm1bjJTXEkCW3FTEyLJy3l4HXomoM?=
 =?us-ascii?Q?6885G43shV9ElIQ6EKOb3AVS383aSAKbzHT2TO8CzanXih5kpgWlm/762KCc?=
 =?us-ascii?Q?2ftiNyc4MRJG/tNGCmH4J72QZ5rWaqW4uhK1Z5+5ksmV9lAQG1HegCICyuju?=
 =?us-ascii?Q?fQDm2AjLwvagI9LnIoP/aPg6Y6B411oLX1kYmwk1cxg8IJe+cLfOtg0z5fWe?=
 =?us-ascii?Q?jrDqL1m765Ae0hm03JmPgoDrgqXofY1DRmUSdR089fNV7Tz6z9lvalGWumXw?=
 =?us-ascii?Q?gJLCPesCpgcsTfYsNFsJm/mDfyy9V2L/AKA1/Oze4lPNrGFNgqPeDuPTwlxR?=
 =?us-ascii?Q?CREmpesXq1yXCpTminHrLgQcrJksh5wNy7lxTwDyUDeUksi4o47MJ4KIY9hN?=
 =?us-ascii?Q?LKCEirhXiIgIBQ5ixQPQG8RmJBedyj5jvEsvmWU6jLBknECSEhXFFzaZwn0J?=
 =?us-ascii?Q?VmA7aoyuM/9GGuDetvWft235k/omWppGgPh5dD4vScVgia+2qoKcuKa0PPoT?=
 =?us-ascii?Q?PPXSBYk/jBV7wggF/Z/px7z1hbYkSNukZrkJ7c9+NDDIOm5IXYT+e6v8w9EV?=
 =?us-ascii?Q?aS0q8ad235m4BVrCgs0faUh+l6/JZrrqDO9a1HpLpHbJ7SfDH6SjACZXbowO?=
 =?us-ascii?Q?h4DA7upYx3AvqcpnsjWpnZ4U3zMGUcQJhnh+jUZNhZvcWu31TmlA0l/COukF?=
 =?us-ascii?Q?GKnx+1+MI87nH9mPZYiJtrPgpDqbHu/a106k1SqKzDq5JS9h/3A14bEau12O?=
 =?us-ascii?Q?6fK10nVsKKLuUZ6peoFg4soy3RHtLqSwMZToF9eqIVAjcqm0fOjIv5nWinYq?=
 =?us-ascii?Q?ptZQxtGBAY759Myjhb+RihLgyYPRcaYLchkOMvtLI1pj1hWZDXahOYq+eRrc?=
 =?us-ascii?Q?mDKz7evB9Za/P5xp51FndsNYSL/ApaCGW8//MNYrGJ7vQq8X5c/p0D6PZyrn?=
 =?us-ascii?Q?TCPMHAWeLQGLB7L8iP4XA63D/KCMKgVuQHz1kTCFiP8NjWglbNZT0OovoKIj?=
 =?us-ascii?Q?FG2luBLdvNd/8qbhSYp+n1MPT5PoSrKoshgG0KM+3DbLIzy338MKZhxfASng?=
 =?us-ascii?Q?7Pw6EJZPHDMwqZx1e388h6lcMJK1Fd93FlsXq03Qok8ckO9CNxs3XTcvOhRL?=
 =?us-ascii?Q?spufNK6Xzlm/EtZyWA1xfFLx+8UI26yORXvBViC8N4UW5AoQ8apI9G5AvgqW?=
 =?us-ascii?Q?W8qWWuRe7mvHG0UBnP9pkLx0dCtccZo0kaQur6t7zgU9NWEcRWC2ZH5f8JSc?=
 =?us-ascii?Q?NGap2s2v4fLKCOGT2Vzz7Gl44Lkl43QJRWfMmPAKo11Ni/ifgvrbl2S55Cn1?=
 =?us-ascii?Q?47Pk6XiOvGjg+3FvGci9vVzYf53/TZO602kfnytRXjXfdzdDIng21ckY2eK6?=
 =?us-ascii?Q?YyE/bUOLejSyU8dgBml0vh6KTj7AOXCMeoE3gd5+vIcoRs+U6m65NgehEX+I?=
 =?us-ascii?Q?JrOm7GBT2WboHC63B7x6yGPrZLGuVqqGj3M/+ixIUc2WfpHGPAVNbliJYVTR?=
 =?us-ascii?Q?ETIQuiMqI5B/DpXJIwshffI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <332CDA0B0DBD064FA1A83FF5A68D03D3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0a89cc-d008-4b40-c052-08dab62bc1dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 01:53:47.8508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrjiw2wLjjlLyJWG2t5gAVMfNWow5Bifs3bzCZPUfcOq5KSUW5+YUOA5uVVxaDxfQ6BHTFto0QWYWogmJZH7ApgR2PoqqL+YLatAR9dd/Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5860
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 25, 2022 / 00:42, Chaitanya Kulkarni wrote:
> Shinichiro/Yi,
>=20
> On 10/23/22 17:50, Shinichiro Kawasaki wrote:
> > On Oct 23, 2022 / 23:27, Yi Zhang wrote:
> >> On Sat, Oct 22, 2022 at 7:57 AM Shinichiro Kawasaki
> >> <shinichiro.kawasaki@wdc.com> wrote:
> >>>
> >>> On Oct 21, 2022 / 21:42, Chaitanya Kulkarni wrote:
> >>>
> >>> ...
> >>>
> >>>> I think creating a minimal setup is a part of the testcase and we sh=
ould
> >>>> not change it, unless there is a explicit reason for doing so.
> >>>
> >>> I see, I find no reason to change the "minimal log size policy". Let'=
s go with
> >>> 64MB log size to keep it.
> >>>
> >>> Yi, would you mind reposting v2 with size=3D64m?
> >> Sure, and before I post it, I want to ask for suggestions about some
> >> other code changes:
> >>
> >> After set log size with 64M, I found nvme/012 nvme/013 will be
> >> failed[1], and there was not enough space for fio with size=3D950m
> >> testing.
> >> Either [2] or [3] works, which one do you prefer, or do you have some
> >> other suggestion for it? Thanks.
> >=20
> > Thank you for testing. I guess fio I/O size=3D950m was chosen subtracti=
ng some
> > super block and log size from 1GB NVME device size. Now we increase the=
 log
> > size, then the I/O size 950m is larger than the usable xfs size, probab=
ly.
> >=20
> > Chaitania, what' your thought about the fix approach? To keep the "mini=
mal log
> > size policy", I guess the approach [3] to reduce fio I/O size to 900m i=
s more
> > appropriate, but would like to hear your insight.
>=20
> I'm fine with adjusting the size to it can fit with new minimum log
> sizes.

Thank you for the comment. Then let's go with the size 900m.

>=20
> >=20
> >=20
> >  From Yi's observation, I found a couple of improvement opportunities w=
hich are
> > beyond scope of this fix. Here I note them as memorandum (patches are w=
elcome :)
> >=20
> > 1) Assuming nvme device size 1GB define in nvme/012 and nvme/013 has re=
lation to
> >     the fio I/O size 950m defined in common/xfs, these values should be=
 defined
> >     at single place. Probably we should define both in nvme/012 and nvm=
e/013.
>=20
> Agree.
>=20
> >=20
> > 2) The fio I/O size 950m is defined in _xfs_run_fio_verify_io() which i=
s called
> >     from nvme/035. Then, it is implicitly assumed that TEST_DEV for nvm=
e/035 has
> >     size 1GB (or larger). I found that nvme/035 fails with 512MB nvme d=
evice.
> >     We should fix this by calculating fio I/O size from TEST_DEV size. =
(Or
> >     require 1GB nvme device size for the test case.)
> >=20
>=20
> Also, agree on this.
>=20
> Above two listed fixes should be done as a part of this fix only.
>=20
> I'd expect to see a patch series to fix all the issues listed above,
> please CC me so I can review this with priority.

Thank you for these comments also. Yi already posted the series :)

https://lore.kernel.org/linux-block/20221024061319.1133470-1-yi.zhang@redha=
t.com/

--=20
Shin'ichiro Kawasaki=
