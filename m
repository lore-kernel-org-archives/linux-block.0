Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020083.outbound.protection.outlook.com [52.101.195.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601113DCD9B;
	Mon, 10 Aug 2026 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368158; cv=fail; b=n9ApjjPlrQ+bdhZQCHq4MY9ldN50+3lrZD8gULegGEQJB6OPM4Iukp0tRzIgILsbw7Svkf9lAqZpP3Eg3Ak1dZyblVrKjZpl/UdCBxcdkjKyemFPG8iolfKw3/XjGw+D4YXFMtfA51rk2rTw+lSfYZKNRtgCQFKMAANtXg/R/kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368158; c=relaxed/simple;
	bh=csHdrjJ0ZwiJhgZu3pOc0lADicTmiNJRh9fINqgnDRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jzU+vU999pX3MKkpAk3IA5p5srej9ZhaMFGeksxkjrXl4ohiK3Bj74EEmqsuyVNUvJWMeDrcadX/CZHJLElgxYitP/BkoCWNTc0hboHqCndDMAdAxjctddIobsRfHv7QFBAgf0SRLo9ue6q7AtAad3jSPtKYrEz8OAcuRDucEV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBW6N94Ii2dF7GaNnxDCU5lXHH9BJynOWkSMjUybZGNsGGMAvMTA4S59Lhvsl9mgoEsUxwV2K5deBTAn8YBcdLxJJJ1i3aVjL+P7VngZUd0ricaQKPhXqWt6IgDnUYvWvOw2g2m+X5uAUKXvFWUEesXuPpFqLqQ+mrXPLhg+BDu0zlOObXRvC7QUXZRb8/IZNwZYpk51y3ns+jYsynQVZ5xsYPANM9Uic2jzMWGxfy1GKClYR3AwS00zb/dpoSs98JXEkXQXojNiKFqrGrLEhDABRAl0KgsT58qz8jZv3j95XS+IMuT9PxueF+G5gEYJ29xowdFhCZRsPCidE2F9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=O+K8c1MIgIEjwD9QSM2otRO0L6V+ry+0qYEtbE8GoC4=;
 b=i/OMv/le05gd8G1NqkE+BbQawQxrmpVS3/aMHrsw8p/0bjpc2Klbml3OQrIGvMlBNN3XHZviYw2iPIWIUWq6KJqTNMaZq3D/iGL2JrDbZmBPqg0KXir1LvTI2aKK1qiqr499ZfxQt7rSxA0l6dikQdvvYuiMOWNPpejX9bPEu6tkWWe6VRCQG3nt9j0G+awS50oAh8x1N0J98RP2FOsG8TfC2Ww4cKExfKHYmJx5FMJEjIT5eXtXVyZXgQySS6ziS61bP/1BM0kd1RUjFs5bs5bvmdOWq+qWHgH7ngTipL3/JkGLVksd2pQHfUE1TTeU/kORFcZcbkATluZHoHbusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6610.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:279::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:22:32 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:22:31 +0000
Date: Mon, 10 Aug 2026 09:22:27 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	bigeasy@linutronix.de, wagi@kernel.org, marco.crivellari@suse.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/8] blk: honor isolcpus configuration
Message-ID: <k2lz7cbhtzlx23qk2nhii46znecytdfrcyoctvpqgu2ibttdbz@v2y6jttq2h6l>
References: <20260521232956.553287-1-atomlin@atomlin.com>
 <20260807142105.382726-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807142105.382726-1-ionut.nechita@windriver.com>
X-ClientProxiedBy: MN2PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:23a::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 859af3db-8955-4392-65c9-08def6e26e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wrov1gL0nqFs7qQtBMBeeVKq+tQ1YXKd+4M8jjj1MwyzCXR/LG8A+7H2SlRWDZm+QUt1isRqKAT7TJOOcWFEERLtqciK7S80mH1Q9t8uz4vtyc0H1bqtkUPYf3NELQgNvcwW7tX6VJA4lqFEeB4qupUL8zwp21+hy46079hjWeuZ+ml6ZVifmQTr96zTSSrwIMW1QKQ8aHywqdWQ89Q10AWvDyAt8n4jYiqoWGNSXKez9fzlJCFJKMBFqUNWszxxIg4kvoidsXiTnd2mFAkMGkg8JzSuBEO0DdDVqKIcEvE6HRHyiSZ/DbG5ubk5JQlVIhpq+iOVYKAVrMDl14yJ9FVY+dHXQm308cvkoSeO3cUCTfj/hE0eNPzOHrHZTXpCEfRYMZlORDF1fgBkTIkQXe52GF7MMwzAk5t9MnWQHI6u5N82gvY2acxK4RqhslDtXcZ5dO32U7RmZ0C014B0W1DUKyToaJiGPrwBcQll7MChzhcRHlo1FncUsiHVzWmrV+DjQ14wajJicXvgRwshPqxjD3JhJn8yB7Lv5mDFaOdA7cYFgu+eFnDVlVlvJTc4RoDvWRBj9vuBAj7WBFVak7tMfxibVD/bTnClRTXRyN3mMaIbGU1XSHV1s88PDKCIcEVAFKzeXg2FJ2MtpUXzO7KDnPASSfsFf91icfOqk/Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWFTWmlHYlNvNEtTNVhFaEY2c2lrTGY1eGYvRFNRbkFTcEhFRGFkMjNGY0Fa?=
 =?utf-8?B?UGdRdGpPZmZESWtKTW5TQjk0Qlk0SWY2RzV1TTZVM0syMnpDdE9zOGdTKzVS?=
 =?utf-8?B?Zmg1MHYxM3h4VWZ0RTRCb3Eyam0yUFBwbTdBM1NzeUlNY0ZvSFFEM3VzMi9k?=
 =?utf-8?B?UUpDVGxicnl3L2J3VDlWQitudWNaSUhTY21heXVZTC9jWVVyaVVkNkRKUlRw?=
 =?utf-8?B?OWNtWks1NWNDZGZqblY1bzkyRHlDaHp6NE9tbVJtdGxsSVVhQmtLc1d0S3Fh?=
 =?utf-8?B?a3dzTTlsSXJoaVFyZzRmeGRhazNBbnh6Njd6SjRSNlVTUk9iK2pydExTckRt?=
 =?utf-8?B?UEpiOHAvR1NQTWpMVm0rdlovQmdOQnFXd3lEbUpTYkF4WWpTY0FlYlFIZjZZ?=
 =?utf-8?B?MUJiKzBqZXpLZkg4U3NlV1BQSGtxejd5RjZtdG9MMUNQUHVLM29VcmxDTmhp?=
 =?utf-8?B?d3BUc0V5b2xxdkR5REdJVUNYa21LZmdjZXBlUTBTT3BqbzJxOU9NeTdqWnQ1?=
 =?utf-8?B?SUtnMkhsbk5XNkVCcDljZHJZcEo2dytPYlVONTlFdHBoU1dqRWRhNHM1MlU2?=
 =?utf-8?B?czFZQUJ5VE9ybzlsT2l1WGp1Yzd0SmZJbmNyWWZsWHB0M09XR1F2aG80RUxl?=
 =?utf-8?B?YTNRa2phdXZZdlN0ZmlCbmYvYnBPcVFla2wvbVlyZ0RBVGtmOHpTNlMxaXVL?=
 =?utf-8?B?aWpNUGY0amRGVC9UT0dTSGdTR01mRGdHYWRTMzdxVEdVVTVHZytETUNKWW5R?=
 =?utf-8?B?VG41U1BrQm5UU2pjWGNLV2FZWXJ4bXZSSG5mbUlQZkJqUkhVOGJGK1N3OVVs?=
 =?utf-8?B?UjFCM2VEZnpDQ0U0aklBcWFmU3dxYVBscGlNMHpEYlFLVzVjNkZDVDlRYi9Z?=
 =?utf-8?B?MktDdTJSaFUyYmUvN0xsdVNVd2hNSmE5dnNLVitWaHNqRDQ2TXZaYU40d0tz?=
 =?utf-8?B?dTJDZTdHZnAxUHExc1NtVVJvZ3dwTjZ1MEVWbk9xc1pLRnNqZkxFb25ZbjBz?=
 =?utf-8?B?ZDVmZnFIdFM0MFJ5bzdZYmdkK3lxTW8yY3JSVTJxRU50N2JkUmRpUUJXekhT?=
 =?utf-8?B?TkRpUjNLdzJhQlBEdjh2UkRXc1FIMHpPTHpiV2dpQUZSeFNVckRNTlUxQ3ZE?=
 =?utf-8?B?cjNxdjdSWGhGY0J1L0NYWWFKUngwVkllMDNoK2F2ckV5KzJULzIwVHU1b2Vm?=
 =?utf-8?B?c0NISlR1OHF1U0V0TG96bk9HNmFab2hQZGNPRUpXbDBIZTQ5RHRzU1B0bjdn?=
 =?utf-8?B?VXk2TFl6Z1hrczFFK1A5ZFlCcWxuQlExWXZHRGl0S0pqR1h6bG5rQmtkeS9Q?=
 =?utf-8?B?YXdGc3o1YUVYRjlYbDhaRzlicjFaWlJLbGF2K3JYMkFMZCtqSys3MnlkSGFF?=
 =?utf-8?B?TFlPZnZSV3l3L05OWjh2OTBMVEs2d1BiNnd2dlRaaWJWL2QrVjU5bGZPQnk3?=
 =?utf-8?B?YVJNenBNZlh5UFk3VHBDUFZsOWFuRnROR0o4cy9UMCtzTzJpMm8zK1Bzc0JQ?=
 =?utf-8?B?bGRmOVRNNkdoaWdvTm5UYTMzZWVsbXl1Y3hEd01YZmtZQi9peWNJSklXWEI1?=
 =?utf-8?B?SnRNazlmaW9DamlHczlxMlhvSVJlKy9tT2F5cVQyb1pJZjdYSENnWnFBcmwy?=
 =?utf-8?B?VWRlZGVta3VZL1lVS3UydXZWMDBaWDZ0R01ZcnJJaFl2eTUzdmgwMHVRZ1hP?=
 =?utf-8?B?RFhndDdJUU41SzRDWXl5RGZnVzRJZHdGdUp5VHBjUGFDVVdlTHRNTnpwUm1B?=
 =?utf-8?B?Lzdzd1BGdlBGN3NYQndhNEZTRDdFKysrRk80dVFaOC83c2lNSHg4Z3F3VXZE?=
 =?utf-8?B?YnRjVUJEQ1BRREFKMHBneGJWVUhSMFdySGNGRnFQMW1xWGhiVDVTM0ZES0VN?=
 =?utf-8?B?N3B4VktuZi9tZU82UkRrbUFmL3JmdmJ3YmtXVlNUdzFlaC93a0FaeEthaXpS?=
 =?utf-8?B?ZHhneFozWFJrbFNTS1dTeS82WTl3OGVudVRGM0J6S1FtclU3VkpsejNsZW1m?=
 =?utf-8?B?cE5LY2xLMUppREs2ek9QRVdlRExjdUViaStwM0NpZU5nYVQ0T2t5Z1FIdVBi?=
 =?utf-8?B?OHloZmVDMmNGTTJIRlRxT2NqRlpNZHIrMkFBN3RuNWZEa3hDUUlERmFFbUFE?=
 =?utf-8?B?d3N2TFJRTm5OMUtmVnJ0ZC9LTXdsVnV6N01MZmZQclpmNkd2YWtGWDhqSFRv?=
 =?utf-8?B?dzJqQWp5UmZxaWNBOVRyKy9xcFl1Vy9YWkJ4SmYrV0k2Q2hrbFFTM2JmcTB6?=
 =?utf-8?B?MGtnWGZxQUlNMkRnazJkVXlTSkRnRmh1TDUyaHhxRVBieUtZK2R1NUtYMWxE?=
 =?utf-8?B?ZWgyUGNua0p5bjVIYWxrN2xpWWxQS3Y3UEJ2WlBCNnB2ZHJzcVdPUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859af3db-8955-4392-65c9-08def6e26e96
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:22:31.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1akXS+l09ID9tsMxOwuue5ZFXd/DoOshYZlafDHbVwMRSq9E4QwATnaPE8dhlgHK4jlX3sdO2W6TLL5yqFi7Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6610

On Fri, Aug 07, 2026 at 05:20:45PM +0300, Ionut Nechita (Wind River) wrote:
> Hi Aaron,
> 
> We're tracking this series downstream -- the managed_irq best-effort
> gap for blk-mq/NVMe queue mapping is exactly the limitation we hit on
> PREEMPT_RT telecom controllers with narrow housekeeping pools (GNR-D
> 144T, most cores isolated, 24 ice PFs + 2 NVMe).
> 
> When the next revision lands (with the naming/integration changes from
> Sebastian's and Marco's feedback), we'd be happy to test it on that
> hardware and report back with effective_affinity + NVMe queue mapping
> data.
> 
> Thanks for driving this forward.
> 
> Ionut

Hi Ionut,

Thank you! I would appreciate that.

Kind reards,
-- 
Aaron Tomlin
