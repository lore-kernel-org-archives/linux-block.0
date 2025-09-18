Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372417D346
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758169026; cv=fail; b=M/9mRa7wFv+VmYLJgJXMux80KRUwMWV4wokYL60nTbwrswjvos/DNsrTCEseuG18aPsqMg3rFoQ3dRE9rqgkwKzJvlpWWUarGulYZiCSlMPKmxnIxQVwJ5z2UiQKXgpBVhAWBvg9AMhE2NmsjTYh0cQT076qAsgUwDZOsd/PWCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758169026; c=relaxed/simple;
	bh=YuOHfeFhuTFwEL38U8DJdSFiNc2Tw23pN9ffOmhmXxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LZyKpJvOldX73oHlEhAmle+n45mW53xmkQJqK3ZA+RCv9Xpk+/iG6hjtcdoS34WMBEx8lw/rdUoHGLvyQ6JQpDjDAMOL5udPq3nCLlR75mMucfE/oi5Tu/o12jHsYX16fAcyLKCCRi0iX367QwmuIjD8lLmrMJxJDLXTtZMMdZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KnX5xxsC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oqQFTV0c; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KnX5xxsC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oqQFTV0c"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758169024; x=1789705024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YuOHfeFhuTFwEL38U8DJdSFiNc2Tw23pN9ffOmhmXxY=;
  b=KnX5xxsCZ0Bz3OsQWoIrzdJy/MR+UhINJOT5F8Njoutdu6pb9gRWpcev
   i9QT2+XxcaYlyETak0CvCevzY+KJVH0kQtt98PPRZR5qqyoA4Jr2F13Ir
   8+Rko9ZAK5aGE+AWkq2PaR8g+uVEWYg+FNiXlt5k1WeWRk+u1o4vpuAq/
   lhTtM131J3vpioDF5Vu7+M5QtWEb281SkCcmwFoKM9voE/CLoW01+ctPK
   evhMcT1xHfESy301fHt3mjDb3EEZf4H7Dn4041KAoV1QP974LNGVAdGVC
   7jGDwcJ7MVEwL3+oHwDiXMwOo19toZ6OfWYWfgc1ZS+xehRt2hrz5R8J0
   g==;
X-CSE-ConnectionGUID: 8Hxyk9D1QsO39F2T9SZeCg==
X-CSE-MsgGUID: 1d61BiyqTvOyfF27YPxdKA==
X-IronPort-AV: E=Sophos;i="6.18,274,1751212800"; 
   d="scan'208";a="123256748"
Received: from mail-westusazon11012020.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.20])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2025 12:17:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azsYQYh46HqqiLn5+dOOWKaqOod3vcdG3UwwZ+tYax75SynCwBhiLiXTIla/c5o8u8FOqkPE4ecn0MI3TcyHfvpovarJN8YOBcWYbLx4w7OR12vSjs5eCz6yA+dl2wQtBWoVW9kdMqJaN4glitTczB5qIecRo/ddv6TpR+6WmD+/T6wg41VgL+XOOvfAzXsvNz5p1P/d0oC70U87JlQAPFSmd4w1p06kdatSJ+tOyNzxitFTBDhbdEju/wRSiLjUbQRC7J2wXj2aBVEyMp4bNNdpq0OUFpYV/Asrpi+E0CDHEaQJh0FhQN77dz4xdaDvmFzsoHNy+i4nainvUYNalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TIQqIMaRwyvk6MHoocSzdXOVclkMZY8/OH/BOV2mvM=;
 b=T/0eL6Y7GE2B0yh0Wr1jv0ZFp0yUosP2EgBnzmQanUupXsye4QfWgEviYRoGY1H2L7jipaZgED3t2tOOXVKQYQvf2Ts2R+kTyWBVONRDGQPNUIQuYpYPd5Azjzi5udMjddLjqWhFuDVyRFvwCHA7kOwt/xI0Hldw7YBRnRnVz8u+8FMKylnOyOa86HSsfMaT2RjytresJj0wbrhg+XEeiJP1amFHaie+OAs1KUWcnMr3gpXzIWytGus1MymBLVd/ONXMn88cTiwW0JExPs6xAOJ1rCJq4t5u40fZdajw1GgQP5IXeyJEyD3nbx4SXd6cJHAzngpgqQvLDJHWap8xMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TIQqIMaRwyvk6MHoocSzdXOVclkMZY8/OH/BOV2mvM=;
 b=oqQFTV0c03KR5ZpDOnLOPkqKf5LJ0rPeNifHs6Qf9e5qE9Y/BAI5u7DUE/7s1hyFmBZTv/Hvg1N8ZQlt42hI2YfEcCGRpcey+8Ew1RgGvwQuPBBFoMdBitJbTRn4QqJAQp6Q/GME29RgaEjS/DNAte+i6gMTejpUZNU9n8tK0eQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH0PR04MB7906.namprd04.prod.outlook.com (2603:10b6:610:ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 04:17:02 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 04:17:02 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/7] md/rc: add _md_atomics_test
Thread-Topic: [PATCH blktests 2/7] md/rc: add _md_atomics_test
Thread-Index: AQHcI8u5xqB/A3wrgkaoWOiXJHt8SrSYXpKA
Date: Thu, 18 Sep 2025 04:17:01 +0000
Message-ID: <lraho55tl3vglno2cpcackn2s6fwirhbyzbtjj3tdwij4z7yav@ka6oyi2p4ohr>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <20250912095729.2281934-3-john.g.garry@oracle.com>
In-Reply-To: <20250912095729.2281934-3-john.g.garry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH0PR04MB7906:EE_
x-ms-office365-filtering-correlation-id: 9afd301d-6678-47a0-bd27-08ddf66a37c9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?M+8Noa5U9pfoMsXN9i0wZxu0dnpKu6QNLe16AuZhAQzd2oJgloghKcEKhfVL?=
 =?us-ascii?Q?tEbSrGDAK+g2rKOAmTjmbiXUAvJrwVo8CXldt0+67T5a7RhnufzspiZAFDwd?=
 =?us-ascii?Q?0Rg1YBoSj4vCUk66pJ05FKN7Mht+WCCGtNRR0dxmC1cZKt44kKvYvlaumlys?=
 =?us-ascii?Q?GK4Xv57Wwkz24rt2eeMnua00ltB057iHDsu4JFr0zcXIPri/YmhZzC7xxy0A?=
 =?us-ascii?Q?2CWqTayaeMfZtQpqexA5dq0OjdwQqWlW8Z81pSSv+htz6YORSPuGjGtPifwr?=
 =?us-ascii?Q?l1EYMCmybsLUy11yUdJcEp2FpOZm5wFRivigshVfWkp+NAu0Cgu1mQlGXCFQ?=
 =?us-ascii?Q?CRFE6IIVpmdxB5AtebwwSkTBbUMr0Wi+D2g+PzQ6K/CguN1mElBSRP2JxKWp?=
 =?us-ascii?Q?1CKiPrl3EWd/OXvda5ZnfjP7MfrpCKYqIllhs5lracSMI5GITeCeCwWCTUjr?=
 =?us-ascii?Q?46sQ3YDhVKJCH/C/tCdAY/TnMxJu00jO3Awqz1cq9ojRwyDhj/TUQWCzC1+R?=
 =?us-ascii?Q?+LjEEKDKP2rXMO9fqkZR66SXfAO7sX9MwSLvSiEcfSdMqkJ9hfpuZFaA8ExW?=
 =?us-ascii?Q?5FEFMBRKTCwlKll7ScXckXVbWh/jUcDIGA0hsHIj6v90IllDuzkt1ha4cUDJ?=
 =?us-ascii?Q?J68rx0hKmcy+A1a7LIZw9fKRfjm4imAdMd5pvyfrKBF44dXHK1BrTJb9F47p?=
 =?us-ascii?Q?laOskgcVHtRDsmZE8zB5C31g9KzsW4CWHDLa+VutBdUKqq50D9nrkJoVypbJ?=
 =?us-ascii?Q?7GdJ+XGTG2Coah/AySzr3bdtNSM4f2zSISX+PioA8uaSLzUmgzVJar/lTvUL?=
 =?us-ascii?Q?930GHJQDZbj/YzdHM1xTfgDFxGf+2BOrccqtEyjzUVxLSjWgz/vbyPlTUa/W?=
 =?us-ascii?Q?TZu7dNSCexv4LeymmCgTftZtB7h2Ly3wqiuhhYgAw1H6uImtCkcx8CpDRHL9?=
 =?us-ascii?Q?4mC6wACcuHbSMRbdd0qHlDKbwQo4rrDKGuiyvynRESM2wl1hGcd/FGnbXtCO?=
 =?us-ascii?Q?yN5XxtkxJaxK0XWNzBH2zHvpbdgZAEmqTXOQ7Dk0LewK+n2Ub+8usr85eF6A?=
 =?us-ascii?Q?jRK0WEfLC+ujnTsysEqZZ6WwkLBkOH6QyF/wJsS8XcMbeacuRIfbBYVDi0ow?=
 =?us-ascii?Q?6dQI/2N/tdFRoQzhLmUcIS0u0YPlboaxBE07m9QZZggnIG5mpMZ3gGHot+vt?=
 =?us-ascii?Q?2/DBUsDaZmooCLJY3WLGiiUm4XOtjlb4XuvFXFY5h2q7dqNefHNcfloSoMf+?=
 =?us-ascii?Q?xh1BPsJS5bVHGiR6VkMy60Zbd+0za3hbRG+EEWHwQOMedqsDWms5GBQ24BEP?=
 =?us-ascii?Q?tkBAjwoMe3cy/V3InTvvN+gSyXNeIeantllxFhLHr4p4T6aSpHRiwRMz75Og?=
 =?us-ascii?Q?/kATRhFt+gRIp6acsOhu0EegxfUs672FXFkqDGJCiVBozdpopPchcuQUMNcV?=
 =?us-ascii?Q?pNh2KvSDDzNP2xTYbmshBcR9TvB/g9H4TlagdSyQgF9751d1Uo7U1g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZKebUumHoG827o8chmcxbRiaJGS2bHvX07GlzT0pEXSmmxL7cUH33SxU8Up6?=
 =?us-ascii?Q?cjXsaDzajhedtEBW7bPfPGvXCjnzxTdlDngcBoe3pebc2E+s3HYKUs/dJMxi?=
 =?us-ascii?Q?HFthAYU460Xnxxp4Zd37JXBwk/qjYXzhUfhlxzVzgdnIlAb4xEaYe7J0XfNl?=
 =?us-ascii?Q?QslqJVn7jCNxidFyvUa2KDvUt07d7biK2NHtINAKbecXxoDxxOqIjEw+vKL/?=
 =?us-ascii?Q?VxKs77LbZNHPR/vuSZQ3Ny1xSn9mkme75tboneO0QX75H/ehq0mwa5UTL9/G?=
 =?us-ascii?Q?4gWW9mZlZAyrdWi1diFsjvzmLNAd2hfJAekQc6UT+J7KA6ZnOxP41Ik50ASm?=
 =?us-ascii?Q?feMtIBR9L+uy4R8neIgMxcz4KqNyJhjyMjY+7Rt/RHyLjWq2bDMKCMVPDfnA?=
 =?us-ascii?Q?L4aFTo+czXT/kc3d93vshfhqziPu9US9EOqjy0Jx3WLmzFTFQn6cbFkQ6Zf3?=
 =?us-ascii?Q?iv5+AJw6dA9DVgGCFOFQXxSt+EIRiJCsklrMZ3Qfzc2m6qBLsThuXJ5CGpmp?=
 =?us-ascii?Q?QFlX4JxwXfBKfucTHSxg/OF1d7meMM/W8Af4ZARoRyITR1ZTp4bL4BXAajv1?=
 =?us-ascii?Q?FGH+35lpSMxvwKp6Zm8ClwGpHmXXletRW2WJ68+toc4k3bzIfV24n3WyXwho?=
 =?us-ascii?Q?vbUA7p5SWjer15oKBDYQ/undlojR69yVJExgKBNuSCpMo/jdzZxgjkbpROn2?=
 =?us-ascii?Q?Bi5zbYOpuSEXN7RKAYrAG4xjtAIOJJrOqEEV1rZj9YQThFIh7IUixFF51eqZ?=
 =?us-ascii?Q?h9CW/FmvqOxMFB/UGrYbyyHJ9exCNd2BJIlUEYXV/1TawEIt2kEyPZJPnKOc?=
 =?us-ascii?Q?6KhPAzm6z0FPIuoAhAaeepR7gd2HriBoEv7JUPN1wQkLUv3hmrLB2Rh0j4JE?=
 =?us-ascii?Q?heH7G8Fxl+Fb8ITqKPw3VnPg4qG9N4NfGrKVxW5ZXaxb5IYfDS6uQtSgMYNI?=
 =?us-ascii?Q?hQ5DJVGhrEl3xXmGryyra4WN+ECOdEvFBs3sD9XQqNVPRsm8XSKfY864qI3M?=
 =?us-ascii?Q?OE21WsVBzf9D666VJZeCW+OyKqQ6viO2c4ytC9nbTYxW7blJWomku5COcVgD?=
 =?us-ascii?Q?xM5G0ZXq6lafe3Tr8CFpYwuSKqmioRXhSTpGXW9Eu1SMOlPCXkmQmy2WVhTh?=
 =?us-ascii?Q?W2GDSvREwpDU+sS8IDWkLoZ+ABf/zjIddpo2y7smwtplYmIQwFEPOR/0Impy?=
 =?us-ascii?Q?nKc/994MJr7q5sJ2UaNi9KwuP70D4j+GFY3Dnc5dp7UAzs9Sr9hSSjyYP4xg?=
 =?us-ascii?Q?FNfSwjOua+eUIKyrw/ccCdMl53SoZCw5td3GGLJU7ruWUft4O52gBTGyBJ8g?=
 =?us-ascii?Q?MIX01ZFiJsxk7KwHLnoTfh84tlsM5CRJ4kiJyNac0/xZ330jwN/O2X5HKVLS?=
 =?us-ascii?Q?aaDAgsV+On2Ga7rUXKNzdyBDaNEJ8A92SmlTDUIf/sCrXXqwNDdQPw3S3KzX?=
 =?us-ascii?Q?G0PoSah34Z59/p7yg+wPhrXN4xoUNHaSB1nj5xDXYAl7WNvtskH8288I7TXC?=
 =?us-ascii?Q?dzHoCnxcG23ymke16+yLhGMUWjnXEMhU/atUD+UjhYpHcoYP1XVH25+fH1AG?=
 =?us-ascii?Q?e3FTyXVfYRyGa+N2d8jWi5HwKrIRdqh/YxTmtYnt5J8tl9H6yhNpBJVclBfm?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0682E6FB914C5945AEE44DCEEB56BEED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4TGQFSuEwvdwycvumRyR+aBQQ4OAgk9Wb3yuryCa+TsVNwNJ+b6deMwwvS1de/7ALnl+MutFKAxLM/HNiWGS9FYfd/2Jxn41PajJDyviUMRI5MkzuvcAxbNLCVt2l80Za9DstRl9OHBR+8QrKnIJGAWRzQjSYZj/5AGDAqqO/FvD0iVJrdym2K2tNqrHGm0VIGL7aNvjyCV14gwMahKxwM6UwmwjFeVUVhImGtcJsE483hcBaGittJKP1H3nAQzghCbWCUIpxdZGHtMGUBUxfVxF6zzt2V0WF3D6hut+6YBtKlkqo5MKE/KYOWN3geNVcpZQZzarKBr1q0wJt15FW9jpciagi/2iv2FHTu9LNSUBTyENprmoT/0KYVxKbzuQDxxdjS4cuFWsDU/Fpz5piTGR38YxbfKS6K2iATLlPUj0WOikW0HyLMIW3ENX2uml5hv8eUXDIS0ZjLdMATNzcNoVWmIPQ2skI3monKwDt/LVOjZSORiLQ89xNzGRWcbzGTaTNt6SGxtNhFncWlLEt1CX3ndDFF9a/2h5BzYKHExI/ii2UgDZMMhGyEnKxWSEMQDwc8G06RYE54tJS4KE2+KiXBIZYRsUO094DF4IUy67PyHhO1gh9LFG8LHh/BRE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afd301d-6678-47a0-bd27-08ddf66a37c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 04:17:01.9373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sw5wq6nzK1f8FCP1h5nlHGUFZ50/Q6gihCjXH9PmNEHirZCWqaDyodseHB3DXQwMosbfURFwaVxmM7Jkb5pXCRJw8JPnrJWEGfk7xdM42L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7906

On Sep 12, 2025 / 09:57, John Garry wrote:
> The stacked device atomic writes testing is currently limited.
>=20
> md/002 currently only tests scsi_debug. SCSI does not support atomic
> boundaries, so it would be nice to test NVMe (which does support them).
>=20
> Furthermore, the testing in md/002 for chunk boundaries is very limited,
> in that we test once one boundary value. Indeed, for RAID0 and RAID10, a
> boundary should always be set for testing.
>=20
> Finally, md/002 only tests md RAID0/1/10. In future we will also want to
> test the following stacked device personalities which support atomic
> writes:
> - md-linear (being upstreamed)
> - dm-linear
> - dm-stripe
> - dm-mirror
>=20
> To solve all those problems, add a generic test handler,
> _md_atomics_test(). This can be extended for more extensive testing.
>=20
> This test handler will accept a group of devices and test as follows:
> a. calculate expected atomic write limits based on device limits
> b. Take results from a., and refine expected limits based on any chunk
>    size
> c. loop through creating a stacked device for different chunk size. We lo=
op
>    once for any personality which does not have a chunk size, e.g. RAID1
> d. test sysfs and statx limits vs what is calculated in a. and b.
> e. test RWF_ATOMIC is accepted or rejected as expected
>=20
> Steps c, d, and e are really same as md/002.
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  tests/md/rc | 372 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 372 insertions(+)
>=20
> diff --git a/tests/md/rc b/tests/md/rc
> index 96bcd97..105d283 100644
> --- a/tests/md/rc
> +++ b/tests/md/rc
> @@ -5,9 +5,381 @@
>  # Tests for md raid
> =20
>  . common/rc
> +. common/xfs
> =20
>  group_requires() {
> +	_have_kver 6 14 0
>  	_have_root
>  	_have_program mdadm
> +	_have_xfs_io_atomic_write

I don't think either "_have_kver 6 14 0" or "_have_xfs_io_atomic_write" is
required for md/001. I suggest to introduce a new helper,

 _stacked_atomic_test_requires() {
     _have_kver 6 14 0
     _have_xfs_io_atomic_write
 }

and call it from requires() of md/002 and md/003.

> +	_have_driver raid0
> +	_have_driver raid1
> +	_have_driver raid10
>  	_have_driver md-mod
>  }
> +
> +declare -A MD_DEVICES
> +
> +_max_pow_of_two_factor() {
> +	part1=3D$1
> +	part2=3D-$1
> +	retval=3D$(($part1 & $part2))

Nit: "local" declarations are missing for part1, part2 and retval.
Same comment for some other local variables introduced by this patch.

> +	echo "$retval"
> +}
> +
> +# Find max atomic size given a boundary and chunk size
> +# @unit is set if we want atomic write "unit" size, i.e power-of-2
> +# @chunk must be > 0
> +_md_atomics_boundaries_max() {
> +	boundary=3D$1
> +	chunk=3D$2
> +	unit=3D$3
> +
> +	if [ "$boundary" -eq 0 ]
> +	then
> +		if [ "$unit" -eq 1 ]
> +		then
> +			retval=3D$(_max_pow_of_two_factor $chunk)
> +			echo "$retval"
> +			return 1
> +		fi
> +
> +		echo "$chunk"
> +		return 1

When bash functions return non-zero value, it implies the functions failed.
When this function returns 1 at the line above, does it indicate failure?
It looks echoing back a good number, so I guess just "return" is more
appropriate. Same comment for other "return 1" in this function.

> +	fi
> +
> +	# boundary is always a power-of-2
> +	if [ "$boundary" -eq "$chunk" ]
> +	then
> +		echo "$boundary"
> +		return 1
> +	fi
> +
> +	if [ "$boundary" -gt "$chunk" ]
> +	then
> +		if (( $boundary % $chunk =3D=3D 0))
> +		then
> +			if [ "$unit" -eq 1 ]
> +			then
> +				retval=3D$(_max_pow_of_two_factor $chunk)
> +				echo "$retval"
> +				return 1
> +			fi
> +			echo "$chunk"
> +			return 1
> +		fi
> +		echo "0"
> +		return 1
> +	fi
> +
> +	if (( $chunk % $boundary =3D=3D 0))
> +	then
> +		echo "$boundary"
> +		return 1
> +	fi
> +
> +	echo "0"
> +}=
