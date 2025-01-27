Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454B1FC101
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968537; cv=fail; b=nHp5HnJ1AeDxnViF2FhgGUytxnc6bm+NgzkNZKn11AdKE/288AvZVvBkfH5gPkvn9R6xQwVZnpnnnwkEvJuMkZFIqnQPnzsKUxf7GtCyn/WGViIIpczj6EmNNliatYgIPzl7+7X0DlIUm3QHHNQvVYtkWTgUBZB5I4Hlc6ViaZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968537; c=relaxed/simple;
	bh=US58JFwnE7fsijbwbKy/RIxEoJlbA7AIst7K/Z0j3s8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nO72/cqzWkAvUy4uV84MpQrfp+5AsdzqyeHsi989U/pJIDEUkU8XlyzifvSV300CeCeUODIhPghm9X1n/s2zzNrV/jMEUK/wskmOf2sEMUNZ6nhiAXTSqCLp+A7Zxx65ceFxuTDRnXsbEGrXrqolam8KvWMuLfFcJ8XRTo6xtms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RwkOd0XK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cS9oMG9x; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RwkOd0XK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cS9oMG9x"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737968535; x=1769504535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=US58JFwnE7fsijbwbKy/RIxEoJlbA7AIst7K/Z0j3s8=;
  b=RwkOd0XKo0Uz8hUpRu4w8E3esjz5x8Cq6ERUbn8MUm/4f+carFglXfew
   hAD+G/pFr1OnvvSC8p3tdQ/qzFxFdMhSodW3SMEqUvnTzh+IyZv6x9mDr
   oN5XvFR0uqaXNdsGdGKx80zwok3Gj1ZEcTJJst7fkICrMAQToatBYla/n
   AOQA2l7e42G7y67/Uvh9l3z8nckIvxthWTneIvN4B6/r7Rj45aWKX4nJ2
   5fgWbNFOntF2MSjP4o0P6a+ihknuYpoDjZBAHu1v4DvxALgdmsJhKElzC
   6jp/oXuMyap8lZ+bdj/gL15mDcSm2JqqGTu6ApcpzAPpkZnVFR6PZ9444
   g==;
X-CSE-ConnectionGUID: JLjRux/eQqadV0H25mevfg==
X-CSE-MsgGUID: fVFzklj3QvucRzt70X3UPg==
X-IronPort-AV: E=Sophos;i="6.13,237,1732550400"; 
   d="scan'208";a="36273802"
Received: from mail-westusazlp17012038.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.38])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2025 17:02:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWVR4p+jXubIvHN7LwVWV1ifWa4/eX25M+agVP9ZyH/VrhhL1pDJxcgWCueMa6S4z+Rb7p3J+rlY9Gwwnuxj/4nHMvfGoHU2HJh7zRNfER+IwkSBfaRv0uHEZ0x79Ugno7KxzlwOjfSV1D0aNUCLP3Uxt5INkVWw865sukoMt8ckhJWthD2aoJ6d1q4ZFf67WxB4LrGdkSMK8GE00JgY2AwVWIqDdFa01UFvO/kogDQUpli1j7wkyDZ91esh3sqhvc1GBwVE4Vzfy0ggwXgt+TzIG+oRDfiRytSLhTYOyclYYyU8wZtcaGmyDvefXgP4WPa3v4pGVUWFRq0q3t3KhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhLYiv4mJ24W2MuJxJlaqcaM8vjiaAkQr9U/KZcFrBU=;
 b=NDUjyppvhcquuJ8ZxYOZgi5mDsWev/NP4WeOcl2URRDDdv4HwF7f2RjpkEIKGQgvJTLaEFvT9dOjpeNduPcvGQwws7dD4gFUZ5kaQtuRrkWl02sqTdlSrEs/K63kM8sOJ4GmlXLKi4ddPLfAIjkVdRteuHGijjsX3HpSsS90ntt/MZ1uTyfG/8po0zBTMOGbnKKaqhWzWIWjz9/ofgrUN9vrpmpjIMs0AlYlHgeNFECcrMOizC+7WmfES8mETWsp0kPkPci4Ifoc9U7KKAcLpm7XyEQEYYIL65xd8ISTBYTsxkmUiVQx5yhtEUn9ivthpAThGzFtKvUuXj8fLua5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhLYiv4mJ24W2MuJxJlaqcaM8vjiaAkQr9U/KZcFrBU=;
 b=cS9oMG9xysErkOCwkz6j46SiFBT3YzaBQp/3R9uMm6yeOTSzFPNDg91mqMIP2EVPcBKoxVKn55oHdo0+JH869ZPdm5Qa7hv/s7tSZQfyieY0yGk+AxxqvHTuGFv+ua8UTv/BqiuvfyOfIWAs6Lm1ydlwriIezOKgZColG03N53c=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DS0PR04MB9319.namprd04.prod.outlook.com (2603:10b6:8:1f4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.22; Mon, 27 Jan 2025 09:02:05 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%6]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 09:02:05 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Martin Wilck <martin.wilck@suse.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH blktests] nvme/053: do not use awk
Thread-Topic: [PATCH blktests] nvme/053: do not use awk
Thread-Index: AQHbZ+bIzSacB9CG30Kje2ajmDrs2LMqZHcA
Date: Mon, 27 Jan 2025 09:02:05 +0000
Message-ID: <6fk6j7mxi2xyren2sirvuqrwaj4vrdbb3guihnfzhi7bo4oxwo@yajiumpcxooz>
References: <20250116071754.1161787-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250116071754.1161787-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DS0PR04MB9319:EE_
x-ms-office365-filtering-correlation-id: 94bc5c21-2d6a-4f4a-9e41-08dd3eb145a9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?L6mzg1eEQEV++Xm7LiV5MHIbKA0tbjOOIvgvpch9/KzhfJMp82YtnFvBI8sB?=
 =?us-ascii?Q?9E03+6L3KywIOiBzQZIOndrF/3bcvsH3ne++1ENoObUZpJZtG7CzknWrVRp3?=
 =?us-ascii?Q?19R2Tya3jwmTayNe9AH5OU/6cwDQGQv2JpOcRxITfDM/1tzv17iajf6X5FAH?=
 =?us-ascii?Q?0Rn5evd+Xax6UCxQtZArbG8X0UQTK9J582JloO4Hmbw5HY/f6Hk2H/ETVLa4?=
 =?us-ascii?Q?BesraEpPflhBZO5jci7xlv0ZLt0geSoV4jYd5H2UbCecFphhouArDftgRwoU?=
 =?us-ascii?Q?hNOgnIqv9pIgRC2MvKaXE5X/cDft9hRTTfkaBrVL8GVl+lbh0eZ0CNmVOMVj?=
 =?us-ascii?Q?4sMBKLDSZRk/1u04DK6n0hvWxifrGEmsWnzBHg5xFInX1vdIfrOIRyhUdUB1?=
 =?us-ascii?Q?7DospBZUFaPZ7XQF388vm4DvlNv8V1jMAr7Rq5hN0yBztAmtoFo7ScfP4fAk?=
 =?us-ascii?Q?MqBp9Qx6bd5ytj3OHjiYZpvBERvtaP4UuW5prU7uHAmwGL7XcpT+f3vCFof2?=
 =?us-ascii?Q?1eT9taAbfz9IYHDswMMeEs9ne9c9CR6VS1boYsNq8RJiwpaBLkEUuJMuxVrE?=
 =?us-ascii?Q?QXvzpQPP9txxdbFgfm2VPFDmLyAuzuew4AtYL/4t83NIYxpdox8ebw7MpBV7?=
 =?us-ascii?Q?7DPI+i9CHyvI1dXswp0taW+PD5ukIjUIuqdtPc7OnIPLb0H45v+Tu2eGBdRd?=
 =?us-ascii?Q?UkduaaGjYm4/iM5RvWCSeyRlLRfeYlYz2F7I8fAQh7TsNKa9eJm6yCRsXVmg?=
 =?us-ascii?Q?1t7QFowOGl/WKLrENEMxW3AVUlJobm0hezNtRzNqrxB01LTC0srEulYlSI4G?=
 =?us-ascii?Q?+Quxqk2b5muM066p+0fRQ53j8c3cFX5sd5dNvH4jWv/DLKkgL9cBFDmgBC5u?=
 =?us-ascii?Q?Dx3sKWhpz6D7WuGTU7gdhiePtHazqoL8DovrPU742qpPqPVNFKDTE1Mf5wHR?=
 =?us-ascii?Q?4F+S7CXUmTLpIOuwaKswpuC1w/PT4AggX741jKFYL1I20ZQg3y2gDbv8Ry/3?=
 =?us-ascii?Q?OvAj0J7NKhEP57uMFk7b+wrPA0COykOoNJx6wfPv8Se4e2UHNs5cS67lpBPy?=
 =?us-ascii?Q?uxCSmwFzwOnQZdc7eWrulSH1LFQ13g18HVp9uXBIelI62Y6QHlfV0jcn0OS2?=
 =?us-ascii?Q?oL502Dqp9N3MhFQ1dKV04Bct0cbNft+8xaF7/SBzLY5GlVqVcw/seG0W145F?=
 =?us-ascii?Q?tDgCgtEXEluLSwAU7hl3S3uPhhDpx5jgaNI0ky6GM2qlU/t8jZAdWXJMlVlM?=
 =?us-ascii?Q?mNUmwdwwe70MkzjZIRnv6Eh183T+SOHZKvAUGbZRrB+9tRU+y4SKbAPRtdPJ?=
 =?us-ascii?Q?h/43543PjYl+qQgE+Wk+6gxAm7sl2eTFdc/k9280zBMpiH/Wq+6IHlr83Kfa?=
 =?us-ascii?Q?EO0JgnkTcPxa12VBXX9UWG7yEhN/ByggIEpdzZTidt0i50OO3w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YepN4qI0YreNwpWODDAUor7cuVO/+Tzig0c4eGUkspg83pkvHKBLrAK6QEdq?=
 =?us-ascii?Q?snb4ub4c7Dmdghk07nfkJJF9us7tMG+LworSybNig4JksLMCCNnx1jbupKQK?=
 =?us-ascii?Q?pH9n96ZTBZTnloBiJjHHCBd5TvaNHnoyWj7oFKwRH6fxPd8WnxiijAXUpnC7?=
 =?us-ascii?Q?++Htq3wzpGK7+aFxdj6mYMsypNpK8anEwW/1TwS3pMiAWjEWfpqofLMG/Mjd?=
 =?us-ascii?Q?5DuH0K7s/ydiG7bqCmeB19IWgtrBHKffdcGIr6Qq21JhvvOSbK6ChSCURcbN?=
 =?us-ascii?Q?E0OZvaRP+OuQ0Eo3GiN2dEE42PQgsSim5OSDGi1425AsnAZXopdi13P3XPC/?=
 =?us-ascii?Q?HH9Gtt0b3ZeeUAdIFzH6a1QZS6DLqr/xtIFlbGOelRy3BGFHQ4tav1s464qX?=
 =?us-ascii?Q?T/7NZQoUWEBN9NpcT2jYaWfKqmwB0RNFto/1mpRMZV5qeCVuGPejL1T8BB5V?=
 =?us-ascii?Q?Xyg0Xu4ykJoRFk5OgQdVuolv5yFzAmA6I7d9vASLU57ja5TafwWT9HEJ/hco?=
 =?us-ascii?Q?7jLmqe8K+GPD4NJRlMwl+52bBMiJramWpY9XCjrkwSKFu9yxDkAdAB1H2RNP?=
 =?us-ascii?Q?3CJgShgH2PZrmP618lokY2xA8pdYCxMxdypnH0MqVBoXAyHh4GPeHLvsorbz?=
 =?us-ascii?Q?mCfVrBPgMot3W6I4UoRFzoijED6pBxdBXLK9rYpANF5/Z27TzlxPTRH2qcs0?=
 =?us-ascii?Q?6498FnDhnV1MZfqcEdPPvmJGEGij2E0RxIFYG94/4LTX465nv9TGQdlPPkMD?=
 =?us-ascii?Q?tG0oLQkEGAYbhkeNci71xL2U2/3fz5TNgcJU5nxKobm7HaSw8CNSJujq+aRd?=
 =?us-ascii?Q?XqkEFkGxnuXNd4ZbimDXaw7VXd1rZ0Kvbw//5bqPvK2S0Vsu9mpCda9MAweq?=
 =?us-ascii?Q?+3C6uDAay8M9qJ4V3Rw8OwqeARIZrvZMemIjGlyc8NwrO9sAZJyYn/gUpvwF?=
 =?us-ascii?Q?KgbsMww+//pHEp4OEhb1vPHSMuj8pkYVqRShiuKjaZvwMhLwyYBercL0Xln4?=
 =?us-ascii?Q?5uUUmm7P9I0GogAQO3FmVaQnQlG6VVztQAmTR++VJqp/DW9lxeSDB8FcxW5m?=
 =?us-ascii?Q?Il2FlyKVDJG4sqhZ1JoEYotYaXggWj8maBIcA6obzP0CLg4bxyPgaYAYOv0R?=
 =?us-ascii?Q?0Q/JAkc7h/iyQSEBOnZqCv8lbA1ry8s0w6aev3JsnlUggxj0HBc8BQK9s7fO?=
 =?us-ascii?Q?s/+uWIaUINa1vU7REdDK1uVkUoSMeT/ClyNGB/Hnw1NKMl0kXU8nDLtkbMeh?=
 =?us-ascii?Q?3j2+Yd5+gsTubzcIM378D+nNvvNfO3NJO+hkq/aYVuEK5K/GFRiZn3zzqYP+?=
 =?us-ascii?Q?Zc8KXfyN7Dgc1GU2bYIP2/imdKm34K0b4uuu9eV1U3OimbjRMO0o2ccYHpef?=
 =?us-ascii?Q?GKhlx1iutI3Ay+fTMJ6MD3Sqj/yJ0Ak8UL+yvZOik8PTrieY+DzHD4UhFbmy?=
 =?us-ascii?Q?JOb1h6hgClfiyXA0nciROcPhhqvzrav+PSEHdl1XBThm1y9JeQK3maOFM17p?=
 =?us-ascii?Q?AiMJ78g4BtYJhFb39ktCvHJcCiWMchRlPw+pWbzCKagWSD9DZmHPm1X761tS?=
 =?us-ascii?Q?zcqDNgLw0B6o7p0Aup4xQDV8yHQ2j0lhPRtKFBtT6vXPPGDPa+AgCj0IHgDe?=
 =?us-ascii?Q?NHsDHZjMYXIMNqBZkmj9I7s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9A8E487A726C349A8F119AEE3BA20DE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kmKOzHqSU7kN7xskUpDCye2Xkxzq0h1oM2CUEKQ6Sc1kHcUnR2YyXkFp6wbp8dfhbm1kx2Thn/JVzeT5PWPRN82eoF6tS6qPftRaG7sZEsCBH9N/9T1guxAJ/nO6TrLOKwtlSSIIxyS2n7rSw1Qonnc0daaSnzn/rqOhJlKDWG0OLyQD2c1T7Y/F1OJ5TTlJDBljbnrBG5uZi/uHn3vWZ0tVNzIbGA7ftbBsPj7jXP+XFJEYPz5J3SBCPSf+w2hPRbeg8xgjC65K3bs8sNAGusbSzGy2rauHVmZnWOUKyJqNh2tWC/gR9Ec6KPWBwC/4yRyoxftNBThHLnmI6Yoi8lfVc3T949LgpxpayAuddNtLmXw0XpCScWrxYKNBVEQ/+JRY/A4e0De85Qw0FNsmMtC8EvenU6LSemSFKf74BrAXCeBpsGLLV2xeBfcRFdq0zVL9tIGaBKGM061OtM3sxGa6v/FqkxL1NxcPTihSKQJuhi0K6SU5MvSA1Z48IOlFrDleiOUnUkS3GblAT2MrLXnMKfHVzdPNO+sq7vPy04kOvFGG2ZGmGpUIu0Smsgb1tHx7R49lzTNIh1FfSDI45Dk1lyQQ7m71QvHK1qiorfHkRgTf5XfpRHyIPoDw9IKG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bc5c21-2d6a-4f4a-9e41-08dd3eb145a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 09:02:05.5265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLDlwr2KyITNRxZyWB//HFRKUlKQPQkSYJV6VNDUeawRXQZtScps0/ZnjzDwA4lOZt2iX8PTuwz2kzZhdajXQ33e9YCyvVOlupCRe0Ed3ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9319

On Jan 16, 2025 / 16:17, Shin'ichiro Kawasaki wrote:
> Luis observed that the test case nvme/053 fails in his environment [1]
> due to the following awk error message:
>=20
>  awk: ...rescan.awk:2: warning: The time extension is obsolete.
>  Use the timex extension from gawkextlib
>=20
> To avoid the failure and reduce dependencies, do not use awk in the test
> case. Instead, introduce the bash function get_sleep_time() to calculate
> the sleep time. Also implement the controller rescan loop in bash,
> following Martin's original patch [2].
>=20
> [1] https://lore.kernel.org/linux-block/20241218111340.3912034-1-mcgrof@k=
ernel.org/
> [2] https://lore.kernel.org/linux-nvme/20240822193814.106111-3-mwilck@sus=
e.com/
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I applied this patch.=
