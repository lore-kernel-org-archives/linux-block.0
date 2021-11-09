Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92879C433EF
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 12:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64735610A8
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 12:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbhKIMv5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 07:51:57 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46149 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhKIMv4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 07:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636462151; x=1667998151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TxMaCGf9tcS5xbCH7W/Al7yjHAJF8b8ag7Dp3EReksI=;
  b=fF9/TB6iM8URAPpv8fOsYmccB6IJyFRlxuwO8CXEyx2kGu0geyl47BB0
   LkAIfIoUWlMUk7lkykcEJU9Cqnep4MenSuXsdcy0KQhRUnbzfXm2GE5H9
   J6KlIkOSa9x3Dp6+PEj395mN+PfaWnwv0FBlEpD7+jzIwUtI3ai0Y/ibP
   Vochrn8iNQysZ77HPXE6yFg01XOLlgia1a8IQUziwD8IYkR1BEtrSLEbE
   if0s93R9j7o6+uE2imHq0k3RB2OqApRBc2LK3UDRx3GYIRv1jtF5IK+XZ
   58Oas4C9GNfx1GsCH44MSxuXyBE2ulHIY0HOD0qJoCRWbXfNQB78rmll7
   A==;
X-IronPort-AV: E=Sophos;i="5.87,220,1631548800"; 
   d="scan'208";a="296908931"
Received: from mail-bn8nam08lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2021 20:49:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECZBD50tWAN3D0Q1GVTG5Q88DRJq5axh1IGabQucnp3G/v/P/AcCQDRR+Ks9tsSgMZqf6e/ZW9Qn54AWwl4UVTHnKOKaXKONK0Dz21tu/wD+khKFjZ5gZ7Xh6q+TnBZ4WNywQYORJIMzyfZTRzV9GcxXLSncX5PFTkBRjp0tqncLuEv0lvtM7qQjsvfZSijODDHJjH3QxkL3dUHJBZhjv7DnU97y/7VR4L8LZcKPwz+ZLAO/qMPUUPSWX436wOvmtRUmbFebtMQ6NSBadxj8Yb8ZlK1/WkpEt4q0rLzaAAsbEvuYkJA7sG74OxOKOz1sY20oR6ipmalyygIyucebZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31HWZZSoCM4qGvU1+6LQOdsuFoUl2tHySrRCjWjjZf8=;
 b=IULRYvdopS6wHdWJr0vVmXGHIAejuLTZYIY+SBCD/4VBtgfyfNrSWFakf27E13NYaM2fuDm4otf/X/rBjMbgcLjVFpQnp1O9kprxGHXVBX8ssFUWvYgCq7UCuqQYCRPl0aeHJHx9OBdHKiJSeBEZn4w0QRZEDSmmoVRaVlBjbgZ5GT8t8lVu0SD0V0zuxcniz9DWGcEEPVRUMPX8dbi1knvWza/gVi53oNXb4iONWyF26IXT3SLws4c4BDoWLOljlHuZPHXmG44e2CcvYZRkiqyzLA0l33KBgYISVtq7U8RXEJ5tlVJpsBBQTQCo1KdJ5G/xLVYuN438L4YzsbdUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31HWZZSoCM4qGvU1+6LQOdsuFoUl2tHySrRCjWjjZf8=;
 b=Zuw2VPccgSoqEj/+pnXI/LqKtN5GdMvDllnUcPYF1+6xxUSwbnWE24SvZIwlESH+FNoHc9e0b53Z/KN+idaxpO++T2fkLiahRiOoUp7iO8h13/e3p6YkZ4b9vRaT+afm324bzP8dKGt2bMGaQGczswL/EW/b4FbSUfbv8mn3IeU=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BY5PR04MB7044.namprd04.prod.outlook.com (2603:10b6:a03:227::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 12:49:07 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4690.015; Tue, 9 Nov 2021
 12:49:07 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jan Kara <jack@suse.cz>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] block: Fix stale page cache of discard or zero out
 ioctl
Thread-Topic: [PATCH 0/2] block: Fix stale page cache of discard or zero out
 ioctl
Thread-Index: AQHX1VcwTtZXEjytAECIHF5qRqlc+Kv7CUYAgAAObQCAAA37AA==
Date:   Tue, 9 Nov 2021 12:49:06 +0000
Message-ID: <20211109124906.ahcqawppdxvpap5g@shindev>
References: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
 <YYpWbnPK+K1kQ3Z4@T590> <20211109115904.GC5955@quack2.suse.cz>
In-Reply-To: <20211109115904.GC5955@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79761cdc-d6fc-49d0-095d-08d9a37f5179
x-ms-traffictypediagnostic: BY5PR04MB7044:
x-microsoft-antispam-prvs: <BY5PR04MB704469968460CD525CA69214ED929@BY5PR04MB7044.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4Ei0nIZgI+ysVXNnOYOHhAi7If+c7P3AOd+oMZ2CTfZHs1uN21pGxq5w9M7r2iDLT9RuzQUnH6+ma6StThHDEz37pMPBYkefFY4aAv3Yf/uHICbkN3AeYc22QKmBiYSHMbvYlaoT1hQh6/Pwdl783nW7gS3dP577k+DhkpuWT2gnZ8ealkPWi43G58uhn2uaDrkituwbMb+AQlK5wQezPEY6klL2U+ynfyryvebhF7dRw8FL8HWHP4w13gyjSYTtOrDLZwVsX1qErXEHs6bf9of5KH93j7q2V8GK2iXsqa+3rL+1ZOIWeCanQ8PyaYn+ahlpgZMY8fpTrNwUBhFxvxpuZMrrB0230TnDCbrlRgOWCpMxok+tR3fHLHypz3//VJVF9V/vF0WGH90wklpBK3LBHXI+o/n+vSt//48z4KrJj3a3IFXoyhvpJ425tm/9kEc7R3IggTG0jqaAkbHYcLYYbjB9biWonLun2gwsZy8lIf+H8OofZoPKjBnj3qFe+4YqqQfTi/CrZ172eYRL3wz2o1AIQAw1Alm/klorpnDSt1O7Hx+p+ahF/geGakJ7coOLAUuPrl8wuo2oYfXVAujGtJKzNr883A8gH6JLorip3qq5Eakhzv6woaUX7iESYRfvDjy4nRuGEoO4gPGk92DdkxM1wgQFkM+tfaGP+xlW7B8LkPhxSN3Yr8vWTs/3PYz7y0rJL0f0jRTjvlNkWhMIakPBzQGMBIIpyzZ8H/y3DyuVW0L6ap8SWJvfCLevH5aYWzjLwelS4iyqbBybICvGO/J/KvlDPk0cHYoETo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(38070700005)(9686003)(6512007)(44832011)(33716001)(66446008)(64756008)(4326008)(38100700002)(122000001)(83380400001)(82960400001)(86362001)(26005)(71200400001)(2906002)(966005)(91956017)(66946007)(5660300002)(508600001)(76116006)(8676002)(6916009)(6486002)(6506007)(54906003)(66476007)(316002)(66556008)(8936002)(186003)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RDW0VGuTXlfjXucKnuqigyGlOb9Y98+n0Az3LhjjtMn5SWIvAy+u4cLq/3Li?=
 =?us-ascii?Q?/k40EG+BqEP9JlczSGSOW6rV7FxAvrWRWZFV4WZJyfo1KV7IadkqmKzihvuB?=
 =?us-ascii?Q?wuAXlMLuttc6UcKn1AsTIv9PQfF5cy7HmYSBV9V8eHQrpVByZxQ9+iTB4Qyx?=
 =?us-ascii?Q?Zodba4rG5dGDStFPYart8tr1R2TCxnKtPjkPSyVpC5pKYgG55b5ZbLZEms3K?=
 =?us-ascii?Q?Ar8XZ2oB811Xv7QpGaHDy/v48UA53PoLwXfO8O+YBkJ2grJo8b0pkKzfgox+?=
 =?us-ascii?Q?jyyQJ8WX6fFLiouG6ZaRaMejFGOD2CZdy0UK+OciNQ60UZAp+51R2HIbQbeX?=
 =?us-ascii?Q?y86w5Ojt/jlxI1jFXHtJZ/E9Rr8P4jU3SBv/K/2VsFaWHJ5MaqtqbZhn7XJw?=
 =?us-ascii?Q?x8ukREvvuDCi2jkcHRcGodokdLPwzTZB8flKhjfSvaeVtQOcV8SKPCRloZ5S?=
 =?us-ascii?Q?OOXM5r5dFyqBUGsr1ClyGW+FRn8nIIRYcFcmc8lnOFa3g59vdFF/8NupDUz3?=
 =?us-ascii?Q?m+qce+zDx/nqsT9Qu/NK0BzjGeo8AafPgelEEn2qon5Ooa+y7RSD0QRvBTXb?=
 =?us-ascii?Q?r/X37KGXbYjFowox+KxLFjFe8Dj0RQOwNtzJrJnJ8YR/qMIe7KydorxIKp5I?=
 =?us-ascii?Q?vmmAuZrc+iWLUlt9FPBGbII0m6P3s8ckItCdsaTSME3PVQ5cLMA9YAoXHVMI?=
 =?us-ascii?Q?ajuL9G/lWobv1hubL8brPJ0DyygA+LQyvlDUiscIqnpUbFHFaBLannZpYIj+?=
 =?us-ascii?Q?gN/FHn/ZlShsxR8k8ytmsWOJLMmhZBjOfE/Dq8jVQ4lYoJVkF5iKKyhnnjTI?=
 =?us-ascii?Q?t75Xy3KSHIfxt9FI7hWTY62MUG4Veqwg//mn6mqlpL/RX64anWm4EnLakQFX?=
 =?us-ascii?Q?dqw9uDsNZ6VbUDda9P5KOdCoV+vDYX7xZhllXWYwJiGy03TDIyqilWQhy5Ka?=
 =?us-ascii?Q?8I4M/HR/uyNTzCNk/UJmbYgh4BwkC/FhmS+MGLLmrlWS39kJNFMQSY5TIKdH?=
 =?us-ascii?Q?QzLmtwkGE17TdHb29jP0Ownx45XOvxmuRtOM8nb15O78Qs3CyKHvHkXZfsmx?=
 =?us-ascii?Q?MxnzW4tdVk85rAyu+E5d1mgAjVsoynPq8r7hpWMvhILD7PaOgHL4pguwN/C9?=
 =?us-ascii?Q?DdRLGrjuGx2bjZ0JW+O49WS0BTopBc7vMOyJfmu/suv3Y1znFxR5gUYsNOIv?=
 =?us-ascii?Q?60fxTcEZTFFSzkT0s7u5RUNfn8oHis7ayOerQFB9RT9yXTMY4grU2j6MiDt/?=
 =?us-ascii?Q?GZTLB3MxnLNXWxNJqVeOQdP5euXs8XNM95iPTulNlxYoOZS4pvsiTwjti/lB?=
 =?us-ascii?Q?bF2EPrro/JPAffey888FSlz4hX2SETL2keQV9WOZ3DgmVMYMlE/jvtbApXjr?=
 =?us-ascii?Q?ZyEGgXq3m8Fr32wCHOffD2hPcvnHfBco00kxbWrLRCqi/qiaCJKkM7jEdyHy?=
 =?us-ascii?Q?rd5do8QfrBCLNzpyl8QIoKzfF87orStOkPoarkrAByUY3CDPZY5x61FW0QVm?=
 =?us-ascii?Q?6izsWvoI2yoW7uSpeDbevjgcCiOONBk+m45/vHSM5LygwjU3RUlHsWiillvY?=
 =?us-ascii?Q?lZJ4I5jtVjzq5nAeEWI38dIDNcN0hrkyji7OUr2mtyl9t/RxSds60VjGp4LU?=
 =?us-ascii?Q?05tiFZOrFpV3teP1j6qzXRdt8EpFwpyM+rz0R9rswQaKARa/GeUb4I7cmcrm?=
 =?us-ascii?Q?jGZnoFzIiwQ4kEc5R5L32dKPxV4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEC88CE96F881D4AB218AB03C6967267@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79761cdc-d6fc-49d0-095d-08d9a37f5179
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 12:49:07.0536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9b8bXnY4uCoqKUyLwgCWlIyGWGUIpK7X7NcmY7TWlD/Q6qbQuOFcRmAqapOsm/TO8gs2O+TjRJMKiQynViDM1KmI75UMgo7tuGywyyMuEBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7044
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 09, 2021 / 12:59, Jan Kara wrote:
> On Tue 09-11-21 19:07:26, Ming Lei wrote:
> > On Tue, Nov 09, 2021 at 07:47:21PM +0900, Shin'ichiro Kawasaki wrote:
> > > When BLKDISCARD or BLKZEROOUT ioctl race with data read, stale page c=
ache is
> > > left. This patch series have two fox patches for the stale page cache=
. Same
> > > fix approach was used as blkdev_fallocate() [1].
> > >=20
> > > [1] https://marc.info/?l=3Dlinux-block&m=3D163236463716836
> > >=20
> > > Shin'ichiro Kawasaki (2):
> > >   block: Hold invalidate_lock in BLKDISCARD ioctl
> > >   block: Hold invalidate_lock in BLKZEROOUT ioctl
> > >=20
> > >  block/ioctl.c | 24 ++++++++++++++++++------
> > >  1 file changed, 18 insertions(+), 6 deletions(-)
> >=20
> > Yeah, the discard ioctl needs such fixes too, seems it isn't triggered
> > in the test disk of my test VM when running block/009.
> >=20
> > BTW, BLKRESETZONE may need the fix too.
>=20
> Yeah, it seems like that.

Thanks for the comments. I'll work on BLKRESETZONE also.

--=20
Best Regards,
Shin'ichiro Kawasaki=
