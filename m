Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296C72FD7B2;
	Wed, 29 Oct 2025 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718393; cv=fail; b=S54G/NZJkfVb2DntoGHcLu7VKRaoV9ST90uVdGz/hsifQyMLiecuYcTBDIgVJfdNY75vLhRaAl6WnyUcrIi+AJu9t7gp7P+mtn9ziel0EcmqqABuwyHUmL15aHVL1PneKZ5EbcYPs+9NDl3VRIzvR/mkZl95QeQLpb8iOUo0TFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718393; c=relaxed/simple;
	bh=0qrtRqS4dDDYKC+bED1a+4XaONxl6T9SRTnMNfdbInM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DFFBflylq8BJMr0e/1hXLgCeNtJBf1DsVzg5pbMqXQrr1yvRbF2UrSLoiBRAQWCuFqbxBib+Tj1AVbhyq4UPlJsDY6kjuWr5N6Bq7KdF8KN6xvY32FPdY1xv7GOjY9NG9wPu9xZiSHQqW2GJytdOUJz2eNa4L0xWcMFb1HhY4NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ea7UcBzw; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ea7UcBzw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvJrFeXg9ARrSSh8aWp4PeBI2CDVOx7r4lJgsb2Shad8oySAJckFqyUoNTmUHbhsoAKHOtXSDAggr+0KJ9UPlwKpmRMgrRtjcW7bf4pGIU/Njuo0vcsqWkiCm9I40s/+R5BA9cydHdBmLaqQQqZalvc+l30tDCWRgAqbJ5k96cC7AhSpv5eev12X4zlNIUXh7SC0ACuidxZcExCIu6/V9LOz3QXKudOQSEFZyTJ8/weT1v9MhcDFPUsk6hdTaCOlSYzumi/4yRlfsYHDOOgyj8pflT8N/a/4Cqg81f5AEPhf5CnU1dKWtDjgl7iqaXFVaXuIF5JrlsrMUq+oQIX56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qrtRqS4dDDYKC+bED1a+4XaONxl6T9SRTnMNfdbInM=;
 b=vg3+aE4zl7mihiyz8cfL6x7JES/5ehoKKNA0tjExcTybZB9PFRigrxmO/OQTNwJd8eFA5rTqaySG/526AQcuh79lioHi8GIKUQ+RH6pX0s2e8FDaB4wPIqaJExXTdJp46wOclobwfgIHKxn4oaQ5VZnTFLWLuJzurXrhuyZ7cdP7J5936mr3Cj9b5V1zWpMpD7jpQotZPCPic7XfF/VGQBVxSyZjWXIpjZozAvh/eAwrloYZQsE4Dk5ZphfvqiMRtBZutJ4YJy/sMxpPXsOURKVdsrSyxbVpk2YayTmVHVsncCz5qTfnFSOGvVfVcXCpJwLmTdqDxpp7dY3oUeDhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qrtRqS4dDDYKC+bED1a+4XaONxl6T9SRTnMNfdbInM=;
 b=ea7UcBzwxTDWhNnbVrQUD5IxJ231q/RKAdhdQCImzD+rDySPl3NTvDG/Lp3ShE2E1CuJ9tQ1Gi9CX5uApKJ19ETQKrltAGudq54aFgsFsnsUEV2otMH3u9vFq6TlThmj1p1kRxzM92/IGrOzzoSfciU0UHlRh0FM2wGay8nwaTonB4QpETN65f17e8XTAcptr8iOx2DEFTOiHN6TquUaymkM/gRPqvqoHApnfbJ4DaeEuUH+js1yp0Lf0/C+YGzIQg5yEHfQB2Q/pYWjWD+G5ky9PvE59hQfB90Vn8bDA/eScQUHlAcnGlZ46cNZeebQdfKwxk8JRHL43sPIvoviMQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 06:13:06 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 06:13:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-stat: convert struct blk_stat_callback to kernel-doc
Thread-Topic: [PATCH] blk-stat: convert struct blk_stat_callback to kernel-doc
Thread-Index: AQHcSJkaoj79k5GLsUuuyDvD8NPqw7TYpPwA
Date: Wed, 29 Oct 2025 06:13:06 +0000
Message-ID: <b5e3d02d-10b1-4cfc-8a10-569b2ccaed33@nvidia.com>
References: <20251029055807.141835-1-rdunlap@infradead.org>
In-Reply-To: <20251029055807.141835-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB5613:EE_
x-ms-office365-filtering-correlation-id: 7e66aec9-5039-410d-6664-08de16b239d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmZyZ09vZVlpeFF1WjY0cGRCNGdOU0RsYkNtay9UYWp6LzBDRXk5bHN3MGs1?=
 =?utf-8?B?aXZNTEZPT0NBVjFXcDIzazl0aDRIc0NnTXZDM0hKbnBvZjVONmJRUGYxY0p3?=
 =?utf-8?B?eFRnSHkvejB3TDlQUXBlaXVLWGZUaDZYaDRWeG02NmRxMlo2QUczWlRIN1A5?=
 =?utf-8?B?Q2dwRy9Pb2ZlWFlrd2VLVXpoOUJpTUIwQkNzVTJzaE9PZWQ2OXJyMlVjVm1P?=
 =?utf-8?B?R2pYb1JnTXFvYXdoa0RlVEI4ZWxrVHgxRzl1NHVBTERXRk1TWmd3dis5UTZp?=
 =?utf-8?B?TlJWcm05Q0hOZFJUWnFCb1dXSTZJaVFQNVN4WjZ6dE4vZmJKeEVSa3RqWmEw?=
 =?utf-8?B?NFpMRmNPKyt4UExNTFZ5VWF6eW9MdnJNNWlLOVZjSGVSMlJDbEk1UmxDZlpj?=
 =?utf-8?B?OEpaRGRMOVVFS1R4b0tkY0s3Q2F0eVVKcTRIL285Ryt0WW1HTWlpaUplblhr?=
 =?utf-8?B?UE4zNTk3MU1HY1dhTW9MY1ZiOXk2S1NJdnJnem1KbWVoQUpWM3dZM3Y0aG1Z?=
 =?utf-8?B?c1l3b0d4OXcrQU5QU05vU2ppZThMMVB2V2o3NWIyKzh2UFJuSks0UjlpUVEw?=
 =?utf-8?B?Q2JpSGtsci9GZmN4bmxLbjJmanp0bWo2VjFiTzdydjhlNjZvWmU1ajBNTVNy?=
 =?utf-8?B?NFhMUllkUEVMQWFMUTkwcFlGZ0VuUzRYUzkxOFY1VDh5aENCUjRBVzZIRnhS?=
 =?utf-8?B?eE9GLzdkOER4WlJkWWJBQUVyaXdyRVlPMHFOM3ZKdFp5Q2krWEZNQlFMbFh2?=
 =?utf-8?B?eEZwMHpFN0tBZkFKR0tqVm10SkNiVmtocmxMNWt5a0FFTXV2bENhb0pLZHhP?=
 =?utf-8?B?eEg1cDJMTUlpaEorbWYrZ3pvRGk0eURiSEdqbXd6VEMzWXFCNnhVcERpbE8r?=
 =?utf-8?B?OWtqb3ROdnNQZmIrQmlLbFN6T2FBRk54UXdhTWkxTlNhUzhYRk9ldjI1c09t?=
 =?utf-8?B?cjV5K01aS3VMRTBBaDJMWWZPTDlTVWRjSDg2SGpIbFNLNVc1clMzQWtQZVll?=
 =?utf-8?B?dGRRTTZXYjlaZGUvdjFOdytWbERxdXpkNnkwUWRUblVSWTRKd3NCTDNxKzFh?=
 =?utf-8?B?TlhLUFUzdUNyRjlLeEp5RFhFRUdObUFKamJBRzNMT20zc1R1K3ZSY2dtU0tV?=
 =?utf-8?B?V1RpQnpib3lud0s4bXl6VUV3YlZEenRnc0hMczdJcElBcFdNbXB6YU1Bak1E?=
 =?utf-8?B?VHJiNUZlTWZKWU5Ed0o4K3Y4WVpaNXFvazRWUnNUZ0RNWHFhQTNCL0p1Yllj?=
 =?utf-8?B?enk3ZDNEbll0cW4rSk9RMDdQRTBnS2RIUjVFdlBRNEQxNmp6QjB5QkVmWEZW?=
 =?utf-8?B?QU9jaUR1c0xsRUNtOEhIb1gzVDRKTWp3TEVUNmJQaWRLbFVFVXkwQTdMc0Rp?=
 =?utf-8?B?VVNVN1dSL09QL2Jvd2pEYUoxaEVZdzFIcSt2Qm9RM3ZoTnJZSXg2d043bEY0?=
 =?utf-8?B?M3lONkx3SDVRTUpwRkNYUkphR0c0eFZELyt5WnloNE1Td2lSSXFYL3RLVzM4?=
 =?utf-8?B?ZjQyMmdYaGVnd0MydGVSa080dGJGbHpmamdFVkZhVm9iU0huRlgrMGdrSjRx?=
 =?utf-8?B?Q0VUZzR3RWtCZ0tOd29wdVFEWkl6RUhrZlk5WWk3WmlKSVVsdXlHcHdoTW0w?=
 =?utf-8?B?MEpjdjNMNnlINEQ3cUZiZVNNS3RzbEVrRlpENDdvc041K3lhQlpFWVJNNWMz?=
 =?utf-8?B?bm91NnBITmJQSW9HU1FHNENnc2lJVmlCR1ZaWjVtN1B3MEduTjJjcFFMYy9l?=
 =?utf-8?B?a24yYzFCWThHbW5lbGpEb005VTB1cFpTUERmMTBSZnQyV2xUV1BiRFcwZDFq?=
 =?utf-8?B?a0luRWlUbThldXlSNDhlUm1wVldTOXJ4T2w1eU14NjRFMXV0RTk0Wjl3WVpS?=
 =?utf-8?B?cXpoQlJ5MW9MbWVzVEgzSTN4N21kcis3akN0bnllNEltb0UwNTR4YlUvdXZK?=
 =?utf-8?B?YjdkcmYrT293WEROWlFRUzJkdGVnTitzczRBbXZ2dkVmMURBSzNhdFcwYkp2?=
 =?utf-8?B?TThCTHRRU1ZkNlhvQkQzTnppYkZhUTVqVTVTYVRML3BwN3N0SktOYkpNQ1Y5?=
 =?utf-8?Q?wF/BoI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wm9FbGtHZUVjUi9yajN1RkJyQndYSVpmMmZ3bTFlKzdkek1uSnNGSVlrOWNQ?=
 =?utf-8?B?U2xmQlZxMVpXbFg2bW5OUGFlVnlKUzl3MU5MYWY4ZDl0TVNGT3NGL0NFY3FU?=
 =?utf-8?B?SkQ3R1RUYk4rYmVxWXZvOWJlSkVnQVZuS0NjUVFLOTJtdVEzaFlCY3JyMWRz?=
 =?utf-8?B?YkVsZW0rU0pxT3RDcG9tWjE4ZHlzb1hYVEVvdEVKU0pZazRnSU9ocjlRU2gr?=
 =?utf-8?B?dmVmV09VZVpBeTlHRGtMc1dJQ3pkRUJWd2NNY0dDTEJhNkpUNjEvMFYvU3FO?=
 =?utf-8?B?eTViSlJVbnY5R0JUQnBlQWVDQVdxcFgxc2FWanZJdFl1ZGVOdjQxa2RDaHRP?=
 =?utf-8?B?MmlhOE9TN2ZYR2Y2cUR5U1JSZGlTUnFTNDZ3K0Q5ekVjS2J0ajVIckdkUVkw?=
 =?utf-8?B?NGRRWWNJVmxQRnhGVGhWejZGZ21XU2JsZHZBY1VBU256d0lCVFdvVFptNnJV?=
 =?utf-8?B?YlducjlPSjJpSEEvRVpLS0dLaktKaDVqZ1g4K3NRWFVlR01WZ1lFTEt4OVFn?=
 =?utf-8?B?ZHRCN1owUFpVNUgvNlNWRldnQlZobDdXOEJJK016a0pCcFViMm51L3lBamVU?=
 =?utf-8?B?RGNNT1hXaEFRcHFKR05UT3NLWTdpclVSUTJXWTQvT1YvK0VnMlJ1MzhIQnhu?=
 =?utf-8?B?WW5ZUE1HRUpRakp2eStrdEpUeFhYenp2d3VzRkdRMHhSYUNvYlhjVkFZMy9i?=
 =?utf-8?B?T3o0WHdWMmF3N0Vza3FPcnMvZGZZWjdaeFFTaUZldGRXbUVTTGN3emtVMi9s?=
 =?utf-8?B?SzBjQ281UmxhTlByZkhoQ1BXVlR0VGVmSk9nZ2lJTDF6Z2NMYk5iRCtvb0Jk?=
 =?utf-8?B?VVFLYVBOM3FjNExUQ2dGcmxQQWlFYmJFUHlOTTZQVEpTNHpEZlo2OFlUb3ZS?=
 =?utf-8?B?d2lFSFlhUnBZRndnWGhxeVg1czdhQ2UyRlZaTWE2TVc5eE5Manh0UXdlbGJM?=
 =?utf-8?B?dXBCb2NqSENFdnIwWTlKM3hRdklMSXMxUW5qa3ZnYlJNdmg2NWpiUTA0aWlM?=
 =?utf-8?B?MHk1QmFFNkU0RzVKOHdQNkVNbm9DV05jK0VXcjhITFNYZTQ5NW5IUXNrRms3?=
 =?utf-8?B?RzRLOWZHTUptNzFiU3ZwcEpPVGJaS1FBZnF5MTI1dnl6WEpxSXduUndCdXpF?=
 =?utf-8?B?SnIwR1dHQzY0dVZZRHVyTTMwMmNlU0lLSGRqM3k1MWJHVVlnUDZxUXh3Sm1w?=
 =?utf-8?B?S2NqOHVqQXMwdmtDaGtRTHdSTTZyRWltcTNhRXBIUUVYLzViQmMra3NYSksr?=
 =?utf-8?B?V0NUMTBKSU9CMkNWUVNPcVNBWk1lUDJaOEJ3enorUWJLekhqY2VLRWhaZXRS?=
 =?utf-8?B?L0pXUXJtSGttU25KTlRlRXR4aUJTQ3ZYcHBiVWhkMjl3Z1VwVWxPL0JkdzFo?=
 =?utf-8?B?RzkvZHZKN2NrYWdZQzNDK3R3NUxEK2Z6ajlYUFVMUkRGUnk2UUl2cFlYOWlK?=
 =?utf-8?B?bG03WC9OdU80eHJMcjhta05LU2FQNHlqZEtNdG5EL0tadEZJZFFFcThzc3FU?=
 =?utf-8?B?S1Uvd2ZFRzd6TFpuTGw0STFkbmJnQTIzZm9lWUhlQU1aaUt2SlFOUnNOalB4?=
 =?utf-8?B?WnpCUksxeGdlcC9zRlRHalNKdjEva1huRzJIYVRBZE5pL2NIVGJOMFRsOTBI?=
 =?utf-8?B?Mzh5MDFnSlRVTmo0WWllbGlvallmRXBPallUNFM5Q2xMS01MdTJrMHh5MldF?=
 =?utf-8?B?SllQN2Z0Rm9ONDFFdTdXZDNhZlIrNGJSU3FkOUVpcjEyQkpYYWFjTjhrYWVZ?=
 =?utf-8?B?WjIzNUlsL1RHNlMxVkZSdTIvWGdodmdPampvTCs4ekdvV3lUOHFvYmdKWWRN?=
 =?utf-8?B?WkhnT3BiVWpnWnpTLzFOekVjbVdJSDR3RXdhaE1zR0lDcnJIYWZFZisrVUJF?=
 =?utf-8?B?WlU3UUE3SU9pV3ptcUwrVWlJbjdCL0xZMnNBUXhoMnB5SzkzNlFjOUN3bWNB?=
 =?utf-8?B?ejAzRWdxV254d3VoVXQrUmorUWdWLzJBd1JqcmxTeGcrWFpMck1UeDVKUnRn?=
 =?utf-8?B?YW9TZWhwZGpsZG0ySkZ3OUhwemljQ2FMV0p3bFROeTVNcDZ3MElsYnZkUkU1?=
 =?utf-8?B?SGVBbndiejhMdllSMkZwZldqcDlIWWtkRHRlTk5EY0Evc0paZDhuVDZNWXRJ?=
 =?utf-8?B?emtEL2laL2NuLzJRSVlFdStyT1J3bHhVek1lcFJwWTllVmlxYlpPeTZBUm03?=
 =?utf-8?Q?yOtgYGP+EhbYauk5wSqb+a0oYOi6oKb7tgMwGVmENxE0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43DB66D2EFBC4A46979C677D972DBE80@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e66aec9-5039-410d-6664-08de16b239d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 06:13:06.3560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BS5BR9WlliQP+H9CrvIa+I/XJcy41ipEfKoi+jVtFvUbln1eddlajQ5p9sLay3a45/mL8qtXj43k06bra1bJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613

T24gMTAvMjgvMjUgMjI6NTgsIFJhbmR5IER1bmxhcCB3cm90ZToNCj4gTW9zdCBvZiBzdHJ1Y3Qg
YmxrX3N0YXRfY2FsbGJhY2sgZG9jdW1lbnRhdGlvbiBpcyBhbHJlYWR5IGluIGtlcm5lbC1kb2MN
Cj4gZm9ybWF0LiBDb252ZXJ0IHRoZSByZW1haW5pbmcgc3RydWN0IG1lbWJlcnMgdG8ga2VybmVs
LWRvYyB0byBhdm9pZA0KPiBrZXJuZWwtZG9jIHdhcm5pbmdzOg0KPg0KPiBXYXJuaW5nOiBibG9j
ay9ibGstc3RhdC5oOjYyIHN0cnVjdCBtZW1iZXIgJ2xpc3QnIG5vdCBkZXNjcmliZWQNCj4gICBp
biAnYmxrX3N0YXRfY2FsbGJhY2snDQo+IFdhcm5pbmc6IGJsb2NrL2Jsay1zdGF0Lmg6NjIgc3Ry
dWN0IG1lbWJlciAndGltZXJfZm4nIG5vdCBkZXNjcmliZWQNCj4gICBpbiAnYmxrX3N0YXRfY2Fs
bGJhY2snDQo+IFdhcm5pbmc6IGJsb2NrL2Jsay1zdGF0Lmg6NjIgc3RydWN0IG1lbWJlciAncmN1
JyBub3QgZGVzY3JpYmVkDQo+ICAgaW4gJ2Jsa19zdGF0X2NhbGxiYWNrJw0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBSYW5keSBEdW5sYXA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KDQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=
