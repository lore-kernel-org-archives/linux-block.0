Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215452AE68;
	Tue, 23 Dec 2025 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456022; cv=fail; b=SEAZnhYpoW1FIgX/JRv5E/hD0T3culNhpKSvrHR0sEo6XoSJrCuAzA+CunsC1UY/gRMNX1Vj9wa6+W3IvXOD+LY5HO/PdkhujQOWqd2iCrodOArgWMTrCZ6viVz3gplqhgPCb4V0sgRMMIhGZU/frNe0DWaupGM5hKJMY1V7zYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456022; c=relaxed/simple;
	bh=dr065x0lOqRn+FEf/MKb18rJIdVnejrBW0YS93uYJrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tF+kVb2GDkCTznVnM5ZaAZe8JLAJEvhE5kKCP+LgKFp7R8+mz9oVBlW9gwtTnfb3PkzisFzDcpm3t6Y3ZA/ev3wN+q4XHGX2f4qlR8kdMUtlZKa4YJ4QBzEvCdnHCmlB9onNrpcplMwZ06nsiIV+ivuiYK1sddJ5aFS0PJ404iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hYRpsP+z; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hYRpsP+z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUEOzhQ+21kVmtteV3EWSpj2l5CMeS/yk4Q0uAjSrmfgR+vXoO+woOFM+W74/3g8CKb24GNiQRADHO5l2F/Rz3sMpxMnx3VuaHDGkQhkt1zbx4GuuSwUi83H3iTWYa6lNHoPKeBeIfYfkwu3ZZAsgIHNWYsbmUOBvWX+JnL1Z9lBxd2ipgZr8ZQX4DwPYTTl0TeCgECt7ro9UpRgStlaFJXNIddowdY6GrCdADFwXyXSnkkCle5XbYz/CGRzGGsJyHTc8n6agX+WoPPGGqpCUA7li89fIzGjuHKj3cnUJ+beHKiz1QFPRLApUqPVReh3V1t+2jKQFFdKyYKtlDZXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr065x0lOqRn+FEf/MKb18rJIdVnejrBW0YS93uYJrg=;
 b=muHp8S2zzylTe1D0c/I7w3+GXxwzJq2lJu8nR6nLD2RTu323TjZhmRfA4WNlf02y6ynlnlBZB5P3MgEMdLt1fmxhl8PrKl8OPFBcy9nrQyF3KDsXxrga3n8r40+IRAT+qNBed3p/mYNgOc3bOoq/WHCBDMEos1nDOP4KgwDmvzQ4RwCFZR7i5qNAMuMMHiHCogTreEVsmCDKKf3Atq8a2amZOw+kDMaPC7IWYHpZNXcI5MUP77s5Y7yhui6Ecqi3xYIBJnTTrgo6gfT8/ay+mX2nwkG17bO+DhQTCfjlp63Et6pzFqmD6VQZVMxgk7xjDg77g9YSEk7lwsOnvx8YfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr065x0lOqRn+FEf/MKb18rJIdVnejrBW0YS93uYJrg=;
 b=hYRpsP+zvjKJJ3G6ezoyiNe2nncD+2w8tniKR00WFw8hNKho1B/lEs8lXsdZe1EjKESXCNja4pyEQUZmx4LmkftHrBMmTHyRrDED9JV2dEF5QtljuZxYCQUDkB5pud5xP3w+r+6KxsW7FkWt4InawCx9hD1IIVLVQoXItk4qEOXwp1VQup2T4WQD6lIpdomralHzp67bUhVCjcp38o8PAbQCQ/PHBSuWL2StpZtCEslMKviNCXWbdXP2ejvhNkFtIwmfPiKGZIrmK9u04is0tamvMM5y1N4wv8nmQdaJQPQ4iA9QsnIrpBcDbov65AhBEEocT0AsA1W+Q5ioq/9OQA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 02:13:38 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 02:13:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>
CC: "rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "johannes.thumshirn@wdc.com"
	<johannes.thumshirn@wdc.com>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
Thread-Topic: [PATCH V2] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
Thread-Index: AQHcSDGn6Dwgolv8p0+vvRCHKoVKgbUp9Z6AgASvY4CAAC4bAA==
Date: Tue, 23 Dec 2025 02:13:38 +0000
Message-ID: <874ee16d-0a76-4139-b802-83c854e271fb@nvidia.com>
References: <20251028173209.2859-1-ckulkarnilinux@gmail.com>
 <bd88af0b-be00-4f1b-b089-6fce986e3cfe@kernel.org>
 <03a59f8b-c139-43e0-94cb-80cee108f939@kernel.dk>
In-Reply-To: <03a59f8b-c139-43e0-94cb-80cee108f939@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS4PR12MB9748:EE_
x-ms-office365-filtering-correlation-id: 24f034d0-6cf5-4baa-c59e-08de41c8e2b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0pTa3JOSmxVd24rOURCbGVHUVJReWwxZXo1Z21UUTBTSk1kM0JDVk1qejk1?=
 =?utf-8?B?bTdLU2MzNHliN05iam9UWTlwVHU3NHNMMW5MdzlhS3pLRkdoMzU0azJaSDBE?=
 =?utf-8?B?aWZXVXlPa2RuUVUzbEY2NXd0ZHg2UDVRODAyQmlubGRvdFNlbkIwOFEvQjcz?=
 =?utf-8?B?VzB6Ly9Ia0o5Q0R5NUhibDNlTEkrdGt6SXhzbmVzU252T1BFa3ArbVVEN1ly?=
 =?utf-8?B?ZndUVHJ1b0Z1UlFxNFJiQUlLMmIvbG1COHRPMWR6Si9UckJPT0YvdkJjY2lB?=
 =?utf-8?B?WDhoRWFZUWxnLzNvNzN4SEZhOWFOUXg2ZmV2MEg5N0tPTC9IZkFqRnppMEll?=
 =?utf-8?B?NVpSQS9vYkIvZm9UODFzUHFDQ1Y5Z1Q2SE5aeTNQeTVUQ3dwRUpNTlJiSWI0?=
 =?utf-8?B?SEw1anhEaGFTeG5UdmFaZXlIcDhIbzJVNDdhSzdhUEdyV1d0RFhVVHhRajVn?=
 =?utf-8?B?dEZQUDdhYnBLMDQ5MWVtMWd0d2ozS253ZGpzcEdJVTlsQ2VBU1VsZEt4cDhv?=
 =?utf-8?B?V0JsRU05YXZWbFluUUhjS21YaGtGUVV1WUJDZS9nUnJGTHBUSnFoZCtSUzFk?=
 =?utf-8?B?dDZtdDZUT1BYUURvUDROcER4OFNHVkgxc1BHbDhUYmpzWFRKdjRhMExyVDFZ?=
 =?utf-8?B?MW5IUjh2YytlaUZiNDhrM29SQmtwNmVZVG54anIwWTc3YjhMUGgzdUdTTHA2?=
 =?utf-8?B?Z1JGWXFJNFpQd214SUxZN1RSS3plem9aOXVlZkQ0NFhkYW5ZMFFsQlRNMEhj?=
 =?utf-8?B?UTBYay9rMzNMa3BjeU1hdSsybWEzQzE2QjhCZlFtMVBKY2t1dm82VzBPOGRL?=
 =?utf-8?B?aUtMMmlaY3ZZbUExSzQwUlcvaVFIdURxYVBBK05Saitlekg4Y0RCZkk3Z3Yy?=
 =?utf-8?B?aGVCNlQraGZlRmQwaW5ZT1loak9nTVNHYmw1RTdBMDArRHY0M2xud1dFdHRY?=
 =?utf-8?B?Wk9zNG1pYVdpS3NUaTNpS24yU1U4bVFaeFF5V1d0cUdIUUJCSWppejhZeEdL?=
 =?utf-8?B?bmt2QzNLZXIwOG42RXp3N2FJcUZSOFBYVkwydTl1Q1JBYldEck00R1BuQmZI?=
 =?utf-8?B?SVBjbHplemVaSjJla2NLTmVsU1lzRi9nOEU0VDhnTUhwR2VKazRKcnZiMFpQ?=
 =?utf-8?B?QVR4Z2JYTG8vL0x4U2NTZkZlUEcwemVGYk94dndidHBvdUFqVW1kNVdJYjZ4?=
 =?utf-8?B?bmpxaDVwdHZyWnBrR29Hb25iN2l1cHhtZEJkRG1CZGZNVTlrTndhWWRlc3Bz?=
 =?utf-8?B?OE9vazJSckxEOWJuOTQyT09QNUdBbS81U1ZpTHZTN3F5VzJZMXh2SDhKWFV1?=
 =?utf-8?B?VGpLUDFLTjhaUlNuZ213Z2dYeGVqeHBRWHdwNCsxb09LQjdQK0YzODhGM3VD?=
 =?utf-8?B?YklFSHZjTm1XdUk1Y3dhUzVRMTdHaEtRMllZRkJicWlGejlGOS9ENyt5TmhW?=
 =?utf-8?B?cUcrWWllcllSRkMyUW1adzZKRUZCdkVUb3ZLOTZuZEZqWE0zSTFheHN6S25a?=
 =?utf-8?B?TzhnQ2ZhdEZZeVI1T0NRcHRFLzNWK0x5M3JtMHJQbysrMkR2TE1pYS9uL0V2?=
 =?utf-8?B?R1ptcTg5c2ppV2RTbitHWHdrYlY4bzZGQ2RDTEs1aXhDOUlvZ1JXeDVtLytu?=
 =?utf-8?B?QVV2Y1h5ZW1GZlp1bVNQSmk1RE0rdEZsM0VCZUJWTC9VTkltbU5CRkl1bXRY?=
 =?utf-8?B?c3g1Vko2S2lVcC9VRThCLzArY0w0RW82Q0xyS3U4djkrN2Z0RWhXSXJOQnZW?=
 =?utf-8?B?dlJ0SUJubUZEa1VjYTVqZEYxMWVPa0ltY240QWlrZWw2Sk1seWFDdEFGVjVv?=
 =?utf-8?B?RlczUzBvOUhmUHk2NWQyM21CeGRJSDVuUjc1NUovc2FOWEhlM1ViNlRZZ20z?=
 =?utf-8?B?OWRHZytmZStUbVF4aEhXUkRvVml1emNidHFjYkRVd0JYRFFHMWdUSGtickc3?=
 =?utf-8?B?ZkZuYk5IWk1hV25EYUdNbkZHWkpiQVlHWHF3MHpZakIrM3ZXYWRPNHE2ck56?=
 =?utf-8?B?UFdwaCtzNlB4Z05BTllKUUxUYm1RKzd2Vm9zUTB2WVJjNGNacitSMkhhaER0?=
 =?utf-8?Q?q3rkXX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnNoekprTWI1eGozS3VXKzZmL1pTNFFmVFltRlZGWjFYMVFQNzZ4cm1VeEVn?=
 =?utf-8?B?c0pqNGQ1Y2ZDdmZUQUZ1eEJOWUpFYkpTcm1yWWtWV1RvdnV5YURyVnlqTXdW?=
 =?utf-8?B?c3pIR0xRWSs4aEp6cTZYVnNTMUpoSmtOVFhtSFZEaTVjdlgvdk1nTFZ2YWNx?=
 =?utf-8?B?MnQxeUdxSmJaUWdjdUltL3J0ZU1STnlNNnZrQWtMd3F0azFGOVVWdnUwYkRi?=
 =?utf-8?B?d2tvSHd3ZjBoQ1k5ZXZkbUZ5OGxGSk5ZUHRZNEdzMm1VZHg4a1ZKVm9kZVpx?=
 =?utf-8?B?a1p4MzZneFFnTFJjTkxJWFg5ZitNQjNoaEpXTDloNDkrMHU4MWYvbW9BakxO?=
 =?utf-8?B?d2hQZlRxQW5RN1NyVHdOL01EUHFtOW1wRDJwYy9tdWZrY2ZBTHFXdnRYV1B0?=
 =?utf-8?B?OWl6UVlFVTNJbzhQTGFTME56YUxZUVI2TUc0eCtRN3VjekEyN1cxd0pxNFZ1?=
 =?utf-8?B?eXgxY3hnYXFQMmo3T3VSdFJzTys4aWo0cG5nb1RpSXNkZXNRQ2hXNmpXV2VS?=
 =?utf-8?B?L2lFVnZLcmp0VmtIRE9zL3JOejM3OFc0ZHdiT3g1VXBuMGd6THR2UmtWbHJt?=
 =?utf-8?B?TVdDTlNOU2RSQlU3UVl0cjdGN2lpenB2UDlWYnQwdlprNWNGN3NnblJMZlUr?=
 =?utf-8?B?eThGdzBXbDZBQnRSbmxaTG9zK1BNUVNWN3Z5RGRncjl4b1BOdy94MlhKemw5?=
 =?utf-8?B?bFVqUmlCWEhyQSt5d05acmRkZnN6OXlHMm10b3RaOXUwQ1RzaE51WGR5NklY?=
 =?utf-8?B?SjF2bEx3VDI3UDhjd21CT1BrRjV3NFh6QkFPU25Zdm1SOEI3U2ZBai96aWNK?=
 =?utf-8?B?NXhTemJLRTdDWi9NUExPdDlvRmQ3Ti93Q1ZxMHFVVW1ZdGRCUitaNTEzejR4?=
 =?utf-8?B?U1UrNWY5YjNpY2hjMm1ZVFhlbEFWYmVXKzhlcU41QTNPKzN0bUFINTRZVS9m?=
 =?utf-8?B?UTRpQnpSZytVNlNBTmFSU2JTcnp2MDlWK25mbXF0MDlRSkhNWTZDYi9jQWIw?=
 =?utf-8?B?TTFSOTdzanRSd3J2ZHhNcUZXRWNIbzdSL29yNUFZSithM0NQVHQzWkRhTDY5?=
 =?utf-8?B?a0FuOEV3VEFYTDdjTmxUbkIrOGxqR3dFRUtzSFFOa0NBYjdwejRTU1NQVG8x?=
 =?utf-8?B?a3ZqYVkyZlo2d09hUXhWWVROUnBFazFXSWd2dWVFek9jdHRranl0Yk8xc0lh?=
 =?utf-8?B?dnhQTUVDbkE1Mk11S2p2dUg4WjFxQ2JzTXhBbDBJTWw5RFZFTXMwekZ0Vmt4?=
 =?utf-8?B?d3Bpb0lTS2pqQ3h6VW0ybnNNdXBYTHRjdFhJWHkrbnNOWjZZWnBPUWFmeE1D?=
 =?utf-8?B?NHphMlJDSnJubmg1ZEdrWndoTFVQSlEralRPZ2prSUV4VmxHQmgxcERodjZD?=
 =?utf-8?B?WEs1WEh6VjlYbjFXRit6VXhsbFVNUStEVU1neWRSZlhTa1RtZnZEVzY2ZkU4?=
 =?utf-8?B?WElUTndUdjZmbGwyQ3lUSlhlUHppTWwxZk9YSUVOK0NhcmV6NlBzN3VtT2Nl?=
 =?utf-8?B?YWNTc3cxRSt4bm10cU1lNS9GazZTWmtUUTZtNTc4enhTMDUwWWxZUDJucGNz?=
 =?utf-8?B?MVZ1NVY5Rm40alNvMmpZdnFNcDRHMEdNL1J1ZUpKNm43OGo5aytPdit5QnF4?=
 =?utf-8?B?c3NsYVVLUFVWWFg2NFA5RnN2MDBIem1EUlZKUDA5dldMOG11L2gzSjdIUlY3?=
 =?utf-8?B?RXZZbHA3U3dlKzdMakhKTnNxT2xjamljamF5NWFSSE5oeFhlK1RRWGZwc2p6?=
 =?utf-8?B?Mk5BTVhpOGlvMlFJTVNscXV2Unl4M2VjZ2kxR3ZpSDl5dGFVZ0FtdUQvclRG?=
 =?utf-8?B?VVJ3NmRqWFh5bENrbkducDVCR3hmcVVJZUNuS1NhM3E5cjV6OWdYUWVQaEpv?=
 =?utf-8?B?M2JlQXA5Ymc1MVJXcTQ1MDJ2TUpzZHQxNyt1aFpjWVJxUVI3eW5aKzFvNHpp?=
 =?utf-8?B?N21JTkhnL2UvenVRTUtLOEhVbWUxZFFOVHJEMTBuNU1ZaGpudDc0clpQb3FT?=
 =?utf-8?B?bGs0ZmNGRnMrUnVQblZNaXhsZVZacVM2aW1PVE1sOFlkNFowbmI1cTJwKzhZ?=
 =?utf-8?B?R3VWd3pMR0dOUGpYQWovU0ZkQlNTMFVBcDh2alJLU1l4bXlCUDBUWVk1WUk1?=
 =?utf-8?B?WTJZc0NmSUhmMjlLVEgvZm51SkJ4UklKc2RxdWFWbjdWSlhjalVQWmxrZ0tN?=
 =?utf-8?B?ZGZibFkvNTZ2OGhzWGYxMGRxU0l4SGVET2JQemMwV1RvUTJXb3lzSU5rR3NF?=
 =?utf-8?B?VGxXbGhwNFo4TmZ3WEoyU0MwVVY1Ykd1NGF0WEZzQy9weUVZbURvK25JdlhY?=
 =?utf-8?B?Y1V5d0I5MXRVZllaRmFMRml5Z1htVEliS2x3ODFOQ1dqR3FJRDg5TlhBem9J?=
 =?utf-8?Q?cNmYPlzqFqwEWUR9WYOEjufxqzeoKT5C17u+t?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE4DAF5631CEFB44BC2D37B7AF2291E2@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f034d0-6cf5-4baa-c59e-08de41c8e2b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 02:13:38.5634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g90/KqMhyCDZl+2rt3Kv9HjdieFiIPKzvv/WNHO/F0S5UP02OMaTDKgRKLP9HVOx5Re5PDqZVI8+2fCKnrZtmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

T24gMTIvMjIvMjUgMzoyOCBQTSwgSmVucyBBeGJvZSB3cm90ZToNCj4+PiAgIAkgKi8NCj4+PiAg
IAlzdHJyZXBsYWNlKGJ1dHMtPm5hbWUsICcvJywgJ18nKTsNCj4+PiAgIA0KPj4+ICsJaWYgKHZl
cnNpb24gPT0gMSAmJiBJU19FTkFCTEVEKENPTkZJR19CTEtfREVWX1pPTkVEKSkgew0KPj4+ICsJ
CXByX2luZm8oIiVzOiBibGt0cmFjZSBldmVudHMgZm9yIFJFUV9PUF9aT05FX1hYWCB3aWxsIGJl
IGRyb3BwZWRcbiIsDQo+Pj4gKwkJCQluYW1lKTsNCj4+PiArCQlwcl9pbmZvKCJ1c2UgYmxrdHJh
Y2UgdG9vbHMgdmVyc2lvbiA+PSAyIHRvIHRyYWNrIFJFUV9PUF9aT05FX1hYWFxuIik7DQo+PiBQ
bGVhc2UgY2hhbmdlIFJFUV9PUF9aT05FX1hYWCB0byAiem9uZSBvcGVyYXRpb25zIiBpbiB0aGVz
ZSBtZXNzYWdlcy4gVGhhdCBpcyBhDQo+PiBsaXR0bGUgbW9yZSBnZW5lcmFsLCBzbyBiZXR0ZXIg
SSB0aGluayBzaW5jZSB3ZSBhbHNvIHRyYWNlIHpvbmUgd3JpdGUNCj4+IHBsdWcvdW5wbHVnIGV2
ZW50cywgd2hpY2ggYXJlIG5vdCBSRVFfT1BfWk9ORV9YWFguDQo+IEFncmVlLCBSRVFfT1BfWk9O
RV9YWFggbWVhbnMgbm90aGluZyBpbiB1c2Vyc3BhY2UuDQo+DQo+IC0tIEplbnMgQXhib2UNCg0K
VGhhbmtzIERhbWllbiBhbmQgSmVucyBmb3IgY29tbWVudC4NCg0KV2lsbCBzZW5kIG91dCBWMyBz
b29uLg0KDQotY2sNCg0KDQo=
