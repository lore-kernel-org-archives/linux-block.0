Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32D81A683A
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683224; cv=fail; b=u4ZS4iPTMiSHMwbpZ0+BIChflRhMwwf/5fRXPK3ssLKuZtvqZ+O1pvKUfYytgnhyAMd8KSIKqmagC5WcFd6HN46ASApN69mp1eNW5OlJmikiYRP+O3vavDwc+jPfdHse0Ip7NPmKeMgPUWRKew71QMP9Efu9uvd+LOT6yqUA5zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683224; c=relaxed/simple;
	bh=MMXZx16gsmZ+zSCICw1o+j4qk/NpCKqq/urE2t2N6gI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YkABuuAsInIdKAqt8FCyYYqU6L8sk1lcgb6nowaXq3FOPh/p/fubkcwBkzqc5cjheUyOCkcIZ+5jWtfDcsapParwv8UWFwMbkwNe1JDU7Xc2Wwr9Jo0PN4J2xvWR9zLkp/Vc8xl/RB+qLzQJSzCDBBpBJ+0DY33PlfHsGbpN/sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IzqxSntk; arc=fail smtp.client-ip=52.101.56.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IzqxSntk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZK4OI5u35KT7KbqLVyXGDOolb0ewwzMCpErJoaxAK4rnIlbPZjR/AN2iWnihUaUSHMLYKNzoJ/0qe5gn1ys4nVA15E96dGJU+Zh0vuyokA8nEJFGCLtQxEID3UbRmR8+pv9PDTwzvJkvh5kEAS3NaqmE2uidYgPwNCLMPRVCtgXbhZG780p23vv3LMKU5D0mmw/s4QjzuM3/OUC4bJQorpbT91yMxS5nUNgKJWa4sSPVNut524uNybxqZVm29aRN1tUEPf1VTXXa/aEuDY/t/W28yrznrjnmkht9gYZ18HZJRfFEDYFJ3LCqkqsqVgnqPKeGUy+IW70wygQNG74ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMXZx16gsmZ+zSCICw1o+j4qk/NpCKqq/urE2t2N6gI=;
 b=V3LE7DGv4focUWu9xbt6zgXlFdqYMYcvlJoWLQ7cqsVE1p/HFLf56C59GWGnnzKKGaMXEEQcn0y0ZLs+KNh6K323Ar3w5OUGfujpSDlLe/isjkvrPtUvg1pSEGvDtIp6/qT98YXi2AQAQIjXt270L2Qh2MwhJnjMZswIy+I8OsRRh3hUii/ZPPgxy7PfUo5Y4oMSdDY0HpUy55eplKewFdFPZq99tcyxKxNqkNfAAvsdMkNsu6N+er4T+07Fg6BXsPxAVO76jrE1FQxnTeyDcq3sNkk1DrWvaLZTUp9/atCABFSA7j50ibszTZ9wjvA61lB2GH2rkLG2HL3gXGTODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMXZx16gsmZ+zSCICw1o+j4qk/NpCKqq/urE2t2N6gI=;
 b=IzqxSntk+Rz98D5wY+MCGxmV6Z3Blvd7pPjSL+ZaXOqD15t1UrkRHjb+POddbfX0yIyu6kPZW/J9H1I1uAeQW6CzahIuRInH4XM3TZwj249o/bC4Nv9mp46L/QAszUWFZKFg2WA6N0D6Y0wW2XhGFjWe9FKh1EgcrFAVnqYZ2l67cL826C5y+SeU3qxyyILYYcigRRV75S2T6UgxKJWcrCzHs+Z7+KJA6nWdXf7RnBrABh8qnipIcM8/x4aH7Y1mWkuncb/cQKXbotZ0fuvqQjhU851EkZ/Ve4309NKY0lGyXye1IkEE5USgHiAvoed6CS1B0C/ys3/PvKUR4V5NDg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:13:36 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:13:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH v7 01/14] block: Annotate the queue limits functions
Thread-Topic: [PATCH v7 01/14] block: Annotate the queue limits functions
Thread-Index: AQHc9RVecRnhxVjLvEy4SfFLciFCx7YwQ+GA
Date: Fri, 5 Jun 2026 18:13:36 +0000
Message-ID: <80e03ee5-bddf-430e-a049-8901f8d4e3cd@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <8f71062b6d0fcf2b80bc8cda701c453224755439.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <8f71062b6d0fcf2b80bc8cda701c453224755439.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7935:EE_
x-ms-office365-filtering-correlation-id: ededfedc-90b1-45d8-4e71-08dec32e293e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 VBBKXM2GHqGS0Su8pI087/ocI4oZy7sSR+juqaqBrpL+2G2hgMCi/SujK3pTa1kP+N4BEeWQEqVoyYu7fJhIoekqLF5WvPNJCwWrIKSrLM8RS5917OcKfU+HhJp/O5SmPakdXNAJsjjNGKBNv6s7RlKTSUUogRI+eIYA1PhySA1aQgDJNGqkDJtjxu2YEdj6TynFnigX2/Z6HnFVRtbm4F6eQqJc8lOpL+U42kF4CG+lD9WnMkZKzxuvYT/qCLf8kQjJJC5mdPbNDCuWyqcuoSCvgA0hDnFrAlHjOQYR7yb/GvYBtQblWbzcBfep68925sOuttaYsLF2/jrDBnihSJl8U1v31Aj4ciLzN87CO4DstYAGxpiXiCOEhl5knfqhWGyKPgbEEf0NLgUu0uc2+DK1MSjfc/RNlWtxT2RllJw4jyEPZ2fI8YyGyjdq+AEZWzB/6k9eY40TGLkd2Aim4RLqrx+Rv+TUNfP0MyYU8dwTCObwRMIyrTeuzDnzgli6FBGkbcS87eu0UWqF4wT5AmyDEgyT91VRHfIDlylRtPCRht5il8SRU6gGJ+NFR8lba28+bVBz3MaIvY3AxmvMbK4Eka4h/c/r6pGHRfiDsV8uPUUlTkrTUbGbPbrncbM5LLM6Us658NICE8Prq79oFXmFik4aJI7jdxkcnwQM/EHWhHoRPhQOKzZKBgE7Bpzb5m4ZRdaUt0ZhNe9sry4lmh5Fhyy1N0cxaz/UQlAJHB6KYsBUHwN8yRivnph78h8y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TW56UzkzSHZpY1dLRm55N1h0YUhNM3FoZlRuc09WUVpBaXgwcWVnMVVwYnp1?=
 =?utf-8?B?RlhDeFBwTUs4WjFEb0xOMmlIWk5EdUtkRHFRT0JHSjYvcjhoNlhGVnVBc0Y4?=
 =?utf-8?B?bnFjaTA1Q1NQREYvSk5iUDBEN3lHaG8xaVpVSzVaMnRDdStBd0NUd2Y5QkJz?=
 =?utf-8?B?NmNES3N0MzkxUUV6eTBJelVHRStTWVlrRDBCaUpxa2FlWWk4NWV2RjlFNTFh?=
 =?utf-8?B?Z2d1eEZuREdma0gvMkhqRHV2OWpNSjQrN0JmRUd0MVN3bXFPWG9xTEdHNWpa?=
 =?utf-8?B?ZGYvQkdyRytCV0g5VlA2REJTMXZnLzNpYUJ5ZEE5ZjRxNS93UHlrK1ZyaG9K?=
 =?utf-8?B?OXV3dWFjUnJ2N0J3TlA2Z2tvN0pXZUg5bTZlRW5UZG9XZWxsK2NOa09xbENw?=
 =?utf-8?B?ZmQ3M29XdkxZVHZuVUR0aXpsWm82SnBJc3ZzVmN6a0o2R2piM3d4MUkycVVM?=
 =?utf-8?B?ckZDald0OWZjNzg5eFM4WFN3bzZONGJway9HRWZabUtQRFp5MUwzMDQyNlFI?=
 =?utf-8?B?eDF5N0dSeTRlTHRRMDluQXlLOFpvVW1LMHJIRi9HbHhBNzN1TUZkSDlhZ0JJ?=
 =?utf-8?B?WFJMR2VwN1JiUEJ0Yk85alJnM3FzYWNEU241MmVCMjdVQVFnZjB0T2xCMWI3?=
 =?utf-8?B?aElFemswZzlIRkJ6NEhmL0t5OE9jazVJWFE3c3I5ZUY4NjdGWGhNcnVYdXNF?=
 =?utf-8?B?a28vcEdtSkw3enJXRUIwR2h6Sy9Bd2Q3YXNNOWxGZnFaZ0lvY2pjRzhsTFZL?=
 =?utf-8?B?WG1rdEhvYngxQ1NLS3doQVJld3U1SmhIZFZKSEtXd2lUQmFNV05CT3R0aWkz?=
 =?utf-8?B?akl6T0FtbGVVMlJFTytxbkZjOGRhMlNJUlJqdHpubVRmSVlrUDRsK2NOb0hK?=
 =?utf-8?B?cDNxUjh2N003akcxTnNVL3ZDSWQ1UVdIMG1NWjVQS3dIdnpzYy9QWGhlOG9q?=
 =?utf-8?B?OFhna2tJVWZwSDMyT2xDY2gxTk9OOWdzT3ByZS96ZEdwS2Njc1ltN2JvNUJE?=
 =?utf-8?B?SmNOU05lMkhLdkxudFpaSy91RjNNWWV4emlsT3E1L0dZcG15OGVNS21IaUJB?=
 =?utf-8?B?UWJrMmVITnVPTGR2Ui9vTFpkelJ6VkNOTnY4UXdyRUZpNjlXcmZwdTZHS05u?=
 =?utf-8?B?ZVhhYW0ydVV3ajgyZzFNbWtOc25Nb3k3dDdHTjlHcmxOU1lITytia2lJUXlk?=
 =?utf-8?B?TjZxM2dra0c5ZS8zTld1M1UzN2JyTWNRSUllSk5JN0tySlFTQ280akZyQmFy?=
 =?utf-8?B?bTd2RE12bkFmQkJiakh2K1kvUFRpbE9QK2JSWkFSamVPNTNDeGpscTA2K3dP?=
 =?utf-8?B?QUxWSUNXNDdWakcrbDRJUnlQeDhmWUZFK0JrUkJrN0ZkVjkwdlp3Z3ErSUFQ?=
 =?utf-8?B?YkZrSHYrTi9qMUhHanFTQUxFOERWT2lHWitsaWp3endFMTVqYWg3NUxhTHRQ?=
 =?utf-8?B?YkVpMXJ5OTl5TVcvRXRlWGs3ZGwyNXdWM05SUkh1OEZ2bjJSa0w3aHhMUmxV?=
 =?utf-8?B?dGlZc2lIbmpuV1ZrWUh5dExtRDVhRHIrSlN2bGh0d1hXNGRpMzJ2d216M3Jr?=
 =?utf-8?B?bW4vOHVnekpjbEo1NWVvZkFLS0U3Ny80ZEpTdjlkZElJVzVOZmY5aXhrR0E3?=
 =?utf-8?B?Ty9LRG5PNHdma1I5dDhkQUxkNjlsb2FYc1JRWVZqZG5vb2NKK21ob2pISWUx?=
 =?utf-8?B?M1ZlL0JFRzFmSlluM0RsSWFpcmREWTRlTkpnZlkrMUNOMVhrZXFmbzdsdUZ2?=
 =?utf-8?B?OFRTRThwdVZ3Qy9KQTRNOVByZkhyMzZTejA5a2YwZTB2d09kQnZlZGgwcmxw?=
 =?utf-8?B?TEdRdGdlNzNMZjZuQnpsdFpkZmw0VDVReHYrVFkvWlhXcnl2a3RGaTlpMFA4?=
 =?utf-8?B?Q3VHR3RULzRjKzBtYWZnaXZSUGtEZGtVNTNwNzFtV2htK3c4a1FqcmZiUnUx?=
 =?utf-8?B?RG1YWGhOUWNHY2diTVNzZjFFRmx5ZTY2d3Y2bG9TZVNKTk9OdVp3c3VndGc0?=
 =?utf-8?B?b2M4MkFzUXNhTitGSWx1UDJMenVTRTNpNzI5QVFLOG9rdGRoVGRLOFRUMjhr?=
 =?utf-8?B?SWhkU2psYkJPbFdlN1BzY3NTek1tVi9nVERZb0NrYnlqbG5IN2pUMnJmYkhG?=
 =?utf-8?B?VHpkK2Y2Q3dRZU5TMk5JTFEvaERzYkVNMmluOFV5UGd3R1B5aEV4Nk1PZGc5?=
 =?utf-8?B?QTFyMWprVG5rWnUrdmJEUmdoYU5ORCt4N1Jaam9UdFZMMXNUQmhzdThpN0ZR?=
 =?utf-8?B?Ky9PdEFCYWZjdEN4TERLc3IrSmQrUThBYUtRNG1US0N6V2p5SDlrQkN4bWtT?=
 =?utf-8?B?RTA3aUxWTjAxTGJCSEpmVm9nZnVPcDZXK2YxRFF0ckhNK2VheGlIR2VQVnNH?=
 =?utf-8?Q?D18P/BemCmzJrrkaEKFWVCjf/0P9RPiqyLUHC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D961A5C8173484DA00BBF287B6E6B83@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ededfedc-90b1-45d8-4e71-08dec32e293e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:13:36.0887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhGLyX3Ty34T09Ng3mgL0H1zWD0XI3XMUjkbEffy2SRFvb70ys6W8LQc/AqHR88fl49ti36K7gO75xwTobzt4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935

T24gNi81LzI2IDExOjAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQoNCkxldCB0aGUgdGhyZWFk
LXNhZmV0eSBjaGVja2VyIHZlcmlmeSB3aGV0aGVyIGV2ZXJ5IHN0YXJ0IG9mIGEgcXVldWUNCmxp
bWl0cyB1cGRhdGUgaXMgZm9sbG93ZWQgYnkgYSBjYWxsIHRvIGEgZnVuY3Rpb24gdGhhdCBmaW5p
c2hlcyBhIHF1ZXVlDQpsaW1pdHMgdXBkYXRlLg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhl
bGx3aWc8aGNoQGxzdC5kZT4NClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2U8aGFyZUBrZXJu
ZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogQmFydCBWYW4gQXNzY2hlPGJ2YW5hc3NjaGVAYWNtLm9y
Zz4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
