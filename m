Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E331862A;
	Tue, 18 Nov 2025 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763430860; cv=fail; b=jTIwOUsobndwb+Zb1f41DpNrnT6Hml/PyyIPKZFgHg22wvCYTfenNb35I66oW5fZkuhKEOhf9L6wBsH5BkIlV7WbkOoWP+bKru1mFHxc8zwZME9RrdoQ3WOS9DeCn/WlJ4j0TmmD9YQfmZXHz5MQFpAw2XCfuktSWwzjIn5p3Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763430860; c=relaxed/simple;
	bh=RRPbcOg1nzWkvT+84SxnlUazF0DLMhgXZ/+E/olU8OA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=USKrbHXWEw0zoBPoa0YFSyxlu/EOjzvjDv5uOGPn48Dbv6ANcbzQ/Hd8aeVl8uyrUUUMlpkLqTNTEZwO1Vfze+CkgxC32DyDjkWC10+Pd5SA4E/FFcEfCiMmIj8U7cGPyjDnWAakPggjZYqy5OyY5a33zDDi+4YA7Loj547aMmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JdMpXIQD; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JdMpXIQD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trME0fsg2BY8SR3FVoEsb79QVjtwuIjjDSqOUvcPRs1OxxFMQCiUiVelOAUayrdBmHWFXsxLoP1G5c0qrQeG07uImnzBxrmFgofX03YrzAI2TFk6F3xn6IharzQpXhlaBkFRCWEFjE4fuLrjxbiWBSb3EODATp2NQq3RxpHkz1fD6l+usJFa1ZBtSn664zT2o/ykbEHdnKFmpGnlzo2JeZBfbv0HgWhlY89y1kZXhXjoGfGft2nPyTIwoaQxvqqxJH3DjjyawhVLokUfQ7NFy2BV+433/RJnzdBA5rX/C5+4ig7RaNt7ahalKyL4Aa1HmHoVhWtOSC6WEWXIMa+WOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRPbcOg1nzWkvT+84SxnlUazF0DLMhgXZ/+E/olU8OA=;
 b=bQVQCQQ4tH9u5WF3QMHGnDOnR9sCMc23dIN3T8wj48KmiZ+qQaJINZmRSQubbTY7z8REQElLSpIkg5X4Pn96+0bxliW35Nne1Fflo5XtU/LX8brZ4+/l4bcEBhv7gWeh1mxqngtKr0VSyOytqxR4F14fwco0NUn7H6lJr9+N/jpYgRG/vqpOo8hY+TmiknHvNvUbXuMAZxptB++e8irg0ZyP0OKTHep1/8Q7kd0GQN0NVK+3Qw1BOHILNx5rLgaGaFezoKAltim+X9wXLrfhvkMVC0rbYR/ym2TJCymlQMtQpqvUIfcqw+GS4bSulZNYMPkCVc9sBsUx+gBSqu8kiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRPbcOg1nzWkvT+84SxnlUazF0DLMhgXZ/+E/olU8OA=;
 b=JdMpXIQDznxOGbhkYsi0i3pJyMJyUh93O8JAD0LTmbhMzD6CIanRBp+DL2qlacqNTjidfFICj0W7R/BYxSO6eT8J3WJ2VnPaMPO7MVarcx9OCMi2FP8Yge4gWGBbB/xiSa3SLo8Ry0CndGs3MrDgXPKb8HYvUxY0GmMWB0FaEwscrZ0GWpaiPh/bhXiQVzQrUi2GsjWgoow8jg8E6VcaaXG9PL2Aer3Xsv1rhBpTqCLsIYCgc/4LI2YIHNbY6Rwk2cn+fkPmPz9ofjspaM5u34mOqdL3pf29yZkd7iPDx9qaHDYRzkwRsAy/HL7tvcLxUYlPy5MuCYsWJN/liNY3XQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 01:54:16 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 01:54:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: chengkaitao <pilgrimtao@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chengkaitao
	<chengkaitao@kylinos.cn>
Subject: Re: [PATCH] block: remove the declaration of elevator_init_mq
 function
Thread-Topic: [PATCH] block: remove the declaration of elevator_init_mq
 function
Thread-Index: AQHcWCp0R6Gb47X1akKPB4N0NNQrA7T3rCYA
Date: Tue, 18 Nov 2025 01:54:15 +0000
Message-ID: <28bd70ee-a425-4d0f-9b19-b7a509c63db8@nvidia.com>
References: <20251118012644.61754-1-pilgrimtao@gmail.com>
In-Reply-To: <20251118012644.61754-1-pilgrimtao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB5669:EE_
x-ms-office365-filtering-correlation-id: d10a6812-1962-42d3-b2b5-08de264560d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVFNUVh0VlliMkM3anJDZStwRHdwM2M3WjYrL3BUZCtaeDh1enVYcEt3SlJl?=
 =?utf-8?B?dVduNDFiZTAyMFpjU0FUazBzdmNNNXlmbWJGN21rQ1hBcy9EeUY2WVlhRzNv?=
 =?utf-8?B?dXZBUXZaTXo5Qk5BVmVsMGg1UnEyQXQwM1lDYi9TLzNQR0puTGJ2SEJ3Ti9G?=
 =?utf-8?B?RkV0Ynh5cWV3dzg1ZXNBeUxlc3ZuU1ZVbWJlVXU2Z0tkVGJvY3NZa2xSUTE3?=
 =?utf-8?B?VHhJcnBOMXRHMTBCZ0NYOGNvRWdkSDI2NXZya01XZG1LOTAvbkFwSzhVSmhV?=
 =?utf-8?B?ZWUyQURhOVM0eG1Dc0VGZTU1ZUtQaHNWYVNTQ05HQmY2SzdmZTNmUmloblpH?=
 =?utf-8?B?cWlaR21wbjBsODB6dE9CcFB0Mlk4NlVGcjQzY2pleUJqditNUXhOYlcyQWJK?=
 =?utf-8?B?eEZQaFlRQ3MveWRJNFg0dEplSWJmMmZidjA0c1FIeHZzTFNKeCsrMDZyQkYv?=
 =?utf-8?B?RXFjcjU0bUJyYnlSTFlITnNNK0JJWE9OMWU1VGRINy9TeEhwSER1VmZnZTQ3?=
 =?utf-8?B?dkw3cUxxK25GYjVHQVI4K0lIMFREeGlqN0hFTTNCdlh2M3JKOUFNVXhjdUJ3?=
 =?utf-8?B?alFtQ3RDZFA5U3JVSnBCSWt1c2g2aWFabERaZllrOFdIMnU2QTBTcnBZOVVH?=
 =?utf-8?B?V1B6WmJRY2J3SUJuSmxZaFB1Z1g3U2RjbGJWZUhKM0pxSEljbnJYRHlKN3lL?=
 =?utf-8?B?bFVQbW5SSUk4M2pkS0tpd3E0bGVCNVRpa2RTeG5VUXVlOU80djUzMGpoWk1P?=
 =?utf-8?B?azVQUUs2NEZJa09KeWdMMUpzdDNGa1pRYVBKeFpIcWszWC8rYkp1S3MyT3VX?=
 =?utf-8?B?L1NIZGlRdEY0WllNdUc5OWZ0aHlOd3BtZGZVWW5GL0IvTC9HUitXTzVZSVRa?=
 =?utf-8?B?czhUUUpxa1BSQUI4ajIvV0VVblZ6K1lkdjNDbmRPZlJpNWE1aCt3cGlMUE1Z?=
 =?utf-8?B?NjZoYldYbUpxa21yWVNDQ1lwbFJ0Q0tvU0VhRUhldCtmZ1BydnpaTFpVNnFj?=
 =?utf-8?B?VjZid3p1L21DcFJSSjM0ekduS1VibGdIQmhkYUpJNFA5MXNGQ3crVklSSzdm?=
 =?utf-8?B?VjR0NkxVeXBXY3BFd0lnRDJIZERuL0dGQ0pSMGNZTE9ma0o5NTNjSVVzZmVj?=
 =?utf-8?B?WUdOTi9JdmtJSi9wYjFiVkJsNkVlS24rKzlDT1FQbkpTOG9meGZNRnM4SGsz?=
 =?utf-8?B?Vk96bTBDVTZXOTc3WkxRVWg5c3RraTN4N0tMMWprY2VMNXpYSHNJRVRCUi9y?=
 =?utf-8?B?WkVXY3p5V0RjSkN1czVnRTZ5bjZaSVh3cStISi93cm40MHV0SFVWZjBLeEE4?=
 =?utf-8?B?c3lCaDlpbVhwaDhBa1BMWEZQV2Jab1RPalo5Q0xyUmZGSkYrb2N6cjFOREFP?=
 =?utf-8?B?RTQ0S2JibnRjZ241Qno3TU8xVWxzelN0eGdVcXYyN3kvK1NIeHRFZ21QWndn?=
 =?utf-8?B?d204Ri9HV3MxcnlGZEdJOGZFaFVaWFdwMytmNUxxUm1XUG14TS9ZYjhCRHVy?=
 =?utf-8?B?cytBWExoTFJ2NXBaeUM2ajh6R0JyVndZZzEzYjBWakxiN2RTb1k4TkNUSlpn?=
 =?utf-8?B?dWpZcjBuNU1ZSDFOa1FvMERPbWxYUm5lRWFQakh1aUZIYVBQSW1WZW50blZ2?=
 =?utf-8?B?dmlBVm1kZndVclphOTVtT3kzSzhmaEJSQVRFckVSdUxjQjBTblpONW1rOEd0?=
 =?utf-8?B?YWRVaFFYYStoa2JkcE56MExRNmlBSTBKaVVUMjlEVHVVNU96dnVGSXZ6K1RE?=
 =?utf-8?B?R2FaZzQvM25ZbUxrZzRzNW5OSitGL0x4UFB0TTYzMEZLMWhFQlUxaldaZXJv?=
 =?utf-8?B?K2p6OXZMRDA1dU1aUVlqUDVrOGljaDJydVE5M3FRQ1lKRloxVGxVcy9FVWU5?=
 =?utf-8?B?OWl3V0NjSG14MjJ2eVlvOTZ0RG5rSHRsdll1dzRmQVo4Y0JsUThnd1Ztd0pD?=
 =?utf-8?B?d2lhK20rOWJ2TFhXa3ZZRW15NHhhd25oR1llL21QdnhRcHBvUFRGb0dTdTNR?=
 =?utf-8?B?bHV3Y3lqMHRmdEVNdE4zSVZYZEpEL2FFVksyRUxSQjVBREN6NVdKTEdqYmFn?=
 =?utf-8?Q?rH3phi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2kxbUdsajBJdnY4UGlhVGhLTjZ3S1FCTS8ya2NxZXl1UzdHcC9wdDBWeldO?=
 =?utf-8?B?eTRNUkNHZ1RZay9sZHpIdXVUNWp4ZG53cmlKNnJ5MHBya0JiLytjV3JyUyt1?=
 =?utf-8?B?bHMrOERMQTRNQ2taVElEYTNWRG5KaFBPZ29heFhoZVZ3b253SlF0bU1oMVZF?=
 =?utf-8?B?YnA3Umw4Vjlzb3lrRDlWT3ZhR3VsamxteHBSRGZ0SUVObWNPZy9LNVhCVERH?=
 =?utf-8?B?d3ExNjVRWmdBTXFxa1lQNVhsa0pSSTYwZjErMDFZcTlrZkdxMktZcWNxUE03?=
 =?utf-8?B?UGZDVm0yTFA2TzcyM25scVNVOTBQemZTa002a09tdlFZSzBFVU44bWNMdzhX?=
 =?utf-8?B?VHRuOTNzcmF6T2lMakZqa2NaL28raXJWeFBQLzUrd0xueGp6ZkwvcjlpbjZs?=
 =?utf-8?B?emYrNU5NbVRIK2NrYlVzQVR4WFozSi9nQXE1S3JtaHdjQ1JFWUxpSmRFYk0r?=
 =?utf-8?B?RFc3MWdvRU92eTN4T01Cc25PMEJYYkVTWlhIdDNzRE0xc0FKY21EbFJObVgx?=
 =?utf-8?B?dExST2VhM0U3b2VjL1cxK2lkeTliVjRMY1FDS3ZEVXFKbG1xY1Y4c2FhQUI3?=
 =?utf-8?B?OXpRK3VqUkpJbG9qdW5UZDJvMXFicWdUc2VrY1B1YVIwQUFiTDMwdUUyNSt2?=
 =?utf-8?B?SVdpaGRHRzRYSXB2Z1k5c1F4Ylo2Syt6SzNHQXVXNDg1ZktUY2NzUGc1N3NK?=
 =?utf-8?B?N2NBb2tCRXcvSEJkYytjcHlUa0dRU29CY0xBb21ReXhmbzlZdjk1TUJaZ1pE?=
 =?utf-8?B?NkdJcGlQM2F4OXdGcTFHOEdUUHQ1N0l1UkRLMnBobjhMU1puZmhYZzZKMk9E?=
 =?utf-8?B?aERQUmRDR1NiREJvM2dLTXN2bTBaSVRUYldNUjY1bjRNNjliZnRJN3JBZXlV?=
 =?utf-8?B?TnZWdnV3NkplTWlJaGZOQnNhU1lhRW4xZkM1MXRzYnZFZzdoZmZJTjRqY28y?=
 =?utf-8?B?WW1PYkFJWWoyZHRWZFY5M2JOWFNqNGtyNXErS1NhTlZEM1JkTEw5RW1SSTJT?=
 =?utf-8?B?N1FKV1VwQWY5ZEpBZ2ZHK1h5WGo3N1ZBTS8wZE83Mks4bGtweGdMWnZLNE80?=
 =?utf-8?B?SkQwTEMvSUk0cnZRdzJGRTh0TGFDV3J3SGxlQk53VG55L1R5Q0drWFJRVDR0?=
 =?utf-8?B?NmlkeFAyUXJ1OTVBNit4aitLamF0RDZRa2lPcW10djNDbzJwTHQ3WDUrempn?=
 =?utf-8?B?aENkaFp3cjNESGk1SXAzd2NkMVg0c2pGTEVKY0NwQWRPTnljcG8zQUZNWFo4?=
 =?utf-8?B?TC92blFzekFqN3JYdVRDb21XeG1lOGQwSDVQWUhrSTAwTEFCRGtLbVhqb3BM?=
 =?utf-8?B?TGVRNHc2eXdDNk9ZZFptWVo3QmFmNVFJb3RWak5KSkF3a01CVXBEcDlWL3Y1?=
 =?utf-8?B?a1V0VGVaODVXKy9iaHlMbzQ5VmE3cUtxRC9CbHdSbFpKVHg1TDVNRjg3azZr?=
 =?utf-8?B?bmNRK2VaSTlDaUVIMzNEc2lEZjB3Y1hDdHBTa29HTE9QdmZlR1BLNzdQNGdq?=
 =?utf-8?B?Zjh0KzAra0oxWExoMzJWSXhVdk4rWElmYVo0QUxnanJuQ1VmSUNQZVdiejZ4?=
 =?utf-8?B?UlJaU0hodXhtakkwMlNidGhzUHN6RnZFMGRBWGcwcFFYVU1jTWpwSFN4bHpi?=
 =?utf-8?B?V0NGNnFHM2RUU2ZFbDY0WEJkNW1yWm9Cd0hSUG9YOTRKN2x5SnNrNXVBeGpk?=
 =?utf-8?B?Rk9ONEZtVTB2NENHSjhjZFVxRVlJVUVZSk9Nc2pDYXBlSVBhQWRadjVXRk56?=
 =?utf-8?B?L3hRZW5jYzExR3FscUpDYURxQW1xbGtXS1NWYUFnYi9EUDk1emFPTEdhQjJE?=
 =?utf-8?B?MVdOUGoxTmhYQmM4WFRDYmo0NUV6eHdGZUlvaXJJTGlnYkNjMGhDSjM3M2t4?=
 =?utf-8?B?dUpEcEVMVWdNbXhkSG1MZitxMTRWMzhJYmFYenhYc1E5NkxEa3lLVzZYNTUv?=
 =?utf-8?B?VkNmUGM1RmpDNmNJYXhwUk9xOExybFljeldMYXRjYkJqQ256aUNuOUNRSHZj?=
 =?utf-8?B?UnZzS05Kb3h3QU0yQTdqa1o4Uk1vN21aY1I5ZjBJWXN4cGd0dW43ZlpmZ0o5?=
 =?utf-8?B?bjRNQWhPempBeTlsVzdLNHlsSktadlUxclFXbUdFamJiQlJNMHV6RnhnRjk3?=
 =?utf-8?B?TndxYjNCSXRUTXcyMjl5MW1pUXY4VG1UZ0gyQ0hEZHpMdERrcHRBYWZhYWpr?=
 =?utf-8?Q?Ez7xa4eGZNRoSLVIPQmwMbwailI2N3cQQbU6xqyw2dy/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E55CDFA585A2094DA4F44AC1B95BD848@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d10a6812-1962-42d3-b2b5-08de264560d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 01:54:15.1928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gGelBD6n4+ViTiZ5xRhXa6bYTJzCsp55H4EvqrV5ZDlpARffN+m2be6pH0G1OcIa+BQr7v/Vl0D2sDmOvOD/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669

T24gMTEvMTcvMjUgMTc6MjYsIGNoZW5na2FpdGFvIHdyb3RlOg0KPiBGcm9tOiBDaGVuZ2thaXRh
bzxjaGVuZ2thaXRhb0BreWxpbm9zLmNuPg0KPg0KPiBJbiBjb21taXQgMWU0NGJlZGJjOTIxICgi
YmxvY2s6IHVuaWZ5aW5nIGVsZXZhdG9yIGNoYW5nZSIpLCB0aGUNCj4gZWxldmF0b3JfaW5pdF9t
cSBmdW5jdGlvbiB3YXMgZGVsZXRlZCwgYnV0IGl0cyBkZWNsYXJhdGlvbiBpbiBlbGV2YXRvci5o
DQo+IHdhcyBvdmVybG9va2VkLiBUaGlzIHBhdGNoIGZpeGVzIGl0Lg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBDaGVuZ2thaXRhbzxjaGVuZ2thaXRhb0BreWxpbm9zLmNuPg0KPiAtLS0NCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCg==
