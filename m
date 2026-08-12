Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012043.outbound.protection.outlook.com [52.101.126.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE642DA5A;
	Wed, 12 Aug 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535952; cv=fail; b=oAjo63IFQv+dwdMOCoJScf5L2NpfpGJ0IrcpADeagxHM8JxhFEeFRP63rikuHJDivxRgG+eC1r8mbo0HenrDnSTrc7d0J7lj+cGEhEjS/2ako4q7W1V+ZYbOES3b0oDANrwV+giNzkBDyJLPz4/VXdMAAIrYBr09wT4PtxH/BjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535952; c=relaxed/simple;
	bh=K9YM1qSMj4w223Vc3gtiY+5WC1DNY5Pnz1nViSPf9OY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sRoVg7HKLQUSW41I/7N3KKFoMOZnrpWxTrInDEA/+FrJiBZSPz4WPcRqyqabIQoDaM83O/KV1xzT0yo7jVxeDcFWyK+aHvrsN3HtKIj5MyfqfF9l8dvwUCykm5BXtvbtu6B9ylF3YSG0I/NU55dwyS+434mUpFKr6fq5MNc8+1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=k79Nnw1n; arc=fail smtp.client-ip=52.101.126.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="k79Nnw1n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8Q5jZ/Zpzwrdppx4cs6H4wv+k3eCXORd3S11b74DPB/N3UwPP4U/lHK++E+2G9g6p25LOJJ2Xnfg1nL23cxVVXQy+97N2u/ArgevUWohmFqG3mKZFulmzXyD4xu81mUvFKnwH3QBBXDzQhsqvfCMy/SoEKiIk4NHM+GCVTyPq/XLv5tW7DXuMOHGlHNgC6xwSj/LjIF1oeKwQoKdHNNLVWxv/O7a3uM4YUt9Sq+p7kjXj8qLmyRrAnFkZPDXvdAvsebmDIQzA1R57Bzdz/+VPwA8Chru1uZco1KBH6Ncdzm2l/EOLK/gRDqTPtSXdqcAT8Uo6orRY6QYQTlHmqenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9YM1qSMj4w223Vc3gtiY+5WC1DNY5Pnz1nViSPf9OY=;
 b=EvYA6Pm4gbj/kfpqSwcI4UtEoTRsiomCPW/eGEeOwd8hkfstAKS/26hP1cUKmVyhTW/Ixd/j5s5vwLYzq87IoXDyC0cGUfN+e4wy1AvcSPjseMw8azWQwU5l6X6YbQMMY3ZWE6B2epvIQXotAbWPrjSZU3SmHYg3sgGpfw4b/wakXESo57/9QGRUryafK9aOR65KKKZnNMjzQ8DN1knScY+XrtNQtECrDzMgQK8+ouA4x/32Wzm1VFkuPxJhSjznyMMV55w3D0+mKY9hnNS/Op8PZNGEL+GdJACFhtrP8Z7rWfSY0JaRlCPQZLpkvCGEmv5zixF3YD8HHcoA4qwNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9YM1qSMj4w223Vc3gtiY+5WC1DNY5Pnz1nViSPf9OY=;
 b=k79Nnw1nNDmzf0Q8+CVl6Fp6TqTtl0lYmhB3bpqxHGmNGBeZUbIwRyS13D2cyjgXtHEc8pfeZCpruwak9USffrKnv6fIRZMFrRiAXbvSa+R91ghSVDtcpsZ1K2i36DhQFR38JCFJ2hVbE5cFFm8LjRfUvqeF1viLDaIyL3awILibNl+vTTVezT9Xq02HWV1KxKpZMlAO0+8UT0HugAGKHNO5PSmHAqNBiLHBSM6y2aMZsBUcShB2LsWJhtEtAmnO+9L+h28mTl5yuTBp22Psyu8U+fzSBIvKyOzObuKzlXJuHD4M99jrH1D/KUuv8po1ALaxcd9dxyj9IKdIk4RYWg==
Received: from PUZPR06MB6224.apcprd06.prod.outlook.com (2603:1096:301:116::8)
 by TY8PR06MB9056.apcprd06.prod.outlook.com (2603:1096:405:3a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 11:59:05 +0000
Received: from PUZPR06MB6224.apcprd06.prod.outlook.com
 ([fe80::2cfc:b348:3e15:3751]) by PUZPR06MB6224.apcprd06.prod.outlook.com
 ([fe80::2cfc:b348:3e15:3751%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 11:59:05 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hare@suse.de" <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
Subject: [PATCH v2 1/2] block: set QUEUE_FLAG_DYING unconditionally in
 blk_mark_disk_dead()
Thread-Topic: [PATCH v2 1/2] block: set QUEUE_FLAG_DYING unconditionally in
 blk_mark_disk_dead()
Thread-Index: Ad0qUWEpTAGCPjLqTvmx3kxWJse5gA==
Date: Wed, 12 Aug 2026 11:59:04 +0000
Message-ID:
 <PUZPR06MB62247E82E66A3ED46CC3E6C7D2DC2@PUZPR06MB6224.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB6224:EE_|TY8PR06MB9056:EE_
x-ms-office365-filtering-correlation-id: 93f06224-727c-46b6-3d32-08def8691b6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|42112799006|23010399003|366016|10067099003|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Y/gc2m2FZzRcn9UH2mJ7pDAT+Kyckv2QA+06xsM0ZdwCCfTeg/xmWjw1vfkiIaX7TkZac+Qr3T4SAe2ym4tlauDCYR5B8hZpl6GNId4T765vXdwPDmT4DereYn+yMlxWFjJ82u4JGwE6QQwR+Z8X5frBbqDs643m7gSumSguORLWcf/aC2X7HNqeKDqEjOSzZzlaZD97p+8S/134i2nA6pQMJwIHj+Px9XIuGv6vx2+oWVz6UjDhxgfNFQnKobcIpJCPYdDY19LPwL/aIGlac8d/2JJX+l2cwFwbpFZhjw22NMrdi0NSddhNetwCduxhE/FmWKDcfYhPT2kpSGhZlimUIoFRx66MW1Uq0UtTUkBBtePC9MzrFsYDYE9MF2T9UwC0G7DyASU9AQPe7ad3m8SH76nxKuoBa3AlYoC9DghdfrFpZY9FVsfu4rcdac0gzNH5BWgEESDO5hsNLJcRL4Nxp8oCCBd1QYc1qgljAmF1aLQpBtafRrXOHHzXO26HrYmUTOUUiOHmpjocOjtmcqlFCwkmsVY8NhZPbCcCNP5QwfUeLDoSHTCdcy7xK9CC1PRTUES6pbOm2sP6evMyGpFgHw9hb8ZEKkLZBNsJIAIOM3Avt96mfWc6bkqO+9e/bs+KS4AKd6MeqT5xVtC53ydAwKC37gM1WCvs3Pcc6d9t5hlxMiGNGnHrpVc7shQo6Iy+s2VnzpQI84o846nz3c3wjtdzGEYDsuI5MDxaE+4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB6224.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(42112799006)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?KzdGZVZtRFBmNjJkaHBQeWFZeStKMk45eGw3SlNsaHlwUm1vRUw2ZVYyemN1?=
 =?gb2312?B?UWlIUFhBY1c0Y1BjaURaMTdkTEdKNWZyenUyMVJ1czNudkF1T3V3VENHS2Vn?=
 =?gb2312?B?N1Jla3V4eDNUSElqNTRTQkRjT3Y2SjQzMnA1V1VEL2lleTU1QnV3S0tlRFh5?=
 =?gb2312?B?Ykd4bXBJQ25Bbk41LzVsQVl6Uk1zS2pIdXFhUkYzeTBHWUsvOHVKYnN5OS9W?=
 =?gb2312?B?T2MxK3dZNW5ybTZOYUtiVExSSVIwMG85WUpNR3o5ejBHMFdPRW9vSEhXOTJD?=
 =?gb2312?B?aWtXZFRzYzVSdlh1eE5rUkRsNG9FbmtjR0NQc2JIUklKT2JnZ1pteEZpV1l3?=
 =?gb2312?B?dG82a1puQnVKVUh2RUFGc05VbEUyT0xxSm95bnoyUzV1ZU8xY3dzd0d0dDNl?=
 =?gb2312?B?ZUwwelZiWkhvME42NnBTZXA3ejV1UWdsY0o2cGJ3VG1HYzVLYkJBTVc5dTRU?=
 =?gb2312?B?R2FBd1NvNlpKamdBUW0vRzFhU2xVckkrQ3ZPdW5PM1hJRTFBNUx3aEVsYXpR?=
 =?gb2312?B?TnJQazUwWEt3b3orV1NRR2ZZa3BGVXl4K0gvZFBJSVhyK3FJNDVVNG5BaW5q?=
 =?gb2312?B?RS9WUjJHN0wyTk92b3p6Y2RSQ2R1eWF1S1NlU1FPcUR2Rm1XNHJaeVQyY0pn?=
 =?gb2312?B?a3ExeEZPTTdLNHU5REVSQW51cjVaRXJabHRBQVozSkhmZE9Fd29ZQzdwMnhx?=
 =?gb2312?B?SE9lOVR6UlpFQ3RUZUVvRnJZRC9xdDRMRlhzTDBvZDgvanFKdjlIVS8vdE1v?=
 =?gb2312?B?dk40MzZuUG1PY2tOV2w4R2RmUXBRUE96dUdXNXphb0hTeFUvUjRHZngxUVZN?=
 =?gb2312?B?SS83ZW1TVWw1Ynh5eXYyZmZGem9nWHc5R0VHTDlJSS9oejVwa0xTc1R3VDlP?=
 =?gb2312?B?R1hmV3RGU1FLZDVrdmZaN3RUMmppVk9LdmdDRFFwamRPWFRZMUpuN0pkQnVT?=
 =?gb2312?B?Y0tPT3NEN0RWOVBJQUVnTStkcXdMdzcrekNqYU5VRVJOcWUrUWJoQlNBSmR5?=
 =?gb2312?B?QllqcVpTVGNQTGRuakFaMURMZnRhdm54Z3VZdWM5elV1Vy9uTDB6N1pYL1Vw?=
 =?gb2312?B?SERTK25PWHVXNzhFcDMvSkJYYWkwclVXVGhrRWpEL3NDOUZJbDN1R3FEVUZJ?=
 =?gb2312?B?LzBjUjBIZXdUc3lFUlMzcU1ka0pMdVNHUWdxZVZhbEVXMjMxWWg4RndQcDFz?=
 =?gb2312?B?THBZbGliMURmYnJ6eWhOcTNMbGJVNmNmZUxoNlE0K0grNHltNnVWbDRXektn?=
 =?gb2312?B?TlZONldDZDcvMVVuVnk1WUJQbUVXMWQwdFVaTGw3SjJGN3VJdzV2bTJ0TS9x?=
 =?gb2312?B?QnFCQWZBcGJOUGw2Ujl6d044ajZraUhiY1FvUHZoQkQ4NnF2a0VGUEl6WEM5?=
 =?gb2312?B?dGNhT3hhNUZObWRpUjVlRThSY2pUanIzL0Q5Mml0UnNNK3hjUUU1bXlhUi9T?=
 =?gb2312?B?TWJjV0tYeHpENk05endKd2hublFSbWVBNmUxbFp5QW1oRWNzdGprNXdvYW9O?=
 =?gb2312?B?RmlnNWNEV0w4V1c2MVp4SFd4L2lkK3VvUk9PY0JUbkJ4ajB3ejRuSEx4d0ow?=
 =?gb2312?B?YkQxckRzakJOUkhKajVQRUdWT3V2SjBKRmlNamdKY01pWHBqektuTUdDc1hL?=
 =?gb2312?B?eGZPcS9NZytXNVNwQUpmYzBDU09BS1J1d3JMcVdUaUQrM1k2cFRPSnV2cUd6?=
 =?gb2312?B?TnBncmtwejZpT29NZjI3ZVo2d2dnRFFhTU5PR3VRVGNLeW85bkNJbEFUZGUr?=
 =?gb2312?B?S3R1UXFQRC9LbC9HUDZZUUFTNjhBL1lodzlxeEUxeWUxcG1VSURDTnp3ZFM3?=
 =?gb2312?B?eWZjOURpbFJMbmxKVlpadUc1OUlWMUdIU0FyZTRZR1c5ZlgyVFZlM1hoSkYy?=
 =?gb2312?B?Tk4vdElyUm9YS21RQWg5dUF5dHM4M3lpdkxwRFhFR2tFRmVTcEFBaW1LNi9w?=
 =?gb2312?B?V0dOa3VncTRjbE9XclZKWEdNWElvZFZWa0YvYlJod1k5SFVmampYWWZLb1RX?=
 =?gb2312?B?Q09FWC9zZ2M3T3ZOcWdGY2s1QnRBWmN2b1lrVXFGTlgwaE15QnZ6WTZOVHdy?=
 =?gb2312?B?SENLZmFzTHNhVmxZWlIwWityQ21MdCtuRnlkZWRUazdtVTRveHF5SVpVOEFM?=
 =?gb2312?B?TTJQVEJFYWxJckg1ZjAyM3hBZlQ2MkpZcTg0YmlnZW00TFNjNkkxb2VEamJL?=
 =?gb2312?B?elJCSkp4TFVvdGM3NExia1NNQ1lkR0IwcW9HWUllVzRTWXhTY0JBaDluZjZn?=
 =?gb2312?B?ckJIUnZuU2d1aHpUaU1QT1FueUJHWi9SQW9OYS9hOTMxR0ZiTjBHNDdUTk91?=
 =?gb2312?Q?YbsCbl3nUyu/ncbglP?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB6224.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f06224-727c-46b6-3d32-08def8691b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 11:59:04.8453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKzt6UCANTkOfZCPPYqpQ/WOIUfiAZcH1zXqPJiilXKRQMLER9cABd/pBS3uIk4iJVC57z2k3PiHi3ecPdyybQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9056

RGlza3MgY3JlYXRlZCB2aWEgYmxrX21xX2FsbG9jX2Rpc2tfZm9yX3F1ZXVlKCkgKGUuZy4gU0NT
SSBTRCBkaXNrcykNCmRvIG5vdCBoYXZlIEdEX09XTlNfUVVFVUUgc2V0LiAgQ3VycmVudGx5IF9f
YmxrX21hcmtfZGlza19kZWFkKCkgb25seQ0Kc2V0cyBRVUVVRV9GTEFHX0RZSU5HIHdoZW4gR0Rf
T1dOU19RVUVVRSBpcyBzZXQsIHNvIGZvciBzdWNoIGRpc2tzDQpibGtfcXVldWVfZW50ZXIoKSBh
bmQgX19iaW9fcXVldWVfZW50ZXIoKSBjYW5ub3QgZGV0ZWN0IHRoZSBkeWluZw0Kc3RhdGUgdmlh
IGJsa19xdWV1ZV9keWluZygpIGFuZCByZW1haW4gYmxvY2tlZCB3YWl0aW5nIGZvciBJL08gdGhh
dA0Kd2lsbCBuZXZlciBjb21wbGV0ZSBhZnRlciBzdXJwcmlzZSByZW1vdmFsLg0KDQpibGtfbWFy
a19kaXNrX2RlYWQoKSBpcyB0aGUgZXhwbGljaXQgInN1cnByaXNlIHJlbW92YWwiIEFQSSAtLSB0
aGUNCmNhbGxlciBoYXMgYWxyZWFkeSBkZWNpZGVkIHRoZSBkaXNrIGlzIGRlYWQuICBTZXR0aW5n
IFFVRVVFX0ZMQUdfRFlJTkcNCnVuY29uZGl0aW9uYWxseSBoZXJlIGlzIGFwcHJvcHJpYXRlOiBh
bnkgaW4tZmxpZ2h0IEkvTyBmcm9tIG90aGVyDQp0aHJlYWRzIHNob3VsZCBnZXQgLUVOT0RFViBp
bW1lZGlhdGVseSBmcm9tIGJsa19xdWV1ZV9lbnRlcigpDQpyZWdhcmRsZXNzIG9mIEdEX09XTlNf
UVVFVUUgb3duZXJzaGlwLg0KDQpGb3IgZGlza3MgdGhhdCBhbHJlYWR5IGhhdmUgR0RfT1dOU19R
VUVVRSBzZXQsIF9fYmxrX21hcmtfZGlza19kZWFkKCkNCndpbGwgc2V0IHRoZSBmbGFnIGFnYWlu
IHdoaWNoIGlzIGhhcm1sZXNzLg0KDQpGaXhlczogNmY4MTkxZmRmNDFkICgiYmxvY2s6IHNpbXBs
aWZ5IGRpc2sgc2h1dGRvd24iKQ0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNClNpZ25lZC1v
ZmYtYnk6IExpYW5xaW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNvbT4NCi0tLQ0KDQpDaGFuZ2VzIGlu
IHYyOg0KLSBTcGxpdCBpbnRvIGEgdHdvLXBhdGNoIHNlcmllcyBmb3IgaW5kZXBlbmRlbnQgcmV2
aWV3IGJ5IGJsb2NrIGFuZCBTQ1NJIG1haW50YWluZXJzLg0KLSBUaGlzIGlzIHRoZSBibG9jayBs
YXllciBwYXJ0IGV4dHJhY3RlZCBmcm9tIHYxLg0KLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvVFlVUFIwNk1CNjIxNzU2NkNGRDMzRjU3RDNBRTQ2ODE2RDJDRjJAVFlV
UFIwNk1CNjIxNy5hcGNwcmQwNi5wcm9kLm91dGxvb2suY29tLw0KDQogYmxvY2svZ2VuaGQuYyB8
IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvYmxv
Y2svZ2VuaGQuYyBiL2Jsb2NrL2dlbmhkLmMNCmluZGV4IGRmMmMzYzY5YjQ2Ny4uN2IwODllMmQ1
MmM0IDEwMDY0NA0KLS0tIGEvYmxvY2svZ2VuaGQuYw0KKysrIGIvYmxvY2svZ2VuaGQuYw0KQEAg
LTY4MSw2ICs2ODEsNyBAQCBzdGF0aWMgYm9vbCBfX2Jsa19tYXJrX2Rpc2tfZGVhZChzdHJ1Y3Qg
Z2VuZGlzayAqZGlzaykNCiAgKi8NCiB2b2lkIGJsa19tYXJrX2Rpc2tfZGVhZChzdHJ1Y3QgZ2Vu
ZGlzayAqZGlzaykNCiB7DQorCWJsa19xdWV1ZV9mbGFnX3NldChRVUVVRV9GTEFHX0RZSU5HLCBk
aXNrLT5xdWV1ZSk7DQogCV9fYmxrX21hcmtfZGlza19kZWFkKGRpc2spOw0KIAlibGtfcmVwb3J0
X2Rpc2tfZGVhZChkaXNrLCB0cnVlKTsNCiB9DQoNCi0tIA0KMi4zOS4wDQo=
