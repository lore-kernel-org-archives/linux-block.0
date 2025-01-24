Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118C23B0
	for <linux-block@vger.kernel.org>; Fri, 24 Jan 2025 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737692763; cv=fail; b=d20fpgUT8bTk/4xXBFqEVSeSpYfLhHP3DTZhPiQX47j5pQzBlARzE8efRf4guTPGRj5Hppta+Ut+FHbHa5dwF928axS5lBGKtUUn2337/Wi/l/mBK63AQ6Y31Vho0JTudt64e99fuERlkOZnNZEJRBKMq9AqLRhxCkiIHm8hy88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737692763; c=relaxed/simple;
	bh=z5wY8NaTY0lKx2NFZTCjDVKYtyjLpKU/om2VKjEHvPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UH9uGr/kcPMMjtn0w3TXnXfDbGia5eVJbYyCSLixQA08ErdHgDcjAq2ynbXeWu/i0x4UqdMysMX90JCvSLMluK7jf7ezEhUCdwgQZlMhzEevGZv4KbjzxLI65QkrF424eUYeQy9Wkxzk/D5Yyz5z2S1DNQEhmHhJCK/ossTu9F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XlE1w5U9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DCsDgRLF; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XlE1w5U9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DCsDgRLF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737692760; x=1769228760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z5wY8NaTY0lKx2NFZTCjDVKYtyjLpKU/om2VKjEHvPU=;
  b=XlE1w5U9rLdEZHKqT570785F+hLJKq7EoiSarXXyOk3qYAdAs6kHUtMV
   AKYtxAcdgd4nZi1/w6Nikn7ufOWECMz85JdMr6YmgoKyDNMugl9N5L3qs
   WGTAuNffMv+xc17nGOj4dPU8cbwkpWvyXFSSOAavTddm4F2AVAlOf78KM
   kMwE9jAgg3fVtjVCWs+NcKR7DrwWprbozrGBs3QlMHOe2b6TfRkaGrFRn
   ir2TXKKoQQNonPwtGALqp2Tq/n62Fl7Vxp0Ol5b6g+weOFZFKvUHBnUuv
   kUOnHkHppemF5/0nmTyePhuBLvuVKxb5HGwu3x1t6ngL8/U3J9NU4fEuc
   w==;
X-CSE-ConnectionGUID: zwwXOYBwQsiwB/P08NoBzw==
X-CSE-MsgGUID: 0nXzkUv0SdSLZTYjP1brnQ==
X-IronPort-AV: E=Sophos;i="6.13,230,1732550400"; 
   d="scan'208";a="37896744"
Received: from mail-centralusazlp17010006.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.6])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2025 12:25:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/a5ygVjXg1lxxMApkCuTfLAxyN+sEPpLsn/QsOtHspHE6kxP9qMKfawJG6w3Vgs+v4P/Gko2a4mZk9XLaXH24UgDabOGS4MGeSuH+NdX2pgEjtubojs7TCiEY6eXhr8QlMb6aXKbuUyMnL9xQ0YE0iduUaTzyoPC5kDCERF9pmhMg1hNdoB1iAwFzKnbbMb9mFox/WSC263+QxCTCg5/VcdfRfPD92jAgZa8faT0mY8zsploIVkNjXnK9FMVMzq7WZcjy4+Xve7Pg/Rd7Ikf0TfHb9WC7vPaCg/CA5ud0Q8kzxFpgJwDYQlPX+wS9WprQ/58VPLSaq0DflBEptMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4jEZgfCEz162kCZowfaGWVzBg4yN02q7xfXajP8kmU=;
 b=avfMnlPT2MoD1AQFFVOjxHjkniuFZTRb8ldyoKDY73RH1C/68QlcES1UOVyHtZTVGDX4n6gOWLZAVYn6GrxACfMwiswXsEmL1xS1990Np3sdnLZ0ye859ZqsA5szTMRX096efnu97iOpAIRLTY77OaWBA2RyhJzu4p8EUcBs5mb1NtJ6e+BQDoyz5HEKAMnPeOm5SKIcZ6Ln5rRtxnTXzhTwmDrBBXeCyrM3wgcWjtp+VQ6bCRjGGmSF4moAteUCahdgbKFo5c2hsgGB0YoCz5KeVMcvfG9O+z1f2yC+lkP/xNKqn8a9Umu0hSAjjVzt8BZO0OYqIzEyq3tFsiaujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4jEZgfCEz162kCZowfaGWVzBg4yN02q7xfXajP8kmU=;
 b=DCsDgRLFymRZJQD+uCrR1+6NYEzpA0lz3+xYOgJ56ODA/tah5FCHDwH3eSfXZfnfDijPEeY7scFYPLbcwDTIk7SN8wYbvbVMDt6gTl2PWK3o37ThLGfgfiwteBDy2uTFL+AlCzXTiqXoGN4crShCo0uZZ7rIZW+EUZWxe6jC7tc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8538.namprd04.prod.outlook.com (2603:10b6:a03:4eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 04:25:51 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%6]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 04:25:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-next v4 3/5] null_blk: fix zone resource management
 for badblocks
Thread-Topic: [PATCH for-next v4 3/5] null_blk: fix zone resource management
 for badblocks
Thread-Index: AQHba9yk00IPExgt9E6jXosDrdH+4rMjuHgAgAGf5wA=
Date: Fri, 24 Jan 2025 04:25:50 +0000
Message-ID: <r7f5pfp4qfon7g6l3mzmuuae3a5e75xvsjwoc5qfkc33zmaa6l@dup7i5ncdqvo>
References: <20250121081517.1212575-1-shinichiro.kawasaki@wdc.com>
 <20250121081517.1212575-4-shinichiro.kawasaki@wdc.com>
 <762c1246-5436-494c-b7e0-0f4ace34e88b@kernel.org>
In-Reply-To: <762c1246-5436-494c-b7e0-0f4ace34e88b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8538:EE_
x-ms-office365-filtering-correlation-id: 2c677d05-8cac-4f89-0926-08dd3c2f2f36
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?d+F5jzE8aifuLf+G7TL8/WK5NGpqNx7Pwu9569k6KtNP6/uQ5Ni4dx2dcIPy?=
 =?us-ascii?Q?4x804XJ5vcgOgOMR3y/hUwFkZhy/QOHFKGMxy1/G53i4xuXT/In9UvW/nau2?=
 =?us-ascii?Q?116+mRjePA+p6khMxx8DikFNNfF5Xzp/Kt2b4iFurGQ7f7+aFTsTpLJkVJsc?=
 =?us-ascii?Q?IZhZRBvkUkGKxP979EL/1JvEV7cI+DUhLhxBlST8IlXQaZXiIMQhBM+SkRee?=
 =?us-ascii?Q?/cJXgmOKZIrDCWny81/QhLdOmX9349CUiNvckCFhpKmnIRGW7NAA3q0X8PZh?=
 =?us-ascii?Q?LKgrp8rRTHJ8X2hbUd6lQlRzL/epIFlKfeWGlEXPvUG92oFaDlJaMsaLTWCM?=
 =?us-ascii?Q?WMQmiwEmXRvT8nAVCXg0mtV0BWaLoiEK1HtUHV648Iz4kuOCh4mSTCVtOzJa?=
 =?us-ascii?Q?BkB/1BO36q2yF1nHS3Fpus7NwfNONqLB08MVoFYnDChTGP6PVWafPIxDnqMR?=
 =?us-ascii?Q?XHJFK6Uk9U2OuD910w0frhT/OdPfrRpAUF3qVvFnbOq4JaWupWvgewxkcfZ9?=
 =?us-ascii?Q?98aEz/t9kBAI7aiuRIGbkN6WSRZ3HZFS64nPb2pjbfYfiMJcCJFTneGgQGHY?=
 =?us-ascii?Q?eqJXI8hXaK1dTyMwi5XBCMrCwA1rofVeOmsHhMPxbpaiHzjszWyY0rODtY29?=
 =?us-ascii?Q?XcjNixBWQ7Gcrk58Kb7VvFZMcFRkJA/bPH7rE1ADq6n9KIEvW7WMYFGwds0i?=
 =?us-ascii?Q?Lf7BQHeaTHCM4ZkicyHbxq0WfKn2xu/ieNCEqWMRxODQsy4bDnkLK1jsoMs9?=
 =?us-ascii?Q?nbPANTtSIZWRdBKIZqIUV1lSprbNKS1ubDjj2dwPLeqmypdOncHlxoU3bujk?=
 =?us-ascii?Q?CsdIRVmuirqSqBVs/D3KXq2q7j6RgykB1MtLJ61G1XLLL/d9mnaPDX1LZ79r?=
 =?us-ascii?Q?X4zI0Y1YFtQXtdIMr0Z2gtVyrxUsObqINVPJGjKPrum7uAC7HP9zJkiIHqpw?=
 =?us-ascii?Q?EQDQMPa2S08WfxmwaBZqNiG9yEvgzmCi9kQJqDcszlDRLfuf1Wa7g4qr4Qg7?=
 =?us-ascii?Q?Ueg71dIF1SfFKGytkMBDvbpwgA1DfAX+nXgxK7ZwcyZaRjcOdI/8KYhJzMu7?=
 =?us-ascii?Q?dRiC4TTZeHPwB9LWOIXjltbHfi0AuoMBQk1H0f8DJbHnbxJRwpE7oFALkwIN?=
 =?us-ascii?Q?sX2rGx4ymYS9GuIppnH7zbcgrkWxf9Z5sJk2o60K95NPoftnp1De82ERGHPR?=
 =?us-ascii?Q?GVPvOGhJDRnPPRjNCWzrJ2rPk3B0uf9k2ZD/hP5nuVXhPeDxL1HcdMnKuz/E?=
 =?us-ascii?Q?scT3KN9k6ulRm66HgUOoP+TRGoOzgiMxwRL1zejjp3mUbEciEhmAewVqM2vF?=
 =?us-ascii?Q?A0Wo4/nmhNz6HoH0GI580YyNwnrnoqlQLMHPyMBRBy1cMFn5kmm4pKIReNdK?=
 =?us-ascii?Q?Gd2dECsnrZn7OnvFeCSkk9/5bAP3DbPc5v405eQaVn15E7EYfdmozfUvipkY?=
 =?us-ascii?Q?+XCt7JVduW6uxTJGvApWyE8krF9bNW68?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BzIo1lqREHqdyoxJ92dV9l9P6BedQYH97bL80fMEpf9N9dIa5v0HfgzpWV6L?=
 =?us-ascii?Q?zwdQiFSwiA/yzCPoB+5wVpRoJYdSZ0/dIyzQG2HtWsy7gUsLhRBRksXbtJ+c?=
 =?us-ascii?Q?mgfbdc+OPM1BcF5WSJPjl2v++eiDHhCBrUQNLe1/WZuzEyy1RWKQCB9z6f0Y?=
 =?us-ascii?Q?+kysrcgsonuhH/+kUodFuC/cqS4etwJo/894HtXguxa0ZOk05BDey5zEDLea?=
 =?us-ascii?Q?aCMHeO+f2Xmha0ISyHqZ3T+N4SJkrPjUozLNHEn54quElh4HIwf5l+a8HdWN?=
 =?us-ascii?Q?URs93JUPyxjLOjUcw2yl5uXDED7pM8SaPw3fJ5e+46FiYXdFzdUEq8Wyi6rt?=
 =?us-ascii?Q?P0uk2joLNwFg6Mz5NOBBmfDdjBQ15N+uSJpcB+hwSKStGzXhusMhkYwu/fOx?=
 =?us-ascii?Q?rnhiv951RXKXC1y0dAXFO7HJJ8TD4mgpFl2n9Zho4TdpfAUtPWu2sjTgR/Ao?=
 =?us-ascii?Q?wQGWVot8qfJwa5kj2KEMbbD50sUN3mkGXtDwto+4dHQSHRo2L/wWWpB2O2/S?=
 =?us-ascii?Q?AhhWWCBYWX717dQ0ksttiJkSX3fU63QpkGm6dyc8MmJE7dhpdkgoENsRZcZn?=
 =?us-ascii?Q?X1omknUCPdCUPxMGgMZIyLNjYfIOt9ireaJxD86iZi8IvgNyExTwzF9TlClk?=
 =?us-ascii?Q?KetiotmFyQ3eq7nFTcsEVKGY3K8UGMM8HMZ0uISAc0hQL+FSP5xw0t1UfKkm?=
 =?us-ascii?Q?EP3jCVg7Tosl2F5qybpcQSO10tW/d2rKYXBHZ7Y3gLwBW/OkJEiUKL1h9hEh?=
 =?us-ascii?Q?I98AhD1CNboiDGz3B9WDgSEwwPtekVBaioZiwVcqZ3P0O2yTf7SQHqhKhG0s?=
 =?us-ascii?Q?99MtA2E/YfG/SnaIXbZbss/Or+kzJKv8HyQv2P/briHlp4prMyezr2gUmzhT?=
 =?us-ascii?Q?OwX3NRoiimJn4E/RaZM8sj9jhZ6x4Z1x+wXUuokvBq0f+zCU6sYBju/24+HE?=
 =?us-ascii?Q?jwVMFNBU+31Xgyo2pa4A5Kda7xml12w5ZesPaDrzG7Myilw+O6cwwSVmwqFs?=
 =?us-ascii?Q?BY3H5teE66U4d6y+YNoBYYxFLBRgdLrsvWq1W43pVxfqNHfwEGYcHSP1WOFA?=
 =?us-ascii?Q?KPMVVyjhmv5O1qIlPPdPJ5SHmL2eJzW8lrrwEVUbtRSQAFKY9+5zt9AQKOJp?=
 =?us-ascii?Q?KqsM5ZGOxBdoJ9Q/tLh7HsOk6ckpDLyICtMdvqwZtev77JGNpoOHb6qaPei0?=
 =?us-ascii?Q?sE+A0mVNpe/3pWftliqH9UUgNJqtZemWXfASGhLYnf14vZlit3gcSzgi8eMi?=
 =?us-ascii?Q?aFxluCZX8Iv0rGyTNMNUGBFWCLCZILetfEgfmo8A20rSd0F6R1LNTe7zg7Fb?=
 =?us-ascii?Q?5fzkkeOL2OEYIBLEGrbCPHCPqvvXWJIp18TgqmnyjgG2DHOjLV5quEVV55bo?=
 =?us-ascii?Q?T2yx3qpvBukduCJTyLOCcj8R12mO1NYfjS5GGlTCyjM9M3Kep9vi129YEXXp?=
 =?us-ascii?Q?FvPWixGlF14a5G/vQQ/TgPZm9JSIatPdMI//SHIh/91CqLYB3BPC+rgORjAt?=
 =?us-ascii?Q?7dhhypJtEdmXMC3WANmJDXyYTBJKwrUfx1ZIyxQIZn5OaaY1GaxYSKJCp/Hb?=
 =?us-ascii?Q?OfP9ZGZLre1qDVn2xr1vJv5gvN5pe68sfLueBpELGT5APW6Yma3PQZoDL4k+?=
 =?us-ascii?Q?h/gliMwkL0NwM/eQdHA+L7g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0BEAA9A184DC54E9F6722C73FDDDCEE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vT2xXI3BINxZN1V6u802E4R9h47b45xHJry4CbdaRgEQX4vGiHr/j4RTGEPbp3XL+w12FPhOLlJKkh0uspxE4/L3LnqpMmM8Fg1YV6tvgaYPGJ/Qyia0nsXWyhjQ9gD1krcvZ+TU0U/gniP/qopOQwXG0tT0IjoKH0vw0BZOGTm+ow18yRn4Eq1xOpz48jmCRf+3eYQngY/fHyR0YZssV4AGPXw3kTZVGt2BqMtBiIKnEJ6jSDyFxcLkkxDlymlvAgR33Q46pcbtUk/1edfAIONWDsPViZBbZSPhdIGcxQ/UA59G3dCCV6KruSWprI7Vv6+W7JiDW7mfOVyqjOU6X08UGs/OGH0vPtzSnqSt/OOx51py0joQM2N4ttS7ob5diI0ouV6YSRM4psD5OUgPjNdZk+l32t4mCtXRrLS/mgD9XFi9IGmt3DVftZn/uMElSWxG8n5uFHI0EsEZfERDekLi6fwbeE6VlirhOW5+I3WzyGx9lQc+4kx3RRorQI3/YSJM+rnBtSV4OdwOJNVNr/7QFURVYcrW9IdvSJrN86s8D+7Aou31oubb1kKGtZeLK1CbocoPyMYbCgQSSEHqVhyk2qpWCF2q0XuXdWgwRX2U3FaRpx29rjTYCrp8yzzZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c677d05-8cac-4f89-0926-08dd3c2f2f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 04:25:50.9472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mChTDTNDu7zai9Zn4Qq6P7wgT93d1mtLg7sB+Uy9m5E2fa9URoN+7nwbCbFCkN6mEgmaK86YnGdp6l7Stn6zSobAuw8wwK05yrmLZ9PrTDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8538

On Jan 23, 2025 / 12:37, Damien Le Moal wrote:
> On 1/21/25 5:15 PM, Shin'ichiro Kawasaki wrote:
> > When the badblocks parameter is set for zoned null_blk, zone resource
> > management does not work correctly. This issue arises because
> > null_zone_write() modifies the zone resource status and then call
> > null_process_cmd(), which handles the badblocks parameter. When
> > badblocks cause IO failures and no IO happens, the zone resource status
> > should not change. However, it has already changed.
>=20
> s/zone resource status/zone condition
>=20
> s/it has already changed/it may have already changed
> (because not all write operations change the zone condition)
>=20
> > To fix the unexpected change in zone resource status, when writes are
> > requested for sequential write required zones, handle badblocks not in
> > null_process_cmd() but in null_zone_write(). Modify null_zone_write() t=
o
> > call null_handle_badblocks() before changing the zone resource status.
> > Also, call null_handle_memory_backed() instead of null_process_cmd().

I will rewrite the whole commit message. Please see my comment below.

> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  drivers/block/null_blk/main.c     | 11 ++++-------
> >  drivers/block/null_blk/null_blk.h |  5 +++++
> >  drivers/block/null_blk/zoned.c    | 15 ++++++++++++---
> >  3 files changed, 21 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/mai=
n.c
> > index 2a060a6ea8c0..87037cb375c9 100644
> > --- a/drivers/block/null_blk/main.c
> > +++ b/drivers/block/null_blk/main.c
> > @@ -1309,9 +1309,8 @@ static inline blk_status_t null_handle_throttled(=
struct nullb_cmd *cmd)
> >  	return sts;
> >  }
> > =20
> > -static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd=
,
> > -						 sector_t sector,
> > -						 sector_t nr_sectors)
> > +blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sec=
tor,
> > +				   sector_t nr_sectors)
> >  {
> >  	struct badblocks *bb =3D &cmd->nq->dev->badblocks;
> >  	sector_t first_bad;
> > @@ -1326,10 +1325,8 @@ static inline blk_status_t null_handle_badblocks=
(struct nullb_cmd *cmd,
> >  	return BLK_STS_IOERR;
> >  }
> > =20
> > -static inline blk_status_t null_handle_memory_backed(struct nullb_cmd =
*cmd,
> > -						     enum req_op op,
> > -						     sector_t sector,
> > -						     sector_t nr_sectors)
> > +blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req=
_op op,
> > +				       sector_t sector, sector_t nr_sectors)
> >  {
> >  	struct nullb_device *dev =3D cmd->nq->dev;
> > =20
> > diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk=
/null_blk.h
> > index 3c4c07f0418b..ee60f3a88796 100644
> > --- a/drivers/block/null_blk/null_blk.h
> > +++ b/drivers/block/null_blk/null_blk.h
> > @@ -132,6 +132,11 @@ blk_status_t null_handle_discard(struct nullb_devi=
ce *dev, sector_t sector,
> >  				 sector_t nr_sectors);
> >  blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
> >  			      sector_t sector, unsigned int nr_sectors);
> > +blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sec=
tor,
> > +				   sector_t nr_sectors);
> > +blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req=
_op op,
> > +				       sector_t sector, sector_t nr_sectors);
> > +
> > =20
> >  #ifdef CONFIG_BLK_DEV_ZONED
> >  int null_init_zoned_dev(struct nullb_device *dev, struct queue_limits =
*lim);
> > diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zo=
ned.c
> > index 0d5f9bf95229..09dae8d018aa 100644
> > --- a/drivers/block/null_blk/zoned.c
> > +++ b/drivers/block/null_blk/zoned.c
> > @@ -389,6 +389,12 @@ static blk_status_t null_zone_write(struct nullb_c=
md *cmd, sector_t sector,
> >  		goto unlock_zone;
> >  	}
> > =20
> > +	if (dev->badblocks.shift !=3D -1) {
> > +		ret =3D null_handle_badblocks(cmd, sector, nr_sectors);
> > +		if (ret !=3D BLK_STS_OK)
> > +			goto unlock_zone;
> > +	}
> > +
>=20
> This should come after the below zone condition check and change...
>=20
> >  	if (zone->cond =3D=3D BLK_ZONE_COND_CLOSED ||
> >  	    zone->cond =3D=3D BLK_ZONE_COND_EMPTY) {
> >  		if (dev->need_zone_res_mgmt) {
> > @@ -412,9 +418,12 @@ static blk_status_t null_zone_write(struct nullb_c=
md *cmd, sector_t sector,
> >  		zone->cond =3D BLK_ZONE_COND_IMP_OPEN;
> >  	}
> > =20
> > -	ret =3D null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
> > -	if (ret !=3D BLK_STS_OK)
> > -		goto unlock_zone;
>=20
> ...so about here. If null_handle_badblocks() return BLK_STS_IOERR because=
 the
> first sector of the write operation is the bad one, then we will return a=
n error
> and not change the write pointer, but we do have correctly changed the zo=
ne
> condition nevertheless, exactly like a real drive would.

Thanks. Now I see your point. I thought that the zone resource management p=
art
should be skipped if the first sector of the write operation is the bad one=
. But
as you pointed out, that does not simulate real drives well. Even when the =
write
pointer does not move, it's the better to change the zone condition.

When I modified this patch as you suggested, I noticed that this patch no l=
onger
changes the behavior. Even before this change, null_process_cmd() returns
BLK_STS_IOERR, and null_zone_write() skips the write pointer move. I still =
think
this patch is needed for easier review as a preparation for the 5th patch. =
I
keep this patch in v5, and will rewrite the whole commit message.
