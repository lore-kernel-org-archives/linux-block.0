Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AEB286426
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809370; cv=fail; b=L0JBHiHa8tOVEZ5svcOL5Z+Ee90Fy8kQw9dPZLZzyd5kBXUGwaHTBrrLm5HcQxeh4wYQG06Mh+QRZUp+K99QuvCHgSZwIvI7GQOVhVsE/81EYic1mYymUzbkM8T8vy7VN5hz2b139G2leCS6XNbY9+FTjHX/OrGNKfdNydvcfi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809370; c=relaxed/simple;
	bh=sdMTrl9g9VxZkSrivEJcvzFxJZyjbqJV/g1gEC+ZhB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sDtYQUnm69XhE2+MSJvlNyyYUbjq13gKQyBxLwjmHj3BTjHZMjip8n3dbWAHJaEEZIulHE6+iJIjPs1GewPXPvU+5atRe8/xhUTRG3tbkMF9wYQjV20Q18mA6NAI8S/Zrw6RkNzzajp+gPoXyLYis5GHvy88PX862mYROQJNNKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=idgbBfcX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rB21Hp3+; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="idgbBfcX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rB21Hp3+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758809368; x=1790345368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sdMTrl9g9VxZkSrivEJcvzFxJZyjbqJV/g1gEC+ZhB8=;
  b=idgbBfcXZBeOHofa48M6XPQnv+CPDJI/359LkN04DevThCVYW5T758+/
   TPiT7Aiivg5QcpJOtqHVMKI0eHvxcu2L6sNeZUEdBeGgbJqVAN5PoS5eI
   j/LksIJSKcjz1ROjD6VwaqH8n2yNCXTIWLNFHMU8pOPCxBFhf9C0GBz8H
   Z7FIR5TC0Ok1Ymdp5GtkvxsW/ozHjfMVcL6oZQZxYSKI2lwOpbwEUmQte
   xhvcem1ZZlZuVvl/lhjh9BbdkiKyzsJ7umHcXHc6/LGye4/RFU0LiTY/i
   3PsySMMV90m2MzgUU0s4fUBbVhv871AFWwJ9KPefx27ZudylqbH/+ta9j
   A==;
X-CSE-ConnectionGUID: 7gxENz6wTeuigq0BkuMb0Q==
X-CSE-MsgGUID: UBPeVysvQ4CLP9b3yjd1lA==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="131249512"
Received: from mail-northcentralusazon11010068.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.68])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 22:09:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+YDPYMeLKU8YoNp1lLeR0DvQ5gwlEWcUbGdfCxyaDXJoYz/5de/vXuYzGmx7PB0OIp+Soan84MAAHLhZDKGVfSMyRPB5u4QqR3APTtPu4mL5FLAuxSmbKx0q8DVnMbdR4uVMQj7JvELg/ooM7IlSUsEZL9uFrDuKzy2YvYh4UcjcOp0frlfJRtbZ02FnBnCmKvIMRFDUSheDwf/0FsaMGvKkj5e8yu06q5Gu0N/8sJ/DBzgArStaKhR+0xce5LqqMHf8VWfij6MLKuJVqugoMTVy58Nezn48HdhaIGPp7K8k1Bqas7GQhVbhF+UFcCk9vp6F6ab8DYvpWdsPPNYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eVMlueEis/6EV+XKorEfTWY11vPaFp8kjsp15h0I1M=;
 b=rXv1hq4ywHQcQc+cMtbM59KCxqWQeFHn8Ki2Zf3ijQXurS1UF0fOQm0Kcn95F283l2qTpaxVXJ8WDDz1vdlckP9OxhAfUaMkHELUVIDleO9hweCoSK2ie0aEAlSkE5CbzPJcmPs0Ck3fESMs8+ThuSrDOiSWbtA886VIpazkh3aR7XD1+uvQ2frRs+h8QhgVWNtNJLgPrvunsr+l96XQqTXcWI7PFuQp31V16XhAeVTfVztVFQDsZXvKBxrmkNfuZTSnWF6yy/ig8/zvi7Wtj1GmF7DP+XGh54POWF/o0pTiyLawlzwwYVI4x+8/tsbB0hOaZVBrPZWz0MVRqm0DMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eVMlueEis/6EV+XKorEfTWY11vPaFp8kjsp15h0I1M=;
 b=rB21Hp3+DNcJZgFh/i6OnkqqWSrqwCYfplsXv6pRSTfn4Q1/T8YRIGL2xapqu1Tp4DbZm4eMfUQf8TgZN2lqNAwdDTLHXiGkmRYgr/kK+hVzKpksvENA2L8/rpoR1yQPbyONzZOsHMeheLMlu/od/jug8TWJWQmyB5ehnv/hZi0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by MN6PR04MB9382.namprd04.prod.outlook.com (2603:10b6:208:4f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 14:09:25 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 14:09:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 0/9] Further stacked device atomic writes
 testing
Thread-Topic: [PATCH blktests v2 0/9] Further stacked device atomic writes
 testing
Thread-Index: AQHcK6shvwB+X66/A0CsPN+SwOZVu7Sj9KaA
Date: Thu, 25 Sep 2025 14:09:24 +0000
Message-ID: <x5yy4lurvv3gc7hzxdj7psnfor77aq2u3aqrk3swq2jsgjjwrl@6siwo33qhpyz>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
In-Reply-To: <20250922102433.1586402-1-john.g.garry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|MN6PR04MB9382:EE_
x-ms-office365-filtering-correlation-id: 2ddc86db-769f-42c2-4e29-08ddfc3d2194
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8W3CG0TC0a9CmQvFDUdrK6njV5ePSW2jrP/zX5Z0tCZSifnqc0+avLlp8ETR?=
 =?us-ascii?Q?PM2Z7lAFSUt2SPKjhpO3mX7OCmExWhvdiD61jFYLvBval+98xBI+t+lAo8b0?=
 =?us-ascii?Q?4QitAe2feFwMBWuHI1A3KKqaFTxJ7TyAkAj+MQ1OgEpIOwMlcT31bW4ks1+G?=
 =?us-ascii?Q?2kFlZ0evzimIIQRcDO18NniCw6Z4BVfvsfMNIHFDt6Epfd5rethH3ruwHDsj?=
 =?us-ascii?Q?UmyAz/hqlf+tqDCzbViuA9LsTe+Lr/ahX0NAQ/5TkAXzXY71jbXLOvcXu6pE?=
 =?us-ascii?Q?s4EGvWpYUarnomCVTjfLffZp6QtlA0LmFOk4GTOLQISg7CxEeSIvLYye+Uh4?=
 =?us-ascii?Q?is45ttRdrt2xTMCJKhp+qJ6pgbEgVPDIoNqast2u0iJ6eiVp6sEnKyulxNBs?=
 =?us-ascii?Q?66wsWCc3AnZwYMPxP8qfxFX5hHkXOKIxcrKkjHSGQ3pYUU8XY77b6QR9JBzG?=
 =?us-ascii?Q?/e97fk5RWF2mmwIZtC/fqTE+Ok3hqORdWZu4Lt2VbZVNTiHa0ZBYriGoK8nu?=
 =?us-ascii?Q?HnGnQfCmdaQlLvhkpK/byhYUAri+WLbMTHt1qOUCsvo7kQT0PSlWohg+eD7s?=
 =?us-ascii?Q?OcczaX12VkJoIr5x5H2nPIPNMCZusL/buoA5ByDJwwdqzINSrIKt8+SYA8ul?=
 =?us-ascii?Q?D1/uQzFHTJ4zwy3raetGPln+AT8n+Lm5qJ1SBWRyqEJfIKZliQZxe/FUVbUz?=
 =?us-ascii?Q?2c97SpYDMZTWVQLzbpKs8bf+J9YGd+z+RuxE75b8hRZAgSw1vgoTG2SyXMMC?=
 =?us-ascii?Q?tlnaDl/6nHT8VkurJ8lYzu46UK2HDueoH/H4E6xz766NHMPtx5fa9a2EMxSJ?=
 =?us-ascii?Q?ia9DS9VO6coOIx8FINhBq0Iuy1xO35jCKFR4f3PYQyJjmdxuuL9NeoWePtY9?=
 =?us-ascii?Q?Nf17DBeJvQ1LUs5eZXJAA2M7kX2no39CAG5PUTR0MKJenh/d7OiNCuPXswGL?=
 =?us-ascii?Q?+WSHfNKZe/W2eA45YrbNcdWPFWFNOl4cdAoUGXk4Qrr0yZt8mbFk18tV08JV?=
 =?us-ascii?Q?FYgiEObQvv/QyzU25Y/l6effSg6+XpetyGrinOUw2wQ3oI9+L+p8E5BJHxMV?=
 =?us-ascii?Q?b//7EA6qAyqW9iP2vVEf9Vp1AP6rPTzynwRYfLplNPOPhJSTcvgNFdHurBB/?=
 =?us-ascii?Q?LDYYfGf+lyMiYDhS/CJ6AcpIO4JTUL77tNxDapsrbNzGIEPaZr57P8BiidMY?=
 =?us-ascii?Q?Pt7jsx6IouX7KEg4vI0/99x305GuzefoY/puRJ7XOd3NxBDjOrGBzTNP0BWC?=
 =?us-ascii?Q?hLKn08KckZT84BCtnmzUtz7kyvoRMjpbu7OpV4Cy3VA3DsjhheiiY/rV3wK7?=
 =?us-ascii?Q?89NXxbdZXsqtIJogVa9u+UXzOpLrMKgVomLXFIA/qK0ytOlERvYeamyCky8a?=
 =?us-ascii?Q?B4LnRurSbPomuZrt+vNbDVQ5GUPTqKNMNUJcDezvK3nTOSekFRPd9lhOVpIO?=
 =?us-ascii?Q?lh04NazMBoktuQ9rTEs6B6OccO9/ffT9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pbNTmIQZprs51qVJHo8udRw3Ze76Tz1gVvlaQssgvoTehBMDXPE/xgJF9OvC?=
 =?us-ascii?Q?k0dvPLFu+YXpqgfy7B/NStasWZ/cY/AS6cNG7+4Zo06kiMHAou3EsS1dxYSN?=
 =?us-ascii?Q?b7zvrChJJfvZsJ8Ceu39weSp+hAcnZMiq3ItVaese3CqpePqKOnxFZYv0gvv?=
 =?us-ascii?Q?+zgzU24PgycySn89GFLnuqWmk1r1YulHaTFhdt3wK7VNo7PZdH9EHau4B5Jw?=
 =?us-ascii?Q?p7JItWjmhsy0WgzGv/CgQ9uTI+qaofhHPPJXasA7+p0cEjJ/Tw0FFL3ofyPO?=
 =?us-ascii?Q?Qv7MRqN54PH+8TyX39vcgHGWTOJR1PiKKw/pxVp3C86msjeJZxrTc74ZW7hn?=
 =?us-ascii?Q?1ojgVt6jUjQT+a42v6+9keubR5w5zghZ4XnmO8PnwJwL21JtVlRi8uh1um4H?=
 =?us-ascii?Q?PgqtVtnpLkYBCzCirwiD+WePRxYiat9rQFdTCAJS4G0lMAOTXcd1KewsNRq4?=
 =?us-ascii?Q?98DwZ0JV0fK2gguwbAlZ+lLroxWdvJRsI6ZkkQraSiwIOE72CAzPzvs1JbCX?=
 =?us-ascii?Q?GPakIpodYbPt5iNec13aAcuPc8AdagKAhQt460RE+H1kalvuAtrtmkJPRp/r?=
 =?us-ascii?Q?YSbaBI6QCpmtCtiljMn6/uMIoHHqxTcHN5MhxAhN9t4IjSi8BTwj+55QWU4a?=
 =?us-ascii?Q?zgKysqTXM5OezEPu/yKr+vE6Dow5j8xnEHEghjNkBFtonGgaNcYi9GmKSijb?=
 =?us-ascii?Q?JK2yT4rCqTzxeHhM5Qg84S9FDFESsB5t9edG/oOrxY4v3fc/rTNfzSrBgOjU?=
 =?us-ascii?Q?QNkahmrz36U0+wSlUpPS4fAb+tBEw9AcT6Y5dGUm3D5bdQw3C9uLw5UeT13e?=
 =?us-ascii?Q?vmowiQVcn1v1uvYM4m8/krD4jjULt1Ublq2mHy2Zf0UMwhVAbvqaxc94Von3?=
 =?us-ascii?Q?ViIeSMu7hIz0vHM0ShdLJKWRwJuOPQnS338yKCTdmMtThp0C0fUeS9eAC7I4?=
 =?us-ascii?Q?6Gf34+L4yF9ZqXul26sTPOhBh/uKM0xQWNGzetxQ+C1L2mroIjJL3MdCNh69?=
 =?us-ascii?Q?3FMAH9pynP8FNm0E+q0MNKJJjniN+4QckIm7vjCx/7J/iOz51elbVs/PhHBj?=
 =?us-ascii?Q?oYdF4LOgrMcdY1zqLDne4aO6GtVxm353rY7cLcKbSJ5Eeb+rj44J/AUCGcM4?=
 =?us-ascii?Q?y3ke0rkutbNhBqSCZqJEvUu410hoKY9azTavK29wAMlqP9LV419pYzJXu4Np?=
 =?us-ascii?Q?lfuw06OlqL1wr/M6SaZIuMmow9UG8a5KVXw1zXS6AU4pNqvj8itcIO3fUGFm?=
 =?us-ascii?Q?mRXIpOyNXInYRTUvzPbcENMy9BppBpDF9uniwIrzQpQh2pXomolq9L3vkN8/?=
 =?us-ascii?Q?e5M8BoabAt32j61zi1QluxBuDiWaR0zj/4aXVpri90c2TLZWaNc1MJ5FG95i?=
 =?us-ascii?Q?ZpD5J+4Qgw/+i82DThEcTRMWq4xDqEgHkKzH+xho7SwYRyGTHaYXkqaviQvz?=
 =?us-ascii?Q?wUibIAWYcc7YBkAcfQNhcypHzTdc2//nQVRLw0TDZFUqcnqJLZmjj9KBO1cp?=
 =?us-ascii?Q?EaMmUE5RQZW3x5jkxVplMsS7T0eTqgymA9UweRnkDtUwBpYoWr3QHUwTGA3H?=
 =?us-ascii?Q?u3amkLzjaHR0YIT1nxTMLlDDXy/kp76dHss1izIWMzOdHyxhnAL0rs7WhsBp?=
 =?us-ascii?Q?dVbNAu+xy6oHXZSPDPEvJa4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAC5D3079852B842938DE04535C02E56@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e/uPfWXUljVKR7/SyQgocAUjHW6yNe+e0HJ9/UVPjb8Dp1WaF3iiDtYwZNuz9DxmxU3Cy6UHAQ/rxMSvEjxPUJ5HVGtM1OlgHDX92kqGo8oPRrk1GoSESlvo9kM4yJWDJTelexpMiv0hzouldLosWSVv9g2RymeHceDsgmSNnziFdg7L71Uynjh8Z89/Kqj06Hw9+S+zt6eJdcupk34ebUqOXOBGqu68iCfkp8aI8i+ZT4zpmHqe026wK1dE4dI49dBjLt2vVI5gRlaSToWvDzWTMgstVfqk0gl3HV9V2F8F45AFcWGj4bQ/OiZ8YQXeVAQip5ss2z7IDOUSFzNK0Sc3O0DbGd4Ku6c/ghaBIwJPZaK3N9jHsACDsXTYSsGPyQeQyVaMOGiD82XWcGiXiZUQj3mvrNJBgJFtfSCLKTTkUWGLOwtjC7WESW+jui7h1w7S0ZRU04natmy1WRF7rnxi+kA+84wwvpPAf0dNPWo4l9/TcKGKxA51kSoHrjwpPfxR+Jtezd+vNrsPNLGplLmG8J7SyAanFQC6KzY6IrQMgcGYJlIZsY0BG7dZWhblBV8TicFXXH57cDn/qaPdGjkdWaawSSfBTiEgtXj/3QubuiERUyqjiBgXggm9aJXj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddc86db-769f-42c2-4e29-08ddfc3d2194
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 14:09:24.2070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CdnqfrynT7NazzH7po9cb8o2Dwffr7R4xncyVNdXIhZaTh7u/JNfXz/6xYtu7NphoY08ZPw6WT2xhfpc//Rm/3IdH8kEUpZVR6l3W6uAmHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9382

On Sep 22, 2025 / 10:24, John Garry wrote:
> The testing of atomic writes support for stacked devices is limited.
>=20
> We only test scsi_debug and for a limited sets of personalities.
>=20
> Extend to test NVMe and also extend to the following stacked device
> personalities:
> - dm-linear
> - dm-stripe
> - dm-mirror
>=20
> Also add more strict atomic writes limits testing.
>=20
> Based on https://lore.kernel.org/linux-block/20250917114920.142996-1-shin=
ichiro.kawasaki@wdc.com/#t
>=20
> Differences to v1:
> (all based on comments from Shin'ichiro)
> - Rebase on "support testing with multiple devices" series
> - clean up "make check" issues and other coding style issues
> - Relocate some NVMe helpers
> - Add _stacked_atomic_test_requires helper

Thanks for this v2 series. I applied it.

>=20
> John Garry (9):
>   common/rc: add _min()
>   nvme: relocate _nvme_requires and _require_nvme_test_img_size
>   nvme: relocate _require_test_dev_is_nvme

I dropped this patch since it is no longer required by virtue of the other
recent commit [*].

[*] https://github.com/linux-blktests/blktests/commit/ca6de24a9b67d4a738787=
1cb71307d1f6cc9c0e9=
