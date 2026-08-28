Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440F744AB98;
	Fri, 28 Aug 2026 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921573; cv=fail; b=MxgytDhoVU+fPvZZO5Y37b+kihlSlcg+m3/100rzge190/O4pm2DirL2yPTHQbiHPHe8IZMp0nbHIEoES9FwqBywwp1pyYhrHGhpoOfP0KIVWOGKGjUanxqITrlFH/GAE07nkSqbTDXJtEGr1mNIqzXlMq2htyb+KjBLfpZyO8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921573; c=relaxed/simple;
	bh=faMDBEb17VSi9BdFBXfjyh/CGYiNNarRDes265vbD1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HWjshRU+YyZuJDrDdm5XgZTOm+C/gghv0RbG5g/icAZ8fQqtaoGHiutd1Ev89RQs43tQFplAzydpqgzxxodlSNdInLf3neWgIMnGujUjtSpjeTXs9/g9EE4KlzfBvbkh2Nh6OyUKe5+sLE3eGRK1ym8nHrrfM4qCeX2hCJBPCI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wo9o7pRk; arc=fail smtp.client-ip=52.101.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wo9o7pRk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVZeWUjlca+s/r44xSVXl6n0JOTWdep/SOPHxjEB40+DlvvgBy60JFmbbPP34nBnTDmeNfjaeiPow6jYbCSmJ4HkkncZTFFgJ3wgjw2Fv+DaILUu8HHHuzp2q+f8SZAFTJIFYW5VZakZoapOAGzlY0P7hnPAtJ8nbsKeENo96NG5ThmzkuwLZlt5G7DVzmguWbI0MzJCxwb1yYLb8/jypGc6CKoAkpvw7FwQXpoX9TBOCQMZ6RluugcixZvoplq9AUF8e4ap+sBM+qdGrqdAJAk9fcEDizUszUpDdIKzCZlaokTFsb3/EHJK/JDMg1hvSu1ji48/vOIUTn/BlE+6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUdc5t3VxWQi/Mkq5FYg3oLEETTjgzLiEiSQpgKiqm4=;
 b=C8+uNbVab//KxuFmprpL8zfqg83Tc+P3+fijRvawhiheLTOD1tdtdwR4EXNj6kLr7XKWa48OHa+T8JpgehaYdqy+FYBEHJqoZNEmi50NRCyMcpRLITVzw5hFhqvHcRasgvGO/Wfpi8Cz/lPSikr62QILqKoh8hvazmaFdlDNiman+MxtAOcwJ2z0x/bgmTCvmQVD5upNWfrYJyQctvhJxiN7xAEWMu6PXyPcvgWBinoBvLHDosQTlOczb5OeYopQnCzLFr/yeEYE6mFAnsKAf4ZqClmILM+8HcEVN86QfOBjV522ipW7y1ZhTv0wSmnEiaunlfZm8r+NLzUKVo5+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUdc5t3VxWQi/Mkq5FYg3oLEETTjgzLiEiSQpgKiqm4=;
 b=Wo9o7pRkY8iEzEzV0N9Kr81lusjC9xb4TyPeGORlYvwLXYMscKS4QWbQGs20NmqtdUKHDBOlXX1yvoiW0e9SpwKM9qjwO/ylwz7+Qny4g1ECW3P/7FVbsFrPPp9IZDZX4qXAL3uWwLBLzlL6K8Uk/9ReINgx77pBtHnKqdM2H68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 12:52:41 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Fri, 28 Aug 2026
 12:52:41 +0000
Message-ID: <fb875f14-3b47-4d43-ae3a-0d0b17e1c64a@amd.com>
Date: Fri, 28 Aug 2026 07:52:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Silent SATA read corruption with dma-iommu on AMD
 600-series AHCI (6.19 good, 7.0+ bad)
Content-Language: en-US
To: Mikael Etienne <mikael1022bzh@gmail.com>, vasant.hegde@amd.com,
 iommu@lists.linux.dev, linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Cc: regressions@lists.linux.dev, joro@8bytes.org,
 suravee.suthikulpanit@amd.com
References: <CAHEgv3TiJUvS=Hustyem0ts8jkbFVAdzBazmPhCbv2sNnTsZkg@mail.gmail.com>
 <c5c2b503-e273-4aa5-ad9f-f7afee02ab9e@amd.com>
 <178791494900.1152725.12728124457005560389@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <178791494900.1152725.12728124457005560389@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:32b::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db1a66f-7b77-4a10-a53d-08df05033ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lT81KiAwqSxllqhNlFp9Sz5mPCC1GF/zRPpfN2jJDe4tBwWifwq4qec4jZdXu8JbXRwp/4zIyFcW4ScrQ+ktgMZ+oAR4KGuHoWr7d2luATu7LtkdFnWXENN8eKOZ/oBI4tcB0GP0saWtXvpC9Zkq55JVvnA236/TlefTJTXol3YXnEeUhSqd4qyhB58xE8IRndYBeXJpHoCXYLN2GO1SXP7Win5V3Ya6YpBA+XqPgZWinryWazjXeKSJ3B95i1gZal+Luxoo1oXW/8qHIy/xeEyQVe64HP0g1US4F3UgwpyW2yRoYbW94dvzhybGldjY1R57KmkaE3pX3vERd3MjMcL4ypv9IfiRtICAiyuCo09jUo/bOroS3lWdz7eLgkdkl9A0Nf18v4opkRhPX/zOzBSd6xgeFSA1lojJMkuHlpqg1ns4ZDVOfvPTA9Umy/6gvBoWGhIGHYyhkyhIrcUZ16YXnGxfQrDmQWYrgsxvrCK7hbIlBuO5qVE8ekex1Z2LARKmDbEqBlb6L3CwLZ55uqWW74kpyO7SJd+wQYMsszJW2jC+MiF9HehggAyJQpHeIUvUSS65oEqqtGlIOgwg4RimdGq3nDwln7i6zPiXueqqTtx5J3qrQgt4ao99xAOLn6OwYcgLyKFstkDaBNMXzihBomBX4SNfRM+j2zohQiY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjBWOG45aVpXQnVUOW5ZRWl5bW9vd3ZSMnZhd1ppbmgveXhNd3hCUkNKT1Vo?=
 =?utf-8?B?MXRuT2dPaG5QMDBTWkhZNjhkamlaSEEvSlR4VVVzQzVSenlYS1JzODBqSUFK?=
 =?utf-8?B?Ni9FS3NjSnMvNEJabElOZ1A0NldGNExDYmhWVWdiQU4vditscVUrRGIzQ3pP?=
 =?utf-8?B?SW54UFJ5MSsxMElvNWVPV1oxUmZObFpIT2hhazhjdUNMb3hMaTVzR0s3Z3Vt?=
 =?utf-8?B?SXNsMmRaSG9lYTJxaCt3bGhDN0tDNGV6SFFpSzFOUWVVSXlza3pmYzk0OHRr?=
 =?utf-8?B?S3cvV29ZME9jSE0vd0IzSjVGc2dvSWtOZjBqbUYzZlNvcGQxVU45aXlhaEpQ?=
 =?utf-8?B?UUN6SEpPVmRkeEprMSs1RmdqNXVZOUNGa3FsckpIMWhMKy9aakVacWZkQ21K?=
 =?utf-8?B?dlZtZUJ5VVRVS0RySXNDSGVhVHNkSmlFckdXL0xVM29RdkFpZ0Raa0hLbmZU?=
 =?utf-8?B?VUJRekR3cmc3dDNxVUd6V3U1aThJdllRdVNEUHZaTkQwcDBiREFOTSs4MHY1?=
 =?utf-8?B?RWxvbWxBSkJJSGZvaWEzeXBwdmgrODROQXVsZGRwT09IWE1xbmRNcTdHMlVn?=
 =?utf-8?B?OFVWei9IZUVCT0l0TU1WNmJTQlVsejFCQnBvQzd3cFcybGp5aEtaL3lxbHA5?=
 =?utf-8?B?WlBZTE1RTHNPYTlqRzViWWF2YkRZcC9BUDBLNGFrNi9UYkhQbzVINGtNenAz?=
 =?utf-8?B?L1BySG01dnhYb1VGaXdUSzNOYWM3dHJJVy91YmJ2bGNDcHhTaHFRZGVTdVdW?=
 =?utf-8?B?akNVa2tzemFzMCt3NjJOcGhoSWlDT2twTW11VEgyQUtXT3Fub1c5RG92SkNU?=
 =?utf-8?B?b2ROaFZDK044RVhEb09JOSt0cFFOcDJtVHBpNXZVNU5MUS9HTXo3ZmdYMnV3?=
 =?utf-8?B?Ylp6V2IvZ1RGbTB4LzYvVEJ2TmZ0RVBvTDJrOUxQdVc4ekNuYi9kaUh4TTFM?=
 =?utf-8?B?SzdjeGdmZlRZZk5kVXNtVUZPeEZ3dEI1VmdOZU1VdENvcUhiWE1BQkw1WEZl?=
 =?utf-8?B?MUhqRzVQbnRxd3VvYVE1WHAxUUphcE9DRE45UWdEaGZsY0UxUlRvc0VkdXAy?=
 =?utf-8?B?ZUoyTjVLdDh5OG53bVlEMUZzUXJyK3Y5ZXpMV0RFZ3dzZ1JLRGxEQjJQODZX?=
 =?utf-8?B?UWhySk1oS3J4ODdjVVJoL1o2ZUVqZGF0aVh6M0JwMjZ3U2RGa2dOb2REdzZT?=
 =?utf-8?B?d2s3WW5BeHFKK082cmh2amFqRW1zZUR4eVdaNmt3enRFamRnNjcwMzJhMEM1?=
 =?utf-8?B?RWJob3MzM1U5bklJVnpONnNrRkFUdE55QUc4Wkp3NldFa1RXdXFvMElEWG9s?=
 =?utf-8?B?UTRjaEVpQVN4RnM0ZjBxbWJTLzNBS25NUStGWVREREVaWTVBUW9FWjZkUHlE?=
 =?utf-8?B?V09EV0dZR1ZmWFZ5RDBTMStIV253M0tqRm1weHkvN1JKcE80OUQ3a0p0UENm?=
 =?utf-8?B?L1hLcUNOa2d4TTFQMjF2ZDFhbG1BM1FLdCtzNDlrNXVSNGpxc3ZNeUp1NCtz?=
 =?utf-8?B?LzNOQUlsbE54bmtKdHdUSFR4SzQ2OWpFclJYT0xMUGovZXNINkpaRE9XYzJJ?=
 =?utf-8?B?OWZKWm0zWFplVDV0eG1CdThVWjRrd09mNkxsZStHTThDdDVlSndkcFU2MFZ6?=
 =?utf-8?B?YW5jVFlxdUpSVm9hV0pqaVl3eDl3RzVMOG9HYjRiOGVpWVlETEh4OHRldC9V?=
 =?utf-8?B?VXlJMTF5d0o2WWdwbURYM0hmMzBrS3VSeER4Ulh2TzNhc241dVllQ21PbGty?=
 =?utf-8?B?SnZ6dlRhSFhhOFdISUFMMlUySE1KK3RZbTBtbFdrNlpMa2lXSkJBWkowK0RY?=
 =?utf-8?B?a25JMXlSc2VSUzVoOGVSUDRVOHhkdWJJV3I5cjlTUUVsdjVvKzlMTU5lYW0y?=
 =?utf-8?B?QnFsTkUzeTZ2UGpSL0FmUzBnbEwyYWlqQyt0dVcxMUMwWHhxZTRQVHc4a3ha?=
 =?utf-8?B?c1h2WjI4bzFDdmxlVGlQb3o1RThvRW4yWE9OZlZQd09vaTc4QktyRHdxa0lv?=
 =?utf-8?B?UTlVNGphTWpWejNaaktUOHFqVFRkUnBhZHB5Tm5sZm5qd0c4THhwRG1HazZO?=
 =?utf-8?B?aDB1UXgzMjNlZHhjRXRHKzFqWFdGbzNsQ0E5Tzk4WURwS2lFK2RGYXNKbXR3?=
 =?utf-8?B?bE1ZTnlxWVdJczJxd0hwZyt3RHp5aUZqdWQwaTZIWTEwVFlXVzh2NFZ4N2M3?=
 =?utf-8?B?UUF3RGtqQlBGSTRPT2EyM2p2a1RMNnZjRTAwdFNXMjV2MjFRTzUxRUdQRkpo?=
 =?utf-8?B?eEZMWlNFQlRtbXFzQlNhRi9zL2wrakh5Y0MzQUdRZG8rNDM1WkhsTEh6RS9q?=
 =?utf-8?Q?VSIBzg4/vCf1GRHqEQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db1a66f-7b77-4a10-a53d-08df05033ee8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:52:40.9977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMYSw8xlQ+rxF5fs75ivP9eLBPLRyQegBKMXttznmmyU6AmG6EAQ25+kLzFgU/NsweEVCNPgkwlfYK5yxM5TSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095

 > I CANNOT realistically: dedicate the machine to a multi-day
 > v6.19..v7.0
 > bisection. Classifying a kernel as "good" currently costs several
 > hours
 > and several TiB of reads, which makes ~13 bisection steps impractical
 > for me. If someone can suggest a faster trigger, that changes.

Even if it's going to take two weeks to do (perhaps run a test kernel 
for 4 hours a day) getting a specific commit will be really helpful if 
you're 100% sure it's a failure caused by a kernel change.

I will note that there are some other bug reports that are showing 
generic IOMMU changes earlier this summer that /might/ be similar.

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1141183
https://github.com/Alvinwylim/asm1166-iommu-dma-corruption

> 
> Mario -- if the issue you were debugging internally has a comparable signature,
> I would be glad to compare. I have the raw btrfs csum lines showing eleven
> consecutive 4 KiB blocks returned in exact reverse order around a pivot, plus
> full dmesg, kernel config, lspci -nnvv and IOMMU domain dumps for both the
> failing and the working configuration. I can also collect whatever specific
> diagnostics you want, including with a debug patch if you provide one.
The corruption issue that my team is looking at is specifically with 
NVME and doesn't follow a kernel version.

So it's not a slam dunk to say it's the same.  BUT the issue internally 
does show the issue is specificially once the 32-bit IOVA space is 
exhausted.

Unfortunately; the solution is currently a BIOS change in how the type 
bytes of the IOVA is handled.

But the workaround that Vasant suggested (amd_iommu=pgtbl_v2 
iommu.forcedac=1) will help confirm if it's the exact same failure path.

Without BIOS change issue can't be reproduced with those applied.
