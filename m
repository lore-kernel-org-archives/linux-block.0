Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647626;
	b=MWDePaZ0ApjM5IkYJ0ePLIwrWIGxJJWaHI50fM3mW+8CbFsE+M/wTFMsHnFgxTuKqjH6
	 DEzzLIpkk3lKl65RG5k4qbQmNMuH+yZGmMH7dRrbIH9cLPaIzkXElIkIh+L32Pq+XoSQz
	 qdIZj0Oy3f+0XKxCGFx2SCYxwks5RygmOWgy5F48878Ae/PMD0TKjom31r421NUENMXdj
	 faWI/eW2K21PhLTaawGo6AqqfuRtQwHFi6lJV6P6NLtKS+2/z5i19e6cA3aA08sEHLm0S
	 +5DufjPmMoaAWOpN/R0kV2C+0dYs+HHnCqdgg4q4azZOnJVF9LwT61Aho/aGFx4omiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647626;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=THdUqiuckdMXBVc38pNnZDO2uOiBGPDGq5e7Q/ZPk9Q=;
	b=vFWY3WEC9eyONVTsEWJE0+TRVA7iPzCvFedCjMdexLiv81rPGbUFZzrZhDFJFWkI+PX6
	 iyTDhwlD7P1xgBL409dII1p9PtsyER21Mc0SYnx2PKVxsgN7fShrzTeEZYRxbIqHWg8HI
	 atZgjkXfQQf3ZjntfcHXiLTrjRoqLF9PK9eAvp1cW6TUtXTU0s/Z+e6lgOd1C6QObhM7n
	 daX306VNknZvTSe1Zil1AyNqXqQjWelTFrO1muI4u/HpsTcfHDwS8LJuVXMmc97tBI05r
	 TgtGe2WKZ2GqGAkUbxBJbzkzy0UQGTzep+GP2rUsA0niqy/8WaELqNr0HzI6oVohYdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qguv65p6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.25
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011025.outbound.protection.outlook.com [40.93.194.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80035606A339
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 23:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80035606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qguv65p6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qarPDBZgDT/WqqH5rI/m3WamqJ5bV/mNylXvWb2xsvgu9v9dNMsP5wIJ/SZP63wdOHnY5u4qTQ4CJLSHjfWvc/cxUAJtkF9NqJij21RR0CWU8lBPjQEY+sMJMkz1hWaPLoj8upbpWvlnJULtHCxKyyiSvEI7v9+moorEUQhavCVUxoQwPLimSpvyWmgR+HJh5FjKo3NC1WIG0MDOU1dH39ri4/muKE+xJ62arTodB+YooPGIkdZ10Y8HVTFtAR/G14JKBWxCj21oBdB4uBmWTOlQUc4NqgwHKwHFjEGQuBRUdJE8/Obh4ygp4vgzt3zpiVxvRYVm+0Aj3KZ1n5ryUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THdUqiuckdMXBVc38pNnZDO2uOiBGPDGq5e7Q/ZPk9Q=;
 b=eBtyAX2Ptuk+RRtgKCPaI+Fzz5azzJ4aLO/K5MZ3x4pSHis8j0uvb8ekMdliMTKVZZ91TxeVpAq66zeSJu5ZYvdWmDddjZe/c+z7qK5n8c0lweu8UGGrI0ZWrQYcGH67GNrPuKPNbvUfGth+rLgtTX3WFx9B0y2T5ynxUoaLkx2nH/mt4xDOTVntQa9KAuEUPaV8IoOCgQjoXpc7CzSV6UPlleipl63YWAOkVRKbWXW8GFOKMVb1dNzNO7FsCVvnHkD9rvdu4m8UCW8TAC6XSAgP1ykBZd6Zt5ZEVuQYQxkujeX3QBgSuSFwObtHMJXfM9X0rN5kyNdDegXj2e9pnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THdUqiuckdMXBVc38pNnZDO2uOiBGPDGq5e7Q/ZPk9Q=;
 b=qguv65p6J28+w1JC8A43aETpxxZehU8XJiCMhpc7bC9qwqZSEEYBLd1STlEdCrJSrswbf5lwzF+nGXvj2rwueofYiOyUmQ9+dhs6bM9HG9xPncb0zwtGRXYsVUaNMXu2ekBj3uHGGwqJKl8nh+IrZgzdZ27jcO7h827m3GKiUrn0B4sudk4AAJqB4/Wj13E78jHDrGoMHvq3LpfpcEpmyBxuh4qcNx7jiqm0shnnUpZYOPCOLEBJy1+wJp4jWpcN6X+4+bh66zpnqyNI27mWqVvHpi9S34ZE24jqNS/0T7AgapqzqXyCmB71eOWhrBOXh5DzG/nyotteE1gu1D2yDg==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 22:59:48 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 22:59:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: Christoph Hellwig <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Hannes
 Reinecke <hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 2/5] blktrace: pass ioprio to tracing data
Thread-Topic: [PATCH 2/5] blktrace: pass ioprio to tracing data
Thread-Index: AQHdfBjPeLGMGoccvEG6oojwiW/oS7c/aSUA
Date: Wed, 25 Nov 2026 22:59:48 +0000
Message-ID: <9a239696-2fb7-4f07-ab89-ff71e492506b@nvidia.com>
References: <20261124133553.152463-1-johannes.thumshirn@wdc.com>
 <20261124133553.152463-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124133553.152463-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|CH3PR12MB7644:EE_
x-ms-office365-filtering-correlation-id: 93de92a2-3f7c-4557-211a-08df4b47ce59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|6133799003|18002099003|22082099003|10067099003|261102123227099003|11063799006|56012099006|261026121527099003|261022105027099003|261026140227099003|261021121427099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info:
 +s+HHxeM5SYWZJzHAvpTSwISNjs3VUhU4LQwdemdcwSpuov2Ucc7RSIAc5wg9NWUNQO6nHm35Swywbzu6/WNjlLGXUKsTn7/A4wIpYyg24w9lfjmdGkuIG0mRDzjRNK+m5nLrScHbdtJTMuZawy1ohhKFbl9cZjeZVVq9aZjz7SxggHIhBXxfZqOQjd8UiXSS5VUirWvfTP1B91XloznzacHo4AZLP+ZVMLy8bh9svl8MXA6aOe3Ec4Gm9x50e/AdHeh1uBxcTa3kzzlfEHWb4kKf0y+J4hfd6jb9iq4qy8Y8n55DL/kQsEZSCSAWS57paZ9YfCwQfq3vleDprwucSxzfSfyrYIIj8xN1vaVc8uqvO3izOKqGis9PEHKUX6CIoRRYUbC0Jpmh+Cud9kaiKa4g29NOI5mUhP+OW8YAsDlxwFRcCvGWwRWp79zDBZjVqETIfEPgAEwMkUQPeKKT8hq8MFgU62kNsvN2TRr7XSD97YMt4VRD7Qi3B+nHaO+h/E9c/GNXgMbq2CzJFM2RBhaQcSHKX5RVu1W6Nr1kmt682VOmJFH0CkttdEZKSv1gkBvxT7RmYAS+nwfwzb3pvFdd3qlh7THA7D64s5YXXgMkxju/44SbUvdUy+pbPxT9itWJBaGMKPvFFkGbTa9KZFe2Nz3xHv/hCjIgBnA0YVfgbLDqAeTW1+ReaGfOZCPye7CkBckgwtke+UpXh/eCSqmxK7i8MdKavUgn65GuSw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(6133799003)(18002099003)(22082099003)(10067099003)(261102123227099003)(11063799006)(56012099006)(261026121527099003)(261022105027099003)(261026140227099003)(261021121427099003)(261028144727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1FuaS85cUxaaXJvN201bnQwbmhzdHh5M05ZZ0lpK25EUnJJcWtxRnR6ZGhT?=
 =?utf-8?B?eGk4bXR3TVZxYk9ZUyt2UzVpMXByTStPNVVYWXFzTUV5WFRZU3NHMGphMWpY?=
 =?utf-8?B?Y1RwTzJ4UHNZMEFtWWd4SllvQXJKaENZaHNaMGVmY0swWGhLVkVvd0tQbEdi?=
 =?utf-8?B?K3gvWUIrSjkxdmkzVnByVTFJUm10cklzYWIxQnExb0FzTEIwRFBuTkhxQzAr?=
 =?utf-8?B?YllPT3ZQN3YzMi9NbjFLR0U4TGdRbTd1Z3A4TXNOYTIyUjJYOS83WnlkNXZK?=
 =?utf-8?B?Zk5NWGxQaE00M1M5ZERXMUl6bnAxN20wcUF5RFl1T3R6c1Q0WkNraWZsR0Nu?=
 =?utf-8?B?MnJLYnNYWGd6cnpuT0RhbTdnMVByV3FVcDRBcmd6UFYvUGRISFBrSXdkaDl6?=
 =?utf-8?B?R2k4dy9haHBnelgrbjhQck56eDZSNkIvM0VERlNqMnRBZktjczQ0Z2tKaUtt?=
 =?utf-8?B?dGc3WTNOYUR0U1dodDIyUWt6UzBucFpUb3ArVEVzdUtBY2dLOTZpZXl1cDZu?=
 =?utf-8?B?YU8weHI2T2x0Ly8yWlpXY3hKMzZJVGg0TG9qUnhwSHR0V0M4dkl1Rm9SeThl?=
 =?utf-8?B?bUd2S0N5TCtseXp5eldsQUMyaGRCL0VFcjloWTJ2MmE3dE1HWXRuT2ExbFN5?=
 =?utf-8?B?RjZ0Y1NhdVY4L0N1T2p6YXkvSk9QcE52bzAxZ3FpNzFVS2UwOXlsTDBpWVhy?=
 =?utf-8?B?cSttbDcrQ1hWK2w3N0t3S3VUTkc4c0tOL0JxOFdLMDhpcFhaT0FWTzZTTlVn?=
 =?utf-8?B?RjY3SzJXM2wwUmZ5SGtSeXQ0alhiUmtxUHFTVXFZUnpGVzNUTjNaNVl4bFZ5?=
 =?utf-8?B?SVFsKzhwTmVZSzFBTWdmU3RPVHVMQytYaElXZnlHZ05WOUFzNWEvZWpXOUoz?=
 =?utf-8?B?SEQrbHFUMjZYOXJZYXBzVmlhaTJWaExFSTNKZ1JSWSs5akxuTGVWMTJBTFpt?=
 =?utf-8?B?RWRWLzhJbTdiSHE3VE1ManFJaE1MMkczUlRMUVNRc051M0pTSVZ6d2tLN0Ey?=
 =?utf-8?B?VW1Lc3hJTlVwYUJKeVNOR3pLSVQ4TWR3YTQ0Y0pzZzZFV2hLbVg3N1gxYWVC?=
 =?utf-8?B?eUdKN0NKRzBCWEJ0QUhWUnF0M1RpZGdlbnppZzlhcUQrVDE2b0k5RUJCbGV0?=
 =?utf-8?B?L0xZaDIzVkI3d045TEpOYmpUWFBXaEF6TThTRUNRNXBzcFdHK3V6U3BhWXVC?=
 =?utf-8?B?TVB1cEZGNWIwMUpJclhuL3VmcjdSRjlKWnNyUGdrUzJoVlhqcmtydTlLVHBw?=
 =?utf-8?B?NzJ6dnZWc3pndkVXdXF4M3pWbHBRZWVUenV5UitUdTliYllkRDRZeVMyb2ZF?=
 =?utf-8?B?UFZZQk14ejN0aVJNWmZROFBUeE85L1dWdElPQ1JzUmJJdGdKMU5ieTFaalRi?=
 =?utf-8?B?UlZkK1dFcDhxcHNuK1IyZ01nZnNjUEMrVlQ4SVVMbVFiekNtY2pqZVg2Q0pK?=
 =?utf-8?B?djZQMUZVUkIyNnU0V0l3dHVubDNJYWQ3dDVyNUFtaWpoM1JhOWNtbzQwUFBF?=
 =?utf-8?B?Q3AzUmoxdmtxMzlPU3JNb2hQUmsxTHZIbnV3dFZZY24wOW1sZkt4ckUrbndR?=
 =?utf-8?B?U2hnaGwySWFDQ3JQS295M2ova0t4MEw1aW81VUhuSXRzdHI1dE9NSkVlWERL?=
 =?utf-8?B?YXpIbGdEVm1wL0RpNXlzL0taUnFOdkEwRXlxWVYvMC92SmVGdmQ4eGI0VVd3?=
 =?utf-8?B?UGdVK0V6My9iT0ZjM3M0M3QyeCtwVWJDbzAvdk93b2tMajJQRnJqNG5mUG4r?=
 =?utf-8?B?TCt1dCtaVDdoZzZldWR0TktnaktROEJ1UlZCdS9XZ3BVMjdnQVhrbmJ6am11?=
 =?utf-8?B?S3hjUm5hTjJWMUQ4eDhKOVUyRGpIa3hlMkFLYk5GRjg3aWZPWnpUWmF2MFc3?=
 =?utf-8?B?TGt4Z1VRN1B4bGpZZlF6ZzlnVFVCMkc3NEJsdUdHVzhDalJlVzJ5TXVnZ0hl?=
 =?utf-8?B?SlB1cU80VlBKclZzNDJaS05wZEcwMnRRd3k0eS8wRlQ1U1Y2VUxwWmRldmJS?=
 =?utf-8?B?OEVvNlJxSHdGbVBqdm0wbDhWZ3pxMXpVY29NU1o0VDYzV3FQdmt0SXNMZ3Fy?=
 =?utf-8?B?Mm5Wc1FrWmdjN3dGTnhBbWxOQ0QxQ2g4d1BHR0tnZEZkSi95ZEd4S0FDbmti?=
 =?utf-8?B?R0xFOEVpS1BTVUxVd1h2NU5BM1VHNFU1Nk5GUEgzT0djd3dBN3lmclpjSDFU?=
 =?utf-8?B?VGN4dFJiZVdpbGVDVFJxZHoxS2VTT3pseEt4VFVyY3J1SFVkWmhzNW9ZQXNk?=
 =?utf-8?B?dk96NHFwL1QrQUFHRFN6TE90NEExL2RjdnEzQ3R3UHBhQlBEZ0JJdGpDcE1q?=
 =?utf-8?B?U21jeHYrVWFJN3JxYzVQclhlZCtsS3ZmWE5DVktyeGhrN3pmQ0MxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8ACB2C9330C6BE4C9FCB8C3FF45340DA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93de92a2-3f7c-4557-211a-08df4b47ce59
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 22:59:48.6518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7fw2you7w2WKE8AJZ5O8nOIiNnhacW4oMikhYKm8mcJxGYd2W7INhjSBSHBbVDMlZ7o/iThOh/D9nznjKm+jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

T24gMTEvMjQvMjYgNTozNSBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBQYXNzIHRo
ZSBJL08gcHJpb3JpdHkgb2YgdGhlIGJpbyBvciByZXF1ZXN0IGRvd24gdG8gdGhlIHJlY29yZGlu
Zw0KPiBmdW5jdGlvbnMgYW5kIHN0b3JlIGl0IGluIHN0cnVjdCBibGtfaW9fdHJhY2UyLiBFdmVu
dHMgd2l0aG91dCBhIGJpbyBvcg0KPiByZXF1ZXN0IChwbHVnLCB1bnBsdWcgYW5kIHRoZSB6b25l
IHdyaXRlIHBsdWcgZXZlbnRzKSBwYXNzIC0xLCBzbyB0aGF0DQo+IHRoZXkgY2FuIGxhdGVyIGJl
IHRvbGQgYXBhcnQgZnJvbSByZXF1ZXN0cyB3aXRoIGFuIEkvTyBwcmlvcml0eSBvZiAwLg0KPg0K
PiBObyB1c2VyIHZpc2libGUgY2hhbmdlIHlldCwgYXMgX19CTEtfVEFfSU9QUklPIGlzIG5vdCBz
ZXQgb24gYW55IGV2ZW50Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm48
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==
