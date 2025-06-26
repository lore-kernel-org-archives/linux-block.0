Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192F2ECE8D
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952011; cv=fail; b=lpCGSrisaToE6Vfu3ARpD7lLOyG6dtEzLXCgYht7Qt+jD3iK00P3vd6hEpjRz/Q5dTaA/WXBLkh/tL484H2myAsyTHVMc+1wtBC1Ri97sT5rxGmL2w1YEdKvvFpgOfUP4maqQIkMtl1KahumGk/RyEN4Xlpvb23nCS2LU1FNt6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952011; c=relaxed/simple;
	bh=DmFcoB2AzkQDKePatCQX2p5ffZxyQ/RK4h8s7CkewgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VA3vZuqygIhHcTFHbj0fFii5iTjP1za9bzA1VuJKhIopF4fInGLLQGMftzeYxxmL/3EcF5YMBoxmzpWDkf1BSrGXiOeSAPSzYfSA/p28tl/10ZXom2xalABLKPQfNG7CmP6Mg+Xu2Ao75Gyq6AKrgl9dctpyJORJQRPcYinkshI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=epK1yYyc; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="epK1yYyc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3fzBNMv6YmjAFvi6PG2DB9VGSWXOE/t2c8H72Os3xLOgjVtCgWHyjsmAY09iiwSAeCwQAvlpVPBm/K0ZRGeePFjaKt4r9CU+GDihaFau4QksbHVhzr868q0Uf57/ciVg7zACa+ABW929+0Igac+um3RKafvI7FTXwm3AJSbF67OseX1z9zREgzj7ZRFUA5v0JSJVRG6j4bl+Rdu41QOncx6/8BsjdJIWxZRwIwPFtrqzKY0x0HkjVMrtRvA8X/uPw76k3E+DpD9XKmXCfvssh7AioW8L+Ui04p8iEB9KXXfTjj0oYeFloIEGtH674T5UbTGm+qZg2luTj69CyRdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmFcoB2AzkQDKePatCQX2p5ffZxyQ/RK4h8s7CkewgY=;
 b=tsiEezYfJModI9lO+Cp5xemvgKeB6/TlP1w/hYsg0HHr0DMOdpdm6KbfTp2rOn6AZQJejLOu9MJmSXGPO5geTde5t4IiiV2N99pTMAsusdFHO5vItTL0fYAuzFbOy38qkTVHb2m1zZgu8jdt2xVSFTzBCpAecaa4XC+7VDHt54eXy9TdWIKDBX3tpqgcWeNPqo2V5W/G3wqFhof6iJ+dPsNVIsnP9SZaj3VqRaNnVzj05fWusUpeSGwrlouTplgtz16GCki9idNfPzn6DLUalfsS/uEDO/SWDpSc51nxuToBQgkjkQ+hHtnOrHzCzMwDcJCJRcsZ26uBCgGsJpccJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmFcoB2AzkQDKePatCQX2p5ffZxyQ/RK4h8s7CkewgY=;
 b=epK1yYycMZAlVOLcmVPgJYXDKwnnbptxt60NLdAP2jFdiLAAwY50dLoUMmndqujH37tjcgVx6kFxwcqyPpuBK16q8ussQcS8p9TiL3GLIdNMURSAfnT89JNBiEXueBnZWxOFXu8i5XMm5V69Penm+uC4GleU/9Z4NDTl2tB3ny3z4ERIXjsrgXurQqE+jDzMErI9Un73ozPUAx6qz639xfNTR7HQyblakfhySNsHmJI0lmWv5tnkoolIJ7d+lJo6fEfzOAudSonLoMht9UzfbBOHG0gH1l7y7IZtP+tCfW9fVjeRFM87cNEaiOezUtYsCCYNocBx8XG6QqqtMgHBIg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 26 Jun
 2025 15:33:24 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8880.021; Thu, 26 Jun 2025
 15:33:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Kanchan Joshi
	<joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>, Nitesh Shetty
	<nj.shetty@samsung.com>, Logan Gunthorpe <logang@deltatee.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: new DMA API conversion for nvme-pci v3
Thread-Topic: new DMA API conversion for nvme-pci v3
Thread-Index: AQHb5cVIubpj0SCqHUO+y4Ky5LS4GbQVk8QA
Date: Thu, 26 Jun 2025 15:33:24 +0000
Message-ID: <bcdcb5eb-17ed-412f-bf5c-303079798fe2@nvidia.com>
References: <20250625113531.522027-1-hch@lst.de>
In-Reply-To: <20250625113531.522027-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB8420:EE_
x-ms-office365-filtering-correlation-id: 98db31ff-6c7b-43e9-553a-08ddb4c6ca38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?elVzV2gvdFJzbU1uOVVxZ2RmMk1RMHhmTUphcTFvcGx3YXBTYlZPN0tvQW9T?=
 =?utf-8?B?a1BTVXdKQUYrNWVadlJHdW55OGpKZFAvT1pUU3JsN2tHV2tMVTVLN21XUkVk?=
 =?utf-8?B?Ykt1STQ5WEw3aTNkdWlGQ2VLSVdGUFg1YzJjY0F5dnFNOWFvd3llTnYwd0No?=
 =?utf-8?B?ZTFqWEszVm03UktBelhPTzRCWWIxU3BjajlLTXJXcFdBNStHd2hpS2NXRC80?=
 =?utf-8?B?V1V6Q011STZqOGJKZVBTOCtyYVFzWWRKMVVVRk5IVklueE9JdFpTS1lzOVRt?=
 =?utf-8?B?TDRDV3JFSm15Z2xJc2pSYmM5NHVESnAvZGhZM3lPNVdIVjhJeFkzOEFTakVK?=
 =?utf-8?B?c1ZCQ1lYY25CaGI0YlQvOFJCRE5nZDRseGQrQjZEQnRxeFZVMnhOMDdlSU9C?=
 =?utf-8?B?VjhWbjZMdE9COWk4R2hIcTM3YjduVWdqL3hyUjA5RGV1NGhxOXBPTzd5cTE1?=
 =?utf-8?B?MXJ4Q00vKzkrNXkvUWw0V2YwcmlUcTExTE15ajJmZ0tiQ1Z0dkJucy9QWDJF?=
 =?utf-8?B?TjEvc3RLM0hvek9sOENrMWd6MWtXQTlEa2h0WmFYNmhPNTh5YmIrbHBnQjYr?=
 =?utf-8?B?d1UyVlQ3UkNreEZneFhTOTVFenduQTgrcE02K0IrVHJWNnlmelNxNnVJRCsx?=
 =?utf-8?B?c0FZcGFHMllIYXNCOHAzVmd6dEptK1prNnZ0Y2picjZaQWdnQTlTWnhsRENy?=
 =?utf-8?B?bGNOTkpoM3U0QkZiTzBvWlFSNVdpWFlrbHBWM29tMGdZSEl6eERxcjZzeWN3?=
 =?utf-8?B?YytyeEZ1RThjWDhicHlIM2tGNG5ST3RNT3FYZk9GTkUzejlud29VbEVxeXNo?=
 =?utf-8?B?V2IzOTV5clFXOGVTMno0dG1OZ3RhRGt5ck5wczg0ejFsRTJKVWN2S0w1ODE1?=
 =?utf-8?B?cnVIV1Y4V1JMVFFJY0NTMlhKZXl3cFF3MnhVWWt5RU5iY0JBd0FQUHNYQTZh?=
 =?utf-8?B?V3JZWUVOQVVzRkJLeUkrQUZkR0tLYWFPbGRta1RXSS9LSWVOMnl0OEFYTVJu?=
 =?utf-8?B?em1nbDR6R0ZLU2pGL0R4QVpUdEtBbWQvRnAvdk9hWlpTSllrVElON2RMOWJo?=
 =?utf-8?B?M1plRUFOMzBqM0R3a00yamlLQXBJRE42a28vVGxtMDRjWVpCc094YUhkNWpw?=
 =?utf-8?B?SlRGSkxHMG9tdHlUbkFaQlFqTmFBemF5RFB1ZHdRWHl4eDBnMVBvbEp6UWRq?=
 =?utf-8?B?eUVCbVpxS0FNOUFqVkR4eEtaS1NpT0NPUEpoZ0F2R2ZVaEpHemJsYjQwRTZG?=
 =?utf-8?B?L212Q1RYNUk4bWx4L0ZUODRBYVhBTkgzN2EvbXZ5dEpIdTQ5ZTY1RFpaQVlv?=
 =?utf-8?B?SzU3Q3kwa3JpZWNORTlMVnJVUllQODBrYUlDTnZmOTZsaEN0L1pyUkpmM0pV?=
 =?utf-8?B?YUF3VFVnZENxbEk2L2FmQnVHL29mK0ZYN2V1Y21JenYrVTQ4SlJ6dVRKVjds?=
 =?utf-8?B?RE4vLzg5OWtCUGw1QWV6Q2M2SXd6NG1xZlJUS0drWDRZOVRvTG55TXUvSTly?=
 =?utf-8?B?NVo4RDByWWZ4QlNEZWJ0cXVmVUpBVFhMZzIrTW42bGQ4RkhxZVJSMnE3NlZI?=
 =?utf-8?B?b0NwUGRVUEhlbzY1dEt5TFJGeWoyVTRmZ3A4QXJ3SXZ0bHBSaTVvcysxbmQw?=
 =?utf-8?B?YTZxRWhWc0NUMVVIUExzNGVMTUd2cEhaT2ZWYlF5ak9HY1JaL3hlL0YyZEVs?=
 =?utf-8?B?MUFWS2xaenI0bC9rd1pNcVZ3bTMxUE9zSTVNMkVQMWdQMWUxWFdhWm5Bdkpa?=
 =?utf-8?B?dUxKRFZSMlpnbW9pZVZPOEI0eWJ4ZVBKZ0RFK2w5dk92Z2t4YS9kTGcxVU5D?=
 =?utf-8?B?eDZveHhBOWVOQk43V2g4OEVkem8wOWwwaGRuVzMycWFuK0FmZHVScXpyblpX?=
 =?utf-8?B?YUkycEV5WXFOcmdaTVMwTm15K0F0L296MW01RGJQOUdkTXVnZzRJTFVOdEJM?=
 =?utf-8?B?STExelFkaGE2MTdVWC8yenBzVUZQMDJGSC9kVUFQRmN4L2NMQXFUSHJLdXdp?=
 =?utf-8?B?S2x5QzNRUFV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmlSR2NaaStLQTl6bXV2ZnRmY0sxTkVQSlV4Sm5KM3UxZ2ptcUxSNURIRXR6?=
 =?utf-8?B?ck55VHlacldSbUhCTzZUSU02V2wzV2Vub2xUdUxrbmhkQUxQc1ByMG1iZllH?=
 =?utf-8?B?UGxMZ0I0a3R6Q3l6SHArU09aVjZPdmxIbWtXd1JwWEEvNkxpaElUWXBWdkN0?=
 =?utf-8?B?b2pOMzQvK2NVaEd3QjMwMkJ0b21mRmxiRmV1blh4WWVkWDE1c3NMVGNxV3Bq?=
 =?utf-8?B?bFV0T1VkaVRzdUsyUFU5U29BM2owbzdSY0g3dDlGZlZPcFY5OGZtNkZzd2Vv?=
 =?utf-8?B?cmRtb1IrN25aYXA3SDJ4R3JGRDZYanIvRi9ZTXQxL0ZHNE54Tzh2bEhtQ1Vu?=
 =?utf-8?B?Q2Rrb1RQVkpMazF3UWpWNkxEa09jNlJLOG8rL0tYSG5PZithS1lnVjBiNHRV?=
 =?utf-8?B?TUJlZEM0Q1JoOWxJZ2pHZmxoNGFhRkl0K0pjeG5iY0JzZkd0NFlNcFovRFVo?=
 =?utf-8?B?RWo5ZlZEeE1qTysreDQ0T2xnajkvWTJHK1h1eWJtN0p5YnliMlVwelh6elhi?=
 =?utf-8?B?aTlWM3ZMVlcxcFBaNHpwWjRxYis3bmF5eEhXTG5QajRLODMyZlNWc0tDbVU0?=
 =?utf-8?B?VGl2QkV5UVhNSStBeXJQOHJNeHFNZVUvUmlKOVJ4OS84Ymk5eWNiMzBEdzN3?=
 =?utf-8?B?YUhKa1U1RnZBUFgrS3VwR2s2ekV6RERwa1FHcTBKVVZWNUkwVjhsclV2MDV1?=
 =?utf-8?B?aXk2VHZvV1NyS2xhVjBWaDZwZ0VuQjZkeWpjTk9CZXRGcW9VejY1UGhHN2xi?=
 =?utf-8?B?Y25zMnMxWXdJRHpJMXJSQ0dsWjBCOFZ5c3hmTHhwQTNQV2ZYdTVhUzFMUHov?=
 =?utf-8?B?V21FL3hleXVvRWhNQTdkRVRhcDZHYml5ZytQdStjZ1kvWXpEMUFabnNIYlJj?=
 =?utf-8?B?d1p1RFBrMy84ZzQ4ZmJmOG1lYWNKcGx6dWZqT1ZIcUlUUHJ6OGNocERrRGNG?=
 =?utf-8?B?TU1YdWo2cUFhZWxNdjIrR2NRbXNpaUIvOHdMcXFGdi9ldVFHYlBkSWFCK3lu?=
 =?utf-8?B?NnRIeVFwdVpTWUQ0Wi92aGh2aytNRDA4Q1ZEZnd6ZVI4dnc2UUFqeWpBdnEz?=
 =?utf-8?B?Q3dOTVdGSWFLNDdURzVjOThMSzgwZUFVRHVTY2JWN1FWc0g3V0E3akI3VXRU?=
 =?utf-8?B?N3VTKzJrUGtBcCtZbnlVNFBpUWpCeWN4anA2c2Q3UEZqTUxWdzJlMDM3bHdG?=
 =?utf-8?B?KzJ4Ry8wQlQwcGtSa3dYajRmZmVaWFVoeWdRYnZFdkxIZ3JNRGpDVHVrelRj?=
 =?utf-8?B?Zy8xWXpaMVJmQ3Vqb2FTVkpGcjJIMWRTSjdvc2FZa0VCM0ZnTCswQVp5S2tH?=
 =?utf-8?B?cG1ySkNTaEFMRUw4RXpFcERYejBQcjRhQk84aEZSbVRUMktUbTV6bzR4Rmlk?=
 =?utf-8?B?L0lSaythNE1TdzcwRm9oYzUxMEhNdzFYZllaaWtDOEcwR1Nla0tEZThxQUNO?=
 =?utf-8?B?cGJkdUpqemhnL2wxSjVXNXN5TUlmZThiSWloQnUvMVF0WEphc09XNXV6dk5U?=
 =?utf-8?B?dnlXRXZ5NTBIaVFjZ051WmRXcDNYM01vdHB6K1V5QzRBWklFR2pPQnY0TFNl?=
 =?utf-8?B?clJ2alBQWVhzZFNVZGlMa01USHNneWFabUVLME1oZDVNcWFLK3NiOWhMdXJD?=
 =?utf-8?B?aURFR3FGSDNrVjlZaStEaWhlOUZWeGhXb0QvR1F3Y1N2aVhCSkFrQjhNZzV5?=
 =?utf-8?B?c1Z6UkpROUM2VnB2RkxtV0tlY0gxTUlmV0NIQXdSbURjMGJDUG1kVjFMdmxn?=
 =?utf-8?B?U3ZKRUY0cGF1aW1QYWR1OXBET1RESVVKZFVLdENHT0JQR2hTczk2OE14SVc2?=
 =?utf-8?B?SzNpcHVMMzQvY1U5S1Q4dGkvUVFFY2JjUTJZSyt5aUUwKzExbWV4V0N3ZGlq?=
 =?utf-8?B?UlN3NWY2VkxrTnlSOVBRR29XMGNneEVIeG5Ua3kvZUtJWW84WGxjWU9WY1R5?=
 =?utf-8?B?cUZ2bE1zV3JxeTMxYkRIRTZHaTZBQkhtZTlkNXlNWHpLU24zTG9HK1Z5a25k?=
 =?utf-8?B?aFJMTDVxeDNheGhiby9YaWtYSW02MHp2N0NmV0xBa1pqN3dDSmk3WWJzMXVp?=
 =?utf-8?B?L2RQZFBTMnVZb0oxbjJ5SE5DSzBSY0llcUVLaHo1NlB1NUJ3V0k3dlY3c1NY?=
 =?utf-8?B?eDEyeFFEempPSDVqODZDNGJidEZpMXJVRjVPaHRqTUJNTThjYXJZTmo0QXZq?=
 =?utf-8?Q?EjmwAtxkUoR5dGBX8QKBNGbNWLhV6DIGioVuYYmP6XVV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E1267043AA02D4FA6C489CC65B762A7@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98db31ff-6c7b-43e9-553a-08ddb4c6ca38
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 15:33:24.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYwiHXHSJNdvno7ARL4f+ObBABDjf4dkf/JhjrkOQvm1I9pD+a5tn7NyoTpkNeFHX4MLjW/JnvpNawvcXjH3qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420

T24gNi8yNS8yNSAwNDozNCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEhpIGFsbCwNCj4N
Cj4gdGhpcyBzZXJpZXMgY29udmVydHMgdGhlIG52bWUtcGNpIGRyaXZlciB0byB0aGUgbmV3IElP
VkEtYmFzZWQgRE1BIEFQSQ0KPiBmb3IgdGhlIGRhdGEgcGF0aC4NCj4NCj4gQ2hhbmNlcyBzaW5j
ZSB2MjoNCj4gICAtIGZpeCBoYW5kbGluZyBvZiBzZ2xfdGhyZXNob2xkPTANCj4NCj4gQ2hhbmNl
cyBzaW5jZSB2MToNCj4gICAtIG1pbm9yIGNsZWFudXBzIHRvIHRoZSBibG9jayBkbWEgbWFwcGlu
ZyBoZWxwZXJzDQo+ICAgLSBmaXggdGhlIG1ldGFkYXRhIFNHTCBzdXBwb3J0ZWQgY2hlY2sgZm9y
IGJpc2VjdGFiaWxpdHkNCj4gICAtIGZpeCBTR0wgdGhyZXNob2xkIGNoZWNrDQo+ICAgLSBmaXgv
c2ltcGxpZnkgbWV0YWRhdGEgU0dMIGZvcmNlIGNoZWNrcw0KDQpJIHdhcyBhYmxlIHRvIGZpbmlz
aCB0aGUgdGVzdGluZyBvZiB0aGlzIHNlcmllcy4NCkkgZG9uJ3Qgc2VlIGFueSBvYnZpb3VzIGlz
c3VlcyBzbyBmYXIsIGxvb2tzIGdvb2QuDQoNCkkndmUgYWxzbyBjb2xsZWN0ZWQgdGhlIG11bHRp
cGxlIHNldHMgb2YgdGhlIHBlcmZvcm1hbmNlIG51bWJlcnMNCmZvciBkaWZmZXJlbnQgYmxvY2sg
c2l6ZXMgdXNpbmcgaW9fdXJpbmcgYW5kIGxpYmFpbyBpb2VuZ2luZXMgd2l0aCBmaW8NCmFuZCBk
b24ndCBzZWUgYW55IHNpZ25pZmljYW50IHBlcmZvcm1hbmNlIGRpZmZlcmVuY2Ugb24gdGhlIHNl
dHVwIEkndmUuDQoNCklmIHlvdSB3YW50IEkgY2FuIHNoYXJlIHRoZSB3aG9sZSBsb2cgYnV0IGRv
bid0IHdhbnQgdG8gc3BhbSB0aGUgbGlzdC4NCg0KVGVzdGVkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
