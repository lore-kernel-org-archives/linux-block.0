Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6055204866;
	Wed, 18 Jun 2025 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228053; cv=fail; b=S7QbHLZ1IiFX8Yp+Qb4+3iXp2orvJC/M/6XTAKRv7G1WdwbUS5F757IXmYkYxZ1r2QNR9byDpbKw5L/Xt8PV8XEMggfpwCivYRCFNatKvdMug5AgqY3NEB/fwUWH9aTOZpD9RDfZMEGd/PFx5mzLrsqXBMEZalBFUktCtRt7anw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228053; c=relaxed/simple;
	bh=F1h2/vhW4QS3vvGZ87DO2XHtpU4SdJFQBsLrGSyG5jI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Pfw0Dm7o5lu7fDLcV2zvxlPen/o0JJnphw9KlohJo/Vlah6+yesngPh7vcnXLkUVO9qqPXNZ38NK7Ou+YRYXD8IfvPdAG9Gvgcp5XvlREQEJZ+QZ3E6seJd5xQ97GGoruqBCDA90EDtdc2P9iYz464w2/PK861wmMeXilFIwV7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JrFP/qsD; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=axQRlOL6; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JrFP/qsD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="axQRlOL6"
X-UUID: 4970b2164c0d11f0b33aeb1e7f16c2b6-20250618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=F1h2/vhW4QS3vvGZ87DO2XHtpU4SdJFQBsLrGSyG5jI=;
	b=JrFP/qsDZP0qfr0JQukDP2tNl2ZnR8gWnmKe9Ei/9mWgqQtFahrAnpEd/o8QuSjSYNJTk9JJ3lwksli4a6uBXFN8e2adZX7zAjdeWZzwtyrl9WoM+CLiFCmIUKZjg8t1tCLUag+tZttgQtH+L7Q5MDDkrph/JhhZrPNOc2Rd5Tw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:491886ca-5fe5-41de-acf9-d9fc10094766,IP:0,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-30
X-CID-META: VersionHash:09905cf,CLOUDID:4545bb83-db76-4e00-9dd0-5c1455b2676b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|110|111,TC:nil,Content:0|51,EDM:
	2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4970b2164c0d11f0b33aeb1e7f16c2b6-20250618
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 899490965; Wed, 18 Jun 2025 14:27:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 18 Jun 2025 14:27:18 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 18 Jun 2025 14:27:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgWGKmtW2Fe1Z/DAJRPuCAHSYkAJ8en4xHw0rupvsFqWdcUbvyxbRxTXHTCTePf6ibeBXT1LEWHR6yw7swPrbdiPgmzz+aEB3StevNxlgGqKa5F6uKpRBv8p9UoJ05cwVAx7w4/OgjPu62ocvyeMAoR1X3bApDgge0a8QwhO8Yj2akD+8GTg7m0R6J2MTQMliEm80VkgabvgaISK7oz76PHuhQF5rlAXHhJ+JGVXvwnfHaNHa5qPx4PhuXRVk/TWBo/qnh/S9UlfmiP1tyBaKT+MxJCl5jUgnk08flfu6xp37vBha/o2Y/hy2LemZv1syoJTivaKkxJ8qM9PVsH40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1h2/vhW4QS3vvGZ87DO2XHtpU4SdJFQBsLrGSyG5jI=;
 b=xEeUM3fwH2pwtwwoggcRVeWS0zNnOy8PJ/7s8m4SD62mNFZ6EQbjQdpgonHfhG0yn8saauH6zniR7KowUYyqDc2pJ/EFgTvWQkU1FdkBKKF2gnF9Kkb+zqeyUJ9NTifxTHt01hKGgIil4+gcyriCvSkUoI7ZvXNhS0J6r2H9rBBdZ7P8Y1kVmhop6L95n5MJ2icRoNKuye7HrOf1sqqfd+Y2DrUJR/pgF4TaKHXe8nngzgYBT/VfH+X0GuivVKRYXlOHskV+FjJ9bB94JDrgxPUqP97ODECB8UsNwSCfaUF4ANr9sKyye7NXuVwPX6GYeIULTofBgZvyj+k7FzIj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1h2/vhW4QS3vvGZ87DO2XHtpU4SdJFQBsLrGSyG5jI=;
 b=axQRlOL6WWsStZXKm1lehHG78QOBlhpn4+JENAM0+sJ8q1F4ZQyOGoXbx9pgfoCIm/afFbizXKGvNMpmdGeh5fhU1yBzhm415uKEZizeIugW1EHxQM3pS0OtKSiLZL/hYRPtiVFlmnT4cpJQT4IohkTGncKRe7ti1cv6K7dB9S4=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 KL1PR03MB7598.apcprd03.prod.outlook.com (2603:1096:820:e0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.29; Wed, 18 Jun 2025 06:27:16 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::8b7a:97d8:96f4:2e6b]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::8b7a:97d8:96f4:2e6b%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 06:27:15 +0000
From: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "chao@kernel.org" <chao@kernel.org>
CC: =?utf-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= <Chun-hung.Wu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: f2fs: possible circular locking dependency detected
Thread-Topic: f2fs: possible circular locking dependency detected
Thread-Index: AQHb4BoIVqrembnNdU6G0o9Jo2quqg==
Date: Wed, 18 Jun 2025 06:27:15 +0000
Message-ID: <05c613e9ea956ed9caa6525509a371ee37a04380.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|KL1PR03MB7598:EE_
x-ms-office365-filtering-correlation-id: c76e095f-c6f0-4bdc-2689-08ddae312aec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T09ZSDRJNGI2aWtuSENxSnNENjRoKzBBL0VNUVZDZ3VFNHZvMWI1ZW9mZTN3?=
 =?utf-8?B?Q2dxY053UktPcTA3dExjYjFxMVlYRXpIUTVES013WkcwME9naWpZK0hURjlz?=
 =?utf-8?B?WTFPY3BBU0RSVU16ZzJWcFR2TUF5cWNWbTNFamZMbFJRblppWWgyeURtUTJa?=
 =?utf-8?B?YlpMR20rYytNcVNqcStNTnZ6UFRvOFQ3NjE5azU1VzFISWt2bkVJVXBpVmw3?=
 =?utf-8?B?VGtCNGhDNmwvbE5kZUkyTGdsejFGelVxcVVLTVVYQ0dRSUYvNTR2MTNkTEIz?=
 =?utf-8?B?dXNqVUZaTVVBOUFnRGFmc0NNY24xbGViRHFpdE9sWTBrQ1BFelpPU2lmbTAv?=
 =?utf-8?B?ZjdYU2VyN2Z5NWlJby91VXBiSy95TWRYQ04weVlWYVNmcW9kRU1pWHJzUkVj?=
 =?utf-8?B?SkJMYWxPV0hqQW1hUGIrRVlKOFkwTTRieHhLOE8yRnRsUEkrRFR4TFphaXc3?=
 =?utf-8?B?TEtYUjA4bkhUYWIrWjJuY1gwZHpvT0crVmFUWjRSZmdjZ24zZC80cG9nSDUz?=
 =?utf-8?B?T0ZQTFZyeFVFQmU2dkJpNmxObVQySXRPTEtJTXBxVXJLUnIwNkZ3cU5UaXM0?=
 =?utf-8?B?dFBwemR0QUFQVGY1YmVUVlIrV3FiQi9IZTlqVzE5QjNPQ0dpSHpBUVBYU0tV?=
 =?utf-8?B?TXdvaUZHT0hIR25XQm1UUFdYOFgvR1hyUlJReGIrejlNa2t5b3g3b3hqR1lQ?=
 =?utf-8?B?YTdkWkh2YUFiQ05lNlRwUjhZY1dUTGdGRTJnTjh3WnN4eUdhbk5PSUJaV0NO?=
 =?utf-8?B?YlM5Zyt3MXpSM1cvVnFOc0wyRTlkaGlzS1VYd2V2SVJ0M3J3d1p6MUlZZmo5?=
 =?utf-8?B?RStCcWVzcWNqNjNuTENUTVRZUXNFUTc0SDN2WVpqM0owN1V6cHJpeUl2UUZo?=
 =?utf-8?B?Z29PUHF0YWp0QjFiVHpvMXJKaEpSR3ZvN3dUSlMrZm50NFh1OW5oY0lGYllm?=
 =?utf-8?B?b25wWCtOcUVVZVNVcVhoS2ZNWEg2R3pHc2Q1Z0tkR1pweDdRV2hROGNhR3lL?=
 =?utf-8?B?b1NCOHpFcVJQd3VMNk40eDdXYVhLZDJFY1BOamJsOGdraGc2dFJqK3BYMnVV?=
 =?utf-8?B?VFAxT2xxcmhuZG5uMDMybzhOaTJyakJjWUFpTTRiRExCR0dTOGRDK3Q3Zm5k?=
 =?utf-8?B?SmVIVUVtSUFFQXFaYUFPNmRVUVovTEZkcmNqbjBVdUpsaFhuRG95RDIrMlRC?=
 =?utf-8?B?bzkwLzh0cnhmL0tRbnU2YWh5dmxmTlJMTU5yK0ZVeGxjMUJCSklWdUxSbzBO?=
 =?utf-8?B?Mm11anBZZ0I5QmNUTzk5WWFDVy9MVWxCeXlwOVg2bGx3b1NWREt0QXhBVVg5?=
 =?utf-8?B?U2Z3NlIzK3ZOTzdpRFY3NklIVEdGbWZVbHRHMVNIOG9MZTlRSVY0NjRPS0NW?=
 =?utf-8?B?c3EySVl1bU4reS9QWDZrTVlmeEkyalg0VmY5WGlBS2ZEQTU5VWNCMnpoOFVj?=
 =?utf-8?B?Ry9mWHU1aTB6N0gxKzdwbDVwLzBwcVNxSTF1d2N2cjV0czZZQVBIWVhCL3ZH?=
 =?utf-8?B?Z3dyOHFydVM4MXV6d0dwblV1V2FjcEpOUFh3bmlJWlR6SCtXNHR5ODl6Y2hI?=
 =?utf-8?B?b3d2UFhNK2ZNTmZEV1VqSTdwVnJONlZXVmxnb2dzbTAzUk00NUExUWJpelpR?=
 =?utf-8?B?dTJUT3RpRXU0U1JwS3NKdlg2L3lHT3VaM3diYmZsUUZVVlYrdjJFTzl0aXRn?=
 =?utf-8?B?czY4dlBURVNqWGhwck5ZMGU0b1hRVTM1NjBPQXZ4OW5HZGRzQklxRVEzUnBr?=
 =?utf-8?B?MitGQUdyN1JTdloycXJYMGpjeVlqOEdvdU1BQk9PRk43R1Byd3FlYmcwOVNa?=
 =?utf-8?B?dlkyT0h5S1FVV0dKWjN6Z0liRG5XRlYzT1dSSHJ5R1hDT1lST3pkb0o1TG9p?=
 =?utf-8?B?YStMVVNPL05vNWg5VTl1K1BBd3o4OVh3ZFJCOENxcmVxZXdoNW9XWHg0Z2J1?=
 =?utf-8?B?NFJMNEIvRTZHSWM1UlF2a05EMmtwRlhVMWtkNmFnTmtHRGxRSmI1cFBvbzdz?=
 =?utf-8?Q?YHdwej5rPSH+4/up8NmZd5jVUtf9ro=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFZCUHJmZ0Vyb296Z3NEdkpXekFDSFlZVnM0UTNzQXBiVW1zRUUwK3RkUE9m?=
 =?utf-8?B?VnlTc3VIZUM1bXRUTTdFNW9ldFJ1bkhuNlFkWEQ3VDhFbC8rbi9icFJJQ2tH?=
 =?utf-8?B?WEVjV2ZjaEE3NnBXTDI1Yzg4Z0F3VzBUTGRJblVXRUQ0MU0ycCsrNGZ0emI0?=
 =?utf-8?B?WVhud2JsWnUrS2JqZG5uK3FjTU9VMS80SzlDTG1KUXlERytzS1U2aFlSUzBn?=
 =?utf-8?B?eGdlakFXNFBBSk5jN28rMHFWbVhtTlZDM1YyWSsyOXMyWGwwNTlMK0NqNkg1?=
 =?utf-8?B?TzU3ZkZkbnJIazFmM3RQaVdKK1N5dFVJZVAxNjVqNzN5NUg4WXJPb0plK2R2?=
 =?utf-8?B?YmJ3YjVKNDU3ZGxHZENDT2tHK3JicEhRZThKdGQ5d1F2SUJub1gvcDVJNm9l?=
 =?utf-8?B?UDVVVEpvbmt3a0hNbnlkT2p6ZzBsbWEzRFZvNnpLS3RaSEo4cjNNRHZFRFhH?=
 =?utf-8?B?YXB4VlpEM25VcjlzekxZeUpYTnNVTitBUVV6ckVDcytxWHhnMlN1M2xjQ3FC?=
 =?utf-8?B?RUVsMStyUVd6VlFPZ3A2UWJTRVNqQjFBK1R2aWZBYXVDVEh2UXMrMmtBSkty?=
 =?utf-8?B?OGcyZWNUd1lDWHlYWDZNVXkxZjNVYVlwQ2JFNC9hNlFjMW5ML05VMXUxeWZn?=
 =?utf-8?B?M0Fac3BaY2pwOEFvSU4wS1hGdjI4TnVrVlMvTEN5bjVBdnVoSEdBV3RCdzdh?=
 =?utf-8?B?NGFZc0RwNG5rd2IvZVJsakczdXFXSTFjYjMyOVQyT3VtWlFPQkJhTFlEa0Yx?=
 =?utf-8?B?VEZhVmZ0UFhMTTBkVTdUUU00b3VISFduY2hSZ3JmbGVVeUEzdmhSaS9TUFhS?=
 =?utf-8?B?MVBIL3U0LzJnSW11aFVkeEFDZFFSdnlmejFFeUhZRDZIZ3ZYWGdteEhvaVNN?=
 =?utf-8?B?K25sWHFldm91dzg4WkZBVnA2enZwWWwzOUN5Mld2MlBHeC8vUzAxclFrZFFO?=
 =?utf-8?B?UE9oVG4yVVAyT1c5aXhTcnBnbGlRYnVZMlhEdHFxM1JiZC9YTS8vL3kwM09T?=
 =?utf-8?B?VTJZSW9UWFFDTVBMSWZEYmJRNTg2K1hzNEVSZy8zYVdGUHhKOTBTU3FRbTgr?=
 =?utf-8?B?STJCVnlQT2xQYlVzVytpSExYeitHdzJ4U3BnazVJZlNMY1NnUDBFZmJJZUZU?=
 =?utf-8?B?NVdDRllKQkFGSXRUazNacnZNa1k5RUI4QkpJZTlSc0cyT1RqTVpkWm9lZnl6?=
 =?utf-8?B?SG9qTVZNUFhGbjNhZlRJb05pRHQxK2pwYUNjUXpMY3Z5MldSbk1POUEvc29E?=
 =?utf-8?B?SEJPWTVqZ1JjeGVwblkwMFN5akRodG1rUm9yV1JPNUM4WFJsZ2ZRTFM2UDAv?=
 =?utf-8?B?UHVqZVpFZ0lyVFAycTdMOXMvTkRub1ZDai9Fc3VXSkxONm9HUDllbklSa3BP?=
 =?utf-8?B?SlJFaEU4R01TL3ZqZW1TaFhVLzExa2FtRWViYjlwd21idmo3dnVYdGFoeTNp?=
 =?utf-8?B?TWdzM0FKbmc2TW9IcDM2a1FxMS9uaHlJVkFNc1Z6WTV5UEVNVExyTG81eHV0?=
 =?utf-8?B?Q1JBa01wYjhZTHlOcTlMd3N2T1dPeUxCM0lSUkpwRGN0Z3VWV2xyVURxbmxt?=
 =?utf-8?B?dzRuMHEyT0pYMnVjUlRrTFIxQkVQc0xibGF1aU5TanBxVVlkbkpFZjY1ai9M?=
 =?utf-8?B?eWpreFdQS0ZhemVlN2lwR0p4TUdDaFplUm1ETTFkY0lqd0FtRk9WN3doM3dZ?=
 =?utf-8?B?VWx2Z21zankzWVJMTy91M1NEajRRK2crMHRRZkFGTjJMVnUxS2hLNmRrTVRy?=
 =?utf-8?B?alRmZ2dwUU5SYnZnQk1RdjU3bDhaNzZsQ0IzN2hpY1hmbUhpaDNqVnJtaTc0?=
 =?utf-8?B?eEZ3MWNsdmZwWGNUd2tTM09xT0NkdkJsQWJ6YURvc1Z4S3dBZnpkM1Jta1lr?=
 =?utf-8?B?TzVrRmM2dzJqbit4Q1FHa3VmaXlMRWs1YUJDUWhMODlLRVJOZVVsMEFkSTdF?=
 =?utf-8?B?elllaHVpdjVValNya1BDSUczMWlxNGlCV29WRkg1ZU9UUmlRUzdlQWVMdWpa?=
 =?utf-8?B?QjRubUM1V1FBNnBzejJYbUR3ZHJZYTRNQVJKcWtXY0lkZXFZQVl4TC9yTXlR?=
 =?utf-8?B?QW1IZHdrMHRtTGw0cXpra1NoMHZ1VkhHaGN6WENjYmE3VU5SVjRDM0dTQ2NC?=
 =?utf-8?Q?4lz2owbbxZSX6yeZbcly68del?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AE2FDD63F506C43A4371459378EF749@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76e095f-c6f0-4bdc-2689-08ddae312aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 06:27:15.2963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRFnsoVk3hPw4ycX22zQl2pZ9cPaRL3RS1ak6L+YH19Z/nYhzhbJ1SFFnbWevCr5XV+dHnND8mNlcyOSCbyuhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7598

SGksDQogDQpXZSBnZXQgYSBwb3NzaWJsZSBrZXJuZWwgY2lyY3VsYXIgbG9ja2luZyBkZXBlbmRl
bmN5IHdpdGgga2VybmVsDQp2ZXJzaW9uIDYuMTIuMjItYW5kcm9pZDE2LTMtZzAzY2Y0NjQxZGVl
ZS00ay4NCiANCkxvY2sgYXBwcm92ZSBsb2cgaXMgYXMgYmVsb3c6DQoNCmtzd2FwZDA6DQprc3dh
cGQwOiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCmtzd2FwZDA6IFdBUk5JTkc6IHBvc3NpYmxlIGNpcmN1bGFyIGxvY2tpbmcgZGVwZW5kZW5j
eSBkZXRlY3RlZA0Ka3N3YXBkMDogNi4xMi4yMi1hbmRyb2lkMTYtMy1nMDNjZjQ2NDFkZWVlLTRr
ICMxIFRhaW50ZWQ6IEcgICAgICAgICAgDQpPRQ0Ka3N3YXBkMDogLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQprc3dhcGQwOiBrc3dhcGQwLzk1
IGlzIHRyeWluZyB0byBhY3F1aXJlIGxvY2s6DQpmZmZmZmY4MDFiNmY1NjQwIChzYl9pbnRlcm5h
bCl7LisuK30tezA6MH0sIGF0Og0KZjJmc19ldmljdF9pbm9kZSsweDIyMC8weDdkOA0Ka3N3YXBk
MDoNCmJ1dCB0YXNrIGlzIGFscmVhZHkgaG9sZGluZyBsb2NrOg0KZmZmZmZmZDVjMzVkNjA3MCAo
ZnNfcmVjbGFpbSl7Ky4rLn0tezA6MH0sIGF0OiBiYWxhbmNlX3BnZGF0KzB4ZTgvMHhlMTANCmtz
d2FwZDA6DQp3aGljaCBsb2NrIGFscmVhZHkgZGVwZW5kcyBvbiB0aGUgbmV3IGxvY2suDQprc3dh
cGQwOg0KdGhlIGV4aXN0aW5nIGRlcGVuZGVuY3kgY2hhaW4gKGluIHJldmVyc2Ugb3JkZXIpIGlz
Og0Ka3N3YXBkMDoNCi0+ICMzIChmc19yZWNsYWltKXsrLisufS17MDowfToNCmtzd2FwZDA6ICAg
ICAgICBmc19yZWNsYWltX2FjcXVpcmUrMHg1Yy8weGM0DQprc3dhcGQwOiAgICAgICAgYmxrX21x
X2FsbG9jX2FuZF9pbml0X2hjdHgrMHgzMTgvMHg0NDANCmtzd2FwZDA6ICAgICAgICBibGtfbXFf
cmVhbGxvY19od19jdHhzKzB4NzAvMHg0ODANCmtzd2FwZDA6ICAgICAgICBibGtfbXFfaW5pdF9h
bGxvY2F0ZWRfcXVldWUrMHgxMzQvMHg2MTANCmtzd2FwZDA6ICAgICAgICBfX2Jsa19tcV9hbGxv
Y19kaXNrKzB4YjQvMHgxNjQNCmtzd2FwZDA6ICAgICAgICBsb29wX2FkZCsweDE5MC8weDNhYw0K
a3N3YXBkMDogICAgICAgIGxvb3BfaW5pdCsweGVjLzB4MTE0DQprc3dhcGQwOiAgICAgICAgZG9f
b25lX2luaXRjYWxsKzB4MTg0LzB4NDY0DQprc3dhcGQwOiAgICAgICAgZG9faW5pdGNhbGxfbGV2
ZWwrMHhkYy8weDFiMA0Ka3N3YXBkMDogICAgICAgIGRvX2luaXRjYWxscysweDcwLzB4YzANCmtz
d2FwZDA6ICAgICAgICBkb19iYXNpY19zZXR1cCsweDFjLzB4MjgNCmtzd2FwZDA6ICAgICAgICBr
ZXJuZWxfaW5pdF9mcmVlYWJsZSsweDE0Yy8weDFjOA0Ka3N3YXBkMDogICAgICAgIGtlcm5lbF9p
bml0KzB4MjAvMHgxYWMNCmtzd2FwZDA6ICAgICAgICByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0K
a3N3YXBkMDoNCi0+ICMyICgmcS0+c3lzZnNfbG9jayl7Ky4rLn0tezM6M306DQprc3dhcGQwOiAg
ICAgICAgX19tdXRleF9sb2NrX2NvbW1vbisweGUwLzB4MTk0NA0Ka3N3YXBkMDogICAgICAgIG11
dGV4X2xvY2tfbmVzdGVkKzB4MmMvMHgzYw0Ka3N3YXBkMDogICAgICAgIHF1ZXVlX2F0dHJfc3Rv
cmUrMHg4OC8weGYwDQprc3dhcGQwOiAgICAgICAgc3lzZnNfa2Zfd3JpdGUrMHg5OC8weGM4DQpr
c3dhcGQwOiAgICAgICAga2VybmZzX2ZvcF93cml0ZV9pdGVyKzB4MTJjLzB4MWQ0DQprc3dhcGQw
OiAgICAgICAgdmZzX3dyaXRlKzB4MzQwLzB4M2FjDQprc3dhcGQwOiAgICAgICAga3N5c193cml0
ZSsweDc4LzB4ZTgNCmtzd2FwZDA6ICAgICAgICBfX2FybTY0X3N5c193cml0ZSsweDFjLzB4MmMN
Cmtzd2FwZDA6ICAgICAgICBpbnZva2Vfc3lzY2FsbCsweDU4LzB4MTBjDQprc3dhcGQwOiAgICAg
ICAgZWwwX3N2Y19jb21tb24rMHhhOC8weGRjDQprc3dhcGQwOiAgICAgICAgZG9fZWwwX3N2Yysw
eDFjLzB4MjgNCmtzd2FwZDA6ICAgICAgICBlbDBfc3ZjKzB4NTAvMHhhYw0Ka3N3YXBkMDogICAg
ICAgIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4NzAvMHhiYw0Ka3N3YXBkMDogICAgICAgIGVsMHRf
NjRfc3luYysweDFhOC8weDFhYw0Ka3N3YXBkMDoNCi0+ICMxICgmcS0+cV91c2FnZV9jb3VudGVy
KGlvKSM3Nyl7KysrK30tezA6MH06DQprc3dhcGQwOiAgICAgICAgX19zdWJtaXRfYmlvKzB4ZGMv
MHgxYTgNCmtzd2FwZDA6ICAgICAgICBzdWJtaXRfYmlvX25vYWNjdF9ub2NoZWNrKzB4MWE0LzB4
MzkwDQprc3dhcGQwOiAgICAgICAgc3VibWl0X2Jpb19ub2FjY3QrMHgzMDgvMHg0OWMNCmtzd2Fw
ZDA6ICAgICAgICBzdWJtaXRfYmlvKzB4MTU4LzB4MTc0DQprc3dhcGQwOiAgICAgICAgZjJmc19z
dWJtaXRfcmVhZF9iaW8rMHg4Yy8weDEzNA0Ka3N3YXBkMDogICAgICAgIGYyZnNfc3VibWl0X3Bh
Z2VfYmlvKzB4MjYwLzB4MmI0DQprc3dhcGQwOiAgICAgICAgcmVhZF9ub2RlX3BhZ2UrMHhiOC8w
eDE5MA0Ka3N3YXBkMDogICAgICAgIF9fZ2V0X25vZGVfZm9saW8rMHg5MC8weDRjMA0Ka3N3YXBk
MDogICAgICAgIHRydW5jYXRlX2Rub2RlKzB4NDAvMHgyOGMNCmtzd2FwZDA6ICAgICAgICBmMmZz
X3RydW5jYXRlX2lub2RlX2Jsb2NrcysweDM1Yy8weDc4OA0Ka3N3YXBkMDogICAgICAgIGYyZnNf
ZG9fdHJ1bmNhdGVfYmxvY2tzKzB4MjY4LzB4OWE0DQprc3dhcGQwOiAgICAgICAgZjJmc190cnVu
Y2F0ZV9ibG9ja3MrMHg2OC8weDEwMA0Ka3N3YXBkMDogICAgICAgIGYyZnNfdHJ1bmNhdGUrMHhi
Yy8weDE3NA0Ka3N3YXBkMDogICAgICAgIGYyZnNfZXZpY3RfaW5vZGUrMHgyOTgvMHg3ZDgNCmtz
d2FwZDA6ICAgICAgICBldmljdCsweDFlOC8weDQzYw0Ka3N3YXBkMDogICAgICAgIGlwdXQrMHgy
NzQvMHgyYzANCmtzd2FwZDA6ICAgICAgICBkb191bmxpbmthdCsweDFhYy8weDJkMA0Ka3N3YXBk
MDogICAgICAgIF9fYXJtNjRfc3lzX3VubGlua2F0KzB4NGMvMHg2NA0Ka3N3YXBkMDogICAgICAg
IGludm9rZV9zeXNjYWxsKzB4NTgvMHgxMGMNCmtzd2FwZDA6ICAgICAgICBlbDBfc3ZjX2NvbW1v
bisweGE4LzB4ZGMNCmtzd2FwZDA6ICAgICAgICBkb19lbDBfc3ZjKzB4MWMvMHgyOA0Ka3N3YXBk
MDogICAgICAgIGVsMF9zdmMrMHg1MC8weGFjDQprc3dhcGQwOiAgICAgICAgZWwwdF82NF9zeW5j
X2hhbmRsZXIrMHg3MC8weGJjDQprc3dhcGQwOiAgICAgICAgZWwwdF82NF9zeW5jKzB4MWE4LzB4
MWFjDQprc3dhcGQwOg0KLT4gIzAgKHNiX2ludGVybmFsKXsuKy4rfS17MDowfToNCmtzd2FwZDA6
ICAgICAgICBfX2xvY2tfYWNxdWlyZSsweDE4YTgvMHgzMTYwDQprc3dhcGQwOiAgICAgICAgbG9j
a19hY3F1aXJlKzB4MTM0LzB4MmIwDQprc3dhcGQwOiAgICAgICAgc2Jfc3RhcnRfaW50d3JpdGUr
MHg1OC8weDE1MA0Ka3N3YXBkMDogICAgICAgIGYyZnNfZXZpY3RfaW5vZGUrMHgyMjAvMHg3ZDgN
Cmtzd2FwZDA6ICAgICAgICBldmljdCsweDFlOC8weDQzYw0Ka3N3YXBkMDogICAgICAgIGlwdXQr
MHgyNzQvMHgyYzANCmtzd2FwZDA6ICAgICAgICBmMmZzX2V2aWN0X2lub2RlKzB4NzAvMHg3ZDgN
Cmtzd2FwZDA6ICAgICAgICBldmljdCsweDFlOC8weDQzYw0Ka3N3YXBkMDogICAgICAgIHBydW5l
X2ljYWNoZV9zYisweGEwLzB4MTA0DQprc3dhcGQwOiAgICAgICAgc3VwZXJfY2FjaGVfc2Nhbisw
eDEzYy8weDFiMA0Ka3N3YXBkMDogICAgICAgIGRvX3Nocmlua19zbGFiKzB4MmUwLzB4Nzk4DQpr
c3dhcGQwOiAgICAgICAgc2hyaW5rX3NsYWIrMHgyMjQvMHg4OTQNCmtzd2FwZDA6ICAgICAgICBz
aHJpbmtfb25lKzB4YjgvMHgyMjgNCmtzd2FwZDA6ICAgICAgICBzaHJpbmtfbm9kZSsweGQ3OC8w
eDEwOTQNCmtzd2FwZDA6ICAgICAgICBiYWxhbmNlX3BnZGF0KzB4ODE0LzB4ZTEwDQprc3dhcGQw
OiAgICAgICAga3N3YXBkKzB4MmZjLzB4NWE0DQprc3dhcGQwOiAgICAgICAga3RocmVhZCsweDEx
MC8weDEzNA0Ka3N3YXBkMDogICAgICAgIHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwDQoNCg0KVG8g
ZnVydGhlciBjbGFyaWZ5IHRoZSBzdGFjayAjMzoNCjB4ZmZmZmZmYzA4MDdiNzdiMDogbWlnaHRf
YWxsb2MgYXQga2VybmVsLQ0KNi4xMi9pbmNsdWRlL2xpbnV4L3NjaGVkL21tLmg6MzE4IA0KICAg
KGlubGluZWQgYnkpIHhhX2luc2VydCBhdCBrZXJuZWwtNi4xMi9pbmNsdWRlL2xpbnV4L3hhcnJh
eS5oOjc4MyANCiAgIChpbmxpbmVkIGJ5KSBibGtfbXFfaW5pdF9oY3R4IGF0IGtlcm5lbC02LjEy
L2Jsb2NrL2Jsay1tcS5jOjM5NDMgDQogICAoaW5saW5lZCBieSkgYmxrX21xX2FsbG9jX2FuZF9p
bml0X2hjdHggYXQga2VybmVsLTYuMTIvYmxvY2svYmxrLQ0KbXEuYzo0NDc2IA0KIA0KQmVzdCwN
CkVkIFRzYWkgKOiUoeWul+i7kikNCiANCioqKioqKioqKioqKioqKioqKioqKk1FRElBVEVLIENv
bmZpZGVudGlhbC9JbnRlcm5hbA0KVXNlKioqKioqKioqKioqKioqKioqKioqDQogDQo=
