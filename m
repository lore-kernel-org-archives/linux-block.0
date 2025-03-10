Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E071C221719;
	Mon, 10 Mar 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613182; cv=fail; b=YcLiEyRYRZbYWcMT8mr3cMtXK9B/U0eGAy0enGITd0GBaSJW0zHgUVGu1Pji7jhBXb29VLXDNOEewsh2wfMDkXPwPl5WpR8j2UK2b4jPdCA/eZ7BojcQg+t2NC5R2shFMLWt7EbyTJBL0KBkK504wE62IDgg3IcErRY/vX1Oxlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613182; c=relaxed/simple;
	bh=VRNem/sfX2TFbrPjsmm3Xxsp/GFJmv5dUi3FByXmvrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NNN1BYqjznlibsvKRYkAheefFvr58LRndKGxSncP+XrRMOpQ08kMUWAT4zadvg0fHDZv1VvAl8CPTID9alNIhQEuL7KF0fTTC3UiTkaF1B4xNaJHpGXIVLnWJgTHtPnIzVNXYqzoeYnINv3fHsqFuIjLjQ97Yp8NrgxThneeSGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FeqR0Wf/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=aunHm/Gj; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FeqR0Wf/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aunHm/Gj"
X-UUID: 3e91cf2cfdb311efaae1fd9735fae912-20250310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VRNem/sfX2TFbrPjsmm3Xxsp/GFJmv5dUi3FByXmvrg=;
	b=FeqR0Wf/NeOmXtOuYtaEXvHUHWy/NzLyO9DiERHQSRBYf6tMB8UhgmYaggvs5MJUvjgQEWQP1eJVq0GQ9M5OPlYQCrtjU82+pHOAs3W/IjhDTADk41NOaW/1J41lOg0i4Qea6Wlyv9akIzDAZwlC+cuag6Gs6fnaDQI/Yh+So14=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:46e37777-3114-4166-8150-e05cecf1c50d,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:2c90eb49-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3e91cf2cfdb311efaae1fd9735fae912-20250310
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <qun-wei.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1655338704; Mon, 10 Mar 2025 21:26:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 10 Mar 2025 21:26:15 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 10 Mar 2025 21:26:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEIj+KxkDb6IwCgaktUDsP6yQGkTF1/7nc8aKds7cUV32/IUZb9z7iGtx42+YmzEbTaWxKpMZlT335hG1M2sgFXBcr7sUF2Gy/EXje+J9Et/DW2LeGYW5aT4ZOcgVLM+NAcmtCkNZVfRlY/wBmir6eNf3M/tmsoWPakV1J3+10XUn8R3MG+4SypRcG3duND7Lz7H2eE66L5vWhJa5FAR0iU5HnT4UXF4eTfIXV2MPpX9KL0Xc9kEAIdQK4L1uOeb6kAnUr43pcktClpGlDMzW3DvmKlgPtMaYEJI/eg63sEeMXe+7x1ZgIPCkqwVFlnkuBT2GnHbMHZ4t8+0kwQ47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRNem/sfX2TFbrPjsmm3Xxsp/GFJmv5dUi3FByXmvrg=;
 b=QH3WLYHy2WW+m1sR/sMfeBucDLPHl7LznZcHe167+773SA0PpiElbxzlrNhkySWYoQGbCA3fkn4tFSirDb7QEoiXFFJ+leeEe+NWGoHrk252Gpr93gogyUhiOlXUHmAXrlxjYUEqFQt1Cn3626vvdPu+BQgS2ZS+/8Xs2IEwW/2katxjfRNASEn/s/HdBCG4un5QqBmNv/n4qmDgEtqaqfuFMuhuBMYRSRuqD0OB11P4LJyn454j+UPbyhp0JWyH7mMmch/M35zhqMIm989vWghmuHc4DEJkD8GOkKfT6X5IXpMnNcWkpxyZWe1PyojCm2a95dMVbjokW057vb1StQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRNem/sfX2TFbrPjsmm3Xxsp/GFJmv5dUi3FByXmvrg=;
 b=aunHm/GjU4aN4qCXxQJcTC1PINsUc/ltXmKUpVIY7QoEDXRGzFDSxbbInYWL3xhjH+cCO5kOOkIlUw192+5ak0Q8tFlqkF15ms0CjOb+6nQHkyhrFFU2giqvLOKArL0dtPBAYp9P77lKM4wNv/goNHt3V1+ALW+9jlU6R8PDFJ0=
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12)
 by TYSPR03MB8543.apcprd03.prod.outlook.com (2603:1096:405:61::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 13:26:11 +0000
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02]) by PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 13:26:11 +0000
From: =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>
To: "21cnbao@gmail.com" <21cnbao@gmail.com>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>
CC: =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
	<chinwen.chang@mediatek.com>, =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?=
	<Andrew.Yang@mediatek.com>, "chrisl@kernel.org" <chrisl@kernel.org>,
	=?utf-8?B?SmFtZXMgSHN1ICjlvpDmhbbolrAp?= <James.Hsu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "schatzberg.dan@gmail.com"
	<schatzberg.dan@gmail.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"minchan@kernel.org" <minchan@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "kasong@tencent.com" <kasong@tencent.com>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?=
	<casper.li@mediatek.com>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram
 compression
Thread-Topic: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram
 compression
Thread-Index: AQHbj1jervQE5KVJbEeGTu19qWI7uLNoExeAgAA7NQCAAABcgIAEEp8A
Date: Mon, 10 Mar 2025 13:26:11 +0000
Message-ID: <80d463f2155a949244881302722865443e709572.camel@mediatek.com>
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
	 <20250307120141.1566673-3-qun-wei.lin@mediatek.com>
	 <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
	 <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com>
	 <CAKEwX=MtzM4Vw221pHTj8CZJ1NhLgo7Ls3xroxLRO399fzG98Q@mail.gmail.com>
In-Reply-To: <CAKEwX=MtzM4Vw221pHTj8CZJ1NhLgo7Ls3xroxLRO399fzG98Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5542:EE_|TYSPR03MB8543:EE_
x-ms-office365-filtering-correlation-id: 2e419a6c-73ee-4ad8-d7a6-08dd5fd72003
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UWpmNWFEZTNpbis3SEhPQlFXa3M2Y0Y4Q1pnWE9BYjBKOVJlMGFnRXYvVkZj?=
 =?utf-8?B?eDliMmR4UHQ1U2poOHMwL2ZPcG43WWg1OFZDRTFQZGpJcHc5bE9WZXM2cUtq?=
 =?utf-8?B?Rm9JdUUyYU5sdjNjOXR3dU1PNXZUTjZTVTNObDd2c2c0eUNORFJkcTQ2bHpx?=
 =?utf-8?B?YjdDaUltK283Z0dOc2hXZGpOY2VqcXMvNkJKNEgyeDVvd3FXVEpmZ3N5YW51?=
 =?utf-8?B?dmlPbjVkSWU1WGZrRWV3N1RZeC9rSnk3cC9hRzQ5dUhzWWJ0ZDB3MDI2dWZs?=
 =?utf-8?B?NTdVQ2loQ1FMWjF3TWFhVVVVSjF3T0FycGFQM01icEFKclNoUGMxWnNIUlda?=
 =?utf-8?B?NE52b2FuWnhMTTRud3NuQWVRVW1SNFdjTmUwU0JYRDZ3blZ4TlN6bDZVVFVQ?=
 =?utf-8?B?bWJDdHhVRVJoOFZJS3BEdHB5ZyttTWRCZVZqOXVRREkrTDlJaWhvLzU1QXor?=
 =?utf-8?B?YmtCb2dmbFFZb2RjSnd1b1l2S0JlUHJKL25VUVZOMjMzeXdyVzJKMG1CbFBO?=
 =?utf-8?B?ZXJOc0lyY3M2eHJ2aG1rV25lRUI4VWhBYzVqWEFBYWhqWHVHRks1Tjc0cTl0?=
 =?utf-8?B?bkYzRnZqa2JLTFBZQW5NYklRQ1hmbUYxTlR3dTVsOW9aSFluYTRYcnE3enVC?=
 =?utf-8?B?dEVTdFJQMldwdUlheDAvTnAwV1dsdCtjMXJaTlBlS3FaUWNSUkRyZlBQZG5z?=
 =?utf-8?B?dXRnSlRNUzR5bURyK09pc1ZUcUhIZ2hFR3JncmJpc0NUMTI4VC9HM28ydkZ0?=
 =?utf-8?B?aFZOYXJCUmtCb3RIV0JXN3Bwb3NjV1VUcFZKMjF1UTBNVVpyR2NWeXpiRXNK?=
 =?utf-8?B?OFhiR29XZ2Z5UFcwYy91Si9lVldmbG03Q0R4Zk9XakRYSkNucWlQZlFkL1VX?=
 =?utf-8?B?Z3lxcDkyRGF6RlRnbC9kaFRaRXVIT0pYM2RpYnVZNjBpTkJyN2kxV0Fnakha?=
 =?utf-8?B?Z3NCVU5TSEVRbXhIK09qRmhwZXpJK1d6YTFGRnBvYTYxZUpxTnQ1SWs3enAx?=
 =?utf-8?B?YWFYdEZKcksyOGlsaXlSZjZQYWJsa3EyZzRFTkMzMENCdm54amQ2dFFYVW1s?=
 =?utf-8?B?c2hadTM0dDJGQkFnaXlvMlBxL25HNTFyYmcyYnJzeGhVKzlWeGdxdi9nUThr?=
 =?utf-8?B?eHI0RWxVcnlWd1FpcC81TW95TStpMm83aUkrOTQvL01yRkhQSkRSVE1MbU01?=
 =?utf-8?B?TXlGcnkvZXN1ZElibjg0TVoyWVlSWUV0aHo5SkRVb1RiN09JUjlML3dpNjVW?=
 =?utf-8?B?ZURTQWhwb2JqZExPWWFpUUt6WGh0bEV5cnhHR05ZdHMrRlM0Q2YxUGZjbDI5?=
 =?utf-8?B?c3A1cVBDZ002SDA5WkZjcUxBQ1ljUTZzN09CeVVnTllvcmp6alFiT3RFMlQ5?=
 =?utf-8?B?OXUvRHhYNFRBN3FNSTRSdlcraWNHOUNDcGhHeTNhK2FJMHZYaEk3Uzl2d01i?=
 =?utf-8?B?ZW1OaWZHQTdkZ1FFdStITTNtVXJUeTZ1VlF5MDQrTGNwbE5EUU5xYVdVMm4v?=
 =?utf-8?B?TUlYWVVCaEtQNVJ4RFhMa2RhZjZFRC9oY2Y3Q2E2dVU4Tm1uSEU5bFgrZ1dp?=
 =?utf-8?B?U0ZNd0RFQzVOZlNydUduTGFpTXp5ckN0KzJodVU1WUxCb1ZTdzVZWkJYM1pQ?=
 =?utf-8?B?U25KSVNGdVkwa3ByZS9yWkNqc2FpbDVKbVlGQUFiQVdlbGdKcGtGM2V6OXRD?=
 =?utf-8?B?ZTVLdkR5U2x5TUlqWW9Rb1pLdEo3ZXphRFhrQlFuMXliR3hqL1hkdHBxTXZV?=
 =?utf-8?B?anhOM0l4UVdqb1QrZ2RkQW8xYVBaSldMZ2g5eS9MQVNxYW54Q1VMQ214bEZa?=
 =?utf-8?B?Y0ZydmVSbml0dmlSbGhaNUZqWFZoNU83YzZGbDc5UGRtRVJPbWhKdGFCNmUr?=
 =?utf-8?B?blNDU0dEU3cySHJ4SHc5SW9JT3c1Tk53MmM0eWlWck5zRHJZYWxybVljeWtz?=
 =?utf-8?Q?Th2Dt0uT1vc3dO1PQYEL8GQ1hn362L7F?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5542.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U20yN3R0eEJnWGkxcnhONjN6R0N5Z2FjaHRUN216ZVhBUUFUQU81a2tIaXgr?=
 =?utf-8?B?SGRWVWN0d1FEeGtsdWJZaDhqcGloNmNiMEpmelZuand0WHlwV0NDSy9WMzMy?=
 =?utf-8?B?YVZnNVkxSm5jZTFtczRNQjk1SU8waW1XUWIxbVphMk1wWXM0WVl5NWNOZERi?=
 =?utf-8?B?Q2owdSsvRXNoYWx4c0ZNVExVUjJlNkVPMTZPamduZk5FSDVmcytuVlRWMnRp?=
 =?utf-8?B?MU03aWs0aDlSY2ZoTTNyc21wWjMvd0NJeTRxNjcxZVhUdjV6eXhHSk93Z1Vn?=
 =?utf-8?B?L2NNTGR4NTRJT1VrMURzanhEd0tLZStaYysvaU5SSXp1VlBrb2RKMlcycVZP?=
 =?utf-8?B?MWw3MnhsK045YUloeEZXaDg3NlVpdjNxTURmcUUyLzFMTWlQMjU5clg1eGF5?=
 =?utf-8?B?ZXFoalBHMU00dzVDenFnelRITUZxbnFCYk8xeWhwMExhc1JJTUxGWWI0amV0?=
 =?utf-8?B?T2VSOEk5WFhEMzFicWFQQUFMeS85TXpCeEduL3U4dlFhSk1SdjJaSzlmTGZh?=
 =?utf-8?B?cVRxQTNUK21SMTJwZVBYUkt2RGY5Tk9qNDA4czN1aE9qaDBZcWxJQ1VTQUM0?=
 =?utf-8?B?NTFLdzBvSGVDOFh6dEJQVkg4dysrcjBYWEdjSjMvd2ZReXdaMDNyRE9Yaml1?=
 =?utf-8?B?ckJsRmdTRi9IRDJSRVZHTTloWm5BK3dHMGI3RDNURWxmYmFJcHM1enAyQVQx?=
 =?utf-8?B?ejlEKy82azNieHBpQkRPcGV4Z05oRlg2SlZvc2tBWWw2RWcvV2JscG9wUmpJ?=
 =?utf-8?B?NFEvaWFyWFJiaUR3MUgydXFtUDltZXpJZXJrdHRYU3AvS3NTTGxXSGoyRXpX?=
 =?utf-8?B?bTBIT0EzTlEybkZmWmlyOVZIRDBPN3h3T1k4WDBENzA3UStkbG9SM2xuMlc5?=
 =?utf-8?B?S1I3bm1TdlovYk9MUkNOMnNuUGVqY3daanl4Zk82SmtDcTZXMkdzelA0SUNy?=
 =?utf-8?B?em5ITk1kd2ROdkdlM1F5YVRzSkhETDhHNDFOY0tUTVJyQ241dmc2OVF3RUtB?=
 =?utf-8?B?SUpBTUsyaWRwSTNQdkthTmRKd2RVZ09yNHVoK0UyQ3ZKeDNGOUxzRXZBZkNw?=
 =?utf-8?B?RTZBNEJnaUo0VEs2cCtDOHBYV281WTI3dlliVnUwdTArTFN1aWlKcWdKK0RO?=
 =?utf-8?B?aWloU2FmY1I2OG0vd1J4NmdiS2pheWliRGZSM1A2ZFR1ZFJBcjkyQ0dwQWlZ?=
 =?utf-8?B?Rzl6R3hraUJEY05iWlY5UTRvYk1oYTBFN29TeU44ZHdPUVFnWXpINVk2eEVG?=
 =?utf-8?B?dmpHTjJheWw3bTZtTzdOZ2FuTGtBZVFLUkZJcXNwaHdrcE01cEk0dXBOS1Ba?=
 =?utf-8?B?MFFSWmxsRlkxdEVjRVAvQk83dzhSU0MzZTJ2cmdxNjMzcEFEOHNhY1U1WDVS?=
 =?utf-8?B?TVNSWjM1bitsK04xK0crZlBHNkg0a3hGUWQyaW5rNjNUV3BpUGlmU3h4YURi?=
 =?utf-8?B?REJqVmtzVFJJUFZGOVMrbVJmYlJyRUxFbThXR1JhVlBQMXQ0eVNGbGVMcFhF?=
 =?utf-8?B?bmNBQk03blloWGRvdHJwaHIwN1ZuL0FYaCtoZzRxcEkzdDg0d2xLSGdhc0Ux?=
 =?utf-8?B?RlFSR1BUUUluZWM5K1lUVzZqcG5VcnY0M1FOajFhMHlzVTJhcWF6cHBGc1cr?=
 =?utf-8?B?NEttRGRFbVlWYW5oR2NDQkNjcGtMVWhCWHZKaGw1N1d3ME5ZT0dKbUJPZ0M3?=
 =?utf-8?B?K0NxSVBZSDVOV1ZFTmhFRGlaZWFDOGozMDJWL0l1d0dDNVJSZDNSVTdRMGRv?=
 =?utf-8?B?T2dUT29EU28xcExoNVBQWEFEMW54dVNiWUVjT1hqQ3BodU9aK2U2Y0d0NTF6?=
 =?utf-8?B?dDVEOFMzenZ2R20wbTNMMzhYbVBGNVl1WVNOWlhpeERwUUlOY212VzE5UWdj?=
 =?utf-8?B?L0p4dk1PZDRNeitlaXdQOFdCRFhjWjFUaHJzaUx6RTRtcXRNcmpYMUN3K0w5?=
 =?utf-8?B?SEtRVXExMHRzWFJNcCtvMjlxTjl2VHpjNmpSWFRWY0VydDRtUWtnSHBadml5?=
 =?utf-8?B?S1BuRkd6dVhmVitvVHdOM1ZqNXRpTVFGY0MvOURNb05OKzZKbys0MHZiR0N2?=
 =?utf-8?B?cHdBWU1VVitPQktBTWYya0VrVUFxL3N2QkNvcDFxdlpWcVc5eVQ3OW1wS0ZX?=
 =?utf-8?B?Z3JXcm5obEczd1NlczlzM29iTVBpOVVkNytWcWJ1YnU2MkxFdnZINmU1ODdC?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39F53354C5671E449D57549C5090F5F2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5542.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e419a6c-73ee-4ad8-d7a6-08dd5fd72003
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 13:26:11.5635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3H1l2VqE4xdmp06ZVPgd5GRa2QtxnVn/TDnSFZ7x6BIuU11auY5jlwZSt3s4BX92scFsPzK6DltVNE8H4QN8i4vYHjxQLE5+0jueRDXcdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8543

T24gRnJpLCAyMDI1LTAzLTA3IGF0IDE1OjE0IC0wODAwLCBOaGF0IFBoYW0gd3JvdGU6DQo+IA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IE9uIEZyaSwgTWFyIDcsIDIwMjUgYXQgMzoxM+KAr1BNIE5oYXQgUGhh
bSA8bnBoYW1jc0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IA0KPiA+IEFncmVlLiBBIHNo
YXJlZCBzb2x1dGlvbiB3b3VsZCBiZSBtdWNoIGFwcHJlY2lhdGVkLiBXZSBjYW4ga2VlcCB0aGUN
Cj4gPiBrY29tcHJlc3NkIGlkZWEsIGJ1dCBoYXZlIGl0IGFjY2VwdCBJTyB3b3JrIGZyb20gbXVs
dGlwbGUgc291cmNlcw0KPiA+ICh6cmFtLCB6c3dhcCwgd2hhdGV2ZXIpIHRocm91Z2ggYSBzaGFy
ZWQgQVBJLg0KPiANCj4gYnkgSU8gSSBtZWFudCBjb21wcmVzcyB3b3JrIChzaG91bGQgYmUgZG91
YmxlIHF1b3RlZCAiSU8iKS4gQnV0IHlvdQ0KPiBnZXQgdGhlIGlkZWEgOikNCg0KSSBhbHNvIGFn
cmVlIHRoYXQgd2UgY2FuIGV2b2x2ZSBpbnRvIGEgbW9yZSBnZW5lcmFsIHNvbHV0aW9uLg0KU28g
dGhpcyBpcyBhbHNvIHdoeSB3ZSBkZXNpZ25lZCBrY29tcHJlc3NkIHRvIGRvIHdyaXRlYmFjayB1
c2luZw0KY2FsbGJhY2tzIHJhdGhlciB0aGFuIGhhcmQgY29kaW5nIGl0IGRpcmVjdGx5IGludG8g
enJhbS4NCg0KQnV0IGN1cnJlbnRseSB3ZSBvbmx5IGV4dGVuZCBacmFtLiBJZiBhbnlvbmUgaGFz
IGdvb2Qgc3VnZ2VzdGlvbnMsIHdlDQp3b3VsZCBncmVhdGx5IGFwcHJlY2lhdGUgeW91ciBoZWxw
Lg0KDQpUaGFua3MhDQpRdW4td2VpDQo=
