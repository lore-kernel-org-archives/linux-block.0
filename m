Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADDA30CD9C
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825859; cv=fail; b=D15N+pwlFCyfpp8EGcQ3dDOGe5KKY99clpxDD/evVFgmTYDO7LuDg4lbfIf7f8jg023FmuKQdFykGrxklHgd9Cw5d2duIISMrRFZ9+ng3VvP4XMivKteDiXvQQE33hfWBNkdV9b+UBK+t+gkLwho2/iCQbTWud+y6rhhyOK6YG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825859; c=relaxed/simple;
	bh=f8UNRpbxZSx6jxPIeS+aN6yUdlfIbYgHSZPv7rViii8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jU12iZVYDdvs69s9Rw7Xc4WS+PtcSFNYNVWkh9kB4tEqiec3n/8BnV8chjJdeYIJAubpC+auhAEGuYdcB8OUybX/rF4cPzC0owGc2K+akCa51HCDLL51mk0et3JiGtOwFdmisH7QHqkq2YKcTKjJ3yyXKZWGcbnzolYlkXZ+8CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gRj3PtkK; arc=fail smtp.client-ip=40.107.200.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gRj3PtkK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXlDHZUbYxKbhAKMX5tL8chrcMtaw3s6U09GlfAElmJ/lR7frOzdXR+HwQnJKaAGuLJzxX/1l+h4ucsIWwcBWteoeqwcZ23CO4pb8BrQ2I8Z+Aoo2TtejZkslLLMPQT2tihuW4fNqmctxIzaJ+kwcESLjGRJdNQIlQS+XF7eRSL6ufQwPufzVn5hh5mTKbN4VIDhwxCslXY5c5rs9RBNab1A2QwttbJRdIebee6TfZkTRzYsgvML8QSixfFQIcvztTVFNzkFb9d5bWqOtWTnyZ9zDTuA9q18bs6OzVjaX7Q/dRLWkUdRT8eJmrCC/n2/WWCWNR3UdHTNbCZSMUbiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8UNRpbxZSx6jxPIeS+aN6yUdlfIbYgHSZPv7rViii8=;
 b=eMvOT024MnLltvlu+K+ARMJr2H6jjF/ZkiHTopRUJlT1Gng/jHpgIm59dJmOSXU2ceN0tq9YKw5x6YLfYyYpIpeDUpodc1IlAnEPM8sx6wiLJIXmpskk1JY/5cq2KCrO9WHmL8+vhjf960mi7h7lWzJZ7mwISZ844KwWiZPSzChBgNAh+C/QdjFhPUqSOn5FGT4N57g2YMHAoAcjczMKp9y5MJF4jgY+NsGpCyYsvcrZPOy+m7Y1fUbPnXZRRX7kpf3av1jxZ/eNLdS0Fh28kOy8EXYwr8qh1O2J5yhKs81jbUJniZxK3z677TemupRm0uvsIeh/3eFS3jQd+J7Ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8UNRpbxZSx6jxPIeS+aN6yUdlfIbYgHSZPv7rViii8=;
 b=gRj3PtkKUzw7VG+k6div/4q7/w2QIy4eiWR1PiFlOqQr3TeR9DWdsw8LNrdbcvqq5YxHJBDqypFo+e79FK0WxRyO7NdHLynfQ547udruwEO5dtLBdVKKEfSy5q/OnAI6TuGrt1PKbxlZ/oVd8vA2/7Ry63RO7fu31+UbO5rvDzj/xlvjGlVN6hMDjH74nRNOx4df9fgTAy7Bjo0MO5okf93cPFiQONuBjQjmBmqOdeCN0f5JUZNrXmZe6xbXn7ghJJBplOx+zW+gOaB1/v0c8Lvvl3TIptKFGrTMQcOWqk57tNmjhpnV+yv/7tqQffR3vYJNERRHsMX8LKWbgqEnVg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:50:55 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:50:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 3/4] blk-zoned: Split an if-statement
Thread-Topic: [PATCH 3/4] blk-zoned: Split an if-statement
Thread-Index: AQHcUpN6mgIlHYYkoEKA2XLD7euwMLTsthQA
Date: Tue, 11 Nov 2025 01:50:55 +0000
Message-ID: <33c776bd-e0b3-44b6-8ca3-916fa2f3a50e@nvidia.com>
References: <20251110223003.2900613-1-bvanassche@acm.org>
 <20251110223003.2900613-4-bvanassche@acm.org>
In-Reply-To: <20251110223003.2900613-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ1PR12MB6242:EE_
x-ms-office365-filtering-correlation-id: c45b9b0d-7dab-46fd-bac3-08de20c4c0ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEliL0hnZnBTRjY0Sk53b0RtYUhVL3pZUm43K3BpZVNHeTJLaXJvUGZkZDl3?=
 =?utf-8?B?Z1Y2WTFpZVR0RkxSMzlSNDZlQWIzemNDb252V1ZrQXJYKzNWRDc2TXJPTDg0?=
 =?utf-8?B?WUtrc25SMEJqdnhEQlJrd0k1U040ZDlNZUZ5YnVSSjdtaXdZdTFTR1JCNjNH?=
 =?utf-8?B?K0U4d0tLeG9lWmpCUU9JQld6NVd4N1IxMW9uTmt6MmVpZThBeUFqYTlJM3NH?=
 =?utf-8?B?ODdUdUkzcVo1aWxJU054Ymw5OUptWVBITlZBKzB2ZUZLdWlDVDVTOVlDQmxT?=
 =?utf-8?B?VVNoYnB3b3V1Ym92ZDJrd2oyUGxEelRjT0FjMy9aUmI5UUVxcXlDcjNVck9i?=
 =?utf-8?B?TXBNenlDT096dDZvVjVRM1pKN3JQaStpaGtwUy92MHhPNGx2Zm53RTNWMHhN?=
 =?utf-8?B?WlFSa1hGNnA5TGJPM05JYzVLWk44aG1pU3NuT3lTUGhhYjcvYXdVQ2xORHJj?=
 =?utf-8?B?Ym9ZMkgwWi8yK05wWGRzVnVRVTB5Qnh5cVNvUWNac0wxbkVUM3hDenBGRFZS?=
 =?utf-8?B?SmpBcUU1emdweUhiOEpvRlNXZURleWtBNEpaMk1kSHhnR3A0SzJKOXZydTlr?=
 =?utf-8?B?TGRuUkZrQUxWTUoyYkJzVFpuT1VlK2F1Y0dRRlZmeDRESUt5K29KZ0FwSlhZ?=
 =?utf-8?B?ZHBjN1Jtd3p1VGZ2K1hISEVnRnY5SXkvck9oWWMvWkJYeTVCalNhWEcxQm1O?=
 =?utf-8?B?OXRoeWZLMDFncExZZlI1OEVqOVhBbEVwNXRVZlNIcFZndU9KZEZwS29HRmE1?=
 =?utf-8?B?Y2haSjQyMDNrVmI0eW1IZEExRnBOenBSemJZc2IvYmRXYS9GWjl3WVdhRzhu?=
 =?utf-8?B?ZnJLSnJYWW8xMFUxZFdWZjVOSmxHQ0NlTTFnQUdEeG5KVzNsSHRCL1BmUzFH?=
 =?utf-8?B?MWp2VHJCdHdYbXk0VkRjOVAxbVd5czA0VGJ1SXhKb1ZacEwwOGN2SU5ML3dz?=
 =?utf-8?B?ZGh0NS9HTjkvQzhpKzdUMjhGQ2w4SWRCWEgwOVRaQkdlVlZlaVpqb1BIWVJ0?=
 =?utf-8?B?dVY3OTRyK09CaDBvQko0R3pnRTl6WGYzWUx5SnFFY2dZSW5hOGdKWndRblg3?=
 =?utf-8?B?aDZMaXd0SDdNeGJERGxGVFJ3MkVuVkFnUjVvbmpnZHI4M3AveVBsVE1BNkdt?=
 =?utf-8?B?dmRMMmdpTXMwdGwrT0JHYnJDWDYrblgxYkNBbVh4SDZnelhuaHVqUEV1OTBh?=
 =?utf-8?B?ZVB3bHd5alBxbk9YQkpaZC9QUkVLc3AzL2N0WDBuWWRjZ0haTlZYc2xYNlNY?=
 =?utf-8?B?ZzVCdDlYTVJUSUhOaUZJcllFMW5iYU04amI0blFoa1Z3NGdkUjJWOW1kc0Vq?=
 =?utf-8?B?VkdvWjQ5R2VwZ0oxUWhabGV6dDRvQXVhKzhHZkxPVVhjQ0lOSW1HNnRmYWxI?=
 =?utf-8?B?dEJqUkoyYVdBSGg3U2ZDTjBIWHIzVWZoQktXTWllUWZvTTM3VVJ1K1hwTjVm?=
 =?utf-8?B?ZndUMk5ibTAxTGFHOFo3NTEwK1ZrQWdTQjNaZzVQNHpBREtOOUc2WUFOdG56?=
 =?utf-8?B?ODJwbzZHSUQ4S1lSYkVxWWtoaHdvdGVMekpiZGZHRW9INnFuM0VzY2dkS05Y?=
 =?utf-8?B?UmdSbVU3QVpzdzEwR2NHWEIwUUJIdGtKNFpYY09xRjVENkdDbmxuVVBGbDJW?=
 =?utf-8?B?L2laL1kxSFpiRFdZL29tRlpKaGRyMEkrQUZpN0crbVdzaVdMeWM1VGVGVUxD?=
 =?utf-8?B?Rkh6R3lqYWhKZ3dScG9DL3pncGliYVlCdDQ5M0ZWZG4xd1lPL1MwL3p1bDVR?=
 =?utf-8?B?Ty8xbDhzVVhiWWFER2FMUXZCVTlrTXUwZE4zVVJOcVhqbWdQSE93ZEczT0dU?=
 =?utf-8?B?UEpHNTVCU0ZXd3FjL21tV0gwS0JEalZQNUZKbGl0NTZiekZFZ3gwVFlHRnFl?=
 =?utf-8?B?dXprQ2RwWlBma2JHci9EekMzeTIweXNMRzQ4b3dlUmVobGVUbFYrdmpDR1Zh?=
 =?utf-8?B?eUV2YlBrY3JSSkg1UEsrNlpQMjR0N01Xd1UvVk1OWkk2N0ZSMDF6SWxaNWtW?=
 =?utf-8?B?eGIvTGFhNTY0T3B1TURnYXNHM1FDdzBCa2Z2ODgzWXl0U2R4aFloMTZHZWhS?=
 =?utf-8?Q?d+RHnY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHdwZ3ZIQkxEeGhzRXJOcWkrOHY5UWdqTW9SeGZuUEU2SFBHM1U4TEJRVkpv?=
 =?utf-8?B?N2wvR1ZPdFpYTGtJMmJzclphSFVRM1B0d282eEVhSDhJYlY4MU1PWm5OY1M5?=
 =?utf-8?B?N0NwQkN5MXlMM1VaVFZmck5zUHhXNjllVlRraDVCbEVtcnVWdlpPR1h3N29J?=
 =?utf-8?B?L0k2SXZFbmxWditSeHRGOUVrZXBTRkU4T1FUWUNNVW1xdU5SdTllZXhwTlBt?=
 =?utf-8?B?VnlCUnVBbXE0TnlYR0lYdVFraDc4WG8wZitkemEzcDZRMkxBSHRxWnBCWERQ?=
 =?utf-8?B?VWhYeUp6OGdCMlc5NnZKcEs3aDZqekFISjZuZ0FQNTBSYnRNZFlHSEViaDNo?=
 =?utf-8?B?QWdFVWtmeWVIZGlHMEpkdHhxTW1nTlBlYzJGcnRvZmhVU0NYdnNOUlJUVzBP?=
 =?utf-8?B?eExUdFJtaGQ1K3J5T2RzSDl3NmFJQU1HUWFLcHZSZnQwNnNtSjVNTU1mMC9G?=
 =?utf-8?B?WjdGVG03L2pnT240MjdVS3JjN0NXNGJwTnVsY3hnMW0veFpycm0za2NEM3pv?=
 =?utf-8?B?SDR3ZlIxZWtYd0liTzdKNmQ1ZXllaWw4cGtlZndlMXJla2JRWU1kczREWkp1?=
 =?utf-8?B?THJjUGJUU0pGOGZ6SDd1Z3FESndYZ0lMVTNuMmVMcVJMc0h3UnFoY1ZrSTVQ?=
 =?utf-8?B?SnhWQkFhODZWVXRKOWo1WEQ3ZDZ2Q3FSY0Y1ZW5WZXN4TXZyKzdhajBuNEJB?=
 =?utf-8?B?UW01WVRKZmVWaUwzNGpOQzdZamxycEpWT2VGbk9pREZ5TEZlR1JLNGJpUVli?=
 =?utf-8?B?ejUxUHYrbmZWY1R1cFBkU3lhSURrUENXdnROWndGd2V2OHg0T2lBYVhiNGdw?=
 =?utf-8?B?akxjZnVaWmJwdXZFVVpYam5ER24rU3laNHErUVdmSFcxRFNoOStvaWoyM2Jo?=
 =?utf-8?B?WlhHSDJjNnVKSU5VbTBRbWlLQmtRUlNJZ0l0bFFIRStCcjRrbytLZ1lCQUtV?=
 =?utf-8?B?VkttOFpFOW9SejQzd2x6NEp3a3Qzd0FPSHdIU29tR0tTSTVPNS9aMTB6MWpU?=
 =?utf-8?B?dllwR09uVldRMXFEb2hIUmxERWxSVkVtUjk3dHNrbEFCNmlvYmV5WnQzNExF?=
 =?utf-8?B?d2E5YTM3ZmVVdFhPczZWSUcvRElDSlVtVnU1emZqRUllQUZreXRCWTE5SXU5?=
 =?utf-8?B?bHAvNFdVa3hBSUVRNUZvcHk1eEFYRWhNUWdycEtkKytaOVp0UjZiTjZ0SWdG?=
 =?utf-8?B?U3VTOFFSckxubnQxeUdFYVRHTDA4NGlab0xtV1ZqL2I0VUpLSU5jS0cvODdW?=
 =?utf-8?B?czU1RnFIcjErRjcydHZGeVdGNWpXenVldGxpL1drR0NqbkVkK2tKcXk1cnI5?=
 =?utf-8?B?aXc0emhxNWpUMXN2bE9mNUZwUnZ3TVVRNjY3L243N0k1bnFEako5VmgwckJj?=
 =?utf-8?B?cmFhdFE3ODRzb0VRU3BMU3ZqazJiV1Q0NDZ2cE1ENU9uL2N5N0QyMG9uM21B?=
 =?utf-8?B?d2ZwbUU4ZEZVTHE0S2tYNnJsK0cvajBubjdBcGxSUW52dmFpMnBvbXkyNXhW?=
 =?utf-8?B?cCtTRVpKUjkrTHZRd0s4dVdJM25QNnBNaXRMc1hra25YdVB2OExvMEp6SGk0?=
 =?utf-8?B?ck1KMUFvR2FqSE4xcXdqT1lMOFExOUgxSGE3TFNMSmtVbTFsWmcwdGsveno0?=
 =?utf-8?B?djlwSVl5QkxLTVhTaGF1RDNCTTVaMEtDY2N2VVBObzVNRm5YeEFVSXNhcGh2?=
 =?utf-8?B?VXdmaTBjN3ZodXZhQW1xRlFsSzZVWDl0Y2F2Z3ZsRnA4VXVmQ0J6YldKN3ZB?=
 =?utf-8?B?aEFGWkxiVmZWbGpDRFEzMFU5SkJMUUpFNjhVbnAycCtabnhKSjlrYkRkMHNJ?=
 =?utf-8?B?Skc2SWZueW1admJINFp0ZUNkNVVPdXhTdWdrYzF5cHQ5VlAwT3ZhUzVGVm9R?=
 =?utf-8?B?R0FZQXoyVmx5bENheFpQZzNqRE5oQ2FjYStVcFdSMytOcFhybnNYMGZsb29s?=
 =?utf-8?B?TFBOOXAxSFkzNHhVeURxNkV0YzZXaDByOVBaRlI0VGJ6VjZKRk9Ud0tHVC9C?=
 =?utf-8?B?cnVNQ0ZrWGZKY3hscHd0aWMzeGVQVmxPUXo4MDZoallIS2ZxeHp6RUpzeWJ2?=
 =?utf-8?B?bUhxQnBMYUJIbXFKaTR0TXVvdGt1eHVJRnV3RWFzUm82R0hRY1BrVHJjUHl6?=
 =?utf-8?B?NGZrMEtEZ0VkUTVEdlFTVmhDTlVQNzRFWkpvKzVnbGtER0FmUkFuRDVra0Jj?=
 =?utf-8?Q?T+aJaraRdH4tcfmbwsF0adBotZGjerfmUCuPpWEzmrcB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD3B1CEB7420B64A9A7E41C5EA5B1255@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c45b9b0d-7dab-46fd-bac3-08de20c4c0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 01:50:55.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goD/pgxwcXvz0Xn89B3FSXh6C8HyGpkfnA58t4Gwb9aE8JxcpgxR04Yycq1NbJ2DzHc5hSwsa6ngKWX0Q6cMuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

T24gMTEvMTAvMjUgMTQ6MzAsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gU3BsaXQgYW4gaWYt
c3RhdGVtZW50IGFuZCBhbHNvIHRoZSBjb21tZW50IGFib3ZlIHRoYXQgaWYtc3RhdGVtZW50LiBU
aGlzDQo+IHBhdGNoIG1ha2VzIHRoZSBjb2RlIHNsaWdodGx5IGVhc2llciB0byByZWFkLiBObyBm
dW5jdGlvbmFsaXR5IGhhcyBiZWVuDQo+IGNoYW5nZWQuDQo+DQo+IENjOiBEYW1pZW4gTGUgTW9h
bDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IENjOiBDaHJpc3RvcGggSGVsbHdpZzxoY2hAbHN0LmRl
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBCYXJ0IFZhbiBBc3NjaGU8YnZhbmFzc2NoZUBhY20ub3JnPg0K
DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
