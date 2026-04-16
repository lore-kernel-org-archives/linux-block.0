Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF437E2FF
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339849; cv=fail; b=tN2HF8xEZM8BQLN4tQ2dyXZSJn+rpdOpnNlQ0UjvPRuDVVzESLp/whI5icMlt4+59GBgTLSEPJAriq/q/4QBlkKcSL6SpSHELM6QbDtafgGemHaYyV9Lqwu+t5REIbG60kVWaMgOcQ05Q/GRln+Itk5iYUCju335KgkiBzeG+4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339849; c=relaxed/simple;
	bh=PPrqvO+Gywc0ufCw1Z+KpJK+S2i9QjSvPtCeG1y1FI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QCr56j3fjca/1U2+Zuj8W7Ur3IsnHT+5+r+zDbdIISeiLV8f7TnkXYFFsHO2NlQ1LFGxIIgHDkpA5hpTSh1BmyxACjg3rczFTWgptpfJ6gda4P5Ix3g30iwrurnYu7MHXyEVuxp+KAdIVz1bANiDLW6W9l10q1DARCGtTqondn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WPEo0uHV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BB0Ea0kq; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WPEo0uHV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BB0Ea0kq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1776339848; x=1807875848;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PPrqvO+Gywc0ufCw1Z+KpJK+S2i9QjSvPtCeG1y1FI4=;
  b=WPEo0uHVHV4TAFVwkJnCu9KEvei8jR9kWrBRl4pxlIt7w2MOdWHy/5AK
   T6tlZO1BdALhTGcnXE3ugfiGu9AU+b4vRbz8269ALgLNHa6GC9ZdjGALu
   ocjlOXEyqA84f/WO0r6D50JT/kxc2UOySUqV7deNWcHgrFPlr7h0Df2QQ
   yhp28Kv1UPjpI0l8cQkN3tTyEPs+SDyMXvOOpBJJ50J7xSLFqOQK7eRQq
   tAs6WkCtxB6JcEYQrZbhp89zWcYQaHD4uqSSrh2wQYEd1RK+Pzi9pXPNf
   GDlWnuXR6P1yIksAgfiFhLpP1+IK4HmKk8lnEgInu1WhVZja4Z0LtyqE8
   g==;
X-CSE-ConnectionGUID: Nub7irnkRueRiudVXjDUAA==
X-CSE-MsgGUID: M1+Yq69QSMKoMCCsiiUaUg==
X-IronPort-AV: E=Sophos;i="6.23,181,1770566400"; 
   d="scan'208";a="144150293"
Received: from mail-southcentralusazon11012026.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.26])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2026 19:44:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7QaYTOER5bVbMm9ZVRXVgL5MHXDNhTQkJbDy+6C1XMVrcNUELQ9O1z9/8YeBCDTbLgs+qXHOorK6K9QHjCEFk8+eU5blrWSZNGHy3tWkJMLwMXOCdrtKyGK41t6tjWTmBaHJYrze762te9I38tInEQhHqORFv8HohNcYELXwakZRDZEH04QZu8i+gsa5JyhpNzXRvHRhSkt2anhXRhNJafftHryAoR+1kHNDNKAwNyc8soYUZG5uC56ZKDcc88n6UUkYC24TTOTujNh2/Cs6jg6+DReYtas3yWFVScvjX2i+g6t8Lp+PYBieEINIRySdYWox0HM9Pkw4CAS18UJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ2e5pxwwmEXbOFUwlAe5kk9m/9mw7a6zuHTnnypiAw=;
 b=hWGxapTO+MrvMWcz5um8gXdSPY/opnvhAe4NkO5s13u24Y8fmV+VvMDaoH5ol2eawTRgxE/mWeeOuj3PS9mEcLwGbwcUFRhK1TJ9E2Gd8GCOGB1wQpNGDz8JhKVFR519/42owWrEjGjB0f3W87bF2tG5GttSXTlp/ux8U5ytABUtOYgu3i+YGuGKMdRVAsJOKwuez0v7ALeofVddif1P7Nk63mwlaxFQrxSUmPCy4PrzIsKip3DKYUmd9akc57ConjsEXmKSEP6fcleRj0R/FDFndGs+WP43XQflrQaUgNOp3P+Th5TtQQtNGlUxKpePNkw4kA+ZSDdfye8pN9VLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ2e5pxwwmEXbOFUwlAe5kk9m/9mw7a6zuHTnnypiAw=;
 b=BB0Ea0kq0FXXdTIdFOn7vBDi6Jow2mfPA+IQK8jY+GQowZkOCJhGYRUG/wjOaACUHz+TZy5TABxEQHUVTzFg7/+aGRFTU1kLwgYGuCRwfWDMICB/4Iys5ORM5BgUUCpL2XCVGV4CDNT6wKz2H8UgJoq1bxo4qkjsPV86C6a0mzs=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM8PR04MB7976.namprd04.prod.outlook.com (2603:10b6:8:a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.21; Thu, 16 Apr 2026 11:44:04 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 11:44:04 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Yi Zhang
	<yi.zhang@redhat.com>
Subject: Re: [PATCH blktests 1/1] common/scsi_debug: use _patient_rmmod() to
 unload scsi_debug
Thread-Topic: [PATCH blktests 1/1] common/scsi_debug: use _patient_rmmod() to
 unload scsi_debug
Thread-Index: AQHcyKshmxChuRdXPEqOou7rkO97W7XYfnsAgAkc1IA=
Date: Thu, 16 Apr 2026 11:44:04 +0000
Message-ID: <aeDLO7xKyOBkZpDu@shinmob>
References: <20260410053016.4013504-1-shinichiro.kawasaki@wdc.com>
 <9a297b35-639c-417f-bf22-a20742a9adcd@acm.org>
In-Reply-To: <9a297b35-639c-417f-bf22-a20742a9adcd@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM8PR04MB7976:EE_
x-ms-office365-filtering-correlation-id: 123e3c8e-4181-41bd-29a2-08de9bad75e2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 MtMP81GNBOinGgedUooQX1DV1ULqnrTfcrTLhz58KHD3+yv5hsWLyBxoew3NlWmtYitU2u3EBvZGm5pDBiVNpXAo/uVdrIfiNcoOVRZwcp95kAl/aSdobNbLUH73HBiPfguHML5BZ14zaNzKxExkHPkZbxxHz1qia6s8OlfDcrexHiRM7I/TVyNpxJd04Cn/9cPvgzsgI+S7HqvLQd4HlSXEDQRD7ht9YeIPbmqAAvi3ISW1ZOmaHafHP2qhuBvlJqChnd1MFaDfNfnEgI5z9+KZoksEzWCiSVWYP1esZ7ARseqmSVk+xASUCHN6/Ka9lBUhfd6lOq+YT28dkxUlfXLJDmgRbKguccZMwV/Vbc93DmAncETEt1JmjJkjQiHdSYNXGaICHjJGo5dDtpwWoM4vYtEcpswTvfSCt3AB62N6S//QbEqdReChFRMssI1qnIz883OHXpHrv9aakTp3voheSzihgIXvS6DOsudF4RD1UtYhYExitgxAmHETpr4XORo2dSUXtA46tnfkp8ux0/8xqHkPI4o8dzqOo+51wLcmde5RIIwr/8DEWfx8XelFHX6PGQiMCAsxSwQnhUIRenGy7y7kw7ymZFHiWZbccqsrkw/rnZ66RMbfXj0Gmmbi4ZpOzrU+3ykVK8X9IkID14Y3A798VG6wYtohoyGmjK1AMqr7sxxwITVQvGRZTFjwxVb15VJWmJqRIa5XjVTVFeVlwVWprIO3fl08hkZpjggpgKfG94i4VV+huWoAh0UT8Z7DLSf4h8LZLh+1DzuNNr/Ruz+NiH7T2mEGgJrrS68=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JezigU18GMuEsJJgTCKOAJI/ZINGM6oVslP0oOB21kisdnBeStXKSp4NQ5kA?=
 =?us-ascii?Q?/GrT6eQArTE1AiQJXRiSk862pYXQK3em2+ZpLu9t2mw2DxZwYS3rBTnf3SbH?=
 =?us-ascii?Q?oRQf6YW4fFC1fIrm+WTWav/efX2iiyd08EIkBSZkeE3p8CXJ/3DQ9oQL0miz?=
 =?us-ascii?Q?+pqc9PDqcdQKfTXSn4CoDMfV+FkFR23NQdcyvVTC35gynoMy3ZACeIo7qZLL?=
 =?us-ascii?Q?pFUwV2VTBrmJ0N5zginpFjUAaB76XMUm6QghHlHJdoUP0i4w6GYwGEnrGdR7?=
 =?us-ascii?Q?EG+emRVKpQ4jj1r0wcSXZTD8Gq7sKaKJqyrhKw+Vq8h75Z624wzbvRAjw992?=
 =?us-ascii?Q?htjVBpnbujvBqqDRd+XkhxXsg5e8S03hj45b5MA0wRoB/JgentqNQv4LndTy?=
 =?us-ascii?Q?9CjxHut33fkXcakVzFf+Hr51acRo1FMbv/GAecMOlpu7yJRzlTqZ1oOW2v1x?=
 =?us-ascii?Q?Q9Z4TAWfZfn+zRhbUIFRQc+o+MQ46eAcl6Xqr3n6xjdrTXo5VTtKFISXN7J+?=
 =?us-ascii?Q?YKvqVcDdTLj9CIiE7LVn9+KqNxnlI9kptj4hmhLV56ViPhjmLEwQqyhY0UVm?=
 =?us-ascii?Q?ubGUow9TOPizGaYrhNJXFRBwuU4zN3HwzbCxCFp7QXw33mM0eQCZt+Bz14rm?=
 =?us-ascii?Q?o0eJUJDLpKANEAYPuLe3qmKY9/z+cKIO7PesJ/Da3JTpDQU1EmBPnElqcQcK?=
 =?us-ascii?Q?CwFh4SuDQvaG1ekL97rbKxlhrznQXdtqj6dk2GwfeNVSff7d3qteAthy5jgJ?=
 =?us-ascii?Q?SerXdbZWqdz2L+P8jemuR8iq1kZ1kJfAV7D+vuJpaMgvtcLzJ4NGObuVrryd?=
 =?us-ascii?Q?o9Qis2D47PfEguJCOmpwvkH5/NDFXGWZHehKrp2UTVTXx0punHO6/+I0W4MY?=
 =?us-ascii?Q?RhsqwJaNPWTqzeTt+dzqn7smPWpRtvf5r1WXFvGVq7ZJN+IF/55McHNBk0Uv?=
 =?us-ascii?Q?DPZg66ZNa5YnqpOdpF2aTBVUPRA+H8xd98s68UqZB/i+AkOw7llYM9JSba/j?=
 =?us-ascii?Q?lDlkSDqJwI1uI+wbyzsfClKGV15WgV5y5o3PHEAXTI3QA3ZLoyFUcUyCjvzj?=
 =?us-ascii?Q?NZkqv6qRdRkz41YuvaKMy2ezRu2K3W4xUQmY7wh1TYhYjmdfDClWL3pqrgbv?=
 =?us-ascii?Q?/nDPPJ4+5Giv0OGzzojWbTssYHuK/T6sF8C1dIJFs3DYYA+Z5t7Fzpjb4KaW?=
 =?us-ascii?Q?XKw/YAU8vFZ6XBzU1OMUmrSMmK3wVylTv9O1kRAQITy9av6Rv4BijrbpMC/T?=
 =?us-ascii?Q?IZl1fARsatGhZU8nIugy9cM0uETgIHK+hISgXzt3C3skD1t89OXTHeIh8PyE?=
 =?us-ascii?Q?yMzLsHRr6D6BDboFEHNJVG+z3OSLUCL8y4bn8rl2x1ixXEKaOeTIQyPs53Lw?=
 =?us-ascii?Q?DLsam0hXOqZW/xh9TmA0N9405+HEhPXKtdXmboyO6oZIOHDf1BXA/BXc2vH5?=
 =?us-ascii?Q?kwwUlBTYO/d3gr7xweJWkm5bHnm86LYikkmxQt/fJRkHQbW1LemefNAqt/6f?=
 =?us-ascii?Q?Nfn6rdsuC4dfpKasmpvADQo/ZjB8r5WttJHNfiKQyc5A3MOWiU27L1DkKStP?=
 =?us-ascii?Q?GeUQoFwzNk9pONBduOp3QNeByFygYBssELP3DyVn/b8f/OOtc7zrMhJ6gleD?=
 =?us-ascii?Q?TEkbh8kj+Ghup5jBAV3Ljxe8bxzh8MalK+jeetX5eXRHVCZbRGTJYDPtGFfH?=
 =?us-ascii?Q?GaEGV+aJuSq55WcYSKJV7Fswp9aMAOMdZUCj2cRxMlC/9RbexDfsvkNVOtVB?=
 =?us-ascii?Q?rS/XBio0m33PT7EgI7B8aOG6lJV3bcw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <734ED21B2B83184BABFED1CD48E9493E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ghhMxOYQra5MCUVmL3QJKvfnAH0yLzu28wEZ3fEzD+xAkQ/4Ok/mqagtKOQSoXt+Y/0B+xux1382cXHkTTStXzuqNXIlv/tYt1LGPI9KgHK7jaQiy0shIa8k/QgIoZsebNQ507XancHYImXUJ/qARE5YqKJ4z51r1vl5OIrnY3o7Z1mlTy19kOWBN+LeN8VvpJUzHxg9CS3aA/SxooHYXSiPnvyHiylDdLUkWnJKClfiNvD+7pDCtrrxriwy6JEl0RuIY17vO8PkWQ0UKFUOh7e+AcxbUj0cSNI/Pp266Qc0wUSSYeb2OoDQoz9s5PGrNfPt7IXGEFPRPqFHloWpWQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vxZLMVnGdt03hvGLFOpWIajpABzCq3fCncvV8Wkfy3SKT/MhT+yxVxBQttwd5iBFfQ4p5iBiHD8ow5qr9VbN/LiA3Vp9laII4aS3aszZRxrFFRW+quK7SZRg905vUbuZpwO5HcC6n+CR0RTB/gTm5HK1Bunxyth4/YWu+fUO5F+XvEE/jvPhv9s7N88aldkjT2jPTMPjaTowYhGrrPRf0CmTpx7yJ8LJFu6xFryc1N4QqJOra95DmaOkMjQLjztay7j9WId09ti0W63hbLw19Cc3Jyd/jM0a3G3oKzgxmlhgLTVP/8BYpvrTVbLUctqI+V3JXpxxGLUi4PhhkRD8YobMNBII3j05rs/5rwlu0CT/B6N1FuvC53JwsxNBSdmaaVIsWs2zhxS42hstp6AyUnmAklkG28fGR8r4zevCUeMqv7Z3NAuZiRzcHwjrEC+5MSv/8atp6QBrN/sArk/rcJA5Nm46MbWAwLw3d7FRAoDbNQnd8qvoSj/9onehz7oP4F2BuWIFw485EnQR+PAZ9bbzDQz40fyFz0/5/t4+ckDRJlQr3Ml5C2TkNSYSf+i4an7K7Vdd+uJrTz5dJbRYcABcP94NWFK1VVdTu04PZLwbULv/95Tq+QTtkbJ/rs06
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123e3c8e-4181-41bd-29a2-08de9bad75e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 11:44:04.2443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Is1BTMAgijIWyk3ICrtbgSVXsXJMp521I8FdLzny9wOVRGGKNsw/enOUxNY4EbrRghRTd1f+ftXnfjn7B9pR5SrjI3ZJyI9ROLonYM/Tmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7976

On Apr 10, 2026 / 09:34, Bart Van Assche wrote:
> On 4/9/26 10:30 PM, Shin'ichiro Kawasaki wrote:
> > -	modprobe -qr scsi_debug >&/dev/null
> > +	_patient_rmmod scsi_debug >&/dev/null
>=20
> The output of none of the other _patient_rmmod calls is redirected to
> /dev/null. I propose to leave out the output redirection because of
> consistency.

Thanks, I completely agree with it. I folded in the suggested change and
applied the patch.=
