Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651263A3E98;
	Tue, 19 May 2026 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779235009; cv=fail; b=SBItZ7gPcNjkMENPN1jBqLp6GL6EH8LJVKOGo2VW4ZZ1PtVgIlM55WYN3Kv/VJ4gQ0g9+PkF7wVXRpdtMtSoPZbbhekoE+YslO/LeUKQIK0HfGK4qTAgYyM4ei2VKv9tALxa7ZnwJe3Yyq7b+r8eqX1zmXkA72/63hHgFlyr3RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779235009; c=relaxed/simple;
	bh=ZS9r4tyK5VaOnSr3OhF/eXnKcXaLc7nRx9Qsa65vBts=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eACaTkmtUUXBADp4lMwFhr9uR1dG2ymXrnVAcUyDCxVjbWIUQ7eHlTHRxa2rs0JtAaYWAYf6PEtBkqGXHw2KfSGt1w5gcNY7xyd6skSjbIB1qO26ypJd6Vqb/fmInOJaRaARgT1KxSBD7GTVdZ48TE3uA1bESWElCNXivO9KubQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fWAsk3Ln; arc=fail smtp.client-ip=40.107.208.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fWAsk3Ln"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1ZlGPaWr5CGU+OTtiSNPfiZ0ZaDWIx9kGNazvr36gh7zkju0SzOnqkJoioNSvILa6tcCHzSn8kGRPPuqsdTLLyPGVgnMizsUHfhXyBqvh2G99MPtZDRsq9T0yblKJ7X1SjNKkkMpydK3VzYY0jAf3diyLYtMhJ9q0neKNCiqIU4SS5cxP16A8eQnFw3M0iljem6Q72Y/DFsQKGS2Za6nIySVzJiYJ3ql7309AEVg5j9PQKPvq28x5QSgYYfzbxf66vV1dJ53sEQbVxz643VoBTy4ot9vWnHPq0W1/VDmXIdI1qIT1QnYcjvgTFwZNGO1fO76Qwr0qwTqkIJ2FLRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZS9r4tyK5VaOnSr3OhF/eXnKcXaLc7nRx9Qsa65vBts=;
 b=b36xLxqxmrXJaTpeisuyieho4TzfpgAMBkIbTxAYQ/PpqH32sCB0d2N9D3iE6acH7Fk+mh1pGlmwC3aTIyXHDvgT+0s5fAT++3JAQRWGMrCbKrCJEKclnaAPvDQ34OIXtaUUP5Yi6/1k+vz7BFaMgYA1GDWdCIBfx4fqSwkzsDigoy82o3vUf8sj5d41xD6SUW/vSHCLfFdaEfVlQdfP48nheb/U6wI4rxAx0LrG2i8/8xsZlf8VkvfQgJACdzAE+Cxd/ie/GzY5ULZ3FDDuojTg40Bcb4CeVR/mkta0FoWBdnPpOr37ADgA6BCLS44mrZs5Ed1hwf9YjaaZH6IJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZS9r4tyK5VaOnSr3OhF/eXnKcXaLc7nRx9Qsa65vBts=;
 b=fWAsk3Ln8UEgutVEUWhmqwkwwk4JqVMbMiEMeq+np/yWxITpSp3fpWXrjUnkHmX95wfoQss2IktfoX7scW7ixks1Vhs8WadIvlL5hoj90fODrZdeXkI1SEIGrIgk5OKylLBnvlZ/YICC8Jt4rM5NWN1ViptfvL56Ax1vDEGnMBfiWGqjAUzfhwHk8PoAeYX4PR/vhybsCa/bQJZ3iTvszNr6GrGjGt0KATwgmAGnnkn0jecsed+hZX1KYRAc7Bd6ONEU4ldz8EhQNCgvlJoxd0/nncXV10atAXVOiUe0U5WjK+HSd5NHig+ebItZcxA6DueyImNdBOLlh/s8J0L1/Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 23:56:42 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 23:56:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: hch <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
	<yi.l.liu@intel.com>, "alex@awilliam.me" <alex@awilliam.me>
Subject: Announcement: NVMe Live Migration Software Working Group
Thread-Topic: Announcement: NVMe Live Migration Software Working Group
Thread-Index: AQHc5+sir6UtfdsKC0SPa4QCC3MoQg==
Date: Tue, 19 May 2026 23:56:39 +0000
Message-ID: <3e566eb1-db29-4eef-b88d-a7978a1d1a4f@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB6890:EE_
x-ms-office365-filtering-correlation-id: 3280a99e-d974-4f90-842a-08deb60244be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|11063799006|18002099003|56012099003;
x-microsoft-antispam-message-info:
 NjLIeBjQHlT1TqaVZpiAGNKwVnUydGVQ1M3r3bPJ4G2tmL8xWEFJF3iK9iCrEAnoYTCtODawlBwEb47mOv9hZ2nymq1MmkhywbSUmtEqsCj5mX661pJGGR/7k+qZPidyeEexE9Kyim3HFh+vGHyj4ougJTQutx5x9uvDQ1xOnBiwBVYnbgfCsKc3VQetFWd6QQ0tBrs9mCTjaraH21o/ewaa2dUcXWgPsnpI64TS07xQaFc5VgT+0x7zosPO7uLGmQVUWlTvPfX4GqWjIjlMVQdOpPwv0LuAcrCyixUGinXDnh+F7877tRJu2BaUez7UPBmnm6lSeqgDac5u26W3R3mTD5JHWlX5vPMMSm9tKQpZXPZqIGxDE/OeZC7VY6zvgGCK9Fq3n/WMuiQsgCMAx07wbQNbhmi1GMi1VcI8VryFLCwtJt+JJwSD2d3idBpa+nOpmoSL3U6hFTVx3yIqdaZDz2SqPBZoiw18VYXw4Svq7DzzZrtde+dwGeqhDeawzhaj4rRp07k4IXz3EPei0Z99TMVHfyoQDhGEzfad3oVAngaSa/c0ZkFOfX6SjcvwLtOZ4O5UxXZQmP4or0NJCbAmdSxpsih9X14t2OD7arf0xLyJ21SveIZz9gE+9RW8fFnIQv5x+WvSRHWAlxMBNNFhRoB9gWbwMb1Bc/SGYI4CTFJ2F8iDwhaiUVdnhL0C2/tgLq5MbB3Jshy2GtBxkQZ+YFFiX4VPl//VbwJ0dhZVB73seMRnuINAN9oVtOMB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(11063799006)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akd3VXVVdk5Iemd3ck9HTUxmYVRPYTFMeCs4MW5zaTU5ZmJOL3lhMGo3LzJX?=
 =?utf-8?B?b09UaVZHaDFXR3g5VUhrUENjclM1THIwVTB4WU45VEVSSjBuZXdXMmxqOTE0?=
 =?utf-8?B?YU5SYlZFSmc2NEN2SlhrOFFlTENIR29HaUIyTko0eUxRTGpwNlprOUNiNUZF?=
 =?utf-8?B?LzlBdHRnUW54b1hPSC83OWVjamlnNGVzZ1pLVmY3WTNCNU1TSlBqRjNTNEZE?=
 =?utf-8?B?MTFyeSt2Y014REhXVUZzb0dNNnBFKzhXQThUNXBlWEJMVWpNcTVuOG9XMGsr?=
 =?utf-8?B?VDBqbGtWT2JSdmp5eXAzR0pqbU1aSnhiNkxLVGpOckFmdXNMSXJibTJnL3U2?=
 =?utf-8?B?RG05UG9vZmRvQmt0V2poVzEvVkJ6VnBZTEZwSzlwUHozZkZua1VwT2VCVUZU?=
 =?utf-8?B?ekwvU1lyVnpYTk53bTNhbmFVd0dGbFo0b0xPWENFdmJXT1BBLzlyV1JqNDZF?=
 =?utf-8?B?cU0zUFJYYm9HajRGNkxNNjVpN3l1TTVZUlVGU2dCTzlvTGIwRlU3Zm9PRDJw?=
 =?utf-8?B?K2dWSXlraEtjeGt4dkRUcVppSmVzbnZGMTBrbDNGb1NVYVltU2pEdU5rbW9l?=
 =?utf-8?B?dk13eVpjKzZocWp5aTl1cXFOL1RjdHdjNzI5bGQ1ejE5dXFlRnRRYi9XUkJ0?=
 =?utf-8?B?MXBnMWRxZFEyUFhhWGtscy91SFBuY1BSNWdFYll4OGZ4MWhzN21PZkJQK2J5?=
 =?utf-8?B?Rmhja3RDODVYZ2xldHRxN0lHd2FuM2FSZGhoaVlYRW1UNnJIVW0rc0Ivd0Vl?=
 =?utf-8?B?dTVDVG9obThBRXFXZFRoalFGL3pHMmVoVEJRMlF6MzdTY3pNQkc1cjVOMDZ2?=
 =?utf-8?B?MEFLUzRCUWdLQk9ZWk1zRVBaWEJBcUZuYnEvNzFabUgvNXl5VlJtRUQ3VVN0?=
 =?utf-8?B?K1hwVnV5Sjk2VGZoajl6dEdtSXgvVFVRK3AzUlQrakE1OUQ3QkVFamRTU3pE?=
 =?utf-8?B?cWtST3BUdzd5dU9uaW11azE3MDJORjljSm1sNjl5S1U3clZqM2E2WXZsVDh3?=
 =?utf-8?B?UlBtQTZqRmhYbXQ1aXpFa3RHdmE4dytkbjNUOStDeEF3cEFhMEJzU3kreitk?=
 =?utf-8?B?dlVHSGV5UGJCOTZab0FJWkdEcVZORnRuRHlaWlZ3SXMyNEpyVGIxNFd0QkRk?=
 =?utf-8?B?Z1FUbkxDVWF6ZldDUDFQQXo0NHY2elg3MU5iVzE5RUhtdkEyelVuSFplYTZL?=
 =?utf-8?B?NmlzRGptbk9mMnFqRkdUZHpJSE9wajN4TVhTS3FlRXB4UklOVDZBR1ZCNTc5?=
 =?utf-8?B?OGg0bTErblBzbVNGRkM1cXU2MVJHOHZUZ0tUbldpQUxJdlpiV1IyRWFaZTN0?=
 =?utf-8?B?M3d6Y0ltU3IzN0xUYmZ6U20wWHR3eENDZWNEYzlQT212aG95M0t4Skl0NHR4?=
 =?utf-8?B?aXluY3orU3BrbEgyQ0EvejZjeWJuakIvRHZKR2JaSTBFaEl6cFpOeUpFTW9o?=
 =?utf-8?B?TWFrSXpVeUp5N3hEbVhWaUZmeDJMUGpLbW55ZGVrVURZM0ZVWmFNTE5WQjVJ?=
 =?utf-8?B?YTJBekpIRU95bHlQcUN4ZVdxTGdydFVwNWh0UVhaNk1HQ1RDbG1tQVptZnZP?=
 =?utf-8?B?MWZ3cW45WXNxTXFVNGQrMkpLODBnTzJGSGJhUmpVSmFtbFcvSnpLSFBadkZn?=
 =?utf-8?B?c1o5cDhzZWtkd1ZPeXMzV2Nia1IveUEyMW1NNjcvU24rOGJXSXMwYnpjSU10?=
 =?utf-8?B?MVVZeHJPOWFMdHlRSkpEbExLT3BDMldlYzl0Y3RTbG41OUdpZkNtbHhrQUZV?=
 =?utf-8?B?RVd1bElaSEhrUFFxS2VtYUtjQ2JWTW1EdFRQSzBJeWNlQitVNysxeGVpblF0?=
 =?utf-8?B?eXB0bHZCNDZpSGR1TG5LOXkyZ1dCVXBFWi83ZDJlU01tTUVza3RnRGhDSW42?=
 =?utf-8?B?dHdMeGRML0I1dTdYY3M1S3pGaStpdVNVQmxPSzczSkhKWUNhV0dyR09rUzk2?=
 =?utf-8?B?OWxxR3NBQkI1c1RUSXJ5UVlUZVh3N3llNkFuekN6QnNmNDd0alhaRHF3SkhR?=
 =?utf-8?B?LzZGOUk2WnE5YnMwc1JPekdWaFBBSkpOaU0vTnNkVnhpK3RPaFJxMlJvd05z?=
 =?utf-8?B?NXlnajJVUVZjTTJwdm12aEtiVFZZOG5QaTAxTGtsTmc4SzluUU53akwyTEF0?=
 =?utf-8?B?dGVYY0xaVGNHZTZZUjdnWEZUYkoxcmVvelZoYkhqNUFVMnVPV1ZtdmJXYkRN?=
 =?utf-8?B?cFNHZXcyN3FyODVjRFFZbGFjVy8wWVlrVTBWTjE1dFJKSUhQak9POGx5ZHB0?=
 =?utf-8?B?bnNjRHBsOHZqcUJvQ2czOTdnVzA4a2VaRGRkdGdrVTArTklMMkVXSmxJNUxs?=
 =?utf-8?Q?hPuiNQ+2buqkgSutRl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88CBA178392EEC438B87E94BB77D7BDF@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3280a99e-d974-4f90-842a-08deb60244be
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 23:56:39.2425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4mA9+3T5AtIc4wvAnZxDceopXNy1mHYRksRzjFcQPAB8itwYpCDFkG2+/13kYS7kO9XY4X+jSqKo0qit8MgTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890

SGksDQoNCknigJltIHBsZWFzZWQgdG8gYW5ub3VuY2UgdGhhdCB0aGUgTlZNZSBCb2FyZCBvZiBE
aXJlY3RvcnMgaGFzIGFwcHJvdmVkDQp0aGUgZm9ybWF0aW9uIG9mIHRoZSBOVk1lIExpdmUgTWln
cmF0aW9uIFNvZnR3YXJlIFdvcmtpbmcgR3JvdXANCihOVk1lIExNIFNXIFdHKSwgc2VlIFsxXS4N
Cg0KV2hhdD8NCg0KVGhlIE5WTWUgTE0gU1cgV0cgd2lsbCBmb2N1cyBvbiBidWlsZGluZyBhbiBl
bmQtdG8tZW5kIExpbnV4IGtlcm5lbA0Kc29sdXRpb24gdGhhdCBmb2xsb3dzIHRoZSBOVk1lLWFw
cHJvdmVkIHNwZWNpZmljYXRpb24gYW5kIGhlbHBzIGVuc3VyZQ0KdGhlIGltcGxlbWVudGF0aW9u
IGlzIGFsaWduZWQgd2l0aCB0aGUgc3BlY2lmaWNhdGlvbiBiZWZvcmUgaXQgaXMNCnByb3Bvc2Vk
IHVwc3RyZWFtLg0KDQpXaHk/DQoNCk5WTWUgTGl2ZSBNaWdyYXRpb24gaXMgb25lIG9mIHRoZSBt
b3JlIGNvbXBsZXggZmVhdHVyZXMgd2UgaGF2ZQ0KZGV2ZWxvcGVkIG92ZXIgdGhlIGxhc3QgZm91
ciB5ZWFycy4gVGhlIE5WTWUgQm9hcmQgaGFzIHJlY29nbml6ZWQgdGhlDQpuZWVkIGZvciBhIGNl
bnRyYWxpemVkIGVmZm9ydCBhcm91bmQgdGhpcyB3b3JrLiBQbGVhc2UgYnJpbmcgYW55IHJlbGF0
ZWQNCnF1ZXN0aW9ucywgdXNlIGNhc2VzLCBvciBpbXBsZW1lbnRhdGlvbiB0b3BpY3MgdG8gdGhl
IE5WTWUgTE0gU1cgV0cuDQoNCkhvdz8NCg0KSSBhbSBvbmUgb2YgdGhlIGNvLWNoYWlycyBvZiB0
aGUgTlZNZSBMTSBTVyBXRyBhbmQgd2lsbCBiZSBjb29yZGluYXRpbmcNCnRoaXMgZWZmb3J0IHdp
dGhpbiB0aGUgVFdHIGFuZCB3aXRoIHRoZSB1cHN0cmVhbSBMaW51eCBrZXJuZWwgY29tbXVuaXR5
Lg0KUGxlYXNlIHJlYWNoIG91dCB0byBtZSBpZiB5b3VyIG9yZ2FuaXphdGlvbiBpcyBpbnRlcmVz
dGVkIGluIHBhcnRpY2lwYXRpbmcuDQoNClRoZSBwcmVyZXF1aXNpdGVzIGFyZSB0aGF0IHlvdXIg
b3JnYW5pemF0aW9uIG11c3QgYmUgYSBtZW1iZXIgb2YgdGhlDQpOVk1lIFRXRyBhbmQgbXVzdCBz
aWduIGFuIGFncmVlbWVudCB0byBwYXJ0aWNpcGF0ZSBpbiB0aGUNCk5WTWUgTE0gU1cgV0cuIExp
bnV4IEZvdW5kYXRpb24gbWVtYmVyc2hpcCBpcyBub3QgcmVxdWlyZWQgdG8NCnBhcnRpY2lwYXRl
IGluIHRoaXMgd29ya2luZyBncm91cC4NCg0KSSBsb29rIGZvcndhcmQgdG8gd29ya2luZyB3aXRo
IHlvdS4NCg0KX1RoaXMgZW1haWwgaXMgYXBwcm92ZWQgYnkgdGhlIE5WTWUgQm9hcmQuXw0KDQpC
ZXN0IHJlZ2FyZHMsDQpDaGFpdGFueWEgS3Vsa2FybmkNCkNvLUNoYWlyLCBOVk1lIExpdmUgTWln
cmF0aW9uIFNvZnR3YXJlIFdvcmtpbmcgR3JvdXANCg0KWzFdIEJhY2tncm91bmQNCg0KV2Ugc3Rh
cnRlZCB0aGlzIHdvcmsgaW4gQXVndXN0IDIwMjIsIGFuZCBpdCBoYXMgZXZvbHZlZCBzaWduaWZp
Y2FudGx5DQpvdmVyIHRpbWUg4oCUIGZyb20gdGhlIG9yaWdpbmFsIFNEQyAyMDIyIHJlc2VhcmNo
IHBhcGVyICh0aGFua3MgdG8NCkRyLiBTdGVwaGVuIEJhdGVzKSB0byB0aGUgTlZNZS1hcHByb3Zl
ZCBzcGVjaWZpY2F0aW9uLg0KDQpJJ3ZlIGFsc28gcG9zdGVkIHR3byBSRkNzIHRvIGtlZXAgdGhl
IG9uZ29pbmcgZGV2ZWxvcG1lbnQgYWxpZ25lZCB3aXRoIHRoZQ0Ka2VybmVsIGNvbW11bml0eSBh
bmQgcmVjZWl2ZWQgdmFsdWFibGUgZmVlZGJhY2sgZnJvbSBrZXJuZWwgcGF0Y2gNCnJldmlld3Mu
IFRoYW5rcyB0byBDaHJpc3RvcGgsIEphc29uLCBBbGV4LCBhbmQgb3RoZXJzOyB0aGVpciBpbnB1
dCBoYXMNCmhlbHBlZCBzaGFwZSB0aGUgdGVjaG5pY2FsIHNwZWNpZmljYXRpb24uDQoNCg==
