Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E626E6EB
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176511; cv=fail; b=R2SvqGyGqe5hoxBAXZjReOuFtoizaZClAAnq2yZr/ozOfQeGn2YVhecUXH7IIIpauk0+yxrDJQWFldHoZoGfOvS/sjD2neBHxZrc+4QSHIg1PEWWO3lEZIyuKoqcOvVmYnZU8dvHx3LKOz7LGvOqhoE9ypibmrYbVAwMAyHv3PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176511; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b225Qts7j2ko8xQEAx0W4vEY7vnUkrivILloNQoAFpGeyFbHK/jZH5nHa7216GQe/byzObw/2NmIFz04UpgA/a7XFriQ2OaW5XUMSiX+piCPMyKUyAGWnCuvTEHf2OGxdZAZxSZkUsIZWw1E2vao6BkAizW1t7cogONiCMQpj94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d2kbFPIv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lNB4U0Su; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d2kbFPIv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lNB4U0Su"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762176509; x=1793712509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=d2kbFPIvWqY6q1DBirQ6mHFn/Fh1rjvK+DIQI4gH5H6KoA7xcgehh3H7
   L6T/9PA/yHev/AwOL4QpqvYlNkbR3ulEd7uFlQDu3q6hUo2NoZcUvoH9S
   bCjBuTZhDYxG+4h469pLc1sL4ZZLFQ+ngOrwXmS+YTZ+Y/UmDIZrFaH/u
   VCAYJHlk9zL8gIyLT2IgNMlnfpQrtT9yont5YC83xCxuDackVlrj+QYOt
   +8ZCe0mgrn7cPYum0qKOMbfE1CQ0iTVvaxBYXz9tfgPrI6jNL6edQoez2
   lsVnutpGh9ZL0Wg38fmW/KljvMiYaqNAPXO4FQjncIHVoj1+ScVCorkCv
   A==;
X-CSE-ConnectionGUID: 4KGZ5enxRdCD51Y/zz7Gig==
X-CSE-MsgGUID: pVQNT/eOTzeXn9pK9GYe7w==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="131390739"
Received: from mail-westus3azon11010006.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.6])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 21:28:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5tImEDllf3/YggKTpsXaFHCqW3rwB9SJ/SguC/BCLbgokiVglA8BK5M3c0v8RLPRoPW+24NEuB9ShIqDP/IF/DsijDvngPrGhZYBqzJQ+LJfDfKiMFyc1VFMqVzXEvvXhvbL8Ockt2OTcn9w+Sogpt/NxHMPLq1xfkYvCqrLHmwVPjhZq58fHlLbrb+BDu3Ykg90Ey2oy+XNymg+gbPYa+mZ/8bX1T3F5HXvFQAULMV8dNS2WtSJ3nE4+E8guQdse5grTFsTD7QQ6tQXraHs0XkdKHCvg0eWiTD9Zeui5eJpc4AqytamevmPX59sHxEr3cdMzel3fkLJaDHQE9c2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=XdnIosHdW1PF9CxhEhuTmmLrhXnKr3RKXOpAMj9lDJlepUWuDLaHH3mUstnoNBp1ujxT5hwyEXRj/uzyw76KZMmpShAsv8jBdmTM7MTRDetUHf/l8ef+0+eVDBjOq5WaEk+DtIngSUpCJepkV/CgWLm0b5yzFwH6vaMEjZdkVHcM7IZ9627pRg9qYnYBlLEN01takU2ZN/gNXnXf+2MjuL74yqSR+r6Nok8XH6i9TXkvEbBTbnOtES76nw2C1pJ0kGJNjiNC8GC9ovD75tLufNShPq6Vh6aiIhMo/RuTPbEeK9pvt6m9Bpx9OC3yH8gHml7rQrBWdTEmjBwtbw3Rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=lNB4U0SuFfZPHIHpRjFmGbDQqWo5BA847TAFqqCT7KMPsmJo+MYXO7KJWvPPv9Hl/xAC6eCQUbMYIbUz/mjDyamrAkwXYlFAZnuOVO9Z/uVV3AQZQTtToeiNlmKd5AV1S9RaWNHSolHhxBDT6IHqFuMZVtWvPiYU86FfeetMs58=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by DM6PR04MB6858.namprd04.prod.outlook.com (2603:10b6:5:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:28:27 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 13:28:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: blocking mempool_alloc doesn't fail
Thread-Topic: [PATCH 1/2] block: blocking mempool_alloc doesn't fail
Thread-Index: AQHcTKs5Mgar8p5nEEyX7SP6tF77nbTg8iEA
Date: Mon, 3 Nov 2025 13:28:27 +0000
Message-ID: <6f36166e-05d6-416e-b2c5-f4f8e90cf458@wdc.com>
References: <20251103101653.2083310-1-hch@lst.de>
 <20251103101653.2083310-2-hch@lst.de>
In-Reply-To: <20251103101653.2083310-2-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|DM6PR04MB6858:EE_
x-ms-office365-filtering-correlation-id: 05e7c0d4-4801-4a83-7802-08de1adcdf10
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dHhOeE5XTVgrY3JoUUhUL1FDVFRTVGJLTFBiUG45bTU1cVhRYWdDZnNyL2Mr?=
 =?utf-8?B?VFdkMlF3ZHBSNldtTnR6bzF0WU5MNEhSUjF3c3RxUmRWeDFTTlZnN0E4bmJY?=
 =?utf-8?B?YWlSYUxNUUxHTTducm1Ic3h3eXEwZXdWMElDZXBIaDdKNEZNUC9OOUgrTk1t?=
 =?utf-8?B?SUpSTkZTM2tWbVJEbEVxT3ZldnFub1VpTlZkcFVXVmVVbnlESXRtcFBpN3FD?=
 =?utf-8?B?NXV0d1dGVVRDUzU4R1VCOGVuY0ROWVV6Z0lWc2NaaVZRWlppSFkzRnB2TVhX?=
 =?utf-8?B?NTFCd2E4K2NNVWZTTnVXNzV2aVFhVHB0aUtubEZPN1A5WUpIM3dzV3RuQWlW?=
 =?utf-8?B?U3FyTU1zUDhGaWdLcUdUckpnSjhyK3RJdm0rcElQUUhTRkp5cmczTEFXMGNT?=
 =?utf-8?B?d2FnenFsdlc3UFprdi9ZVERFRFI2UncxNEpmckgzL3N2U1ZkK2h3eXlVMjVy?=
 =?utf-8?B?dzhkdGJkQjdjWFdCMG9xR1VNbTl2R0NQdlMrMkh3QjhpWXhPUlRScWNkUXBk?=
 =?utf-8?B?VTlRU3lWbDYwa0tkSkhnY3JJek1tNjBpc3pHRlNUQlBjQzJkU0psS3RRNFJL?=
 =?utf-8?B?bW4xTUxLQTdkeVNGMFFYRjJsTTJDU0RqS3RnZStJbVY1b3p2bEJtMmM3eWto?=
 =?utf-8?B?cjc5U01zMGhnNWsxbTJJbXdvOHN5SUVyQUQ5ZFh2Y0JxSUR4dEh0cnFKaEV0?=
 =?utf-8?B?RUcvdmxLWE9lYzRIOVhCRjhWMW5iZkhMZ0laUXQ2QlN1akhpSFEvTG90cmJO?=
 =?utf-8?B?cG9wN2loWEZSQjRPYmQ4eG1ielJYQ2NsR0xaMVcyaC9xdTZRZnVnV1dkcEJQ?=
 =?utf-8?B?cCtYcXErSlpMdk5IczFkSHJjTml6eHdMTHFnL09LNkVBamVORFpINVo3YnBl?=
 =?utf-8?B?a3d1ZXU5aXR1YVpva0kzV1RudkZNd2JZSW41UDdWZG80UXFDOFl3SERJVFZB?=
 =?utf-8?B?Z21sWHJtYTlwWmczTC9ocG15WUpodWI1VlBGbVYxQVJJVmNPajhwQWFmdjFo?=
 =?utf-8?B?cEJQNk5DTUt6VVRhVnliQ2QvZmdZZklPZGpnb1J5a1gwdzZsRVF2MmNGR0ZR?=
 =?utf-8?B?bWhBek8vbFpXZDUzTnlaVitwbXZlMlVqTFVycDJvUllQS3JnNXN0VGZGdjZQ?=
 =?utf-8?B?dklVRzgzaDZ3RzlPMTVtdUJ1dnpQUEZlcCtqY2RXV01sODZmbTdZZk9xR3dM?=
 =?utf-8?B?aWwrZlRueWlhUkx1MVZKMjlTeEtPSHdBTWRlb0YxZEhHSjAzYWQyWUFtNEJI?=
 =?utf-8?B?bkRocHhaV3FFSkRYYVp4L2JMakFPWFFiTzY1NFU0TlRFdmJKdUZVd0xyTGcv?=
 =?utf-8?B?OVd3dzhENGM2QmRyQVBIMmFaSWVmS3ZEVTIyQXEyR1pCTWNReWlac2NEZEdG?=
 =?utf-8?B?VHZYb0VKckZTS3FDSmNyckNPeXRMYWhDWFNKU001R2RZVGFXMjhvTVJhUW5M?=
 =?utf-8?B?ZDhwZ2tCS0lLMHJ5L3N1SW55ZXl1S1dESGRZZ0N3QUVoT3Q3RURFdnFzWERF?=
 =?utf-8?B?aXlVcVYrZFdTY1FKWFM3MmFUcTRYbHZpWjBpTTVpeGxBaWJhWGxTUU9WRDlM?=
 =?utf-8?B?bElJNUxXSklWY1lXS1VhR0UwdzZaTmNaVGZla2lhWmVsR2d0ZEk3dGE3MkRm?=
 =?utf-8?B?d2N4V2pLUlNIWWdTbEZNS1RmWlhTdmpmVndtWmRnS3d5a1dLcmRWTE12bk16?=
 =?utf-8?B?UlB2MVhYU1kvVk1NOWFxdHFoMEVhV0JYeVM3UENqZUFnZ3A5RDUwNVJwL2py?=
 =?utf-8?B?WEZ3aXFBK2Z2YWZpRW5nY3ZaYmhQaUV2NkFNTSsvT2ZGMGttNmViZTNwU1pa?=
 =?utf-8?B?NHFVa0ZtMW1icUJ3Z00yZ1M1RlJIUnNkWndqbU9IYkJ4bnRTUFBlMWtTUEtB?=
 =?utf-8?B?cVVZUm5NMnMxUktOWDFTTHhsSmxBZEJDOEdIa1pCV0VxdVVaOG9YbHpTMHhl?=
 =?utf-8?B?cWhHZVNtSmtmYUpsWEk1Nzd4R2pjc1J3QldhdDZxa2lpaVIrbjJyNld1bHZD?=
 =?utf-8?B?aUNmcjEyRDhEQU1vVlowZlBRRFBHNmQ3ekpPMzYxUVJlY01lakVFbjAxcW5X?=
 =?utf-8?Q?sxA7HJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3ZkK0JQYVV2OW9MK0FjYnNKRGRWdmxjeDhMeTI4ZE15NXJqREl3QmlYckVn?=
 =?utf-8?B?UEYvTGZIdUp6WVJnWDYwQ0I5MDN2djJ0Q2VEWGlKWGFmYUVDSjQ5emZlRkZk?=
 =?utf-8?B?UEg0azJkSmtGQ2N3am9nYjVRZWNJYSs3emlZMFhiRm5jSmRNSmsreVRpbElT?=
 =?utf-8?B?Vm41VGJIMlhocWppNGltblNCSEd3YzNpZEMwMTRUSUlIOUs0QWdiS2MySFVm?=
 =?utf-8?B?ZFRQMVlCSE1iZUIzSDBTTVJ0UTNrVC9ucFhuS0pMN2hEVWZuNGhPbGFaR0kz?=
 =?utf-8?B?V1VkRTc0MytkaWM4NkVoYnl3aFF1REZ5VjdSMDRXa0lvR1U0bjVmdW4rRC9G?=
 =?utf-8?B?QnNCZkswQVhrZFFLcHdDMnBXVjVNeG9xbGRnMDd3M2tER2NpTVJDZGltZ3lK?=
 =?utf-8?B?YzBZMHhpRUdYa01rTTE1cDdhU2w1dmRxQWxkajZ5bTlEMkVMWEhOeU1QTWtj?=
 =?utf-8?B?SHhrakxGWTJRTTdmeENzdmx1TTFtdy9vR1hXRjBucG1VWm9xb3ZDTFdTU2tK?=
 =?utf-8?B?Uk1IRThpM3ladHJCbWFSdlBOV2pwYzZZMGNnUUdFdkI3V1dYdWhEbThpcElS?=
 =?utf-8?B?TG5NWWdOL1dWbTl5TEx6N25ENTlPc1ZkYzkxMDMyZ3pGS3RDWUlXNFRyb0tp?=
 =?utf-8?B?eDRCbTJYWVdtTUZQRTJPUVR6eDcrelJ5aWdlakhJNXdUWGtqY0hQVXBzY3ZR?=
 =?utf-8?B?QzdHcXFaY2IyT2FQSnpDTW9NcG84ZlcyVFlIWVlxSkMrRHk5YzkwNXZ0ZG43?=
 =?utf-8?B?SmMyKzVYZktVeGZMN2tIVi9INzlKdS9IdEl2TlVsNFRYMHhvdWExaTIxblFj?=
 =?utf-8?B?RVAxU2FpTmMzaWZLN1B3NTF1UEpSNGk1MFhYTHJna0UyM3FJVVltQzdFSVdm?=
 =?utf-8?B?dGk3NEE2T0lTV1pNM3o5SGdWdm4zZTEzVWx4SmZQNWxkS0F3WnZYRDBVMmlm?=
 =?utf-8?B?ckVlTHE0YW9TZFJjV0ZLVXVXSEFSQlU2UlM0OGlxTGQvTWN3ZFBuZkcrdUk3?=
 =?utf-8?B?MmZ2RFNVM2V2SjdPZll1dnBkUkRQUjR2d21Cc3FmVDl4Wmw3aENQWVpnMDRF?=
 =?utf-8?B?cmJqM3FEc0tUcW53eUZkdUhuK1hOWFNLZmk1b1M3WlZaNy9PY2trSktTQXF6?=
 =?utf-8?B?dlZmUjY0aVZWQ0pLTUZHYWxzbE9UUnIwaFFPMUZwNXhXYW1ia01KL3B5Q0dh?=
 =?utf-8?B?QmxGOUZnZ2NoMVY3R1ZCWnpkR0tkcU1jaFlDcTIyVEF2TGNjS3NMN3hzbXRa?=
 =?utf-8?B?QkZtV3dGQlBMdlRzRGZEQTcvRXZEWGs4bG1NS1FoTHNxVVlOTlk1MGpGOTVB?=
 =?utf-8?B?ME83U3Rsb0E3ckhzTkUzV1U5MHo0QVpxUjl0SlduOVlrdlh5R29BUXdGNUxI?=
 =?utf-8?B?MDhyRW8zckV2RjRhd0VyN3IzQkQ1U1ExWno0Vi9RWS9ycjcycSt3aEZiUU8x?=
 =?utf-8?B?QklEZTkwWjZ0d2NPeHFFa1VxYXVrZnVZSTVpbVMyeFhNN2ZjRHJQQ0NoMmxS?=
 =?utf-8?B?anJjejlHYVlmZi84UTNsZEF3MnlDUXFuWFE4RjM0TFFoK0lJV2dzUnYzaFRv?=
 =?utf-8?B?aWVOODYraVJ1TmJJUGZhT2JmS1Q3UWhUa0RjejFrZHJWcC90WGcwZmlrYjR5?=
 =?utf-8?B?ZEtXRXdyTUx5ekZOOHhiUEgxZG52dmlqUm56Tk9UQ1ljSGFEMFlCYkkwWUMw?=
 =?utf-8?B?UzFIaVJPa3B5TkxRTlJvQzVnbENOM1l6RWd6N2REZGxnRVIwZ0x3SFFPb241?=
 =?utf-8?B?N3hWcWZ6MTM2dHRvSUgzLzBiMTNYWFhBemtnRUE3UFR2TVY4MVVSQlMzMnlV?=
 =?utf-8?B?K2J0ZitqTElEYWZlZmIzaFpIM29zYk5WZ2dTVG8yTU40SlYvWXN4MkswQldu?=
 =?utf-8?B?bnJGc1dEL0VqR0FoN1g5YUhyNnZ6SE5JUUhpVzc0TjBoNCtDSDM5YVlyM1JT?=
 =?utf-8?B?THkyK2gzR0JVWUhEVno2OTlGWXJxUWJhV0tlaXozSEszWXNHajdoWWJJMU5M?=
 =?utf-8?B?TENHQkVCcm1mWU9abEdPNEhmVU5MeEdVU2lSeDRweEZOVWp1VTBIM0IxdHZL?=
 =?utf-8?B?ZEx5L1BxQm5iRVZzTjdhUy93dkhBOHh2dUpxNHJiSkJxMS9jQnFKKzRidk4x?=
 =?utf-8?B?RzUzUlRMbkd5TGIrQ1RObFgvUVdvNDBWdlhldTdrcHhnS2RSVnJSL0pRWWhF?=
 =?utf-8?B?cjVKeUIvTEFCZ1BBb0ZiZjNEeWNJTzNFcHdjNWFYeFpiaFJ3T2NpS2lHUDdF?=
 =?utf-8?B?N3UyRFlxbWtjN09rU1pRb2dlNGVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AD99DE9B6EE524DB1DC5D5C422D9B42@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5YfpK1OzuOv96Txb2v1JtzeJZA6AB9gw0l911wMWAABes5r3vzQRndsSbCblORm244R81/9lu2eezwYnBoeD1+VULQDgTgOz4ckXrCdeK41DYL1fCR1+kLxK/a4SIbul+CaJG+WyNtDHsawBJ+1DeeatXYXxNSClFydpeSst86ZqPkb5F68Tg1dY9QHeIpcU63JRHFfc7Mg/reMBhB+PPxbcFDmjdpGdTttGu1u4f++sQpMnsBzUhH6UK4wFG7w55QQdFov9C4pOfJv0wz1ytNGfKdwHLcA6ej1PzgcwNmRPorE7jeCtjl0iEwCcCf43k3B1RBh9zT6EUfsQ4cE+DzwEg7rAvRYKdDA6CsYjscpSqomMTM3NoDJ2VpcwCfBRT3JD+L5IB/nF/SrEjoFoq/2grMiO/ZrHRWSiE4P4V61A+zc4sXFU0lHu8pOwu5CGrTTvkPHPk5bkq2ioshKulViF7WOHKy4VYZ8exUIPGPrG7VAw337SB08cqEhdWDx/SIplWo6PyHbb0IoHAWtygsRFfA8Jugczn3H/wt7229EfmlW27PxnGUWTKW5ofW00kf5RvjXbgbUEIKSOt8yl9por9XFBgcFE4k2+ICEAxurIDbjYfDXrHGzC/QYk+Tu+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e7c0d4-4801-4a83-7802-08de1adcdf10
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 13:28:27.0406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x66fRVfiWpeOmf7UuOdVb36zd1Pzh0wi6qVM93CtYiSufwKiciVARGt1dO7gfxrVF4435XGflZvAKw07vCcd+A5mj0ADJZ9SPvpNgTlntCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6858

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
