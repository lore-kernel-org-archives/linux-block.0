Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C791B4F1C
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732008902; cv=fail; b=Ge9aXaYcUO6vbXYspgTb6yP3fLULgtuqAYu/Oyksa3Ie57xDwwbahrmMiRPXF+SbLPgo15eUMx5KyaPShoQaoV3xjNEGaDMrnwLa1Uf2lE/Ve1qNWQvH7tTsLlB7FyLa8HWZeC+DGHcV+OQE4Gsa1gqfpaAdBY2DFuK+2DyHV2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732008902; c=relaxed/simple;
	bh=e1iODOkzIX7xc8Yk++1gsqy/KDtSjCzScLd70lXIzeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TZnt5n0/7IjTjfUxlvpjHgp5rVixsEcQzkH7a+DqO8AFKC19HvCCSFwRJoQCbVOtoEhZeElrESFPr0bOv3Zs2hDHujIUlXYW42AUTgZhhPPsVm+V3WSsE00kmH76koWBC6yIwaAU9DmDUVVLjuKLnyZVG8XzksnVGS/3RJXYCzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eyzVVw29; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=h2+8IYbw; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eyzVVw29";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="h2+8IYbw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732008900; x=1763544900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e1iODOkzIX7xc8Yk++1gsqy/KDtSjCzScLd70lXIzeI=;
  b=eyzVVw29uJundja97wJNlMwUsUIcqscpb90TZUU0E1ovfxw4h2uh77+N
   uaJGvEl5AtuwYY+1V5MiA2YSL03ElMDBnZpit6LRE8q2AD2b9Ztgfls+C
   PAuEkl08ZftU+jJlj0fvW4XqcMsdEW5OBFvrvN2LWYTWoODNl3cL1dL1Y
   uBhe1ZKCF1KDb01G5Mi/ElXl6jPambqXyTUw1UOzgu8qznCZypoujbqqj
   bpFwlgLUOVIoiw98pYobCvxgZPyaZH+PGedmroutysZG9q5+N41TFVlcr
   9964O2Nt1qlLFEj4A5THt13sSq0WtO4t65pN+YzYcTLiLCmBjp+EuI9W0
   g==;
X-CSE-ConnectionGUID: zHgKZ23KSPGiB5m6504j8w==
X-CSE-MsgGUID: LqkropUTSsaS47bE2Y88ew==
X-IronPort-AV: E=Sophos;i="6.12,165,1728921600"; 
   d="scan'208";a="32829254"
Received: from mail-northcentralusazlp17012052.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.52])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2024 17:34:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEhDSmngpa2tOvKRlI41qXVprrf/YIJg8LlsTuCqZ4TzsyVr9x192XAU2EjtCFmlfHtKBqOcLyh0xtYrV7eFad4x4h1M+zl8g4gQh8wHcgWX/S2vyh3eqcCVNetAVe2FEsaS5kTMFLPZMBA0CkepwunbwjfRmwYHELFC5RhqpiZmcvRWhRHidqlMpoyu6LCxOO4rGVO+Mkq6VKq4AEFU+igYu7lmTuV0YZkO99aVRK1e5KZ56I93fWuZwo8l78GhYOv3DWhvvZBJsa7VV4HSMsmNT/lfrz/EtjVN9XrQozq4nKwVaaCwG87svYdA4/KGHNfu7wt/pW2wkRd/XxHBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1yx6aIEdI4MlpZi9M2BAmIieEyyKXTlZ4/LLTgxk9Y=;
 b=yQ57OR6C/cs4yuQ6dj8lX8HL0WQ6aO7nA5kk+9M+Wzh5gzxfz5JWr313Tsyk1fZfBxo8lWRoXETn/iU8Dz3oBiNjhJKMnEBT4s4PyMcWlYLcNo17pBYPyV3oK8ezFUuI93D/pw8owxC8MWmCJ3Q3tTajYgUKsE1KDGDKQ+wO20YI6dh6Itg131zgy6kBItFjG76Dl8EpA1up2x//zMf/Vx3WV8pbBY2poD9RnnTRb8SV6uMLa4CBZH/3QW07ywIcTbIiV/NUtfD6mO9oorGqwaXICriHF+arPPKxHxVdxh+7e4ooX/UtceGOns00TIDSjiAWYs/OGAu66kiW1WSH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1yx6aIEdI4MlpZi9M2BAmIieEyyKXTlZ4/LLTgxk9Y=;
 b=h2+8IYbw1vsk0LrXPxoNs245qfqaDiwGPGWamxx4UMfh3nkSuev3hXn0ZieaUCbwn8yjc3cYKcKxB1h6AZG0ABdEWarSLvhFXs1rCWkPts8swpqzMhlkstJqUc0RZJSNrpGI4w4swhM4rr8hyDWKHKeHp4uiRZqvEn4lZdHJZTQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DS0PR04MB9413.namprd04.prod.outlook.com (2603:10b6:8:1fe::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.21; Tue, 19 Nov 2024 09:34:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 09:34:56 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
CC: "kanie@linux.alibaba.com" <kanie@linux.alibaba.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH blktest V2] nvme: test nvmet-wq sysfs interface
Thread-Topic: [PATCH blktest V2] nvme: test nvmet-wq sysfs interface
Thread-Index: AQHbNKJQUxvMgQFJ0EmWuDcrmsrGa7K+Y1CA
Date: Tue, 19 Nov 2024 09:34:56 +0000
Message-ID: <bwta4aoprzumsl3evig5yhtx5szzvkjbzauqc44bll5sk22wod@zj2354ed4pjy>
References: <20241112012904.5182-1-kch@nvidia.com>
In-Reply-To: <20241112012904.5182-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DS0PR04MB9413:EE_
x-ms-office365-filtering-correlation-id: 513e973b-ac91-4d36-1e4d-08dd087d6dd9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9tR7CIR6miwOftl2Q7ulDnYXWrSrXY80IeB5Z2+HwNtQ8j9vojE+DvM6EUDg?=
 =?us-ascii?Q?G0DhJ+NmK4lGpbghiA7S406DibnzLmBoeCGOfksvrAW6t0x+dNelRsqQh2Ge?=
 =?us-ascii?Q?QsY+UC8fGlXTXw4XKLNewMseYqP02NSaULAdumzClOibzmEIdzo4C8LO2kvI?=
 =?us-ascii?Q?L3ExyP0npHDbvWmWZNMYd6wMiU8E/OvzadxBisnsEua8WeCJCduklloaOTaj?=
 =?us-ascii?Q?wplO9xvswhp56xbiY3iVnWZ2RGQ4hYrLK8ceL4OFGrzmqorQQrj0p/b8AajG?=
 =?us-ascii?Q?xiIcbS0CoIheVKWoTdpeeJdjzC4nmtDmPKnpHeBg/IK87HzJjD1oJLVSC/1R?=
 =?us-ascii?Q?O4dJeO+tzFwHEE+/eztXSAgjWQJBZLWwggjlJIMXOKbw/CeeGHIYgVHtSSz+?=
 =?us-ascii?Q?/4UnBiwd5uCVDiler95bIe+YFkbGIrLp4yiIQ0psoC4bI8v7av3feTIrvlsM?=
 =?us-ascii?Q?u4WnoZZA4deN3aimHCOQ1UIlqjPTJAxay32xATHzBFMbx8R2ABsQLPZOyCa/?=
 =?us-ascii?Q?YK1Ntj0O0ehDvEnUFWWjiE9VrVOqq8ketO/BfzT+HN23G4J0cmvEkN5OQLeT?=
 =?us-ascii?Q?dXB7n3xex5QjxTr9NPaOqHw9eh1kN3tU5yGWR5/eyNxi6fasir6T3+F01Gix?=
 =?us-ascii?Q?+qaTGe3g2XLSyuDzBTBOnm8eKCLinx6CBrWdsuRgxjdCXnh7INdUcNcG1Eiz?=
 =?us-ascii?Q?fBkd7m+TtarqyldNHSOpyq1iqLa+8L+vFyIp4mYn5gNaMqdtf4VsfyfBH3sR?=
 =?us-ascii?Q?VOUrRuN8HgWvTlAON9OOHd3yP4WmIITvlxdxDVDJ2WiytfM8BpS4G1Qkoq8t?=
 =?us-ascii?Q?88nFCnDSlZYjF+jd8+BEvty/yNS8oIUZwgX6s2bJp/oQpxssrK0NxZrJ2K0T?=
 =?us-ascii?Q?tM7jqXRrf9M9eSHgMKhxQ7gxvupowH89+vIWr3jzAMR8ixW0F8mBwU+ZkCiW?=
 =?us-ascii?Q?XO0KQ2ngW0IAGkq0dhFjRUqWd62UWjEL902AeouO+FfjakjjyNOL/rfOda0I?=
 =?us-ascii?Q?TKr3GRwjUCnkRi6nITLCaVr9E/m7Fi4aeBK5MFT68GphMT21S2DYy+XAVYSr?=
 =?us-ascii?Q?JTxL2nuOhQ7gfejRzRg5ek8K4GzjHhIPL0iaG0vTjCOtPl1BUwPLpwvH1eej?=
 =?us-ascii?Q?t5A3Q98vGJ3mAH0Ock2248mTSE35iQSuc9k8BVqITG0zfB8sCaKFYbFuIdI+?=
 =?us-ascii?Q?NH7h5VNMVf9yBZFtB1RmrvYsTrlUwDePrceEO5jd40lqnSmsfYBREELnT8Wy?=
 =?us-ascii?Q?OTvXkEPMb3NPXJf8gsFyWvdATtFPXL7A5mRdsdYzmHatlYEEfh6U1Z4Zmx05?=
 =?us-ascii?Q?Qm97glMPhcPX8eEvnErmFXL4ACCpsVO1b9yh82+SKrDpfTyfw787bkOWajF1?=
 =?us-ascii?Q?cQ47nHc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G62umV8qIHN1VIDwV84keu8498XMkP8OmvQ99nWP9xv/QK7q6KImgjXbvhB3?=
 =?us-ascii?Q?rv97AXCHI/SxDPi6D3SB7VcQhsOAYE86lterbRFeDAgdsUDhYf9gYEWrJeoX?=
 =?us-ascii?Q?mXaUr/D1/rwTGIoaV3y0UF2xdB845BXLvH/Otcaa6mgX1kdqg/IT7EVBiVGg?=
 =?us-ascii?Q?UUlfzKcsa+hoCOMOUnoLnCrkJhtwVPhFx7xvmvrn3FpY5qPiHqzbOH9udk5W?=
 =?us-ascii?Q?yRtP1RXWuBETEPAqN7Lhdmw6CmQvJV/jimJj3FQQVP065x9P6rdj7OLhhBjB?=
 =?us-ascii?Q?7tJ2Np1o0S9MfB2SMt1ZC1619byPClR7RFClChNRNlCuL4jdw49TbeOBNCMI?=
 =?us-ascii?Q?xBM9DO586RmSOv+r4vDI4jT8BFD31frENqzQwtDe/nXrw+TdincAC4jroq8G?=
 =?us-ascii?Q?XUu32bI2cekA8wN8xhCCjmwcO8P6BgdYTcjdOF5hcrq88H1lxAYcv2nmpS9k?=
 =?us-ascii?Q?tl5lDIrxj2ro+zSbQWe9sWKRAAwWwCjGOSUV5ogaYN/dbnsQYEgI3ITlPbLo?=
 =?us-ascii?Q?BinGgc8Tp7gWR3NelalzolJDPIaQgK10N1gXZ57ZocXoOAGktPbOYmduy0cI?=
 =?us-ascii?Q?VljtVfOyGD3yRUxuJLr7iDy63KA5STpYk72QNb4AKb6arbOUuzSGoC/rnqt9?=
 =?us-ascii?Q?BG3Gd2Kqd99JIITJUMdhfIQUAe2r3Z554df2TV3ygHi+1rKlP/B9VJU7kDc3?=
 =?us-ascii?Q?jb1hDM1UC5Duu5U+jZonXaSHfDJar3qjEo8IhTk664Ozol5D+TBlBp24zkWU?=
 =?us-ascii?Q?00oQAPl5rV1KN5vH9at/EHiuODUH59dVarlu0mC0baK3S2bhygx2pKxQxnaH?=
 =?us-ascii?Q?bXucftu8WCwIjIPfSIxD3pr+/b+OBtA4s5Wa8KLhx4trf4gN0LighgGRucR4?=
 =?us-ascii?Q?+gxTg3MS+OmYViV0u2jgqXZT0ibmSvMg89nJ972rILy1fUXXW65hpjtRnJNK?=
 =?us-ascii?Q?EALBWd5oA/+XWQSouQI7u9/ChlX4+EUwpcMuvk7G1KqzCoQ3w517jGiBZ8+s?=
 =?us-ascii?Q?y8FPQayfYkOWi8/V8Z34KPWxky9h/7EUEGJFaKmC/cJRkSvdSpt434vh60Mq?=
 =?us-ascii?Q?KD9dxOQx6+BZZ5cup1ZQn+te6UVIKUYJru106gIhsQmQtZedbdSf5Otve7ZW?=
 =?us-ascii?Q?1XK/ghKA5lblGt3S6nGqDNXiVwh3TbslmQF+9ay187wzIS9U5xYAildoGZfU?=
 =?us-ascii?Q?8b/r3HF0RYXZQkeLUdDU3FrUykP8jBSo0LzIPPCaLngdDogdSyuGWa78moMq?=
 =?us-ascii?Q?TurwL3y6bZzPIFYeTz/4P6oKLxv3JciObb62si7fd7laxme+KhLA/1U5kQgg?=
 =?us-ascii?Q?K60w5alxtRjgoNbdbPjtUA7r93GskScSPgAtPmM76ktXhGKOgXfuVySFkOw3?=
 =?us-ascii?Q?4UmTXNhfH232k5AC1lgUJLCjw+mcW21UBrDFis0hbayTsb1CLpsaHHsiGMgX?=
 =?us-ascii?Q?b2i0R1/w8orPeX3L4ThdPbQA3APw8jhp5TazFQsuKP2v6+ZwXfdL96tiuFJz?=
 =?us-ascii?Q?q2yBf8bJ8y1dmEUmxA0kY6m9Z0ymuEkfpIvfisVzKc1Ldg2KTh33jDtT8HQK?=
 =?us-ascii?Q?PPPcxlURaHIaAQc6NtObKV9TIHSebDPJr9o7wm9NMNdq9s2p4OETOez9QzIs?=
 =?us-ascii?Q?DHYbDCRF9OVj7S6FcqttX+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18901D8E78729B40BA27B8CF1D6C630C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uCqzGta4Z/RED1Y9rFvKaKb8RzCvsKXY71pbcVbGS5ceSmnn7xhYvmX6YRSTjmEfEZJTM1o/vKaKQ6KdXC5i7mjcCUSQ7Ml4Xr+cbGLGJhBHFRfF8O2Zt2qJgT2PVPTcXh1jX5ighHZ70OzZ0CdB+FB6IN+xR+Keh5DyCvM+eQwJgbQeBXGOuNcmIUCGdaCN1v9+ceG6QDUSKBudM4HzG25h0sCeCP6oYePPV6r7jtAI8KIVSeKAe0tTOcS1+9BJDl8PyVHrpXx8pTUWwM82ezSiqoOdK0ZzsDBaVm0pYV71qSXib0ngMehWQr8FI/dtOVVP7yE2YO5QyV2aDHeKl8ZpzIcUGt+JcTY8lR4qe/duGI9pJSpZ26aYhDCqRJ9swB8D+P5WeWaXlKp1hxeDZN3SHLdgH0jo4C+Wp+UJKbO+Xc2TroBWNlhCHaE7oPErPcQtH3pumGwSRxPNGzmCHnIGhG+JyXZEVJhfVsR37Y8LVQ3Gc6BhmVF+FbLnQyM8QqalnVy7+VdjvTuNJJDXd9kGORmgSoQq8SLltX2LKfFh1NLAnwfTf+SdSMfsnATghLIjliRkR7Bi4sQ037Nk5rX+/zmzzcJxs0QCl+wkhbwoidhVkT7qsu8ebxXF7Cnw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513e973b-ac91-4d36-1e4d-08dd087d6dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 09:34:56.2792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1O4rJ+UmHkewVPfI0odt94EE4MW6yDK0XmMJyEMz5ja05ycW2Gmn4Dd+7ZTrVr6DCbicn00d5gY5oACbq42K1eQJ+7G7XhbLp2Q9XOvagdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9413

On Nov 11, 2024 / 17:29, Chaitanya Kulkarni wrote:
> Add a test that randomly sets the cpumask from available CPUs for
> the nvmet-wq while running the fio workload. This patch has been
> tested on nvme-loop and nvme-tcp transport.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> V2:-
>=20
> 1. Remove the space.
> 2. Add set_conditions.
> 3. Use read -a numbers -d '' < <(seq $min_cpus $max_cpus)=20
> 4. Use           : ${TIMEOUT:=3D60}=20
> 5. Remove pgrep use kill -0
> 6. Simplify cpumask calculation
> 7. Remove killall

Thanks for this v2. Please find two more comments below. Other than those,
this patch looks good enough.

>=20
>  tests/nvme/055     | 94 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/055.out |  3 ++
>  2 files changed, 97 insertions(+)
>  create mode 100755 tests/nvme/055
>  create mode 100644 tests/nvme/055.out
>=20
> diff --git a/tests/nvme/055 b/tests/nvme/055
> new file mode 100755
> index 0000000..24b72c8
> --- /dev/null
> +++ b/tests/nvme/055
> @@ -0,0 +1,94 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2024 Chaitanya Kulkarni
> +#
> +# Test nvmet-wq cpumask sysfs attribute with NVMe-oF and fio workload
> +#
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"Test nvmet-wq cpumask sysfs attribute with fio on NVMe-oF=
 device"
> +TIMED=3D1
> +
> +requires() {
> +	_nvme_requires
> +	_have_fio && _have_loop
> +	_require_nvme_trtype_is_fabrics
> +}
> +
> +set_conditions() {
> +       _set_nvme_trtype "$@"
> +}
> +
> +
> +cleanup_setup() {
> +	_nvme_disconnect_subsys
> +	_nvmet_target_cleanup
> +}
> +
> +test() {
> +	local cpumask_path=3D"/sys/devices/virtual/workqueue/nvmet-wq/cpumask"
> +	local restored_cpumask
> +	local original_cpumask
> +	local ns
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +	_nvmet_target_setup
> +	_nvme_connect_subsys
> +
> +	if [ ! -f "$cpumask_path" ]; then
> +		SKIP_REASONS+=3D("nvmet_wq cpumask sysfs attribute not found.")
> +		cleanup_setup
> +		return 1
> +	fi
> +
> +	ns=3D$(_find_nvme_ns "${def_subsys_uuid}")
> +
> +	original_cpumask=3D$(cat "$cpumask_path")
> +
> +	#shellcheck disable=3DSC2010
> +	CPUS=3D"$(ls -1 /sys/devices/system/cpu | grep -E '^cpu[0-9]+$' | sed '=
s/cpu//')"
> +
> +	: "${TIMEOUT:=3D60}"
> +	_run_fio_rand_io --filename=3D"/dev/${ns}" \
> +			 --iodepth=3D8 --size=3D"${NVME_IMG_SIZE}" &> "$FULL" &
> +
> +	# Let the fio settle down else we will break in the loop for fio check
> +	sleep 1
> +
> +	for cpu in $CPUS; do
> +
> +		if ! kill -0 $! 2> /dev/null ; then
> +			break
> +		fi
> +
> +		# Set the cpumask for nvmet-wq to only the current CPU
> +		echo "$cpu" > "$cpumask_path" 2>/dev/null

My understanding is the sysfs cpumask file's content encodes each CPU to a =
bit.
So, '1' means enabling cpu0, '2' means enabling cpu1, 3 means enabling both=
 cpu0
and cpu1. Is this understanding correct? Based on my understanding, the lin=
e
above will be as follows:

               cpu_mask=3D$((1 << cpu))
               echo "$cpu_mask" > "$cpumask_path" 2>/dev/null

> +		cpu_mask=3D$(cat "$cpumask_path")

If we make the change above, this line is not needed, and the if block belo=
w
will need some correspodning changes.

> +
> +		if [[ "$(cat "$cpumask_path")" =3D~ ^[0,]*${cpu_mask}\n$  ]]; then
> +			echo "Test Failed: cpumask was not set correctly "
> +			echo "Expected ${cpu_mask} found $(cat "$cpumask_path")"
> +			cleanup_setup
> +			return 1
> +		fi
> +		sleep 3
> +	done
> +
> +	kill -9 $! &> /dev/null

I had suggested "kill -9", but I found that this make bash emit unnecessary
message "Killed". So, now I think the -9 option in the line above is not ne=
eded.
I think just "kill $!" works.

> +
> +	# Restore original cpumask
> +	echo "$original_cpumask" > "$cpumask_path"
> +	restored_cpumask=3D$(cat "$cpumask_path")
> +
> +	if [[ "$restored_cpumask" !=3D "$original_cpumask" ]]; then
> +		echo "Failed to restore original cpumask."
> +		cleanup_setup
> +		return 1
> +	fi
> +
> +	cleanup_setup
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/055.out b/tests/nvme/055.out
> new file mode 100644
> index 0000000..427dfee
> --- /dev/null
> +++ b/tests/nvme/055.out
> @@ -0,0 +1,3 @@
> +Running nvme/055
> +disconnected 1 controller(s)
> +Test complete
> --=20
> 2.40.0
>=20
> =
