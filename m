Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271764C63
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 04:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549112; cv=fail; b=KJgx9HkDTyUYkiEn0LRbkr6KWNchhNxEGzF/p5yNP0DaAjn9AKuDeFXqEYM0r9W7351IHG7HcKa4Ro/U9EGIVBq9sAHxWc6ZFdPk6Q45wDDmXLATrkmBhRFEFofXvSdu77/I71Fis6zx3vCuIxLAbZ10RxctffBVRe5S5rlVM/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549112; c=relaxed/simple;
	bh=YadGm+KWJw9YTpUqnqVdEs2YJogep0DabUzqpRDgtWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WCUDp3UXUy/Z+KU5bfXWI1AKqOjK8oa1+UFGy0PJi9Z77i0/PpEvMYU8rG3BGMAyiARpWyr8UqOMIzoSypn789PWHQsM6zpQo+8Oi18oQY1fx38v14osd8AghWr1mRwejnh5dy3CrRgeY70HJOUZM5/ru+0Ak2+0s6rbJ1g01DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TDAl3vLO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xgs41z57; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TDAl3vLO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xgs41z57"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712549111; x=1744085111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YadGm+KWJw9YTpUqnqVdEs2YJogep0DabUzqpRDgtWc=;
  b=TDAl3vLO6k4RsPZLOtpErLnO7+jciIzG2HtLvGQGD1f6wQE6V8cFr7TQ
   aa/aitzCRmvcwdDq1h46vsA7qaW9sxNaiaAgzpnEHVLONJ1GaRHNvyMM9
   zwRTGJBW9p0gV1D8bPaGPfWpT82wSXTAxlZLonruS+a/BWrEuyQIp7nF2
   QsCac7bUHQgrALLbuBJ5Is//KwEocbHgiJQuUCkVrRVJxAG5ruvEYtU8E
   m9DPH1izTYK8vtG7lvzuThJPpA06hnb5NMFLZ5NSQq6362Xj5V9CU4tGP
   cQ7EQ6QQyhN51ya23R499UCI8uXgUDAr/rYHqvs9a2gFXGucjW1dfLNvm
   w==;
X-CSE-ConnectionGUID: TNdhafbqRdqT4VGqAYOrWQ==
X-CSE-MsgGUID: RAwYPNjhRse57tKQdo4hXg==
X-IronPort-AV: E=Sophos;i="6.07,186,1708358400"; 
   d="scan'208";a="13299719"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2024 12:05:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2yiG99WsCx7Y1ihgfq96ye37FvfSiaMqsBl8+fsXTMk4/6qfZ06GOwTpiaARiqGhfJwwZ7gq2CGNAsytNmxAWKaLTKF4WICZ56VMEB+SI8yE5V1w9WwHXGI4dAnVipHWlnAghRIYguQhXl/PoJ3FS/5xdKgLHz4e7wvW1xMQGM5VYgxdllhXfhrOXzUr5oHu8jgXU4RMOAsiZJ2XusstFiqfDB/IzWKSkMzK2ax5E8rdYM+JqUG1EI4Ht9CWSU0S4CBSLiSXnVsZVr665B3vgt9sPCURMXfuHDw0WTIRB5DGnn1i9jXHTkSGvW5WlpSlx19eCjDXnquEttbSzaCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YadGm+KWJw9YTpUqnqVdEs2YJogep0DabUzqpRDgtWc=;
 b=hQj3UOX6FKKdZLgUIinjvOUvDj2fRqzw5s7BkZ3JkOZ6EdzW196u3gvtSbjcrIKhOkUCT5R9CO2bldptTV9/wrEFYvtErsbKN3hMAeulzzPfcg4EsLDI5bBU5H+bnfM3FJlSsCK35qfrEIb1vM/Vz9tSP+5lZMb3ay5JoSKBSMvHvR/dRUSpuZ7SM4kOa6sHJp0CPT8tdMBGh+AmrrkDQC/VKBTqMfE7XPUGtBAqPBJh3AP/St3NBI1DkB91y2xcTO1ZneSo2QqnQiAh9GPPET07GsfV/kl4is0/a5ORwgpYsxGp61Exlbe8WN2yRkpbJn0lwWLUyFJEyqhfQJ5tOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YadGm+KWJw9YTpUqnqVdEs2YJogep0DabUzqpRDgtWc=;
 b=xgs41z57zZRKkf6/XdjMI0n+FM51qAqYbSJ/XItkujqNP0o0INjK5YF31qbd0haSsU7mdQw65INObXUclbfn9wk9ywTkKzybVFZHPixx5M9/iwgwecKy1l+Vq0+FjvSLMRl/XND4nFi0F516bnt5MIBoHqao8Y2FXC0bkw3vg4c=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL0PR04MB6484.namprd04.prod.outlook.com (2603:10b6:208:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 04:05:07 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 04:05:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>
Subject: Re: [PATCH blktests 2/2] nvme/rc: fix shellcheck warning SC2086
Thread-Topic: [PATCH blktests 2/2] nvme/rc: fix shellcheck warning SC2086
Thread-Index: AQHaiJo3D1lUA7tZMUKc1E35E6SU4bFdwqwA
Date: Mon, 8 Apr 2024 04:05:07 +0000
Message-ID: <ypr6ndd2oupjxdulymr4nyumb6vh3ork3ck462wqfgur2kkhiy@lsznhyo6j7ed>
References: <20240407031752.3945715-1-yi.zhang@redhat.com>
In-Reply-To: <20240407031752.3945715-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL0PR04MB6484:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 o0bETURvAuzV7BLPTtc25rGQZF0/P18jQDsVDrjU32i6ezlRIi0iCubDNllxqBkmCEbvlZIILFQar3BoOUkvzorzCl+DiJmBuzUDbVPxoD8t4W9ocxoXgTBW9H4N6M/o0QEHboEtawX+8/Pfb8bQ3urYdCtsTHb/MwgzNwOyXq2+CQlI1HxDrVu8dhj4xyY+K2nRTWsTCYeM5W/wE/M1BXJGdMYOSWxZ7nWKax9gWjo6nCnReHHIA91YjUANnFMjZuQAOGhybgBiSalrDGQxI0LsT2wumLtz/89ZYE+nkJMpHVc9pbKF4J8jP6YYUoUkeMEYAqp/TEcDPYBV918McdKU/qguZhSuD9TyK3PAS8TqIpmLxOs7ZU9Nd3sv2a1J+3f7l7iuPrt80CD7u0vFHvm2rTplnulMluJC42TWk1BfmPsK4+MFHJJQcQcAcBRw8iBcZPtpHAL1x4vV1MN0jkNINKK+vG78Ti1c1EeJOE0PDEjzIfgYNySJyMzVPdt7ghgaTqKvoi8p02jqkpo/bAYYhgNLhdyNNMqGnsZ57qBfR3ku8JL3c7sAoPn1alZt6sMkbXJ2KToAQ+8YSQABOxmJ5VIEi8DXBaljzq1nt/zVRL8hDvAgVAtKo1iFSRZjpR9635nLVikkS529htPIIbWYqV4zIxYIwcQYGdGd7d4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RW/PCoRDD9ycMvVyX24h/c9vm8VXs+Z/1qtF84i2WdMdWXB+7dy11EDU7uRU?=
 =?us-ascii?Q?25IK4HekucppD02ni/BvnOaffPoCeJUV2MDpyeAti4mWVWcM8Ke0iODEmBQx?=
 =?us-ascii?Q?NG2axzidcUn/2Nxc18cWAEPD0c3XCa9aqf5DL/PR80u9egl2aKwr0uVZJgjy?=
 =?us-ascii?Q?13a1VTqXTx89wDD4YueYzWb27ZTCUZJP+AiZhnbFdwsRROiwGUQTRK6OTIiJ?=
 =?us-ascii?Q?H3taahzg0MVu4g4gbaSPdqMHtftgAqD1WEQkOfprnTtK2qjYg0vyeeTab/PA?=
 =?us-ascii?Q?cd0kWXC9e+MEHK9xJ/+qbGFvxD23ILlBLlRnZDRSXUKd6nK06vb6y8Eqot9P?=
 =?us-ascii?Q?rOV02COfZQfkuLubzdH/OUnUaNJ76RwXmBiHpkGmPYyKpMnbimStQiErAUHU?=
 =?us-ascii?Q?3DYVazgAIG+TveZiR0N2YxGwTdCZ68WjTMqgdzwCs1P4hKzNnWACG8HWo9Nz?=
 =?us-ascii?Q?acerZiHuASVpjUopJZS5pw8PafSGvpBSRqSGXfqQZ0ER2Nv0bvcITQ4u6gPu?=
 =?us-ascii?Q?SjwbbjjWPyb8ucAnGjhjLrO07CpmIXshu1wayds4EMp1qeVhiFEbjlq5bv9O?=
 =?us-ascii?Q?eRfhAR6ucg7DuABbq85B+l8+IlM+56l/PgwmDBffAZw43T2uFaahK+HljDBl?=
 =?us-ascii?Q?MCeWHppEYYYJnBhSkoJgHzcmWv5y9SfKq9O/0EGaCQuWt0p99kMZECRQyPqs?=
 =?us-ascii?Q?gjD/P0sejH98kNcNKX435lJa8HK4KqRWoVTHH/EFhvp3M2s6t/U8YgUgmFb0?=
 =?us-ascii?Q?j7IbCgB8v5yfPZGmKo6ZfWRXr38rRlnzFTdLSxhje3nfwoh1KPZs8iBNXXhM?=
 =?us-ascii?Q?VxLqxAOup7zWVMRtDvGxeA/jNpfIi270TM6Yl5VpqX48ZUM5e2QY0qoiigCv?=
 =?us-ascii?Q?7HIBuqrKtzB2PB5j3sp9agaatdylt+WWsRgIPCEaus2l0thkWS7PmjPqjaOQ?=
 =?us-ascii?Q?w4m7bM8ADBjxwHnnNllblkhd1x0Lxj8xVQ1w+25BQ0STvnsf6an0YU5TgKos?=
 =?us-ascii?Q?GyPpRW/tb/O5vLliR0SdQ1gV3/mYkR7BQGVEGCkqNYDHiGkLQa0LZgGB5bDP?=
 =?us-ascii?Q?ptmdasvWcdZJyKmWoL1GcaXYe53oGGhuX7QF3VlwtwK3eQEEzBsfaNaA8W8K?=
 =?us-ascii?Q?jlSi+zlQt4c3u0WVeHwBxRrII+eVkfTW9T6je8wcPdBPLLsHEqnsusg4pmvU?=
 =?us-ascii?Q?/gJFTuUrEkmIhO2FWHaMwNPv9ZIiRXkqNguhBkhuwe2XH7Zi4H7w2OE5RQ6d?=
 =?us-ascii?Q?z2wXPTVTemRhlzpP5NCzCIPKuFv9iTUVXtb1KYLoCE+Hj+dxbwBG2byDOCMI?=
 =?us-ascii?Q?3NUvTttm995BG8xM+UCT0eGirTQtXBcVYaflRTU9fkSs6F4GG5gMuGsdpkVv?=
 =?us-ascii?Q?ONlIHG4+sbIfpbL1Afi/KSSy84J5fNQ80wnsqhPnNbiYWIoSpgHZc4nBi9So?=
 =?us-ascii?Q?TRbgivkfzDAqqfULgc9H0xdZCABK5XKVVR0Xw8u84adZI+dfNq9QNL7Wgv2z?=
 =?us-ascii?Q?CuCErp1oar/Dh8boSUl6iLe+lAnpQr/sZTRztr7G3u2A5xKvjdHJ2JgEMoFw?=
 =?us-ascii?Q?TCQFH9NDN45QGyXL3LtyGYGsK2IgnPhxP7xCa9Yoba6lbYvNtyUiLiupnojb?=
 =?us-ascii?Q?+HpRh5Xx86G/NBU7dVehcyM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36DE78CE54AE9D4CA9A97F8CF649DC1C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dkBxtxk1sku0PFRnxm0fZmZa42+Y30TilLh6qrzJwF8SomC+b5pjxMh5l9kdWcJOfMnElrWKTj4hHjJtdwFiXlSBLHS2P1MHohzpNTGK0x+JBGYnRQskT17XCxSE0KguvvTMXonoCByQLs8UIvQLag8WYr4KazDJ/Z05VS5uyXvOYgOyl5SezQxUBiAs5RfADZNy/O8JsqkQb6SphplLAtHdUXtb8kHFBSDNeQvXyQB8W2lPfPtCp/dC17gVPEKuXm2TaDp4uTq8LdSWpwO++tKOniYJ/iqegEgWxZ1P118dMCUfbUYG5s/HZ9kBkHUTTQdhK389vJpXiVlKXnK5eYAIGUhs1uTwdJUnTaOoy3f6Qu7inixfOzMO5m9VsKeT4oNYRJxQwXEFvQ25QiC7XXUDRrMyN/mT9JHNf/9EcLfU4wFyzkEUVQINJbK8xqTgDb1baXUhgEmDLmZcoI1wWAKf8/MB5NbdMKFm9PlvFEkE7xe5x6B0r7PS2TQXa/J+nwq8QM9OPxN06zoTfvTb+QN3v5kuSB9gzewHx+VDPzgpogV1pkCr4SIA1zcaSGi07zgZYXqFGEFYc0/eFbDLvrxs+yfU9BAiiPcUyKhSgRPD0Tg7hsuw/xsPo22vkMRc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d053224c-0e4d-449a-fa8d-08dc578113c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 04:05:07.3366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14sNpSAOa5ooqnpST+LyCduHXjUApt0vVt84kMCkwNFru/gJmXE+qeprh8LWiLNUSsyHfQTAIALkD1+rh+KQn2/uD3joKDvPGVvbmERvmus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6484

On Apr 07, 2024 / 11:17, Yi Zhang wrote:
> tests/nvme/rc:1056:7: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
> tests/nvme/rc:1057:7: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
>=20
> Fixes: 369d310 ("nvme: Add passthru error logging tests to nvme/039")
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Thanks, applied.

Of note is that the warnings are observed with ShellCheck version 0.8.0, bu=
t not
observed with ShellCheck version 0.9.0 and 0.10.0. I added this note to the
commit message.=
