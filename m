Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF0216F0D0
	for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315650; cv=fail; b=Xff/E/QDY4hjjFReVC1O3R+RjAWOIPSTbiEnHgYIccjAM46kLK3QzHZiET7Mw30LCjJBxvwbqb6UHZC4PM9WewtHgKnmGdB6qSMVePwf3GyzV3BGW/LLaMLptEfnk12tFKNFWxP8uOEpvLxnwFx8AK6pscSuZ4QlwMuipc7OKik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315650; c=relaxed/simple;
	bh=YF8f8beTaOYapt53UZHiOBZ5ADkbXyoWsX1L8sIiD04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OnoKdGkZUiMRZ3Qj+Ldeu2zcgRyODpylyFeCJ/+lJCu7mCEJz87T2Fnuzlp5gUrc5axq8V3n97cZk/n9wHVTQkMs1znwT9TW8m0mDo7gfnbvP6cuw1aK06YRvZCU12Ipf9AY1et4FrDqkD53IPdvTRwF3JVNtVW58AV4gRlZGA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FL7w02kE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wSrTDT6n; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FL7w02kE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wSrTDT6n"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724315647; x=1755851647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YF8f8beTaOYapt53UZHiOBZ5ADkbXyoWsX1L8sIiD04=;
  b=FL7w02kEhtRU2ZhsKUGwzSDjMtl8v9UPvYJUVNwxcyWslrQJkQ8ZuvOc
   Ggm31+16EVJ3DhxKNW7R0xWbz/euQ9tRogfzBnUf1u6BvzLLjJ6/IeNOe
   72Gu5Zi5Ml6kCEqvtnvD5JqjQpYiz9eBpYaOGUrQII/bD15nw0ovYCcyJ
   I16mJS4apShrP9kO8gpDMp6dvr28+jlZfeMmRq6HhJhwI9M+i+Uw0At9k
   vaiDqTg+vahAJcCCZRhbLqcMwXl10Bi7TldVo7bAJhZMJk5JFaPXf1V1C
   wTGrDjFzbCvE62ak2dINAoIjyyqLFPshmEMG5cwuxY1wxw4UPmRlVHt4m
   g==;
X-CSE-ConnectionGUID: c6KxVNK5TbSMKlLPJPRegA==
X-CSE-MsgGUID: nYNLi8GWTsW48fhDMmZcHg==
X-IronPort-AV: E=Sophos;i="6.10,166,1719849600"; 
   d="scan'208";a="25642652"
Received: from mail-eastus2azlp17011027.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.27])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2024 16:34:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLd7iZrQJI8C/xPrxbvLM+XaGSmWWcxzvCS4PGrkj+/qplQxWL4iUARR81kX7GcUy7g0JNdi7k2HuHWxQXZLLHwRrbqJxJk76jJ9FahTYbUJVKFHwCJvhk0X94wE0sER3ccuxSiYn1sI+G/v7TGhwXxxnFrqo2TPNQKZ2NllEWgXlW53t+cQFc7CHt3me2/64dSpGflm2N6iR/pfYms4PvKJkwCwgkn1jEln+bIGxb6ar06i7zLIQZ0wK1zwp/buPCFbUnt6hLwtzMSpFWe+GBHF1CPGRYdpvPnOuP9rQH4sv75nBd0z23JlsYPvtpWzUu2FXsDGL+9JRzZn+lrlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yp8a8++L8Cu7Sf7lCvklWtVr5YXCWNvk6W7Ad0i8DOs=;
 b=KHSqtj34CHpOyh/XJg71Sn1IzT64IRfzi5gjGQDMXzTez9w8eHbk173N1nA4VvdlIWv5He4mwoYF1Kpoaay5IN42QzW41emFBbqoLqVdM5jq87n5sfChc5XJBhNoisasUO6ZO5D71P7QAqe+vBBEC3vruyyzsxaiPTO38qKU5Scoi9JQn/2A73dmkIURnCA8ffOc4KOGA/qANEXdwJNE11LPp+b0WnJWNYmObLhX/EyIutygwxaGztjAqdvpx+gFNKR1aGElKsirHinmz8lEF7zbyrysfk+QPMNp5qss7U9u6/MS9RMv+QnQY62088BpPM1amGWz/YD2Et2lQCJFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yp8a8++L8Cu7Sf7lCvklWtVr5YXCWNvk6W7Ad0i8DOs=;
 b=wSrTDT6njiW+ydeC1Edp4+L5tTiqys3jFyysZPOllvCy6ESemMBsX7L8ldER0My4KUaieVjcqLOFCm0uEDWeCDLAcwlCBR1gp6yDn1IZaJ3jGpqK+2xJsxArU5tufxlYfant8HREyrY0D6Zryn66Xm21JG/M7pa/qwx53BqQtfo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7742.namprd04.prod.outlook.com (2603:10b6:a03:31a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 08:33:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 08:33:58 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Yi Zhang
	<yi.zhang@redhat.com>
Subject: Re: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
Thread-Topic: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
Thread-Index: AQHa8uqR0Nq3uU3VMkila6SfAwK3vLIwXbgAgADx2QCAACN+AIABgyqA
Date: Thu, 22 Aug 2024 08:33:58 +0000
Message-ID: <wf32ec6ug34nxuqjxrls5uaxkvhtsdi4yp2obf5rbxfviwlqzt@7joov5mngfed>
References: <20240820102013.781794-1-shinichiro.kawasaki@wdc.com>
 <d22e0c6f-0451-4299-970f-602458b6556d@linux.ibm.com>
 <zzodkioqxp6dcskfv6p5grncnvjdmakof3wemjemnralqhes4e@edr2n343oy62>
 <0750187c-24ad-4073-9ba1-d47b0ee95062@linux.ibm.com>
In-Reply-To: <0750187c-24ad-4073-9ba1-d47b0ee95062@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7742:EE_
x-ms-office365-filtering-correlation-id: 4b8d62a2-6c8a-4c80-006f-08dcc2852ad7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DJDUtoajuIvdMgPXmz9kqRPJCsJNV5QariNsJJht24OcKTJKSIS3AHKWzQln?=
 =?us-ascii?Q?j2JTF0sgpZzHTWtBQR4ShTvdxHNmOyxV4wQF+4uV3kkPjM0pVW7N+8+OpoJW?=
 =?us-ascii?Q?h5+bSVqAAupuHXAoBy+8nBdXr+JEbUd+BEc59tPKcsOVfILtnWXzHN8+46bA?=
 =?us-ascii?Q?J00dG4xz8pkntAcnGRPlqZGK1R8bqPHgz/JB5HB5KNdSngw7C1IqRmnkF2Nx?=
 =?us-ascii?Q?8m01o9dBgsmSTq+pdFp/qFzLS/0aHyLq/inzkc2KOCMb79qBqkIx6UEWeGpn?=
 =?us-ascii?Q?wniFitm7eO0SUU3VHBF0hHSlioSUVtgtqzS5YqT52M8GF6jf2dqkpdjf1dzY?=
 =?us-ascii?Q?13CpwtYm9+JZ/EICTUp11yy/hqkwZBuOk4FjanDSsMVCfOUeQ6WEcmK0GM86?=
 =?us-ascii?Q?OlagV+3qzFD8eKTA4UMneHMaA5LSjBtcGNJAO8VUHpG15Xvq9IZX+J2VGMAZ?=
 =?us-ascii?Q?2D6Q1bqMazHzeIsyfysrka7DtW0lNCSISlWNoXU4+mWPzqPHXe1JN3UK9Tl1?=
 =?us-ascii?Q?DKwU/9QFiw/XR6NAafEnPI+Syvsy7EdCfcv7OytJk8NjM4MS3zvvGxRczLR1?=
 =?us-ascii?Q?3SzMy1aeuXZpVT3yodSjDWcZbEif45wSw4fRbETXy3VIeI4sFuN3EiR7hVlT?=
 =?us-ascii?Q?d+aLaS9dxbODd3NiYTh3m+uXAfkNI1co/w7ee0r+NEwi6Q2GGPBqoS/I7r/C?=
 =?us-ascii?Q?woSEtKdqlPPrwWjp2YidIv72gu6bJTO1XfctVkuu/xlbEo0KAbKdNE/+3pHX?=
 =?us-ascii?Q?CsEeWOCnurhXJYskchJj60hJNtKohmgqGZBdR/pSPM4UDfp+qWl8BrlBWDCp?=
 =?us-ascii?Q?7qjIG9C6fo7zARvPwmqKY5HuIGdIY/hIr0p/Lx3rJW3/lELajuY6ZgVkg98U?=
 =?us-ascii?Q?2da+RcefEcagxenxh6+AVpuw7ME+tFC5kzlJGUlAkyldL3XtnUgtlSgvBPbO?=
 =?us-ascii?Q?3rb8Z1bnS4RD9WtOopTqC2JdaIadY/BZzpm/wIkvodoSSINKI14Xi36btLqZ?=
 =?us-ascii?Q?SAxSb6tvaDRg9PybYwV4/LdS+I2+y4IrdEdPucEWLnx57lVkq3cb8DwGlmOr?=
 =?us-ascii?Q?P0yg7ygyElx3id9wE6FYbCB4bKolasIFkAfP8VdDS7VnU5aHtxxYEahXWb07?=
 =?us-ascii?Q?8wXe5yndizeDrg4ho58rtylbWH/xlTYXWhEs6jfSI/xs1FspoxvFU2mWLnsk?=
 =?us-ascii?Q?5folJ2vTGZYsCoLvQef1bKZRnbPA8PPnOLMS8WQuFwI7y9Ah67XOagW4VgwL?=
 =?us-ascii?Q?Cb8c+bak94tU1WKhNw00wITg2qz11by0dXSFVzQsT+M6JWte0xZqo1HBlv+u?=
 =?us-ascii?Q?6BDJ2Lqn3eXP1/ekFyECFzjaXXWj6sjmo6ynRZloP1c2rcrQFf18wW8oMvIB?=
 =?us-ascii?Q?2TqJZz7v/HeEW0UrYphWeX+a3WZ4naGgGJo/c0oqwGVDLjr75A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XVRxhC43LmKr2AXGwArwn9st1GfZ177qe+vICpRYiviaMY5ZFLxxUhBcNubl?=
 =?us-ascii?Q?JUlhge0mAcGtLIMFE7U39B1NeTbH8I7dI9UJPQ297bn8j1+eQ7J0jlrPfWu9?=
 =?us-ascii?Q?vOvtmNLaHM23jca75S8Vj/tCwXt1dkrq/DB++7+hws8BeV6fvqHdOr4Z6clU?=
 =?us-ascii?Q?CdhpFL6+ARNsL2VBlSC3JVOEViQW9RfykE8XFMpU/kfBdNhwoukSAETSrL+P?=
 =?us-ascii?Q?xpWDNCywaX87WGORd+kj3DdqzLwyQi3OgUzdtoZNS4gwInQcZ1Z6o0Lh3s6s?=
 =?us-ascii?Q?t+2a6PcfJCFakRHhoqSWnQuepr8HsYVM9BYhg47fXN9GPINnVERkmKVv6Ktx?=
 =?us-ascii?Q?DDD14LHCUOWgVuoWKC11+jiPeogbVzq0b9sWW4vNwE6LaUg1EFOxLiYGTOe+?=
 =?us-ascii?Q?f9girvoDgvDBtGEo1k1A4OJGYqJzj+TPpWvwASncQomxGuVmlYCkhXcPB0yv?=
 =?us-ascii?Q?i1EEnRFtcEVdE5voZ7ilsmkp+LLKEiGT3Pdz/aiCtttwPnWuR/ACH/HQeaSN?=
 =?us-ascii?Q?i9tCrSw0gETFTJEa+DnXW2PONgKANH2IkAR857Og9pgius7jBZnKYdVB98XW?=
 =?us-ascii?Q?C5qIqzEaBjndBcowYWrd7/xUgoV3sKPgd52OAAz1GEdhj/J4+3ZPFAa6yxBg?=
 =?us-ascii?Q?8xIVSZ/uCG8v2bPhFHp0tubSo8VGcAWqaaGd7vyhcvAcGoYPcOQ6HWQbJY8f?=
 =?us-ascii?Q?KNrwkgEMuluZJNj/6FbL697Be7HfRtp7Jv4d1oTo9VvbDqZg2QjdTCIXltDP?=
 =?us-ascii?Q?OG+0Qp+q1gShXLo+KCeZhCQX/ogfViJVIARD6jV6NScfHklCYATHmbX7vPbn?=
 =?us-ascii?Q?xgKS5deSI/yIalrrzwv2tMyTuYzTyVTQoFi4Sg0BIxILLvGilewJN4HhP6ID?=
 =?us-ascii?Q?3T2Kx7r1qHA7ejdhYoM69lSRCksXYO8KE3mTSCeGzdCtthN5fkCL7Ik1Pq5U?=
 =?us-ascii?Q?p31DUxznRlMoiz7nOnlygVzJjeQEsmpqb0F4o9y7KL7zUQ+xRnQnvarPv4LI?=
 =?us-ascii?Q?WKur3kfXwWY4rMUgAo8J+WH8jVYSwhJ1kNY2GlqX/kRwLEkv6rdc8lm5Hjhy?=
 =?us-ascii?Q?r8RrZ1f9voxvk2bsdyC6iQatBOsg6WVtZna3roHtDmJeOZtBKpwzoW0aWlbO?=
 =?us-ascii?Q?CBfy57MOGj0rJVUm/4QPZ+oYTkzEVoDFXRYujHGPx7CJbDIGPH+e/guG+8ZG?=
 =?us-ascii?Q?q0n/hVT+gP/4UIGvKhW8/GmeptwHJeAKqG8ZrKqIqJC/5dmVC1gDBQGa7uUm?=
 =?us-ascii?Q?iWcHCvB7XDthi9ILVlacxQLrlCYChntrONEh/izQXknjG+2F/BPFMYc+NRmf?=
 =?us-ascii?Q?7F6Y9gFMPQm9NEE8bv2ZOnAvViIbIlifdU1PrbiFRPWLAyWfr5KyS7UZaIQh?=
 =?us-ascii?Q?t+Ax5XpId0o8i87QS6/UZg72Tl9Bx7TkhQovbvhjsJlJdqPnmwGmyJWjxZl/?=
 =?us-ascii?Q?Gq+oCmD1sG2t37ip7Dt0COZ1PmJdsJEJRkQhE7Wrlw3hD4V/yb/9AoC2Fosw?=
 =?us-ascii?Q?i0YOThFziBSqe4Wh8qyqlHQtCsY3uzCfBM6T6YCoy2X7iurUgpVEIzmcbWGv?=
 =?us-ascii?Q?n+ktmbDxYm0aD79/pVKKS2fukrYDQkzgMxWtMV+R5tdAz61AOHw1O6oDNY7C?=
 =?us-ascii?Q?rz9V4E6Atl5w/D5TBzyF05M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06457F706682E240BD4D0D046443D2B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LbkNpMlfbCTIoXbG8+lV1++KCogMSOIhBixK1+GvK9P1EJIUpLS6mrbe6qyBFn5j1P21hKgC5OK4MELXFxVorOnIovlKjf8EtzsmZCOQXqwsNSGG2AC6Sde921Thpz/t6LXfCu43yBrQqZ9wpNHz2kiWmm4D9zFv0LFnW/8xHCAEU8jhpEvueq/uo1R1C/TvS0TarwFhAFfNCp+6zz5bgwVYeGPEqiAdWFyN1VCrRF9EvSBIFX+PHg/W6vm3Yvuiem45MRgZaHnBp6UoMGhJQ3fhNKUlYM2EhmSzIyLQCeDiNKviK9gXUIbo+4I0Ndg+P2ryS9Ql9shu/JVI3A7vc+pbqOM03rEXrcNCl0nHVkfQ/avC3hCv3l1g2AOQpScUfJJeMZSJPyWi/HT3Hs3xbepIKjzPR77VPCOgkR7+en1Vgj3rI/C4zgav+W4NVov+k9UDRRmf2Omjjaf42xib5czVvYFZHWDfETMEZKi5BvsoobVBkB+vSuzK2A/g3QJPFAOfXb95A/nEqOuxN2Ouu2N7i4ndcFS13kNqbOu/7FZG2Ohdmj7IoFFgiDpRZArhtowL/fIhDTif7cTdKgWpnl6vxuvPr+AS0RtdtEzCndtYSBd24QEtTB/Jdadj1uZd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8d62a2-6c8a-4c80-006f-08dcc2852ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 08:33:58.4736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bou0FsppIkDynSMBBv+oFBExcX0XXi3MNAvbzyZexq/KWQ3xANW/XVyIYqXDF3JLLZGzux0DoxnvP9Z6zfXwd+/0WBBDFgdKOfVlyYpFQVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7742

On Aug 21, 2024 / 14:58, Nilay Shroff wrote:
>=20
>=20
> On 8/21/24 12:51, Shinichiro Kawasaki wrote:
[...]
> > diff --git a/tests/nvme/052 b/tests/nvme/052
> > index cf6061a..22e0bf5 100755
> > --- a/tests/nvme/052
> > +++ b/tests/nvme/052
> > @@ -20,23 +20,35 @@ set_conditions() {
> >  	_set_nvme_trtype "$@"
> >  }
> > =20
> > +find_nvme_ns() {
> > +	if [[ "$2" =3D=3D removed ]]; then
> > +		_find_nvme_ns "$1" 2> /dev/null
> > +	else
> > +		_find_nvme_ns "$1"
> > +	fi
> > +}
> > +
> > +# Wait for the namespace with specified uuid to fulfill the specified =
condtion,
> > +# "created" or "removed".
> >  nvmf_wait_for_ns() {
> >  	local ns
> >  	local timeout=3D"5"
> >  	local uuid=3D"$1"
> > +	local condition=3D"$2"
> > =20
> > -	ns=3D$(_find_nvme_ns "${uuid}")
> > +	ns=3D$(find_nvme_ns "${uuid}" "${condition}")
> > =20
> >  	start_time=3D$(date +%s)
> > -	while [[ -z "$ns" ]]; do
> > +	while [[ -z "$ns" && "$condition" =3D=3D created  ]] ||
> > +		      [[ -n "$ns" && "$condition" =3D=3D removed ]]; do
> >  		sleep 1
> >  		end_time=3D$(date +%s)
> >  		if (( end_time - start_time > timeout )); then
> >  			echo "namespace with uuid \"${uuid}\" not " \
> > -				"found within ${timeout} seconds"
> > +				"${condition} within ${timeout} seconds"
> >  			return 1
> >  		fi
> > -		ns=3D$(_find_nvme_ns "${uuid}")
> > +		ns=3D$(find_nvme_ns "${uuid}" "${condition}")
> >  	done
> > =20
> >  	return 0
> > @@ -63,7 +75,7 @@ test() {
> >  		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$=
i" "${uuid}"
> > =20
> >  		# wait until async request is processed and ns is created
> > -		nvmf_wait_for_ns "${uuid}"
> > +		nvmf_wait_for_ns "${uuid}" created
> >  		if [ $? -eq 1 ]; then
> >  			echo "FAIL"
> >  			rm "$(_nvme_def_file_path).$i"
> > @@ -71,6 +83,10 @@ test() {
> >  		fi
> > =20
> >  		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
> > +
> > +		# wait until async request is processed and ns is removed
> > +		nvmf_wait_for_ns "${uuid}" removed
> > +
> As nvme_wait_for_ns() returns either 0 (success) or 1 (failure), I think =
we=20
> should check the return status of nvme_wait_for_ns() here and bail out in=
 case=20
> it returns failure same as what we do above while creating namespace.

Agreed, I will add the check to v2.

>=20
> Another point: I think, we may always suppress error from _find_nvme_ns()=
 irrespective
> of it's being called while "creating" or "removing" the namespace assumin=
g we always=20
> check the return status of nvme_wait_for_ns() in the main loop. So ideall=
y we shall=20
> invoke _find_nvme_ns() from nvme_wait_for_ns() as below:
>=20
> ns=3D$(_find_nvme_ns "${uuid}" 2>/dev/null)

It doesn't sound correct to suppress the _find_nvme_ns errors always. We fo=
und
the issue since _find_nvme_ns reported the error at after _create_nvmet_ns(=
)
call. If we suppress it, I can not be confident that this fix avoids the er=
ror.

>=20
> On a cosmetic note: Maybe we can use readonly constants to make "created"=
 and "removed"
> parameters looks more elegant/readable.=20
>=20
> # Define constants
> readonly NS_ADD=3D"added"
> readonly NS_DEL=3D"deleted"=20
> =20
> Now we may reuse above constants instead of "created" and "removed". You =
may rename=20
> constant name if you don't like the name I used above :)

This sounds too much for me. "created" and "removed" are constant strings, =
so
I'm not sure about the merit of introducing the constant variables. Number =
of
characters will not change much either.

>=20
> Thanks,
> --Nilay=
