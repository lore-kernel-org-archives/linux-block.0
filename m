Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA592BFC73;
	Mon, 10 Nov 2025 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810499; cv=fail; b=atMPdUJ5L0SYBg+smcSFYjY4oWu5qzQfyKgyqO7ybL7+UUnqFzD1mNFxJlz+aJ8MsIIXAaVXitbzqvULqU+vTtPJVY3KSo8KbqUJTW3KnRpMPkDBTGbOy2nrgHp+vbRF02ZFQZHzXikcxV9tFBeYSXI+miYL56u++AJy8vyjWZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810499; c=relaxed/simple;
	bh=OHijyCtFGWOR5pA0MuWUDZmkfEisyuSEiC1a72hCOg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=szfgrsPZQXPBTcegxsg1do0JHyh8QKGstN/K9fjSQSsFm7sTxoKLtrqv1O7Yj1ffkr4qBGXsMnf+JY+ENn3qPUElpLLbbGoJ1wN1WzRFCu85XTbO5LWzTNUjjBwNw7ZIoPL7qfy/4ruz6w6Dhs9he1lKZya60i1ID8WpHEbdWmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h2+i7d9V; arc=fail smtp.client-ip=52.101.56.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h2+i7d9V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9zUbyG+9QHYv83Hxgh08jMQ/blClCTCnFlbdzeV9abWEzZLLqcfehoGoo/69ekaw9ZFzS6HdvMbpvYyoc4hxSDYU/fvvZ8TazQY6Xqeko/mGNDtPA3K9YWcW9r+F/tzW0WXx875+nF3jqvpvoeniTaHPHfhD78PktEuGC+TVeCyWIBre6s0z0ZChu0oDo1uLDg1vIv/ajJPtxWPMDljYaQBhpDoV3k+2E9O6KpeMY0n9sZKt1dSYx/f/TLsXnTD5CgcICnJnYYmsB8vSvsX9MWki7MjCesmGHd4wCA0n659ScNrfGDz/2/Mphe6dgoWQ1ki6ZhkIvonSIG8tUXq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHijyCtFGWOR5pA0MuWUDZmkfEisyuSEiC1a72hCOg0=;
 b=gLEzU+pPFvRiPe7tIPUjkh5/sGRAWLmaQvlkOZEojwjSsSJLpH2EBgPdBOX61Bi2Oa7wt9l/UVWoR6U9rODZU89siBa/mloFZcGj9O6e0ssCDLw7iaDzIvrWnYBRmyvub2nUDavgpTplRTt1h0wi+qGhXD1SolCiZsNvFMaXl5MOvAbq1KJFPmiTE0uWGsouo8zQ6ibH6Pj6StuS2NtPmUykTBvLVZA3r1JfNKtJquMjS7Qcn3Q78rb5vAqITaKyAmZlvzhoQ/a8BmHAJ+etpUxnVjK9rOC44ZYOajJwIKaCS97W7Jg0kn6SeU4v+pwtR2T0f+dKJz39JX87R2y7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHijyCtFGWOR5pA0MuWUDZmkfEisyuSEiC1a72hCOg0=;
 b=h2+i7d9V59oALlC9Ob6MpoHsWKbVJjlUW915v41mjVQAjrt71KeRWkm7KPQwpOlY1IkPEzQyh7smF8EZlxWojjBDJk7m7P7rbaZ/5bP8Hn8FbKv1INGQMd4Qw9bMCFWEKl8u2UB7DWaUhMzCkDOV+HqE0S5/CvKyaGhiadYQ+BVUrPVzoRCo7KX0yZOSsPsnBlr+qxB9nNOgQDBzaJls56eDFZIZlnoGoGtOkskpEHPkd3ZLDle3ubZtq/klDPDbeVdMt8GkXadb2hYQKfXflQ6hzKWzoFqu9/FKl8Dsd19qgu59QzfKzyiWgAJGlq5flnBFhXvuQiQJi9gsahQI9Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 21:34:46 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 21:34:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Caleb Sander Mateos <csander@purestorage.com>
CC: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH 1/2] loop: use blk_rq_nr_phys_segments() instead of
 iterating bvecs
Thread-Topic: [PATCH 1/2] loop: use blk_rq_nr_phys_segments() instead of
 iterating bvecs
Thread-Index: AQHcUQOdjgtc2W0TJUScOtgtPtkTArTqRDcAgAHdPACAAFAmgA==
Date: Mon, 10 Nov 2025 21:34:37 +0000
Message-ID: <23b538a7-904d-4fc3-89ff-9a79904c0683@nvidia.com>
References: <20251108230101.4187106-1-csander@purestorage.com>
 <20251108230101.4187106-2-csander@purestorage.com> <aRCG3OUThPCys92r@fedora>
 <CADUfDZocSmRC2uSiY=1gayxQ5TGAcCnKQRSg+4SeficpQ3Bfhw@mail.gmail.com>
In-Reply-To:
 <CADUfDZocSmRC2uSiY=1gayxQ5TGAcCnKQRSg+4SeficpQ3Bfhw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6603:EE_
x-ms-office365-filtering-correlation-id: afc7a6ef-b613-4444-5e2d-08de20a0f32f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?amJNUUNRSENsNklQakNkM1ZuVEl3VkIxdUptRngxWHJYaTc5dmFrVktFQVlM?=
 =?utf-8?B?UWcxVkFlRmp5VjYwWURaQjJrQ012QU5UTWRXRU9kdmtleVhkU0xzN3FvS1Vi?=
 =?utf-8?B?Qzk1NHZPM2k5QkloNmVJbW9vMXNkdlhSVEVYQlg5WkRpY0ZaOHdWMEVPd2V5?=
 =?utf-8?B?a1ROTzBsazc3Rk5uVEtlWTBIQlpoMVNnREdMOHFmbk1IY3hxcjN3QUllLytV?=
 =?utf-8?B?YlVFNFRqY0tVd3lXYlhyZ1lkS1NYQjFhRUh1ZlJEN050alZtU0tMaEZoN1ZD?=
 =?utf-8?B?aFBYQWEvQkgwUDY1UERXSWRCb0VqL3Q1bUtnRFNIQ1MwdytBd0JMQjMzRFVU?=
 =?utf-8?B?eXZwREhLNVdPbktQTnRFRWJUSUJ5UnFpTmh3WXFYVGRTY1FoaEFzTFRMVHAr?=
 =?utf-8?B?dWI4c21JcHluNngwOE5KM1IydytNZXhRc0xqWno3ZVpFUE1jZ1A4V0NSbW1C?=
 =?utf-8?B?azBDZnhLLzF6cSt5STVNdzUxcDE4OGNoUk5Mc2xUYXB5U1VDU0dFSXlSdTZF?=
 =?utf-8?B?Y3BsUFJlQjdvanphQy9KNGhyL2VsWE9Wd3ZDNkdzVmROUjY0eGRsbEdhek1l?=
 =?utf-8?B?L0NZOTZUWThqZjlEVGRxQjdCTURBZzdoUGpmWTNPRFcyM3ErVmVJYStJalcr?=
 =?utf-8?B?OWU0aU5sMVJnejhodUsyNHRsZEZsZ3VsNkJreTFLUzhadEkwRTEyMTA2S2NC?=
 =?utf-8?B?R1VSU0d1SG90MDVBb3BLRWhuTjUvYVBHcGVWTEVhRUgyN3RZaFhaUnBKNkhM?=
 =?utf-8?B?REVzajNWRzcrNjhSOTk1aWt3MEZEM2pTUXdPTjk4YXBEMm5xUFpZNTFjMysy?=
 =?utf-8?B?M3NVb0NpM0UzdXRvaFA1MytmWFgxUkRTSC9QdUhnNDU4TjlVQzMySDIxcmdV?=
 =?utf-8?B?QVVVd01UbXp5TUt6VXIyRk83UzBtWjlvb0Y5YVZEc010d1AwL0NQSm9XVVpn?=
 =?utf-8?B?bEc5NWJwa3F4VDROWlVYN2lJSmhVTklqOTBvQjBlemhyZGJGYy94bDFxUER2?=
 =?utf-8?B?VnA1THM0Q3lvOThSV2ppL29hcVY4cUx0VXpnRW8yOVIxWTIvU0R3eUh4NHhr?=
 =?utf-8?B?WDhGMnFzeUVreVFraUtpNEc5bE5nRHBjTEMzWU9SU0FWamJsVTFQd0ZGVmJE?=
 =?utf-8?B?Q3BWNUVKc0xIWjZpbTVMbGlqdFlJUXhDaU8xZUI2Y3VkdVl1cG5JbkFhc21M?=
 =?utf-8?B?UWd3SkRPbHZvaFNNcVNvL3cvemdrVEQ2VWJzcWJzalNHc2RkWlVRVGFMeTdk?=
 =?utf-8?B?TmFZcnZvOWdxcXhuSkhBUlpab1FVNVltYlpIdmVlbVNRRUdsWlhnMEMwNnBY?=
 =?utf-8?B?QmF5YXVOQy9OZ1d4eEEydndFQklvWnE2U2Y3N2FtRmEra2QwUjhzRkQ2YzB0?=
 =?utf-8?B?MUdBbENDb1ozOXdhUUZxckRPc2ZiVVBCdjhpVTVIWjdjR0J4UjBwZU8zMEdY?=
 =?utf-8?B?RlZyeWxBck1BaHN6cDNzQmZyY1hGNTA4SlRBbkxvTlVGRSsyaE9PTkxzZTlH?=
 =?utf-8?B?Y0k3UHZ6K2RBTjQwV2JBdDZ6MXloTEVGZkZOSWZ6NTVNbitBOUZNOVd3Rk9K?=
 =?utf-8?B?N2EzR0g2bTIyRHZ4QXpUNExiaGZZdm43M2ovU2NKaTQ5QklOZDNmaSsra2VZ?=
 =?utf-8?B?bjRhYjllRmV2RFBxYnpyWGVHL0VCRU00bWJKSHlCSFdPNjhzbGcrcmRNTmlz?=
 =?utf-8?B?UnhONk1GVXZMbzc5K2dxMU9uNGJnMXFUcGhWaE55QThwM2EvQTJ1aEZpKzZa?=
 =?utf-8?B?Rk90cUszM2pwMUowaDV6UG1CTVdRbmpmR21OZXdmNHdKYW5GWjBJNk4rRDVG?=
 =?utf-8?B?MlNuS2djOFJBV1dXUnZIYzAwL0d1cmZraHQ1ZHhTQTJMU0FzTlhvMDB6MTN3?=
 =?utf-8?B?NnVPT1Fwd1hMbmR4OXB1anorWUYwQzF4TFdKNDhqdFgzS3lUYWE4RENOM3Q4?=
 =?utf-8?B?bkVnRlVacTEza2JEVjY1eUNKUkdiV21VdVBsTzV4cWdzTk5vSDVKOENVYVNR?=
 =?utf-8?B?dWo4RXVEQVV1TWM0TENCcWU4STJxRGhhYnlkczJPdVRRM3pmdS8xWkZmejVo?=
 =?utf-8?Q?Kq2swZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFAwb0lETTlTWWdicVQ3R0xTRDBQY1loN1pUWkNaNWEzNkYvUGpkczRCZkFi?=
 =?utf-8?B?VlRLR1hheEhzcDZjOWc2T09iQzVRYzE0UWplNXF5RXB0YUZrSVg4eTFaSFc5?=
 =?utf-8?B?bncwSFBSd1NyWHg4LzcyRENoWkNzSmQyaGx0cFMreldSdHZ4amRTZkJMcUZw?=
 =?utf-8?B?SFdiLzc3NDRlL0Znb0NUaDcxeTFPRDBaWlNLMjk3WlRaZmFzcTM1YkoxU2Fy?=
 =?utf-8?B?blp6Q2xJUjgzRzJiMEZFNHFyU2Q3WDZZODV5OTdBSDZURGxQV2N5NGd6ZStZ?=
 =?utf-8?B?WkZIZjdnSll0WEY2TmMyeEJHYlQ2eG9aZDUvUWRMVTZEMlJUamhXTEVRaTV2?=
 =?utf-8?B?ZkovcURzeDhBelJCeHk5WE05TWc2a0I2NlhXN3NYSnJ3SkRzd2sybXBSMFl6?=
 =?utf-8?B?SUxQR2o2SWQrRkJab2JRcWpacXh3VGJkWU1EdnZieE81VmR1cHpheVM5a003?=
 =?utf-8?B?Rk8ydXZxSXU2NG5KckhxaUo1MHpiUWh4bTVpaTBzYzl4UFBsVTBRbDNFcGdX?=
 =?utf-8?B?VzF3WFVabDg0ZTkxQlUrd3RZeFg1L3FGdFNwNmRLZkJKMnNSZEpwc2wwWnUv?=
 =?utf-8?B?TUxKYm5rVDBXZVFXT1UwaS9VUDl4Y1EwaTF5YXU2ZDZqMks1ZTY4bEZmTkpn?=
 =?utf-8?B?ZHMrTUFuTmxFUXladEoyRjF0U3RCRkdiUUszanFqUzJMNElJd2ZRL0JENm5r?=
 =?utf-8?B?Zmx1cytuaHJpcG1Ja25IWWVmak1ha3Nlb1NKckxhMDZYcTQ0dGFNSUNyanp3?=
 =?utf-8?B?WnRnV3A2MGFIc1BsbHdTcXY5cjNRRU1ic2dMOXkyYThBLzVWaHo2ZTNFQzJy?=
 =?utf-8?B?U290NDExT1RYVFhTTWNRaHR2MmZtbnRzQndMRmgwSjFVVnFvc0FOV2daRXor?=
 =?utf-8?B?Z0ZCZEN5d1FvUmRmbmN1cCsvYmdwWDBGVHc1SXQ1YXMzdGkzeWc2YUIzYWY5?=
 =?utf-8?B?RXRJL3RkVnVDeS9RV0xtRHVwRmF5REJMUUdmVEhyTzV4eU1XZkt3Q1poU2h2?=
 =?utf-8?B?VFZKcTJKcFI4SHcxS3hxdC9DV3lzNHJiakhvbjF0QStJbVg0QjdFQXVuTnlp?=
 =?utf-8?B?RENheFowL2JzUDZHR3Y5a213QklRM2VpcnNaYXdNM3QyS2szTDNmOGVCdFY2?=
 =?utf-8?B?VFdRVUJwdWpuRG1ZdzJEaXdoVnlzdHI4Q0UrZTREdWhXMFNQSnVPandLZFdt?=
 =?utf-8?B?MWpLNGY2QUJia1RSUlg3M3hlekNRTVBucnZYR1A3VDgyMVB1ZFI5RkJlV1RL?=
 =?utf-8?B?alFlLzJtS1FDM2F2bW1qTkd2eWw0N1ArUXA5Y3B0UEdRQ2ZpQ1E1b0FmTEE4?=
 =?utf-8?B?NnJEcjd0SlIyWlpXT3Fyc3I3V2RxQkVVMjNSVCtuS3JRWFdhc1V4Z0xVT3g4?=
 =?utf-8?B?NDZHK0tVNWdWK1JRVS9JV28yTlJYeGh3YVRGMlJjU0diUUNNdUJ5anRSNkFD?=
 =?utf-8?B?YVdDY0dVbmVRUWhxWVdrMzlmaHN6YkdxL0t2a1NrL1AwV2hnNGt0VjRuS3dN?=
 =?utf-8?B?VGw0VUdhVGh3L1VHYmdJajQ3LzFCNzZadEFYU1NVRUVQQ2s3ZlU1ZTdkcnZw?=
 =?utf-8?B?aGIxRFFKTGdEd2N2SEJicXhGVDV4YUpTV1UrMXRUUW9tTFNaa0hFVUlUZUds?=
 =?utf-8?B?aWpOTmhjWXliL1dCMEpvSGdVdDdrV1dkcVJIUTc5TGpHdytvSmFwMHRaTGVo?=
 =?utf-8?B?N1d4bjZFZ2wwZnRYcmQ3MW9pZVZGWkJ3UlpVVE1FNzQ2UGU2cGo0N1NuRTNR?=
 =?utf-8?B?Q0xZSndXQW03Zk90dVZhWDJkVEtHNzJuMVgzTlZFMmRqYitTRXQwYzYxeGd3?=
 =?utf-8?B?K2hJS0c3ckhjdlpUZTB3T2JMK1J5RENuWGpDaHpLSml4UnJSVWh4STVDN29w?=
 =?utf-8?B?VEh3NUZRMUMzL1EyZVJoQmV6Ti9JbmtqREN1SkpuRUd3aytkQWJ6Umtzb1ZY?=
 =?utf-8?B?Qk81RnEyMFpoMStTVE5sN1hpTExheVZsOVV3UEpTa1VrU3o5RGFITHUwZHBs?=
 =?utf-8?B?VXRzU242MnlUUmtaNjhFY2hCMFFlRzROMi9EVGcyZ2w1L1F6OVM1NHVJTVJH?=
 =?utf-8?B?dEorYlZRWUZ1bjZxTDNGLzRUM2RCWkdXY3laTzRmQzk5WWhraFlUT1pZcnQw?=
 =?utf-8?B?TW5jNzY4ZVE5akpobSt6VlR3VmdrMGVsN0h2M3VDYXFsTEtraHFqTzd3QVZm?=
 =?utf-8?Q?DcnrFzUXzMJwGXhaFsr1sONgzlqb4caDJnKar6VSuX5/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7069947DDAF6445BE5E893427BC7E99@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: afc7a6ef-b613-4444-5e2d-08de20a0f32f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 21:34:37.9824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0pBYFnCV5SocRzxrSUA/P7u5kL7N0XLqaiI74L6nHMiU5HOjx2PzwNNv81MQIPyF8o5KpXgKavJ5nK0VzATbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603

T24gMTEvMTAvMjUgMDg6NDcsIENhbGViIFNhbmRlciBNYXRlb3Mgd3JvdGU6DQo+IE9uIFN1biwg
Tm92IDksIDIwMjUgYXQgNDoyMOKAr0FNIE1pbmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29tPiB3
cm90ZToNCj4+IE9uIFNhdCwgTm92IDA4LCAyMDI1IGF0IDA0OjAxOjAwUE0gLTA3MDAsIENhbGVi
IFNhbmRlciBNYXRlb3Mgd3JvdGU6DQo+Pj4gVGhlIG51bWJlciBvZiBidmVjcyBjYW4gYmUgb2J0
YWluZWQgZGlyZWN0bHkgZnJvbSBzdHJ1Y3QgcmVxdWVzdCdzDQo+Pj4gbnJfcGh5c19zZWdtZW50
cyBmaWVsZCB2aWEgYmxrX3JxX25yX3BoeXNfc2VnbWVudHMoKSwgc28gdXNlIHRoYXQNCj4+PiBp
bnN0ZWFkIG9mIGl0ZXJhdGluZyBvdmVyIHRoZSBidmVjcyBhbiBleHRyYSB0aW1lLg0KPj4+DQo+
Pj4gU2lnbmVkLW9mZi1ieTogQ2FsZWIgU2FuZGVyIE1hdGVvcyA8Y3NhbmRlckBwdXJlc3RvcmFn
ZS5jb20+DQo+Pj4gLS0tDQo+Pj4gICBkcml2ZXJzL2Jsb2NrL2xvb3AuYyB8IDUgKy0tLS0NCj4+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pg0K
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL2xvb3AuYyBiL2RyaXZlcnMvYmxvY2svbG9v
cC5jDQo+Pj4gaW5kZXggMTNjZTIyOWQ0NTBjLi44MDk2NDc4ZmFkNDUgMTAwNjQ0DQo+Pj4gLS0t
IGEvZHJpdmVycy9ibG9jay9sb29wLmMNCj4+PiArKysgYi9kcml2ZXJzL2Jsb2NrL2xvb3AuYw0K
Pj4+IEBAIC0zNDYsMTYgKzM0NiwxMyBAQCBzdGF0aWMgaW50IGxvX3J3X2FpbyhzdHJ1Y3QgbG9v
cF9kZXZpY2UgKmxvLCBzdHJ1Y3QgbG9vcF9jbWQgKmNtZCwNCj4+PiAgICAgICAgc3RydWN0IHJl
cXVlc3QgKnJxID0gYmxrX21xX3JxX2Zyb21fcGR1KGNtZCk7DQo+Pj4gICAgICAgIHN0cnVjdCBi
aW8gKmJpbyA9IHJxLT5iaW87DQo+Pj4gICAgICAgIHN0cnVjdCBmaWxlICpmaWxlID0gbG8tPmxv
X2JhY2tpbmdfZmlsZTsNCj4+PiAgICAgICAgc3RydWN0IGJpb192ZWMgdG1wOw0KPj4+ICAgICAg
ICB1bnNpZ25lZCBpbnQgb2Zmc2V0Ow0KPj4+IC0gICAgIGludCBucl9idmVjID0gMDsNCj4+PiAr
ICAgICB1bnNpZ25lZCBzaG9ydCBucl9idmVjID0gYmxrX3JxX25yX3BoeXNfc2VnbWVudHMocnEp
Ow0KPj4+ICAgICAgICBpbnQgcmV0Ow0KPj4+DQo+Pj4gLSAgICAgcnFfZm9yX2VhY2hfYnZlYyh0
bXAsIHJxLCBycV9pdGVyKQ0KPj4+IC0gICAgICAgICAgICAgbnJfYnZlYysrOw0KPj4+IC0NCj4+
IFRoZSB0d28gbWF5IG5vdCBiZSBzYW1lLCBzaW5jZSBvbmUgYnZlYyBjYW4gYmUgc3BsaXR0ZWQg
aW50byBtdWx0aXBsZSBzZWdtZW50cy4NCj4gSG1tLCBpb19idWZmZXJfcmVnaXN0ZXJfYnZlYygp
IGFscmVhZHkgYXNzdW1lcw0KPiBibGtfcnFfbnJfcGh5c19zZWdtZW50cygpIHJldHVybnMgdGhl
IG51bWJlciBvZiBidmVjcyBpdGVyYXRlZCBieQ0KPiBycV9mb3JfZWFjaF9idmVjKCkuIEkgYXNr
ZWQgYWJvdXQgdGhpcyBvbiB0aGUgcGF0Y2ggYWRkaW5nIGl0LCBidXQNCj4gS2VpdGggYXNzdXJl
cyBtZSB0aGV5IG1hdGNoOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9pby11cmluZy9aN1Rt
ckI0X2FCblpkRmJvQGtidXNjaC1tYnAvLg0KPg0KPiBCZXN0LA0KPiBDYWxlYg0KPg0KUGVyaGFw
cyBJIGRvbid0IHVuZGVyc3RhbmQgaG93IHRoZXkgd2lsbCBiZSBzYW1lID8gY2FuIHNoYXJlIG1v
cmUgZGV0YWlscy4NClNlZ21lbnQgU3BsaXR0aW5nIDotDQoNCm5yX2J2ZWM9MSwgYmxrX3JxX25y
X3BoeXNfc2VnbWVudHM9MiAoc2VlIGJlbG93KQ0KLSBPTkUgbGFyZ2UgYnZlYyBzcGxpdCBpbnRv
IE1VTFRJUExFIHBoeXNpY2FsIHNlZ21lbnRzDQotIFBhdGNoIGFib3ZlIGFsbG9jYXRlIGFycmF5
WzJdLCBidXQgaXRlcmF0ZSBhbmQgZmlsbCBvbmx5IGFycmF5WzBdID8NCg0KKlsgNjE1NS42NzM3
NDldIG51bGxiX2JpbzogMTI4SyBiaW8gYXMgT05FIGJ2ZWM6IHNlY3Rvcj0wLCBzaXplPTEzMTA3
Miwgb3A9V1JJVEUqDQoqWyA2MTU1LjY3Mzg0Nl0gbnVsbF9ibGs6ICMjIyMgbnVsbF9oYW5kbGVf
ZGF0YV90cmFuc2ZlcjoxMzc1Kg0KKlsgNjE1NS42NzM4NTBdIG51bGxfYmxrOiBucl9idmVjPTEg
YmxrX3JxX25yX3BoeXNfc2VnbWVudHM9MioNCipbIDYxNTUuNjc0MjYzXSBudWxsX2JsazogIyMj
IyBudWxsX2hhbmRsZV9kYXRhX3RyYW5zZmVyOjEzNzUqDQoqWyA2MTU1LjY3NDI2N10gbnVsbF9i
bGs6IG5yX2J2ZWM9MSBibGtfcnFfbnJfcGh5c19zZWdtZW50cz0xKg0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWluLmMgYi9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL21h
aW4uYw0KaW5kZXggMWZlMzM3MzQzMWNhLi43NGFiMGJhNTNmNjIgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYw0KKysrIGIvZHJpdmVycy9ibG9jay9udWxsX2Jsay9t
YWluLmMNCkBAIC0xMzY0LDcgKzEzNjQsMTggQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudWxsX2hh
bmRsZV9kYXRhX3RyYW5zZmVyKHN0cnVjdCBudWxsYl9jbWQgKmNtZCwNCiAgICAgICAgIHVuc2ln
bmVkIGludCBtYXhfYnl0ZXMgPSBucl9zZWN0b3JzIDw8IFNFQ1RPUl9TSElGVDsNCiAgICAgICAg
IHVuc2lnbmVkIGludCB0cmFuc2ZlcnJlZF9ieXRlcyA9IDA7DQogICAgICAgICBzdHJ1Y3QgcmVx
X2l0ZXJhdG9yIGl0ZXI7DQorICAgICAgIHN0cnVjdCByZXFfaXRlcmF0b3IgcnFfaXRlcjsNCiAg
ICAgICAgIHN0cnVjdCBiaW9fdmVjIGJ2ZWM7DQorICAgICAgIGludCBucl9idmVjID0gMDsNCisN
CisgICAgICAgcnFfZm9yX2VhY2hfYnZlYyhidmVjLCBycSwgcnFfaXRlcikNCisgICAgICAgICAg
ICAgICBucl9idmVjKys7DQorDQorICAgICAgIGlmIChyZXFfb3AocnEpID09IFJFUV9PUF9XUklU
RSkgew0KKyAgICAgICAgICAgICAgIHByX2luZm8oIiMjIyMgJXM6JWRcbiIsIF9fZnVuY19fLCBf
X0xJTkVfXyk7DQorICAgICAgICAgICAgICAgcHJfaW5mbygibnJfYnZlYz0lZCBibGtfcnFfbnJf
cGh5c19zZWdtZW50cz0ldVxuIiwNCisgICAgICAgICAgICAgICAgICAgICAgIG5yX2J2ZWMsIGJs
a19ycV9ucl9waHlzX3NlZ21lbnRzKHJxKSk7DQorICAgICAgIH0NCiAgDQogICAgICAgICBzcGlu
X2xvY2tfaXJxKCZudWxsYi0+bG9jayk7DQogICAgICAgICBycV9mb3JfZWFjaF9zZWdtZW50KGJ2
ZWMsIHJxLCBpdGVyKSB7DQoNCi1jaw0KDQoNCg==
