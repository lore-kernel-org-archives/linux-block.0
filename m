Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F63A1E7E;
	Wed, 17 Dec 2025 03:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765942254; cv=fail; b=V3qRSKNj82hGps5l73tcf9R6f0V4KQoHw++lb9tQts4Sl6fgEwp5kuVTvlkgDh4FDq4OzcrsUGg9I3HfayJTLZpco+3E1XLBXeVtjAHXmviYOXeuOCbFxmlfKGw5+5C9aHYBD29fXgcpsvuibb8xxbYxKIzHDQYdBGkmDltlSxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765942254; c=relaxed/simple;
	bh=WpB7bmcD/752ATH2F4N1RPlVieRYq9NJwGwebJnuYHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L4V1JUy2v9O+LTXjhzA2jfaTOzV/vtvRf9LpElSeULeYfCWdC8sfR/8GeWEBoLE/rgv+AFC/PZ5Bc6/dh4Z9J+iQy5gB9tw7zFw/pKyd4JO22f86+eiJQvAq6AJPIVfCfNcdgl3Uu0pVE8j82meAWboRodNK/pXDREj3LqoSrp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jAq9+r9r; arc=fail smtp.client-ip=52.101.84.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jAq9+r9r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNnkDUE/jJeNEXZOp6str75cZxGrhxRfuiOnpnWNYLqVHvoLtcg46H0AAWEvoylTkK0WqoQtktsOYFDLhaVVBuzewHrD1jiFAFquOeRPdwF/YriVO70drCs52CdUNg8Y0yeoowZI02D96GG1HoxDpIkDpkBJc3UmZtu5rrlOYsWign/laLFAyNAB1MgYNG84rrIZ6xV+CaNYPA0xlohSG7NPrDHlAAHgfu4ZYqpg+UrHC0R1JX0J36VnxlC8XlZhIaFg/VbMR59Heaqz//VsY+gdY0hlH8Uv3v5NtBkkQCf9+55eG/I7aQ4aKIuDB/n19pcNRmj/oaUgxDE/9qQT8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpLktXE9N+thpZTrCMpOID6YtoCbn4zzG6SP9K6ct3E=;
 b=nYzO2QATq2Tudh8j4a4pzPgYmlxu3vD7xm0hU4OX7iUOguP40/cqJSBCRa+KRIH+3PvSyNseLjs3tuVOfdWmSqogRvy63JDs6VVYr/RCEhcLOZH5e/SUZoww4EuJwEqhMynQgbn97wmujleybCMXk90G9o+2eS8DCURDb5QzeHLaQavzrNvmLIVF+toSLqGL9USGcevL9bhEd6z7MDXeZSGupSHXa568veVcm01Pohi6c6TBqsB0McZTm0r3Bav/MkRfVqhAG1MopJbDa3NNN7K8uiluklo72uG96Ve7jM5e9PqvAshvS31XKuDcyK9DnAHn4wkxFlUPhcu33quTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpLktXE9N+thpZTrCMpOID6YtoCbn4zzG6SP9K6ct3E=;
 b=jAq9+r9rA8zYMBGx4lkZ4jPp6MR9XHLWj8rMYK1WJddwnMVun1aM0EX/W3z9SOt676hh2Aqn3kFxlBh/QHA4y17y3RIKggmUSUBJPEBkGLG5h+zXVaL0ah4d64bIRlTmZ/gLhlrlWNzxps0eTabc89xH0jW4xBSMbRjofBSUO7Hi48Q/1r5JcgdJtFMm3sA26Yg6u+FCY9a+0a/lZnnJlD6sxcmj1Ehv6h5njqkqAU2ctxFyVL4Y1i1w2pwrJCO7fHyR3P9/p9XuQ/AFsw2MeNqFaqv5HF+CEBbd/OMU/iX3GBNefetKgx5r6DkRf0H4xrVbBrV9mJLHTbDE0+r99A==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA3PR04MB11203.eurprd04.prod.outlook.com (2603:10a6:102:4ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 03:30:49 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9412.011; Wed, 17 Dec 2025
 03:30:49 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v2 1/2] block: decouple secure erase size limit
 from discard size limit
Thread-Topic: [EXT] Re: [PATCH v2 1/2] block: decouple secure erase size limit
 from discard size limit
Thread-Index: AQHcbawi7YpaMPP2e0WrCcsPcWXjvbUi17EAgAJV9QA=
Date: Wed, 17 Dec 2025 03:30:49 +0000
Message-ID:
 <DU2PR04MB85672571C145478700238C21EDABA@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20251215102010.608421-1-ziniu.wang_1@nxp.com>
 <20251215102010.608421-2-ziniu.wang_1@nxp.com>
 <aUAskIkCHiVmKs87@infradead.org>
In-Reply-To: <aUAskIkCHiVmKs87@infradead.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|PA3PR04MB11203:EE_
x-ms-office365-filtering-correlation-id: 7bf3a2e8-83e3-4995-3aaa-08de3d1cac7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IxwHopofjlMX8GiKEyhQlfas/cJLvlzNUVShkgbA9M21yVH+gorELknmWgTa?=
 =?us-ascii?Q?hkGEjzH/AtRB4ZuYfPpN1neayoYtEhfdeM2qcy9Uw7p02soz+jFO0xba43/i?=
 =?us-ascii?Q?NUpAB0MQhW4Sz6CZChFCYhOIu5DcFQGOPtIuUMs0Q1BIXYGKb0dxDiYSNa4P?=
 =?us-ascii?Q?pSFfkxJtxt4hbWeuWGIicCDbteqymUvOgAsFWqlcxEAqLj0l9gWDXgxFeGZm?=
 =?us-ascii?Q?Tr49vBGQlH7NaT1SHsXQkSlzTjTqYhlN3ae45CrIYXXZZmnvcrlPWCbbeASD?=
 =?us-ascii?Q?6sIzTFo+6u7TjOst9cjjY0OhTFyFsycovLJhM5nbnAuElh7q3LRWJzo6vzYJ?=
 =?us-ascii?Q?nppePV3BD4czK3nIstClfdW6ummF5ZEoi7CWIpAsGcdhHY284/gg6TBIYypK?=
 =?us-ascii?Q?txSUbH6W16dE6jk2ND6ffvHeVqQE/dsfz37c8O/dqKSgmA/WMad0ma7ewOlU?=
 =?us-ascii?Q?pbNehR3RVdJyU9ztdhDAyc7FYGBIjC40sXgoIPJx+JTPtPDDz3IShlQZRTdo?=
 =?us-ascii?Q?PwJ3vjpMtCmOavwKkW9wyeXYWxynt3+XaLpfLN7V2Jf/UgYzVeGSY2cBlRBv?=
 =?us-ascii?Q?awrIiD82TN5K+ujH099xR2PTq7XcHhvD/lUgIr4uZMZNOIj61tftAg4rptTk?=
 =?us-ascii?Q?jvyhsC+t4sS6WMvWILwQ1PrWpv1NFOII/IG70RfE5ESZsHLvEhyfFYUubzWK?=
 =?us-ascii?Q?LkH/V5WoOfS1Xnk+cZBdvTw+F4w8nu3InBtMmSXpfg2zUNACJ0HT8LyoyTgb?=
 =?us-ascii?Q?F3vfqqrNj2g8weiotnWDBQfg6TExpomA1yorx4Vat2OktQDYlfOjIGckWT2y?=
 =?us-ascii?Q?u5X5zFCnf1WIEW5iWIOXNt+LJyWCZq7tct5kz5jsgGoBphCGM0N4jV0iKkOS?=
 =?us-ascii?Q?/86KasEjQxKXYycLbfyGa0nzrIRbDuW698akbcc6+hDfW+fgW4krdrvTL3CH?=
 =?us-ascii?Q?5j7WfO6sw+V0bIpW9vrHyg8/U4yNIgvVDJy8/OqF/0NIbjNO7bfNmHkICRHp?=
 =?us-ascii?Q?WFYXTo3Vc0ZM9vF/D8m2nSrGAR67dF8pgf80MQrGa0W+u4ArP1BGKsPpayP/?=
 =?us-ascii?Q?NxjlIlgk6hmnRK+NQRbVuAl1W9a+NPepB2inazjuzDFJiD+dgU5g7o22qHqF?=
 =?us-ascii?Q?OlCWXzSRm0tuC8+Jly/t7zY9RB9WvwaZmsmmXW6bYmmO/0SLF5AhmpKQE4iA?=
 =?us-ascii?Q?km+A/EQaFcAf5+X4UtDpxawY2IakCsH8s3mPKlxph4TSoyd+P0eq6OfKE3Mk?=
 =?us-ascii?Q?IPpuX9ZNN2QkHXN04bOQDGNnolb95zHMzeR+jbmsNsqbtUdP8TS6sLZc8wJ2?=
 =?us-ascii?Q?teaWYvA5L5Z8XR4t0ZLFalEK2Goa91qJgDtyE7yBaOGqDmDCUu1H2od30SBU?=
 =?us-ascii?Q?DLAEUSFjYmcKMSiyRTYUfapMvMGa5z34Y4iVc/T0JVPhmFCEHhPSxE9iKy+A?=
 =?us-ascii?Q?EzVhptH66NZXaOIpeDkpktdKk2SVc972xHxTQPP6Uwh0OcfbVgclM8+g0iR2?=
 =?us-ascii?Q?WUdsDho1xFjnJhC/btybPQpa41gyyYbfxl6y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S6pRjTtKWtes2GfCYSCmGmttwJLPIFAFIKkhZPiJIGQ3ih3PIDCbzL3fV+sc?=
 =?us-ascii?Q?SSrSMV8XdupQeLxV5Xz7/2visUwQpRXR3hvsBzsoTGChTz3ruzX98Wx4Oj8m?=
 =?us-ascii?Q?JvRpifk+RvLtlB5I+di07k7bSt8mRaiJfp08NcUfahn/JCHjW5KhCqja2hko?=
 =?us-ascii?Q?z2AI+rslpsg4u4rubBcP0wbCD/j8BTta9sQRV24nGYJsGe8CmCwamMltIiXu?=
 =?us-ascii?Q?faoV6ru9tXVRHahUhEGccTHQj93vI8A74KLFT/H6Nt9396F4GaiF2HZiJH7N?=
 =?us-ascii?Q?edtGzlG31EjhDnGyg32mx0B+8eGxpOWOSCsYX8XIROnpVC9zQYrGU9L+2wHE?=
 =?us-ascii?Q?z5RD1mGiYAapqid6faZ4Bw41O1s2zEIsM1kEwDhoF+CJMLEk0yhkW+B38Cny?=
 =?us-ascii?Q?bubBZPKCtum6+RkLOzTzi7Fjpvi/xsmoZ3V0qu3ho5clauD097ete6lQv90Z?=
 =?us-ascii?Q?h5v8tHhd4ntuz5TPLG8Mqw1oqYb6g2JVfutEhPqKuGXe684g7zbx054pKwcR?=
 =?us-ascii?Q?04o/6Mpgj2zh7bqgTgsWDzjWSlQwsa4O1YHHjXXwAG36djyJrBuRt08bbWmn?=
 =?us-ascii?Q?xIztfWweBNyaMRZCp6ktTV4Ry3vSFFscr8eOorneESUMYPNaripVDQMvzFv0?=
 =?us-ascii?Q?vZLIeLeVYGvENNqUvg7Bz8DwzkjCD8J56cTM6mVPop14cB7bpPb6O4IlOSXr?=
 =?us-ascii?Q?NbthdSF8z4aavYSxXD0fai168+ycZzV5P2ja9iOtIN6LWh3Cigc+fdS1hK7E?=
 =?us-ascii?Q?ezBUMnhyBjaOIcUjU4eiA4FPzSJ/+rOyHakAxLMJmlGWEuo8beoh5srlY5Ws?=
 =?us-ascii?Q?KWWMIbSNPKu8m8Dt/iWyVkAxV8aKBXpIoj5Y+FcjeE2giQ4WuM02aKVv69Dy?=
 =?us-ascii?Q?OWu12krHddjCLr7Z7Kp8cRQUbOzL3djlEgiodQewoeqtW7LwFod6THV1rIaF?=
 =?us-ascii?Q?IQeWmxzZRvnxZqnp+Ay6y6RMSyIQauCIxIKk9IqMBbFqPnUspv/7fFJyRt2o?=
 =?us-ascii?Q?IhndKA26ZS73LbUb1QVmOtgCq0qXFIK4gF0ZNjXu2968uLTmow00VFOQVYbA?=
 =?us-ascii?Q?oaFXabTyKxTeSOiZbo2svTU1qYC5JBElID0PRJbgFkts/zx4Vca2Z0tfFr2X?=
 =?us-ascii?Q?dfs/P5f7b0acwQPT6HQ2U67+SQ2KrpaUSi44bGiA93cjo71B3zvF6H2c1gnE?=
 =?us-ascii?Q?DivaQj5ZQvuWc76/NJ6LsUszMGrHbClFtcbHxVg6Tujnv4mF4zEkMHjauh9X?=
 =?us-ascii?Q?y3wCL9IzcfQn3m4ze7ADUb9ezz/z3pw2oaEQKcA6MiMhDGPo7YAaCKRQvycw?=
 =?us-ascii?Q?mRdH/+7OvE1zf8qeG5ZbOjCHjK/PGILwTAArFWiCGzT5R/1iTnOz183D8jgX?=
 =?us-ascii?Q?yNVSMeEF/2n99WAmypTlyUfBwgC5phwMMRR3knajMFFkJT7r8FxJd8t96fyO?=
 =?us-ascii?Q?At8Ewi3hPUfTqDMRC+SoC+9svBstUk1XErA7WMF6RiR0ESNyoG2jOjcp80ws?=
 =?us-ascii?Q?IuCAh1V8YLF/tHvk4e44qeRvGwaJAND6GH2oYqmcklYhRy/0z1dxUcH+L977?=
 =?us-ascii?Q?n1yW3qTGXJch1UJfuphbrTda2RuZqJVNMlIRHrvJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf3a2e8-83e3-4995-3aaa-08de3d1cac7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 03:30:49.5198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Scv0Afvvz9j89YC1clEA0bLIn6FCi0g0YAYOCqmB7ZLzp2rPj26RKlEhD9CY7A8OpQXeq0YosuIIM8r3FGVLpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11203



> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Monday, December 15, 2025 11:43 PM
> To: Luke Wang <ziniu.wang_1@nxp.com>
> Cc: axboe@kernel.dk; ulf.hansson@linaro.org; linux-block@vger.kernel.org;
> linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.=
dev
> Subject: [EXT] Re: [PATCH v2 1/2] block: decouple secure erase size limit=
 from
> discard size limit
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -169,8 +169,13 @@ struct bio *bio_split_discard(struct bio *bio, con=
st
> struct queue_limits *lim,
> >
> >       granularity =3D max(lim->discard_granularity >> 9, 1U);
> >
> > -     max_discard_sectors =3D
> > -             min(lim->max_discard_sectors, bio_allowed_max_sectors(lim=
));
> > +     if (bio_op(bio) =3D=3D REQ_OP_SECURE_ERASE)
> > +             max_discard_sectors =3D min(lim->max_secure_erase_sectors=
,
> > +                                       bio_allowed_max_sectors(lim));
> > +     else
> > +             max_discard_sectors =3D min(lim->max_discard_sectors,
> > +                                       bio_allowed_max_sectors(lim));
>=20
> Please factor our a low-level helper and pass the max_sectors
> as argument.

I'm not sure I get your point. Do you mean helper function like get_max_io_=
size()?=20
Or do you mean something different?  Please explain in more detail.

Thanks,
Luke


