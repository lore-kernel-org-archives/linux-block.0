Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554E2F12C1;
	Wed, 12 Nov 2025 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762991955; cv=fail; b=VgMdTsWm0SC9w0fIvetaL0HB6UvT3006KL66OL6y1XzVgZhKuwrCfmhA4EYvz+oHf/qd2bPCH0qM9JtY1qep3YmIJ3zVTo8pwfqWw3C8h7P9mGvM98x8eT2ILH4dQdegO9Ah1f3tjqnjcxdVr+IZFuri4vCEBHtDUa/PpJWyxzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762991955; c=relaxed/simple;
	bh=V22S4ApvPcoBMyalvw7Tm4VMkKW/KXMo8VSwqD8hd2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vw6ByWpfmiQVUlmgV9MMAFil8anLHeIo1ZBxmFd6tgAzfDskAzUCOvCQ0yWMqoC8UDy1908DYzz/gkA82Gz8/Cn9foHLlIfp3vNk04+48LrxIyf1Wn8ZeYVijCRckyOBVxcO2QVK18oZ/RBjodxRCyV/4Ux9c60h/4BgIYN6QYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y9hc9BlF; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y9hc9BlF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJGdd89UqLV3e9V95yNzAMW3PYKfytXr4foIiWPR6FUwhvKblMQpIsDXlJD3tlhlZccaapde7nF4gKCYdqQQkVK4ghoohQISbdes7j83yQpbrWb+Sp5dIOdYl1hob01laTvmY47PcW+kmJ4psCFCv7iJfDBN8ah69ZB2sFCAl4hv7K70dc6GLxzYA7KqaGaxl7zehDRqGmIiXAUL4fEI/wtEGOp5QdWazWHKVJRqilrHH4CfzC9xsGnV85ZKf9V1Oh0Ah2g90BPgLkvzCftSR6Ad0CT72cl0XQOy+sERuSgP5BkJ+gGuO6MUIRzHaOFlJTRsmdIZubb/17vyRg7nRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V22S4ApvPcoBMyalvw7Tm4VMkKW/KXMo8VSwqD8hd2A=;
 b=oRMQwXuuqTbRUUq+8VrDbGr4QMwQBrz4FUL/VejQFJAVPSS9omk3QiDtAA2LXclBPasfyqASd9Ye7+AoyGat/WfHWqsmW2qNT5Xl8FYDbw08RGNsKFSIDqBk694Qy6eu8zzMZs4+Ba0b7XyxQC00wgqOPDZV3oVjToRrjh2VSGuo4v6tNFyAzZMXY/RYFCD6mRWyIGjVwjfRfIs96Fbl3GgP9AlZMKj3A2iRVotUJiiaCSypgTSOgHa/pASAMo8EJQ+iw1lxHrjYWXEgEJXBLe9a7/90Tuy4m/pNzGYqKBycca+8fJc/RKjqYb5s+x5pzP8uDCHCINJAcPnG3owZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V22S4ApvPcoBMyalvw7Tm4VMkKW/KXMo8VSwqD8hd2A=;
 b=Y9hc9BlFmueFfF7jm70bWT4H80tzhEji1ZqGH51AyRT/dWF/OamQuG+rC9S7x7mF1BETm77EW0UTmgMWa9FMHqyck1ENEX7G98uU8Zt+HsbuMIgKc0AF/TB9WmVhuhjpirL7zWAHjLW8v/5F1/wxp+oRek4SSiOCC+nbz5WoZeTFWa+v2nNWt28tIpTe6i33J+aL/y+5H8/JV8i4dMf0Ux+pCd06TXFJe+a7loENscRdTrESnM/XObsTLIy7HOjTWYxzN9fJcThpmeE2ztajv+uyIueeQwTdeOqdiZCLOKCyTCme1+h3JU3QkdJcjNPzNWupv31QwdSNV+RaQqHY6Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 23:57:58 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 23:57:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v4 2/2] block-dma: properly take MMIO path
Thread-Topic: [PATCH v4 2/2] block-dma: properly take MMIO path
Thread-Index: AQHcVA1pHdetE5cvZUG9C6tYBW4zArTvuDuA
Date: Wed, 12 Nov 2025 23:57:58 +0000
Message-ID: <982324f4-b8a5-4c53-a799-bbe75f7a0e30@nvidia.com>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <20251112-block-with-mmio-v4-2-54aeb609d28d@nvidia.com>
In-Reply-To: <20251112-block-with-mmio-v4-2-54aeb609d28d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7248:EE_
x-ms-office365-filtering-correlation-id: 391ac327-2913-4f5d-7530-08de22474e3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmRUbmUxdEJyUE1sVkg1TGtPNnpPUGZzNzhVbTNqSEpQQ0NWanZmUEpMNVlR?=
 =?utf-8?B?TFZOaGRWQ2o0b01lS1dxT3FrSlpkbEwwV21FQXRJTUpFQ01pRlhmY2ozc05u?=
 =?utf-8?B?ZTB4TUJJbkJNVkVsaldWRm93OWNaUEtxVUxWa2FUSVZ4L3AwNWNXZE1IblRq?=
 =?utf-8?B?MUpIQkg1alZNeHJQSmdMdXo4MmtBL0dMK3NRcWthbGpYcG4xOUJJQlE2Ym40?=
 =?utf-8?B?SWMvaTU2QXZvYTFaeC90dzdlV0czbUh3YUtOd2pFM213dnk1ODU0cEkxK1ly?=
 =?utf-8?B?MW83dGpKWCs2UExHWFQ2Z00raU5ETDlxR1d6NW53WnNOV2tKbXczejVjVzBQ?=
 =?utf-8?B?VG4rd3pjQWxsazlkZDNRNkZzWW0rS1ZTRnoxQUdidGhwZTFGOVAxWHh1NjdD?=
 =?utf-8?B?MlRJeWNHY3pub2JUWjlHVE1tYVRYaXcyT1M1T05aL1RDNGhjbkZWbEZpRkFa?=
 =?utf-8?B?WFdxTUZndDdjMjNxNXpISFZkc2RTYzFLTlRwQlVHRDdtbEF0RndFd0p5OUlM?=
 =?utf-8?B?eW1oNllOV3lCQTZIa0MrS3FHQVJDY0EwWW1LRHp1enhZZmNESHhhaUJmR3A2?=
 =?utf-8?B?dkJ4OHdJdDZQd1JnOGhOSGJHemVOUDZKcWNvYnllTGtjaTFYRkhub1k3dVVT?=
 =?utf-8?B?cUdFajUwNDhQbnVqUjhLYVR6ZDg1VGFhU2ZoYnpIYW95ZjRrM2o4NnJWRVFH?=
 =?utf-8?B?REtCY1I0YkJkQUJKaW1UWVFpRlliNldPS3VaWmN1YkxDTEtPWUNXNmoxNWFn?=
 =?utf-8?B?LzQzRXpLNU1RTGJSanJjQSt6ODlNYnZhVlVnUzQvM3I5bDRuUE4yd2lwVmVG?=
 =?utf-8?B?b3J2OFJoQUVFaWk5ZVFXQUtYUjgzVTRtWU01NmFwNFFSUU5mQ3R3YlhZd05o?=
 =?utf-8?B?c0NFUGZHM25oYzJhU1ptcFdnN2xicVJNK2JVMU55VXdycTRxSmV5Z1ZqN1VQ?=
 =?utf-8?B?aHB0MFdZTmV1Q21UWWFZV1lQcUhYSzU4Q0doeU9Dek41Q1NtSFVlRm8rQWVz?=
 =?utf-8?B?elc2Sm9lV2haTWFpa3BWZDBLLzlXTGtBenJjeGE1eHUyQ1kvcm03Q0l1RjBp?=
 =?utf-8?B?Q3N3UDB2OFVucGlVdXhqaDROTnltTnJTYk5UNkE2S2laSENQc1NyY2dFZFJ0?=
 =?utf-8?B?WE8wUTJIMGY3MXVtUHdJaXI3SGRSS015d1RNQjQ5aXUzU1REeTE1QlhpZ2Vt?=
 =?utf-8?B?dlhKWjdTVHVXRG5nVnlHNGRKYXlJZGs1VmY5N1Q4a3RCUytRV2tpOXM5Nm9W?=
 =?utf-8?B?d1lvVjFVRncvb3VlWGZXNmtCTW1Gc0svZG9PWlVtcU1HNmRWMHdvS2xUQWxW?=
 =?utf-8?B?TWJTMnhIS2dObjF6R25za2RLdHQweGs1SlpFNDQ4a3o2NThiank0a0UxOWRM?=
 =?utf-8?B?bW5sci84NzlnQlNkd2dyL0JBcDF4U09QMit5VkFZdVhVb3RneVlJQ3R2V0Ns?=
 =?utf-8?B?emQrTTlVN1pLU0xjZURuMEE0K1FYOTFNU1VUa242K21jZW8ydkthaG5PMGo0?=
 =?utf-8?B?QWpBaHduSzlBcWlhS203VWl2cTRwK3k3ZWU5TFZTa3NCd2lyak9PeXloTld5?=
 =?utf-8?B?Z2FGNytUQTFmSDlpeStDZWNQSHdBeWZqWmNwN0JmUjJyV1RXYmpkaDB3WTNr?=
 =?utf-8?B?dnhvWk1mMTgxZW5uY3RYUUw3NU9xWGJTbk05L2tVbHc4Zm0vWDBOcXBiYm5r?=
 =?utf-8?B?Z0ZqT2RtUTREOVJlRkRFdmRyekV6dlhablZkb01VRm1aVk43S3d2TDExclVi?=
 =?utf-8?B?eG04alBYNFFDa0U1QnRNYzkvMUZkWXJjbUFsaDNKL0dSTUR5S21qSHNGTnhK?=
 =?utf-8?B?WktHS29xUTlWcVJ0UkFTeFJFcHo1ZTFEUWFWNzdtdldYbkRONGlXVUtYRWVw?=
 =?utf-8?B?TmRKNlZ3dmVrSmtsWVgzK1l5bndxRzNyeFBNd245TVpNRldUVGg1RThGU1Jq?=
 =?utf-8?B?dllpamxBZFZwOUtWUWxVWE9hZEhwOVVEVEFqL28rSUFVb2Z2c0NiUGg3ZVI1?=
 =?utf-8?B?c0p2ekxpLzlQdFpzMnJpVmJzTm9OUi9kUjZleWJzbm0wUTRRcDlSSFFwUVlh?=
 =?utf-8?Q?bW0rEo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHJTdWVaa2FlcTZIQzh5S1IrVjNuZGFNbS9xT0xSSm0wNW1WdkgwOU1SaERh?=
 =?utf-8?B?eWdBTElzWTQ5VmRmVDc1azdzcFk2UDVKNjZmWktpVTZFZFNqRTYvejcrb3lT?=
 =?utf-8?B?ei9wR1JFY1A2VFpVaVgvK0l2cFNxdFJ2M1FNSyt4QlU4ZlRnT1l4ejJpV2lS?=
 =?utf-8?B?YUZ0TnV3R09KWGppTk5TeWxscUQrS0pqSWtKaThkSkI3U1VWekhibGhtMFFw?=
 =?utf-8?B?OXg0MnBRUHNDZGt0a3RpM1lGQ29oU2ZTbmJ4Nk9xemdQcStpbjROVE1SbzIr?=
 =?utf-8?B?azJ5Ky9CbjZSazRWTlYwaEwvWDMyTGZuYVlzU1hLbUw3SFc2b0tPOVhIRkpn?=
 =?utf-8?B?UGEwWTNjTDg1UTZHVDFSK1V0ekhiV1lpNHJLVzJ5Q2dFTDllMlJRYnNRQU1j?=
 =?utf-8?B?UjlyTnZNZVNwLzM2blZFMUdCM0J1RGt4VCtmS1A3bnp2VTdrQy9aN1IrQ3g1?=
 =?utf-8?B?enh4UTlqWmtLa1lhZjZ0R3prbzk1ekpjUGpLT0xadFJVVFZCSVlvZEI0a2M3?=
 =?utf-8?B?LytCNk95VW5wL0hRZTU1Vk9zVHpoQ2w1QytJdGhnbU1wc0IyRHM1Wm1uOTVP?=
 =?utf-8?B?WjR3SmVsbElZWjN3eld6RE8yY3lhWFZkQmc1OHlIcFNEejc4c1JMSlBQdDF3?=
 =?utf-8?B?MER2M1ZqOW95cnI3QVk5NkJralBOdm9TVHpMZVFSQmtlb0xsR05oNFFQaDVM?=
 =?utf-8?B?R0RJWE51c0Z1NnN5V3JzckJUNkFrK3ZXUkRrT2JlNEp4b3pLSXlYWk1JdWdW?=
 =?utf-8?B?ZWZTTjNSUHBNTm5tNVVVbS92R2Z2TVFHZzdWU1grWFBoMVVheTk0bm9VK3hh?=
 =?utf-8?B?ME1XV2JYK2xCK1BOUCtUYnR2YUlhMzFSV0tVTWc4WEJ2WWtkZk1pRmoyOVR2?=
 =?utf-8?B?cFF5SzVmSGNXYXFwN1ltRCsxeVBSdllKTTFadkZPakdybmZ1dkJMQnpWN1Zi?=
 =?utf-8?B?WEd5Z1l6emRSdHRQRGJDYmgvWUJkaDJGMGtwZ1YzTVU0UDhNazV1bXNCNGRv?=
 =?utf-8?B?bnpNWXgzM2dFWk5FM1oyODBrVDJHSXh4SzJiUC96STc0aTNnTXphUmo5N0kx?=
 =?utf-8?B?UDBpbnZpay83QmIxZjJZTEFhZ2ZWNURyWW51d2R6WTU3VXlMcER2TkZOdUow?=
 =?utf-8?B?blBiNFpVeU9yMDhYSnJTZEZLRTRoVEh4OFJRcWVOUGx0OWlSdlJxWE8yb1px?=
 =?utf-8?B?QndPTHRkc2FrUFZMandYWEhnbDFMTCt3YUo1QVpzajZqeTFGTVhqQ3dXa3NU?=
 =?utf-8?B?azc0UlFCOWJveEdLd0M3RHlHT20rN291V01scVREd3RWTjRhcFhpNmdXZDNq?=
 =?utf-8?B?bUh4SmVMbjdOKzZyZDdLL2NsQXlYWm1LQjd0Ukg5c0t5NVA1ZHJGL29DaXBY?=
 =?utf-8?B?UFo0M0FPZ3NSZVlnYW5QZEJmSWtJVWpLSUVtQlhvZGxnL1F0ak40VXFFa3FV?=
 =?utf-8?B?b0dDa0VwTFl6eW80MVNVNzNrREMvMThLd1FMUkFZYTRWSVhhQnZUUi9rTjNS?=
 =?utf-8?B?UGIzYnN0d1g5UDJCdVJCOFE4ZTFQU0xBWjk3TzdVVHFtM0ZadVNHR05Uam9w?=
 =?utf-8?B?K1ExRXFrOHAzQzZ3VUw5dzUrT0VibEpEUUlkT0RlUlM1VlpZQ1BTNnhpL1pL?=
 =?utf-8?B?VGJoclFseElIelpzUmNOdytCSU5Cemwvc2JaQUlsNEZGMkxkcFlRRzZ6WEdZ?=
 =?utf-8?B?SzhjU3ZiU1diU2VRK240N1pQOWJHU3BTOTlWODhQRFVvUGhzd2I3UmU0SFZy?=
 =?utf-8?B?aXhBclhYVG0xeVlFL3lMYlNOc2QxZ0lVbmR5bi9pYm5lWEdmbDVxSUp0RGo4?=
 =?utf-8?B?NkFhS3RHNkRCOVBIV0JzR0IyRDFoOTVPVlNYTWgrR0Z6bU9tTVBacmc1SlNz?=
 =?utf-8?B?aFd1ZGp0TldyWFVGM2V3dUZwQlFzN1d1YktUcGRCME16S1JFemcvMys5MHVG?=
 =?utf-8?B?QTRpUTB1bUdjNkp2V2ZTa2E0QVJJWHNnR1hzb2VMclZSdWFUL2cvdGw1MmpV?=
 =?utf-8?B?U3luVjcwYjFpNFh1RkxPNHZzYStSc0ZyV2dmSVVML1o4eER0ajljZnhpenlH?=
 =?utf-8?B?eUdGQitqZnArVFBWYkNYOC9RelhZc293VnBKbFNHZjBMNm1TVmc0UUNCdTFu?=
 =?utf-8?B?S0Z6aHYxam10cGhjMW14SE9NVlNjbXRuT2M2ZS92VytnVk1qaFFqbHdUdG0w?=
 =?utf-8?Q?Dp+qwKCfe+WtkjYhU5BRl3uSCe8ovTamSZGyzoQ9fSPW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9866A5DA4B19034ABBE3085F4B1B72C8@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 391ac327-2913-4f5d-7530-08de22474e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 23:57:58.3676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8umaGkqgL88oA6JuLG3zmlBaKV7HTHv2e3DOIAq/HY/QFTNRBoj4nPd6V/ggfmWTeXjamHXVDsfp2ammiu3B2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248

T24gMTEvMTIvMjUgMTE6NDgsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gRnJvbTogTGVvbiBS
b21hbm92c2t5PGxlb25yb0BudmlkaWEuY29tPg0KPg0KPiBJbiBjb21taXQgZWFkYWE4YjI1NWYz
ICgiZG1hLW1hcHBpbmc6IGludHJvZHVjZSBuZXcgRE1BIGF0dHJpYnV0ZSB0bw0KPiBpbmRpY2F0
ZSBNTUlPIG1lbW9yeSIpLCBETUFfQVRUUl9NTUlPIGF0dHJpYnV0ZSB3YXMgYWRkZWQgdG8gZGVz
Y3JpYmUNCj4gTU1JTyBhZGRyZXNzZXMsIHdoaWNoIHJlcXVpcmUgdG8gYXZvaWQgYW55IG1lbW9y
eSBjYWNoZSBmbHVzaGluZywgYXMNCj4gYW4gb3V0Y29tZSBvZiB0aGUgZGlzY3Vzc2lvbiBwb2lu
dGVkIGluIExpbmsgdGFnIGJlbG93Lg0KPg0KPiBJbiBjYXNlIG9mIFBDSV9QMlBETUFfTUFQX1RI
UlVfSE9TVF9CUklER0UgdHJhbnNmZXIsIGJsay1tcS1kbSBsb2dpYw0KPiB0cmVhdGVkIHRoaXMg
YXMgcmVndWxhciBwYWdlIGFuZCByZWxpZWQgb24gInN0cnVjdCBwYWdlIiBETUEgZmxvdy4NCj4g
VGhhdCBmbG93IHBlcmZvcm1zIENQVSBjYWNoZSBmbHVzaGluZywgd2hpY2ggc2hvdWxkbid0IGJl
IGRvbmUgaGVyZSwNCj4gYW5kIGRvZXNuJ3Qgc2V0IElPTU1VX01NSU8gZmxhZyBpbiBETUEtSU9N
TVUgY2FzZS4NCj4NCj4gQXMgYSBzb2x1dGlvbiwgbGV0J3MgZW5jb2RlIHBlZXItdG8tcGVlciB0
cmFuc2FjdGlvbiB0eXBlIGluIE5WTWUgSU9EDQo+IGZsYWdzIHZhcmlhYmxlIGFuZCBwcm92aWRl
IGl0IHRvIGJsay1tcS1kbWEgQVBJLg0KPg0KPiBMaW5rOmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9mOTEyYzQ0Ni0xYWU5LTQzOTAtOWMxMS0wMGRjZTdiZjBmZDNAYXJtLmNvbS8NCj4gUmV2
aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnPGhjaEBsc3QuZGU+DQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sN
Cg0KDQo=
