Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18125A653;
	Tue, 11 Mar 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702392; cv=fail; b=H6BmfV4d5mwq0lytebH+kT6DNDYquQ8Swv/665Wh0OMU6F4aAupTSSDmMSC20rCIbyp05mj3J8GfYhj3uJZVT+U7pP2lP1aLP/B4eLR2lH/2hz83V/GYsJWVlTpGxZLYIPlIRTSA4413eCslMDRiIe5zUcbwqh4CjqAN31p8v/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702392; c=relaxed/simple;
	bh=cRaOwP/RJJaF9Kz9pE7wUGMMVyL6pd85mjuH5f92i4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rvhWltELqXTiaU41HQOVVSnOZcZlfXDUA2QIXE9jNo05QD9MbFIqWMbSB4xreF1Z3rM3pZg6FiVfNH9eAQsZe4e0dEMouWNwrRgOWsDqfwOMVH7PwoxuiEfQPAo0Dn9N7qhBQnyCq1vCjGG7Jvlsx7uboyFYJR+mnDWY1hAWwWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KmH2e0vg; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gXjA9lS+; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KmH2e0vg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gXjA9lS+"
X-UUID: f0d35f46fe8211efaae1fd9735fae912-20250311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cRaOwP/RJJaF9Kz9pE7wUGMMVyL6pd85mjuH5f92i4I=;
	b=KmH2e0vg59AZ3D1jSEmjHdsFiiIVfYvoJoNUn63P8nz1koSDkVcg4VydDdbwIpvJhU9+pE32r6jAHws/xdcSUhMeA0rBkW55ETXuqXhu7tevbXkp5AqmtR6zP8tp3RnrJcivRYzA5LE1uPbJ0YZjGhOqHa5cyVP1re0X0Q34SpI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:23d1b00e-c394-4a5d-80b4-d44ed4e0d338,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:892f34c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f0d35f46fe8211efaae1fd9735fae912-20250311
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <qun-wei.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2137478095; Tue, 11 Mar 2025 22:13:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 11 Mar 2025 22:12:59 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 11 Mar 2025 22:12:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ra+qo3UySDnT3w7iGWT8fRrHomCfpvJ/dpjXzMLhlwY6HWMzSZCEgIHKFT8yKoRWOGF2s0llNFYNZobSQM134h/Zalnl+i9AldI8qLEmIc/hV22EwbyjERCVCv0+7i68M/E1dE3q9jh02is571N2d3fvxreDF9oH16Unb/5aqi159S0vvaq0urT7uB6zMlRGvhh3ejzjTqD/DyiTxZWDk5/1oRi5t9HtWPZa3fM4fKRix8NXweOOTkRHrd6vYv9omTlfoj5/+jTi1vmgClS2AIjzfzTdf90g4ETpkKBUYU95I8pb5J8sd+/3tDDocQWL5eererTZLiu7z85a0VPaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRaOwP/RJJaF9Kz9pE7wUGMMVyL6pd85mjuH5f92i4I=;
 b=Tde4cxftgVAvglXx2L9rwvHD7ym6y/llInAPaJbZlKGhGAs9cD6RXBmfcx21uuYZ9JRZqWZW2Yr0chrTc3A6TRrXhQPCAgf/kqpEwlgViUn/jVt+N4MPmvcgCus+l36x6aX+Phm6ilcMcjJPxf1YpigHEJjw70RB4uv4eUPmrVIRDKlYZS2B66Bzmok985HTqSRsuX04N1UzjY1WYHMukzaubAQCImaATPfUYDoqNImRl4CXZ19ofpGCJw53LUow0F6SA2i4tDXMVpWtfCOSUUgJs59+lOCkKIhDl+iBkCGsK60b3cklpyQ39tUb9o/W5yUalDh8J6u/ERC3bhM/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRaOwP/RJJaF9Kz9pE7wUGMMVyL6pd85mjuH5f92i4I=;
 b=gXjA9lS+DoMRPhrwW6Wa87E75xoLbczLUSX3glH7vk7ncOxoy91I/e9zb4bePpp6L24qO/6R0tUP+s7fAdNceG6+t+yGXIcf4uboeqipcXwra5SYll9oyR4Y+997Upnxy0tWz/EsFipZO33wiHTPLF3ULh2P+pGVMxGXPIbxxw4=
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12)
 by JH0PR03MB8810.apcprd03.prod.outlook.com (2603:1096:990:a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:12:56 +0000
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02]) by PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 14:12:56 +0000
From: =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>
To: "21cnbao@gmail.com" <21cnbao@gmail.com>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>
CC: =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
	<chinwen.chang@mediatek.com>, =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?=
	<Andrew.Yang@mediatek.com>, =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?=
	<casper.li@mediatek.com>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chrisl@kernel.org" <chrisl@kernel.org>,
	=?utf-8?B?SmFtZXMgSHN1ICjlvpDmhbbolrAp?= <James.Hsu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"schatzberg.dan@gmail.com" <schatzberg.dan@gmail.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "minchan@kernel.org" <minchan@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "kasong@tencent.com" <kasong@tencent.com>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ying.huang@intel.com" <ying.huang@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/2] Improve Zram by separating compression context from
 kswapd
Thread-Topic: [PATCH 0/2] Improve Zram by separating compression context from
 kswapd
Thread-Index: AQHbj1ja3HBtEsnk0kq5WQ+MAj7gkbNoS5sAgABvMoCABKrwAIAATL4AgABOMYA=
Date: Tue, 11 Mar 2025 14:12:55 +0000
Message-ID: <32d951629ab18bcb2cb59b0c0baab65de915dbea.camel@mediatek.com>
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
	 <CAKEwX=NfKrisQL-DBcNxBwK2ErK-u=MSzHNpETcuWWNBh9s9Bg@mail.gmail.com>
	 <CAGsJ_4ysL1xV=902oNM3vBfianF6F_iqDgyck6DGzFrZCtOprw@mail.gmail.com>
	 <dubgo2s3xafoitc2olyjqmkmroiowxbpbswefhdioaeupxoqs2@z3s4uuvojvyu>
	 <CAGsJ_4wbgEGKDdUqa8Kpw952qiM_H5V-3X+BH6SboJMh8k2sRg@mail.gmail.com>
In-Reply-To: <CAGsJ_4wbgEGKDdUqa8Kpw952qiM_H5V-3X+BH6SboJMh8k2sRg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5542:EE_|JH0PR03MB8810:EE_
x-ms-office365-filtering-correlation-id: 9a569351-3f38-44ca-fd73-08dd60a6d203
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Umc0WEhONllYSnlQSElvbndCZkM2c0VDVUphUDJkYmlqc0xlcHRYekQ2SUNt?=
 =?utf-8?B?OWkrVW5aTTdvLzFqZDZ3ZG0rb3JtaGVNT0tHUUlyQlFoWS81R1ZESDhIMWc1?=
 =?utf-8?B?K3FCT1RzdnpvWmZHOWprSXBQVDJQVUYwNmxUOUhObllaczVZM3VXaUUzZERC?=
 =?utf-8?B?bS8yS0p0SHFPRXpWQ1JTRWZHcGRUdzJ5TE9SU3E1V0d3RTNqbWk5ZDBSTFE5?=
 =?utf-8?B?V3NDNjFmaU4xM2laQ2lBRVloQ3FsYlE1NEVKcC9peVQ0SVFtYjlzYUJKRGxu?=
 =?utf-8?B?bkJGVzBkWXZCSnlwdFRuUklLU1oyUEZUNStsaWxRUmZMU3JWNnJabUFIUVNC?=
 =?utf-8?B?QWUzNnFlUkU4UTVuQmpzK1Y3VGNYNjFxR2J0WTBDTXRWR1l4ODhZL0w4eUxz?=
 =?utf-8?B?bzBqVUYrOUJMMytxNzNhN3NlZVZsaS9lOUo4NVlXNGYzYUpRYnAvems1VTJC?=
 =?utf-8?B?Q00xN3NjSUczekMwVEY2RDJGT3lpcGRmbWJlN2NEM01yQ29yQkZMVUVNeEx6?=
 =?utf-8?B?T2hQdCtIUklnd3p6V2lxZHlHZTYwOHVBaHM1UzRHejFLU1BZWjNIejJtbmNB?=
 =?utf-8?B?Y3EwSVR2YWM5YXR4ZEtCcFY1Qm9NeStia1pJYmd1VFVnR0c1YUtyWXhLaUxV?=
 =?utf-8?B?bXc2N01nNmh2YW0wc0dNVHh6cWgwVUVtQ3d2OE1kWTJ3cnpKa1BPTlZaZlk0?=
 =?utf-8?B?MU8xQzJHSW9iUVZYZ3RGTTN4aGVKT0RmQjFFNzFTaTR1ZnZiUThCSjVHbitm?=
 =?utf-8?B?UnpsQTc5UWNGMURQVDN6UmZPTFg5dWhhRU9jdSsvLzQ4ZkJ3Y01HQVkyd2dj?=
 =?utf-8?B?ZlRDNEJ0SFh5RWxkSVFxa0JkWFBObXJneGZoM2tUQjVqaUh2Sll2L3IwcFVj?=
 =?utf-8?B?TXhIQ0VsK2ZCRHpQTWVhNkFoenZtZlJNNmxPT1RjTTZHOG9sYndNbnBCVm5O?=
 =?utf-8?B?N3hJbUhad0lYdzBzYzZGYklnR1hCZmtLc1lMdm5DWE9XNFJmd0VhWUowck1o?=
 =?utf-8?B?dGt4MHZaZ09mWkVPVGJLMUhtNWlERGV5dWt5cHhlc3hKcDFFdGcvaFBwWWFa?=
 =?utf-8?B?aDJkYmpxOWNyRjVaZmtsVExOSDBTVHBFUTJnZTZNc0d1S0k5STZjSGtCMWVN?=
 =?utf-8?B?bEFqb0V5eUpkTHgzVkZqdzB4STJvQS9wZ3QyVWFHMm92eFJxbEZ2c2EvS29O?=
 =?utf-8?B?TVFOSkhGdWRTblVCai91bFBqTzRKVEJZWUxNSStjcjdNbFlQbTdTWjFtTXlM?=
 =?utf-8?B?VWlGbTAwZ3piWE9rRWZRa3ZMdjNyYUxsQ3RkQjQ0aDdINngvbEJoVkFka2or?=
 =?utf-8?B?dWhPbDYzVnZFczIrSXpFZ2RHTnJpekVteDE3OWVYS2dublE0aXNwa2g5bkEx?=
 =?utf-8?B?ekhKNnVvT1VnaGZqdkVtZVhxQWRJeDJpOExzYk5hRUZDVzBaRk5oK1ZMR29N?=
 =?utf-8?B?VWhqb1BWTlJvU28yTEZiTktSd1o1VW0wdGd1cm43cEJwUW1IckM3ejc0Ui9R?=
 =?utf-8?B?UHF2bUtVVVMrU0lWSkNaR3FsUkpGQ3BTcVVEQUJ3TDN6R05MSTZFLzZkenRJ?=
 =?utf-8?B?WWMza1R0aER2OGk0bzcyMFlFVGRzTW1yZFJSaG9rZlA5Z2VwUE5uK0k1TE0r?=
 =?utf-8?B?TVRvUHpheEU3MUtUWW44MW1zOVhWaC9LSld4ZmI1bytvaXo0cEw1R3l3YlJH?=
 =?utf-8?B?ZFpMeEphV1lvdmtLS1FuNzJmZlFBTzNNV01RMUs4MmRhZWwyRE1jTVgvaHBW?=
 =?utf-8?B?SGQwQk5acTYzQjBDcmZsTDZxbkdvcHdoRjNwcmI5OWN2RlVCSTFHSG9pWW9h?=
 =?utf-8?B?RFJzMmJqQkhSUE1VQlpHT25HLy9JYWpoWGprWVdDOFFZODJvYm9NZWVLZmhj?=
 =?utf-8?B?c24yeU01K0crc2pUT1gxRiszOWo3OUhqSUNlY0d3ZVZWYnZqQkEvNkJSamJu?=
 =?utf-8?Q?LWeLTHn46mEv4sNAH9dL+ZKrkGPMlGkK?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5542.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWZTVEdzOHh1MEVHY3g3Z2Iyc093aVlWSlRoSFh0ODkrZVhEVXcyQmhha0Zl?=
 =?utf-8?B?dXJ3dEhvT2k4VUhHUjQrYVl4NjRhWitlK0JqUzBMNGQyUkVvWjhrQVBvTTFo?=
 =?utf-8?B?a084VFpIendoVkZ0TkszNTVIQmtmUHl6a05yMW1wV2orSmwyUGwvSjNFMFhT?=
 =?utf-8?B?Vk9hbER3emNiR0RsRms0UkUzaG9BbkJwZW5Cak8xcmV4MXlmZVA3RGpBbHBD?=
 =?utf-8?B?QkNqeXhKNFhKYUw0THFyUk0zOHZSRHNaQ0UzKytNbzE1bUJwU3phQXZjcENx?=
 =?utf-8?B?aEVsb3dFb3hxYVRaMmFKQnFheGVxZXhpWXdXZW5BbmxkWXF1eFUwc2pOWldC?=
 =?utf-8?B?a2xrRzhWblZHQkpXaUVydi9pTFpmZlZGdSttUzhkRkFnSko1REVNWWw4cjF1?=
 =?utf-8?B?d1NhY0JFaU9kR2tYYXdRN0drVjY3NFRFT09jeHlwLzF6SkR1Um9XTjZpOWNT?=
 =?utf-8?B?LzdneS9Sdnd2ckhncVVSaEd0SVcxVXNPbEc4SUFGZEZ6NjNRd2RCVC9oZGpE?=
 =?utf-8?B?Mk5kbHZJeE5EcERLeng4MTFndXVEbngzRGNxY05VTzU2WXZSbFBQMGpTa0dQ?=
 =?utf-8?B?clkwOHVIUFhqRm11NWI2WTJnTTAra1QxTHlNMi91ZTVjRytwZXVtcFFyeFlV?=
 =?utf-8?B?VFl1RUdCaDVTeDV3UDNTNDd6VGNSYjNtVkNraVZJNzU2RTRVM0RLdnp2NE11?=
 =?utf-8?B?RGxXUndPRDNPNUczVjBjVjdRbDIzS1pCckFtMDlGVFhLcGVuNUo2dEpvVEdR?=
 =?utf-8?B?ZDZSTC9YWkZmU1dHUHprM2QwWXdMSzg2ektWdWp1ZE5qdzhuQVJrNnR1Y0dx?=
 =?utf-8?B?bXVpV25OYUhoZTdQRDByMXhGMEdwNGdvSGJtMlE1b3pLSytvVERuU3lKQjhq?=
 =?utf-8?B?RmNyaGFkRzhTbnI4T1JNK1FFRkx3UWJaYVo5YzhiRkJQSXVHYnBRRG5IWGlj?=
 =?utf-8?B?UXB1ejFiV2FHNVpVRlRyeVV2dHBsbGloemdoV3dySTh0WE1TNjgyL2dNUGVy?=
 =?utf-8?B?LzJjOVJOUU9VeEFMVkV5M3FzbXFuL1ZjN3d4allBUy9UM2VoVG84RHF6dXFo?=
 =?utf-8?B?aDlrdjdwY1lYOW9sYXJPT3Vmc2txdWhQUnArWGZWWFpzSzl4aXRsN0kvQ0Nt?=
 =?utf-8?B?OGFiVlhtdU5XT3VWWXJnYUFGS3RZNSsxWjJPU3A4MDUxNFVaNmV4a25OWXF2?=
 =?utf-8?B?WWRKSkp0NllOdWJpYWtGSS9XQ3p0N2liNkhmN3U3QytwUVlra3dSMzZJYWds?=
 =?utf-8?B?cjJSdDNqcGxUaGZBbjlxa1IvaGVkcmJwUXRsUkZPK1pXK0QrYlZFSmdVS3Vy?=
 =?utf-8?B?Tk9aNDNCdU05VThpYXBVUnpYTW0zUlJHZldhMVc3TlZyT01uZEJESlZsZ3Bx?=
 =?utf-8?B?TFlEamY1OS8vMUphU2NSajE0TTNSeUtKb1BvbDR6NUtZYTlzWHFuakNXWnFs?=
 =?utf-8?B?WHNXM1hscGNWS2IzMW9zczVHcFloT2xWMUJQSnhRcmhpTURyTFY2QlJNdmdl?=
 =?utf-8?B?NFNPN3c4TzhkVWJyeHBuSVdzVDF2bjFCa1ExL0RPRHcySG9wT2dLUmZvY21u?=
 =?utf-8?B?M0k3VXAyc3IwZ2JnSHZadytTN2tBeElVem80VWlvcFVrVENKbU9FcURsekFC?=
 =?utf-8?B?ajdPT09lVElOWm1zYzRzNERUa1RTWjFsMXlxbVVvQ1FQS01ON1hVVC90bFlt?=
 =?utf-8?B?bnBPTWhzcThVSmx2ZUV0OTBsSWM3djBsSDBMcWdmMDdlK1BIUHp5dnd6TFlH?=
 =?utf-8?B?bjNSMWNRVjdTWE9XM2NOTnJZeEhabU5sZzg5Ly9IYzB4Q0JaMWh1SW5Ua29x?=
 =?utf-8?B?S01nRGFrS0U5NkU5aFAwei83QzI1N3VsckJCUVZyMGRvbEliNXRaT1R5bkR6?=
 =?utf-8?B?Zm1sempKeTBCaXZZNkxlWTlmaG5JVTdoOGdBRVVlcGkxZHB6M2RjM3hJenFD?=
 =?utf-8?B?Q3lwSVJRNUNWRkpISmMyQVY0U0h6L0duNXhOVEw4U3I2SGx1NlVaWVVhdk1C?=
 =?utf-8?B?bWdJb0tzTHB5c1cwck55Y0EwTGp3dFBsaFcvK3B6SHhXMzFMT2dpam5PeDVG?=
 =?utf-8?B?cUZTYlhEQk9yOWg4ZTFCYlhTcFp2c1FDYktLQzl1dlFjVkhJTGUrbCtrZGR4?=
 =?utf-8?B?U0Zzd09rLytzQnlwVi9XaTBsZjd2T1o4SHBTM0d6dU5udkptTEx3UThGdE9L?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <432B53E5AD71EA49BC50CE48D6A488B0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5542.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a569351-3f38-44ca-fd73-08dd60a6d203
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 14:12:56.0563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EH8CC4Cd4vwQ4wgUb9JSdIg/aSQ1Sh0gHbNC+87f3/XOFFx/om2bBL2Ep5VvYNRqMEwnomoBfvemX0EpWQ8Yv+auYnQeNkeUejF7x7zic1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8810

T24gVHVlLCAyMDI1LTAzLTExIGF0IDIyOjMzICsxMzAwLCBCYXJyeSBTb25nIHdyb3RlOg0KPiAN
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29u
dGVudC4NCj4gDQo+IA0KPiBPbiBUdWUsIE1hciAxMSwgMjAyNSBhdCA1OjU44oCvUE0gU2VyZ2V5
IFNlbm96aGF0c2t5DQo+IDxzZW5vemhhdHNreUBjaHJvbWl1bS5vcmc+IHdyb3RlOg0KPiA+IA0K
PiA+IE9uICgyNS8wMy8wOCAxODo0MSksIEJhcnJ5IFNvbmcgd3JvdGU6DQo+ID4gPiBPbiBTYXQs
IE1hciA4LCAyMDI1IGF0IDEyOjAz4oCvUE0gTmhhdCBQaGFtIDxucGhhbWNzQGdtYWlsLmNvbT4N
Cj4gPiA+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24gRnJpLCBNYXIgNywgMjAyNSBhdCA0
OjAy4oCvQU0gUXVuLVdlaSBMaW4NCj4gPiA+ID4gPHF1bi13ZWkubGluQG1lZGlhdGVrLmNvbT4g
d3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNl
cyBhIG5ldyBtZWNoYW5pc20gY2FsbGVkDQo+ID4gPiA+ID4ga2NvbXByZXNzZCB0bw0KPiA+ID4g
PiA+IGltcHJvdmUgdGhlIGVmZmljaWVuY3kgb2YgbWVtb3J5IHJlY2xhaW1pbmcgaW4gdGhlIG9w
ZXJhdGluZw0KPiA+ID4gPiA+IHN5c3RlbS4gVGhlDQo+ID4gPiA+ID4gbWFpbiBnb2FsIGlzIHRv
IHNlcGFyYXRlIHRoZSB0YXNrcyBvZiBwYWdlIHNjYW5uaW5nIGFuZCBwYWdlDQo+ID4gPiA+ID4g
Y29tcHJlc3Npb24NCj4gPiA+ID4gPiBpbnRvIGRpc3RpbmN0IHByb2Nlc3NlcyBvciB0aHJlYWRz
LCB0aGVyZWJ5IHJlZHVjaW5nIHRoZSBsb2FkDQo+ID4gPiA+ID4gb24gdGhlDQo+ID4gPiA+ID4g
a3N3YXBkIHRocmVhZCBhbmQgZW5oYW5jaW5nIG92ZXJhbGwgc3lzdGVtIHBlcmZvcm1hbmNlIHVu
ZGVyDQo+ID4gPiA+ID4gaGlnaCBtZW1vcnkNCj4gPiA+ID4gPiBwcmVzc3VyZSBjb25kaXRpb25z
Lg0KPiA+ID4gPiANCj4gPiA+ID4gUGxlYXNlIGV4Y3VzZSBteSBpZ25vcmFuY2UsIGJ1dCBmcm9t
IHlvdXIgY292ZXIgbGV0dGVyIEkgc3RpbGwNCj4gPiA+ID4gZG9uJ3QNCj4gPiA+ID4gcXVpdGUg
Z2V0IHdoYXQgaXMgdGhlIHByb2JsZW0gaGVyZT8gQW5kIGhvdyB3b3VsZCBkZWNvdXBsZQ0KPiA+
ID4gPiBjb21wcmVzc2lvbg0KPiA+ID4gPiBhbmQgc2Nhbm5pbmcgaGVscD8NCj4gPiA+IA0KPiA+
ID4gTXkgdW5kZXJzdGFuZGluZyBpcyBhcyBmb2xsb3dzOg0KPiA+ID4gDQo+ID4gPiBXaGVuIGtz
d2FwZCBhdHRlbXB0cyB0byByZWNsYWltIE0gYW5vbnltb3VzIGZvbGlvcyBhbmQgTiBmaWxlDQo+
ID4gPiBmb2xpb3MsDQo+ID4gPiB0aGUgcHJvY2VzcyBpbnZvbHZlcyB0aGUgZm9sbG93aW5nIHN0
ZXBzOg0KPiA+ID4gDQo+ID4gPiAqIHQxOiBUaW1lIHRvIHNjYW4gYW5kIHVubWFwIGFub255bW91
cyBmb2xpb3MNCj4gPiA+ICogdDI6IFRpbWUgdG8gY29tcHJlc3MgYW5vbnltb3VzIGZvbGlvcw0K
PiA+ID4gKiB0MzogVGltZSB0byByZWNsYWltIGZpbGUgZm9saW9zDQo+ID4gPiANCj4gPiA+IEN1
cnJlbnRseSwgdGhlc2Ugc3RlcHMgYXJlIGV4ZWN1dGVkIHNlcXVlbnRpYWxseSwgbWVhbmluZyB0
aGUNCj4gPiA+IHRvdGFsIHRpbWUNCj4gPiA+IHJlcXVpcmVkIHRvIHJlY2xhaW0gTSArIE4gZm9s
aW9zIGlzIHQxICsgdDIgKyB0My4NCj4gPiA+IA0KPiA+ID4gSG93ZXZlciwgUXVuLVdlaSdzIHBh
dGNoIGVuYWJsZXMgdDEgKyB0MyBhbmQgdDIgdG8gcnVuIGluDQo+ID4gPiBwYXJhbGxlbCwNCj4g
PiA+IHJlZHVjaW5nIHRoZSB0b3RhbCB0aW1lIHRvIG1heCh0MSArIHQzLCB0MikuIFRoaXMgbGlr
ZWx5IGltcHJvdmVzDQo+ID4gPiB0aGUNCj4gPiA+IHJlY2xhbWF0aW9uIHNwZWVkLCBwb3RlbnRp
YWxseSByZWR1Y2luZyBhbGxvY2F0aW9uIHN0YWxscy4NCj4gPiANCj4gPiBJZiBjb21wcmVzc2lv
biBrdGhyZWFkLXMgY2FuIHJ1biAoaGF2ZSBDUFVzIHRvIGJlIHNjaGVkdWxlZCBvbikuDQo+ID4g
VGhpcyBsb29rcyBhIGJpdCBsaWtlIGEgYm90dGxlbmVjay7CoCBJcyB0aGVyZSBhbnl0aGluZyB0
aGF0DQo+ID4gZ3VhcmFudGVlcyBmb3J3YXJkIHByb2dyZXNzP8KgIEFsc28sIGlmIGNvbXByZXNz
aW9uIGt0aHJlYWRzDQo+ID4gY29uc3RhbnRseSBwcmVlbXB0IGtzd2FwZCwgdGhlbiBpdCBtaWdo
dCBub3QgYmUgd29ydGggaXQgdG8NCj4gPiBoYXZlIGNvbXByZXNzaW9uIGt0aHJlYWRzLCBJIGFz
c3VtZT8NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBjcml0aWNhbCBpbnNpZ2h0cywgYWxsIG9mIHdo
aWNoIGFyZSB2YWx1YWJsZS4NCj4gDQo+IFF1bi1XZWkgaXMgbGlrZWx5IHdvcmtpbmcgb24gYW4g
QW5kcm9pZCBjYXNlIHdoZXJlIHRoZSBDUFUgaXMNCj4gcmVsYXRpdmVseSBpZGxlIGluIG1hbnkg
c2NlbmFyaW9zICh0aG91Z2ggdGhlcmUgYXJlIGNlcnRhaW5seSBjYXNlcw0KPiB3aGVyZSBhbGwg
Q1BVcyBhcmUgYnVzeSksIGJ1dCBmcmVlIG1lbW9yeSBpcyBxdWl0ZSBsaW1pdGVkLg0KPiBXZSBt
YXkgc29vbiBzZWUgYmVuZWZpdHMgZm9yIHRoZXNlIHR5cGVzIG9mIHVzZSBjYXNlcy4gSSBleHBl
Y3QNCj4gQW5kcm9pZCBtaWdodCBoYXZlIHRoZSBvcHBvcnR1bml0eSB0byBhZG9wdCBpdCBiZWZv
cmUgaXQncyBmdWxseQ0KPiByZWFkeSB1cHN0cmVhbS4NCj4gDQo+IElmIHRoZSB3b3JrbG9hZCBr
ZWVwcyBhbGwgQ1BVcyBidXN5LCBJIHN1cHBvc2UgdGhpcyBhc3luYyB0aHJlYWQNCj4gd29u4oCZ
dCBoZWxwLCBidXQgYXQgbGVhc3Qgd2UgbWlnaHQgZmluZCBhIHdheSB0byBtaXRpZ2F0ZSByZWdy
ZXNzaW9uLg0KPiANCj4gV2UgbGlrZWx5IG5lZWQgdG8gY29sbGVjdCBtb3JlIGRhdGEgb24gdmFy
aW91cyBzY2VuYXJpb3PigJR3aGVuDQo+IENQVXMgYXJlIHJlbGF0aXZlbHkgaWRsZSBhbmQgd2hl
biBhbGwgQ1BVcyBhcmUgYnVzeeKAlGFuZA0KPiBkZXRlcm1pbmUgdGhlIHByb3BlciBhcHByb2Fj
aCBiYXNlZCBvbiB0aGUgZGF0YSwgd2hpY2ggd2UNCj4gY3VycmVudGx5IGxhY2sgOi0pDQo+IA0K
DQpUaGFua3MgZm9yIHRoZSBleHBsYWluaW5nIQ0KDQo+ID4gDQo+ID4gSWYgd2UgaGF2ZSBhIHBh
Z2VmYXVsdCBhbmQgbmVlZCB0byBtYXAgYSBwYWdlIHRoYXQgaXMgc3RpbGwgaW4NCj4gPiB0aGUg
Y29tcHJlc3Npb24gcXVldWUgKG5vdCBjb21wcmVzc2VkIGFuZCBzdG9yZWQgaW4genJhbSB5ZXQs
IGUuZy4NCj4gPiBkdXQgdG8gc2NoZWR1bGluZyBsYXRlbmN5ICsgc2xvdyBjb21wcmVzc2lvbiBh
bGdvcml0aG0pIHRoZW4gd2hhdA0KPiA+IGhhcHBlbnM/DQo+IA0KPiBUaGlzIGlzIGhhcHBlbmlu
ZyBub3cgZXZlbiB3aXRob3V0IHRoZSBwYXRjaD/CoCBSaWdodCBub3cgd2UgYXJlDQo+IGhhdmlu
ZyA0IHN0ZXBzOg0KPiAxLiBhZGRfdG9fc3dhcDogVGhlIGZvbGlvIGlzIGFkZGVkIHRvIHRoZSBz
d2FwY2FjaGUuDQo+IDIuIHRyeV90b191bm1hcDogUFRFcyBhcmUgY29udmVydGVkIHRvIHN3YXAg
ZW50cmllcy4NCj4gMy4gcGFnZW91dDogVGhlIGZvbGlvIGlzIHdyaXR0ZW4gYmFjay4NCj4gNC4g
U3dhcGNhY2hlIGlzIGNsZWFyZWQuDQo+IA0KPiBJZiBhIHN3YXAtaW4gb2NjdXJzIGJldHdlZW4g
MiBhbmQgNCwgZG9lc24ndCB0aGF0IG1lYW4NCj4gd2UndmUgYWxyZWFkeSBlbmNvdW50ZXJlZCB0
aGUgY2FzZSB3aGVyZSB3ZSBoaXQNCj4gdGhlIHN3YXBjYWNoZSBmb3IgYSBmb2xpbyB1bmRlcmdv
aW5nIGNvbXByZXNzaW9uPw0KPiANCj4gSXQgc2VlbXMgd2UgbWlnaHQgaGF2ZSBhbiBvcHBvcnR1
bml0eSB0byB0ZXJtaW5hdGUNCj4gY29tcHJlc3Npb24gaWYgdGhlIHJlcXVlc3QgaXMgc3RpbGwg
aW4gdGhlIHF1ZXVlIGFuZA0KPiBjb21wcmVzc2lvbiBoYXNu4oCZdCBzdGFydGVkIGZvciBhIGZv
bGlvIHlldD8gc2VlbXMNCj4gcXVpdGUgZGlmZmljdWx0IHRvIGRvPw0KDQpBcyBCYXJyeSBleHBs
YWluZWQsIHRoZXNlIGZvbGlvcyB0aGF0IGFyZSBiZWluZyBjb21wcmVzc2VkIGFyZSBpbiB0aGUN
CnN3YXBjYWNoZS4gSWYgYSByZWZhdWx0IG9jY3VycyBkdXJpbmcgdGhlIGNvbXByZXNzaW9uIHBy
b2Nlc3MsIGl0cw0KY29ycmVjdG5lc3MgaXMgYWxyZWFkeSBndWFyYW50ZWVkIGJ5IHRoZSBzd2Fw
IHN1YnN5c3RlbSAoc2ltaWxhciB0byANCm90aGVyIGFzeW5jaHJvbm91cyBzd2FwIGRldmljZXMp
Lg0KDQpJbmRlZWQsIHRlcm1pbmF0aW5nIGEgZm9saW8gdGhhdCBpcyBhbHJlYWR5IGluIHRoZSBx
dWV1ZSB3YWl0aW5nIGZvcg0KY29tcHJlc3Npb24gaXMgYSBjaGFsbGVuZ2luZyB0YXNrLiBXaWxs
IHRoaXMgcmVxdWlyZSBzb21lIG1vZGlmaWNhdGlvbnMNCnRvIHRoZSBjdXJyZW50IGFyY2hpdGVj
dHVyZSBvZiBzd2FwIHN1YnN5c3RlbT8NCg0KPiANCj4gVGhhbmtzDQo+IEJhcnJ5DQoNCkJlc3Qg
UmVnYXJkcywNClF1bi13ZWkNCg==
