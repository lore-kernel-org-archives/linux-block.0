Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022134.outbound.protection.outlook.com [52.101.66.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF561450F2
	for <linux-block@vger.kernel.org>; Tue, 16 Jul 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128229; cv=fail; b=ZoBI+HQjp5M4KIu2N3/yaHh3L0jqg60kJHTGcNzeo7m9MZYoG74JvramgJR/sA3o2lWHwbCKl1VqA2uXLJ8XrRUU0YY96eN6H1MVywTOl+72Us1ub5L4C4sDeLj2PFReRNDJk0Hanp3YWN/Ohk016s4TTUdK36tmY7/eFyMQ9YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128229; c=relaxed/simple;
	bh=7ts/J/SKyfYufUHrMwFuIYj4HJcYS4jHUX2zk1HE6Uk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H4OM18ejCM3HJzAgqg5NN12AYghyMatQXxWVjrQBykedNoCUFzqi4jBrUoZGl7wgmZJl87TU1Hg1oJJnT1fK900qFOvobxgeTmTSVRQmieG6I67aOzZJiNn5FO9l6/e7KEyqK/McbA8rajP6eZd1uEIvsXpZqE4ILCa30IgGdKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=H+oHj63w; arc=fail smtp.client-ip=52.101.66.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="H+oHj63w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBJmd7pMh+K2fzT/ij5hgJ+BY6Ck0p5mvB6fe38QZERC+/cGctPniEJ+K+NO1SYmfAX4yXSJbD5IZMpVuzknuu4+IgB0sWGnReIMXrKBFfAf0gFGgCZCBqCkOH+gBqD5EdCw2FBsO0pXl1PDLqUZgXRpAJ4qNKkoa+GVyW4MAbOB13IMdbUraTIJ9R82C4NGtg3m+aP+lsZAzrABWtmUJ2vFs4T7DZf+StX2GvWhJe6bdidkLAoMNgmo9J37u9orFBra7UAi+/exTB4n9hmrCVB6QZrhLlGXV88zxTYf5Xpr6FjvlkqXMKPObqsnPkSLlTHaSiTW9yzty+SfjzbG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ts/J/SKyfYufUHrMwFuIYj4HJcYS4jHUX2zk1HE6Uk=;
 b=wY56LHsUfDQc45xH3Hg8l/tmLMiqRj1rKxYfTOLlSj8oMuUVAQxL67QPjvBv88+diXcimKNs6wdxg4AjQg0YZml6UCzLNYEMCUGKRMCSST7VDzhzPreAoccaZMnZIGxsftniUrzTuooNQdIzz3qepzlVs8c1yJlINTbrmXayvCvRrUM8DwjcN1NRQqPVRDubC17nuZvs5XNGqKn/n1VOlj5wR7B4GUxQ5EGum9orvLIs8MlSrsG9VXS0gf97Cofm4B2rQFEVrx6loJLxDMzoWunYds5v9D6y5zoRGTEEhraf4UvPJ2IuV7A2Uy1yUte+gGovJea9FN9w74vA+3Um5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ts/J/SKyfYufUHrMwFuIYj4HJcYS4jHUX2zk1HE6Uk=;
 b=H+oHj63wb48ijycjXJg9MNKFxrowL1TwF2il3TJc4Q1APj47x3sa0uJVHm21nCiHofwkLNsKCKKO9H6ftIwdjqsriAG19SUpD1LSy5BXPFneGH9kfDDaaOTuMUiE0TCnIHse0Z6qRyGkRT8rsIjnRQJnk/GT9D+VVuY98XExrcLdnSZXEw6oaZNJNhHAXnrnKzhoKfvBNqfGukLTwZW+HYM738M44HKY9ku854dudrqYa2sWZB0qovWJWaDjBNSPHY0d3y+2bN+iGQckCRIqtfQgDZW75G4ORkW5/+LrcOAloN+jkLcciuAmGtvnk6Ytj4zBsA/5xM7jeEm5W9ZBsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by DU4PR04MB10499.eurprd04.prod.outlook.com (2603:10a6:10:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 11:10:23 +0000
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7]) by AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 11:10:23 +0000
Message-ID: <f0bf01ab-604f-48cb-85f5-e48978579bcf@volumez.com>
Date: Tue, 16 Jul 2024 14:10:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 1/2] nvme: move helper functions to
 common/nvme
From: Ofir Gal <ofir.gal@volumez.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dwagner@suse.de" <dwagner@suse.de>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
References: <20240624104620.2156041-1-ofir.gal@volumez.com>
 <20240624104620.2156041-2-ofir.gal@volumez.com>
 <g5ob2s5hhobdr3nwbv6bdt5yg7ca4jff6g4w5nrkaqac3ozu4s@lhre6wr43bub>
 <52ac9125-d5a3-4e5c-8708-875c845a05c2@volumez.com>
Content-Language: en-US
In-Reply-To: <52ac9125-d5a3-4e5c-8708-875c845a05c2@volumez.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To AS8PR04MB8344.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b3::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8344:EE_|DU4PR04MB10499:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a0a233-0894-4819-c1d4-08dca587e305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mm9kbXNrQi90Z0FROSt2ZENHRlhMUWlIL0VqTUxQcmpNeEdsYzFTRWVmdVMw?=
 =?utf-8?B?MFZZREtzTGEvbDVCYjh4SDZaSVZxNFl1VE1qZ21TbnlTZDAwRTJtTVUya1Jk?=
 =?utf-8?B?dGlGT2hpNGdsU1M2QkZyaVFzSTh4Y2hQaWNyZWNmMWl6MTBPNXBpTW1MOVJi?=
 =?utf-8?B?dk5VeitPMXR2ZmJSS1VhbEFVMVNFUXhoREk4RlNNOEkwcEYyNE9LT1FxeDRN?=
 =?utf-8?B?dUpBUkhaZVFDV0lZR0hXYVN5N2wvVm1Gc1F0aFk4Tzg1NEFPSEFmOEQ3QktD?=
 =?utf-8?B?QXZvYUIvbDI0ZTBxcTIzSjlMdm52c29XSU1pSjZja1hHL1c3dTZHNWRBZVhy?=
 =?utf-8?B?NjVmNkpJOHRBUVlKUmQrbDBPaG9aRGJuSHVnWUtyOXhwcVBDLzF5d0JPYWxZ?=
 =?utf-8?B?Vk9zQmdxLzVuaCtFSElGY05SZTVUSnVwSkUxL1dicDJFalc0cjlpaHBjdDNr?=
 =?utf-8?B?czcwRmdHQk5MMFloSVc2M2w3N2lJZUMzcWlKTGRHZGY5ZC9OMXpmMG00amVY?=
 =?utf-8?B?RXBscGdyWndJVEZIbnVtYUhRbWkyR081NXdMTXdtVEVDaGhMQWVtMHJydWVE?=
 =?utf-8?B?UjdWSEpyWFhFekgxaFJrOXA4ai93bDluOEJQUUNJUG5pOHc0ZStNYlZZYTFu?=
 =?utf-8?B?eW9QYUx4TjNzb2FKRDR5d3l3WmlRRFhYaDJsU08wQ3lXODJWdmpFbkVMbFYx?=
 =?utf-8?B?NU9rcGt1Skk3SkxyRkxBVW5rdVgvZ1AralI1UGNqZ3dkNDFLTmVnZWVyd0pR?=
 =?utf-8?B?MWxHbkY3bHJiSW80VkgzSEQvUUJacGZ4VnRCbUdNQlJoc2xxVWJCYXY0cVh3?=
 =?utf-8?B?U3EwMkJBRkppVHhCaVhDMXFuSWpWelNHY2ROVHYxVE03ejZBb0pYTGR1QjJn?=
 =?utf-8?B?VEYwTktBWDE5bXQ5Q1J1QkRRMHNidUo4UEM2eEFrNVRkWWx1QTJTMDh0NEUz?=
 =?utf-8?B?cjVzV3RaNFp1Q09JV0loNVpxcXNTd0dPbXVZUVZjb0pDSER0emE3ZSsyYTdI?=
 =?utf-8?B?MFBXcHZZMHBidmNaZHZNM0FWNGRVcW1aV2ZtM3R0T2hMcysrVlloSVgvZHJV?=
 =?utf-8?B?SGtmckhjMTA3MEZNdCs3ajBuVVdVU1Z6dWRPRnFBTmE0Nk5UL08zS1Mra0p5?=
 =?utf-8?B?U3E0QmdSWW9LMTRjRmVqNlZrbGRrTVdLZWxxSkhENktwYnA4STRKYzYrMTND?=
 =?utf-8?B?MGFnbW42ZGNQVnVhQm5wa28zYzFCUFBQSVltTjdNVENKWjVWSDdlTDRGOHhQ?=
 =?utf-8?B?NURNR05MdjkyQXpScks5Z09VdVNDSUZleHFsY2dGYmNnc1c0TjNZUVFna3Mz?=
 =?utf-8?B?YW41Z0NYSU9DNlM4ckxBa25WaUpWSlA1Uit4OUw5dmZvRnBvUVA3elZ3Wk1H?=
 =?utf-8?B?UFppYkF4bWxyb05QZUVlT3NTR0d0VzhLdHhVMWhFN0JWUHpRMkc0ekxwT2ZL?=
 =?utf-8?B?eHFFT1FURlk4aVMvMVJaWTB1U3FaZXJHOEpjZDlKbzAxdUwzcFBTUXF5VTlj?=
 =?utf-8?B?bytoMXJyb0dMV0xJM04wTFhhbDZiYlg0YkRyKytIS0RGWG1LQmpzM1ZCR3Y5?=
 =?utf-8?B?d0NLQkhZTG8wb1Z0SkNVUlY2MEZlU0cwZ3lUT1Y2M3p4SHZUenBQbUdjVUcx?=
 =?utf-8?B?aGpSbDhTZUdNcXpHYnladExtSWJORmZBZkxnbVowUjM3TjhoM3lBN2VQL1Zo?=
 =?utf-8?B?TFBMcVZYc1NybURmYm82eUhBSC96dkh6WkdrbEU1OENqc3RKcFpNK1QwTEdF?=
 =?utf-8?B?ZGpMWklQZG9TeXkrS0oxMGdVck80SnNNOXVMbTFzTGkzNUZLZGRmam82Sm10?=
 =?utf-8?B?aHEzek9jWlBlaVZTV0xtdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTg2Ujd6Zm00Slp2cnorY3lNaTB3dGdzdElaQ3lJYUU3amNGTEFXa3hsbmNE?=
 =?utf-8?B?eFJRcXc0MGJXVllCMXhqNzUydmZYaGJJNzM4SmVYdW9tR0VjRkZ6NHBPRmlv?=
 =?utf-8?B?NUV3UHBka3JBZHN1N2pCSDNmaStvMm9yRTZoenFtcTJVZmRMelh1eGpkamRn?=
 =?utf-8?B?RUVrdzROb3RRZ0lHZWFOaXhOTHBvRHhVYXJQaDZlNXQ3di9BaFBnSGlWMzEz?=
 =?utf-8?B?VUw0ZHhQWkRtZDUrOWErM2FxN2NRNlArL3MwVm1ob2RMRlhibStPMnQzN29E?=
 =?utf-8?B?cE50OW8ya2ttNTJpd3phcExidkdNUjQyYlJpdDJaRlovb21JbnltUG8vZnBn?=
 =?utf-8?B?MUJ1azRpNW9pQXNJaERIVlFtUFBFUlJhQkRkMzNQdmNyMklhMUtKcUhHc0wv?=
 =?utf-8?B?c3NQdWp1blkrZ0MrUDhkak85ZVJpTnJ6ZHZvTngxRGI3eUtZSFFxN0U0amRq?=
 =?utf-8?B?ZElCNTVFbkpyYjFodnVDOVo2TFk0cndVMUhXZXN0QzY5YXFZZjNXYTNEc1Fw?=
 =?utf-8?B?QUNJWDFUdkZyWkxNTUdiMGNlRHVoTUIraHJ0c0syR2cvZHZDQ0g0NWxTWUNr?=
 =?utf-8?B?SFdRS1hscXpOejhncE16YUh6OVQ3UWtWRytoVXBEZ0JvUUx6Sllua3hSMkdJ?=
 =?utf-8?B?V0FCS0F0bHptMDd6ZVl3SFh1NFl1dHBiWHZsMEJWWklqNyt3a0QzL3R1NlRu?=
 =?utf-8?B?dFY1b1hHNEdWdGRqcnViajFxOW9CQ0lQcnZybEFoWWVMRFdCM1p6YUxvRHFn?=
 =?utf-8?B?K1BraERmZHZPMXRaRlJabFVIbzRpN3dqVEpQT0hiMVk3d0lJMzhkYnIwbU42?=
 =?utf-8?B?ZEk5UDMvakV4Z3V0VjFNeXQvcDdTUERTRVVJMUMvVnhzRnJhL0greUpUY3FE?=
 =?utf-8?B?K3NxeHYxWjRPTkNWYlJCdEUyWXZDZ0RnYTVHZnlBSWdCelYvU09sMXRvMVF4?=
 =?utf-8?B?ZzRpSFI3cmxYUTB2SUU0eURmOTg5WGg5QWtBNWpHNFlKTmtJb0lGM1VaR1Jt?=
 =?utf-8?B?UTBvTTRMaVhXR0IzN0lDcE5kYUs2YkJEc2pUanJvVXBGMnM3UGtUQ1MxTGJP?=
 =?utf-8?B?ZFA1MWRGclZKeEgrM2FJOXFXc0N1UXlzMGVLM2k5aFc5QjMvOUY3am9xSDMy?=
 =?utf-8?B?M2ExZ0dNZSt2VmhtWXYzUG9zL2dpNjVrZkVTNk1FS0FLNUhnSUo0cTd1U2E3?=
 =?utf-8?B?ajNvVDdWa01CUHlFemFWTjRmSThrcnIzNDNNb3h6VEZYZHNWRmxINGc3Y1Fu?=
 =?utf-8?B?ZDZlbDNvYWZYenk1N2lpNk9PVm55N0RsbjZERG9aUXZYUnpWZEZ2M3hHeEcw?=
 =?utf-8?B?dUxKcWRsTXRUOG5FVTV5cWdXajVvYUhudVFxQUVvNmpUTFozOEFXWkg1eHBT?=
 =?utf-8?B?MFNnVnRtS2JsY1M5VnZnZExMYTJwSGFnWmpBVlEvMmtGUm1TcVNmdjl0dnNW?=
 =?utf-8?B?bFozZ0VLRzlHUmFhZEpDRmdjVXJCMFcyTjNQVjBwTmlSSzZ6RWR6UGdlSVFE?=
 =?utf-8?B?U3R3MTkwTWVRT3luYjVzUHdIaE8yWlFCeE5QMytJTnVoaFkxZW1XU21adit2?=
 =?utf-8?B?SFlGNFJ1YkNwS05pNUdUeldsZU1UdzJYNVZETUJGbmFWcDNhZ0FhOVFBUGk5?=
 =?utf-8?B?ZVY3dmZ6ZHFVcmgwQnNuRGlzM1pmSzZoYXVDN01LV1M4OGtaNW0yQlZLUkxH?=
 =?utf-8?B?T0gzckROZUtVMFF2V2ZtM3hTSExjeWQ1ekw3dVRoUlJXcGplTXAzemNzMlVR?=
 =?utf-8?B?U0tLcXdvelhPVDZKWXpvdUR4endPNGo3WExGdXRkYUFOR0hLVmIxRVdSSG4z?=
 =?utf-8?B?UkhyVnRtYiswaFh5cjJmeWNDMlROSXQzSHQ1cXV5Y3MxeWEyeTlQT2NVUGRJ?=
 =?utf-8?B?eUhMdXE2bW9JVWFLMDBZRGZWR3lGcTJUUmkzcEd2SDhEblo1dWdKNGQrT0t6?=
 =?utf-8?B?Q1MzTHNURHdmQU1uNk5FeW5vS2g4QWErWkdXbnZFSFRnSTN3Y0JHbHNBMzVE?=
 =?utf-8?B?WVFETHFRNEVhMHZMRWkwZlIvTXNxK05QSXpnV3poYmJvcDJ0NU83bWRjSXRK?=
 =?utf-8?B?OWRUSm5XQ0FyUjZTOHcwNnVlRStDS3FZaEpUUEI2YVhpL0o1OSs0dkFxQXVP?=
 =?utf-8?Q?mF9Ka8yniBUygjudSfpEIsRsF?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a0a233-0894-4819-c1d4-08dca587e305
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 11:10:23.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smwQWBwjeOtks6PihNog+AM6fa0/j5JKDRMm0eu3lZV9DFPaB72XJq2Ggr2Q3ChnWvGoUCiNPQk0M2KQAY7nHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10499

On 7/16/24 12:23, Ofir Gal wrote:
>>> -_nvme_disconnect_ctrl() {
>>> -    local ctrl="$1"
>>> -
>>> -    nvme disconnect --device "${ctrl}"
>>> -}
>>> -
>>>   _nvme_disconnect_subsys() {
>>>      local subsysnqn="$def_subsysnqn"
>>>  
>>> @@ -465,141 +206,6 @@ _nvme_disconnect_subsys() {
>>>          grep -o "disconnected.*"
>>>   }
>>>  
>>> -_nvme_connect_subsys() {
>>> -    local subsysnqn="$def_subsysnqn"
>>> -    local hostnqn="$def_hostnqn"
>>
>> It looks weird that _nvme_connect_subsys() is moved to common/nvme, but
>> _nvme_disconnect_subsys() stays in tests/nvme/rc. I think it's the better to
>> move _nvme_disconnect_subsys() also. Currently, md/001 does not use
>> _nvme_disconnect_subsys(). Isn't it the better to call it in
>> cleanup_nvme_over_tcp()?
>>
> I agree, I would move _nvme_disconnect_subsys() in v3.
> cleanup_nvme_over_tcp() use _nvme_disconnect_ctrl() to disconnect the
> controller by the controller name rather the subsys name. I can change
> it to _nvme_disconnect_subsys() if it's more appropriate.
>
I changed it to _nvme_disconnect_subsys() after using _find_nvme_ns() as
Daniel suggested, will be in v3.

