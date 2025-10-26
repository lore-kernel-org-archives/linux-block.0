Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6005217BA6;
	Sun, 26 Oct 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761454543; cv=fail; b=h9Llj7S9A5lEjlkllhEo8jL7/Wv78WVM4ctBksXkLQYPO/weSge8KmH/kgNq4zW+TFiiBQ4K6WePPyTAM/64fV4M9/HuQQBprPeEMFjs+ILhbTZg1Teo7ClSrtm4TB0QilNVgOD4SfZxf0lLJIMZAmmbvzLkG5HPQMX+QyXBfNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761454543; c=relaxed/simple;
	bh=UZSV2fmNegJTEjlaSB/zYpW/Lgib3JTvo3II0tIQQSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a1KV4fgkrO6JM5cERAFPk0t5lDfxusyHh/aeqBK45S5J2Ov7kaoYMFHI9AWAz0NaJDLGB5Be08BtpbtKSN/kn4BGl6dd/XXkyH5FFTMP5qzglQUOAQIp90K09s+J87mBa8dvqaizH3wM3E2SBxmmGKaWUELk+G0iuQMvxbvDNE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hn6ZiP3M; arc=fail smtp.client-ip=52.101.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hn6ZiP3M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkGpTFKqJAorrOe+P3+5pLtAlrKCAlcn9ILwdLQU/s8vl9uKqnTDXHm85d0G0Z3NFWE+O3XGlz/l79mhJKqSZDfIVs0fy1jWAOHO2l6S9GYsHDthA5OC5sHJGjAY6nY5IPgJgS/r2uk7sm3gR4a2dxt/vT16ozTXpUYlVJFpFQjeVMxNdZIzPWPOvK9BRgY/7bTgFOFTS8t7XNj01BvnW446Fwf7Go4iJTptMWzd2GHr5Xx7V9VZHVbFSNDO1KKhJZZ5fDgZxBPkzW0LDaR9K17mUgU7cpyZavMx24+wy57Y3zoFAxR8mZVXLaYqHu65pgcegPOfYlwtWhBnfbee2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZSV2fmNegJTEjlaSB/zYpW/Lgib3JTvo3II0tIQQSI=;
 b=tV9DdSCx17bOAoX9pWGNCetN0aA0AdgU5jQUCvOqZjxT25IUk81mQlKqxDDaFNkkm1G7CcY04I/XmeuQC+V+V7ET3WH2hfCaYuB4LruQp7mmeMaUi7h6/OZtJecMdaqIwC3ziMez1eGdkunNcdtgq0RMSslFmW+T/onGRcWeQODFG3HE1HXhQXY8PFc7OQnWQqJAasPbhl2pIyPWy50ee36XT1jDssAVC317rr+Yi6Qy3aSXeb1nvh7R4GL9BTV2YbKZp/OE8BNm1ugnGUMd4TZuNPYsNmOgeMFbzzkH5/kRdufcPQ++ZncFVW/+HYeUtJd7/fZ/p2O5U5+GMe8z6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZSV2fmNegJTEjlaSB/zYpW/Lgib3JTvo3II0tIQQSI=;
 b=Hn6ZiP3MUh+6fFAglSjFqWMkRPStVHZR1XLM7AIF45CH3HhudWjRUXE+PQHuXDMdR7QV8bZsFggkE+z+tKeFUgpDhUtb4DTRkeVCklkR7xS3Qp2kEzyaZhA/he1jLpHGhRPUN5BO8cOUhqpW/o2/7u5XrGHwCb5UcTB43Y0Ru+9TX0MonQE75T29QebjfZCe/KxQKYE5zry5XuYIW3u87LQDasz+UKwLF3C/76CyU2SDKgBVQ47G6cVNH7XdRrbfxE8zc/X2X/O7CXz0hL9WHYv+z128UQuJ+yZOnDqUbdQ+3F53kBqyLpspA5FzgjbvsTeCxEAPWfhw8YMUYGLCdA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Sun, 26 Oct
 2025 04:55:38 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.013; Sun, 26 Oct 2025
 04:55:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: syzbot <syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [block?] [trace?] WARNING in __blk_add_trace
Thread-Topic: [syzbot] [block?] [trace?] WARNING in __blk_add_trace
Thread-Index: AQHcRTuRuF4tdLmizk2cNOZ+I1QUsrTS3e4AgAEBJIA=
Date: Sun, 26 Oct 2025 04:55:38 +0000
Message-ID: <cc31bf15-5c9e-43b5-9615-2475aebd1d53@nvidia.com>
References: <68fc07a0.a70a0220.3bf6c6.01aa.GAE@google.com>
 <c4ea8d7c-e449-47d6-b4a1-54fdbe86ba01@kernel.dk>
In-Reply-To: <c4ea8d7c-e449-47d6-b4a1-54fdbe86ba01@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7654:EE_
x-ms-office365-filtering-correlation-id: 2849e581-a39e-4c9e-a27b-08de144be820
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aTJxdWN0QVFJSVBxQTFuTVZENHZ5WmljZ2VMais5NDZwdU9PWHAra1g0MnNN?=
 =?utf-8?B?Ry9Ib3ZqQW01NHZzN0xQVnBZN0RGVUJCYlMzT0d6SU5OVG5FQ1BUazhieXU4?=
 =?utf-8?B?amovWVQvcCt3S0VXeHdTSTdzWllXam9ROStrSHYvT3lDeWhvNFJaUkdHL00x?=
 =?utf-8?B?WTJIZFArNE9sUGJ0UzBObkRCcHFxamVJTHJYaHZHdjhWQWRWMWdHU2xDMjQx?=
 =?utf-8?B?M2s0d3RQVWxrcmVNS2lqR1BWM3hMTzFKQUMxYVc2V3NDd1VtTjl4bStMUmk3?=
 =?utf-8?B?SnU4Ymtybm9mOTd6czU0Q2YrWi9Nb3RxcFNLZEhJZmJEbHhhK2xIdTNua2c3?=
 =?utf-8?B?Sloyb2hxRG0vTG9GcnRUR2ROcGkySGViaFpiVTN4ZWhDR1pyNklybHpOa0Uw?=
 =?utf-8?B?NTY4eXhoUDBtb3BPTmwxbk1BaTlkU3MxdGtZQmpkelJFNGlPVXNJbk82UU9V?=
 =?utf-8?B?K2F1ZkdjZ25FMXhqT1dDSUVZd1EyT2NBaVN0elZRbkZ1TXBpL201bjQ4Q1Nh?=
 =?utf-8?B?ay9uQkI4Z2wySHZRelhoU2RrbkVqQ1BpRWs2MmFEaWUyVFNKaEtxTGdVVGZk?=
 =?utf-8?B?cG5UWm5nTjllVzN2dnFKMDhIb3o2YWQ3N1IrcGpOKzEvWXJiQjg4T0N4VnBx?=
 =?utf-8?B?TUc5R1lpTnF1aldyRXJoNk4yK25Dc3JYNTlld3h4UjhsUzI1NFhQdkZMR0d2?=
 =?utf-8?B?d2E0ZzZtRDY2NVE0U1VuSkUzZ0R5YUtKb3FZZWVUMThuNGpqV3FNbUxBeFor?=
 =?utf-8?B?Nkx1ODhadWdGaVJuQVhOckhRVVVlenRzdGRNVEorMm9XS3hSMmRxS2JUTnNm?=
 =?utf-8?B?YXJ3aUdvVDVmd25RQ0QrekJpWEI4RW1aRDJVaE5PQlVySWxwUC9renk1NWww?=
 =?utf-8?B?ZmNLRDJ3QzRicVFZUDRKSlZLdEhON0VWL1A1elRTb2c3SEdOR2x5RGxyUmJP?=
 =?utf-8?B?em5ZVlZCb3d0N1YyYnVkZnhON3dNVzkwTHNjcDYzOGJSdGQ0V2owT0NiVFFo?=
 =?utf-8?B?UTVsL3B4c0FaTDA2VFl4K0hUK1JZbXJqYjg4SzBWbFMyUWhRWDNOYkRsa3M1?=
 =?utf-8?B?RWUza1FNZVhuaVl0anFRb0sxU2o5emYxNGFObThlQ3NlclJhTjdmTFJFMXRI?=
 =?utf-8?B?TmFtVzZ1eSs0QWVCSWkweTlHRVl5cmxQOThjakJnUE1EUDFCQXpFR25jaHBX?=
 =?utf-8?B?aFRWMmtLeXlxRXVmV1FOSDNSOVluYW0rT0J1cTBtNTkzNXgwakRTN2RrK0Fm?=
 =?utf-8?B?STdtRjM0U1ozRHZaQTBIRGRnUGN1K2doSmdOZ2RqZHlKYXd2cE9rME83bksv?=
 =?utf-8?B?ZmxlU2JKUUNBZG5xRVJoeWQ0TWNFVVlQS0R0SmJNUGNWdVNNbGd1bDJsRU8x?=
 =?utf-8?B?WnZxRmZlZStXN1h1Nk94KzE1RzdnN2g4VmtBSFp4ZjQxNnBrN05VQklsK0Ey?=
 =?utf-8?B?aXVjS2RNNUVBZDRycElZQThjTmNyZW43UmJEY1U4MEduWFk3RUpGWnJjVDEv?=
 =?utf-8?B?eHpWQW44OHhDQnVMWWpZYlN1TFhXOGNJL211OGZnLzJTdHM2NktlMmROWGFK?=
 =?utf-8?B?SUtvNW9OVmVDUm1nSXZ2UHVqa1FNNk9PSEs5azcwSFBYZTNXeFNXdzhUZ1pC?=
 =?utf-8?B?d0JyZHZoNEh6MDhrck9KcFBwSURRQytkb1BIN25VVXFmSUQ2bnI3QjVvVFhY?=
 =?utf-8?B?ME1zMmMrejZITi83WEVLSnM2d3lUZnYxVWlOa3dZT1RQLzd1ei9pcjNtbDNa?=
 =?utf-8?B?UkpJb3dzVTR2d3RmMnhKQllsYnhYM2hiT1ZoMi9ReHBZbGo4WElNRzNHL0xh?=
 =?utf-8?B?N3h2Tmh6Ym1UWnlHellkZnBiZ3pKRjlsRTgrbUxMeEdGR3VKYUNsWnJ3emE3?=
 =?utf-8?B?eStDYXVORWRSSEZsK2hyRGoxOUxqc3lZRFU5ck5vZDhqNHBia0ZZZFMvaU93?=
 =?utf-8?B?SnJGekpUckorVFpDWlZsRElMUGQvN2JSWFBJRkg0My9LRHpxd1NUY2ZvRlow?=
 =?utf-8?B?UUFTTW0zU1ViQXN6ZnFYdytMbUVUQXJuZkxjL0tZWVRSWEpiTjVrUGR4dWF2?=
 =?utf-8?Q?adPYZ4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0JXQTVYb1pZaW8vck56VWZyUkhXQ0hjZWI2eldNbGV1MUo0REowK0dOYUg4?=
 =?utf-8?B?MWZCMXIwV3l3WXYzbzI2VHJWNzJsZ21XT3dOR3lZL1BUeTBjdmlhQUVyK1lY?=
 =?utf-8?B?a1lYcDUvdERqOExUYTdibWN0TUJnaWFRSVNJeHpPUjY4OEp3N1FqaFhwVFI5?=
 =?utf-8?B?VlpZdEZPL2F0KzJqL2JtVEUvYWJBL1VWV0Z3NkwvcUM1WTh0eTE0WWJxaDZD?=
 =?utf-8?B?d2h1UGsyQVUxd3pUSnMySG02emRjYzJoWWJnc2FsL0RTUUZzdGtCVjBHc2Jl?=
 =?utf-8?B?dzV1SU1zTEx5ODgrenpYOUF5TEhkVi9VSUo4YUV6MTlteHZmWFJFalFMczEz?=
 =?utf-8?B?WFZ6OFNFWXJpbUN1a2NhR3kwRzdIK3FndUw0WXNpM3Q5OFc4bU1nTUpaM0FM?=
 =?utf-8?B?ckhNZE4reFlrMzRwWHVvd3ZId214MFNzd20rNjlIRWhLTzhGbjgrZ3gwRlI3?=
 =?utf-8?B?M09MRitYY2FvTlkvbUJBd2xrdG02Uk5pNzRxeTRDSUMwaUhsVVhhU1haZnpX?=
 =?utf-8?B?ZVhkb1RRZ3JaUTlDTjFDR2tqK1h0dGhTSzkwVXVFRHVqL0djeUd4Z002NURv?=
 =?utf-8?B?a0NNbUlLU2NsSTBvdERGL2tVQTZNN3BKY1lDMU5qdENBL2FNakVpTk83aXVs?=
 =?utf-8?B?U3FydzFXTGxEMEhMMUdCT25samh0ZHdQeDQvb28rU2ptbVY1V2ZQWDdpSkpt?=
 =?utf-8?B?cTFuRmtYM3NXbVo0c0FWVTMvamdoclNPY1dBc3BwNWRDMjczODM2ZlEwUXZo?=
 =?utf-8?B?Vk5acHJ1dVlrQ29HMTFFazVpSHhLNjJSK05RZ1B0NEFScm5ETitSZ3I0MTVk?=
 =?utf-8?B?VWgwUmhobmp6VFBSeXpvYWIzcGtNekVHYWw4cWJ6UzgvdytkN1BYak4rRC9E?=
 =?utf-8?B?VlFmMVkzU0d6d2FFd0hXMC93ZU41ZUxXTFlLOG9MS0lOUmQxQ2pmOTgyejJK?=
 =?utf-8?B?TmdJbHpobXprRGFkT2JTcG0rbmd0YkgwdkJUVlNqR3BLNVB4b25jdVpLUFkr?=
 =?utf-8?B?NTlpWGRoWk41ejN6SUZRTWFISEJJajduV3NjTGVEMHd6bVNTc0hvbzNaRGV6?=
 =?utf-8?B?YU82NWcvMTdrelZYbVVlQUZTMFlWdXFUK1VvbmVhRWI2MTBKamNkY0Y0WEU0?=
 =?utf-8?B?WEMyT2w2N3ZvTjVjOXZtM0lYYmlOd1ZxZmJ6TTZNVmtXZ3U1OFAxSytLQzNk?=
 =?utf-8?B?a3ROT0dmZk1zT0pKdkd3Ym01UkN4VWFRWlF6SmRVdnljTUZIczYzSVZ2WTEv?=
 =?utf-8?B?TlNTTkczV1JZNURNaEsxbjNyOUhtbmJCWFhzMS9SNXV5ZXk1NW04bFMvVS80?=
 =?utf-8?B?R0JTL2N1NzIrdDhhQ0lWdkMwL1F3Vzd2aHVIOVppcEJDV1hOZnZzNHdMUEtw?=
 =?utf-8?B?Z29ZeFU4Y3p3L3lCTGFsRVV4ZEpkcDRucWFDMks2NnpFRTE0K3JiWFVhTzBM?=
 =?utf-8?B?VGJqWGk1ZEQ2MWFaRXl0QW9BcTArRlNGVTg0VnVvaHJzTzhPbkVjT1pDSzBx?=
 =?utf-8?B?S1FjN28wMjZFS0prNWpFT09lTWNLTVUvd2lrVXR3Z2JnOSsyc2xDTTNxaTM1?=
 =?utf-8?B?MUdBVjBtVUNtaGVDYW1NL1lrTGhoSThhMGxsZlNuRkZ1OVJhdER3TFhlR1h0?=
 =?utf-8?B?a0VmcXFqYldSZFd1c3FOZVJrRlhaeHZweHdyd0szTC8yMUtYUjVyQXRMTmFr?=
 =?utf-8?B?TGp1NG5LaG5DbW1OUjV3MkVtSktRbkdKTERjaEtPSzRGZVRqS2Jhd2N6bkZx?=
 =?utf-8?B?SDNIQk53R2orYjhYNm5HZmlwVGJrODR1NDRBWnlrekxJaWhxV2NaNmYyY1d2?=
 =?utf-8?B?R2NkQ205ZlZjWExTZEJwNk9oVlI3cmp2SllLdGJraXJ5RStQL0RnL1cxaktk?=
 =?utf-8?B?YktHekpWZzBMMURJR2ZnWG5sSHhCdEx6QlVKTTc5SUlwejlwQkFBeGlSekYv?=
 =?utf-8?B?UGJuc2huM2lIbENhOE1Ucms2ZlU3OUMxcTBNRWlOZ0NvUFpWZCtJTjJWZ3Jt?=
 =?utf-8?B?TWlzZWpNRWNjcHNicGVjd2wyVElveFpkclBTSUszb1VDOWhNMllIWk1yM1dU?=
 =?utf-8?B?QXd0bTlJR2pwMVpZTGVBbUs3WVN5TWNKVkZTTUw1U24zVDlnZExKMkN2TTBo?=
 =?utf-8?B?QldRajJ0aDdML2U3dkhLeUNRWXdmY3Jzc3FMSDNDZXhiWHNONlk3c2xIeUlJ?=
 =?utf-8?Q?rPCHktbakqHhYwkRtswJUyf2yNKf6fhbKUrMJoCNYQ6Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8D39B2713E9E64E89E9B893044706F2@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2849e581-a39e-4c9e-a27b-08de144be820
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2025 04:55:38.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9ZztqD79CWThd5QtBIjbcrW0b3gqSq25LKZ7RO1EOl+70xgOnop6o/5dqXxkHPWltaE6s8IEqhghlsOkaI0UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654

T24gMTAvMjUvMjUgMDY6MzUsIEplbnMgQXhib2Ugd3JvdGU6DQo+PiAtLS0tLS0tLS0tLS1bIGN1
dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4+IFdBUk5JTkc6IGtlcm5lbC90cmFjZS9ibGt0cmFjZS5j
OjM2OCBhdCBfX2Jsa19hZGRfdHJhY2UrMHg3OWMvMHg4ZDAga2VybmVsL3RyYWNlL2Jsa3RyYWNl
LmM6MzY3LCBDUFUjMDogamJkMi9zZGExLTgvNTE2Mw0KPj4gTW9kdWxlcyBsaW5rZWQgaW46DQo+
PiBDUFU6IDAgVUlEOiAwIFBJRDogNTE2MyBDb21tOiBqYmQyL3NkYTEtOCBOb3QgdGFpbnRlZCBz
eXprYWxsZXIgIzAgUFJFRU1QVChmdWxsKQ0KPj4gSGFyZHdhcmUgbmFtZTogR29vZ2xlIEdvb2ds
ZSBDb21wdXRlIEVuZ2luZS9Hb29nbGUgQ29tcHV0ZSBFbmdpbmUsIEJJT1MgR29vZ2xlIDEwLzAy
LzIwMjUNCj4+IFJJUDogMDAxMDpfX2Jsa19hZGRfdHJhY2UrMHg3OWMvMHg4ZDAga2VybmVsL3Ry
YWNlL2Jsa3RyYWNlLmM6MzY3DQo+PiBDb2RlOiBmZiA0ZCA4NSBlNCA3NSA0ZiBlOCA4MyAwZSBm
OCBmZiBlOSBmYiBmZCBmZiBmZiBlOCA3OSAwZSBmOCBmZiBlOSBlYyBmZCBmZiBmZiBlOCA2ZiAw
ZSBmOCBmZiBlOSBkOCBmZCBmZiBmZiBlOCA2NSAwZSBmOCBmZiA5MCA8MGY+IDBiIDkwIGU5IGNh
IGZkIGZmIGZmIGU4IDU3IDBlIGY4IGZmIDQ4IDhiIDdjIDI0IDMwIGU4IGNkIDUxIDAwDQo+PiBS
U1A6IDAwMTg6ZmZmZmM5MDAwZTU0ZjQ2MCBFRkxBR1M6IDAwMDEwMjkzDQo+PiBSQVg6IGZmZmZm
ZmZmODFjODFiNGIgUkJYOiAwMDAwMDAwMDAwMDAwMDAxIFJDWDogZmZmZjg4ODAzNDFhYmM4MA0K
Pj4gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDA5MDFlMDAwZiBSREk6IDAwMDAw
MDAwODAwMGZmZmYNCj4+IFJCUDogZmZmZmM5MDAwZTU0ZjU3OCBSMDg6IGZmZmY4ODgwMzQxYWJj
ODAgUjA5OiAwMDAwMDAwMDAwMDAwMDA5DQo+PiBSMTA6IDAwMDAwMDAwMDAwMDAwMTEgUjExOiAw
MDAwMDAwMDAwMDAwMDAwIFIxMjogMDAwMDAwMDA4MDAwZmZmZg0KPj4gUjEzOiBmZmZmODg4MDc1
Yzg2MDgwIFIxNDogMDAwMDAwMDA5MDFlMDAwZiBSMTU6IDAwMDAwMDAwMDAwMDAwMDENCj4+IEZT
OiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKUdTOmZmZmY4ODgxMjVmMjIwMDAoMDAwMCkga25sR1M6
MDAwMDAwMDAwMDAwMDAwMA0KPj4gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAw
MDAwMDA4MDA1MDAzMw0KPj4gQ1IyOiAwMDAwNTU1NTc3NjI5ODA4IENSMzogMDAwMDAwMDAwZGQz
ODAwMCBDUjQ6IDAwMDAwMDAwMDAzNTI2ZjANCj4+IENhbGwgVHJhY2U6DQo+PiAgIDxUQVNLPg0K
Pj4gICBibGtfYWRkX3RyYWNlX2Jpb19yZW1hcCsweDRiOC8weDU2MCBrZXJuZWwvdHJhY2UvYmxr
dHJhY2UuYzoxMjAwDQo+PiAgIF9fZG9fdHJhY2VfYmxvY2tfYmlvX3JlbWFwIGluY2x1ZGUvdHJh
Y2UvZXZlbnRzL2Jsb2NrLmg6NTI2IFtpbmxpbmVdDQo+PiAgIHRyYWNlX2Jsb2NrX2Jpb19yZW1h
cCBpbmNsdWRlL3RyYWNlL2V2ZW50cy9ibG9jay5oOjUyNiBbaW5saW5lXQ0KPj4gICBibGtfcGFy
dGl0aW9uX3JlbWFwIGJsb2NrL2Jsay1jb3JlLmM6NTg1IFtpbmxpbmVdDQo+PiAgIHN1Ym1pdF9i
aW9fbm9hY2N0KzB4MTg3Yi8weDFiODAgYmxvY2svYmxrLWNvcmUuYzo4MDQNCj4+ICAgam91cm5h
bF9zdWJtaXRfY29tbWl0X3JlY29yZCsweDY2NS8weDhiMCBmcy9qYmQyL2NvbW1pdC5jOjE1Ng0K
Pj4gICBqYmQyX2pvdXJuYWxfY29tbWl0X3RyYW5zYWN0aW9uKzB4MzQ1NS8weDVhMDAgZnMvamJk
Mi9jb21taXQuYzo4NzUNCj4+ICAga2pvdXJuYWxkMisweDNjZi8weDc1MCBmcy9qYmQyL2pvdXJu
YWwuYzoyMDENCj4+ICAga3RocmVhZCsweDcxMS8weDhhMCBrZXJuZWwva3RocmVhZC5jOjQ2Mw0K
Pj4gICByZXRfZnJvbV9mb3JrKzB4NGJjLzB4ODcwIGFyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmM6
MTU4DQo+PiAgIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMCBhcmNoL3g4Ni9lbnRyeS9lbnRy
eV82NC5TOjI0NQ0KPj4gICA8L1RBU0s+DQo+IEFkZGluZyBKb2hhbm5lcy4NCg0KVGhpcyBzZWVt
cyB0byBtYWtlIFdBUk5fT05fT05DRSgpIGdvIGF3YXkgaWYgeW91IGZpbmQgdGhpcyBmaXggdXNl
ZnVsDQpJJ2xsIHNlbmQgYSBwcm9wZXIgcGF0Y2ggOi0NCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC90
cmFjZS9ibGt0cmFjZS5jIGIva2VybmVsL3RyYWNlL2Jsa3RyYWNlLmMNCmluZGV4IDZhZDM4MDdh
NWI3My4uYjQ2NjJjNTYzNmE2IDEwMDY0NA0KLS0tIGEva2VybmVsL3RyYWNlL2Jsa3RyYWNlLmMN
CisrKyBiL2tlcm5lbC90cmFjZS9ibGt0cmFjZS5jDQpAQCAtMzY1LDcgKzM2NSw3IEBAIHN0YXRp
YyB2b2lkIF9fYmxrX2FkZF90cmFjZShzdHJ1Y3QgYmxrX3RyYWNlICpidCwgDQpzZWN0b3JfdCBz
ZWN0b3IsIGludCBieXRlcywNCiDCoCDCoCDCoCDCoCB9DQoNCiDCoCDCoCDCoCDCoCBpZiAoV0FS
Tl9PTl9PTkNFKGJ0LT52ZXJzaW9uID09IDEgJiYNCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAod2hhdCA+PiBCTEtfVENfU0hJRlQpID4gQkxLX1RDX0VORF9WMSkpDQorwqAgwqAgwqAg
wqAgwqAgwqAod2hhdCA+PiBCTEtfVENfU0hJRlQpICYgfigodTY0KUJMS19UQ19FTkRfVjEgKiAy
IC0gMSkpKQ0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybjsNCg0KIMKgIMKgIMKgIMKg
IGlmIChjZ2lkKQ0KDQphbHNvIHdvdWxkIHlvdSBwcmVmZXIgdGhpcyB0byBiZSByYXRlbGltaXRl
ZCBwcmludCBvciBrZWVwIHdhcm5fb25fb25jZSgpDQphbmQgYWRkIGRlYnVnIHByaW50ID8NCg0K
d2hlbiBJIHNlbnQgeW91IHRoZSBjb2RlIGZvciBibGt0cmFjZV9leHQgdGhhdCBjb3ZlciBsZXR0
ZXIgaGFzIHNvbWUgdGVzdHMsDQpub3QgZGVtYW5kaW5nIGFueXRoaW5nIGhlcmUgYnV0IGl0J2Qg
bmljZSB0byBoYXZlIHRob3NlIGluIHRoZSBibGt0ZXN0cw0KZXNwZWNpYWxseSBmb3IgdGhlIFJF
UV9PUF9aT05FWFhYLCBzbyB3ZSBhbGwgY2FuIHJ1biByZWd1bGFybHkuDQoNCkVsc2UgSSdsbCBh
ZGQgdGhpcyB0byBteSBUT0RPIGZvciBibGt0ZXN0cyBhbG9uZyB3aXRoIDE1IHRlc3RjYXNlcyBz
aXR0aW5nDQppbiBteSBwcml2YXRlIHRyZWUgdG8gZ28gdXBzdHJlYW0uDQoNCi1jaw0KDQoNCg==
