Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6674411
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 06:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165410; cv=fail; b=OUyPKtUrlpbNSpAbkvKm+8ujTbBvoZV7jKcdMUls0R0MpP76w3xbtrSXerHCRTAx3E8+ulwNSKS4vIcahZoc0NZWEgIf+HdLgrR9U/U6RC93JgLaOFGHiAG9ZwqNZ58VcVV0exw27JoMJe7q7HpgSECowiYWXiChk6aiSvjMze4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165410; c=relaxed/simple;
	bh=GhFV5IFQW8D1CnWkalsUDbNhYALLCsuPZaJZ+5QVb9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j3W6gBXyCve47yDRe/OGk2TENM789t6fcJH0JZ0E2zDTReVa1uNnnBFrNVh6/MVWgQt3xU94gqZPwa2eV7FRO36Xo5brE1dpO/ObBBaaoK/aQPCqQOHYk+WpQCRWjvNAaLjdYDpuuVz9DCxvhzZ10u7EMbXhUldGVIs6VXNXgdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LtFx+wPJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hLgRvhQQ; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LtFx+wPJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hLgRvhQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706165407; x=1737701407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GhFV5IFQW8D1CnWkalsUDbNhYALLCsuPZaJZ+5QVb9g=;
  b=LtFx+wPJ8Ws5ddKD4ay4gpJflYvX0qP6Qb14hW8+3zpyWVZP3IiYR0/D
   KHi2JF6RaNcvTy+y7IF62FUj42cH+o1Ev3N401EhRDB2/nbERrCKJXBoY
   sQO+3979Qoyv8xXsLOc3wna7ObbcObivwjFdvxpfzE2DPtf2OTomz10oY
   csEx/pzgdhBztk2d9uV6RMgIyE8UQ4hN0GGmPIRXYZQs8WsAmJWv6TAMu
   d5IQv5eRnnnLSr9YK+8Izf2k2ERMKbpNSx6B9vOA96Y0DHuilGnPjMPg4
   qcCJXSYA5pOt5WKlpmEnwtIZZZ59LxDF5LsVLaYjwvEM5AFTsxYuL14/6
   w==;
X-CSE-ConnectionGUID: lWw6HjmnQ6OjlH9Ks9nMcg==
X-CSE-MsgGUID: qNkSpjliTNutmykco4UTNQ==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7698182"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2024 14:50:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkIW/CVHKCe+tePipwUbJix4P9UFSKZBxbb5tNPpXT929ShwJqVHc9sRAX8yUa9a5Eucs2PFffx2HebrdyRzdwFGP5+DojUehrs1rjjf1Ey+ibXll73D4mvBNmUnvG00t82kKz4qKNNC+lbpeld4QasRmtlsRXSOwRQkdNZNEn6Jmx9/fDb0qvvMTuterZerUmbiQXNV2sIFI2ftpMYTWeXCD9YiALm02BiFof/NETRj/wZSZI+S/r3GUHNqzJcp4sdQM4et9zr0ec6pZ8pmK2wfuKYyA22V64PKUYeAJsa3+wgl5b9fhmPH3dyHFbV6Dw21FEcOaCfpQQnRT2oh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkZ4H70wh32pmvW8OWk4sah40DML3/uSQOWtXdXrQ/w=;
 b=iwGBMIuCr+i2zSAkcHwIGc0D6pKvBBbvGiljGxCj7c1LjZC8nVx8GmHXZFGyYU1c6KWFu2e6D8vte+faP7QflCd7WhL047ftdMyLlOEx/6XheK/dYVqgJgKq5pSbIiRdDXXzq0nw4Mtbep45jEp5C7t4O73sMzm4GYflk7l1uulWOGZ7V7lEbiUArHfwm0UAzjluj17sPBiSwAxxNb1sH/RhHx2v/0P6cI0qSpo9E2Hc7BIi9IOFGXNqBYUtTa8oH1RU/QTqimYr56zYsnaQumWdfJGdqna6b3LCMCNFL15YPD3XsCrGZgm4wzjKax8rcWVhYHUgBIx6PU4ytrDaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkZ4H70wh32pmvW8OWk4sah40DML3/uSQOWtXdXrQ/w=;
 b=hLgRvhQQrUTeJrdkT+CXhXku9HNQI+D3k3f90pPsma1kG2Gm8ZEDMP+B9GmACDAxLBgC1KD1VXFZMqQ5zh3OW86Ou2zg9UzNJPDZiCvsYhyBYWa5Q5CxQjrOJ9rKue/OSF8ptHXTfu6MVHsZTUExFjsHGk7FZhRBGQkIKyquRiE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB6452.namprd04.prod.outlook.com (2603:10b6:408:7d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.26; Thu, 25 Jan 2024 06:49:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 06:49:59 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH for-next] null_blk: add configfs variable shared_tags
Thread-Topic: [PATCH for-next] null_blk: add configfs variable shared_tags
Thread-Index: AQHaSC2d2CDEmP8DtkS5pBI3MmAtpbDdZp8AgAy+cQA=
Date: Thu, 25 Jan 2024 06:49:59 +0000
Message-ID: <5k2z4ldvxxdysytiexprwribvnktgbyzj3jghirxcvqmdu2shq@njdycji2ghrz>
References: <20240116033927.628524-1-shinichiro.kawasaki@wdc.com>
 <481f2f1f-ee5d-4278-a856-1f0d01ef3b4c@nvidia.com>
In-Reply-To: <481f2f1f-ee5d-4278-a856-1f0d01ef3b4c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN8PR04MB6452:EE_
x-ms-office365-filtering-correlation-id: abeb2884-0da4-436e-3e74-08dc1d71d940
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6GzosAxQbb4qP4e1HRVkuB7Zq58QbHZmxboAXTvH8OSRNU4/lIu04kPNt53Ea4fwghD57uNPHacTYr0o6YKmmm2rPz8EXOd6juFhaYzgv5b2hHq43N2iMIndkO3rpFH1+pYWRbvh7HiqjiuRrN4fC7V89ob8QId406q5ab0VllOBWppcv+gPTCGI2ZHOfEMCOLDHE9wZr52wAYQdGOTc1/G6JIdSpRK09L3D7IHCxvkwqECfMUEGgYz6+5ToABBnY30HnLJoYUZhokH8gpfYKK59dyBcb84+vle98GocYp1kT6CPTBuXfbi6v/b8IX6E/clX1Hl3GEliX0pWxLY5md4dr+NslEcjIffx8br3E+8tUg6dULCgwAFCmXw2nZPB4kBs36VxVaGr7KY5U164D8+QQtlS3YzUOTn06mDjbfSTEuMlUlEUxapcvSYtTMOikqp68/RM1mKxFjXDpMCx+QQsmGRwu3SWVjdzeaS353dOWcu98Ema2429g9HwxmsuDjTypO+GCkMu3y34mQEtHqdqkCjQyAkvjNTVgJpeKC7qIESiCnbWC5hZLUSFCONlYxek1psWQyTL6d4fmJxvuQwD5pO3Er4CoXxFOu0JC3B3Ii43rMRDEJhP1iBEcE4B
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(478600001)(71200400001)(6486002)(38070700009)(26005)(38100700002)(82960400001)(86362001)(83380400001)(41300700001)(122000001)(6506007)(33716001)(6512007)(9686003)(44832011)(5660300002)(8676002)(8936002)(4326008)(2906002)(66556008)(66476007)(64756008)(54906003)(66446008)(91956017)(66946007)(76116006)(316002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cEQlI7nnp5dIl51+syS4tph0bco+3JVrJwUiVFEv56l1bG4I4EgCHJkR8f79?=
 =?us-ascii?Q?rKOMdyQXcNMGywbZx5pyR39thQw3hVw/V6MqFdDBhGx0hNvaDSFnRjDdDrRT?=
 =?us-ascii?Q?VrHx+t5nRzEduhPbm94xgGTc2jd6VF5zyqvjOJbm9zAo1oWxG6tDeTg46C9I?=
 =?us-ascii?Q?mdKkAwZ01fggj3kkx3ui6/7EKPYl/LTOSutbkB7qq9yu/63jCtYvnYOanOGV?=
 =?us-ascii?Q?a+wdk6vYe9ccA7jbAgqOPwSQCHsBjAEelVvROaFazD9AJLl52icZPEG57+Ob?=
 =?us-ascii?Q?GERoeRQ5P1BglJl+wF+rQbdwKZ52GkFnqloo5/WQ0witaChMPoNiM+vCe2HC?=
 =?us-ascii?Q?YwpwmGa0g8zb5G12GqW7sboEh80Lb8t/hJv8DgaBpq8zCW0oaHz6YSD5+hvf?=
 =?us-ascii?Q?6c9K/RgArMmy89Q4e/gPK2WxtHTwuw6JPFBs9O3PMmRRmrRnxqAVoH8hLD6Q?=
 =?us-ascii?Q?07EO9MRbL2dE+evq+fcXPYTgoVeGpS4UMKrQ223OLzHtRBPIJ3oE1EPipjQ2?=
 =?us-ascii?Q?8NVmf30EC/bPv8NPFf2meqNAf/zAD3R7ICOeYBSe5XiV4q4xqCEaAuPCPLb8?=
 =?us-ascii?Q?dQH1gAoPbgnNHUN/s/1AVbBAUufBErQz/EWBHyaqGNmGytMyE6t8E8QR9Y2n?=
 =?us-ascii?Q?8bH6MTJIzLP0GnI+/8s8ZIZo5UnVCI/drC9bAsb166I7hmqhjp2Z37SeiWgZ?=
 =?us-ascii?Q?g0JCsTnHURITaXA8DWGzV11dF09FFHjNjKl9ZFMewT1jjJu/9Bh4o13zcMjX?=
 =?us-ascii?Q?pg3/WPvq68HXKfNg0dref44hRFai9KpVLQl9lCvPtups0+TB4kPEWp2gdCSZ?=
 =?us-ascii?Q?gYNvBnjgrw8SklL2sEVdEBbrrkeXMo6Vpqk1mcGRX2QOGpfNlHHT4Yb87YfG?=
 =?us-ascii?Q?qNNaqSaONDMLnRqYQNHuIn8UfU8+Sr5FwlDkKWJkQrkBzo4JTz+fLEmfsQjd?=
 =?us-ascii?Q?7OXInQ+tln3W25630xNf15qrv5mcKZtztFNmgcvtEMPSlWxysVvfrDS4xm6m?=
 =?us-ascii?Q?s96Pj/mNjpzLclf8FRIg/0MVug7zGQeNYDSLOQF7OxlraWxJjE3JmiKRniUC?=
 =?us-ascii?Q?MbdMT+y41O/XKYVLsBrJbS5Jsmm2jOwfcbHxphDyOvwvnA49wvSIrYbBrEN8?=
 =?us-ascii?Q?kwSSWQXajUqhXDKp9y98QNy1LdpSZMmwsCPIaTuEHus79HYdh4qZ+4SG1fyD?=
 =?us-ascii?Q?Ggfry0B5F7Yiwhj6v+HBKywh6xP+KeQ08/B91ukJdRitTwOf0vEp+9uKZjUz?=
 =?us-ascii?Q?PVZH3rA+hfiuNxB9lwukCo5YFC+iBn1p/Cd8Gt5D34YCCqi6uDGtE80gZ2BP?=
 =?us-ascii?Q?reliksGrhVWEXWUkXe5GR47y+VFWKFvepuG6j3rFSKCDzYCYJ6pECQ2EwrN6?=
 =?us-ascii?Q?L6eB5wD4/3Lxb2ccSHhQmraoSzhBoyZs8gcPBGDBOzArAHJCKfWEzU92ZLyz?=
 =?us-ascii?Q?D+qOMetL8uG8HZcN3b1JKkIXu0unQFs3IngvvxSTvBwc42iXuEPcBvyUuiZ/?=
 =?us-ascii?Q?SfJz2I6dheLCvf6R0AQ7NUMl4bPN9ybiR77ThnUf8O4H6QQUI7S5Dk8XSo5/?=
 =?us-ascii?Q?KKTFx+4D1d8kSy2OKX1dgWTNqjaIpSRoxYXvE/OsKJxSQn0oCwZzaP89PzuX?=
 =?us-ascii?Q?XeLF4P7DcFr5r5PTJmUY6no=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD2DE61572419048B72E3AA86F1B5263@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bhywvJIuvM6/F6tmqr2wFWLymAgyfyKnPvm5MFel0GiCY+KYb55/wMuCl15m6PfaCPx/aIgcZUW8BtiVGlOl1sL78ujlyNkzEdO5TymK2MywYlfJaPAsJrh0Kb5/+y8rYo8ZRxesmpObFcOSISRjghJ/K3FsaXfT5tkjZoCc2eOsN/AXy2mfIvwaOaAvV5l0+WpXKYKX7bvlGGE/qKxSundj/8/vQx2sub8N/dbJ+l3msJT8C5R2Yis1GV7VDYro4wKsd0zb6in88rYRZeJs6Z/zb28+VrNkWnUtGA3Pk546cddH6TJPeW4a/YAiyvdlA5wK01L3EvNXQqY/fkNb4kBoeblIxvlzo4uwFgs1FTfJbnn1f+3fzDtBP8HduQl2a9duCsatlSuQNuKwPvKrPCqdkWAuHasMEFfg6Pg7CMW5fg50UQ7/9bh8txUk5sgnDb0mq4wkhshvAKdCVqgwvtHiEtmqplhtvlkKmvwtB3s2rHsWcNXCpbnAb+8M3RUEoqMkbCCPDjyGWruF6a+3kSVQ8arOGQiPrLRFAskkKy8tADHhlffbVyZ24yEEMTLe/0WsAy4kn7FNb/cw2lkjlfu7y9ehuqmOgxIgsA+Bihpq+1GLR0j2TotxIg4jS9mv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abeb2884-0da4-436e-3e74-08dc1d71d940
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 06:49:59.2598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhWlKxx7Hcp9C9NrQXbNKFg83WoNto6COIDAX04AnCZ2VB5FXIpiHcnzNxdEzt80gCq9dxaNanWMb2PSDHtJlRMHVejop6OBPCPrusAuuR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6452

On Jan 17, 2024 / 04:13, Chaitanya Kulkarni wrote:
...
> > diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/mai=
n.c
> > index 36755f263e8e..c3361e521564 100644
> > --- a/drivers/block/null_blk/main.c
> > +++ b/drivers/block/null_blk/main.c
> > @@ -69,6 +69,7 @@ static LIST_HEAD(nullb_list);
> >   static struct mutex lock;
> >   static int null_major;
> >   static DEFINE_IDA(nullb_indexes);
> > +static bool tag_set_initialized =3D false;
>=20
> explicit initializing global bool to false really needed ?

That was the point I was not clear. Some of global variables in
drivers/block/null_blk/main.c are explicitly initialized, like:

  ...
  static bool g_virt_boundary =3D false;
  module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
  MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the devic=
e. Default: False");
  ...

But I guess these existing global variables are explicitly initialized beca=
use
they are used to store module parameters.

The variable I introduced is not a module parameter, so now I think it shou=
ld
not be initialized. Will send v2 with the fix.=
