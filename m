Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E017BB01
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817364; cv=fail; b=hyjU2K0u/MFkJME4N4NUfx0V52P/3Xm23QdKgIAfelzc6FiHCzZtEolk/CVENZR1/SW1cGw9tkw0t39ok1u8dzmLgwV1r0Wt/JfkTEj4Wbgn0E+Hi5wIy9eMCIKzZunrYEG9kXKTgq9tsNl+J3MBIZu5510TGsfeGqXRxfLG+d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817364; c=relaxed/simple;
	bh=ptR+AuEym+b3E294mEICN/0dU2xntFtnaslQjcDRihk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VfbqXs1DhGr8oa+3f/Sw/q/MbWS9uLH0aLxD25B0FmmHN3Rc+ZhUvlmY3DFAFooBo53MbPLrhFgHLdPJMuLBSaw6509+GqH9CPIiH784cMyZ0NmUzIONcKpHHIQ7LD1BWMxYYeWE4+M3mBQ06DSKEviPxPCs5wjpq9WqT2yPeak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fbd2WK3n; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fbd2WK3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNJE1997WzK6HXi1q2dUwGat0i/q3vWpfZHcVT0lDswxdE49zLgC0P3iQbLXVFDlcTMZ8wm1Od5lWkzrMSOm4G0sGQLbLVnI6o/Y9KOAZ8v96d7cHG4F3IXu6qu8vncSolnVO9Hhvsnvtzjwp956bX4SblFpKjtEINsYPJoQW5nZeIzeqpzeih8EgNCiAGrZOoPVmQgulCl5H+Kwa+JpL6EbrlxEhlEmEfPt0VLZnqaIXQEHeDYjxGoVXTkE32+kaTV3Yq8osYeFKIo1wz+e5Xquk2BzcFW659CsS4k3vtoSKjvd8x0DtBBSitNB8nLnaLy3OHu0is/q68GYtT5p+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptR+AuEym+b3E294mEICN/0dU2xntFtnaslQjcDRihk=;
 b=jDArl9uyXififrPE/2GrOZCn1DSw0v9IVhPZAWm07qVwJLNObdxzrUg2mkjji7ZFX1lWylskHBOxRHNfadLnydVAzwV2gFmqfEW5Dga1Dj4orYpuVBnPMfIJwRKtzDIjHkJ3Q4Q5cabOw3D2raJKqjUKWE3f3ycPKKBD3v0XTpmCIMgN6Cp4rTcSHnve5OL0EuUmyg2e0Mr7yVBAgwZIBJxahUB4xEyspAH45TgzRnYbWNtU8fy6LjVdyFf3jCgWig5mk9shX2eXk/qBGjjlO49t9SJKBTAfGzC5yH0ZTkGCSRoEf4g5gqcSlkOl7CbDITqtSsDPekmnsfyJjS3flA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptR+AuEym+b3E294mEICN/0dU2xntFtnaslQjcDRihk=;
 b=Fbd2WK3nUQ5N379hvnyR2ePTE1AA7MQnacI8eufNHYwL6cUJFSw4Ue/Y7ZfeXiXQafhpiNXODUDZpvEaTLFS/InjZrcUmgDQXFXm407kty/XlXPFqzjorvGeXEZVmV+suRREeN4ZEAbiEwJW5iI1hq3ewBKAeWBuLNUHXHJyHCX4V92a4HI3QEFvTOEFPyycuxjheXagqIa1SnRArJLk2Jim5vJzYXpO6vZLECRDG+wqNByVIlEf5MAi+LiJFAJs2FT4ujKhgN/+hjijWbzVUL8+KYZt/gTVCpOo8bjWIeQGYCpKOs7rCwgXgKFYzP6//DUgehIky4QmHkrgIFLxBQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Mon, 1 Jul
 2024 07:02:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 07:02:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, "Martin
 K . Petersen" <martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] nvme: don't set io_opt if NOWS is zero
Thread-Topic: [PATCH 3/3] nvme: don't set io_opt if NOWS is zero
Thread-Index: AQHay3YV+6B0vMqNZ0un+ybRjErm7rHhcmQA
Date: Mon, 1 Jul 2024 07:02:38 +0000
Message-ID: <420a0a8e-f826-4aba-a2f3-6ef2286c6d29@nvidia.com>
References: <20240701051800.1245240-1-hch@lst.de>
 <20240701051800.1245240-4-hch@lst.de>
In-Reply-To: <20240701051800.1245240-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7275:EE_
x-ms-office365-filtering-correlation-id: 7080e254-f423-4aee-dead-08dc999bcb17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NVVTOHlUZU1YQmYzWlJLOUpTWWp6WXVpVmZ4YTJQQmpSR2Y3K2tLTDdQQlgy?=
 =?utf-8?B?SENWbmZ5UVZ4RUhXSUZLQjBXMWRrZC9xN0J1ZEdRVGg5V0d3SHlxUUsrOGJn?=
 =?utf-8?B?NG9mdUlhcUhDWG9mUk9qNEF2NmRkOUNlM0hPYmNVcjI5NEJSRElZYjgwMkUz?=
 =?utf-8?B?MHRPdmQyQ0tFdHhjNVlLblRmR2xJS1AvMGhNSWJSbWcxamI1THhwQ1lXakts?=
 =?utf-8?B?WEZ3ZnRzaCt5bHg2bFAxYW1Bd25QbU00dnRQVUEwdHc3dlZiU3ZWUHE5VzdK?=
 =?utf-8?B?OVNsTERnanlGU0kzOWRlYjdiWWFKNEVOSkczUXdhN1FUT1JVOUYvSWpBWU5C?=
 =?utf-8?B?elRneGNFdXl2SHlkVVlxczZFZzZVY0NjcWZSRVltY1I4TnpLdzhFVWFiMkVY?=
 =?utf-8?B?SDN5bW5HRUtlU3BhS2FpSStyYStJQkJkQWFwT2tCZ3ZXdHY4aFdqelp5cVNQ?=
 =?utf-8?B?VUhVMjRrZUlQRnpQRFlZM2owNUxtZldTQy9mWUZEbTJxQUhPbFBpTVQrRHFY?=
 =?utf-8?B?dmlIQmNpN0c4WW44THA3WUFOaUtra25pazY0N3A3Z0ZKSXVSd1hLMHRGbkdW?=
 =?utf-8?B?b3A2NmhjT0x6VUttU0w5NVJqN2hMc1cvbE1NaVY5QW91TnlZT3huTG9NN01D?=
 =?utf-8?B?MWR5RGIxQ1NaQ0t6dlQ5cEdrZWdBS1BMR0k1bktGMUJUbXA3M0hMcEZKdVBy?=
 =?utf-8?B?MnYyc0YveE42b01vYm9UcW9YQVhOY0pSZkNOaHNvcU4wRW8xSk9LV0lzanpD?=
 =?utf-8?B?czl6c3JsbXB6RjBlQVIydXVmTmtkQW50T0EwUmRISzRHMCs0OERnc0RXem1Z?=
 =?utf-8?B?bnh6N2pQckdBMHkxcGllMGxFNmJFY1huRlV6L25oV3JQekZ3ZlBWSHpFNTJ2?=
 =?utf-8?B?MUdFc0lMVmNqY0kvaHVWUFdNZCtNLzhVUk1TYTlrZktON3VNUnZhVWFQTk9k?=
 =?utf-8?B?eHlBcStjYytXMW00b0NrdkJoTmdYdFdNbWRJN1JURUt3NTRnaFRxK2ZnOFhK?=
 =?utf-8?B?RWVoc3oxaXZqZU1jQUJrTnhGZ2UwZG9ac3hudHdxOFRrKzlpaXd1UzZrQVV4?=
 =?utf-8?B?V1N4SXNYTko5R2VxM1NHTFB2bHhNNjlhNkRBVlEwajBtZlQzbVNJOFpGWWRG?=
 =?utf-8?B?UkxnV1NNUFh5ZTRXQTNlN0xYWTRjMnNjekJkNjBqWTAzQktuSE1zYmJjQnBL?=
 =?utf-8?B?Wlg4VVRNMzJ4SDYxVlN1ZjgyRThUZXBneGFkcU5wc0kzTE9qMG81RlhTUnI0?=
 =?utf-8?B?ZkVGNkVXZng2Mm1RVHJLYitGVHJLRHFaQ3RiV3lBVlgrRWxpSlZEeWs3L3ll?=
 =?utf-8?B?RUxKWEwzNG1YQ2R6STlKTDQ4N3kxT2pFRDJCV0k3N1gva1NMWEJ2WFM4L3VJ?=
 =?utf-8?B?eE03cHc4aHBsVEdTVkFQMWFvdW5leGMyVVF6RUdVVWJyZ3ZMR3JER05zQWc0?=
 =?utf-8?B?YWZCeUh6aVc2V2YyUjJXbWpXdENBMzJla2cwclZOM3lvbW0yNkVUUjM2b1dV?=
 =?utf-8?B?blJLS282d1A5YjJEK1haT1Y5WmtSZ2NGMC8rb0x5Y09uTDVYR1h6TzRzTGx1?=
 =?utf-8?B?aFJtLzVINDFaRks3MlpwSW45S2NPUi9GM01UdC9oMkJ1L2hLa29uK2dqenlT?=
 =?utf-8?B?anJwM0Qxb2RlUTJvTDdkOE43NlF2VmNsMWNMZ3BPTGF1SGtEaXRpZldYRjBa?=
 =?utf-8?B?VVh2Tkw3R1kwZk91WHd3ZHBLWFZhZGRFSkFqamtVaWwzTU5ObHBWaVZubkNR?=
 =?utf-8?B?ak44clI1ajRwSkJENHcrWmZkbC9hbWY4OVVMaWo0bXJzdHhPb25ZYU5hQ1ZR?=
 =?utf-8?B?MjhKTnQzd0cwbUVmRFNza1B1aUJXS0o3ckNTbWNoUjBCeko0VnFDQmYzZFM4?=
 =?utf-8?B?UStxU0EyV2JZOVZETWhSTkxReUZMK1A4eDZ3UnJZQW9MYkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bElvY2lqVjdrdDBVMWFXRHFZcDU1RzVkTTVzcWhsdGZHcWNGeVFGNHRLYXd0?=
 =?utf-8?B?ZXl0MUVZVTcyMWlVYXVrOERHOG9GSFdlZWdyZkplZmpzUkZ2TXlwVnVvSzNS?=
 =?utf-8?B?T0ZHb3UvdzM1MTIzamUyRm5oam5nR0taQ1h3RnQ0ZWp4RURPeUVxZXhQd3pM?=
 =?utf-8?B?UFpCS0QwS0t0dXh4V2lVV1V6bkpjVGZWOTdPVDNRWWp2dFFTTHg5QlAwYXpl?=
 =?utf-8?B?TFphZitQLytNbG5OOEJGcmtvYmVQRmpya01FOXNRVE5UL2phM3VPWHRtOEZW?=
 =?utf-8?B?QVRmQ1NQQmY0OFkzVHdJamhuT0s1ZDh0MkVEYk1jWi9iak1EUHRNVW8zN2ZK?=
 =?utf-8?B?bHUxR2lsbjBxVkN2bWZmNDlWY2F6QmJ5Qk1nUGlyZVZtKzZLV2tYQkV5RWpn?=
 =?utf-8?B?Um1vckJiUEVoR21Ha2RXT3BFdm9nc04vWHFkYnJMK0JJanhCUGw1MUZibTUw?=
 =?utf-8?B?dCtmSHhqOEZhQjVkVElFcUtGc0Z0aXpVQ3d3M0hMazdTcTNiNXJySzhtSzlj?=
 =?utf-8?B?YW1KU3p3SWVXTjVaMDVSTStYb1MyYVF1dFdoWWVEdloybGVnb2dYYkUyS2kv?=
 =?utf-8?B?Nkd5STBvbnJQR2NpMk5TQkRRVzZ3N05vM1hxMk9PL3N4TUVYR1B5NS83bU9o?=
 =?utf-8?B?b1FnYWlINTZydTc3T3JleHZEcFB5V0IvZ1ZlczRpMWxVYUtFSEdLOFcxdkph?=
 =?utf-8?B?ekJuM0RzUjJDZFJ2OXdXSWIyQWlaVE5MTXBGZ3U3TU1PT1ZOajI2T3o0S1Y0?=
 =?utf-8?B?eGZpQU5nVCtkUjdjUHFlVlNiSys3NVhnVzg4Zy9UNkZ4djArRjhBTFEzOU1z?=
 =?utf-8?B?ZGRBYW9xdnBDZ0QwV1hVRU1UYnZ4a21Nc1ZBOUdGQ3RzMWVhZjJNYlZlNDMr?=
 =?utf-8?B?dmFSVmd3VElQbklrOXpjMU5TdjE2SkhwaElhNHFvQTFuU1c3a2NNc0FZTEU5?=
 =?utf-8?B?SEpKUm9NWitWb0N4bklhSW5tZDhmSDJuZjduSmgyQXlpR3VWSlFRUFhHMDVM?=
 =?utf-8?B?OEthcXVGRFBDK1dOSkVkUGU1K1VoV2dBdUJxa28xV0xjcmV2M3dsajdnNWRK?=
 =?utf-8?B?eWhpc20rSXVRNXM3eVRkdWtsdDV2N2NmQlkzMnI4bHRqeVd2eWk4T0ozVVgz?=
 =?utf-8?B?S1ZGbG1FelhkQzNpY0N5RU1EK1RFRGt4ay92U0FLYkppWDdNKzdNTlRiQnYx?=
 =?utf-8?B?Sm1mckg2TjJBTGJ2Nk1RQWFlYVBpUU9jMTMveHVEd21ZRVJRVm9YTnEvaUIy?=
 =?utf-8?B?dEN2SXpxaXZKTW85UHkwN0JrY0U3STl5NXJkbm9UYmlpZWpQaVpNcC85UHZO?=
 =?utf-8?B?d1d4UXM1N2pUc05kUUxqWGI4aHo0NTY2TzNwRXphdWp1RS9wMEJHUDI2NEFr?=
 =?utf-8?B?ekx6WUhVNkVSdnlaYkRQRnFWY2o5R0JSTXlJc2hWS1VLYkQvV3orWmtKODVJ?=
 =?utf-8?B?bXNUaGViVjV1cU9QcEEwS0dyQjk3TGNZUzBRU2ZKRFFTdUFPd1FnS0lVOEpX?=
 =?utf-8?B?TkhWUThWcmltMzlNUDBSSFhQNVBPSXNKSTFvMEhpY3hSRW5HcE4wdnpWRm9C?=
 =?utf-8?B?Vng5WmRYT0x2ckNKNXd1ZHVXZDFEQm50bXhBL1pMZzJxMFVjMTk0VVBnQjFD?=
 =?utf-8?B?TGsyckUvVmhHVnhrM2ZVZDFFSi9XcTIydU5GUVE0VGlXUExZS0VFUWN5Yk5m?=
 =?utf-8?B?bXhudkVQbS9ZRHNjWTVkblR4NDRGTVdselVVUVU5cTNWZXhPK01WdERpZUhL?=
 =?utf-8?B?VzAvS3NJSWFDTjB1QTdOOUhQK2wwaHdaYWdGL09NcHNhL0RyNnJvUlFYVlg0?=
 =?utf-8?B?OG1JdVFubmFQd2VXbW5DRkNwV3RycldLN0hQUllTUGVrTlRmeDRRQ3NkdUtJ?=
 =?utf-8?B?Q3FyMEFBMkJsRE93SUtvdDQ3SXMvUkQ3L2dFSURvK09raXlVUjZKdDUrTVQ3?=
 =?utf-8?B?TDg1WDlWRnRtdElLMW9Hcmc4WnFmMHNmZEVpd2NkSnU4OWRMd1p6K0JCSGZj?=
 =?utf-8?B?cXNmZXk2UzdrU0QyTVdtY21oZXEvS0VYU0NaTUxDQTdvZS90NW5FZUpnL2J0?=
 =?utf-8?B?OWJzcGY4VE5sSkVSR2loZWk0SnFSVXg0K0VaOUFSNWFZN0krN3pPdjViMnZI?=
 =?utf-8?B?d3VMY1pOV293d1B3UlpCblJ3QUE2QlFjNWYzWjVGMmJIOVppbFpJRTlRZ3px?=
 =?utf-8?Q?d0F+NSxJ5CW+8c155lnDNwmZO8ASeObaKekpq7IQgI8I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14E67479FA5B3E458126A0B27D3CB6B8@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7080e254-f423-4aee-dead-08dc999bcb17
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 07:02:38.5990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lns1DuJU0AqhqflfoToTp8CJzU9k8CxlYWXX5L4mTjlQOaY8HoxnWS42mdB2/oh4u6lmXYXHqNU10/ugDmCUJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275

T24gNi8zMC8yNCAyMjoxNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE5PV1MgaXMgb25l
IG9mIHRoZSBhbm5veWluZyAiMCdzIGJhc2VkIHZhbHVlcyIgaW4gTlZNZSwgd2hlcmUgMCBtZWFu
cyBvbmUNCj4gYW5kIHdlIHRodXMgY2FuJ3QgZGV0ZWN0IGlmIGl0IGlzbid0IHNldC4gIFRodXMg
YSBOT1dTIHZhbHVlIG9mIDAgbWVhbnMNCj4gdGhhdCB0aGUgTmFtZXNwYWNlIE9wdGltYWwgV3Jp
dGUgU2l6ZSBpcyBhIHNpbmdsZSBMQkEsIHdoaWNoIGlzIGNsZWFybHkNCj4gYm9ndXMuICBJZ25v
cmUgdGhlIHZhbHVlIGluIHRoYXQgY2FzZSBhbmQgZG9uJ3QgcHJvcGFnYXRlIGFuIGlvX29wdA0K
PiB2YWx1ZSB0byB0aGUgYmxvY2sgbGF5ZXIuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9w
aCBIZWxsd2lnPGhjaEBsc3QuZGU+DQoNCmluZGVlZCAoRmlndXJlIDk3OiBJZGVudGlmeSAtPiBO
YW1lc3BhY2UgT3B0aW1hbCBXcml0ZSBTaXplIChOT1dTKSkuDQoNCndvbmRlciB3aHkgY2FuJ3Qg
c3BlYyB1c2UgMHhGRkZGIHRvIGluZGljYXRlIG5vdCBzdXBwb3J0ZWQgZm9yIGFsbA0KemVybyBi
YXNlZCB2YWx1ZXMgdG8gYXZvaWQgdGhpcyBjb25mdXNpb24gPw0KDQpMb29rcyBnb29kLg0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoN
Cg0K
