Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647711;
	b=hbNBfWIMRKEeViC/v/FiWzPdwDaltf18M7mxc/sj4vCtTHre8yM6Zjz4dIvFvdZPB+ae
	 a5LqrjWlYQ1UzjH3nEA8ZfUsfxwa/1Z78gJYWH4NRVnkC67ibf1a6yB1oXzOXz0nro5cL
	 gU2S1hpWxrLC/9kz9lA6LQAuytSkAyS1ECdO/MtBOAG16G5fJSHWuOJ4bNHn+HFSSuaul
	 o0tNaN9Vbvx1wecnj4QnKIm2XQ8EApOQKEaiFn/0rDDIoy4AxebOXRkGJSD/cU+jUUWf0
	 OM7AqSyDX9VSIxSxNWeFj0M1LLQYYrQiApuxDbOLkYSYySKp1/XTF2nVcmAZ/GMqGvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647711;
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
	bh=1Fs0TCAD45B1xfpftwl7ypd4aDyu+TcX7XHmo92GEOI=;
	b=yKrDbTFnYRe7umLREwPWrSNsBC1CIriK36hLsU1Us2M0GmAq+YzR/tFBS7XfXnvPsKq8
	 M0GOS3o7qYNRYPffjHME2PyXGmcs4r7msISm1L2cBc2JpqRaaUlp317h8QOxVaEo2twbn
	 +oi2v0IW40sMGcers83saGPvQ9KB/k7yZmAGwCJI5GtfLgFA0QK/Bs3z9CKJJKXkEscpG
	 oAkx8usSv7VG+c3n7hY4Ux4jeR8GiimO40bjvkGy1MI1yHbnkuGkGxdiRjvNN2e/BpS+p
	 XzP7fvl1v2SAuv5ezohewDQMzPGy7RA1CXcAWJ8MHTLw70kENQ8LZZX58tCz8eQhOeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ILgD3JAj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.52
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADA606A33B
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 23:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8ADA606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ILgD3JAj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qi5fIerc+x2p8w8/RXgvOLdwpNipDHfdeJ8CTkaIrm9LbDYZR6iNwGgLUN07NtjvM3LvO6xsVNtQ5YvSayMugwntg/jmvXi+hpNcQvo2U/pb7LDV2E4rOfcnspggC3OtgYZRfIfDtWPMUv8UbpfMAKrN/KnlMzku0XpaJKcRQ8VTosbgqGZXrEcpkyqaXa79EoaVL05tE74sRY8gD8xU0NGbnq3/IvPGzbuFdVw2I1YSJVTocnOzdmLYcTGBTuJ0bja6hUbIZsZ48IbJ54A8nJWnNMVZbvEEdmyfUWDF02tliC3EN0qyZpEakRGiFzSFuzqAMDrCCve600Fqkwjqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Fs0TCAD45B1xfpftwl7ypd4aDyu+TcX7XHmo92GEOI=;
 b=QjRcyXsYtjdT2ZfZf/zBcqLQLZDqoOslmOXs1sHBWcVd5FaLmosL5T/RN6r+NFzW7fBr3a1bcMgttYhAF+3JOq4pLBT4UM3+Ksjpm4D48/AvPL246kMWDNCzo6+g0rAZVUtqodbr7JOZiVrEN8ST8t/helwvLaoQm5GrX+j6YnlC/CvPAfTxIFj0o/VSnRQbS9ZE35zHWRevImDKmiXUfwHn+tDO3+7ZXXpjaueP5wov11cN5MsqJYaKIvSoqIRPtxHmxsuoSb4J9LWXArXkkWtVFn74yz8EKAZiLxdb/WrokCcgXFatuPEsX8q51fOUYmr+Be7rMlypoN6CHX4dbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Fs0TCAD45B1xfpftwl7ypd4aDyu+TcX7XHmo92GEOI=;
 b=ILgD3JAjBm68dB7wh0eD+YUxCSrwbyzaYxXmy/mvdNL2+nlVMsOAECDBVdAIxbaOShloUOkvZxGCTFbnXrtarcVmlzK3dNs4ockJemleiCGIJn0WJWA5UOplEt21rRlViJFXN6/NGkF090yNpPko7r0bADwjbbaf9VQXWeyU11oTvcSgbq6mpn8AEYj6v/4ZdypA4XOEJvndxO6rvP2OTgzBOQsSvMS0IkE/IIUWHkMAq/oHUOmdXDG51YN4cX/2cBieI4P+rpajt80sMr2d1zoA8OV7FRrVdbLF76J7Ey4UmZBy4ovak5X8R5/A8Rl/BSZfn5vK4VfobceycqfomQ==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 23:01:46 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 23:01:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel
	<cassel@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 5/5] blktrace: test bio and request tracepoints record
 ioprio
Thread-Topic: [PATCH 5/5] blktrace: test bio and request tracepoints record
 ioprio
Thread-Index: AQHdfBrN+CWo3aKjwUSWfTGNSsQ4DLc/aayA
Date: Wed, 25 Nov 2026 23:01:45 +0000
Message-ID: <7d66e332-d75f-4957-a333-04252d5eb889@nvidia.com>
References: <20261124135016.153657-1-johannes.thumshirn@wdc.com>
 <20261124135016.153657-6-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124135016.153657-6-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|CH3PR12MB7644:EE_
x-ms-office365-filtering-correlation-id: b4ff8c5c-ebf1-47e0-3aab-08df4b481419
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|18002099003|22082099003|10067099003|11063799006|56012099006|261022105027099003|261026140227099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info:
 e8syJLwNysIFr8uI4YjY99qqFjYEnQ3PNB9BKSxsQIZYTntRvNrC8N2nXgsIkOh7RIuY0og0AUbbbnAhq9OTgw+Y/VaCPJzj07FRU2P9LnvvX4GfZ+seWk1CiemLnW7qq2cZe9j6rT9MVDWLRbgXg4boejBn96UqUbf6c6wiGsk3lZGTGSklOIiDub1T0mnbjj7pGSmpr5yrYpQKHApjyHoZQS30ilYzPnxYCSD9m11zr+Reusc/XgCZSjRcgxHlrWwKfRvdSiWFwcu19e4QtYe4mWAJ6GRp/mirfBiBDEsRY6yM9R1uFScUDoB0WHFxf37SYE5chzNILywVHL0hJfoov4JXWCAnjCSKuquQ8bqOXCIoCf1mPFNk+fMICbssjXhYnilJgtJVZuQ/0ojuy33Tre1Dr7bmbLSwGiGUbniI+EVXivDIdooAgPUOyQyqM245wp+5AeoWal0c3TYATcjJ/xdhpnWhkoNQ73Nf3Ml1NAUWpwpTWI60Chh9EqESfhUbZnl9jKeG6T8fsjjs2+FJcE/rrSDU0Ad6eJU9Q6zKkD5FqsrhVFJPFprGr8gC/nn4bS99Ep6I7WdymyzsWiKnlJiqckdisyevCKCDzq9GlcHrt3lXCHwTqhHnXKPBnPJGJN00vwWTXozkqvnR16WVePWlByCVMbq9nDVMBOUHE9SabZQA7qo+bW0Qfm6ueEyDnBVvtS0KkjDQw0dgsAdaXf8yBK4OnWoNgvLmiLk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTNqTzJ1elo0UC9xNTM3bEl3T1lWUkhnMVI0b05sZ0FuODlNVkIvRHNDVWU5?=
 =?utf-8?B?bS84UmU4eDdVdi9kc2ZRUFdJR1NNUG81Q2JuOXJSVDR5ZWtNQSsyR3NVczRS?=
 =?utf-8?B?S0l1VEhQTisyYzB3bHhqY2R4cWxWeXhZTDd4MFkzeHVWYmhCRVBjZFZ3cVFr?=
 =?utf-8?B?dlNYNnIzbWdCQlFOTERWTUJJZEhoYURXWkhzSE1NVzBSamxjczNiQXJZSnFB?=
 =?utf-8?B?TDVmNUpab1BFd0MxelV2b2RTUFVaWEVzQ0dNQ0kwU2FnNFpiNmE4M1Vod1U2?=
 =?utf-8?B?eGRXV2lnbG5UdlhWRjFDZ040MFlZbXZGWjgwRk9zQzd6dHNJa1M5VzZlQVNx?=
 =?utf-8?B?QjJpV1Z4TGFyODhBTk0xM1J5bmNwMjEvRjBXLzBpQWZQdkRNVXRxV3pyMDcz?=
 =?utf-8?B?dlhGNjY0TkpPMTBjdUYwenFZZzI2ZGlRTEpnODBnTWZQeUt0RTNGMFNDTXo0?=
 =?utf-8?B?dlJJbm1FSitIS0diK2c3QnFzWUZtbmxUc0F6dVNHU0FmdE4xb2JzOWJ1Z2ov?=
 =?utf-8?B?Z1V5dng2b2ZmRXJNWjdIUHNmc1ZRcXZ2UUhHQ04zLy8vWlRXU2hWdXpZL0dm?=
 =?utf-8?B?RWVwZUhwYUFibkhFL1EwZ0Y3b0hTRlJ0OEJpYUFXYnNDU3J4ZlZlOHZVcm42?=
 =?utf-8?B?UDIvWm5PQ085aXNaYXY4bzlNUnloVUtZdjFQaWRJQUd2SVJIUEhpSnR5Z1Fo?=
 =?utf-8?B?Yk1OUlI4RzFMczFkN3NjdWZkTm0vdkdMZGlVckx4YUhsck9OaFdyMDVKa2tN?=
 =?utf-8?B?cDBseFJjRCs1NkFwSVNvTk9hL1VpNXl1L1FKYVVZYzZUUEZaVjlLWEhTQkd3?=
 =?utf-8?B?UTdFRmZqeklwM0QwUytqaFZBYTJ6WWJ2aWdrT0FNZzI1VFFScS8xOURQWUx3?=
 =?utf-8?B?QXVPdGdzU3pJVUoxaDF4VlZ6NVB1c1JyWlNmWHZxZ2huUDlWbzA2RzRKL1Np?=
 =?utf-8?B?dmttTmY3VVEzME44K3pyU0U2c2NXZWpndUd2T1ArcTR4Q2txSDdDaTZnWUlh?=
 =?utf-8?B?SVpjMkpIVFpqSUpVOGxnWENBVytpUS94VUZnK1V2amJHSWYrOHJRL2JKNlJu?=
 =?utf-8?B?dFV0b3JaMDBIaTJiU3VLSFJ1WHlLNU1SK25PZWtNYlJGc1lScEVHQVJSb1Ez?=
 =?utf-8?B?MG9ZdkxsekdSTk85dWlBbEFubERzZ0Z5U1hDTU9vTm5HUklQcXNBQ0d1UUlQ?=
 =?utf-8?B?cmFsbk5BTXViWk1Vay84YzhWTDNwcVJOeW9GOVljNVA4K3F5VVBISExSTEhY?=
 =?utf-8?B?K1RETVdCY3ZuTVRIMEFYT2Ztd05CdkdNNWhWT2xwcjhqOVkzYlJWRWR6SGRk?=
 =?utf-8?B?SUYrRXQ1M3dzZWdoZUlOZEhkZVFwcklYVlQvS3BkZXdHQ3Fpck5NMG9UZGhr?=
 =?utf-8?B?aGxpNlp1cUtKM3NIdFlmZkxFRU55VTVWRGNieTRUdlUvaE1DSUxXQkdmeFFZ?=
 =?utf-8?B?Q1kvRjJXQlBnSWJENlo5cHBoVWllK1RrWm1WQXVHTzFEbE1jdmtHa0Nwdjd5?=
 =?utf-8?B?aFFIRVZwazZJWEtHS0VZVmhWcyt0NElzbjN1QjlRU0FEYWhsL2R6VFBOdS90?=
 =?utf-8?B?YjVhc2pPSy8yTUQwNnVIVnZ1MWljT2ZjNFBGTkE0NDcybnhvZ01aOStGWGFa?=
 =?utf-8?B?a0pRd3Ewazk4UUt4L0JwRGtsTUF4L1pYNEg4YTFFL1NWZE9VQm1rTUFiUUkx?=
 =?utf-8?B?dnllc1JvRXJzazIrMXQ1OEZMRGNJdWVXUXJISUVjeG9VZk9pbUFuWVNvQ0V4?=
 =?utf-8?B?MEpsaldVeTVBZFQreWQ1Q1RjL2pPWVlpa3JXYklmWjhIYmJ6Q09JRmlDTU13?=
 =?utf-8?B?ZUo4N1lySkRZZ3B6SVJ0NHgrdngzQWNnQSt1UzFZN0ZNdHVoTVNBUEVNMVhx?=
 =?utf-8?B?b1ZrVnRubmNQRDVxTlJKWVZJVndydnlURnhId1FMRUkyc09sNlBNM3JjbFNE?=
 =?utf-8?B?Tk14SGNlcFVERmZLMExBenYwc1JSY3ZVRC9QSW5hc0FkY2dTbEtNakE4eTc5?=
 =?utf-8?B?cHNuWGlOeTd4d0JRekFsMXpJQUxzQjlmeEYxYVptcFp6bDdEZ21rayt1QmNZ?=
 =?utf-8?B?VjdWb0NXYW9FUmFNZmt2ZmZpQmxCN2QrZ3dkOEhSUklvZjdjc3crZjVTY0N1?=
 =?utf-8?B?QWI0cVJrQnBGOSswNitmUUVRWWcyczNyYzYzSjFrYXRHRFJGcDRZR2FwU3cr?=
 =?utf-8?B?SmY4ZmZ2S1JUaXVxWTlyclpXY2EwMG92OWR5NCtNZ3BMWi9KOWQ1OGQyazVT?=
 =?utf-8?B?TWlJOElGb3BEYkt5L3JvWHBwQko3cDdDcENPQ2VzSUU0ZkdDUkF2M0RVZmI0?=
 =?utf-8?B?NllnRnRqR2tBdXFsNG9IMngzMzEzTW1Lc0I5S29sMWRuRHRKZktMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD4CC4549BA2464AA23E62DCA674CA23@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ff8c5c-ebf1-47e0-3aab-08df4b481419
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 23:01:45.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Da7Viubbc1XLXO2pcE2Fl8J7t40djfcq1sAywSfe/SIcABufS7ZbD5BaTrozKj5+1FxSQMsBiNtnIhqAIUn53g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

T24gMTEvMjQvMjYgNTo1MCBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBDaGVjayB0
aGF0IHRoZSBiaW8gYW5kIHJlcXVlc3QgYmFzZWQgYmxvY2sgdHJhY2Vwb2ludHMgcmVwb3J0IHRo
ZSBJL08NCj4gcHJpb3JpdHksIGluY2x1ZGluZyB0aGUgQ0RMIGhpbnQsIGFzICJjbGFzcyxoaW50
LGxldmVsIi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuPGpvaGFubmVz
LnRodW1zaGlybkB3ZGMuY29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
