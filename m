Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD21B808
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766207368; cv=fail; b=qI/bw3BQx82kZuOEDl0qoj7fuJ7CWB9FmGsapXd92xwCtB52dqsAhvkJxVT8VzIy7FJw5Fg0hPbuStKxvKk0ZIQ1pc/TUIgIQkUVL3H18k+JtADwkxAo2Nz/tzhE9rXsee+fsNF0KyhCn73qni8Rom92Cb/0VBHxFDDW8g3F7Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766207368; c=relaxed/simple;
	bh=fWSJCXa2IuXiGBRHtjcR/tBjLoE27E33U2FuBlW9hXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PkpruHM0niRerc+on97cV10H9q2/20vFqFLuwCwYqpxu76RIQSwfyhuAsjBQKPx3PQ91Vae4jE3qlMaEXgERRZO0tcUMrGrn5x7fWClo/xU2yT1yCFY343lON4k8aQLmA7jSqn8UWcLPfaq+gvp8MxcmWXNkU/2QtHzrTwC4BK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cWWtyBpK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=v39/ngLB; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cWWtyBpK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v39/ngLB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766207367; x=1797743367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fWSJCXa2IuXiGBRHtjcR/tBjLoE27E33U2FuBlW9hXM=;
  b=cWWtyBpKhu0YaJIxxhgZE+0rEDzlKMr0i7SrxTCE8rRylyJbpWzxROeH
   VG4pdLLSSViqS85LkllifhTP67rLSISoYogS1HhuRW8rtmIAlNpxyZQgw
   nekP63NCi4VjInrBY9aHdnKgV9WO8/bsrBNckesSwtRnq5/p9WXaVfRKk
   n4DDaQWM9DKKr1HrI8o7wQvnYmGFif1Pxjk0Uwpe8UJ9yE1B1UCk8qQAn
   ghIoo6NzKoZH2/cL9IOlfi0sEPQ9z4vrjbZUGuHVpbmeBqSSyiol7PD2R
   vsDavXnAN76F/OFmB3M5g9CyWKoqC9rMSrc5kgZGPEGHVgvDWchw/HdLD
   w==;
X-CSE-ConnectionGUID: gsS6xljCQb+PcRExb8sZFA==
X-CSE-MsgGUID: cLmlNqIDS/yuq7PcduUgDg==
X-IronPort-AV: E=Sophos;i="6.21,162,1763395200"; 
   d="scan'208";a="138254870"
Received: from mail-centralusazon11010066.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.66])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2025 13:09:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYZgeYJkAV747SyzHmsdC8BdLy72xTzD9rK67/SVx4gff4wgqTusOKLz/AdfopG58jXCjx2ZPrxsdTmOh80/XJSnwPx05P4/x3RImXgmlGmpZWBi93+MYMcWmL4XUo3+eE2gJXGF5KYBcjPBLVeqHQAXEZxPhjJQ+dMDkiQRgwnTTfilGmlS6TluOJ+WGd5SLPil66gWY734NikwsIkfVxxDG0Ei50wzkck/c1xvYJww358f71nebtTZAsHpAhdpr2pUrwYfE+26fxo3kF11NTYMuIqoLJnALp0AtlEhTpa/OQ9dSy/9KkpJp4YHV00bZGctyKYlTjUmxyq+6W2SMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWSJCXa2IuXiGBRHtjcR/tBjLoE27E33U2FuBlW9hXM=;
 b=YXqsjUzSkmYX6QcyjtD+XQCGXoUAsMuhtTuiaiGDGWhZMuI83AuCh50naZFA+7a+HmfoYbBd/VycK8RrCEa4kBHE8DGIEyacCHdJGIQffQGhdyt8kju1Hzhic8QXVHcf4C+lq62FPF38bXbbbWkO7Z6a15nCYIToYj6dSdgyco/lE6S92M5crqKEoSLGIoKpjcPrYi9mP9gu9Pd0UAdU+zyrkywTlOOy8J/Fu79NRDAKRp9+Ufn4bSN72sZqYh4Ype/G63u1oESz0BvBwbPs4c5IPoLWjqa/t15bd9AmbR2ccxw19gUoOyQ5w3sieUgEtPbmKdrKt67i4pztzoHLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWSJCXa2IuXiGBRHtjcR/tBjLoE27E33U2FuBlW9hXM=;
 b=v39/ngLByX6QLB9HEr/LUxXVeWR3pKgokI39/nACXX4co+45uyE+YA+hplaUbQNON2PZsCRGWdm6NxxRsiIETbzv31LBWM6Qn/g0dAWUXe5ovoGtLmMlnheTAjxq+aX5yWTUKXQefCi9QtXEKm/Su7HhWqSEjAMeIS2Rklos+6Q=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CYYPR04MB8877.namprd04.prod.outlook.com (2603:10b6:930:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 05:09:24 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 05:09:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Pittman <jpittman@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] md/004: md/002: adjust per_host_store to use
 numeric boolean
Thread-Topic: [PATCH blktests] md/004: md/002: adjust per_host_store to use
 numeric boolean
Thread-Index: AQHcaVQ1ezLhw7304km/zdXkjvib2bUqCvOA
Date: Sat, 20 Dec 2025 05:09:24 +0000
Message-ID: <daad9131-63af-4658-b419-1d84bf1ccc1c@wdc.com>
References: <20251209213835.2707268-1-jpittman@redhat.com>
In-Reply-To: <20251209213835.2707268-1-jpittman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CYYPR04MB8877:EE_
x-ms-office365-filtering-correlation-id: 32c6f8cc-987d-4e39-d2a7-08de3f85f152
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXRpOHFKWmhtNUhYTnZCa09DcEVrR0dtTWJOT0JSSE1ERWdLSUhyWkZGSmZG?=
 =?utf-8?B?dFhYN3R5SExxOTYwOVhPb1lkd1d6WHNJTEtOOUs3QlY5ZmVkaGdpaXNTdFNj?=
 =?utf-8?B?UThIazBiSXBReFpaai9DVXJFUXN5TXNUMmlKSzlBSFpvUUtIdXQ1WkFZMVRF?=
 =?utf-8?B?MEtDTFUxVTV6aTFFY0hhZVpWN2JUNUMxWGJhUXY2WnpiMlp5SE91V0pQVnB2?=
 =?utf-8?B?VFRreXZORmhIanVSK1NqcUlkZkljc1VObmpqbm5KQktJYkoxQnk0UjFBTHgw?=
 =?utf-8?B?QzV1OC9JS0k3U1JXZ1lVZkNCRVBjbXExNDY2T2oyUFJkR0dmY0pKYmwvcnNV?=
 =?utf-8?B?UDVyeXJCUmxZYTQxSUpRaEkyQzEvUzd6MnVKSHVDMklhV1pMU3hTaG1BRHpy?=
 =?utf-8?B?a2doMENsVjdzTm5QSk9lVFJHZkVlZGt3MTg0VUZ3QVB4MlhLUUZUZ2ExM1k0?=
 =?utf-8?B?eWMxT08zTTg1TmkyZWR5VitpWTZKc3MxRmpwTnNnWFJNaEZ2RXkwaXduWEFx?=
 =?utf-8?B?WVJnYXpOTG4yRmI1amZHYzg3cTFRN1hRRHpFd2xGTzlTTU9yNktRSTMvdzNS?=
 =?utf-8?B?eGk4TlZpQzlYTkE3SzgxZGZzM0NLaHlsWmdCK01aZDluV1RvTzJ3dGRObVIz?=
 =?utf-8?B?SU81d2w5K1A3VDJnanFmVUdXVEZhTUlHZEhVR05DNlJwbmhFeGV5bFkyWVFi?=
 =?utf-8?B?STBzN0VpcVhPMEI1M2JRWEFmMWRUU3ZuajNyMlFnWWwydkovOTI2YjIvRGhO?=
 =?utf-8?B?a2dCWkFDb1VFS2JTV2dub1VjK0dnWmVIY1o2RjJacmtJQVVzRDJMN3VDSS91?=
 =?utf-8?B?MkRtZlJ3R2hHK2k2dkFaUHl0VHlkTzBnVFhGalllREN0S2NseEpDaDQwSHdB?=
 =?utf-8?B?VFpMOStaTDkwdDZ0QUpOWUFoVVZ6VmhzNG1SaDBsdGFCc0ZzamxLL2FyTzZS?=
 =?utf-8?B?V0h0RmVzb1ZhSnZZeFZsTy9Nakp3a3JyVkptZkUwSWNjU0Z6NSt5c0lYSElr?=
 =?utf-8?B?N3ZXSVRPdmo3T1RQU0RhV2lvQXRPajB3QitmSEVNUzViM1ZNMlFhYU56NzlR?=
 =?utf-8?B?MU9rVDE4eElyWUVVR1hmNFRiRjRvemNTVWVQOHZTNGVidFl6VkJsUmI5VUFj?=
 =?utf-8?B?dFA3WmM3VkM2RExia3hWTm4xbElrbmRlbENRbkMrWEI0Q08rNk44dzNybS9S?=
 =?utf-8?B?TDA4V1d0VGEyalFrKzJoZUVXOW1EeDVWK2tucFpLaW1tYkhlNnp6Z3NvVG9H?=
 =?utf-8?B?V0syemk3bWxaZUJYSDVYaUVkb2dwdlFXTkh4UzBQL3dwQTFqdjNmMEx2YkIr?=
 =?utf-8?B?VzRMVmJrckFaNVp4YVl5Ym9KTzM1M3paMzhEL2VLb2VsZzMyYUxXbm05WnJB?=
 =?utf-8?B?bDdJSGUvRWhIaXg3NEdSL2FyS3NxWlIyYmduUXRPNjN4T0JrR1daRlVnclM1?=
 =?utf-8?B?ckV5aFd3bnBpY3hsdklCekd1bWsxNTIvcllMRXFzR3cwajQ2Vk5sQmNOQjhn?=
 =?utf-8?B?WTFjMU8xUlAyVzdDWGZnMDdkZUdUeHZpLytGYWYrdzdyNWc5Z2dNR0xpYTV6?=
 =?utf-8?B?YWhnazc5aDg0Lyt6ODVHSmdrbXFoOCtJVk1kODlETGg3NXNwTUEzdUZkOG8x?=
 =?utf-8?B?S291b3ZLMVh3bUIrYVhvMnRpR2FWR2M0UzNZaXFnTUF0ZDlXdTZVZkFxSW12?=
 =?utf-8?B?UGU3VkwvemtTT1hyTldFN0VYZG9JbXpsTjE2bTJTY05SMW9TdEkwdzVEVlJE?=
 =?utf-8?B?aHh2NUEwVklPNjg3b3IxMXJtb1YxSEw4dldoUDNKZFFNVVB6elFGcm5NVTdv?=
 =?utf-8?B?NUxDRGIwQ1BnR3lVMnUvVlJIOUl1bDNuSmNDeG5DemdRTGtPckZDL3RGSUxa?=
 =?utf-8?B?ekY4OWt0OXUzT2FXQnJMQzdDYTZsNjRsSkFJSW02NkRzNGdnNURlOFNZNmx3?=
 =?utf-8?B?cTNPcXFueUFBYm9MVHprbzJmYVRaZHlLQkpodE1kTGYwNDlBbnVmRXZCODRZ?=
 =?utf-8?B?YUYrUVlqMXdPWm9kdm15VmxNaDRZUDl2dEF6UkplbmZ4cDQ5V29PS0QzRXQz?=
 =?utf-8?Q?Vmj8J8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXZJNlBsY3pjZm9HaDJNUTVuRDZUQXM4VjVhYSsxTDVXM01YalA0cDFmbzRM?=
 =?utf-8?B?Y1lnK3FPSXZQMHNsTW5lZ283cXVFdTlMZjNZd21rZ1JLUHkrYUE1UGNVaUdD?=
 =?utf-8?B?YmgzR2tlcVRKT1R6cFdYYWgyVzZiZmpFS0p1M3d5Nk9sb2hPS2JJZXIvNlVG?=
 =?utf-8?B?MlB3WEVZZzlBSzNkdURuZzh1K3YwOUJWeituQW03bjFBc0JlSXpMaEQ2SE1J?=
 =?utf-8?B?U0l0aTJ4cmc1ZFQ3ZS9wcENuU2RnRldkUGJVQldhTUtvY0FkMTNlU3QzMzlZ?=
 =?utf-8?B?WmttZkxOU3RtUlNzWG41T1pVTXozZVlDYW1XUytNWC9MZEwvRGJZNzJqQzZL?=
 =?utf-8?B?RHl0WXZ2KzVRai8yWnlxUFJ6SFhNeEVGK0VJWDdWQ0lRK0RwUlFBTUxBdE0r?=
 =?utf-8?B?NFVTNGlsOElndGZrcXI1YkdKTXBqOElUTlRzRG9OaWNqVEMrMHZLL3cwbzlp?=
 =?utf-8?B?OGU5dDI4cEtCd3V4MnJZNVpPYXdGVkZtQUZRc0gvRzFzS01kbURDT08vY1Z0?=
 =?utf-8?B?SWdlYjJ2RWFMWGVNKzFPVHdwajVHS0s0dURTNmNNUjRJQW5BWEp6ZVgzcWdC?=
 =?utf-8?B?WjhLeENSOU9KS3FkK2p0Wnp4eXQyUkhyQzIvaTNiMWM2U3ZSR1BwVnlQKzJn?=
 =?utf-8?B?akhyYnhLVGxpWVFFUEhKUzUvQ2JkR1djVFZrSCt3bis5NUt4dW41MjZmd1N1?=
 =?utf-8?B?WUJCVmRkY0JCSlZaVGNVSEM1RTZSUnAxa1F4NHpCd1FlRGFMY1dTZUJhdGF4?=
 =?utf-8?B?UlQwU3dPKytCcDBQbCt3bXlIUEY5T1pUSTluM3JFa3ovN1RhOUkvZm5yNFpY?=
 =?utf-8?B?L01DMTVUc0hqUldTVW1GU0phYktsTENWZmg0dC9JTE9RMnJrYVlTRVRId0pM?=
 =?utf-8?B?eEQ0SzJHcFhLUUlqZmtVYkxzOVVXNlRCV0Jjb2pGVkliNkc4V1ZaRzZ4THk1?=
 =?utf-8?B?a1RIV0pPV0lQelZWSTBhT1Ezbm1iZUxNenJqUGpQd2pqc1lUT0NMN3RWTjQr?=
 =?utf-8?B?bkRoQ0d6Qy9lK2dlVTUzT0tDQ0FHZ2ViZ3A1UGNJbm5wMDBUMXhXNUl0dUpP?=
 =?utf-8?B?V0YvQlBYZWF2ZnFaM3FsRU1jNEJxYWI5andwUkNIcmZIUGovWjVMN3NHOTcw?=
 =?utf-8?B?SjducUFockJmRWxRQkkzbkh2NUVOWnJPU0htOU5hemxSTkMvOXBvQWZnZFJV?=
 =?utf-8?B?QVc0d3FtUStGWWwzSlgvVXhEdllNZHArSFl6M0MxSUpBK2g5b3NpaWpOZkp2?=
 =?utf-8?B?blhZd0R6Zm8yUmhQUG9lU2NNK0U0MytHZEdlbHNPRXRBVFZsNTExY0h4TzBs?=
 =?utf-8?B?R0NWRmtpVVZZRFE5Y3RQRDNuUmd1eUE2L3JlS28vWWxhaG1oTXJ5R3pud0pz?=
 =?utf-8?B?aWtUcGloWE5IUTFzcmY2VkpQUk0yMGRUZzFjdXZ2eFQ4YjRXMG02TWZHUVVG?=
 =?utf-8?B?UDZYSWwzSCtJNUMyc1p2SlFOQzBzemR2WjQwb0YvR1RONEFqdVZJOUNVa2Fw?=
 =?utf-8?B?cjBQWDRGNGVrUE9DSDRZRk5aWkxuMlpZQ0cyQWg5WmNCRkJjK1VDdmdXaTJr?=
 =?utf-8?B?TGdMWTBCMElUUmpqVUhSR1VzOG5mRUwyN1AvMytQaGxQV1c5NTVmenJQaFNO?=
 =?utf-8?B?ZG8zVTlua242N0VlMWtQREc4TGtzT2RhMHNDTzNBRFhnS0hlblljMDBhTTM3?=
 =?utf-8?B?QldNN2h2QllDenY0QlQ4R09oTWQyVG01N3E4cFVvTVZoMUJtMnpPOUJIbEtK?=
 =?utf-8?B?MmFmVDVMVVZRZUVjdTlMK3U5N096RzM0WjhaWFhrQmxxTEVPWlN6bUNOU0hG?=
 =?utf-8?B?eUhLOCsyVFlnUnVIT0tBZFJubXBBNkpRZER1MDJSNXlXYUdtZTA2REJicnUr?=
 =?utf-8?B?ZHNLUlNzY2t1Yy9GcDV6RzBIaW04L3F5cllnY1FNUXd1enZpemNaM0xuL2F2?=
 =?utf-8?B?WUFYL08zZ2FEQ1pLWlI3Y0U0RnJ3Zk1hdGlDYWYrWGhWL1pyMUQwR2FOR2Iv?=
 =?utf-8?B?NnpuemgxaWNDZ1VyVHJ5RVpCaEI0bEg4NCtZeVlTR2FobW1Ndm1NdDEyY0dn?=
 =?utf-8?B?YW5IcmlaOVNmL3kwVGtBaUFnSU5YQjluMWs1OEkxSHhOVXZ4Q1NZNDZzaXYy?=
 =?utf-8?B?QmRsbjBKa09pUEtuZGlHUXdNNStwSzMzd1dmK0dBM3BJdWtaUDBMU2lKN1h5?=
 =?utf-8?B?NTFjaW1yWUdiK0FtVW03L2I5SDZmRm1WSzZIdEkyL2VIY0l5WGRXakVrdlh0?=
 =?utf-8?B?bkJlRnRlcnVuL2xibjIveWNtcmM2WENKWi81Q3ZXYXNCNzcwQkI1N1R6ZFVI?=
 =?utf-8?B?RUJZTEN5cWVPblZVQ0dOOWpMU2xoQU9sdDRvUDhFUDd6bEpZck1QTWprbkhz?=
 =?utf-8?Q?ITHKQjufVPDAEiD4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30363DB6B121824996AD8CC74C6FE258@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DsSgPfaO8YwIkkgILzem2RWs/QnTR+o+68gn/Slhyfr2m8vdLKMIC6meL6eBqhdtQaLB9WlMi/PKr4rNkCItB9h2J0EOrpK9MvmmKObDClkTX6jAVdivdlRfPFlnVJwGFUIbom2gUEhZDU3+4XcAVnaZ09hRwgkPgjAF9eDZ7tFTbRk6hAb90NBVqX60AXiDmoSQeKT4B+kO7XvijkArADskH9r6M5lW+vqyc8n5H0rVtGNaANOgLuRqWDH1UKbvh+Wvbnj/+QDWtI/Jvtdq/CyESibrv6IsPc/qv19p5se4zgxEREUjajbMI8HeBivyJ099knjfsKWl7LOJEiaLsoamn2lFm+UG3BOgnKFDY2kE9aQKH+guet95mtk6AzR1VAGoYVCNi+JeMVNhNEFsXtvyzJrO5COTlKnKs4WkOIQK3ooweuURESxXSNySFYTTBoO+KRThwbcbeY0eCjqeeE6dZuhUEbywxkgW5P02aIuNHxGgEv9AzfebW6eHyrKn2kRGdc0UYPdkMpT9fYg1H8z3+Z9Z4iyYR7i7wnc+QaitRXH/oLBxG+Wg3q2ooPh8eZI4nI2tMVZjZ9c+Oq66INHtHdLXx0lueEHxm3Oypfe4JFRO24BfxxGV4ms3+Hvn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c6f8cc-987d-4e39-d2a7-08de3f85f152
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2025 05:09:24.4938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1j8r4RgGPgWjF/y6tGwNoOLRIxtXCzRmUtlWqzmwhqEz87zbEp2/JeQ2SAYyzLmY2Wehr+60AAd4hwIUzZWeCfTkGiRx0Yan9UTUOjVFUrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8877

T24gMTIvMTAvMjUgNjozOCBBTSwgSm9obiBQaXR0bWFuIHdyb3RlOg0KPiBJbiBib3RoIG1kLzAw
NCBhbmQgbWQvMDAyLCB3aGVuIGxvYWRpbmcgdGhlIHNjc2lfZGVidWcgbW9kdWxlLA0KPiAidHJ1
ZSIgaXMgcGFzc2VkIGFzIHRoZSB2YWx1ZSBmb3IgcGVyX2hvc3Rfc3RvcmUuIEhvd2V2ZXIsIG9u
DQo+IG9sZGVyIGtlcm5lbHMsIGtzdHJ0b2Jvb2wgaXMgbW9yZSBsaW1pdGVkLCBzbyB3ZSBnZXQg
dGhlIGVycm9yOg0KPiAic2NzaV9kZWJ1ZzogYHRydWUnIGludmFsaWQgZm9yIHBhcmFtZXRlciBg
cGVyX2hvc3Rfc3RvcmUnIi4NCj4gQ2hhbmdlIHRoZSBib29sZWFuIGZyb20gInRydWUiIHRvICIx
IiB0byBhdm9pZCB0aGlzIGlzc3VlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9obiBQaXR0bWFu
IDxqcGl0dG1hbkByZWRoYXQuY29tPg0KDQpUaGFua3MgeW91IGZvciB0aGUgcGF0Y2ggYW5kIHNv
cnJ5IGZvciB0aGlzIHNsb3cgcmVzcG9uc2UuIEkgYXBwbGllZCB0aGUgcGF0Y2guDQo=
