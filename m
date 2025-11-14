Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A082D0605;
	Fri, 14 Nov 2025 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763096217; cv=fail; b=aaYdiSTcflDEKMA18BKYSs9KLoi1Rz66SqpXGKTSrV/fpuYfFMAVrr4ALKmkJvxHbb+xp5HPkF8XVT9LBTZjvPEb44ptesJcUmzhaRNHnPldKNADGgXDtDMY7c+hj6FOnE+/8J6fpt5r9gSelswnbYNNIqdNaFJKH7KxEl2cmUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763096217; c=relaxed/simple;
	bh=DlewJGLpHWbpEBzsJijkVS9XFdngl6QSvKmN/YrI9Wc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L2Z0zk6NElMA0KDoz7kh0WsNM3Ta23w0dXVimEjDIG8avzbOp4+8U6e7E72O5+hoDkV1QAj/oibbfFOV3Sf3cy8mm7b1W4KIbb5N4B/yBqKf5J5pCEAHMSIol6SCPMJAvPIDtr7VeJLZG46DeGy739wJEYy+u+M3V+zwCViquZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tUbvywDp; arc=fail smtp.client-ip=40.107.208.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tUbvywDp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiHfh+Ou5FfnccTkIch/VIsgKlI0UNqzQMis/2DiotzXZsMOyXTc+8nas/4rTGYqAWphk2QTS9bS1g/p2Ri3m3s0fnFmZDLcIDbs1D8TFBRcCno0+Qegx2gC46wLtfkhZe7cz3a7DcwClVIZSMwjCWiqksytXnrzrLHMH392AW0Xw6NCktutR9LF8ae2SrZcdDezAyAV51oWkUiLq9/KtuWQ0iOIChjWLKl0dvcJIkHONXgOT2DCKZfGYsMRkW9D4ddu8/1swiHewDaisGDBTy83zd91Cxy9HfFpGJ66EkRi6tN3V7pDRAg7lhaDY68jcl+khaMaTJpURt2ZLsNFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlewJGLpHWbpEBzsJijkVS9XFdngl6QSvKmN/YrI9Wc=;
 b=FxLJGr7MAYlwYMp3RjU2qJo5DjpnNhEZDVyazMgoF+y9UAMqBgREmU59zH1WANpjTzDnhnrax7cu4FVQBGcSt14i4iBRpVAv/XQu1w9wvSOYDzQ0xP+iJFrexh2U4f/w+JiKRGqGEtYZINwf8PRWkGo4Q3+olUEaiOrDOYybnNR97o023dUsEc1xDLl05im+vNz09MvQgEIzZHTZXoPipQky9O8k4R7Fqz9dsy+Mnokj9AgyxKTVO5YSEOT2lET2u/bkbsGKWW1H4hQ3e8fxAd3AFYAZtgUciaXnyv/LuyOz4NbMOZUSkDNL8X3BnRdLsUxkSHe/ZjUMVH+bLZ7Tpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlewJGLpHWbpEBzsJijkVS9XFdngl6QSvKmN/YrI9Wc=;
 b=tUbvywDp7mentl6O0ogMvbS14fTbem/oftPIE0Zu4iDC1Ugsxeae0cxrh62UMpNmFzCSGl6apeIqN6grFmm+YptRPEgejgq7+cUpkWn27HcE9+aDRF60i1oXMmxm4KFIn6hqpj+nXMhnBMPOqNjJR2RR2EF8sHkaCVZf9dV2953Lkr1lc3AVM5El1ukLZjuMn1xlUyq1mg//FonCZbA+BJzMWfMYqrOUN+O3fiaO5MAEyCAKsKyRnKuvWio9j+mfHF8VspY1V7Xrm72+UPdfpjes9Fudr4UXCtBlBrNX2UP018aW38GfvZLaXX5q0PEFynss8kInnOGr/JdcLVcJqQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 04:56:52 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 04:56:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
CC: Casey Chen <cachen@purestorage.com>, Vikas Manocha
	<vmanocha@purestorage.com>, Yuanyuan Zhong <yzhong@purestorage.com>, Hannes
 Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Convert tag_list mutex to rwsemaphore to avoid
 deadlock
Thread-Topic: [PATCH] nvme: Convert tag_list mutex to rwsemaphore to avoid
 deadlock
Thread-Index: AQHcVNtkSeCFlU+DtUiP4jOBVXj28LTxnHaA
Date: Fri, 14 Nov 2025 04:56:52 +0000
Message-ID: <e629ec9c-9f25-48b3-8fb4-1c94cf83604b@nvidia.com>
References: <20251113202320.2530531-1-mkhalfella@purestorage.com>
In-Reply-To: <20251113202320.2530531-1-mkhalfella@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB7479:EE_
x-ms-office365-filtering-correlation-id: adffd8cf-dcb0-4150-fab9-08de233a3a29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OVJBY1F5NnlMSnhQdjJ4YjhIdmZ1ZlIrOU51VURjcWU0RGM1WmpDSzlnbVVO?=
 =?utf-8?B?dGcxKzNxVFgyZVNzRnM2aG8zM0RoV0dZdXcrZWxMbU5yRTlTWm9DNUlyTmFC?=
 =?utf-8?B?Q0orenI1UkdmQzFHTis1VWFkbm5hcWFua2w0bHkvY05Sd3FXVU90RGNIYndK?=
 =?utf-8?B?WUhWeGQvM1ArNGNESTNXSTI2SFZ4bDMxMyttQnBaVHF3Mk0wQm91QW02MnpE?=
 =?utf-8?B?NXhTb3Q3UUJDWlE4eXhyYjlOKzZEVDhsbkVINTd6UVVzMzFsdHhDTFlNYzUw?=
 =?utf-8?B?RnBmczV4NUw1RldDTDRtUUpWNDZOdmlJNXoxenFiMGl1Q2taTXB2d0FIdFFC?=
 =?utf-8?B?Qnk4QmdwdXRiVTRZblZhNjIzd3VMcDJGMGQvL0lYVk1DMXkxNkM3VWo5RFdX?=
 =?utf-8?B?MFRUUEtXeHJYM0RtU0NlMmRrMW9lRTJCMUpoVEdsalRxbFB6eEZTNktxZlpI?=
 =?utf-8?B?cU5BNTNPU3c4aFN4cGRxR0w2TE5FMEV2MC8rTkNZTDFmL1JVcEFHSllMTGk1?=
 =?utf-8?B?dEhiaElyemIveDRVRVgvUGxhazQ0WEVVR3h6b3I4UGlMa3dBNXVzYm5zL29m?=
 =?utf-8?B?aEF2c2Q3YlBmSlNqK3BBdkk1S0cvcjNFVnl6a0FXTnh2ekNmNWM3bDJQQURh?=
 =?utf-8?B?WlJjOVNmai9iZHJlcnkxek05YUhuL2k1SkNoUkRXMnJtWEFhMi96RklHYmFD?=
 =?utf-8?B?blVSUmU5ZW9UMWVZK0JPZmRKMndWOWtSNzFCUFVha2FiY0JBQ1llbGlsRXBy?=
 =?utf-8?B?cUNsTUUva1lvRmx4dTJxcFFRMytUZ3gzY2tBRjhDK3ZuQTFFbjNDZW5WRFdV?=
 =?utf-8?B?QXdDRGhLWlRyVXpybjN6aDJ1YmNvR1FINFRhUG91MXpUang0bGJwQ0dQOVU5?=
 =?utf-8?B?eFlxbWVBYWZVZ0tEY3VBZzhlK1VLMVYzNHJyTTN4RURnbTFwMjY3V081ampI?=
 =?utf-8?B?bm01S2Q0VXhjZjNRbDM1aEFlL09kdnBBRTlZbUV6TWpkTG1XeDFpa0FZWEgw?=
 =?utf-8?B?K2lFQUNRaWNOV05QbTVJTW04SjNhaCtpYUVtV0huNlVvNVA2WnlOTlFZNjk3?=
 =?utf-8?B?RWJ4S2Z6Z1BmYWZMcnR0Y0ZEcWVNZURLL3k5YjNzTjZxa3FIUkhsNXRMU2Zj?=
 =?utf-8?B?OGpxT0d5bXlkbEt6V09JR2ZPWngwWGZEZmpUWCs5VFBIcmZjL3M4d05zbWlq?=
 =?utf-8?B?OG9zZGFGZHdjZU1xemUzWUlsNFBJZUMzYjhnTWpBWHltRUJ5MmhwWjFXVzBE?=
 =?utf-8?B?OTdYYndYTHNGRCtzRTZvR0pqZDVWNkdELytqWDZpeml4L3dvcytVdVRpSzhO?=
 =?utf-8?B?WC9rcnVYMlJWSVcxSXkrcC9lS09CWk9KdUI4VmN0UGNCUHlGTHFwVEJicTZk?=
 =?utf-8?B?Y3NVc01zWTVqUFNtSUZFdGZCYndrU2VubFMxY1hrMXRDN1dCWlJMTnBRdDUy?=
 =?utf-8?B?S3B6TnlPaVRveWZGSGt5UjVkSEsxNytJUm1DN1RkR01iUHNQdk1tSGkwWENs?=
 =?utf-8?B?ZEVOaDl2UTJIZHgrWGJyZnBPYmFMajQ4K1R5R1hyTDlPNHBaYWxFbUx2Snpa?=
 =?utf-8?B?cHBqbExSZ1ErNUlNNkpabEFQaVQ0WlZsNnkyVzFRTVIvOHQwcnhRTG1ndzFs?=
 =?utf-8?B?R3BJR01WS3k2SktuVnVONU5ZUUxOeVdjTHdjODJKVERwTDllamI5ekRyVkN6?=
 =?utf-8?B?TmQvQWpucEdMbVJ0NEpvVHJkUkk5cy9GbWlDRGRLbUE0ekQraGVYc2tRSk9h?=
 =?utf-8?B?K2h3L1AzNVFncVJ1TThXRVdGclIyN3ZHMmV3aFlJU1pCM3NEVVMvV2ZQSFY2?=
 =?utf-8?B?MmVwaFcxbmFYN28vc3E1amc1ci9mVkg0Y2RLWHBkVHhWMml3QVZjb2I0eDF3?=
 =?utf-8?B?T3Q5WkY4RzBXakVWZzRrc1lsNDZHVXlIYkhmdGRvR0QzdXJGUEFWUXNXOTB0?=
 =?utf-8?B?SmxzSlJZdkwvK1piS24zVlNzdWRPZlppekdzKytEQnZHTUY1Mlk4aGpKMmw4?=
 =?utf-8?B?YWs4dVkvc29oNGFOZHVjM1UvaGlpZnh1ZnVJcVdyMFZIc3JMN1MxUEhhdDRy?=
 =?utf-8?Q?ErH1SO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFBrcVFwUE5oWnRiVlBob2h2amRIdyswa3N4cEtYcjBRY2VUdmJ3a1NqbjA2?=
 =?utf-8?B?WkRwMW1uTU00bUkrTFhuanlDU2d1QTVLaHc1WUtLV24wMTRoSStmS0tTeGtw?=
 =?utf-8?B?aHJZQzNqV1YvWlFxVHNic1BmOTZXRjdzOHk5M3BMamRHKzYwTC9HaXYvelky?=
 =?utf-8?B?VVlxck84TE4xbTBEejZmdGZNRFVwU0hjVncwSFBjaTg4SEkxcEVydkNuK28x?=
 =?utf-8?B?SW5sMFBwQ0tKVjBQL2kvVldzOHlONVZtRkYwbkU3cUJsNGJFbThQNjkzeUYr?=
 =?utf-8?B?Ky9IVFlUQnN1M21WRjBHMmQrZEJBS0RVemRiUjRUWHNMQWlaWVJqUGtnWEdU?=
 =?utf-8?B?STZXRExnTW0rSVcrdkVxQUJDWWRjS1hwZGhjNTM1WVFiWDEvSFNpZnRjVXdw?=
 =?utf-8?B?VGIxWGxQaWp0Y05wUWtkV0F0aTdRR1prblh2bTErMlZsaGRHTUxXUUVaM21v?=
 =?utf-8?B?eitzcjkvMXRBUGorUUwwT2ZDeGNGdC9YM0U4WjliZXlESFE4N1Vpb1cvalBR?=
 =?utf-8?B?RmdVcFFqbTZabDZqRk5nem50eHhiRTBzUDRENDVTZUsveVgyaysyNzZkdlho?=
 =?utf-8?B?d2YreXVoalZmY25VWE4vSkViVG8rTGQ0U21ndS9VcFhPZkE2ZWVpMkdoN1py?=
 =?utf-8?B?eWQwVGlMZWZqWHhnaG1NZGlhM0xQR1NGRCt2OHBoeFlwRlREYTZ4KzJoOVZL?=
 =?utf-8?B?a1JuZjdvYUk1bmsxSGJkVlhtOEpWMUJPRkFNcHBPMWZkZll3aFVDSDF1RGEw?=
 =?utf-8?B?SjZWSVBsWnlnS09rZ0FCaDUvMXRJS2tZS0pQYVgvSXF1SlYrRWg0WFBGcUM5?=
 =?utf-8?B?T3oyVHlMN1lueE05elM3emF6ZHlVREx0STRiaGtzQ0R4NVJORmk2dVNSaWRw?=
 =?utf-8?B?YnhVLzZFc3BnNXVrVkdHQzJ2dkJiQWhOSTg3dERCNXp5SlNOSnNWM1Jacktt?=
 =?utf-8?B?WEJTb1owa3UvejBVR1hadFZTOFllVnJhcTBHWW5uYWg0eDd0ZzFzQi9jM0p2?=
 =?utf-8?B?TnJDN1FZV2V0YTdKVFNPd2JmTDhRdExON0gzTE9PMFBNbUc2enR2ZFNRKzRj?=
 =?utf-8?B?czVocVlGeDJrc3E4WWNrOXJiaytPOHpZbWxBTUNuVGtpZXBSVFBqU0RnV0N5?=
 =?utf-8?B?VUVTWUd0TERaTWRCQkIyaXhsMDdxR3gxVkVkaGdMOW5Yb0drRlBySjZnaXMw?=
 =?utf-8?B?cVpFVFJUSllzWTQ4b0lxMW1lQTcyYVBReWhwSkNYSlY5RldpT0kxSWVjZE5l?=
 =?utf-8?B?WWpNbVRpcTVWNWFrc1k5WXZwQzV5bGo1emNVaGp5RUorNTlPbTJxUnRtRFpR?=
 =?utf-8?B?OVQ0L1hWOXZ2K1Y2L2FwQTlJZHlicVJ2NzJySGhoUDFCakxiT0g3YVEyckky?=
 =?utf-8?B?dTlxLzRFdFd3VkRidFpTZGl0UDl4dmljLzI2YlpBbzhPdDBJSXRHMUVPWFor?=
 =?utf-8?B?WnViMTFGczdldnU0N3VHSXhsV013czhrQVNpVit2eU9NWVBOWnZrQ0QrQ09S?=
 =?utf-8?B?VnVoajJTYWFqMU1WdjdRWGR3TWlJWkRqY0R5V3RXa20zUm9UY21qRlJ3OE1N?=
 =?utf-8?B?OEJEMlBwSUZuT0duLzZKYmZ5eU9nNUNWRWZyU0JyOHJZZTRGNU5tZFA4ME5O?=
 =?utf-8?B?aTVzR1N3WUJZb01QaFRSWFNIZ0dZbHg3di83Y3IvU1htR1VVWW5RTEcyVnNK?=
 =?utf-8?B?QTNPeU51em1aZjl0ZnQvVFdqU0VYTEt5aTVoUVhsLzhEcVpUSTNhSlpSN0hI?=
 =?utf-8?B?YjZBZUxOZ0RUa2N2TS9PTUJPaW11aEpwL1pBQXJXM1p6R25SaXFaZjFUY2ts?=
 =?utf-8?B?enNDbnltdVk2Y1ZwZXNVbmhvWlJtd1RKOUZNdE1BRkVLMVJIemUzdFYzUVA0?=
 =?utf-8?B?Q0tMMlRRbE1HRXhHN05mejF4WkM1Njlic3FlUTBQNnNPdWl4ekV3VGlQVzZH?=
 =?utf-8?B?S2VOK0gzVE9WY0VxMVlWelNjT0xOTjk1U1J6M0tRQVZPdkJROHhNZk5wZ2NY?=
 =?utf-8?B?dmUvYXdiYlBFRTZRbzN6Y0sxMENqMlF3RHhxeGhDNUltSzdDeWVOeHdjMmVq?=
 =?utf-8?B?V3dRMXNtZkdpNkhqQXVuQndYaGExNmJRSkVhSmNORzNmc01IMGVlYkdBangy?=
 =?utf-8?B?ejFLM1pWR2g5Z3NLZjg5cE9ZU2I3b0pQd3JrS3BqY2c0aTVpckxNUHJudmts?=
 =?utf-8?Q?ola4MzBIg6wOyVj3b+kjVV4OGS4N7BjMBb2kHNJ4W40A?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F502000820FCF4987144955D5C5F762@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: adffd8cf-dcb0-4150-fab9-08de233a3a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 04:56:52.4004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xPnaZXCbSKZSXYw3RxcLctTGFCNXGtSUzSqx7mOBvB/ux2BGLifJskWYk4KqJwEVzUKYZPouETq9lubOgjScbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479

T24gMTEvMTMvMjUgMTI6MjMsIE1vaGFtZWQgS2hhbGZlbGxhIHdyb3RlOg0KPiBibGtfbXFfe2Fk
ZCxkZWx9X3F1ZXVlX3RhZ19zZXQoKSBmdW5jdGlvbnMgYWRkIGFuZCByZW1vdmUgcXVldWVzIGZy
b20NCj4gdGFnc2V0LCB0aGUgZnVuY3Rpb25zIG1ha2Ugc3VyZSB0aGF0IHRhZ3NldCBhbmQgcXVl
dWVzIGFyZSBtYXJrZWQgYXMNCj4gc2hhcmVkIHdoZW4gdHdvIG9yIG1vcmUgcXVldWVzIGFyZSBh
dHRhY2hlZCB0byB0aGUgc2FtZSB0YWdzZXQuDQo+IEluaXRpYWxseSBhIHRhZ3NldCBzdGFydHMg
YXMgdW5zaGFyZWQgYW5kIHdoZW4gdGhlIG51bWJlciBvZiBhZGRlZA0KPiBxdWV1ZXMgcmVhY2hl
cyB0d28sIGJsa19tcV9hZGRfcXVldWVfdGFnX3NldCgpIG1hcmtzIGl0IGFzIHNoYXJlZCBhbG9u
Zw0KPiB3aXRoIGFsbCB0aGUgcXVldWVzIGF0dGFjaGVkIHRvIGl0LiBXaGVuIHRoZSBudW1iZXIg
b2YgYXR0YWNoZWQgcXVldWVzDQo+IGRyb3BzIHRvIDEgYmxrX21xX2RlbF9xdWV1ZV90YWdfc2V0
KCkgbmVlZCB0byBtYXJrIGJvdGggdGhlIHRhZ3NldCBhbmQNCj4gdGhlIHJlbWFpbmluZyBxdWV1
ZXMgYXMgdW5zaGFyZWQuDQo+DQo+IEJvdGggZnVuY3Rpb25zIG5lZWQgdG8gZnJlZXplIGN1cnJl
bnQgcXVldWVzIGluIHRhZ3NldCBiZWZvcmUgc2V0dGluZyBvbg0KPiB1bnNldHRpbmcgQkxLX01R
X0ZfVEFHX1FVRVVFX1NIQVJFRCBmbGFnLiBXaGlsZSBkb2luZyBzbywgYm90aCBmdW5jdGlvbnMN
Cj4gaG9sZCBzZXQtPnRhZ19saXN0X2xvY2sgbXV0ZXgsIHdoaWNoIG1ha2VzIHNlbnNlIGFzIHdl
IGRvIG5vdCB3YW50DQo+IHF1ZXVlcyB0byBiZSBhZGRlZCBvciBkZWxldGVkIGluIHRoZSBwcm9j
ZXNzLiBUaGlzIHVzZWQgdG8gd29yayBmaW5lDQo+IHVudGlsIGNvbW1pdCA5OGQ4MWYwZGY3MGMg
KCJudm1lOiB1c2UgYmxrX21xX1t1bl1xdWllc2NlX3RhZ3NldCIpDQo+IG1hZGUgdGhlIG52bWUg
ZHJpdmVyIHF1aWVzY2UgdGFnc2V0IGluc3RlYWQgb2YgcXVpc2NpbmcgaW5kaXZpZHVhbA0KPiBx
dWV1ZXMuIGJsa19tcV9xdWllc2NlX3RhZ3NldCgpIGRvZXMgdGhlIGpvYiBhbmQgcXVpZXNjZSB0
aGUgcXVldWVzIGluDQo+IHNldC0+dGFnX2xpc3Qgd2hpbGUgaG9sZGluZyBzZXQtPnRhZ19saXN0
X2xvY2sgYWxzby4NCj4NCj4gVGhpcyByZXN1bHRzIGluIGRlYWRsb2NrIGJldHdlZW4gdHdvIHRo
cmVhZHMgd2l0aCB0aGVzZSBzdGFja3RyYWNlczoNCj4NClsuLi5dDQoNCj4NCj4gVGhlIHRvcCBz
dGFja3RyYWNlIGlzIHNob3dpbmcgbnZtZV90aW1lb3V0KCkgY2FsbGVkIHRvIGhhbmRsZSBudm1l
DQo+IGNvbW1hbmQgdGltZW91dC4gdGltZW91dCBoYW5kbGVyIGlzIHRyeWluZyB0byBkaXNhYmxl
IHRoZSBjb250cm9sbGVyIGFuZA0KPiBhcyBhIGZpcnN0IHN0ZXAsIGl0IG5lZWRzIHRvIGJsa19t
cV9xdWllc2NlX3RhZ3NldCgpIHRvIHRlbGwgYmxrLW1xIG5vdA0KPiB0byBjYWxsIHF1ZXVlIGNh
bGxiYWNrIGhhbmRsZXJzLiBUaGUgdGhyZWFkIGlzIHN0dWNrIHdhaXRpbmcgZm9yDQo+IHNldC0+
dGFnX2xpc3RfbG9jayBhcyBpdCB0aXJlcyB0byB3YWxrIHRoZSBxdWV1ZXMgaW4gc2V0LT50YWdf
bGlzdC4NCj4NCj4gVGhlIGxvY2sgaXMgaGVsZCBieSB0aGUgc2Vjb25kIHRocmVhZCBpbiB0aGUg
Ym90dG9tIHN0YWNrIHdoaWNoIGlzDQo+IHdhaXRpbmcgZm9yIG9uZSBvZiBxdWV1ZXMgdG8gYmUg
ZnJvemVuLiBUaGUgcXVldWUgdXNhZ2UgY291bnRlciB3aWxsDQo+IGRyb3AgdG8gemVybyBhZnRl
ciBudm1lX3RpbWVvdXQoKSBmaW5pc2hlcywgYW5kIHRoaXMgd2lsbCBub3QgaGFwcGVuDQo+IGJl
Y2F1c2UgdGhlIHRocmVhZCB3aWxsIHdhaXQgZm9yIHRoaXMgbXV0ZXggZm9yZXZlci4NCj4NCj4g
Q29udmVydCBzZXQtPnRhZ19saXN0X2xvY2sgbXV0ZXggdG8gc2V0LT50YWdfbGlzdF9yd3NlbSBy
d3NlbWFwaG9yZSB0bw0KPiBhdm9pZCB0aGUgZGVhZGxvY2suIFVwZGF0ZSBibGtfbXFfW3VuXXF1
aWVzY2VfdGFnc2V0KCkgdG8gdGFrZSB0aGUNCj4gc2VtYXBob3JlIGZvciByZWFkIHNpbmNlIHRo
aXMgaXMgZW5vdWdoIHRvIGd1YXJhbnRlZSBubyBxdWV1ZXMgd2lsbCBiZQ0KPiBhZGRlZCBvciBy
ZW1vdmVkLiBVcGRhdGUgYmxrX21xX3thZGQsZGVsfV9xdWV1ZV90YWdfc2V0KCkgdG8gdGFrZSB0
aGUNCj4gc2VtYXBob3JlIGZvciB3cml0ZSB3aGlsZSB1cGRhdGluZyBzZXQtPnRhZ19saXN0IGFu
ZCBkb3duZ3JhZGUgaXQgdG8NCj4gcmVhZCB3aGlsZSBmcmVlemluZyB0aGUgcXVldWVzLiBJdCBz
aG91bGQgYmUgc2FmZSB0byB1cGRhdGUgc2V0LT5mbGFncw0KPiBhbmQgaGN0eC0+ZmxhZ3Mgd2hp
bGUgaG9sZGluZyB0aGUgc2VtYXBob3JlIGZvciByZWFkIHNpbmNlIHRoZSBxdWV1ZXMNCj4gYXJl
IGFscmVhZHkgZnJvemVuLg0KPg0KPiBGaXhlczogOThkODFmMGRmNzBjICgibnZtZTogdXNlIGJs
a19tcV9bdW5dcXVpZXNjZV90YWdzZXQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNb2hhbWVkIEtoYWxm
ZWxsYSA8bWtoYWxmZWxsYUBwdXJlc3RvcmFnZS5jb20+DQoNCkkgdGhpbmsgdGhlcmUgaXMgbm8g
YmV0dGVyIHdheSB0byBzb2x2ZSB0aGlzIGluIHRvIG52bWUgY29kZSA/DQoNCndpbGwgaXQgaGF2
ZSBhbnkgaW1wYWN0IG9uIGV4aXN0aW5nIHVzZXJzLCBpZiBhbnksIHRoYXQgYXJlIHJlbHlpbmcN
Cm9uIGN1cnJlbnQgbXV0ZXggYmFzZWQgaW1wbGVtZW50YXRpb24gPw0KDQpCVFcsIHRoYW5rcyBm
b3IgcmVwb3J0aW5nIHRoaXMgYW5kIHByb3ZpZGluZyBhIHBhdGNoLg0KDQo+IC0tLQ0KPiAgIGJs
b2NrL2Jsay1tcS1zeXNmcy5jICAgfCAxMCArKystLS0tDQo+ICAgYmxvY2svYmxrLW1xLmMgICAg
ICAgICB8IDYzICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAg
IGluY2x1ZGUvbGludXgvYmxrLW1xLmggfCAgNCArLS0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDQw
IGluc2VydGlvbnMoKyksIDM3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYmxvY2sv
YmxrLW1xLXN5c2ZzLmMgYi9ibG9jay9ibGstbXEtc3lzZnMuYw0KPiBpbmRleCA1OGVjMjkzMzcz
YzYuLmY0NzQ3ODE2NTRmYiAxMDA2NDQNCj4gLS0tIGEvYmxvY2svYmxrLW1xLXN5c2ZzLmMNCj4g
KysrIGIvYmxvY2svYmxrLW1xLXN5c2ZzLmMNCj4gQEAgLTIzMCwxMyArMjMwLDEzIEBAIGludCBi
bGtfbXFfc3lzZnNfcmVnaXN0ZXIoc3RydWN0IGdlbmRpc2sgKmRpc2spDQo+ICAgDQo+ICAgCWtv
YmplY3RfdWV2ZW50KHEtPm1xX2tvYmosIEtPQkpfQUREKTsNCj4gICANCj4gLQltdXRleF9sb2Nr
KCZxLT50YWdfc2V0LT50YWdfbGlzdF9sb2NrKTsNCj4gKwlkb3duX3JlYWQoJnEtPnRhZ19zZXQt
PnRhZ19saXN0X3J3c2VtKTsNCj4gICAJcXVldWVfZm9yX2VhY2hfaHdfY3R4KHEsIGhjdHgsIGkp
IHsNCj4gICAJCXJldCA9IGJsa19tcV9yZWdpc3Rlcl9oY3R4KGhjdHgpOw0KPiAgIAkJaWYgKHJl
dCkNCj4gICAJCQlnb3RvIG91dF91bnJlZzsNCj4gICAJfQ0KPiAtCW11dGV4X3VubG9jaygmcS0+
dGFnX3NldC0+dGFnX2xpc3RfbG9jayk7DQo+ICsJdXBfcmVhZCgmcS0+dGFnX3NldC0+dGFnX2xp
c3RfcndzZW0pOw0KPiAgIAlyZXR1cm4gMDsNCj4gICANCg0KWy4uLl0NCg0KPiAgIHN0YXRpYyB2
b2lkIGJsa19tcV9hZGRfcXVldWVfdGFnX3NldChzdHJ1Y3QgYmxrX21xX3RhZ19zZXQgKnNldCwN
Cj4gICAJCQkJICAgICBzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkNCj4gICB7DQo+IC0JbXV0ZXhf
bG9jaygmc2V0LT50YWdfbGlzdF9sb2NrKTsNCj4gKwlkb3duX3dyaXRlKCZzZXQtPnRhZ19saXN0
X3J3c2VtKTsNCj4gKwlpZiAoIWxpc3RfaXNfc2luZ3VsYXIoJnNldC0+dGFnX2xpc3QpKSB7DQo+
ICsJCWlmIChzZXQtPmZsYWdzICYgQkxLX01RX0ZfVEFHX1FVRVVFX1NIQVJFRCkNCj4gKwkJCXF1
ZXVlX3NldF9oY3R4X3NoYXJlZChxLCB0cnVlKTsNCj4gKwkJbGlzdF9hZGRfdGFpbCgmcS0+dGFn
X3NldF9saXN0LCAmc2V0LT50YWdfbGlzdCk7DQo+ICsJCXVwX3dyaXRlKCZzZXQtPnRhZ19saXN0
X3J3c2VtKTsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gICANCj4gLQkvKg0KPiAtCSAqIENoZWNr
IHRvIHNlZSBpZiB3ZSdyZSB0cmFuc2l0aW9uaW5nIHRvIHNoYXJlZCAoZnJvbSAxIHRvIDIgcXVl
dWVzKS4NCj4gLQkgKi8NCj4gLQlpZiAoIWxpc3RfZW1wdHkoJnNldC0+dGFnX2xpc3QpICYmDQo+
IC0JICAgICEoc2V0LT5mbGFncyAmIEJMS19NUV9GX1RBR19RVUVVRV9TSEFSRUQpKSB7DQo+IC0J
CXNldC0+ZmxhZ3MgfD0gQkxLX01RX0ZfVEFHX1FVRVVFX1NIQVJFRDsNCj4gLQkJLyogdXBkYXRl
IGV4aXN0aW5nIHF1ZXVlICovDQo+IC0JCWJsa19tcV91cGRhdGVfdGFnX3NldF9zaGFyZWQoc2V0
LCB0cnVlKTsNCj4gLQl9DQo+IC0JaWYgKHNldC0+ZmxhZ3MgJiBCTEtfTVFfRl9UQUdfUVVFVUVf
U0hBUkVEKQ0KPiAtCQlxdWV1ZV9zZXRfaGN0eF9zaGFyZWQocSwgdHJ1ZSk7DQo+ICsJLyogVHJh
bnNpdGlvbmluZyB0byBzaGFyZWQuICovDQo+ICsJc2V0LT5mbGFncyB8PSBCTEtfTVFfRl9UQUdf
UVVFVUVfU0hBUkVEOw0KPiAgIAlsaXN0X2FkZF90YWlsKCZxLT50YWdfc2V0X2xpc3QsICZzZXQt
PnRhZ19saXN0KTsNCj4gLQ0KPiAtCW11dGV4X3VubG9jaygmc2V0LT50YWdfbGlzdF9sb2NrKTsN
Cj4gKwlkb3duZ3JhZGVfd3JpdGUoJnNldC0+dGFnX2xpc3RfcndzZW0pOw0KDQpkbyB3ZSBuZWVk
IGEgY29tbWVudCBoZXJlIHdoYXQgdG8gZXhwZWN0IHNpbmNlIGRvd25ncmFkZV93cml0ZSgpIGlz
DQpub3QgYXMgY29tbW9uIGFzIG11dGV4X3VubG9jaygpfGRvd25fd3JpdGUoKSBiZWZvcmUgbWVy
Z2luZyB0aGUNCnBhdGNoID8NCg0KLWNrDQoNCg0K
