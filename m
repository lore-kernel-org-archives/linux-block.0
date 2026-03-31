Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC7280037
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 00:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917445; cv=fail; b=LA0+0Hjp1o34mPUdOPfPDmJyB9oqRLf6k9qfL0YZaZXmWloT92KD3tNnKpbWg1h2n6Y9+TDpYYjJvDD/i825Oc/YfOaB9bU3t9kVNoV2sfXonLFqsLRLBAnZtq8DWUNp8/OybFBggPQEKyWobxBsPjzxHvHPjMWAd2wd6x/XCng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917445; c=relaxed/simple;
	bh=b/2jP2W6++i2BOK688Cl47abp8mJKJSl+rbsIwCx7o8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RRzD9im1URcm4npVNAkDN4pZL8X3wUi/7YWHdXMti3uABmYSjnLHsrN6vcVgOt1O/tiYUWrcpqCqBlARcy1DKXSCacn4W2HPLx7nR85Vvkkgwusj83Xgmi9RI23HbgyeSc98Dc0P/cUHcwmJpcjFEsJtMSm3KN6KAsujwKS7+PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ow09kAVx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BY5jfMeA; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ow09kAVx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BY5jfMeA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774917443; x=1806453443;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b/2jP2W6++i2BOK688Cl47abp8mJKJSl+rbsIwCx7o8=;
  b=ow09kAVxZRHbXVdDJMdIXJ6dJszijOfBvQJEjstimJMnUOhhG9L8zyil
   UfSAcNeyFB2xMg4qng/U38f3VAdgdcCxHJ/HeaTHxHt5m2Kc8Us8V9gaC
   OdB2YpyxNYr4BoLNg48R3m6e74IMmuEou2R68ApI93o25NjynrAHZY6B9
   S0iTJZplyq5lwcUK8SobyG73Iy2pdvEknMT9vJaGFRaOTNDPHoB95AOeC
   mYQrZiCnTmjBPSg9hpo77+ot3hhrbEBHcQj84vQiZBVZ8kM3sOPZNwjJ/
   OqEzDmqP795LmzcTuwNSOJNvze20G5ePV/0XZBeVIlky+pF56IFox72wv
   w==;
X-CSE-ConnectionGUID: f3/9Nr87Smy2E4fhX8oJVQ==
X-CSE-MsgGUID: noWLHbxgQdKYo7rr4BLDMg==
X-IronPort-AV: E=Sophos;i="6.23,150,1770566400"; 
   d="scan'208";a="143561895"
Received: from mail-westusazon11012017.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.17])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Mar 2026 08:36:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKE0SkIujGVdabYsy07Wt98llTPUGCH12MOHBrXL0j+Y9DxE7hxnF//j6T0ZJS10sfQwY9PZ9FH243VYg4sfC4CNwLJmQMPt+NyONv9KYCw4wFGkKy411aIfTLEGWRk5KX2kZAZvJwHzLyp+q9xZrVqEP2I+aCtJ/N2lwK5OVf9l6Lf/SapMrMKW/N+v4BoFSxNDK2+8t2Hk5v6tucP2+6mXi4XDZ/A8YCzQgBZ3sMyQRrXA97v/6VwyQ0B0DTLm2Ul1AuU6gEunwF5wjpjda5YZO7Xlzt0GoCu2MXQ/J5BuE7Tvq2WQKSJS+2u66Ix5AvLrZatB2Gbkx0hxHdqSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/2jP2W6++i2BOK688Cl47abp8mJKJSl+rbsIwCx7o8=;
 b=fRKPdYDhF+Hep6WNtQIm4b0dA0okQfB9odQ49vFrqRWxktjnhjPpLhgEMTJe8E8udxoIbps81Y5pDYKfr/bhxScpkGLlXsa5yYNWg5DKUqq3dIz4/YW4TIgpR+Rp8I2GyXaTk83xbgGe+F2R2xVBOgC6l6qAIKm8QmkfW3Y/PMi/Hz89/LsP2vS9HchbeXdfz78X4HN2aUDV5YJOoZ9LGDp6NhShn9QTIjbFNBWcUQMCPl9ak0cy6ON0C8Q65tC+4b46rRqp5gdwq/X4TF2zWp13vgLiA03XZoGt6u92rtDxQg+dl/9mKV/JQrDRCkaZlWQkfSA+7RC12GOpZrv7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/2jP2W6++i2BOK688Cl47abp8mJKJSl+rbsIwCx7o8=;
 b=BY5jfMeA2QLhchX/1Z20Zj/tAfEHrP/UBjNGKjC2etEqNuHOx/pErL9XYr6oKxFWXZPnz7T9mEkI0vjKauE+9sIXeZEPvEapnND+y9HvuQ66vVR0TRb5wt2FzPG08yHajBwsjijJgxsNyWzLPWT8Eelhb9TXQ8vZj32aXX4j+Co=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO1PR04MB9536.namprd04.prod.outlook.com (2603:10b6:303:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 00:36:12 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 00:36:12 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] check: Suppress kmemleak scanning failures
Thread-Topic: [PATCH blktests] check: Suppress kmemleak scanning failures
Thread-Index: AQHcuwBh+N2ktJcdDkalYHucAGtcHbXH1r2A
Date: Tue, 31 Mar 2026 00:36:12 +0000
Message-ID: <acsW14LSdqipbfJd@shinmob>
References: <20260323200512.1237426-1-bvanassche@acm.org>
In-Reply-To: <20260323200512.1237426-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO1PR04MB9536:EE_
x-ms-office365-filtering-correlation-id: ab5f5997-ef63-40fe-21fb-08de8ebd82c5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 cL3Ks3V1Cm/SdAzIudH7jilOGwhhwX8qSjs3LTzgw4C7ePOb4jMk8+moN6kzaGEIA8+O4TL0pewIEU3Y72+i+GhkMfeT+JoGTdhOJAbt9e00WpWbwFbJKHzfz+agXqWVvGVZyDHRcPVZBsh7SWQ6SNpZtSgAP0kRJx9kZY4X6yB8QvOEzNYO2jdmpVDwIXle0eTmV7e2fxZUURSwAhykENB98wEmCVXV1eKSreNefwh/hvg8yy3UfaOTFQE01Bwnuz29aAyydATC2egg0+Q14jqy+bqb3IzrX2PEs8FLbXGccuJquDl5m/WFpmO3nvH6/is7GvpX/WZvtzvug9hPbRH+G7snBP0sD7VauifJY8sN8LytrxKr7FV1fkDDYqVUXPaVVNHHVSG3NM/COxmOdJXOkgVqI12CDoWLhVlcUm823gsJbVglI/gxC12yV4Xv+krmkj01w8UWttlWmDobSsmQnl5rOJV2llOeUlMwVLo6H9DmPyqARxfd9PmG8/NXXOPMah/EvDAkoWV8QavxdxlC4UtpmcWzjSwCMeeF0B2NfQpmUe8Afpli0o0av3VctsBIfhgWJXP1xjtsoBxK89jS4uJUgcwI9foXQsTkYbLgWrq5Hu8Sp/0fujlaxaEzJkd5nr+q3ExDyxnLKNIxOJHaaHeErcg//0CDUerLwZfsjjvvBAWJWLebYEzPBVvAnE054IbSDblhHUhtBfsL7U/Ghb3viTiilHFxeerDsBbZCsr1OnkJdM+19MBLq88MBmjpC/CpSd8viWOFcVvOtwS1bcYl2AcpbhA0pEWqsiw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HpWpFn/goF7SZFrjkXL0iNeDHm7dudubzuda+WgHV/oNCo4byKxsaPHEyfL8?=
 =?us-ascii?Q?2NePyEQ7kKO/o/1xQigiGulK6ULY0cyRVMl4xb3/RzCFZQAwnRti443p+5Hm?=
 =?us-ascii?Q?dmOO/oa4qZZtGz8uZfxO/cl70YfP6rZsP7rx4j4WxHADpSFAd7wghSSD5fiA?=
 =?us-ascii?Q?DP098nGXwyC3os79vkSaTfpOxzfpxmnUnhCIy34FsD8DNewch7vXiob++AVa?=
 =?us-ascii?Q?IkLAsObK1qdhjJRtLr40WyrCHW8DeW2LvUNxKaeez5mSjLHMoME+N7cYSGdR?=
 =?us-ascii?Q?juPL9VFNUqHqaIESZSu2HsAUO+PONIy2IX3Dg8U0HlXHAPNHXkxX5490BmQu?=
 =?us-ascii?Q?jsiwxwxgYuHjqQTuR0nemAcvS03/PRZgojgG3hjBnWq8TNe6kU1tQ2GhV1YD?=
 =?us-ascii?Q?pLlPRJH6/EPKY2c29YtkK6fmdct0nXss0Y9Uj4UHaJ/ta08m+LDN5jMo0qrz?=
 =?us-ascii?Q?GClKspx80GJ6cYaWt/yndOpCtmYzi5B9gRqecshUem8y67aOR8jXRNuS5DIS?=
 =?us-ascii?Q?R/FTwWTNBPJsrSfi7gygnd42cgFlyYCB81Uvwk8YHrbkbFIMsKrJpwLoaUTL?=
 =?us-ascii?Q?7MbSXY8xyw6DlVt17gZ29Gg7Xws6C4q+iYqX6ok0bcVJoj8EYnyCM3M7OoLc?=
 =?us-ascii?Q?UI2AIvO8ITkQ5nLznpbhKoopij+aXdvkcC1F15bfzSSmw8dsX7Xqt3/YI4en?=
 =?us-ascii?Q?Z7wKvhfa4NczAoQ7ODFjdqOCwBnoyrpt9NQwHj7pWw4l+/m5Zfz9lHL1gb/v?=
 =?us-ascii?Q?XIy2kVUlhtgBiPK9Tb7NriZCp5g3mhibIOCCktdDYnXPgJPKKYN0WUFpls2K?=
 =?us-ascii?Q?lxlpCdWk74/y46yqvnKGkLtPWn17j8f4Re3kuY4xFBUnY3jqZ2p0mUnHZsKT?=
 =?us-ascii?Q?WFSB+3Cpg5q/L4V5ijlshOVlgjq+xKHNFd+dV2guBlw3NCMEcczPMJJO6fPi?=
 =?us-ascii?Q?zNuu4Gupf6Fmnlyz8AoSFbXDE+3LcLOGQOEPHcbo0pAUEZlJ9Ys9nvoG4Sfw?=
 =?us-ascii?Q?8TNgguqHzDEsl4+Y36xf2p3dtiolnRdr49RhiuOzGYRlEAqZ8A2P8lUuPpZn?=
 =?us-ascii?Q?E1yZI7n3HZp0pu3Yrujd21pOHPzGuYGTywStYeIq5/eHqvfXfN9f8yGIbkxM?=
 =?us-ascii?Q?A5c/S7uVQZJ+sjKTRfgfqvbURRuYeU/oJGpAHG9IwxIp2+Sk/JLbqNOxl0ry?=
 =?us-ascii?Q?cEXxjzyDWBeuRsCdQsgZCpknZqW45hwYX9uQrFF7XFr252rHaQVfflnxnQkS?=
 =?us-ascii?Q?IGAZ1kLUvvCg5Om7xiD+3+1ceR3qhzDyTFuBvnAKN/xXsOA2E0G1N6xDbBhK?=
 =?us-ascii?Q?7FWwvj5YgL/+iRf6UZFnKC7S9vOp0U6ORW7wrizEIW1r7oQvTZqxaYViexaR?=
 =?us-ascii?Q?DFtiiY2z8WcYfLI4rztHpU1CW6OYwI/jukjvvucz8oZL7xp2r4wWt5dSiabV?=
 =?us-ascii?Q?mSiJEeKEPzKd9vuc1Kz0meb567eMIFD2x7SW4KdjbfDKgYPeg//gUYB3Kj04?=
 =?us-ascii?Q?x7+2gaW6leva7MNWiOKPusbDC9vt8D3PGCZrbEjYcBXM1YUYmXTrn30beprW?=
 =?us-ascii?Q?Q2ZdU7yq1q6hXcW8XtIk6n26PTAYRymLQDfxnoYbL7V7ppnl/+snheESzC0Y?=
 =?us-ascii?Q?1toQtW6fqxmmvQer18XDY6PfIuOKxJKq2WmZgTFSZUbLpmcDSD7NH18Ch8d2?=
 =?us-ascii?Q?RhZZ2jfdUGs7J/oOB9gTGb3/3PPypk1sXDuTlguYte/p3u1xeEDBvXAm8Zd1?=
 =?us-ascii?Q?QpABmdfiBBtHpu2npYOdrYH2/+6cHZ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6868B8DF15396E46838CCB720E05197F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	B/XVN3r++uImgConJOtzOZoPTtdNhJY8+WgHGmcW/7k2nbhsPhoceS9kGidi/LAgcJShyaQa/RXcO85yhmwUl0h5R+b9ZFmN58xk3tNCUZYypmGSl5KSLmxYVtKNCGo7r0EnMXYSZjVjWdq1B/Vf8c/j6/VmOyI9lIPNo3zsKmDHHibRHAnLK0PSq0DFbmMlGyCM9NpWtJU29/42WPhB7FuO/7/cLctDfo2J61uipfEGuLVNRYi8eSs4YjjSceDYN9hlRdJ0CDkxKp/0J6iMbsu46Z6usNo+mVij53Qnv845m8RrYtKsJdXk/+YSkeOPwHca+48Fu455PlO6IFq7EQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PZMzmJZweQIng3S6WNKTyjRmwytVeFo15i/DC8hm9nkummsb+1GBuBBb8r10kU2b1tJHwNLSvZ2bSoXKdjMFa1kgIQgRBUtcpIUAVSmYo4XGR6EHGZa9yvOQzUd+MigSyawGkSzOJWJFc8NG+kxj8Gl+iWqxU7xjMVLZeO6t9o90gcIukapf/29g8j+SiTCjp2n7GZAtMLo7z/1ZIXAKDyeiU1KjbFfFdqrRak+AizULsyBTnTuK25rcDESh9Edn025r6Rg6Q/yHe9bXzt6/fnveO5AeJNylXK8kO0S5Mqzr7wV+B1tCNfwNnG9MCwElHL8eteGW3eDjGG+tKXmp2mZlEIHvuWnD1lQa5nRAD0tWBw7TQxH6BIeeOmlHre8l315oW/BgXMNSXpV29NPCg23shysHAAbXBeQtTHSx9Gl+nx8AHph5AFKih+Q3fLoX9c7yB/Z7XtA+MBeL82xGGXjvzal46WfqMT6hpdXiSoalGzidPEHVYXELwY2v2RQRRdyoHCTke39XmHAlXmtx1jb9bI7m6/AIL4SzONeOfrDenRMhY1+03/Kvp3TR3kPYa/py1EP3wwGk9iHtJQA4dfm9sUpI2gGek5buq/4IRe+BmrXfKLjxDmFXxIaXLXMp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5f5997-ef63-40fe-21fb-08de8ebd82c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 00:36:12.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B47zEKwVuAxo+gxFObPtl0iY76Gqjf+798iM2g77jv+F0QU9pBoxCbJ67zY/T3b1MbFgahI66qpLnri0oFM7LSJNkmFQkLrR+L6llsBY1bE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB9536

On Mar 23, 2026 / 13:05, Bart Van Assche wrote:
> kmemleak disables itself if an internal error has been encountered. If
> this happens, any attempt to write into /sys/kernel/debug/kmemleak
> triggers the error "Operation not permitted". Suppress this error
> message instead of displaying it on stdout.
>=20
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thanks, I applied this patch.=
