Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79536227BB9;
	Mon, 10 Mar 2025 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613865; cv=fail; b=RmFAW8C6PO+xgWHuqZdb05q4d2Vclv+Iu1z2fpVLv+gGRj9+c1dbFiHgKTkvF0uMGp60faqGylsA9YNQtBAaHABQh7LBhq/s3+c1Q6FnOE0UAdmlyLHEK5W0BFhcchkpmLKKq1u9DptNbyACqGuGqhQTWFaU0DJ9/yjHwYBzyuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613865; c=relaxed/simple;
	bh=f0B1OJAm9WTQmdSulvGh8EgEHtwAdeXLHvD7S2BjM5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lo2NHkb0l/XFnBQJkDJOtt3ABzlRMoRZ5Ydx1EEGFMCcawsTTNCLqQ1AqTet//xbec8uIf6paoZHGUSupx8wXd1fnT/+jW+SY/Tui0bAml1AVDHh49JzfdUZ1CFVfy6vj8iJaGKY0P2ye7NgExOQSIxB+//Eu3lJ4XXfVCTgdaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XNIiaHK6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=IhkTZ3qP; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XNIiaHK6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IhkTZ3qP"
X-UUID: b8758d3efdb211ef8eb9c36241bbb6fb-20250310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=f0B1OJAm9WTQmdSulvGh8EgEHtwAdeXLHvD7S2BjM5c=;
	b=XNIiaHK6Rfu0iqAFyGKwCpzAKvGTuWcrAJL6b+njyARp9/7SFhtL822L7FOGRP08gvq5K45NN62VoLZlwaVHyMDkdqTfERbPPiG9GPC0yWhh0xs622khSbG3HikGS80qMqXZYaBiU82q3XXfiHfEBW5i2GajygPI4TQIFJ0ncjU=;
X-CID-CACHE: Type:Local,Time:202503102121+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:e50931a4-ed4b-4412-acce-58aa9c868dee,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:fc88eb49-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b8758d3efdb211ef8eb9c36241bbb6fb-20250310
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <qun-wei.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2070883714; Mon, 10 Mar 2025 21:22:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 10 Mar 2025 21:22:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 10 Mar 2025 21:22:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vb3laie2FHTd4jnsS9LUAq0o4P9UMIH5EKNKPBgifTkniCjzNWngEPAbbPYpKbEg1PWk1zu931u3DuQTqYzHFGGVyVVLCyHsfkt6XPswrko9odMjPcZo5V6zFEtJ0zHMQz41X0rXVqmRss6aZljQXApdjXlvVmIEm8Q5+b/9wjhpSibJSD0wwN4nv/9d2xePXtspx4jiJnIIjiOxl4g6/LiMB+oO2KA++J/E0BL4691ed5Wv0XMOM3xjz4MS2CT1UOi30ekYnXnJP08ZtSLJaLvole2bHa9+L85A41/SXYBfOX6ZmJoOPX0tnFyxXhXiUrmKO1/niRHP64uqaa5J3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0B1OJAm9WTQmdSulvGh8EgEHtwAdeXLHvD7S2BjM5c=;
 b=Y4lAxxh8Mwr1Qy/JcI0Fa/3Uk/yM0rhMC+SMtyESOl1KZ1GtLMz+TiL+pziqGNgcbDs8pFBvPWnEQlOioLADm9iCDl6O1G+OSTWfmRsWGb7Jow9SflMDwdpygd6WAQE/FigpZOQCagQa8buu8X1O0ylDTgffhuawxelamf/VWXisN2jEu9BAmUVf5r8vMQyp0FfEaaz2xr3vPDd1b1ft5SEItvrNqShpkgMTmxr15tTS6/op40ycSn4Js0lShwT1ChNR/PEUrMQWqi3XG1MfS84i1OWK6lyugFrybE96SN0xrF3l7nSimha6dRW34r7ck5mj0XiPrImucShGYX9d2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0B1OJAm9WTQmdSulvGh8EgEHtwAdeXLHvD7S2BjM5c=;
 b=IhkTZ3qPFegBBdUukvWIljp6lJN15f2c93A6v5AXSlVzvXMg8zfhkoz2V9CI1GkZvdzcRDWrmfdMvtLCR41d2x7CKCWq5DScGEkbqdHhxy4UNFA7wbAGtVJRejL20f8nOxgzqJv3oAQ3euLBesvvecZGLYa4PRX2hGZ6mfO9crg=
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12)
 by PUZPR03MB7042.apcprd03.prod.outlook.com (2603:1096:301:11d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 13:22:27 +0000
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02]) by PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 13:22:26 +0000
From: =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>
To: "21cnbao@gmail.com" <21cnbao@gmail.com>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>
CC: =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
	=?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
	"chrisl@kernel.org" <chrisl@kernel.org>,
	=?utf-8?B?SmFtZXMgSHN1ICjlvpDmhbbolrAp?= <James.Hsu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"schatzberg.dan@gmail.com" <schatzberg.dan@gmail.com>,
	=?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
	<chinwen.chang@mediatek.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"minchan@kernel.org" <minchan@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "kasong@tencent.com" <kasong@tencent.com>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "ying.huang@intel.com"
	<ying.huang@intel.com>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
Subject: Re: [PATCH 0/2] Improve Zram by separating compression context from
 kswapd
Thread-Topic: [PATCH 0/2] Improve Zram by separating compression context from
 kswapd
Thread-Index: AQHbj1ja3HBtEsnk0kq5WQ+MAj7gkbNoS5sAgABvMoCAA6VvAA==
Date: Mon, 10 Mar 2025 13:22:26 +0000
Message-ID: <52896654fa07a685707b11cfcc141b038a13b649.camel@mediatek.com>
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
	 <CAKEwX=NfKrisQL-DBcNxBwK2ErK-u=MSzHNpETcuWWNBh9s9Bg@mail.gmail.com>
	 <CAGsJ_4ysL1xV=902oNM3vBfianF6F_iqDgyck6DGzFrZCtOprw@mail.gmail.com>
In-Reply-To: <CAGsJ_4ysL1xV=902oNM3vBfianF6F_iqDgyck6DGzFrZCtOprw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5542:EE_|PUZPR03MB7042:EE_
x-ms-office365-filtering-correlation-id: 462890ef-6554-4a48-a33f-08dd5fd69a16
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TE5LL2cxMTlHSmI0bng1SWhzWFpVampMcmVrSHE3K1IvNXpGSmlOSFVDSmpF?=
 =?utf-8?B?bjJzTFhTQU9kZWZZNzhuWUF2QkV5NFc2ZW5Za3JPTUh0Y1JZeDIrZVJXM3l5?=
 =?utf-8?B?Vm45RHY1blRxWVZtNTg1Y2QxUE8rQ3YySmV0N1d0WTB4Y3ZjOEl4NVBGOCtq?=
 =?utf-8?B?aUxzY210VHo5aVZsTklBSWpNZytmZERXZWdKT290MFc3d3hzeVI2eHVnRUFC?=
 =?utf-8?B?UlA1VGhYQzZhdFhtY2ZTSjgrS0FaaldMZHBFSFAycVpFY2NpNG9VdjJjOXNI?=
 =?utf-8?B?Rkp0UHUvb1VUMHFJTmg3QjZMdlAvSzNLRTFPajkyQkhHYjZKWm5kQk5Ya1pK?=
 =?utf-8?B?VkszSkFjVUFzekI0dVZxeDcvTXFIeXJTODI5bWtkVXdBTjdqQVpCakd6bEVi?=
 =?utf-8?B?eCtsMmFJMmo3NW0rSUxHdERXdWx4T1ZwZTRwcGI3QnBsVC92MFl3V2VyaDg0?=
 =?utf-8?B?TnRIOTZhTzJIMzA2cjNLb3FHSHhtTkFLVm1jSzFMOHBQWnJwb1J0UU4wZTRT?=
 =?utf-8?B?ZndrbTZvV2cvN2dmdUNFTE1nRk0xd3U3Y1Q1VDRYalJsMDVhVlM0L0diVTlF?=
 =?utf-8?B?ZFNZTTA2eWlBZjRmSnRjMnJKZWdZVS9lRktNaS9RdGJ5aTFmQjVQMXdwdDZO?=
 =?utf-8?B?NGxNZXlkekVJOFowNU9LemVqN1ZpYmF5MHdHdExzRXdpNEluVjFGOHNCS1h3?=
 =?utf-8?B?VmZHUHNvVHRGVStPdnh6ZS90VzhnRzBvbm50ck40OHdRUENFYnVYb3d4bXNS?=
 =?utf-8?B?YmhHRTdqbUlINUlRbjNLRXp2andBZFRBUEhaSXEzTEhBc250ZTFTNlMydzNy?=
 =?utf-8?B?OEk5Z3BQZGhkQWpGb00ra0RuNXZKelQwQjN0bU80bWdxUnFsSlJFZnJzL3pY?=
 =?utf-8?B?eVV5KzJKYW91Qkk0c1dSVlRRbHdvd3VVTStKTndSQmN6MzdiVWF0SVJmZi9S?=
 =?utf-8?B?WFFzT1FlTGJXeGJqQXhGaG1tdzdvTmhISnpsbklIa2hzb3A2dmlCcDAwYmhT?=
 =?utf-8?B?a2g1c04xUExBSnpBYjVOdUZkZ1lENE9sNTlUQUNUQ0RGdXNiOHBaZXVpdGZ1?=
 =?utf-8?B?UUh0VmliL3d0cXc4cXg2V3dMRVcxR2lJRnlQcExXOU1QdHA2cUI3M2NyVWEw?=
 =?utf-8?B?TGhNNUVKamorYXJ0cHNEQzNzc05YaUowTVY0bkk0L2JHSXByVzMwendLR2Rx?=
 =?utf-8?B?ZjhUOUdCMmJkNU1aS05XR1JFNk96LzVvbjl3TG1zSE9jZTJaWERvQ0t6c2NS?=
 =?utf-8?B?ampxV3hROUVhUHNJWFdVSHhuTm02cUNLWlZ1blVUeXpwYUJyaFdwT1FiT0Nx?=
 =?utf-8?B?b0JUdE9UYkRaWS9RcU9YUkNvSHBuVVBBd25ZUjk0Z21oclB3ZXZYLytxT3k1?=
 =?utf-8?B?YnNyRmVPQldxWTJTbzhsY0Q3K2xNV21IWDF4c1JCTUlNT0Zxb2JZUjRPNE9Y?=
 =?utf-8?B?RWdCS2FRRVd6YW5kc0NzQk9yQkJqTTc5Vi9VRytYdGR2RFdoajhHNVRBbVM5?=
 =?utf-8?B?b0doU2tVNWxNZXY4VnpyUVp4ZE1veWdMaE1KSndaMnB2R0Nuc2lzUS9BTE1r?=
 =?utf-8?B?VmpiVTFhMjdQbzFlMGRTMDhxcE45S1hNbmdwaFMzWDFuNis4Tkt6WE1YV0lG?=
 =?utf-8?B?R3ZZMGpzaS9mejNVSWFBVDVCOWdtQlZrVVRSMThrZ2Z5QklMZkpOeURSUWVt?=
 =?utf-8?B?YUVKV0Q4S0pncWNUU1JZSnRZU1pHQTBzcWNjZEVmdTFWWHdUb0NwbWh3V0M2?=
 =?utf-8?B?SlZ2WkpmV040OHdiRlpCK2NRZG1lc1lkVjFIaU5CeDhoSmFBSkxLMlRUajNZ?=
 =?utf-8?B?MDEyWHZVUFAvUlZ4TXpCYXBjRy9HWE1qdUJFSE5LWGJWWWZub2wrY3kxYjBW?=
 =?utf-8?B?NjRJYjlsMEd0S0dJeHIydUwrSDZkTFVxb0tTUXVoYXFqQVVicGlwbHZQelRG?=
 =?utf-8?Q?oS3l0qJUZZlHmqezBV9ICckmDFHocbdW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5542.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmpPRmowNGRCTVpwelpZc0E5SW1tZ1lPSTBLekZuSnNTOWJFR0dtU3FBalJH?=
 =?utf-8?B?SmtwUFcwYzRlM0w2YmI1TnZCS0htT2VXUVd0aG5Qa3FKKzVuUDBjTjR5OWFZ?=
 =?utf-8?B?L1ZTMFhON2tnZG5DbjI3UG9RRGl3a2hrODRvai9QUG56ZTFGVFlicjc0R0w2?=
 =?utf-8?B?M09IM0ZWdURldTR4K1NwVzdWUUhPOEdueFk3bVlBckhUSTh3SjZ6RjJ3anMz?=
 =?utf-8?B?Z25pVTJnVjViNVluZXRiaVRzaUFEQllOYm1nV3pYUWduT0U5RExIdnQ2Z1BT?=
 =?utf-8?B?TmdBTFo3cW83ejQxZmU5eW9MMlFkTEt4aU5TRnc5d2FHNEVnUWlHdU1jbGhm?=
 =?utf-8?B?dXNJc3BZelNuWS8zQUdxNkdmWVFyNTJxM0JoV1JQNXl6NnIyR1l0MlBldk9X?=
 =?utf-8?B?MndEYjJJTTNpamk0VW5FTFc4UUp0bjhyUHExdGNCR0RIZUFQaDBydHpLY29H?=
 =?utf-8?B?WDQrQk1RVUFkQXFyRkt2ampDTHcrdUJreXYyM0h1Wm9TczIyVkF1dXpLV0NZ?=
 =?utf-8?B?YzVwdmFZWUNUSzQzeGNNV1VoOEtSNXcwRGNCMmFQK01YMGhVUVY5SnpXT2dU?=
 =?utf-8?B?SHFEak1KZysxME1UNFN1UWZyQldqNGl4OXhqdWdJckxUNkhnT1Fhd3Z0WUNv?=
 =?utf-8?B?M1dDNExHODRCTFByYmc0bjdMOXNXUHF5MEVUSXNVNmlTTFBDWmNZV1g2cTFL?=
 =?utf-8?B?YTRMSTNHdDdMUlM2V2libkNaUkxYNTFDaGtXRnBPdGNvcUhUVlNrRjRacDdw?=
 =?utf-8?B?NnhielNHcmZCeVdaQTZyN29CU3hHY0Y0OFJXT0pmV3N4aUltaE4xL3ozdmkr?=
 =?utf-8?B?NVRvNTVnK1lISUJGc0lva1BuT1dSU1UzSU16WndoQkxBNUcrVG5ISFo1N2Z1?=
 =?utf-8?B?MThuU3o4aEYrWGdoMTdGV2lDMXphNjgrT2o5L2llU29lV0Y2YXhrZ1RHZDVD?=
 =?utf-8?B?RzVva0NhZFM5bDhyRHY3VGRVZXl2VUY5cWhiYW1TQkhTbDJNc0I2bnlaeWR3?=
 =?utf-8?B?czQ1U09QQVBYK0xyaTlwWGZyekpSRTVvZHo1bDZOTTdlMEFNVW91TjloR1hV?=
 =?utf-8?B?KzltRUo5VGRvWWNtRklURHlML3B0SG5MR3BIRTBDN2VPU011a3lYOXpFK0Nx?=
 =?utf-8?B?V2pDZW9KQ0pDWGVibW5lQ3Q4b3N6OTluY2ZoVHVUN0xkaVpQYXI5YjU3b0hR?=
 =?utf-8?B?NXdMVlY5OFdna3FKL1BaWVBDTFUyeWx6aW9rVVFDdDJ2ZVpycnp5USt5NFhL?=
 =?utf-8?B?UFE0ZGg1Z081NjJ5c0R1ZFFZODNxTUVLV0FsQS9GOXZ3VXIvYzNFWHFpcEtI?=
 =?utf-8?B?ZVZEamMvRkJPeVFvdW1MWit5aWNyNHNwaFdmYzAwUU1yY0FxU3lUdUUvNkZI?=
 =?utf-8?B?eWpZc3lTZXNXUmlUV1h1L3h5THRsTlBRN1NaZHhKZGI3RjJLU1RiOWFTWmda?=
 =?utf-8?B?azNUaVJEb2ZrdGM0dHJXNTBaTTdZdUxHSi9ZWVhWYTBET0ROeHVkTU1NSk55?=
 =?utf-8?B?K29uT1Z2TCswMkZpMzhreGhOQjVxOHI3WEZsN3lYaVo5dlZnZ1pWUExPZFlX?=
 =?utf-8?B?dFdvN09oTmJBY0Q3OURjelVaUHNvSVFRLy9hWTBGZTNzak5kU3c4RmIxQXRo?=
 =?utf-8?B?bUlIalF3V2VvNC9jYWdrSFVZYmdlSzZjcDgvbll5VVhlaGJxbmxyd0lRWGo0?=
 =?utf-8?B?QnlYRWl2QTRlblA0ZnhJL1VFUWpVNlZQVjlDRzZ1REN1L09hWVhRZEQ2eEw1?=
 =?utf-8?B?MjlNTFAyVTFyalhBT2Rxc1BtWXlGRVlsM1JwSmxnM0QxUXVrSTc0ZklGaU1r?=
 =?utf-8?B?YTA2aERvbUpxTFVYR09QeDBnNGhXcHNma0RUN3hVMENyMUNXVVVydXVBVjJX?=
 =?utf-8?B?L3VzVlpyMXc0MmFFWURacEM4cnc5eXcvSzd5NE5rdThrYjhRbXM4VHZHN2FY?=
 =?utf-8?B?MXFmamlNb2dhRm4yQ0twVHRrU05IMHlBRVNVRFZFT05VWEFlSVRUS096aEd6?=
 =?utf-8?B?dVc4WW8vTGFpa21uY2xQck1sSVI5WDV4MjBJa3FheGgxcGZ3blJNa0tIT3hl?=
 =?utf-8?B?MXpCRnpHSXdUU212aElFR2FXTUFoYnZybHlYY0J0bE1OWTY5UUU1SG9DQ2Z5?=
 =?utf-8?B?OTVFTmREeVk5dDMwcUo0YzhKNzlCNHkrc1ZEMXNGL3FIQnB3aktBbFhDamJl?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <510D9D32C5B7AC4CB154EC181A37B410@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5542.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462890ef-6554-4a48-a33f-08dd5fd69a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 13:22:26.9150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/MOa7mO0x4d34i24ZR/zY8ZnDR/3NSAT9xwyg0Jh6BRAKyKDCqcRjWmeUDQptKD9aE+auDxdmdHarx5Yd0qN8/rgmF+uqu9BTpJrwDvp+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7042

T24gU2F0LCAyMDI1LTAzLTA4IGF0IDE4OjQxICsxMzAwLCBCYXJyeSBTb25nIHdyb3RlOg0KPiAN
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29u
dGVudC4NCj4gDQo+IA0KPiBPbiBTYXQsIE1hciA4LCAyMDI1IGF0IDEyOjAz4oCvUE0gTmhhdCBQ
aGFtIDxucGhhbWNzQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gRnJpLCBNYXIgNywg
MjAyNSBhdCA0OjAy4oCvQU0gUXVuLVdlaSBMaW4NCj4gPiA8cXVuLXdlaS5saW5AbWVkaWF0ZWsu
Y29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyBh
IG5ldyBtZWNoYW5pc20gY2FsbGVkIGtjb21wcmVzc2QgdG8NCj4gPiA+IGltcHJvdmUgdGhlIGVm
ZmljaWVuY3kgb2YgbWVtb3J5IHJlY2xhaW1pbmcgaW4gdGhlIG9wZXJhdGluZw0KPiA+ID4gc3lz
dGVtLiBUaGUNCj4gPiA+IG1haW4gZ29hbCBpcyB0byBzZXBhcmF0ZSB0aGUgdGFza3Mgb2YgcGFn
ZSBzY2FubmluZyBhbmQgcGFnZQ0KPiA+ID4gY29tcHJlc3Npb24NCj4gPiA+IGludG8gZGlzdGlu
Y3QgcHJvY2Vzc2VzIG9yIHRocmVhZHMsIHRoZXJlYnkgcmVkdWNpbmcgdGhlIGxvYWQgb24NCj4g
PiA+IHRoZQ0KPiA+ID4ga3N3YXBkIHRocmVhZCBhbmQgZW5oYW5jaW5nIG92ZXJhbGwgc3lzdGVt
IHBlcmZvcm1hbmNlIHVuZGVyIGhpZ2gNCj4gPiA+IG1lbW9yeQ0KPiA+ID4gcHJlc3N1cmUgY29u
ZGl0aW9ucy4NCj4gPiANCj4gPiBQbGVhc2UgZXhjdXNlIG15IGlnbm9yYW5jZSwgYnV0IGZyb20g
eW91ciBjb3ZlciBsZXR0ZXIgSSBzdGlsbA0KPiA+IGRvbid0DQo+ID4gcXVpdGUgZ2V0IHdoYXQg
aXMgdGhlIHByb2JsZW0gaGVyZT8gQW5kIGhvdyB3b3VsZCBkZWNvdXBsZQ0KPiA+IGNvbXByZXNz
aW9uDQo+ID4gYW5kIHNjYW5uaW5nIGhlbHA/DQo+IA0KPiBNeSB1bmRlcnN0YW5kaW5nIGlzIGFz
IGZvbGxvd3M6DQo+IA0KPiBXaGVuIGtzd2FwZCBhdHRlbXB0cyB0byByZWNsYWltIE0gYW5vbnlt
b3VzIGZvbGlvcyBhbmQgTiBmaWxlIGZvbGlvcywNCj4gdGhlIHByb2Nlc3MgaW52b2x2ZXMgdGhl
IGZvbGxvd2luZyBzdGVwczoNCj4gDQo+ICogdDE6IFRpbWUgdG8gc2NhbiBhbmQgdW5tYXAgYW5v
bnltb3VzIGZvbGlvcw0KPiAqIHQyOiBUaW1lIHRvIGNvbXByZXNzIGFub255bW91cyBmb2xpb3MN
Cj4gKiB0MzogVGltZSB0byByZWNsYWltIGZpbGUgZm9saW9zDQo+IA0KPiBDdXJyZW50bHksIHRo
ZXNlIHN0ZXBzIGFyZSBleGVjdXRlZCBzZXF1ZW50aWFsbHksIG1lYW5pbmcgdGhlIHRvdGFsDQo+
IHRpbWUNCj4gcmVxdWlyZWQgdG8gcmVjbGFpbSBNICsgTiBmb2xpb3MgaXMgdDEgKyB0MiArIHQz
Lg0KPiANCj4gSG93ZXZlciwgUXVuLVdlaSdzIHBhdGNoIGVuYWJsZXMgdDEgKyB0MyBhbmQgdDIg
dG8gcnVuIGluIHBhcmFsbGVsLA0KPiByZWR1Y2luZyB0aGUgdG90YWwgdGltZSB0byBtYXgodDEg
KyB0MywgdDIpLiBUaGlzIGxpa2VseSBpbXByb3ZlcyB0aGUNCj4gcmVjbGFtYXRpb24gc3BlZWQs
IHBvdGVudGlhbGx5IHJlZHVjaW5nIGFsbG9jYXRpb24gc3RhbGxzLg0KPiANCj4gSSBkb27igJl0
IGhhdmUgY29uY3JldGUgZGF0YSBvbiB0aGlzLiBEb2VzIFF1bi1XZWkgaGF2ZSBkZXRhaWxlZA0K
PiBwZXJmb3JtYW5jZSBkYXRhPw0KPiANCg0KVGhhbmsgeW91IGZvciB5b3VyIGV4cGxhbmF0aW9u
LiBDb21wYXJlZCB0byB0aGUgb3JpZ2luYWwgc2luZ2xlIGtzd2FwZCwNCndlIGV4cGVjdCB0MSB0
byBoYXZlIGEgc2xpZ2h0IGluY3JlYXNlIGluIHJlLXNjYW4gdGltZS4gSG93ZXZlciwgc2luY2UN
Cm91ciBrY29tcHJlc3NkIGNhbiBmb2N1cyBvbiBjb21wcmVzc2lvbiB0YXNrcyBhbmQgd2UgY2Fu
IGhhdmUgbXVsdGlwbGUNCmtjb21wcmVzc2QgaW5zdGFuY2VzIChrY29tcHJlc3NkMCwga2NvbXBy
ZXNzZDEsIC4uLikgcnVubmluZyBpbg0KcGFyYWxsZWwsIHdlIGFudGljaXBhdGUgdGhhdCB0aGUg
bnVtYmVyIG9mIHRpbWVzIGEgZm9saW8gbmVlZHMgYmUgcmUtDQpzY2FubmVkIHdpbGwgbm90IGJl
IHRvbyBtYW55Lg0KDQpJbiBvdXIgZXhwZXJpbWVudHMsIHdlIGZpeGVkIHRoZSBDUFUgYW5kIERS
QU0gYXQgYSBjZXJ0YWluIGZyZXF1ZW5jeS4NCldlIGNyZWF0ZWQgYSBoaWdoIG1lbW9yeSBwcmVz
c3VyZSBlbnZpcm9tZW50IHVzaW5nIGEgbWVtb3J5IGVhdGVyIGFuZA0KcmVjb3JkZWQgdGhlIGlu
Y3JlYXNlIGluIHBnc3RlYWxfYW5vbiBwZXIgc2Vjb25kLCB3aGljaCB3YXMgYXJvdW5kIDMwMCwN
CjAwMC4gVGhlbiB3ZSBhcHBsaWVkIG91ciBwYXRjaCBhbmQgbWVhc3VyZWQgYWdhaW4sIHRoYXQg
cGdzdGVhbF9hbm9uL3MNCmluY3JlYXNlZCB0byBvdmVyIDgwMCwwMDAuDQoNCj4gPiANCj4gPiA+
IA0KPiA+ID4gUHJvYmxlbToNCj4gPiA+IMKgSW4gdGhlIGN1cnJlbnQgc3lzdGVtLCB0aGUga3N3
YXBkIHRocmVhZCBpcyByZXNwb25zaWJsZSBmb3IgYm90aA0KPiA+ID4gwqBzY2FubmluZyB0aGUg
TFJVIHBhZ2VzIGFuZCBjb21wcmVzc2luZyBwYWdlcyBpbnRvIHRoZSBaUkFNLiBUaGlzDQo+ID4g
PiDCoGNvbWJpbmVkIHJlc3BvbnNpYmlsaXR5IGNhbiBsZWFkIHRvIHNpZ25pZmljYW50IHBlcmZv
cm1hbmNlDQo+ID4gPiBib3R0bGVuZWNrcywNCj4gPiANCj4gPiBXaGF0IGJvdHRsZW5lY2sgYXJl
IHdlIHRhbGtpbmcgYWJvdXQ/IElzIG9uZSBzdGFnZSBzbG93ZXIgdGhhbiB0aGUNCj4gPiBvdGhl
cj8NCj4gPiANCj4gPiA+IMKgZXNwZWNpYWxseSB1bmRlciBoaWdoIG1lbW9yeSBwcmVzc3VyZS4g
VGhlIGtzd2FwZCB0aHJlYWQgYmVjb21lcw0KPiA+ID4gYQ0KPiA+ID4gwqBzaW5nbGUgcG9pbnQg
b2YgY29udGVudGlvbiwgY2F1c2luZyBkZWxheXMgaW4gbWVtb3J5IHJlY2xhaW1pbmcNCj4gPiA+
IGFuZA0KPiA+ID4gwqBvdmVyYWxsIHN5c3RlbSBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbi4NCj4g
PiA+IA0KPiA+ID4gVGFyZ2V0Og0KPiA+ID4gwqBUaGUgdGFyZ2V0IG9mIHRoaXMgaW52ZW50aW9u
IGlzIHRvIGltcHJvdmUgdGhlIGVmZmljaWVuY3kgb2YNCj4gPiA+IG1lbW9yeQ0KPiA+ID4gwqBy
ZWNsYWltaW5nLiBCeSBzZXBhcmF0aW5nIHRoZSB0YXNrcyBvZiBwYWdlIHNjYW5uaW5nIGFuZCBw
YWdlDQo+ID4gPiDCoGNvbXByZXNzaW9uIGludG8gZGlzdGluY3QgcHJvY2Vzc2VzIG9yIHRocmVh
ZHMsIHRoZSBzeXN0ZW0gY2FuDQo+ID4gPiBoYW5kbGUNCj4gPiA+IMKgbWVtb3J5IHByZXNzdXJl
IG1vcmUgZWZmZWN0aXZlbHkuDQo+ID4gDQo+ID4gSSdtIG5vdCBhIHpyYW0gbWFpbnRhaW5lciwg
c28gSSdtIGRlZmluaXRlbHkgbm90IHRyeWluZyB0byBzdG9wDQo+ID4gdGhpcw0KPiA+IHBhdGNo
LiBCdXQgd2hhdGV2ZXIgcHJvYmxlbSB6cmFtIGlzIGZhY2luZyB3aWxsIGxpa2VseSBvY2N1ciB3
aXRoDQo+ID4genN3YXAgdG9vLCBzbyBJJ2QgbGlrZSB0byBsZWFybiBtb3JlIDopDQo+IA0KPiBS
aWdodCwgdGhpcyBpcyBsaWtlbHkgc29tZXRoaW5nIHRoYXQgY291bGQgYmUgYWRkcmVzc2VkIG1v
cmUNCj4gZ2VuZXJhbGx5DQo+IGZvciB6c3dhcCBhbmQgenJhbS4NCj4gDQoNClllcywgd2UgYWxz
byBob3BlIHRvIGV4dGVuZCB0aGlzIHRvIG90aGVyIHN3YXAgZGV2aWNlcywgYnV0IGN1cnJlbnRs
eSwNCndlIGhhdmUgb25seSBtb2RpZmllZCB6cmFtLiBXZSBhcmUgbm90IHZlcnkgZmFtaWxpYXIg
d2l0aCB6c3dhcCBhbmQNCndvdWxkIGxpa2UgdG8gYXNrIGlmIGFueW9uZSBoYXMgYW55IHN1Z2dl
c3Rpb25zIGZvciBtb2RpZmljYXRpb25zPw0KDQo+IFRoYW5rcw0KPiBCYXJyeQ0KDQpCZXN0IFJl
Z2FyZHMsDQpRdW4td2VpDQoNCg==
