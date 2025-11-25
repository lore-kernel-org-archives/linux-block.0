Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131263115A2
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069997; cv=fail; b=Ew2bK03RwaDmRBctf8F1BAwP4u0SXX9IaJcwv9Foz+zrFxScOLLYFHRx1bJgk+SXSxSYQfy3pvg31iiPdrIP3QuGTAyrMaqq3Oc/vcz/hLtFnCcSErG1YvISkOmn8KtXhitvjhzbshfYyFp7OrGG9ex8X7rMmEJ+ClpfpDUIrX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069997; c=relaxed/simple;
	bh=O8l7qsZe8KeldvTeo+ztcO3LaZSOjV+wqOOoObxV+9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dUrdHfRDlyOPjy3ax+HV7c+E7YSoAqY/4eYf06SvNvJI+AFSl1ERizS0dRbgxCYMZ3UvM3rLKxAmz7mkmzzwtudMv6WCtjmGL6d0TwZPJxsPbqcmR8vwjhkWD7UfUj4h5LnZtzOYRBJ9j2sr2tqujDzvFmDj1OdrV12n/GTC52A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nqVe8RwM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HduTII5w; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nqVe8RwM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HduTII5w"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764069995; x=1795605995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O8l7qsZe8KeldvTeo+ztcO3LaZSOjV+wqOOoObxV+9U=;
  b=nqVe8RwMcAWMMm0PTMrokOStanS53BhNX6tyjQobLYkShVNuRtg85TOk
   fwL4n/goXM6b2GchygftFrDHVoK7XE5TyD2oxH+YP/Z9u/jp50F+FvIsk
   RMPaNlOSbIS52szVi14/W6RHVuKHjuWi8Kr4kfkLv+R7+peMjJWjAy2lv
   AO+oULHs+IyEdc8JtL9WChDOYHnSkkuF5arcN1aUIDWiEru1H7+IBtLjO
   I4VaMJTcpKa/GHJ9YY5p7Eg4JVI4dl7UAKdu0wsZZP4TvCRKqlgTOdoIt
   UtLCHeQG6KfHXXNRLvyLtR8XuTmWe1247geNJh7EIe2y2jLmABjpMwxSB
   w==;
X-CSE-ConnectionGUID: VPds9WdnSByLakkGI80HtQ==
X-CSE-MsgGUID: MtLmqUoCSVypQxSX+VMXYw==
X-IronPort-AV: E=Sophos;i="6.20,225,1758556800"; 
   d="scan'208";a="132699182"
Received: from mail-westusazon11012022.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.22])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2025 19:26:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzabzHND8Ymt5RnKvPxO58JFmZ9pcraLfHvVLLcRGliwJtjoyOK4EQHdB7d3eT+WszC22Ybp6Ez9rQhohtJwZfnGXVpfB9UM4ri3nnD38WLGDVC3HJRJQoVqXJAoJBo6nAnpnCPmJ3zPLxYCCvZnySDDIos7PdTHHyW1KktYzJlWqrSk94F6AHc3KFWKy6AybVDz/8nUR22Nap/y0H9mYiU39KAW9/QeZcghfPRgL9oak9WB5KFjndcm+YAnfbpXhN/wpg5srodsCfZnjhaI2Bxyj0X6mcwlE0vkY8vyyiihxNR0mV5q3OruxOrFe3A4av4V9U5+kfrh7WpcQ1/8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deLixO9C5+V/lhhtx6Uin1yL2HqfgxvApV/caOPvFRc=;
 b=XHyHtX2xpG/SWvyVt7bziIQyM9z0kvqy2XcJTdwLH/cylKO1lPa+s/7VahLXbbNnf9GGUhHEtL49KPrj3NWhI4ykDKu3KwS3bWHTiXmFoQrpQj9dXpOFQFlZc2UpNjSmLlf0qh+u8qQuGcGoptNgBgh++1Jo61zkpbSge9DXth1VCgQq/21XXJfKTBVTp8Lv2KQMSKtopG3EbJGBbThHhcK/npUp4Iu1vkDjstgI66erom1mzUjOtX9M20nVLmSaWZCpockWUDMUy6tiBHXGyqbVxfZh2hLA57GZAUsyD8zt7MYvrrCBPylWtIWvxP/he57+3pJCx1Jfd6EXP8ajIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deLixO9C5+V/lhhtx6Uin1yL2HqfgxvApV/caOPvFRc=;
 b=HduTII5w89y7sVfOHwtaUGtPM03QICdBqNWrcOCQAsE7EDfPxPgiK4y5RIAEk/KShzpIgXrJreGOg99eyotMIZbOKfs0lVYyY51n9wLfZHPqC7651rrvZVF0U/9tNHpRV70JcktqslF7oCR4cgzc3MokCW/oSdy6HSzcWwvTD3k=
Received: from PH7PR04MB8521.namprd04.prod.outlook.com (2603:10b6:510:2b8::19)
 by MN6PR04MB9336.namprd04.prod.outlook.com (2603:10b6:208:4f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 11:26:32 +0000
Received: from PH7PR04MB8521.namprd04.prod.outlook.com
 ([fe80::5bf1:37ae:cf94:c7ae]) by PH7PR04MB8521.namprd04.prod.outlook.com
 ([fe80::5bf1:37ae:cf94:c7ae%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 11:26:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] blktests: test direct io offsets
Thread-Topic: [PATCHv2 1/2] blktests: test direct io offsets
Thread-Index: AQHcWY5oK4YlIertQUeyjLZiqQGMbLUDSZMA
Date: Tue, 25 Nov 2025 11:26:31 +0000
Message-ID: <y744um3exsnhtf5u4iabfipzwkexcz5t3xqe4vvspa7z7hfuws@y5mbl2oszpuy>
References: <20251119195449.2922332-1-kbusch@meta.com>
 <20251119195449.2922332-2-kbusch@meta.com>
In-Reply-To: <20251119195449.2922332-2-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8521:EE_|MN6PR04MB9336:EE_
x-ms-office365-filtering-correlation-id: 9b750556-f5aa-4861-53a6-08de2c157bf0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y+b5KnyhiGptcSoY5Me3n4fpcBJAFGeCtRZmKtLFUYGEBt6KLbzVzsoA2o/B?=
 =?us-ascii?Q?qBZQZLzZZUvNOZtSqP15u/BrNnq0frA6Cn0wBSPi3ZuUfkxM9vnUyt2KtiBY?=
 =?us-ascii?Q?0weFS/9V2dWpmOmHtnglHnb6CcZdue6zh8Ukw1wDLcOjJ4CNOzDHyBG9vhFF?=
 =?us-ascii?Q?fwKjzuNUQ7xHErN9HmVFfWCYb4o6j6S83nhy+kY72wIUFRzsLQUdP0PosXH7?=
 =?us-ascii?Q?Ox0cxpFoe8YoLq2P1jqz5sX18C1F9s26zFU2x8KJ4/YmcHcqz/xBmPaG+WAB?=
 =?us-ascii?Q?kISs1pguS7IlII53jnsI2wXmFptHLTIttV4Ae+OnXGfC9D7jJMJF5EwpKDVD?=
 =?us-ascii?Q?iWs+xl9hZLVP9LTxJwz/jfTFvE1NRfKebRlL96XWNvmrlpKQNXqXF6bVpQEQ?=
 =?us-ascii?Q?S3HbETDCoKi5/nykFCec4mo15L8vEUe6Tk2ZGQZF/Dqn/d8Fe/OlNyRn0AIY?=
 =?us-ascii?Q?YJh4WEIzVyXuahvlNl+3vev0J45DmUYyNQadG5ArfHfTFp8Du3gewHCCCOpl?=
 =?us-ascii?Q?Mqvetne6rtlFenYdW7V4qvBtiF9Hm7Nf3UxqeOaNgS4O5+so4vE38yLQoTUE?=
 =?us-ascii?Q?6hK+TmTfbeYT/TiNm3YKA7K1L84x06rzIv+wYTOq/xmmTcygcb0VNWpREebV?=
 =?us-ascii?Q?5iG6zRHC6iTlypNKcAa+xO1T66gIh4Sf/2TzAAjmotupLb976g7Uj6hseuaJ?=
 =?us-ascii?Q?pJodz5FmSoHuigyUDRIvB/4WDr7eVh9+A6ilwx71FdHm7PvvVT66CglUqBx4?=
 =?us-ascii?Q?WLiOuRRwBkmHgVzWztp94loCuUidTiuXMrGqj7lIdRP1gHTnoINThDZh7CBG?=
 =?us-ascii?Q?HxQyKqNzEo3qqcwPb2+GY61DV9YB9pCe9xIO3g/0US9Pi9Ijm7Wd4m4xKRkH?=
 =?us-ascii?Q?0p1HUrnTuyuRK0nTTLbLbXahj0RxHsQ+/0hDAZEsjzb3jFuLj24DVhXj5GHj?=
 =?us-ascii?Q?JHJtfnQXXgzn0yXVwSTeHGD4BhzntNbPsYgqKRpEo5SCbP2KHi7gVqyj1IfQ?=
 =?us-ascii?Q?7EEXqAeJP+lKNqFGzM5SD7SV/nebiqvIojJSatnfC4kvpOkC7ycQwOzF3Km3?=
 =?us-ascii?Q?2HNtYIWtMz4/dUkuelTSI5gGbstxJgFAZPpT1fXXXo+cIcIv0SIz6kD4z5sT?=
 =?us-ascii?Q?8XzsWgQ2r3D1MmsLLuZbH9LBb59tY3Qu7C1knaX71dvp/5DgPHpVfeZG8iZ0?=
 =?us-ascii?Q?eBjlK7lxHpTnieO6ZWa46+TJTlIO7iCP3mjgSk0LSq0hYgwqqil/N+2RI/Au?=
 =?us-ascii?Q?jgmZefCLM5j/pls0YG8gRUYLQHS1C2STXzZtGDHEPlRQIwi6KpolkZIzzkYX?=
 =?us-ascii?Q?Fu+ifXlGCa9nWWoVLqagN4SQnAq/xEecTpHyo/Crqx0wOV5SQkPGoS9Uu09m?=
 =?us-ascii?Q?hvkH8CcwLMAj1J7o2qDr3pFW0Svc7m4WbSTgxrdPePjxyDZErPFJG7Hlz7MJ?=
 =?us-ascii?Q?6VWakYaJ0+1b8dWkViB8WVnBjemCxp8ADqBuxsVSjariVFFkwWL4EkxFlwXg?=
 =?us-ascii?Q?k3w2+mqRjk/xMaC9apCVMrLbIVWxVbojFtPV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8521.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QTTeSIZUGauws8M3e99uFoNKRawcGxhhI/Ts0U/HqlFIq735ue2VwXk/+fZ1?=
 =?us-ascii?Q?gIYwgzu0KzyoXowqnosxmomBeyeK2N8yhiaXwWYyTmffGOH6YGewtoWJdItI?=
 =?us-ascii?Q?WynM3Lcez5vtAfbNcNlcLmmSgqEAAKN40NUxSOVUacN+Wil7tAfbuOpsFJBb?=
 =?us-ascii?Q?0WIaV1KkV5KZvUklCebqDWKUSXrSHdwtB+PsD1sZ46zIKv501EM3tnBqg8HI?=
 =?us-ascii?Q?aQfvPOR6kXBXUTqgr9L3+BP7siJZxV2Hn6tHzcQ5jRtMEvvw5iEu/eBn1VGa?=
 =?us-ascii?Q?Oq+tLKs0m1pwr6FTysSo6Rin1J3oJ6cbPeGyGZcJWRMp9FZVN2V0sDG3mDQD?=
 =?us-ascii?Q?IoRxNN/REitF91XreYshomPwEfaZEbsBrals8+qJRUel9R3prqgNOQKqe8rd?=
 =?us-ascii?Q?+y/oJ9FQHtVFIJzcO9TU4ktb/arTQpme8dR866sXDglerh05oEumf/QibUaY?=
 =?us-ascii?Q?FtkK0+3HfYwEf9MNCNcqcvFPcR/hc5l8FVqupF7TgKFr4lI/64s3XYNE86Wi?=
 =?us-ascii?Q?JY8wuP40k8CJ1EFWfQlwVFW2F1RRs9zEJL4eZA2oaLgvJ4ygiGwrlQ1aQMmp?=
 =?us-ascii?Q?+Po9f3Y/NQwW+p81HRd+/ZYbp1O6AC99cTyw8mu8usLp1ZoUhVvUaM6iOlkN?=
 =?us-ascii?Q?xio9SRmatprBVJPnsw7SbZqunChruPDJ5+7GmALUXid9/ZqOJSOenPUYHTL7?=
 =?us-ascii?Q?cLlbk6ADWi/wPHOYjQQSDzVt2x5oKmnF3kV+PSNBra8S5s4zap3TBbdsKoKe?=
 =?us-ascii?Q?h/MiDj7rvu01FyDYC8JEgMfEJRndSi0SZvgHsJLR1Uux8vnvV27SkniiY76D?=
 =?us-ascii?Q?JojwBd5LmIJi4Ja80WYbXTkmoOoL4OF+Om0F/qD6kjOZ9fR2I4MfDQq6wjvK?=
 =?us-ascii?Q?vUuRdTGmnfQYZsu8f8qxpCj2EwVbzcQ5UML0TDcRWE3CuX5mR+xPfxw4FoBA?=
 =?us-ascii?Q?1FD83iqaGv9d9irscuXRcEj6z+HYYFelhnz/1Czgnz5RjN2EbbiVQd2D81fX?=
 =?us-ascii?Q?bU2fmq/0okK6CnkLuLJssxGL/QYMFCN5qwRrHLHMpDgjrt9onTCJHL8VwihI?=
 =?us-ascii?Q?Azg45LgJEy+MJIBKWiN6JraqDLi4XAacfRLXD4KOU6LqW3JMF87P3p13cAn4?=
 =?us-ascii?Q?LgUHpKCPRInaEBVodl5YEeuUqd4U7gsycNYQPhG21tU88VgB4Qargk6UiMJo?=
 =?us-ascii?Q?UCpZYXnt6hrU67rT/1nMDc/Mf3zQyVbB7bHHZT0DPjWiDDHKjAfvpQ2LSoIe?=
 =?us-ascii?Q?xySqQWRVkleunxprFhb1GJTl8Ts8uzxom04voiCJHUk+5xwPNioCpydQ2OEh?=
 =?us-ascii?Q?aI9NuyW1AeIiJRhqWMZyFIxNH2/lY68AQAwRdad3liDv6IqGiIClWUFjgfLX?=
 =?us-ascii?Q?mAubJ62YL78vQBIc16geAE7rjJuPvT+qW9MzZBHsRm8+LdT3smvi/ArLZdyH?=
 =?us-ascii?Q?gRd3JsdE0iEZBEhRNK6oKPRdSO113uFazwzQXg1rAaluR4E9H7vsylkPU/La?=
 =?us-ascii?Q?IDji3oDCbBG8goUuC2kQ0Xis1MuIo8Y4m2Puyrc4YI2Xc4ivf0mCdo6/fn50?=
 =?us-ascii?Q?YN4d+CjpAYMDWFHd7gMBSz/uDZDdXsC+iw6Y5NVpd/tFSqaCubV5ScqBcX/+?=
 =?us-ascii?Q?DHsJpX/x+I1fxxGC+oyX1Yw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2921D0058B8F6445975A12F7920D9CCD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wuq3d0R3nnNEq6/aRmuN5lPUi/+jOh+bIv43HDBnZpsQXQkZ41mZL2QWf9KoEcd3VhNvidIM4e6cMkb21FStPeWJFt57tzs2HYVcz3LUIpWa667Z6q4ocRuDpgwGI/A6o8WbZQiQCMcCrFRl0cFrwDf/z6U66kZ7dZ+TZapkNTfufDfqtPSH/0Wc2yEaPs+ldAOwHFF6vkotOivzmxNHhOa4fUjfaYqOVBwT52YYr2d6c3qHp5PO7Wx9ELIXv2S0JvSB+xw+rkKcAuVMxVhx1oEnZzzCUN3lF1HGDknX1CJlPhANZ9OBWjlhdNcatdN+iXCAxzomLz87637Yh1Uh0jFLSf/TA2VchG4grNEbZmindh5E0s+B5oNkXU0I6To1pncJ5cYUIkALedBYQ+F1IK0OfV/1WyvPeFTCGzEt1+NoSQOOSiQjpU8IYWqGRkDCmj7BtOcthPEHsv/TfwKFJok++KTR0LWa76K3G3Vp66Yljc8Ovi1IQA9hsRy6o89tLjcJ/KdoBAGY9MwyKDLGQDnOtCyaXj/R5v3p2lJgpjBbk0h+6Gku2oIeEeYfL7MzNXjt8bsakTLip6IBNUSg/G1+55Jo8vY18uxuw2RpLChxS1dOzwjGARJZv5wBskEr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8521.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b750556-f5aa-4861-53a6-08de2c157bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 11:26:31.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDVm1Q8fyq/4UgeVPePsaj57ap6/aMxJzUlhN21p8jU50s8Zr1SujAaTscf9Mil0QykilASpDHJjcB5dLGyC/3xHMkA4+50wMfwGc60smMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9336

On Nov 19, 2025 / 11:54, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>=20
> Tests various direct IO memory and length alignments against the
> device's queue limits reported from sysfs.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
[...]
> diff --git a/src/dio-offsets.c b/src/dio-offsets.c
> new file mode 100644
> index 0000000..8e46091
> --- /dev/null
> +++ b/src/dio-offsets.c
[...]
> +static void init_buffers()
> +{
> +	unsigned long lb_mask =3D logical_block_size - 1;
> +	int fd, ret;
> +
> +	buf_size =3D max_bytes * max_segments / 2;
> +	if (buf_size < logical_block_size * max_segments)
> +		err(EINVAL, "%s: logical block size is too big", __func__);
> +
> +	if (buf_size < logical_block_size * 1024 * 4)
> +		buf_size =3D logical_block_size * 1024 * 4;
> +
> +	if (buf_size & lb_mask)
> +		buf_size =3D (buf_size + lb_mask) & ~(lb_mask);

I investigated why this new test case fails with my QEMU SATA device and no=
ticed
that the device has 128MiB size. The calculation above sets buf_size =3D 19=
2MiB.
Then pwrite() in test_full_size_aligned() is called with 192MiB size and it=
 was
truncated to 128MiB. Then the following compare() check failed.

Is it okay to cap the buf_size with the device size? If so, I suggest the c=
hange
below. With this change, the test case passes with the device. If you are o=
kay
with the change, I can fold it in when I apply the patch.

-------------------- diff start  -------------------
diff --git a/src/dio-offsets.c b/src/dio-offsets.c
index 8e46091..7e1aecd 100644
--- a/src/dio-offsets.c
+++ b/src/dio-offsets.c
@@ -22,6 +22,8 @@
 #include <sys/stat.h>
 #include <sys/statfs.h>
 #include <sys/uio.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
=20
 #define power_of_2(x) ((x) && !((x) & ((x) - 1)))
=20
@@ -81,6 +83,7 @@ static void init_buffers()
 {
 	unsigned long lb_mask =3D logical_block_size - 1;
 	int fd, ret;
+	unsigned long long dev_bytes;
=20
 	buf_size =3D max_bytes * max_segments / 2;
 	if (buf_size < logical_block_size * max_segments)
@@ -92,6 +95,13 @@ static void init_buffers()
 	if (buf_size & lb_mask)
 		buf_size =3D (buf_size + lb_mask) & ~(lb_mask);
=20
+	ret =3D ioctl(test_fd, BLKGETSIZE64, &dev_bytes);
+	if (ret < 0)
+		err(ret, "%s: ioctl BLKGETSIZE64 failed", __func__);
+
+	if (dev_bytes < buf_size)
+		buf_size =3D dev_bytes;
+
         ret =3D posix_memalign((void **)&in_buf, pagesize, buf_size);
         if (ret)
 		err(EINVAL, "%s: failed to allocate in-buf", __func__);
-------------------- diff end  -------------------



> +
> +        ret =3D posix_memalign((void **)&in_buf, pagesize, buf_size);
> +        if (ret)
> +		err(EINVAL, "%s: failed to allocate in-buf", __func__);
> +
> +        ret =3D posix_memalign((void **)&out_buf, pagesize, buf_size);
> +        if (ret)
> +		err(EINVAL, "%s: failed to allocate out-buf", __func__);
> +
> +	fd =3D open("/dev/urandom", O_RDONLY);
> +	if (fd < 0)
> +		err(EINVAL, "%s: failed to open urandom", __func__);
> +
> +	ret =3D read(fd, out_buf, buf_size);
> +	if (ret < 0)
> +		err(EINVAL, "%s: failed to randomize output buffer", __func__);
> +
> +	close(fd);
> +}
[...]
> +/* ./$prog-name file */
> +int main(int argc, char **argv)
> +{
> +        if (argc < 2)
> +                errx(EINVAL, "expect argments: file");
> +
> +	init_args(argv);
> +	init_buffers();
> +	run_tests();
> +	close(test_fd);
> +	free(out_buf);
> +	free(in_buf);
> +
> +	return 0;

Nit: last "}" is missing here. I can add it when I apply this patch.

> diff --git a/tests/block/042 b/tests/block/042
> new file mode 100644
> index 0000000..a911d82
> --- /dev/null
> +++ b/tests/block/042
> @@ -0,0 +1,26 @@
> +#!/bin/bash

Is it okay to add any GPL SPDX license and your copyright here? It is not i=
deal
that I add your copyright and license, but if you specify them in this thre=
ad, I
will add the Link to this thread in the commit message and fold-in the spec=
ifed
SPDX license and your copyright.

> +
> +. tests/block/rc
> +
> +DESCRIPTION=3D"Test unusual direct-io offsets"
> +QUICK=3D1
> +
> +device_requires() {
> +        _require_test_dev_sysfs
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	sys_max_segments=3D$(cat "${TEST_DEV_SYSFS}/queue/max_segments")
> +	sys_dma_alignment=3D$(cat "${TEST_DEV_SYSFS}/queue/dma_alignment")
> +	sys_virt_boundary_mask=3D$(cat "${TEST_DEV_SYSFS}/queue/virt_boundary_m=
ask")
> +	sys_logical_block_size=3D$(cat "${TEST_DEV_SYSFS}/queue/logical_block_s=
ize")
> +	sys_max_sectors_kb=3D$(cat "${TEST_DEV_SYSFS}/queue/max_sectors_kb")
> +
> +	if ! src/dio-offsets ${TEST_DEV} $sys_max_segments $sys_max_sectors_kb =
$sys_dma_alignment $sys_virt_boundary_mask $sys_logical_block_size; then
> +		echo "src/dio-offsets failed"
> +	fi
> +
> +	echo "Test complete"
> +}=
