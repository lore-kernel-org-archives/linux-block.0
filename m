Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B223BE;
	Tue, 18 Jun 2024 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670542; cv=fail; b=JGu+lnOk/HT2lzUK0kascBIR0I2Obj7wzrcYBlV9ZT+cR5lvBeS4j1zAJjeugyo6ie/VATHXjbJQry65FxHHyUZTpB8reby9hMGfcLp9uWUH4vvzkiMMZS7EM9lhtSl/mmOI2QEvirp4AGhm041+ufVxGeFwBfcRcjNn5gACXlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670542; c=relaxed/simple;
	bh=P8KXEESJCGTj4L7lUDepuVQtZsmUjxE7VQqjtJ02/b0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGAu1IHDrIX+de+d7DvWw+FR8qC5+9BgWJCvM/CaPRD/BtF4cfIrxzGLBWiDoV1Kpipw3hLDs/Grjv/Z/dt58kDgdGyKZ/3mhoaI96JJ8q5uYXWEmIUd128s2ic6g5Swjbys3EDK8dZIMUtlGj149fXoaRY97i2KTpVNObvjAWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GokL/YQE; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GokL/YQE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8hqKgEyfHsmoBOvWkIT2JpAfMpv7FV9azB3QVjWo4+E9chxfKQJ761OPSGN/s3eEx+vcTN0R5DDT9SZ8je7im3lTdoqNkQgRcyyJ6rNhmrfm2ehMjZ8RIBGyAKiDHE/7b3oEGt9INQ60rrN86kvKCvJQXGIm1l46hovvkW7g4VL2IhoZS+pRCuFZZCWO/oiFWA3ae4Z5itGlYhiWWN7pb9gu5t6V/qbmoTqBfpPjbtbOs2PlUOBWlqxWh2NORcT/mDjuDUhEdq5Y8v5wzCFBfPxZkv+hh5fRF5FJkaEJS8wI8YDT9h9Kbjp3OoSI9D6dGDGDfgJUq4FcKLaWStfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8KXEESJCGTj4L7lUDepuVQtZsmUjxE7VQqjtJ02/b0=;
 b=AmTBRWLYRbLw6kd66NyrDnuiEuc8c24rsBZYyQnh6c7gTST0GShBuezqtOggaHrpbOHGBxKtpIXejLaNhlw7gKk0JFzjsP6MKr1wriZhyY45t7bFKgQQV7dM95TlDn8vxhV4ex+ua7tOqaDXZ9/3MO3ccLK8bJPY6xxRYmA2tm3fK0TvnJSlG25+y7ZjNmbw30hhfYy/9hf0At6mylydwHkl1wXj8dW/hSk4q7ZMSKDnoIDAd83tiwoC2OY+x7P5+S8PPpKM+C0XiTDorV1Jb8YyrpNl7vuEjQjjeeg7SALZHGZajXHHdLrF04iL+QjcfasULr6bTojATYFBrXPMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8KXEESJCGTj4L7lUDepuVQtZsmUjxE7VQqjtJ02/b0=;
 b=GokL/YQEBnysxM8PSupQtVm4YevVusdqMWIPE0jcjTnoUuAwnpKlKoWwmrezLCTkbgGqOBpqAS0/e1OjLEjWDy2JlL97sCUINX25FEqpeeL5yyMW7bolZTWdEHrpzHgva04kWci22hBztCowGM6m5kUuHrk4m1A/l/JzOE+pYrFe+Sif4wcxCmIBKqGPRbr8rVc3dks/VCXa8ePf7x18ZvOc+LhSoQututfXSOjtAOsMawwgOrVdj4tXHOFfGenAV4HQ7wLYEPAkzB9MiacA0mLKM1iKwGT1S5ggLkaPp+UsIs89n4FOx8s2kJ6zXRbiYYEzBIJocWLPBtdxeKtE0Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 00:28:57 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 00:28:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Dongliang Cui <dongliang.cui@unisoc.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "ebiggers@kernel.org"
	<ebiggers@kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>
CC: "ke.wang@unisoc.com" <ke.wang@unisoc.com>, "hongyu.jin.cn@gmail.com"
	<hongyu.jin.cn@gmail.com>, "niuzhiguo84@gmail.com" <niuzhiguo84@gmail.com>,
	"hao_hao.wang@unisoc.com" <hao_hao.wang@unisoc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akailash@google.com" <akailash@google.com>, "cuidongliang390@gmail.com"
	<cuidongliang390@gmail.com>
Subject: Re: [PATCH v5] block: Add ioprio to block_rq tracepoint
Thread-Topic: [PATCH v5] block: Add ioprio to block_rq tracepoint
Thread-Index: AQHavi+B6LwuAL2lA0e+D8s2NJ92CrHMsKMA
Date: Tue, 18 Jun 2024 00:28:57 +0000
Message-ID: <43b022e5-18ba-4f03-907b-4bf148fa102c@nvidia.com>
References: <20240614074936.113659-1-dongliang.cui@unisoc.com>
In-Reply-To: <20240614074936.113659-1-dongliang.cui@unisoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB5604:EE_
x-ms-office365-filtering-correlation-id: 80284ce9-5148-4dec-731e-08dc8f2da49b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?aXJ1bGN6K005bklpTjdXcC9JS0JuUTdTS1FiSTF3Rm9aQlBQK1JTYXpyV0dy?=
 =?utf-8?B?UWJrbGhMeUl0Q0xjZE9zZmczRzEydjhaMWgzcFRKbE5sSDZVamQyM1QyZ09t?=
 =?utf-8?B?V0RxSVNCZ2xRcnRUTzgrNTJPdWo3dlNVY0ZYb0Nkd2pacWZ4MVAvTE9VclRJ?=
 =?utf-8?B?UjA4UDNJWjZvdW92Z1ZmMytQT1pKREticWFtajhLb09QbUdFSysyekh5Rm1p?=
 =?utf-8?B?NzNabXVIcHVzVmJtR2NMWFQ0amljL3JQaUlyVUlDVXIrbStDaTE1UCtPYzRG?=
 =?utf-8?B?c3JyVGR1dEpBY3h6SzQ1V0hNVXlXeUZOaXM4Mm4yRXVESGR1eEY1b3lWZTFr?=
 =?utf-8?B?bU5EQmh6dWZIeWlYU0JUWGk0bklNeHhyenpDUWlUekp3bFByN0U3UUgvWFYx?=
 =?utf-8?B?ZEs4UU1CZGtSVk9vQjVZOFlsdXVsZnBUL01rNDlMNmlMczVQK2lHSjM0UnIy?=
 =?utf-8?B?dkMreUIrV280VnlMV2VpVVJzQVRvS1ROdi9ocjNJYkVDSkErcWlRdXl0UjdN?=
 =?utf-8?B?cUgxWDVmQ1k2dGU4TnlmdjFxUXNjV3h1ZDFIUytDci96ZXowamhQV1czNzNq?=
 =?utf-8?B?UnNYcC96Sm1TL1l2UjNWZDlVeFRZQTlCLzQ4aVVTYlhCMjVXTW5SR2xwU0F3?=
 =?utf-8?B?RXZRZXRRT2UrZ3lITXJUMXdlYmY0RFVzcjNQK29YNml2cG5GdHA2TXBrZkpq?=
 =?utf-8?B?R2w2UzFlQWNwYURqNm9BWGRPQnBCZ0RvdFF1WDNZYURTNTVwK0tPUG9hVCtC?=
 =?utf-8?B?UEMybTJac3YwYXVPeWRja1FXME13NHYzZTgxcGlISW5wTnEvdlFXQUd2TnJM?=
 =?utf-8?B?RTk0clF2MWM1T2RBUVdFT2Z5a0lHekZ2V0hnQ0Y5RFBiVGxvQktzNFV6QjVQ?=
 =?utf-8?B?YWxPYnFmRk1sVHRMVUMzd0lGWDUvYWdnbVM0eHBHd0xyWXpyY3FacGFXeGxH?=
 =?utf-8?B?dWEyR2U4QUFxRXdpenVBd2JLL1Z3Tzl0dGFuc21HUGN3N1g5STJ4MzQxVk9Z?=
 =?utf-8?B?SVlQMTJoTEdyR2lab0hwMGlyTVNWaXl1Q0FSZVRzRmZPaS9SbWdQSFJQWURs?=
 =?utf-8?B?ZWdVWXZ5azRRREhXYTZUamlrcUdxdS9Cd1VCVkpQblRjUFd5d2xJNFBqdjQv?=
 =?utf-8?B?OUE3M1lDQXF1NmU1SFZZdVVQR1g2OXowZHRBOUV1ei8yK2REOGI2Uk5IY0cv?=
 =?utf-8?B?YXp4TmxGc2hLSWhzdkVSY0dQN2FyY0xHRWZZQjZwMWNIWEZvVVVQQzZlOW1G?=
 =?utf-8?B?d1hEb212V2lGZ05walRKWlBoUTB4YlVmMUdCSVZaVTdnbXdGdytlbzBhNnNL?=
 =?utf-8?B?L015WUt1dTNKUlc2RjR1bHBVU1BBRElLekFmUUZGVm95VEtJdytYaU9QVG5m?=
 =?utf-8?B?bzQ2ZGs3cHpsQlltRGtkWEtGNDd6ei8xd1N5cWpDRkhsUGxQQnhBWURTM1E4?=
 =?utf-8?B?RFprajE5YUIvaEpQM1pzb3BHOSt6Q0RtN0lvVERHK05IN0ZRaDFkMG1rbFUy?=
 =?utf-8?B?cGE3V2pVWUlMYlA1QUJMRkY1Y0U0NktRcUVTWUdFU2NRWUo2a29zcUlFUlhs?=
 =?utf-8?B?eVIwMVh2UnhtZlJsZHJBeEFnQWs5M241Z3FUbE13cWY0RXRUR1B5Z2Y5WVZM?=
 =?utf-8?B?cnp6N1Q4SVRhZ3YzY083SzZwNk1ZZnU2MWJNOEtEejNHall6SEpDb2RtWjlW?=
 =?utf-8?B?ZkVRU3NLeWVRQlJQV2c5RGN6OWxXWGZTOUROZldnWE5BZUhJbFBwOEF4LzNH?=
 =?utf-8?B?OFYzRXNjQitPRHIyUU1VNlRpSU84RmozL0hNc2xaUkFCVmFvNTlPUXdUNlFv?=
 =?utf-8?Q?CXm8yae4VDWFCf4LcBXCUV7GaFLGgcbtufe/c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGpObFB3RnhLSXZMVllPWG1MUFpSQTBYcXBvalNZTEVJYlZoVStNVk5wakdB?=
 =?utf-8?B?TGtPRzdVZUw5SXkyV3d1RjlsY1RuUmJYWnpHQjJWM3F1N1BhdWU4Z2FVa1NN?=
 =?utf-8?B?WkxoMlpCbVpTMWNsUnBuYlZMMWpBWDlkeDRVM1E1T1BTMW05VzdEa0NCeWxB?=
 =?utf-8?B?RE5PSWJMcEtiWk5FRjVqbHdEdGduM3VBN0Vld3B1UVBNZEFJb2RzaXFibG02?=
 =?utf-8?B?YnV3OTUzb1NHTGt5VGVkNWxQZmlqYnU4eVp1SzlpbHk2dkY0RFVCK2t1UGZy?=
 =?utf-8?B?a0kybGtLK216ekRTM3RTSUhXWk9HN2VOSUQ1OWZ6KzN6WnVaVzZ0emZOamU0?=
 =?utf-8?B?b05OT2RBNlhnL0ZsTnU1a054NXB5N3MxbmtLMkEvekRpcEtEL1RZVWlidnh2?=
 =?utf-8?B?SmNkVmgyOXI0ajZxSnExRUJuWk9Xd21VMDJENTNzbnNZRHBSc0c5Sysxb2Ni?=
 =?utf-8?B?aHFURkppVmNKNXRzVlRIWFc5ZGdJZ3JNaGxwL0tHUC9PaTN3MitjTHI0Ykxv?=
 =?utf-8?B?ZnFmM1FRVVh5TE4yYS8xQlpxbmpkNTYrRUxJSTg4ekpuZ3N1bFcwaFVieVo4?=
 =?utf-8?B?OEZpSnU5dVV0NkNxVXJpTGRJa1U4VUh0K0QzNjZXYnlwK25UTCtoWi9Ycmkw?=
 =?utf-8?B?WTlhaFcxUTdDRVphSTZCNUE5cm8vcWZyUjFoampJMlZRVUtzaWMwNHo4S3Rn?=
 =?utf-8?B?UlhuVGJuUG5Uc2xkM1BRbmxOS1ErUWpmY0JIVWFEMVBuZmw5emRlTThncDNW?=
 =?utf-8?B?NHFjdlJKSnc4K21ZamFNanBTZkZrcWlaOG1DdXA0d3l5TFAxMDgrRmM4YUxa?=
 =?utf-8?B?aS9TVEtNV0VEY3oyU0QxMm9icXVjUXRiaCt6WFBRTGxxQy9YeUhXeDJ3SEpN?=
 =?utf-8?B?YjYwNUllMHFiTThWd3E1VmRpR0JnTXpTM2hpcFl6ZDMvbTdOZlJPNHZhOG1S?=
 =?utf-8?B?ckRUMDdTNDZpeWJINVZQUWdQSlorVzVNbStZdHJ1OTNWSDUvSmVKZngyZ0xU?=
 =?utf-8?B?RFdVL3ZxZHVuNXdVZWtXbzJvMm5MY2VkV3d4dHlFYVBKYlBpTjUvUk8wanJ1?=
 =?utf-8?B?MjF1UEVqd1hmS3A1SHY4YUcyRXl0d0R6Y0VmelRrVHFCcWg0YVUxSmt4eWgv?=
 =?utf-8?B?bWd4Z3JpcGh5S25QLytXYUJIaFk3REZ0U1FNZWtTVUlMbXFZdEYzSnUvWVhr?=
 =?utf-8?B?ajFpa1c4T3c3aDBMY0hNVWNubktlVi9CWnlLTVpNL1prZ0xKbE5PWkdqT1hC?=
 =?utf-8?B?emx4WWQyWkNsS3hVZEc4SnoyNVdadmdkTVh2VlJLa1NkdnhERHNMMVZCdzRB?=
 =?utf-8?B?R0JXSllVVGNKdldyRWRaY0V0amhSaTk5MThWT1ZHd1FBWHlOQ3FYZHMwOU5C?=
 =?utf-8?B?U3hHckxhc2lBZ0JQRGxVOWtTa3dyaG9uYnV6SlIvVjVtTEZWdU1ZSStTYlRO?=
 =?utf-8?B?SmowMm9ac0tmdU1COWJqMm9iNTNwRWVLZE5EdzZZNEFEZWNURlFacVc1WW4y?=
 =?utf-8?B?a0tHM2QvWmhvM1JRNFJ3M1FPT3BmMXZKb2ZBaVhwQnVha2NmWjluZkZPMkpx?=
 =?utf-8?B?eEk4TlA3MWM2TVBDUHVNT3NTbG4wdTN4aEFWbGZHcHgrV2kxUTlVQ2s2U2FT?=
 =?utf-8?B?Z3hhN292OWxCc0Q4YXZ4Yk1zYzhjcTUrRVlCK3RZckdBVGNvckdXUDVBcFpx?=
 =?utf-8?B?Szh3a3JVRnhYSXQwK1NGSlFXT0hUZkpEU1kxZS9JOFFSRkxzVnJVbzIrNml1?=
 =?utf-8?B?RFFNaGllK2ZiU2NDZDRkbG8xbnM2ZHVqeFgrRCtabUN4Qlp3ZE1lR1dsNFd3?=
 =?utf-8?B?a1pCejRwUk11Nzd0UFdNTmdiVTlsMGxvTDJ2eDBWNnF5a1Y3Y3A4VDMzY0pN?=
 =?utf-8?B?bVBTZGE0TE95YS9FTEZRb0VscENUUENGRVFkUE84RGdzbEtpb3JKeS9zdWtp?=
 =?utf-8?B?cVpWQmRZM2k4YzRKU25RYU9MZEtOZWZ4d0JnaHRobnlzV3lBNUhidE54dzV5?=
 =?utf-8?B?L2s4dnRTdGw3R2x2NmVLZzV6cGJBNWplRTQ5V1V4NnI4cG5QRnlWM09ld3dh?=
 =?utf-8?B?c2tPTXNSSEV2T1N0VnFjcENiWjlxTzUvcE9vcUhuTlViYXFZQTcyYXNMZEla?=
 =?utf-8?B?RmJScWMwazlLOFl0a3I3NWR2ck5YVWRZNTBOVUNPY2dBc3FVcFBhNGNNcENP?=
 =?utf-8?Q?a0y02rQr3E3tHdukYciyZXMQ8L8g1oBU/B11xK3bO678?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BDE7E57C909F3438CF61186C0B5E2AC@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 80284ce9-5148-4dec-731e-08dc8f2da49b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 00:28:57.7489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4juKNF/dGjrEpsCJHvl/fRY9iybDqrvqEntUunltP/3R2nH1ETloaNJoyNEJEkG1p5O0a5dOqaSa4tA7fPbFkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604

T24gNi8xNC8yNCAwMDo0OSwgRG9uZ2xpYW5nIEN1aSB3cm90ZToNCj4gU29tZXRpbWVzIHdlIG5l
ZWQgdG8gdHJhY2sgdGhlIHByb2Nlc3Npbmcgb3JkZXIgb2YgcmVxdWVzdHMgd2l0aA0KPiBpb3By
aW8gc2V0LiBTbyB0aGUgaW9wcmlvIG9mIHJlcXVlc3QgY2FuIGJlIHVzZWZ1bCBpbmZvcm1hdGlv
bi4NCj4NCj4gRXhhbXBsZe+8mg0KPg0KPiBibG9ja19ycV9pbnNlcnQ6IDgsMCBSQSAxNjM4NCAo
KSA2NTAwODQwICsgMzIgYmUsMCw2IFtiaW5kZXI6ODE1XzNdDQo+IGJsb2NrX3JxX2lzc3VlOiA4
LDAgUkEgMTYzODQgKCkgNjUwMDg0MCArIDMyIGJlLDAsNiBbYmluZGVyOjgxNV8zXQ0KPiBibG9j
a19ycV9jb21wbGV0ZTogOCwwIFJBICgpIDY1MDA4NDAgKyAzMiBiZSwwLDYgWzBdDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IERvbmdsaWFuZyBDdWk8ZG9uZ2xpYW5nLmN1aUB1bmlzb2MuY29tPg0KDQpM
b29rcyB1c2VmdWwgdG8gbWUuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
