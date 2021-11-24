Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC084C433F5
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 08:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbhKXIEW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 03:04:22 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32579 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbhKXIEV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 03:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637740871; x=1669276871;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=R5wqDVApaz04mIWEF8r9sOsDtmrC+QFzAGd9KUoBMEw=;
  b=hmOCiK50noZYF5GNFVrCEq3MnD9qXz0xuxJDKqKOFpV8bMm1nCIyX5+L
   R/JAka0JWGb0GPO5sEgqu2jpcGhT9gep0uKvrceK/TixNMb7vJXcCz1J4
   fikDCR5x4Iq5bmTYKyBaQovKKasvIBwrBVbIJXoObfG8b6CYdP4LPQ+J/
   3DEcs3Mg9Cm1mPSiDw3WSJ0QuJE2DqsuUmP/hxnNI1CYqZKR/45Ng1s2+
   pFJIRsadnIrBF3kho6hDmg6hgSduLgQIB/fiooDarsfrOC4VB5oFUMyRf
   BINjVAXIfnI3HwZEqfSChwP0BxaN2ytrkzYOfA6ixAVymh7xNQbHiusdO
   A==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="191303234"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 16:01:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOozj8a8KSdy6WvYbxlhXc4oZztXS7mYRP2RgfL8y8c30xxyaw+aGCVvUj4yUgXVKN4uC7R8QfJ2KHP4Q3WBEfFMRgIBK4cw2CA2hAPeFq3CdMXrz4g8UiQeF3ccg49MWeKb/wfPmMCXHj4wpIuEje45ecviyB5be9Ne0FMaa8ZDP/Lnj6Qu/bZ6HdVLTvVGPoBK7HvouSH4z5PGSn4YVPnA0SZml13hF7e/AgaNZIYEMYpDInKgVLeKgTONQo9QnCdmPU6OXhZwF/tXDBO8etBiDIqcmOnq2w1xSyAbTL/AZJNIq/650PqnV6riwEw87FQ/dWe5a9uAlUWcopai/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5wqDVApaz04mIWEF8r9sOsDtmrC+QFzAGd9KUoBMEw=;
 b=GuMTqHRVEBZeGbE+ypcIOf3ZJXHLa1/dYVB69kNEShabIX7KZ3KZEs13SSF+0qSaiu+5CNvOrqO0P60Ce6V7kr+8ybKGTnqPiOAtPlpxi9hmxBmwhKJ+loDbtLDu2zK7BSrQOAmzbFfwcQdqY1HNosgGSV2RuvcHFCrkXBtpQSVvw6KeMhuyvS6o+2PXHNyjtW2tYX4nXP1cumuUsbyy8GgpL9BMTHHoN+63NjAC3m+HEm7qTJe36pzZbbrYB14FQVqWaPk0zjQj1gOLKLhu/3l9guBH0Bnjx3BHS1PG+vXmLh29cMyAIea05qm/uvmJuGSPSZTlurrMTMkSI+hARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5wqDVApaz04mIWEF8r9sOsDtmrC+QFzAGd9KUoBMEw=;
 b=uj134LSoU2ThiAk/XLdqnyYJOKA9WgUZHOEIuy7995ankyxf+zk9/B/Sgnu19eUShHln8P6PnnmO+aoOGDZ2qXf0cdqe6TK1Hk2A1KNY5SNjj2qk/7rGjOQCbBiMkVuXvpNf+GN1ihfk/psfxj4t1j8jaWrSDmFjmfZktgYqnG0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7734.namprd04.prod.outlook.com (2603:10b6:510:5b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Wed, 24 Nov
 2021 08:01:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 08:01:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCHSET 0/2 v3] Misc block cleanups
Thread-Topic: [PATCHSET 0/2 v3] Misc block cleanups
Thread-Index: AQHX4J58wMbFlNN1kUml+NwFIppMsw==
Date:   Wed, 24 Nov 2021 08:01:10 +0000
Message-ID: <PH0PR04MB7416AC1212126EC0136D9A009B619@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211123191518.413917-1-axboe@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3f53ff8-769e-45f5-68aa-08d9af2093b3
x-ms-traffictypediagnostic: PH0PR04MB7734:
x-microsoft-antispam-prvs: <PH0PR04MB77346A4D32DC9EE4579C338C9B619@PH0PR04MB7734.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rxyr9sp2ZTwVES0FsE1FRpJ5VDE8uNGwQou9zG2dsZ6pLOZ6/75msu/8ueaCLxa1+oXHs82VLRtDtny5brgTLIXSPFKZ06U2VH10uONLHWXNbjhVNMC0Ks9uUdWqwHgrZQigzQbn7CjPa6xlFP+rpBgEU11imq0NH+nGGamFL7SS2tLuX7AGQ0ElZT4ISdiTycHikH5bNLTeBCRm/cElW3bkwj5XtYJOnqqUXtV2LtlWXuq2yQPROs0hHTbgJhJwc1SswNyzQtrSc5zFATlOS/Hzp/DNLgluEYNuX0oEWpdopbmfkls1mRueCkSs7m9/MszJ4qsblXg1PvMGRhOuBmMMn0opZqjCVIne9bsr9sZzXMsNda9cqxJ786w5TfFe6eyeGvl5+vEAPS/7zgyNuiNYc834XpKXof4JQSjoQOqiVyY0/ee9F3FcjJMGGESE5bjOE0TCiOE0KGocA7JJgPdLLAhSldbFreVTFN9xjyq8vSTnYOoE/YmHWzcKRLxxbT4SmCwHbmDXalq7h3KeYloY57fJm48P/MnFpDTAekBrR++efSUZ01h+KaFpMw1rPlWvswZOHSztb3R1xJA/dyOqdKe3liB5P7lHXhwyNPvSggfQ/7H0nu61lOxAK3raSMzEPduB44X/gZEW9QNRgqWqPjK2HhzFDvXdXISfL2l1yU/kRXxmJPMqKyzcjSH7/Pcdb36OXWXN+K0o15TwIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(71200400001)(91956017)(508600001)(122000001)(52536014)(82960400001)(33656002)(55016003)(4744005)(38100700002)(86362001)(7696005)(8676002)(66556008)(2906002)(64756008)(8936002)(9686003)(316002)(38070700005)(186003)(6506007)(53546011)(66446008)(66476007)(5660300002)(66946007)(110136005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?En90NREY4i4v/S6dob2ucVu5VldbKygtITqviDpaWSWbWlUgrIBzOkonUcHg?=
 =?us-ascii?Q?M+eW7gQVXVUDt5FTkDwChrlV1Rt26cBXYfJsCpa3zPVBmFdXDbo1KujO6kq+?=
 =?us-ascii?Q?2UxYbTUNHkkQG4pZk18IjPgYy5GDQSC3LuzL/kAxmvBwBCFZFi11AUgj2tTr?=
 =?us-ascii?Q?bXfW8gAi0Ljga8+3B6/cQAZNYD/2dePCElsES3puvhc7JZPLAZ+i4+LCVGIG?=
 =?us-ascii?Q?TMq6Ue9kFoHSuoMuJnMC1n9fEJX4T4fsa0cQ8/5P0UNQ3s6EX79KG12qRQPf?=
 =?us-ascii?Q?174nm7J8on0WcONcfLdhF01tGCOTeAlt9EegCHXYZycLPr0C0yGAPjNp+1GK?=
 =?us-ascii?Q?XY1tO4p2KSTAc3GTDHlYl0d83qMrjhWENIy9MnT8pV8Euu50CfskPoP8SKtA?=
 =?us-ascii?Q?GppMLwIasknpg3DtiS+lLTxTNmVufLtCXT4URmxBK4cmAyEUw6Y2ncJ7KSj9?=
 =?us-ascii?Q?WbmIs/zKNmBSHHZs9xXFHWpQnXeFXjNTK+VQek8DZ+V9VQfolkayi2sr5IHf?=
 =?us-ascii?Q?YKqM0oNXeFfcz/bSLKE85JmOlMTnKqm1yZdtCgTonfUZ7Bo4gW1fGHWxXmO1?=
 =?us-ascii?Q?gNdg3WbINcvXh/Kl/AVYQyk1ZW2HcbXB4KI8ML+xkQj2yCTjjc7OFXt3dtUl?=
 =?us-ascii?Q?fIIGuNlSNqhHf9vSEB42g8dm+Qjb94ai2nDypZ64q5zBO5LHDNBdjWI3FI2X?=
 =?us-ascii?Q?UJ/oL23qugCruGP5fpqmB04e9SHG+y9B7/yO6FFuTuxR7SkBmlDSFu4wy5Ho?=
 =?us-ascii?Q?51/ORu0+URnDhFOWT2sEcTFDpxZb4xQkJe+Ejm5G702VP4tXZVnUmJm+a+YR?=
 =?us-ascii?Q?JTM/qbaZSX2iRubkpEYM85D8RfjqNpDZG2OQXdCSf0oIC/Or/0hAqw5e62V+?=
 =?us-ascii?Q?H0+bbbhPtKhNDF35Bht3Hh9Zy/mZMYDD1v+ToVcX5yKllmrQDCd5M+s9JQBc?=
 =?us-ascii?Q?F9wbsbVaFEw0v4ETwIvvcStA7tlCGLgZ7jEjhbhsOPJ2sTyrgF4Bu6g99urZ?=
 =?us-ascii?Q?/HpYDj9/JJTHhtch+NLlcRNF26yA9Xbys8lBd5PIYCIqX+l/s0OQtZSV+47m?=
 =?us-ascii?Q?LH5fse4fJE+ZVzpW5eGP/0M/CA5dt/Fj7oEUst0motnj5eLOLIHAr7slLrfo?=
 =?us-ascii?Q?2JXa6MGh2M5ngkpJylkAJfe7vZrxCrqdRz0dIC1nWioOyPbZ+XjjNYwCgDvR?=
 =?us-ascii?Q?mQGfVgljhAa1cjBZEs0CjgM/DEFXuDsMxOZApJkgAqBFSYVGzynWmvw1E8C1?=
 =?us-ascii?Q?ssdSqa0Ed1y5KLsDBuyJVvaNEjMZ/Wjqmhsa/NecXP7b1NZB4bXvzZx2StVt?=
 =?us-ascii?Q?TKbVV8laKCP74V5DlL1kIG26uQAzVZxjK+pxu1FoL256/jPUBhSpg64MoA1L?=
 =?us-ascii?Q?9thBtzXPL8+VwnXK39hJrP/EYCdTkY/YC9nT2DZh/lPfJUdAfHk0lh+ZW/hM?=
 =?us-ascii?Q?pYzpusDKJpOsUdCPD13BVn1G2b4xVln+iw7l4feRNS86JWpr1m8j1kO6PhAb?=
 =?us-ascii?Q?0JPLbBkk2CbDMP0Zuj7Ovo6p063wT0Y6MKcN4xCHelCFMKE3UAscq5/XN11L?=
 =?us-ascii?Q?uoEbNKia6ULIQTz/lGED63V0j6mFe4KFKAWx41AR4rMNCIOTfU7wP1wy2blI?=
 =?us-ascii?Q?FnShz5THExLpg4/ve/TgSudPame3DDmSHoSJ1RXtHOOvg3eqEB2iqgxvC71K?=
 =?us-ascii?Q?vsdVvmNssNaqQdyLDw8PaBZ9gdsJiZUs4wxENLAYXaWyJM+JoejAvRdNKEhl?=
 =?us-ascii?Q?koEWH+SVSYQ7kEDMvYLTaqzwkMLqV28=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f53ff8-769e-45f5-68aa-08d9af2093b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 08:01:10.0502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CvyFMSxCWxYClWqKAaAJcJ+v9GQTIvGffRjYrBjaPnk3DbIqnaZ0YY3TPY3oHrgaZjS+krytLsGWfWKAkxh1SLtC6lMPPvgUt7s/sJpoPD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7734
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 23/11/2021 20:15, Jens Axboe wrote:=0A=
> Hi,=0A=
> =0A=
> First patch avoids setting up an io_context for the cases where we don't=
=0A=
> need them, and the second patch prunes a huge chunk of memory in the=0A=
> request_queue and makes it dynamic instead.=0A=
> =0A=
> Since v2:=0A=
> - Use cmpxcgh() for poll_stat install=0A=
> - Move poll_stat alloc + enable into blk-stat=0A=
> - Remove now dead export=0A=
> =0A=
> =0A=
> =0A=
=0A=
For the whole series,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
