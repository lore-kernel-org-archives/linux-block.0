Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF68653
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864793; cv=fail; b=ctMIn58855J7zqUHKnkaoY9U4HuLBkfe2usBedi2QzMTbT0Z0lQkbnU4Ne6gvr3vtAQXX+vqPbkLBUlhUETdVoMugvxXcqfIhgx/mR3SwbWoKyL9IqVAD9rT/i45l5hLQnprkS1apd4WfMNnRU4HR5XZvvSqe9xDvPzKEc1AQ3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864793; c=relaxed/simple;
	bh=tiL/uU7lC/9lW1qY4o/WHn8lRdY9iSXX7WKwP61rj2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qU8G/SQr+UzfGjxWU/V2wgOApI3s9eduWEydYW4Wg4hv8ei3yFNWNA54Q8aaZ4JZggT559yrqXg1b3OWjY8fr7gPBjYGXQnqSWvAeMfe5s3AgKxNNienF2tyPzQcOOeZkeuXxOzbg7lDfnXUyQSb/bHzL/xAV9xUNfZMZ4cCC/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VODMaotS; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VODMaotS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCIgcs4TO2caBHkNsjqkwSJx4JfEusf5W70tBvu5xvTZgFE1L/8DlljtWcu3PJsd/FpfhO/YSxIvkztVgCQqMMiFM/VwR5Kp4Oxy7n/Z+CMuvAFIntYRPCE1P6DPpHRFH9xNi3mDM7XIeyyZ37/Tq5tTWEwMr4R8ZiIvcTJEEgZNcPIfcEZk/gOskmp0989fs2/MkrABkJ1rOZASUB6W0JO2alXmqtS7yBpUn231ApiqSdgF17PdRoxJgBcpnc8RveaJwjCFZLljPlQ/lRMu4UQNCPVuI7bUGTB4WlVRpHSnY+fP4TnSJSAEcKaMiUdFsAAFAfSzjeyYgle8mDt74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiL/uU7lC/9lW1qY4o/WHn8lRdY9iSXX7WKwP61rj2s=;
 b=FHsy6LSOkYjiUqHuVHrtzS3EJiyWSikdnV+tIppcd/sQwvRNVAJcKp4MyeZavBZwU33DT1x4aU3DrcK5pz77dmzCFIuYwG2n5idFJLafI79KYM0OQ0sIz/Y3GIHilVeOAFOi3XoGsbDia0XBrkPnHC4ZOctR8GdrbKVfRFr7tnCy3XLg8MhV0q5zZTwLDBxg2JogELPAXUiOOCSSxHZRjS4VZIZFIwIsq2hHgL3MMDqO43RO67cHyOFqfVsjUxA5iTRBlC2ieqxFGGivjnI3w5r37+L8/kpagzrkO1XlqF+G5HEDVqMks/zSJaI8WsgYaXVD3uFu3M4xjhntDfFKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiL/uU7lC/9lW1qY4o/WHn8lRdY9iSXX7WKwP61rj2s=;
 b=VODMaotSLsYlUFRr10XGMG5knxx92djuN0HUyKchBeikrrlzbECjxqZIDZTEF+etCO/XhiHzEHHO5NivmkhyexpQVgExCIrcWa+46MEP/UMMs8K3okuQksJy9Yf6Ahv173XLHxK7ohFetBe5kfXK4/SWZr1T+XwMtFyikXUQKcUorQZabnTU8YUp117poSrbU3WhtHngPWzqUqmJ5PAv/rH5N8QMhXV9lql5PV2JUTuR7aGVhAKhdsaeofLC427IcVydWayxaQ/3mxB5DRGHJMBQlm7F10MG9xSPBdTasSPUiJVEhTLhQgy1ziq3kuuMwq9IUE+b9jYQ5hYfymcH+A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 03:46:26 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 03:46:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "kanie@linux.alibaba.com" <kanie@linux.alibaba.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] nvme: test nvmet-wq sysfs interface
Thread-Topic: [PATCH] nvme: test nvmet-wq sysfs interface
Thread-Index: AQHbLu/ijN/kq9fajUGjfF8Lslt6jrKoQ2WAgAFbo4A=
Date: Wed, 6 Nov 2024 03:46:26 +0000
Message-ID: <bd5ea038-42ab-433a-943f-d385ccd96770@nvidia.com>
References: <20241104192907.21358-1-kch@nvidia.com>
 <5d603860-33be-42a2-86c9-a10c224c813d@flourine.local>
In-Reply-To: <5d603860-33be-42a2-86c9-a10c224c813d@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB8641:EE_
x-ms-office365-filtering-correlation-id: 07afef69-5679-4fde-e356-08dcfe159732
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUdBM0hYU3Ivd3VOeDQ5VlMwdzRHQVpMaHFBZ05wbGNHUTBJTmUwNEVuQlE5?=
 =?utf-8?B?YlZ6MXpjSytXY2RocHlycWFKUk0zdThyNkwydzcwVDNMK0xBdnF3ay84WkNo?=
 =?utf-8?B?L2dvQnJuSTFWblpLdzNrWDhDY1ZuZWI3K0J4YlVWbjZkb2o5b0FHbStqQk9V?=
 =?utf-8?B?Um5XSys0OXlyVlcxRkdHQW9FT25CcldIa3NQZTQyNWYrOExCYm9mbGtRQjlS?=
 =?utf-8?B?RWEwKzBtK0NBcTZqL3U2emVMekhMV1RLay85RTFkVW1kNjc3NEVlQlhxT2Vw?=
 =?utf-8?B?ZmVOOEtmc0ZnV1d2L25BQlZMZ1RxaFAyN2pYeWp3Vnh1d1R3UlRudXJ2UHF3?=
 =?utf-8?B?RzFTT2Z0c2xnajlOT3RjRTFpclZINmV3Um13UHVXdEgvR3RmVnl0VEExTS8x?=
 =?utf-8?B?bExNOGRlbHN4dFhWR2lKeG5FYmZGU2tXS1F0RExpc3hXa0RzaUVCUTZYTXdO?=
 =?utf-8?B?VXJIZVdyL3czVytISUUwbmcxU2t2NjgxOTJVR0g2SW8zV1FnNGQ2Ym9hZUgr?=
 =?utf-8?B?TkFBS2kwZFpLZHRHdU9zUTI4ZHREZlpSd1FDWnRWNFFMZWlyRzhpZzhHSjVG?=
 =?utf-8?B?TWNUTW16cEMwbEdrTEN6Z3Y2S3RlNktIaS9TOFRPcGdrcXJGRkFMT1krNGpF?=
 =?utf-8?B?QVE4dmxMbGpZdkNtZFV2OUx2TXRPUkQ0c1dtTXFiZzI4TmNGV1ZwWGxnSGl0?=
 =?utf-8?B?S3VMOThnZTE0cjdKekwrNzRtNVRITjRnaXV4VENhMTkwOWlQbDNKS2lqMGl0?=
 =?utf-8?B?akhFalVCbXhobXBobXg2cElsQmtoQkZpNlpxN1huTTlmL3JkZmI3R2t3TDBs?=
 =?utf-8?B?Rk5QMm0wMmxXS0trMisxT0tTMDVuNW1aQks4azEvOWpEWnVpZ3lJUEYycGl5?=
 =?utf-8?B?bjNjWGt1dTVFNG1rZ1BDSnhwTUF2T2tIbGNHbFdZbnVLdWxwU3pJTTBrZHNs?=
 =?utf-8?B?UTRmS3NkMjdVWmhoQVZqcWdxeHU2VzVlNndmRFMyRVNqS3R1eHBoUEhkMk9S?=
 =?utf-8?B?ZHVOODZDUGtRR2cwRlNmd0pnNTMvK25uM2ZyQ01RcDl6b2tBd21PT3F2cHhu?=
 =?utf-8?B?d3FaSXpta3locWk0T0JJUWN1ZFFXcDQwalpyd1JTai9TSWxQNHltVk1KYlVK?=
 =?utf-8?B?aHF0S3BtemxmUHdIdjZoYnZHanRWU0JKNFlDSDZRK1VDK1JKWmh3YS9yU29X?=
 =?utf-8?B?eU1jeTI4MzdvVVBFTlRSVnB1YjRvRnFEMVdoNm84b3RoNnM1RGVlMW42dlo4?=
 =?utf-8?B?K3NsTDNPQkIwa1o2L3UvelAvbXA0elNDb0tQNU84VjhkQjRwbENxYXIyV3Y2?=
 =?utf-8?B?NlEzMVJCL3JvcHJiNUxNTzhlOGkwRUhINFliTU1sQXdGVHA5YnljTlNMZ1Jj?=
 =?utf-8?B?bzBHYSs5a1p6S0w1QnRMdXdhdFJNYnc2NUYwL1ZScU1oNkdSeVJBY2dQQkVs?=
 =?utf-8?B?UHR2U2pFaHJ5YVdqenMycWtHSXB2eEZGemlqZTNjTHFLM3hUd0VibEo1MGVv?=
 =?utf-8?B?ZFdyT0NzUXc0Wk5POUI5MURQakRZZGQ4OWhyV2dQVWl2aG5iQVRWOWRUdXB2?=
 =?utf-8?B?TytPamJpNm5yallIMWhKaUZ5UytHT1BWS1JPakJjb2JWMXJHaGllR0ROZUNF?=
 =?utf-8?B?blFSUHpJMHovdm5zalJRaU5PbW9XcE9BNTdVQUU3bE9mRVZjaG4rRWNRNFNZ?=
 =?utf-8?B?NGlUQkQ5Z3lLWENidis1clBPM3RZOG1vQnRvQmJsSDhvSDhUaXlKSmFIR0dF?=
 =?utf-8?B?UHZvWWZ5eW43QTVib3dLNGNLTlVlMmRmZmM2dDRpRU90aC9Rd2IrVGg2b1M2?=
 =?utf-8?Q?4PAWmpGNmmSWdY1RZQ3w6puT+HdUjwdaSdzqQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTBNYVpCUGg0ZFdNb1YyRmx3dUZFcDFibWVSK1pOcXA2UEZXN3BjeWR3d3gr?=
 =?utf-8?B?SDBpTDI0NW42b1A4Z21hb3haOTNsdlkvcGU2cVdySkdjZlRDSkdDb3FDclF0?=
 =?utf-8?B?NGowRUh4MjBrdjJFWFdjN3ljdlJLcHJ4bVA0MGttQnNhT3R4T0p4ZEg2NDVI?=
 =?utf-8?B?TnRJNW0wNkdaN29iQzZYTG4rQ1lyclJGU3kxOW9rMzNEZFZXNmxmZ1o3cTVj?=
 =?utf-8?B?NG1mUk1TUElwU055dHhnVmlhbGt6UjFLZ3pJckdqM2lWcVI4UXdNQTVCVzY3?=
 =?utf-8?B?S1o1OWJJTG80c2E2R0ozVlJ4ckxMNDBsdnc4NmFDdGVDZk1LeHNtU2JFbURz?=
 =?utf-8?B?SUlNYkNxdm9ZVDNNWGpjU2xra0FZdWxnazlsNnpuZ1hZNmVnZ0N3RWNlelZR?=
 =?utf-8?B?L0RMaWNYWVdSVzRGckdXZWdtQWFzNjAyZm1WRWRBWlhoQVFuU0pHODJSaStB?=
 =?utf-8?B?aW9GZmsxcUVtZmxzYlJFZWl4NGNmOTk1ekt0bCtkanFCYyt1YkRzMDAyLyto?=
 =?utf-8?B?ZUJ3ckJSNWRRWDJ4NHRPY1hpbGp5cHJwdXVua3JxOFpEbWRVSUxPd0FvblYx?=
 =?utf-8?B?YnhPbWdZNUt4cmYvSFNTYnFUVkxNTm13WTZwd3BRV3BhWmEwd1JKN2FOWjdS?=
 =?utf-8?B?YmhKL3UwZ1hSMFV5M2Q3N2RkeVpKTjVMaFZobEllc3FhZ1BkazUyYm1aYmtM?=
 =?utf-8?B?QUcrQlBjT1c4dTBoeHVuMW1acVVFbTg0ci93R1d5R0x2TnhYa1Rhd05tcngr?=
 =?utf-8?B?TCtxSHQrdnQrLzFzRXFKV29ka241ajJyZjNaSGd3MnVyYzBVNkhnaEZWcFZt?=
 =?utf-8?B?bG1URFQ3T3hnaHlPMkt2WjdYQnBGK3hjeUZpMW1mS1d2ZG1JNE43T3VIWXhY?=
 =?utf-8?B?UjlXUWVEbjZtUkw2T2RKSFNuUHVTb1ZhaytTZVVkVWc0RUI1bzg0U2M4eDJl?=
 =?utf-8?B?U0EyZWgvT2Y3VlV0aFVtb0w5eFVOV2FFQmFYaDJRczR6WWl0Lzh3ZGVodEp4?=
 =?utf-8?B?N2o4Y2YyelhIWEQxUlhQTVFWNUNZNnFxdUJGcWFoSzRjL1I2MUlVYXVRNExZ?=
 =?utf-8?B?czhLZm90MTN4cmRGWUpRM0pYckp3am1zSllZanJUWnd4alBORjFOZ3pJQmVS?=
 =?utf-8?B?ZUdDZGs0c3FWZ3ZYYzk4eXZQRHhQd3kzRzQrbXJJa3VnaXp4MnYzUm42bEpx?=
 =?utf-8?B?ZkhGdDE5Nm5hMi9FMWxXZmV4NDJEY0hMc2VwcmtaeSs5MTFZQlpIMFEzVTJD?=
 =?utf-8?B?NEovSVJ6T0FxV0NoNUNseDBKQ1ZjYjdaVnA2NGVkUnZkdS95OGRFSHlwRkpr?=
 =?utf-8?B?QVg0azhVdnV2aWUxVXJYR3ZyZThPS3JmQXJTUUY0R0pnNU4wM0s0UjVQYnlx?=
 =?utf-8?B?bkd1aGhTSG5iUlhud1NBVjZ5bW9VL29HMmpCM0RBTGRZY3VjVlZBYzhiUGxQ?=
 =?utf-8?B?eVFIK2RYM2MrSEE1a29pSXNWTDROdGs5cStSWFB1czdxMmtsSkNsZmlySmtS?=
 =?utf-8?B?ODFKekl5NEtiU2gxckJHMlNpZWZYazhHcFRMcXlWWXFzMzJLVTc5K01rZzRS?=
 =?utf-8?B?RU9qajdQeGVoSHUzdDZvMTdNcExUZUFjbHh6VzZmdlV3NnZnQWZSZjUyMTdo?=
 =?utf-8?B?TmJ2b05HMXprZFkxcWI0aVdEc0NLa0pzZlI3ZDU2RDhaRUh0WE9oUkgwTjFU?=
 =?utf-8?B?clRNOVJ6SjJscFFZaTdKZkFvcHFqSjN3Sit3dFcwZ1ZTSlpoMFVYWlY0U21x?=
 =?utf-8?B?elZQaFZHTXRYcHphbDhhQU42bkNaUzQ2MlFSOEs5WFpPcnhjeFpnWFl4a1R4?=
 =?utf-8?B?UW1Obm54ajdoVkZza3BsVHhpVWhYbFlabGdKZjZYbG9lU0hGT2cyRnczUWhV?=
 =?utf-8?B?MUNzdGtCeXVSVWVoZ1lzRlhZSi96cmNobmxBMlJQNjBlRGVtOWVWTHVsTGxI?=
 =?utf-8?B?RFMwZkZVTmZDQnYyM1hkcTYvSFljQ251VzZFZjF0YU9jamZmMUZZSWhIM2Yy?=
 =?utf-8?B?blk4bGNRSGlJSEgwTVBybUVPOWtNMUZFYW9PMnhzZ05hU0ovZkc1UkNtRDdz?=
 =?utf-8?B?eHBSZ3RUdGptbTFoMm1wS0tLSG9Ocm1DOGRwRS95WFdMOXJObGlJOWpwMVE0?=
 =?utf-8?B?dE4xRnZoVmNFM3RIYW9KWHBkRjNnUHp4RHdDWTlPWG1pZXZaK1V6OHJpbzFQ?=
 =?utf-8?Q?EMnw8g8b0g81Pg2xth6p74oD+w+JCyeAj6k/QWz+UY3O?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <053699A74EF80B43AE8B6AF8FB2BA3E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07afef69-5679-4fde-e356-08dcfe159732
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 03:46:26.3964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHiCUFuoQN+YTBaTR/y8J/ZQfpWFG4JPkZrHXbcmtBgbw46rTAEavpe3+BKxMQ3s9g9n4nrk3v+iMLVTZ1o4Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641

T24gMTEvNC8yNCAyMzowMiwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gT24gTW9uLCBOb3YgMDQs
IDIwMjQgYXQgMTE6Mjk6MDdBTSBHTVQsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+ICsj
IFRlc3QgbnZtZXQtd3EgY3B1bWFzayBzeXNmcyBhdHRyaWJ1dGUgd2l0aCBOVk1lLW9GIGFuZCBm
aW8gd29ya2xvYWQgDQo+IFdoYXQgZG8geW91IHdhbnQgdG8gdGVzdCBoZXJlPyBXaGF0J3MgdGhl
IG9iamVjdGl2ZT8gSSBkb24ndCBzZWUgYW55IA0KPiBibG9jayBsYXllciByZWxhdGVkIHBhcnRz
IG9yIGRvIEkgbWlzcyBzb21ldGhpbmc/IA0KDQpGb3IgTlZNZU9GIHRhcmdldCB3ZSBoYXZlIGV4
cG9ydGVkIG52bWV0LXdxIHRvIHVzZXJzcGFjZSB3aXRoDQpyZWNlbnQgcGF0Y2guIFRoaXMgYmVo
YXZpb3IgaXMgbmV3IGFuZCBJIGRvbid0IHRoaW5rIHRoZXJlIGlzIGFueSB0ZXN0DQpleGlzdHMg
dGhhdCBydW5zIHRoZSBmaW8gd29ya2xvYWQgd2hpbGUgY2hhbmdpbmcgdGhlIENQVU1BU0sgcmFu
ZG9tbHkNCnRvIGVuc3VyZSB0aGUgc3RhYmlsaXR5IGZvciBudm1ldC13cSB3aGVuIGFwcGxpY2F0
aW9uIGlzIHVzaW5nIHRoZSBibG9jaw0KbGF5ZXIuIEhlbmNlIHdlIG5lZWQgdGhlIHRlc3QgZm9y
IGxhdGVzdCBwYXRjaCB3ZSBoYXZlIGFkZGVkIHRvIHRoZSA2LjEzLg0KDQotY2sNCg0KDQo=
