Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CC1C9DC6
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584100; cv=fail; b=lfKWU3fZGcmY8zTQNoEJXepS8L0xL5hKnXwUHwVF3c8BIbbkp9TwLYluA5R3fsyxz7N2/gQs8X35tq0ebgMelVhKHeeTiEp9DWLsvwSl+PjYZ9GS8UrOHglW9/qw1HkQXOhfPJ/x2yts++jPLHP+MGbnsak3jbI5UuLMCUgzu8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584100; c=relaxed/simple;
	bh=k0rICRzUo6V9siub7ojX49yNCEwl/tA1GiN0XE/5mD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F6xZG0IkPNMBmKSZZ0Y59gPrz+QxXx6XBgQkHO18ChS9hAAySImPrCwU8vVrraKQ5aOomtwHeTQ8Vdk1BN9kmRJYyb6Or8HsAXMw6jJniuTOllNXfLya/jNysyB6diK8cMZqnmqvSzWnjk7l5+iULiQImLsJt28pdfbbWF7twu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gFiAUzEY; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gFiAUzEY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4Yy1ahKjSekC/kGPJpSzbg21zaK7y4cQYwbiaODWpYdbMrdnnOpP4vb8PmpjBaY5AtXgmOCj2V4tyvxXC8sYvKlPGG0ExMMVJRs/71b3gfJKVDijUKTtzvEOEp8tSvRg4KWpW/AboO8Uhm6X6Pk3a1GU58fnQ8yH20OBbN/PSvMqZfnZMt4jvuCuutkYHsu0W/khrekOQNEGTeQjeksA16hRphAkV0kSTL+IE17RI9LXbyhVke2rO5PZvOcyAJ9bE40xB4jXfKTYTDqnLHzKSET7gJtpyuWMfb8YtjHrDt+Bv04WgbJfYLfCkz/UmtQrzrtZgPMw8x4ResNIEJgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0rICRzUo6V9siub7ojX49yNCEwl/tA1GiN0XE/5mD4=;
 b=lPAbnxnmGADIpOBfKnRnqWIhMcwwh2jZAS662feHs2plj439f3f3a0flm2zfdXBW19wem8TxyNkw16j98Q2MCcFr1H7hBQ7lECbNza4RDEgIhJqUViHJiIai94fa+Cm+xufPhWEyb3P6z9O2HWXUzbnkOV9FQjwy556rmC3+RZaNDEIM1A8yI1kqRZ5TF+RZ3+Dp46OQGlgbONwJnFpsPTy/06xbW3K1E7Vn12UU11/WogwUIOy7QcgGJm4EnjvakGF2MzWpde+krgz0Gr//U+pxbTWTpJmPN4Sbkl9XbOOpZInOeEZFx+UsdIflPFhCB8DOtlIGquzNqCIt/Rn1Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0rICRzUo6V9siub7ojX49yNCEwl/tA1GiN0XE/5mD4=;
 b=gFiAUzEY+biIKHu5fAM3O0R1K67tnRtjdNr5nqiPDtd7oRJipHwHP8/whzrXAbghKO4Ul8JxZur9Yfk2TonyNXPJkhu86BwaeXLQu/RJ6rqlwwAlt9H/bNJ6N/COCKcRxH3A3GMmj4FyvE1PNOzvsuFkeGOEOdf7gX0CdMtpJ5o=
Received: from IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 22:14:53 +0000
Received: from IA1PR12MB8311.namprd12.prod.outlook.com
 ([fe80::ecc:e2bf:cb33:468f]) by IA1PR12MB8311.namprd12.prod.outlook.com
 ([fe80::ecc:e2bf:cb33:468f%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 22:14:52 +0000
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
Thread-Index:
 AQHbYTG5PPtb1U4eCUarxpU24+zL4bMOWgAAgAAcSQCAFH+oAIAALw0AgABMsgCAAAH9gA==
Date: Wed, 22 Jan 2025 22:14:52 +0000
Message-ID: <CB749FA4-79E2-49F0-9BDF-67B089A8EC35@amd.com>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <20250122165854-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250122165854-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8311:EE_|CY5PR12MB6525:EE_
x-ms-office365-filtering-correlation-id: 0ca0b276-512d-44bd-9a95-08dd3b3231fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TS92S3R3S2ZLTE40VllzRk43M0dYZXlzWWZIMExUc0tXbEkyZm5iYTJDTXpi?=
 =?utf-8?B?VlJSbXovUzM5TlRFdXZSSmVOTkNjOTFjMlFpNkFYK0l0ZExSQU01ZURWQnN4?=
 =?utf-8?B?aDJGWVozVzVISDhSSXU0YkxuWXNrVDM2MGVaMUhmZFhuZlU1NWdzUmpzRWhX?=
 =?utf-8?B?ejZpUDFBS0NTckhweXJQMGdITzdnMWdWMlVXRkw0aW9vTDdOS2U4VGFaSDZY?=
 =?utf-8?B?emFISEpXZndJVEhzWGNMTzd1NFNUMnlPdU5CZ1FDcnRQVDhwMks5eUxZdEow?=
 =?utf-8?B?TkhxeWx0NWcySXoxRjBZYS9VWjdaUlp4Wjl0dmpwR252bVB6WFdkZGc0WWZT?=
 =?utf-8?B?dmkzOVRYZkNWMUxqeWpkeEhRUlhGcHllNzFlbjBNU2xOK3NWQkRCckpqSkxm?=
 =?utf-8?B?VGJ3Z1B3d1BLU05aODVFZmxSb2NYdWhyd1UzUnJmQWFaYy9XR2dkSW1rRGND?=
 =?utf-8?B?SGxnN1ZDaHhmOUxoM1g5QUcrTnMyd05ET3ZPeFNaQURDQVEyOXFxbjZXOWZR?=
 =?utf-8?B?YmRLWVovNmdsTzJNVEJ2MytGT3NjQ0ZRUHVidGttT2JEL3p5bGxic3B5akZP?=
 =?utf-8?B?VWxZVjhsY0FSakI1Kyt5WkNkeitMdDcyUHc1VWNpZDJ1SS9yU3dVQVo2bkpw?=
 =?utf-8?B?YS9jSFNtMk1PSllxMCtWZVZqS2k4MXR5cjJIZ2t1T0VBTDJCU2Z5WjAvKzFQ?=
 =?utf-8?B?M2gvajNJVkg5dTI2bjFCeldpNGttT1I4UURhUXppdlEvUExqTExoNDkwKzhq?=
 =?utf-8?B?MXVLclhGbk5YWHRGYWZ5RVYvQkVsTmd4ZCtCREVWZzJadXp1RGRiMGpUTnFI?=
 =?utf-8?B?S3pTUG9zUHh3dHJ4VDUrODV5bnloWlFxbWNwRytDUHMrVlUwUytwNHhTbi9w?=
 =?utf-8?B?YmNkc2VWNW9RblM1QjhVRTVTMzY3WnY4OHUzQzZmMkM4dDNtTlNscTZ4OUhD?=
 =?utf-8?B?YmxMMzhMTzhhUXMzMEZtY24vLzNpYUQ2aXFkd2hMaGw2STlsK2c0ZGZqb1Rs?=
 =?utf-8?B?a1M1cTBpSDczb2tFOVNkSHhxV0dxNTExektnZ0VOei8wUkx1aGgxZFhrSUlr?=
 =?utf-8?B?cE0xU21hRWpSaDRVckVBMXRua01PUzRValZvS0N0bE5GbUZQVU11bG1QTmEy?=
 =?utf-8?B?aGdBeVhVQllwdGNvSnFJTFp0aU44NDZ3S2NQSERxRWlNTlYvTFJsbjUzUTgv?=
 =?utf-8?B?RXRtY3BpNVZGdTEybzczVXpCZ04xd1FFMUNWaXRvN0hvQlBhZ2cvbGR4eVdJ?=
 =?utf-8?B?RUNlRzhzSmozdHcrTFNaRHBUeFZRSThRNTBjMlFiYk5maS9Uc2dQOFgyRThF?=
 =?utf-8?B?b09IdG8zOHZCUjFXeUxBN2srb1NST1V5Z0RBdUlHemxDMkdpZUhiMFMrS3I1?=
 =?utf-8?B?T2hNRVYxb1Fsc2FoYTkzMUlCREZ3L1lWWVQ2TW44cjlZZnJNdFpHQ0NHa0V3?=
 =?utf-8?B?TThPRTBiL3JlQVJoNEp1MmJHR1B4Zm9CZzBTc01TaUdjWS8wcTBVUlRSUXVS?=
 =?utf-8?B?WEJTRjF6YVdjZUdQTWlRRVNCalNsekR5UTlTL2QvZTZRUGJXK0FxN3Z3eFhl?=
 =?utf-8?B?cThabUgyK0Z5NC9IMFFnSjhMRC8vWXdqUTJsZy81SXFmdUxac3RVUFEvcVZy?=
 =?utf-8?B?TEZRTW5ERHRkN2NoN3J6OEN5WjZORHpncjdHR3BpNFN5ellLeXVOMnh2WUp1?=
 =?utf-8?B?aEpuWGVVOEFlbXdSRmpxbUxFK2lpRUNGQlBFeWdkNU5kV1RlSEpsK2cybTZL?=
 =?utf-8?B?aGU0VTJhVXFnOG54TzNGR05WMHRVdUJ1eUh3Sm50cGJhcTg2ckNka0dEam9z?=
 =?utf-8?B?VTZ0VXQ4d012L1dyMlhpZUJWU3JuUGtSc3QzaDAwM0JuSXRvNk5GKzBBclh3?=
 =?utf-8?B?OWFyUTgzNWlIMEl6MUhFbDVENWsxMUdjWWV1MnBWc1NGWGpoVmhpajNBcUNo?=
 =?utf-8?Q?Cw0DrYdnfZi4ccQkesVw5ZLKzSYcU6c2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8311.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmRpZ1lmS0xwQWt3OTI2MzN3b0tUTWV1TDFZR2l4end5anZtaFJEcmFmQWpI?=
 =?utf-8?B?bmZ0ZldYa1J5MmYxdXdWTU1ZU0ltb3RaMW9hS3RpdkEzbG9MdjQ3K3pVYnVn?=
 =?utf-8?B?VFYvd05kSTIxTTVIVVk3N2RIenFUUFk2S3NxMlhyem9DYzlaWHRPMDIrYy9M?=
 =?utf-8?B?aE5jTXBjMTd2ejRhdFMreWRpOEtkQmFyYWdRY1ZXb1BhaE1nMDBrUkNKZ0tt?=
 =?utf-8?B?N3FSRnBRTnRUZmJsait4UGFJWDJ3WW1qc1ZyeXJxdzhMYjBkajBYSVFYN3Nh?=
 =?utf-8?B?WHlKTWoyNHg0ZEhrOTduYUhha3ByRU45LzhvbTZUTUhIajFPSDY4WTNaN01w?=
 =?utf-8?B?TzJBa3p3enU1QTZyM0RVY3hXbU4yK1J2cmZ5TG91U0YrcDFpeDlJMGxMMVc1?=
 =?utf-8?B?QlB1S1hMVE5uQndOT3RWdENtY2hRYlNLcTFOQW9PQi91SlVmZzR0eTlRYi9N?=
 =?utf-8?B?a3dkeVRlUkY5TUpxeXYvOU5jRzl5V2NvVzdkdFViQ2NyWGoyYk9WMFpUQjFR?=
 =?utf-8?B?RzVUYlcrR3YxdzJZR0pHL00yaU0vUVVwclEwVDM0Q3gvRitUWmVCOVBoM3Bx?=
 =?utf-8?B?Nml6azA2Q0w1RnBkUXVQMjBwUVdrWFBkSk4yZ0VoRlNqeGJOR3RFbWdQdTV2?=
 =?utf-8?B?dU9sMTNXU04yejJEc2VxRTJrMjVjbktVNjFad082czBGUUJ2VlVGTGhxQi82?=
 =?utf-8?B?TTNDSHNkTnlpT1RJN00zV1JkYkRwQWVnWmdiOElsVzBGNmZZS1NEU0d4UlQy?=
 =?utf-8?B?QWtwbjI0VkRaZDN2OC9sMjFzMXVvVkNsdC9RODNJOUd4eCtxNjJ5TGJtT2h3?=
 =?utf-8?B?MHNmY1NLYlNDK0dwb2k1Z0dXN01jWFNJRG9nMENKdjhmcW9zYVV3VFYyUkh1?=
 =?utf-8?B?aHlmQklQcFpZVnZxeTFITWVoOVozOThxYlR6TnhjZzQwNVRhYkcyK1JnVDZR?=
 =?utf-8?B?bWQ0T1VIODdpbzhzelorR08rNHZmVDMxT2lNcFA4ZG9iNkZtb295UTJVYnhK?=
 =?utf-8?B?bytYU25BRVFkSUNoM0FMYUhESjlXRXlwR0FnK2VRVHJQVCtOaHRIb000K0Ni?=
 =?utf-8?B?NWNJTndtME8zeFljWmNhKzdKTDA4S3JRTTRlOXNsZ2hlUnpCNStIenkvTStO?=
 =?utf-8?B?bkNJa05rSllZZzAyc0NEcmdVZ0dEa0ZsVGI4ZTMwUzhJUjdWbFpvL1JLQlEr?=
 =?utf-8?B?eHp1aUZjUUVHME8yUm9VOE9WbzU1a205cFdIQ202NmxmaU1ncjVEdUd6ZWox?=
 =?utf-8?B?aGptR0xibFYvYmpDSmtJOWpqOXgrZjhVMG1WeEsySDVLaGNaNTdBMitBc3Ru?=
 =?utf-8?B?ODVEOThZUEdjUFBBR3ZFYlpxcXRJM2RwOGlUWU1Qc05CUm55Q01KbzZtNEFE?=
 =?utf-8?B?ZDdwUEZ2T2NTMkR0QUJsdWIrdzBiUlRaUGU3NmFXaHRFaEJ1QUxKK3NVN09a?=
 =?utf-8?B?RjRjSFhQMUM1dUJXZ3RLK2hlR0ttQzBTeHBpU1BMQ1N1dGZiSEZCaGxCTjJk?=
 =?utf-8?B?MWY1VkF3aUprSE03WVhOMUNPenhaM3RkYThvL09mNy82ZC9wNWxhMkF6WXg0?=
 =?utf-8?B?bXo4WTNaVTJzQVFqVlpMRFhMa1IxdFd3OTZRQ1lsWVpxd3dtVFVPenFQUkFu?=
 =?utf-8?B?MkpZcUg0Z2RnNmFjaG9VZSs0WHFrZFhXQ2R4T2w3eUZHNlN0MXFWSi9pdy9x?=
 =?utf-8?B?bS9aOHliWWMya1hZS3BuUERWSE1aQW5PWUdPeU5MMWJpc2ZUaDFSMmJidUdO?=
 =?utf-8?B?aElxUkVtMThUQk4zSkIwY1h3Tk9CUVNPbmk3Ly9ENWE4TmsybHlkdWNPazNk?=
 =?utf-8?B?S2dERS9rSUlEdzVPdlRybzhBbGNLUDZpTXcxcGZkOHNRRXlwSjE5bks2Yk9V?=
 =?utf-8?B?SWVtZmlqN3c3YmZxRjVuazZrSngrUkVyaTgrK001YStBU240OWlHT09EVnZK?=
 =?utf-8?B?a042dGdpTk9ZUUwra2VKejNCKzBWTGpGRm1JejlDbC82V0N4SHYrYjkwbDJL?=
 =?utf-8?B?MU5YOEJEd05hTEpHclQyaVNubVRpUnV4ODhzR0lCQ2pPQWVFVWVWaldhbUEz?=
 =?utf-8?B?dUxuaGwrVURFSzl1L0gzWDN5dW12WHpuTTE2Qko3R3EzTjVudEpmZXExREFO?=
 =?utf-8?Q?4O3sdsbZN5yIMquPSaER8LiKC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36587DAF5DD5F843B6B27D3EFFC96499@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca0b276-512d-44bd-9a95-08dd3b3231fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 22:14:52.9463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+IULZFP0GUo7wOndSmPSTQS+3rVAtTngYz+J9fK2LT15Q8F08FKIr1Xhn9x2sO2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525

DQo+IE9uIEphbiAyMiwgMjAyNSwgYXQgNTowN+KAr1BNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5h
dGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBvcGVu
aW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4gDQo+IA0K
PiBPbiBXZWQsIEphbiAyMiwgMjAyNSBhdCAwNjozMzowNFBNICswMTAwLCBDaHJpc3RpYW4gQm9y
bnRyYWVnZXIgd3JvdGU6DQo+PiBBbSAyMi4wMS4yNSB1bSAxNTo0NCBzY2hyaWViIEJveWVyLCBB
bmRyZXc6DQo+PiBbLi4uXQ0KPj4gDQo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ibG9jay92aXJ0aW9f
YmxrLmMNCj4+Pj4+PiArKysgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYw0KPj4+Pj4+IEBA
IC0zNzksMTQgKzM3OSwxMCBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fY29tbWl0X3JxcyhzdHJ1Y3Qg
YmxrX21xX2h3X2N0eCAqaGN0eCkNCj4+Pj4+PiB7DQo+Pj4+Pj4gICBzdHJ1Y3QgdmlydGlvX2Js
ayAqdmJsayA9IGhjdHgtPnF1ZXVlLT5xdWV1ZWRhdGE7DQo+Pj4+Pj4gICBzdHJ1Y3QgdmlydGlv
X2Jsa192cSAqdnEgPSAmdmJsay0+dnFzW2hjdHgtPnF1ZXVlX251bV07DQo+Pj4+Pj4gLSAgIGJv
b2wga2ljazsNCj4+Pj4+PiAgIHNwaW5fbG9ja19pcnEoJnZxLT5sb2NrKTsNCj4+Pj4+PiAtICAg
a2ljayA9IHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUodnEtPnZxKTsNCj4+Pj4+PiArICAgdmlydHF1
ZXVlX2tpY2sodnEtPnZxKTsNCj4+Pj4+PiAgIHNwaW5fdW5sb2NrX2lycSgmdnEtPmxvY2spOw0K
Pj4+Pj4+IC0NCj4+Pj4+PiAtICAgaWYgKGtpY2spDQo+Pj4+Pj4gLSAgICAgICAgICAgdmlydHF1
ZXVlX25vdGlmeSh2cS0+dnEpOw0KPj4+Pj4+IH0NCj4+Pj4+IA0KPj4+Pj4gSSB3b3VsZCBhc3N1
bWUgdGhpcyB3aWxsIGJlIGEgcGVyZm9ybWFuY2UgbmlnaHRtYXJlIGZvciBub3JtYWwgSU8uDQo+
Pj4+IA0KPj4+IA0KPj4+IEhlbGxvIE1pY2hhZWwgYW5kIENocmlzdGlhbiBhbmQgSmFzb24sDQo+
Pj4gVGhhbmsgeW91IGZvciB0YWtpbmcgYSBsb29rLg0KPj4+IA0KPj4+IElzIHRoZSBwZXJmb3Jt
YW5jZSBjb25jZXJuIHRoYXQgdGhlIHZtZXhpdCBtaWdodCBsZWFkIHRvIHRoZSB1bmRlcmx5aW5n
IHZpcnR1YWwgc3RvcmFnZSBzdGFjayBkb2luZyB0aGUgd29yayBpbW1lZGlhdGVseT8gQW55IG90
aGVyIGpvYiBwb3N0aW5nIHRvIHRoZSBzYW1lIHF1ZXVlIHdvdWxkIHByZXN1bWFibHkgYmUgYmxv
Y2tlZCBvbiBhIHZtZXhpdCB3aGVuIGl0IGdvZXMgdG8gYXR0ZW1wdCBpdHMgb3duIG5vdGlmaWNh
dGlvbi4gVGhhdCB3b3VsZCBiZSBhbG1vc3QgdGhlIHNhbWUgYXMgaGF2aW5nIHRoZSBvdGhlciBq
b2IgYmxvY2sgb24gYSBsb2NrIGR1cmluZyB0aGUgb3BlcmF0aW9uLCBhbHRob3VnaCBJIGd1ZXNz
IGlmIHlvdSBhcmUgc2tpcHBpbmcgbm90aWZpY2F0aW9ucyBzb21laG93IGl0IHdvdWxkIGxvb2sg
ZGlmZmVyZW50Lg0KPj4gDQo+PiBUaGUgcGVyZm9ybWFuY2UgY29uY2VybiBpcyB0aGF0IHlvdSBo
b2xkIGEgbG9jayBhbmQgdGhlbiBleGl0LiBFeGl0cyBhcmUgZXhwZW5zaXZlIGFuZCBjYW4gc2No
ZWR1bGUgc28geW91IHdpbGwgaW5jcmVhc2UgdGhlIGxvY2sgaG9sZGluZyB0aW1lIHNpZ25pZmlj
YW50bHkuIFRoaXMgaXMgYmVnZ2luZyBmb3IgbG9jayBob2xkZXIgcHJlZW1wdGlvbi4NCj4+IFJl
YWxseSwgZG9udCBkbyBpdC4NCj4gDQo+IA0KPiBUaGUgaXNzdWUgaXMgd2l0aCBoYXJkd2FyZSB0
aGF0IHdhbnRzIGEgY29weSBvZiBhbiBpbmRleCBzZW50IHRvDQo+IGl0IGluIGEgbm90aWZpY2F0
aW9uLiBOb3csIHlvdSBoYXZlIGEgcmFjZToNCj4gDQo+IHRocmVhZCAxOg0KPiANCj4gICAgICAg
IGluZGV4ID0gMQ0KPiAgICAgICAgICAgICAgICAtPiAgICAgICAgICAgICAgICAgICAgICAtPiBz
ZW5kIDEgdG8gaGFyZHdhcmUNCj4gDQo+IA0KPiB0aHJlYWQgMjoNCj4gDQo+ICAgICAgICBpbmRl
eCA9IDINCj4gICAgICAgICAgICAgICAgLT4gc2VuZCAyIHRvIGhhcmR3YXJlDQo+IA0KPiB0aGUg
c3BlYyB1bmZvcnR1bmF0ZWx5IGRvZXMgbm90IHNheSB3aGV0aGVyIHRoYXQgaXMgbGVnYWwuDQo+
IA0KPiBBcyBmYXIgYXMgSSBjb3VsZCB0ZWxsLCB0aGUgZGV2aWNlIGNhbiBlYXNpbHkgdXNlIHRo
ZQ0KPiB3cmFwIGNvdW50ZXIgaW5zaWRlIHRoZSBub3RpZmljYXRpb24gdG8gZGV0ZWN0IHRoaXMN
Cj4gYW5kIHNpbXBseSBkaXNjYXJkIHRoZSAiMSIgbm90aWZpY2F0aW9uLg0KPiANCj4gDQo+IElm
IG5vdCwgSSdkIGxpa2UgdG8gdW5kZXJzdGFuZCB3aHkuDQoNCiJFYXNpbHkiPw0KDQpUaGlzIGlz
IGEgaGFyZHdhcmUgZG9vcmJlbGwgYmxvY2sgdXNlZCBmb3IgbWFueSBkaWZmZXJlbnQgaW50ZXJm
YWNlcyBhbmQgZGV2aWNlcy4gV2hlbiB0aGUgbm90aWZpY2F0aW9uIHdyaXRlIGNvbWVzIHRocm91
Z2gsIHRoZSBkb29yYmVsbCBibG9jayB1cGRhdGVzIHRoZSBxdWV1ZSBzdGF0ZSBhbmQgc2NoZWR1
bGVzIHRoZSBxdWV1ZSBmb3Igd29yay4gSWYgYSBzZWNvbmQgbm90aWZpY2F0aW9uIGNvbWVzIGlu
IGFuZCBvdmVyd3JpdGVzIHRoYXQgdXBkYXRlIGJlZm9yZSB0aGUgcXVldWUgaXMgYWJsZSB0byBy
dW4gKGdvaW5nIGJhY2t3YXJkcyBidXQgbm90IHdyYXBwaW5nKSwgd2UnbGwgaGF2ZSBubyB3YXkg
b2YgZGV0ZWN0aW5nIGl0Lg0KDQotQW5kcmV3DQoNCg==
