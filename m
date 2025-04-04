Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C87191F95
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743754121; cv=fail; b=g3Tasr4vDTpO75fKoTsa2toT831Zm7J4QtQOrz0fwqKJOlByuDng1AnjmHavBK8idebapV+fNEHs31gsswOYx8vlj43yUL5I487uPCKnIE/ToF8K2lPOCi7A00kZeYua8uy0vVK/E1wmTZUp6A3NHP1IwwcdsAdYlyD+00Nzp1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743754121; c=relaxed/simple;
	bh=GIMhUehep3kOI8BMxLQTYg219tP0rEBhcORcJgcJXSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RrRyqMYH+54BozWgdx0+AtE4POK5/qyTpurFqjDEvtWAkmBZfyc73YamlZlk/goHKLbEoPasq1n2dFkBdCQ5r6Us53AKytgzkWERMcJhSGRbIHcvGAoLzZ7VQerDNOSZeQrk9NnQzGEAudrGKV8C92YJWgc2froUhvTnKthlqZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Uf0jOjJb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0FgBBoqE; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Uf0jOjJb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0FgBBoqE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743754119; x=1775290119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GIMhUehep3kOI8BMxLQTYg219tP0rEBhcORcJgcJXSs=;
  b=Uf0jOjJbgAIDQ1iKewVyOqhIrY6YShEXaaRlG0mMGfHeYWlUf4jppDga
   jqRkW4kzCQbsd2iu5i588C+X0l4z9H0bYAkGI/ONYdCVqSvCBBB7MWTSz
   uzF7G+PH16Ve6tjN9TeyCmkx3RXxR9rRzCm4kYt20exfp+6UwPlKYLZKc
   iccrWGugH1ysE7LYsKPySJ1mwzt/RujV00h4SSyuMmmRRIq6Hw7sookto
   Q4eMGRDTnPnGxtP6rQNhM4YWnRGOLslcBQ0JZ0/N0pcyHxx8bWnJPolsW
   2j/Kr0dsGrIfgAtcMc4b8wBD6EyjbJnHTjbbzZC2jld07hZtsTQXP+oH8
   Q==;
X-CSE-ConnectionGUID: UFLH59rpQluv2vaO1mii4g==
X-CSE-MsgGUID: SPyg0Z/qSvWZft7zirY4eg==
X-IronPort-AV: E=Sophos;i="6.15,187,1739808000"; 
   d="scan'208";a="69112952"
Received: from mail-centralusazlp17010002.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.2])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2025 16:08:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1UglZT2J8FporbkKc4ECXwUyMocFIc/+R4C46ggXbEytyVbQab7YK5CCefuTJfkRP5Q9rVkxRgEitPuc7yPoLRHaW/UdBVOs/jfT18NNF+qV60aPx2x1pgf1gvXU1cSGN2KZpvSBntbAxQ4FuRFx308mXhhLzYnjRL3TPe/QKWQv4IsomO1FsCusUW+5tl3yBic8kmUqdfWZRyAPkQ6rd65V8OwWlgku6KD/91XT8psZNiacRZ5SObo4h7snBs0WzUtRge0RE/ZqZpjEseJFnpQ5m1TCxJOnhIxBc9BVpVvN6BV7Afjq0qPgrhZE4UginO/oyT//IiB49M56JWweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJIHGSNRs2308VOmy+WKDkGkgSme60UinVJ9P79ufH4=;
 b=lXlXXiKusp1M8XmLoOqv7FY9tDv3bzZMjDogWNe2SLYvJHe2arZf36By9iQwFDdMcI1YrioNU429gg8wl2nRslt7OgycvUhFdc94elOCxcq9eP9xMvwbod/ajiEzpQJee9V3eSMi3FD/wc4RogkOMQqfiFJSBb1QbVfVaDiVhabrl3Mc6TIuKab1XQ7cnDzmRx6uJV00dqBSL2RLd079MfZw1Zj0/+DpCdDyzX3RjfBnBORsEcNwWZBJrYWV/3JAtRD6BB3psXWT3PRPjH4j3AsrcRkfyfDJEP5qeU6FwS2qjcYN+2boKPOLJQaFMm3VSIyo/6Q501FbqqVGCQcI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJIHGSNRs2308VOmy+WKDkGkgSme60UinVJ9P79ufH4=;
 b=0FgBBoqEPPgaDhyAJbIXEU7r+XBtk72nQb7HCTF36iFzYyHR1PG7/xZz9SnX/M0lqj88NtFQQ+gGcc7hZTK4uz+Imc5scuNKEC71zfHGIWCC2mSaEq3aLzuEnzthB2SvybM/Fg7l1zywKUdn+FkJFyW06N88UkSzHX1v5j44Ej4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB8025.namprd04.prod.outlook.com (2603:10b6:208:344::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Fri, 4 Apr
 2025 08:08:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8534.045; Fri, 4 Apr 2025
 08:08:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <wagi@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/3] nvme/060: add test nvme fabrics target
 resetting during I/O
Thread-Topic: [PATCH blktests 2/3] nvme/060: add test nvme fabrics target
 resetting during I/O
Thread-Index: AQHbl/IGLgCdyFQgwEKbzNdBLAVZG7OTQZuA
Date: Fri, 4 Apr 2025 08:08:31 +0000
Message-ID: <eusczvub2jnb5dw26t52tpmsidd6fwehfbfqgaparsrmhxdasd@xwwxeqaxh7h5>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
 <20250318-test-target-v1-2-01e01142cf2b@kernel.org>
In-Reply-To: <20250318-test-target-v1-2-01e01142cf2b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB8025:EE_
x-ms-office365-filtering-correlation-id: d70fcef8-5446-4e2e-5792-08dd734fe3a0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cgflpbLRmLMm5q53IMB8FkHJJQMgl4/4C6tfUrgA3dZEs2rJ3SmSkwqyNwzf?=
 =?us-ascii?Q?IvZ3wDA0VgXgxDO0JeKGiTLgsQXxosZkYKrlzXXVIKZRZluVfk1A9VPPLzv3?=
 =?us-ascii?Q?paqiztxn54G1SXjbGOkzZkz2K96f0/N/X7yWkL5VrB/zFryvVlS81AQaWOpp?=
 =?us-ascii?Q?BRsbZRueOjpqhKuW6mF15oQ6ZGKG0lOWJwOUMZE/rk9orcv8lvzAiGntTkpc?=
 =?us-ascii?Q?cHToYkLm62wUqgz79eff6FCCIo8ufAEMqG+Po9KhqTPWtukBBEp6yL/H2HSZ?=
 =?us-ascii?Q?nqDrgYWRUY0AjELurWVYmXA39DovNFgL0aq6pW7mLRzlmc5cW75c3lAAaGnE?=
 =?us-ascii?Q?TuKIxHuuKB0DUmRNZa2MwiNu+1rwXqqch+e3X6x0ssFL+PJuh5oquHr524Qh?=
 =?us-ascii?Q?CMsYBcn4URNlXz06Jvw3UWOaQi+xspUOM+0IXvePOqvpxTLmbqzP9LSkjyLd?=
 =?us-ascii?Q?XFEiPSA0oYmCqQIzSjEUwuUPidp6fDEOSO6GlNFLMRB7qqKR7Fh1hbaQBHDN?=
 =?us-ascii?Q?QW9p5YAanCh+klQl1sAyVmIwG/c4Mq+8TqPJO/at9kE2o+6av56i2TabwJzn?=
 =?us-ascii?Q?It36kxpxL4NsaLi0PsQ0L2hViGW8WHwkDMRiRMKfQG1ewm0SwGXzoqRvSUdn?=
 =?us-ascii?Q?iM7oW86MW5YYfk0EsCk/k5d/jkqDhw/2XbAYZwtJkpryWd6zj2jI4/u+Mevy?=
 =?us-ascii?Q?lQaQjJmED+nFUdLbZeqj8GRQni7ncyq4GiPtODifXJEOP3TaVryLZyZtphKu?=
 =?us-ascii?Q?Rp7oOnNAxDRuc1aKYgIvF6ih7DwMRGn2rnN+OJ91XoUM2wgwWWCtKjsYYuW1?=
 =?us-ascii?Q?l4ogJsw8O+50jeyWvvU/BsBeSqtafEt3nLpzgc1RE++CKXCQZcV7IgRksibu?=
 =?us-ascii?Q?S6Kd7KC2GZuVG/4voTSEZWQIB1Zd+nk2EBnB80RskpXXGy8DJ2JGDdpVHbNu?=
 =?us-ascii?Q?eK213dJ8WZ22DGthjgahWcJtFGCSODeBkX0aVPqQVt2obQZh7hHjDJ65qx0C?=
 =?us-ascii?Q?8jezSIH6Fh1EoDFS0INVqktQDLKbbCCbxaszP/4znqZuAZnTJiHTF0+d0vKh?=
 =?us-ascii?Q?J+jIwm6T14Kvoxa7AUyHwEjpSKfS1AU5TVPOGUNv1rlpwIcLJF7OVuyTkT+5?=
 =?us-ascii?Q?0XKi5x+Bb3OgHUDzznxCpMUH7EeluvXzfwQqCphn2O0DBkUoIlpXEzJev0oi?=
 =?us-ascii?Q?CQq3bj2JSC4q8ebj4Uoyd2oABMx37W7F93jFjclNyg1SEUwlXBWAlHFrYVMF?=
 =?us-ascii?Q?PqtI/INfsQG8LvdfhVAD7bZjNl/rEyaq5VI+DD5DAXfccMSbVoFnZkcHS2Xf?=
 =?us-ascii?Q?FBArnaTkdX2oZ5SYLX/MryPJCVDum9pIc/Ejrsuhe4//m/ffg6+2AchC6D7s?=
 =?us-ascii?Q?S389nEOONr+I6+P5ZQmKf3D49uVtaMOL74PaGo5h9P0o8B2MCsC5thHNYkoo?=
 =?us-ascii?Q?AI/qadlId55H1S6FEw6T3DfVoABQhkDB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c3Ij5kSrDZ21O75q391zmj0MUlk8Rriwd0YuKd7Mv/pV0k/5jqE130/I/sNb?=
 =?us-ascii?Q?VWxsCyXwVXEANUzkqC+nk0J/XCBwdJpxAw1XiFP9S2AZG1Tamg8yjJkTKVdm?=
 =?us-ascii?Q?W1pstSX1MnvCcY+rzeZZTKcXlxwx3EtLppvR3nPyy4BEs1MsvcPm2DjLL+J/?=
 =?us-ascii?Q?CTBGKbIQ7BzqYIHRQLdUIaGlYPSEG/slSvn4GZWeHHGTYIivOCmz1IE4dqmT?=
 =?us-ascii?Q?wt/g9lH5mUJKl6PLQ0XcsHhugJSwpuAhHhMEOr91aIdMK8wgsneJ047ersBV?=
 =?us-ascii?Q?HB20GANtAop8gGvREzNxRuDeiEp/BdPwngctsQL3DntAGZxqiwxVewIrXoZ8?=
 =?us-ascii?Q?5eFMxgQ5DcU+7BbWai6xN7/pgRAEVzz0vPLa1cV4Oduj7vyDTinrxGpsRckP?=
 =?us-ascii?Q?Yu6XojNR2d94xv4GBqZ4eZteqVmd56hFLib+HQ2f2v6MZWRMgfTeMr2f53te?=
 =?us-ascii?Q?vTvUTc4RU67xajpYeC9JYNfi2rSTUdOrWCuy34w7rVBDIERL/phbWy23pTi3?=
 =?us-ascii?Q?DEwVcuIH77s7W2ET6mqx4+LWEKGS6qbCjWwCoHlq0cOpv1Qojl+VbhLGOZf/?=
 =?us-ascii?Q?nsTdvHLStkUTDRxpcdGgAmSX+OxJKTgU28MCcmPyjQLP0tVjIAxBrwAZY13a?=
 =?us-ascii?Q?Z+O9uskk5tGW94/e70s4zZv7j/ASq2HtWt8Yye9cQdmwUhgmqv20eNK6bWB1?=
 =?us-ascii?Q?D083DvB1Ac/t/bFXNaSyw7XJnDZ+LAx5s65y+TTeCAHzSEj1Rx9mYzLwU3RR?=
 =?us-ascii?Q?PNwEvdjziONulNJ+QuVyg4lv4YfdOC6cOOA6BI0hA6xyF8PQwiD3w/12f3QC?=
 =?us-ascii?Q?0h0z3TC9+MOrKMRAFbYVmdJ18zOZWG+9rY/AWjT5+FCqLC7B3V6KnV0B+zN9?=
 =?us-ascii?Q?lNK9Pr0746rS1ZFTe5KFjJs8qv+5KZFkx0JMAcjurDcGEk5h7Xl6jOlzQ13K?=
 =?us-ascii?Q?2ttrQ2MOuRHQg4sZQF+6jJw3q6FdZERLo3+Uwn1u01g7rIZqzV/5rpwaaUU1?=
 =?us-ascii?Q?Y56sdpQ9+bI0lxY7vS+9cs2N1ue707tPXjfNbAIBQORMxfUPdzNCBVbrkvEn?=
 =?us-ascii?Q?omV1/aig9v/zwQqe+YcmSw4uAmk5+sVHnevzUoa5jQs1Bb1kuGj1vSV2E9zd?=
 =?us-ascii?Q?oaTUac2mRmj2mBAiHhgMMt+jWAOXdfXCIUhpMK2WTQ8+cYKb6rr0edAQC2wf?=
 =?us-ascii?Q?R6pGxfcL0D5Fp/lno6bRhhhXF/sVw381OP+LltdCAobAISsJMPgdN7Nu0/YD?=
 =?us-ascii?Q?gPjSGjUkwXz2uQJ0fkue5f6oCvR0pMI5HJ5mDCQ6cHJjsNljLSBUuHW5vzJU?=
 =?us-ascii?Q?BaZ+8Q/39bmnZkRz+d2IiQ8O4YS2tXNDH4Kmqmz7zAErjAn5yRg8b6/+Q6IH?=
 =?us-ascii?Q?NDb9BmXCBKYlpcUQKzXFLZp1PjtbrVfsJw1/cBQHlNpvf5HN40oCjVagCTlq?=
 =?us-ascii?Q?Mc8zkphTmnYOCX2aXyu01bx9JWO7YsQnvYdCHjJ1bU5jVdK6M0yZBsc0GGoL?=
 =?us-ascii?Q?qx5Ua2QcjknBWKLZJQm/W127AZhaXcUzc2LvDqPkt1SjmcRx/hlhuMfXHzd1?=
 =?us-ascii?Q?gVPOuE1Oe02r7Y8D2oCFGze7Uk8SkMTC4wPAeb6P32m4Snfp/QYrcBbbdAjb?=
 =?us-ascii?Q?vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16D48D01AA86FA4893C8ADDD58EFA5E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I6taVdfTubGwpHblKCvEEbEXlxIEDF6xcA0cAg18T0ftwTyxRt100uu+vcsB4PphFEInRhG9m6KOUWCZDTn+vzPQmOanPLOt4N3uhgjiTHquEOaVf//F5WWBs6eg4fiw/qerP1TH4APkzJxGfPlbyIKOz6MujMxsZ/k/wDJUOCtNy9W1SM637WbEuO7t253EclUs4uLlAqLyT73Z7muGD2mwXjVk4cPXYKNc8jE9TvznDDaJFPposLEpc2VROAeot5PoRKfNNZYvVWWdq9bU0Qdxt5JkWF8paVpE2CLd32jlp/3VS0zlJh+C2AOO6182KCmMLQjMwFRYJjswGka1gmxFBGE4vBdIrrFpsNB1Os1LeAvxZW+68rg/YETPtmqbNc3kPcCrfsVEs7BpqPAZq+LPm2yvYD/qoTocs0SQsMQY/iGBwQ4bjttvHT/wi0FXF9fOc76dTkwjtaPiaQjM8aYVlfSzBDe8xcb1oxweROo0l7n39RQ3ElcilyPaDMCz9bTzCKJ8CV3/4SZn9uVfKvZKlUPOYwi1C2ws9XMGNiEwPYNCqB19SeWiiQBPcH2LyLHBQxI/o7xa3YdFeMvbC0Zy4oBZcE4ZotfEXHivjr449Axn2AJbmjfrNqjv42Ml
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70fcef8-5446-4e2e-5792-08dd734fe3a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 08:08:31.4976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osttSHrdgor3jVht3N9LP3NxShmldy2VJCfo0jTvBp30lZJG1dPucDr0a7eU6m92NCQlFVp8PrIyb50MqejM+yN22YufGY641Gt13NGs/tI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8025

On Mar 18, 2025 / 11:39, Daniel Wagner wrote:
> Newer kernel support to reset the target via the debugfs. Add a new test
> case which exercises this interface.

I find the kernel commit 649fd41420a8 ("nvmet: add debugfs support") enable=
s
this test. Looking at the kernel commit, I fount this test case depends on =
the
kernel config NVME_TARGET_DEBUGFS. So let's add,

 _have_kernel_option NVME_TARGET_DEBUGFS

in requires().

>=20
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  tests/nvme/060     | 88 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/nvme/060.out |  2 ++
>  2 files changed, 90 insertions(+)
>=20
> diff --git a/tests/nvme/060 b/tests/nvme/060
> new file mode 100755
> index 0000000000000000000000000000000000000000..16a3c0d20274428ae17569310=
9c694f42004a619
> --- /dev/null
> +++ b/tests/nvme/060
> @@ -0,0 +1,88 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Daniel Wagner, SUSE Labs
> +#
> +# Test nvme fabrics controller reset/disconnect/reconnect operation duri=
ng I/O
> +# This test is somewhat similar to test 032 but for fabrics controllers.
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"test nvme fabrics target resetting during I/O"
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_have_fio

I don't find fio command in this test case. Do I miss it?

> +	_require_nvme_trtype_is_fabrics
> +}
> +
> +set_conditions() {
> +	_set_nvme_trtype "$@"
> +}
> +
> +nvmet_debug_trigger_reset() {
> +	local nvmet_subsystem=3D"$1"
> +	local dfs_path=3D"${NVMET_DFS}/${nvmet_subsystem}"
> +
> +	find "${dfs_path}" -maxdepth 1 -type d -name 'ctrl*' -exec sh -c 'echo =
"fatal" > "$1/state"' _ {} \;
> +}
> +
> +nvmf_wait_for_state() {
> +	local def_state_timeout=3D5
> +	local subsys_name=3D"$1"
> +	local state=3D"$2"
> +	local timeout=3D"${3:-$def_state_timeout}"
> +	local nvmedev
> +	local state_file
> +	local start_time
> +	local end_time
> +
> +	nvmedev=3D$(_find_nvme_dev "${subsys_name}")
> +	state_file=3D"/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
> +
> +	start_time=3D$(date +%s)
> +	while ! grep -q "${state}" "${state_file}"; do
> +		sleep 1
> +		end_time=3D$(date +%s)
> +		if (( end_time - start_time > timeout )); then
> +			echo "expected state \"${state}\" not " \
> +				"reached within ${timeout} seconds"
> +			return 1
> +		fi
> +	done
> +
> +	return 0
> +}

Is this function used in this test case?
