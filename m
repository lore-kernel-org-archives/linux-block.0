Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F225761FC4
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816158; cv=fail; b=KO3Scm671r4EvLiHHl+KHBusTJO8NfAVyqKfnjUT4A6NhqxtiWF0dBWHX8Us/o+BNhjY7U9hmDgrGhO9UHZw3UEk5L7WUSUHGLBobCDWYYA5dUTI4Vo5ZNwoIktbdufWDnTqppF90J1mDJWEarwF9n0v+rNzY5W17c9mcmItK70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816158; c=relaxed/simple;
	bh=Pg+hz9ufpVt+7VYK7uUgT2EeoWbh3O3qR9RFPtaGh8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jUXw1a6ZcDIQaK7lwN1L0dbSYymd1VgeQ68Mag1OuzsVg0NjhW7SnHmjkXrh71PfPIxQ79IcaWGt5cgDtv8EnAPYTtNyguBCIZgi19Zp8QxqcVhiSjB3rrLHERYFQ3/TdnojsCBJkOv5pmpEekxYpw8cs/QKjW+vBNphNltCMl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FFH8AyLw; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FFH8AyLw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlZqaPcHwjzVTkQOd7Tonyuz9IwODUcs0fDDHhjNevJIb6EWZf5cKSNRQKeKzfpdyJupaYhn8R/LlIHEEIGkjpziz7VVtQDT9puPFcW8oUrC+jgtFtG/SnYwGXQ2OtrYtfNh0BMhzsnEGX2Lf9sAsEAIcI2n1M5WeDfsfqAvAZ0LhGeIJDp1vE/tTeO8vUkXZHMkLmS852OxwOibsOcCr46nAL67lS05XLSGID2TnBx1IaEmmBiFvh0ImlKUngc88QfvJ8axu5aIwkn79VAfpz9cUn80p0ZL8FuEoU7H0Ist5p6AQGOOWUylzPRiKJZV3L5uLVLf0J0kU7VaR+zhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg+hz9ufpVt+7VYK7uUgT2EeoWbh3O3qR9RFPtaGh8U=;
 b=MAXLe+g/FDN5DBbPKxb81l8thXwaXu7TdQOuOjZw5h6At+wuTPxpxY1Mrx6cJTRmMpG7e2kd5le2P7LDqkUpcvCrT/8BdSzaUhFnAmJMrKriXk0GPpTywxhkNNpcPmW3piC1J4g6GEb+osdxYcRJBZ7monuYwsw57u+kW5siR2sFT6B2QPoQ8RFGVxCDK5dT85OtbJn9Jj4RTHsEdNr1eZ6FPg5kExd4kSjEdycd72fGSwdmeT5YCs1oK8a5JYblGDrNlwKunxBNS+xjyh/k39a9XWMIMCakNLuWjmdbBAmvi3ESfdQoGtrAwQlTDM9vFt3Ng7QlbnKXaJiA6RoHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg+hz9ufpVt+7VYK7uUgT2EeoWbh3O3qR9RFPtaGh8U=;
 b=FFH8AyLwqz2FWUToH7KbmsN3a6Glvzm0H/Gos2CrSShoMGzLENrv2NcSOkmAqlZS//Mla2ik3GxuOlmv096YPPuaOk4gj2cKV8Wg50ZTkXMX4Wzy1Yz/UY4gTvAyB/AOQXIQT00p2ciosaxXqgOpOf3rAzq0emCVu7BpyisHwRwDwIJ7Y04yUDTgCZ8gyLAAWFqL2OIU4qwla0GVju/utKcCy/MLXv+0X9DOMS3mV+/XyWWwj4zHqLpnvRufz/0rftEM+oI/wQ2/qgN5OJRujpR9kWz5PmzSw1V2u2we6vTZmQsJ7iTf/RnBYWKO4ulH3h/bWl/sviCQGK2JBvUXZQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 06:42:31 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 06:42:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, "Martin
 K . Petersen" <martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/3] block: don't reduce max_sectors based on io_opt
Thread-Topic: [PATCH 2/3] block: don't reduce max_sectors based on io_opt
Thread-Index: AQHay3YWtb86eWa270KLzrmWqJdSurHhbMQA
Date: Mon, 1 Jul 2024 06:42:31 +0000
Message-ID: <aa27b8a0-89fb-4d81-85ce-ecd5287ef400@nvidia.com>
References: <20240701051800.1245240-1-hch@lst.de>
 <20240701051800.1245240-3-hch@lst.de>
In-Reply-To: <20240701051800.1245240-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH0PR12MB8579:EE_
x-ms-office365-filtering-correlation-id: 1eab6d2a-3043-46a9-9a54-08dc9998fb73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWVJUnF2MVpJVmRDN3hCTXgyUjArcWRwU3A4eHBBL0cyc2cwdmZRY2JEU1lI?=
 =?utf-8?B?OTUxWUkreFlPN2Z3SmR4WHNWczg0RTh3ZlJNRjZvWVBSNzhUbkxNZWlYR25X?=
 =?utf-8?B?Z01uNjBXUFdIc3JES3gzY1BIZXN6Q3pUOUFwcFlGWEh0cHhRVG5sc29IdTNC?=
 =?utf-8?B?cWRKVndMTE1WN05KZG9JdExXRUxqcWJEODhYemVvTlMzYzdlQ1NvZVl3QmEv?=
 =?utf-8?B?bkhSSUEyUlZWTVh3ZnBtcmtEbHdmMUIySDlEQXEreTFMbmJaTXdxTFpxSTM4?=
 =?utf-8?B?L2tkeTlDRS93VEpGOFRETWNSdExMOXBKa2NHb1RoN1lKb29ZdFR2Q1hXZW1P?=
 =?utf-8?B?b01Ia05pNHd4YkZMd3E1ZzdSR3Z5Y05hRi9QcmszdlE0bEdDWktZeEtoVWhj?=
 =?utf-8?B?M1MyRFRibWFJRjRIa0VNdCtKNytpSVFkWmluN3dUYytvcU1sZzFIaVRSR3h3?=
 =?utf-8?B?aUxMQ2M5YWd1L1g1bXdVNnJQbktzWVVMYXJPN1J4VXMvRG4yYkc0eU1zdnZm?=
 =?utf-8?B?WXI0RmhJOEZDdGNMT2dKcmtpU2ZGdktLemFQSHJWRzVldVl5Z2U5eGR2Ym40?=
 =?utf-8?B?V3V0R3JTSk5FQ0FuNFgxSUt1dmpVVVE4R29KZnZVcHFhSXFKOHh1RW5FUGU5?=
 =?utf-8?B?UjBQdFFWUWc4b1ZPNHRYM3NkZHA2OFU2RTA2Wjh0dnFZbFRmMU9wNWlTRGtD?=
 =?utf-8?B?S3MvUnIrZDJ5c0l5YjdIRENPTmZvQUdvZkY0V3U4NzFrcFEvSDBhR2hveE5Y?=
 =?utf-8?B?a0lmZjY0aG5lbmdCWGFBQnhKdWJEYUIxZkJYWm4welhTZVluMHZPVGdNaXlo?=
 =?utf-8?B?SThvOHlwTENLTXVGSHdVbnJoV1BDakpQeUNWTXNZa29Oc3Zodm8rMytpVlVm?=
 =?utf-8?B?ek4vcFhyTjFFOHJVZW9jT0E2UjhWVWdsVzBJL0xWeGV3RmIvR0xvdUhYNXFz?=
 =?utf-8?B?NXh6ZW9iclJWelZvTG45ckFnVFRpWGY5NnZTa1FLejJGVjdqanRZTVZHd3FJ?=
 =?utf-8?B?VW40VndRcEFkWEpEdzNaVmhYRnpRVVRGYytPMFhiSlNUVTh0bWhGdGN4VVhp?=
 =?utf-8?B?SVB3UFJhZENRL0VjRHNjL3RDZGpFZkg2YTY1dkpnY0ZrR1V2Q24vWElyT0Jl?=
 =?utf-8?B?WmZSVUNEUDE3R3lRVXR4UllkUVZ6UStsdDZYc0s5L1VNUm55NGJGRytabkV3?=
 =?utf-8?B?T2N6bnl5TFVzbEMyR3U0Vk9Ta1ZtdThxOGQ1RU1vakRyWWpRZFVnNXpoOEhN?=
 =?utf-8?B?OFpHVTJqOVc1THoyRGYrVCtVaWlWcGRaWkJxRVVvMlluYThiTis4WlpHbXpo?=
 =?utf-8?B?Z1dsN29CQzhUdUQ3N1BSdHJUYzN5aTUvb2NpTkIzbzRtTzFxak4wSVp4Rkt0?=
 =?utf-8?B?ZGJ0aXVEVXBPR09jY0wyV3ozM2x2SFVyajZnMGtUTFZFZmwrNlUvM1RHQ3Nv?=
 =?utf-8?B?S2xzREU1eHR6ZXgySDZ3NDhOMDlXcko1WEtPMjJydjVvZVA3Z0diMmRtNElp?=
 =?utf-8?B?bmd4YnZEWTA1aVlTZThPSi83RFBZSm8rTlUyK0xkeGtYWUcyK1VWRjIvOTdU?=
 =?utf-8?B?YUJTa3JmejF2cUZBeFNmRlpmWkxWZi9oaUpxbGNiVE83a0pQdlpHdm5NVHV1?=
 =?utf-8?B?WHk3Q3VGMVVnTm04RU5wbWVQNS9jR0lXa2lVOG1rbUZNcEcwNjMyQWdFSWxK?=
 =?utf-8?B?RFV0NklPa01tUW9YY1huc3ZybElQSVBFMjRjT0h3cjhWbzdKM29ORGl3OEY5?=
 =?utf-8?B?R2RjY0Q1ZDBaMy9OWjlsUWllOG5mTm5FZ2owdVhkV2gwOEkrNG5UelhScVZO?=
 =?utf-8?B?dlExcGRjUkdrdEd5NjNkSmdjOEFSMlp6K3M0Vi9sb1NoTTVUa05jTGRNclZX?=
 =?utf-8?B?bGxsSDJyRXBUaklnck41OFVMejkyYTduRW11cEFXY01QWWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rm52bVA3dW9zLzZoRS93T3grNWVMblJ6QWx0OWRKc2RUTzlSNnVmdlYrQ043?=
 =?utf-8?B?UVVWQXNLV2tuUXdkS3RiTnA5Y204ZzdmcjdnUkdNZXdCNXdFUC9rcUFBOSti?=
 =?utf-8?B?emdyTHlDczJPYk14bjlRQXQ3ekV0K2RsWWFQVWkrUHBYUG14aE9WbFQyZGx1?=
 =?utf-8?B?SjRESWVISjUyQWZpaGd4dWpyL2MyU0RUMmY4ZEFIdXpKUng5dmRJVHJhS2lZ?=
 =?utf-8?B?ZlhweVl0ZEVnOXJiYmJ3RGpTa1BoMExFdVdUWFBMNkRQVkwwc2VMbG1jeXRl?=
 =?utf-8?B?MnFEYzVCMTM5cmZlRXlrUmZ4QnlRYWducVhaZHhqcFhJVnNWYW5rMFFFaVVI?=
 =?utf-8?B?RDZNTityc3N1UG4ydmFhYnhaQnBhZHZJVmVTNC9hb0pkekk1L3pvRjZkV1Jk?=
 =?utf-8?B?YVM2ZVBnQ08zMnh5VHlCc3J2Q1BXMXo0bFU3SDVFV1hIT25RYnBRRzNZcHNT?=
 =?utf-8?B?TmYvZm1Bd1oyanhsNTd3Q3g2WDlzNHRIQmVvNXhSOFJlR0ozckVvcjJtNXB5?=
 =?utf-8?B?S3lsNWthalVXSm1JdjlHZWVtdFdDbUhDQzJFZTVtaWhmR1E0MXVRN2hMVnd3?=
 =?utf-8?B?QUFxZEE0bGc2aHNVUkRSTW03YTd1bi9RaGJmTU8zWm95K0VaaFNvZ2xoeXVD?=
 =?utf-8?B?a3RzQURYYzA4ODBxaWRzNkZtNmhxVFpUMlkxYWtsTkVsREFQanlwQVl5NUVF?=
 =?utf-8?B?ZEVSMHdIcHU0UW5KMmtMSkNPZlhEZVk0dkRuZGI3VnI3TlpTU0tWZ3ZNTFI4?=
 =?utf-8?B?ZXo1OUJ2NzVxRWorcllxQjkrQ2w0KzFIZlF0cFlaZ21zbGNOeUFlZmcyMVZ1?=
 =?utf-8?B?bWdSVHBKNXNNV0dYaEFadXh4bUhzVzEwVWN6L00yMjMvclNQZXdUdUFXd2d5?=
 =?utf-8?B?NHNpMjVJMTFFZFVINGw3UXNFbnNsSEpETXRiUjBhNDgrbVIydUk0NU8rYmhN?=
 =?utf-8?B?TGtINjJ6NnI4bldDY3JydWx4QVFzaHpEakh5VDVWTlNtQU9oeFVrcjlZKzc3?=
 =?utf-8?B?cEhkK0trZVJqbHNWWXJtTnRwQlZndnA1MDVRV0dLMW0rR2hYdnlMdE16NXMw?=
 =?utf-8?B?amVjcFFEWW9QTk54eFV5L0h1T0JjcGZWSGJ1aGVxeFdGbTdKTEZHRWtMcTZu?=
 =?utf-8?B?ZDQxb1BYRGsxVzJJWFF0QzBMMExXU1RQTnpscHdrT0xCRTE3ZERiUThrYmR4?=
 =?utf-8?B?cmpydjN1K202TjVFWm8rS0NxbnZzcmczLzBMU00zcmhqeDMyaTRvMUlFcGhx?=
 =?utf-8?B?K0EvUEpQQTRHOVM0T3MrSGJSZHVsUUxZSEtVNFAwdWlndzRsWEo0MHptRzdo?=
 =?utf-8?B?NlpqMSs4ZndBMVl0Q1cyd0dFOGFyRk9NQjlzcFlQRGVjTDVXRWE3VmdhTFhV?=
 =?utf-8?B?ejZOd2h2N3p5ODZ0WWlXcUY5YThIWEg5a0M2SEZjTjUrbS9UMzg1OGd0T0RE?=
 =?utf-8?B?dW0zYlIzcnl2bWFrMm5Nd2o5RzlRSnVESTJhQ01PanRBTVd2Rm5RUkZLQXF3?=
 =?utf-8?B?dHRMbGlqK0tMZHAyU1VNbDdFVHN2YTdHR3RFdlJHSm5sc3h5ZEpYUTlNdHFH?=
 =?utf-8?B?b1B3Zk1LenJsZ09zcy9pWk5sUWErK2ZOR0RTWS9ydHlrTEYvQUVlUmFjbkl2?=
 =?utf-8?B?dlQvWTBPQi9KY09weUJ4YVZHejZMVWV1MnBoOElTQlBwSTk1SUxJcHhGeWpk?=
 =?utf-8?B?ZGxtUFZzT0JrOEczejRlNHBGSnBwQ2JGVU04d0JycFZ6SFhCdnRSN1RxYUFr?=
 =?utf-8?B?d2h4ZmthVWNyb28wSlFNd1RNeVh1Z3F5YS9ZNWY3MUY5MW9hMUFTNzNkZ2hr?=
 =?utf-8?B?Uk1rNVdyM28yY2hNd2U4QVR6ZWY2SzVxWktheUl1d0FlOEY2bzJBY3JhNFNN?=
 =?utf-8?B?TnVyRStiR0VKcVNhS1QxZ1MrMUFnZkRyS3lBV0lkUjFaekxjZmZ3TlcxdHdS?=
 =?utf-8?B?Vzc5TzQ5UEZDcUFaZzNsVldSSmJTUHZjcXhRQzRveHVxazlnWFpkelUzTXVh?=
 =?utf-8?B?cVBJbTUzYWE4enRtTkhwTTFINXF5aFNoTGZmYlZndi9TK1ZBNU9lOGZtZldH?=
 =?utf-8?B?cWFMSkJkUUhCNGlsa1FuaFpwdXc5cElpeUxZd0tPME5hRVlKRHVid01MNENU?=
 =?utf-8?B?VUpyMXNOeDFXc3B4MEh6bGJ1YUdOY1NZbEZHMTFWSWdpSmZJczdOcCtpTFFK?=
 =?utf-8?Q?q1Uc4bUO/rU1jOq4CzvuziLO29H3Y/8tyUHxr/CvHaoz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <582FD5DB99D2DD47AF2A0121698C8CE6@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eab6d2a-3043-46a9-9a54-08dc9998fb73
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 06:42:31.2319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDcvNQVtYPksQM46erz+iG8iSOBqPe0zCsPItglDrcVT2L8Wy0aOiTUbeNCX0wC7HJ5WVfzFxIBv/bEcfaq8+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579

T24gNi8zMC8yNCAyMjoxNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IERvbid0IHJlZHVj
ZSB0aGUgbWF4X3NlY3RvcnMgdmFsdWUgYmVsb3cgdGhlIG5vcm1hbCBjYXAgd2hlbiB0aGUgZHJp
dmVyDQo+IGFkdmVydHNpemVzIGEgdmVyeSBsb3cgaW9fb3B0LiAgVGhpcyByZXN0b3JlcyB0aGUg
YmVoYXZpb3Igd2UgaGFkIGJlZm9yZQ0KPiB0aGUgcmVjZW50IGNoYW5nZXMgdG8gdGhlIG1heF9z
ZWN0b3JzIGNhbGN1bGF0aW9uLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdp
ZzxoY2hAbHN0LmRlPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
