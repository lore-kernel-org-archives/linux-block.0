Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1931448E0
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737557294; cv=fail; b=EWFzsBCzvfcyBEBOg3KiRGZkgJM+3qurpcUqTWFNNBPbTmh8SNOIXQh+oovkjcgzVeRlqUpqW6hh7+jzRrpuv+Frm7wVnIiNmZMywe6KjOtIIpsXgP/U88wKxmyhF2qDjnxfKJJsOhAk37f+9xidzG7ueahTOqOBxiMYTqmVBvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737557294; c=relaxed/simple;
	bh=tfGAxppI9puZ0pTK4lwZ4igbh1lnNjShZBY7+VkNw6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C65qsV/RoK230BYcR4gVcBztgjkeFiHZ+g2N465bUm9M+nx/c4VsggH+sybwA+2WFsxfgnOFwxNaxSUvhq0OBXyd75PU9OTmXN9NtvEIpdUOWoUKce5uHEur4lndqb8uuLy6MC/Nt+3q4XsL/7kh1rLOlnRlIeem93nEo+/m/LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yjDK1G9T; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yjDK1G9T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPCTwTUeIj4JYNjcajIFEpi5TnXL6Kv7zIuV+qcFbg8CMdG87Tr2rpIeSXK/bpoi1gf0tLncztXFWBzIx8AU45aMqM5D08ay5HPDMV5C965n0oDLAm7topLcx47sb5j8E6oXPjGky5fI/5h2V78UVKZDnR/5o3qIxgPL3MhISuAItmCdFIdRL+G88Rs2bRDaIQA/+um6/p+V1f5JmaFy5lRqmA+FSBuhN9mIw9HUZrLPUx4wfF8fVhWFyW2MzD3cTQcJVGmYvCpq8fF9MyuoX8q2bRSuiQK0K1mMkceYOCDKViC0jkIa+THYl4XWTb0Olfu3G/KYuYrfO+1duLZj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfGAxppI9puZ0pTK4lwZ4igbh1lnNjShZBY7+VkNw6w=;
 b=CTBgNUgGYi4P7mYCy0pSsaI5CBq9GOlls4YPbFYLp0KgTA3fKK480oQF/FcfjxEhaWEJfz2/x24dITPOOPipG0pDtENWXnNfmaM8vWcRz5Yazdj2sntf3PoGYucqP5eL0WsjSa9HGAdFXTJS9dUwcI1OZZFXMmFmYx75t358aGKPTFnr0zHzdsoBIHViTsFMXvEzLm/65N9KTnfnLEeqJ8GlSnArVxX12AiLz25aqCV6/w7lS6Team0bCdbkKCG/EBzZfX+2var2aKwRtQMxL3T8fgdcTVnJhk4DwtwBOxlUwBbeBEZEwkvqlXa+OaMhq3CLqSnimo87WrYUdHApug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfGAxppI9puZ0pTK4lwZ4igbh1lnNjShZBY7+VkNw6w=;
 b=yjDK1G9Tjp4uWGo+AyUZgO3xhw87UsNTPo9YzYhB9kfpPlTFAPx+mQkLImj//xPfz9nFBPdr5rUi2d/8PAvNQslqOJDX9+OfJvOHFccnN3AqUptfdIjffm9AVqLfuIGTvpCswxN6n6OHzv2LWnXspGznd5iEqAdcHAWrYsC6AMU=
Received: from IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 14:48:10 +0000
Received: from IA1PR12MB8311.namprd12.prod.outlook.com
 ([fe80::ecc:e2bf:cb33:468f]) by IA1PR12MB8311.namprd12.prod.outlook.com
 ([fe80::ecc:e2bf:cb33:468f%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 14:48:10 +0000
From: "Boyer, Andrew" <Andrew.Boyer@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Christian Borntraeger <borntraeger@linux.ibm.com>, "Boyer, Andrew"
	<Andrew.Boyer@amd.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eugenio Perez
	<eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "Nelson, Shannon" <Shannon.Nelson@amd.com>,
	"Creeley, Brett" <Brett.Creeley@amd.com>, "Hubbe, Allen"
	<Allen.Hubbe@amd.com>
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
Thread-Topic: [PATCH] virtio_blk: always post notifications under the lock
Thread-Index: AQHbYTG5PPtb1U4eCUarxpU24+zL4bMOWgAAgAAcSQCAFICXAA==
Date: Wed, 22 Jan 2025 14:48:10 +0000
Message-ID: <FC65D558-44E2-468B-8EEC-3AF3A0CA15F4@amd.com>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250109083907-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8311:EE_|CY8PR12MB8410:EE_
x-ms-office365-filtering-correlation-id: b64e9222-967c-41df-80db-08dd3af3ca88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QU9sQkt5QjlaeXRkVkJLMFNvZC9BN1p6SWRDaXNaWmdkVWxNZnVKU0hJVTlN?=
 =?utf-8?B?bzloYTBzTDZRNGlOUENraTdTZFNJaFhQMTFHVm5la042VWtYUjk3UnVaQ0E3?=
 =?utf-8?B?d3dEWnhUOHczdjYzbStBZDRmUU54M0hMdUtZT2V0Q2c2ME9IcVNXallBdU1T?=
 =?utf-8?B?YmVwQUNZQXhhZkxmK3BGK0w5NUJjdnc3RHhvUmxGZzNsL3BqZHFEeE1xaXJI?=
 =?utf-8?B?MjFiU1VucWttNWo5d21EM3FhbnZwYi9vS2M4aEJRb1ptTFU5akpHcE82WDNn?=
 =?utf-8?B?K0c2SmFTREtLVUliQUtvOCtvRWVleXcwcHkya2QydTFqVDVvZnczM1plcFI1?=
 =?utf-8?B?NzQrSnBQaHZ0Y21XbmNCZGFoQko1eDM0ZGM2MlBRcnhTa25uTWNqWHYzMjFR?=
 =?utf-8?B?cDJnQkVXYjRYQTJlbUgveGRxQmlkc3g2RU1tTGE3RHVnbk9LOStHbTlPK2RN?=
 =?utf-8?B?YUJEZXA2ZGxkWW5Talk3WXFUTVQ4bzMvMCtqTTBTeGdMdTZZUzFzeW4xdHhr?=
 =?utf-8?B?c1d3enREaEVORTl5WEJQNVhLNTcrandRTHNpV0Q5NGZRWEZ0djRZY2VlanZP?=
 =?utf-8?B?TWFOYSs0ZDByOXdQWFhKUkZkNUVlcFpkRnU5ZHNleXpuTFpqd3MyVlZmOGRD?=
 =?utf-8?B?dGMwbTFNNTR6dkR5b3RIKzJSc29aNTZpSmZMVWtLelRaOEZjTjVDaUVQYlRU?=
 =?utf-8?B?NmljNkN2K25MVEJ5YkhXNXlzSGdIOENUQ3EyRG5pT09aOFZkY3hXUjJrZ05w?=
 =?utf-8?B?Snh2RUJFc0ZjQTNNVHBUMW94S0FJMlJsM21LcW1rNmc0TzFURGVwRHJtcUIr?=
 =?utf-8?B?T3JiZi9kS3lQWS9lYkpYOE55VUlvZEx5Njk2R0dHTDlSckJyenFoRWd6RzY2?=
 =?utf-8?B?WWttemtLV2lldlBoaSsxMHdKRG9DVy80N2xpS1U5TEJRaVF0RlR2bkZma09M?=
 =?utf-8?B?ZktMbHlXRkZEYUFNa1ZrTWpvT3ViZnJXMGs3K2Z1RndJeFJRZ0hiQ3F5aS84?=
 =?utf-8?B?cHZKL3NObmNPYzhNOHFEOHZQelBnQmNDT080U1NCUG1JVHJ6K0JERXNZVlhl?=
 =?utf-8?B?Y1VTM2RtT2FUclpaelQzVnp3RmExZzZwRTF6MzVseU9xaWEySWlyV09JNVY4?=
 =?utf-8?B?UnI4cXduM1diaHdpYkVUN2k1dktESTFmMWxiOCtDOXdXNjBJOXNPdTY3U3BU?=
 =?utf-8?B?YXE2QWpBQ3JUbVhGMjRXeFN5eXVZWVI2czRxUVBkaDV5SndVTUl0Q0VFRW45?=
 =?utf-8?B?eFhxUVFMa1EyTnpqN2hsUWF1Qmd1MXhXWkVQVElkeGp6dFdTaStqRVd3dmlL?=
 =?utf-8?B?WkNMc2VCUFNlV2FYcUV6V2lrTkVlNUVPaktqT0JOWDR6UE9VaEFIV3grczVG?=
 =?utf-8?B?UWkzcW9XQ1RSSTlEUDFZZzdLVXk0d3JscEVHa1Z5QmZtSmxRUEw5TnFoWmdJ?=
 =?utf-8?B?S3hvUVhQamJVVVljWGF1bXU2bStpK1VMQUhqek5hYTUxbHh6eWpaQm5nUFJz?=
 =?utf-8?B?dnNLZ1hTcUhEM1BEbG9pOUFHTTV3MDRaaWsrYVRTcmt2OEVoWFMwVUVmQlVv?=
 =?utf-8?B?VjdWZ3Zuc2tHNFA4TkxIM2NqOGluOW9rMXovVGFCQ3BlZmlNZDViYWk1RkR4?=
 =?utf-8?B?ZU9IVEVkY2h6Qkdmay81NTBKOVpJcmQ3VDkxUWhJWEd1anFVVlRyTHlyc0lO?=
 =?utf-8?B?b2p4ZUNXNmpJMVdiSVVMcDlwd1M4NWI3R2QyS3FvSHp3djJuYU9iby9ZM3pp?=
 =?utf-8?B?K1JiLzRrd2pFdElMRUZsZk84aGJaTDRZVnNseGg0c01sK3R6QlBFQU9LaTFr?=
 =?utf-8?B?M3ZRUzhzbEdqaDJuYXpWMGJiTnV3MVgwSnhnUEdkdnhIb0x4OXU3YWdxRk5s?=
 =?utf-8?B?M01SUUFGbnd4aUs3WjBseEhPOUdHd1pFQ3ZPNS9jenY0OFp6YXJzQVp4c0lS?=
 =?utf-8?Q?rQ9NxdL54wza5KurBgWVtd7QSY33846v?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8311.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHRzR3FQaGZpMVdoVUtWZXFKQlZwbExYVVQ1M0UxdlF1TkFHckJ3d3VkOXdr?=
 =?utf-8?B?ZWFjdGtWMHdsWVprOUNScW05dVR1VjBnOFVEVGhuYmxvRGQ1bmpsQ25RNXd3?=
 =?utf-8?B?UlgxUEtrak9JelloRVFEZXVCUmlXZ0p4M2ppM0x6NnVFZUZjZHJSRkhoTlh0?=
 =?utf-8?B?NFBzWktYK0JCTGxKZm50UHVmb25DbzdJZitYYVlDKzh3T09BbmFtYWpsbG9G?=
 =?utf-8?B?SGpLUVFrRnlQN1lleG8vTlIvb1hpL1hJODBjTE40cStlOXVwT1VxM0ZKcVdF?=
 =?utf-8?B?VVpFV21YWStMTmZOZU42S2JtbDQ3QVVoM09XVENPdjJiQmI3NW5kUVl2QjVM?=
 =?utf-8?B?YldpQ3JLaHhyQ2xaVklwQldYWDFWMXZxSGxQd2lPZHBiZ0U5NE5JQTd4ZHFO?=
 =?utf-8?B?RzFGRnorN05Qdm00QUJnWk1qeFBnMHhMcFVRSExodVVHZkhyZzdFcndBSGRn?=
 =?utf-8?B?eU5pdUFrMmdFZkwvdThlVjMzbnRyRTAyU3ljaXhFMmppbGhya2VvMzU2OVBi?=
 =?utf-8?B?cEhwN2JleU43cFY3MmN0c2RaWUF4ZXRSbm1sSVRNUFBacy93VHJxR3lZZzJs?=
 =?utf-8?B?L29JS0h1Y3BBQkZYOHE1MjJDZmdJNm1sbnFrK2xUSnE5K3RUUFBWcWRib2RU?=
 =?utf-8?B?ZnVmT2djYWZBWDV4Qnh3SVIxZE9Cbmx2NHZ4WHJkbGpxRllGOXV2Y293VzJJ?=
 =?utf-8?B?ZlJ0Q0ZxckJxN3pGU0R3a1lSWDB5V3ByRkV2bDdUL1ZUT1U3d082RWJJZE12?=
 =?utf-8?B?TkV0d0NKZ0xLSE1sR1FLL1JsRnorejdjM3dFTmo2dnVvamhjSS9JUlhpWXEr?=
 =?utf-8?B?eDl5Z1F0SmVrUWJGMzBkNk13Z2lYb2tQZFpCOWZ3NHp1cE9VejNoTWY3dEJO?=
 =?utf-8?B?TFJJcGdwZXE1OWNYUXR2TDRLWFhaNUhZd2NsUDVlWHZZdmRFa2hZaVBTMFF3?=
 =?utf-8?B?UzhvYUhJVjdRaFdaV2Y0Rk01clA1OEhxYSszQjZydHBYSGdEMktCckFIdnNv?=
 =?utf-8?B?NkF3QjZFOWJISDhRUzgrVlRtbUhibDJhSXpvNG45N0FqQXhINHlNOGVFS21j?=
 =?utf-8?B?K2lBY05ZcmtrTmh3emxXbE9PRUNmZ1E1R0UvOU81ZFpobXZFVHNHYUlabnBG?=
 =?utf-8?B?cW4vM3B5WUczUWpsYlJ5REJra2h3MlJjMDlXRk9qbWxPMm51QW5JY1lEY0p5?=
 =?utf-8?B?T1krQmlPc1NwaFZOZER2SXlBY3FVY2JPSmNXaUpmeEM2VWV5cno1TGFKdnhm?=
 =?utf-8?B?K2pBYmI0SFZpSW9ZSkFVZUhUZktWeDI3TW95OC82ZE93R3pac1dNU0lNb001?=
 =?utf-8?B?cnhRTittMWJBamZaSUQ3RCtxcGFLZWhzMytWNjhLaVcrMXJEZy9nV2ZQNHoz?=
 =?utf-8?B?djVBWG9qYWM5VXE0YjB6NnRJNW55eWFaNThHRDRVS0xpZVR5bWp1TDVxb0s3?=
 =?utf-8?B?Sm1zUDkxeE51MXdZaGpjMTNHMzdrQVRFRjZMYjkzcSt6Mi9MaUFzL2pMYkcy?=
 =?utf-8?B?T3U4aEk1anZFVllZTTZyRE5VUytURjJBd0tJUEdCV2hBRW1tUnZwdWs2OW5q?=
 =?utf-8?B?c3FxZ2ZkOHpuL0hTSHZwdDJHTmVOTWpuU0Y1WFgxRW5hM2E0ZTRZWkt4amxQ?=
 =?utf-8?B?cmg3VzB0NmRUVk9QR2QxcDBFWWJpVSt3VzRkNkZ1TzZlWnhTTGNQSUJmek05?=
 =?utf-8?B?dWJVOEZtRDFBbm1JVFJLZ0srQjNpNUpNejJmNS96Z3BHL0F2Unc3VGQxTWJx?=
 =?utf-8?B?cGVzbTdWVDBzK1FEK3V1czBUMlBKOHdmY1lyL3JneHJOQ0xWZURyT0UrV0VL?=
 =?utf-8?B?U3R2ei8yUkxBZkxFWVBIU0IwSXJLdVQrbGhldDBhejR6TU1FV1pJcHlSSzE3?=
 =?utf-8?B?WDVZdTlxUmJDWkF2V3FKcktmMTN0cEhtZk0rSXloVFBHNWk4WVJCeTEyUERX?=
 =?utf-8?B?YkhjTG1hNmhxdGdCWFV3TGNpeDlLc0pMZm9xYUxSRXpyKzljaVJNNUlIeFpl?=
 =?utf-8?B?djk0R1lyOXJJai9CQlEyTUhIN0MxanJNYWZhWW5UbUUyem42dHhQTWxJL3No?=
 =?utf-8?B?NUpML1cwQTRpbk5tZHpVZjhLQS9hL3N5T01yWENUK09GaS9HRHVGUVBJVWFk?=
 =?utf-8?Q?jS5A8XDVzlCnu4CYe46NFdrgj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C75B3580C0A4774B8221E3AE2A2150AE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64e9222-967c-41df-80db-08dd3af3ca88
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 14:48:10.5467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYCSkwhcUzuA2vsIIS9P0ZaE6IRkTET5a9nFub+AxGqsuAs3C92PfUOuETUW9EnD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410

T24gSmFuIDksIDIwMjUsIGF0IDg6NDLigK9BTSwgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEphbiAwOSwgMjAyNSBhdCAwMTowMToyMFBN
ICswMTAwLCBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgd3JvdGU6DQo+PiANCj4+IA0KPj4gQW0gMDcu
MDEuMjUgdW0gMTk6MjUgc2NocmllYiBBbmRyZXcgQm95ZXI6DQo+Pj4gQ29tbWl0IGFmOGVjZWNk
YTE4NSAoInZpcnRpbzogYWRkIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBIGZlYXR1cmUNCj4+
PiBzdXBwb3J0IikgYWRkZWQgbm90aWZpY2F0aW9uIGRhdGEgc3VwcG9ydCB0byB0aGUgY29yZSB2
aXJ0aW8gZHJpdmVyDQo+Pj4gY29kZS4gV2hlbiB0aGlzIGZlYXR1cmUgaXMgZW5hYmxlZCwgdGhl
IG5vdGlmaWNhdGlvbiBpbmNsdWRlcyB0aGUNCj4+PiB1cGRhdGVkIHByb2R1Y2VyIGluZGV4IGZv
ciB0aGUgcXVldWUuIFRodXMgaXQgaXMgbm93IGNyaXRpY2FsIHRoYXQNCj4+PiBub3RpZmljYXRp
b25zIGFycml2ZSBpbiBvcmRlci4NCj4+PiANCj4+PiBUaGUgdmlydGlvX2JsayBkcml2ZXIgaGFz
IGhpc3RvcmljYWxseSBub3Qgd29ycmllZCBhYm91dCBub3RpZmljYXRpb24NCj4+PiBvcmRlcmlu
Zy4gTW9kaWZ5IGl0IHNvIHRoYXQgdGhlIHByZXBhcmUgYW5kIGtpY2sgc3RlcHMgYXJlIGJvdGgg
ZG9uZQ0KPj4+IHVuZGVyIHRoZSB2cSBsb2NrLg0KPj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IEFu
ZHJldyBCb3llciA8YW5kcmV3LmJveWVyQGFtZC5jb20+DQo+Pj4gUmV2aWV3ZWQtYnk6IEJyZXR0
IENyZWVsZXkgPGJyZXR0LmNyZWVsZXlAYW1kLmNvbT4NCj4+PiBGaXhlczogYWY4ZWNlY2RhMTg1
ICgidmlydGlvOiBhZGQgVklSVElPX0ZfTk9USUZJQ0FUSU9OX0RBVEEgZmVhdHVyZSBzdXBwb3J0
IikNCj4+PiBDYzogVmlrdG9yIFBydXR5YW5vdiA8dmlrdG9yQGRheW5peC5jb20+DQo+Pj4gQ2M6
IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldg0KPj4+IENjOiBsaW51eC1ibG9ja0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4+PiAtLS0NCj4+PiAgZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMgfCAx
OSArKysrLS0tLS0tLS0tLS0tLS0tDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDE1IGRlbGV0aW9ucygtKQ0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2Nr
L3ZpcnRpb19ibGsuYyBiL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jDQo+Pj4gaW5kZXggM2Vm
ZTM3OGYxMzg2Li4xNGQ5ZTY2YmI4NDQgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9ibG9jay92
aXJ0aW9fYmxrLmMNCj4+PiArKysgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYw0KPj4+IEBA
IC0zNzksMTQgKzM3OSwxMCBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fY29tbWl0X3JxcyhzdHJ1Y3Qg
YmxrX21xX2h3X2N0eCAqaGN0eCkNCj4+PiAgew0KPj4+ICAgIHN0cnVjdCB2aXJ0aW9fYmxrICp2
YmxrID0gaGN0eC0+cXVldWUtPnF1ZXVlZGF0YTsNCj4+PiAgICBzdHJ1Y3QgdmlydGlvX2Jsa192
cSAqdnEgPSAmdmJsay0+dnFzW2hjdHgtPnF1ZXVlX251bV07DQo+Pj4gLSAgIGJvb2wga2ljazsN
Cj4+PiAgICBzcGluX2xvY2tfaXJxKCZ2cS0+bG9jayk7DQo+Pj4gLSAgIGtpY2sgPSB2aXJ0cXVl
dWVfa2lja19wcmVwYXJlKHZxLT52cSk7DQo+Pj4gKyAgIHZpcnRxdWV1ZV9raWNrKHZxLT52cSk7
DQo+Pj4gICAgc3Bpbl91bmxvY2tfaXJxKCZ2cS0+bG9jayk7DQo+Pj4gLQ0KPj4+IC0gICBpZiAo
a2ljaykNCj4+PiAtICAgICAgICAgICB2aXJ0cXVldWVfbm90aWZ5KHZxLT52cSk7DQo+Pj4gIH0N
Cj4+IA0KPj4gSSB3b3VsZCBhc3N1bWUgdGhpcyB3aWxsIGJlIGEgcGVyZm9ybWFuY2UgbmlnaHRt
YXJlIGZvciBub3JtYWwgSU8uDQo+IA0KDQpIZWxsbyBNaWNoYWVsIGFuZCBDaHJpc3RpYW4gYW5k
IEphc29uLA0KVGhhbmsgeW91IGZvciB0YWtpbmcgYSBsb29rLg0KDQpJcyB0aGUgcGVyZm9ybWFu
Y2UgY29uY2VybiB0aGF0IHRoZSB2bWV4aXQgbWlnaHQgbGVhZCB0byB0aGUgdW5kZXJseWluZyB2
aXJ0dWFsIHN0b3JhZ2Ugc3RhY2sgZG9pbmcgdGhlIHdvcmsgaW1tZWRpYXRlbHk/IEFueSBvdGhl
ciBqb2IgcG9zdGluZyB0byB0aGUgc2FtZSBxdWV1ZSB3b3VsZCBwcmVzdW1hYmx5IGJlIGJsb2Nr
ZWQgb24gYSB2bWV4aXQgd2hlbiBpdCBnb2VzIHRvIGF0dGVtcHQgaXRzIG93biBub3RpZmljYXRp
b24uIFRoYXQgd291bGQgYmUgYWxtb3N0IHRoZSBzYW1lIGFzIGhhdmluZyB0aGUgb3RoZXIgam9i
IGJsb2NrIG9uIGEgbG9jayBkdXJpbmcgdGhlIG9wZXJhdGlvbiwgYWx0aG91Z2ggSSBndWVzcyBp
ZiB5b3UgYXJlIHNraXBwaW5nIG5vdGlmaWNhdGlvbnMgc29tZWhvdyBpdCB3b3VsZCBsb29rIGRp
ZmZlcmVudC4NCg0KSSBkb24ndCBoYXZlIGFueSBzb3J0IG9mIHNldHVwIHdoZXJlIEkgY2FuIHRy
eSBpdCBidXQgSSB3b3VsZCBhcHByZWNpYXRlIGl0IGlmIHNvbWVvbmUgZWxzZSBjb3VsZC4NCg0K
PiBIbW0uIE5vdCBnb29kLCBub3RpZnkgY2FuIGJlIHZlcnkgc2xvdywgaG9sZGluZyBhIGxvY2sg
aXMgYSBiYWQgaWRlYS4NCj4gQmFzaWNhbGx5LCB2aXJ0cXVldWVfbm90aWZ5IG11c3Qgd29yayBv
dXNpZGUgb2YgbG9ja3MsIHRoaXMNCj4gbWVhbnMgYWY4ZWNlY2RhMTg1IGlzIGJyb2tlbiBhbmQg
d2UgZGlkIG5vdCBub3RpY2UuDQo+IA0KPiBMZXQncyBmaXggaXQgcGxlYXNlLg0KDQpXaXRoIHNv
IG1hbnkgYnJva2VuIGtlcm5lbHMgYWxyZWFkeSBpbiB0aGUgd2lsZCwgSSB0aGluayBkaXNhYmxp
bmcgRl9OT1RJRklDQVRJT05fREFUQSBmb3IgdmlydGlvLWJsayB3b3VsZCBiZSBhIHJlYXNvbmFi
bGUgc29sdXRpb24uDQoNCj4gVHJ5IHNvbWUga2luZCBvZiBjb21wYXJlIGFuZCBzd2FwIHNjaGVt
ZSB3aGVyZSB3ZSBkZXRlY3QgdGhhdCBpbmRleA0KPiB3YXMgdXBkYXRlZCBzaW5jZT8gV2lsbCBh
bGxvdyBza2lwcGluZyBhIG5vdGlmaWNhdGlvbiwgdG9vLg0KDQpEbyB5b3UgaGF2ZSBhbiBpZGVh
IG9mIGhvdyB0aGlzIG1pZ2h0IGJlIGRvbmU/IEFueXRoaW5nIEkndmUgY29tZSB1cCB3aXRoIGlu
dm9sdmVzIGEgbG9jay4gV291bGQgaXQgYmUgZG9hYmxlIHRvIGhhdmUgYSBsb2NrIGZvciB0aGUg
dnEgbWFuYWdlbWVudCBzdHVmZiBhbmQgYSBzZWNvbmQgb25lIHRvIHBvc3Qgbm90aWZpY2F0aW9u
cz8NCg0KPiBBTUQgZ3V5cywgY2FuJ3QgZGV2aWNlIHN1cnZpdmUgd2l0aCByZW9yZGVyZWQgbm90
aWZpY2F0aW9ucz8NCj4gQmFzaWNhbGx5IGp1c3QgZHJvcCBhIG5vdGlmaWNhdGlvbiBpZiB5b3Ug
c2VlIGluZGV4DQo+IGdvaW5nIGJhY2s/DQoNClRoaXMgaXMgdGhlIGRyaXZlciBseWluZyB0byB1
cyBhYm91dCB0aGUgc3RhdGUgb2YgdGhlIHF1ZXVlOyBpdCdzIG5vdCBnb2luZyB0byBiZSBwb3Nz
aWJsZSBmb3IgdXMgdG8gd29yayBhcm91bmQgaXQgaW4gaGFyZHdhcmUuIEZvciBzdGFydGVycywg
aG93IHdvdWxkIHdlIGRldGVjdCBxdWV1ZSB3cmFwIGFyb3VuZD8NCg0KVGhhbmsgeW91LA0KQW5k
cmV3DQoNCihBcG9sb2dpZXMgZm9yIHNlbmRpbmcgdHdpY2UsIG1haWwgY2xpZW50IGlzc3VlKQ0K
DQo=
