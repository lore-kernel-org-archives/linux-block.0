Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022110.outbound.protection.outlook.com [52.101.96.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4433EF;
	Thu, 21 May 2026 02:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331159; cv=fail; b=Gq/+2rljPO7Ni6HMhM5Zdt5gg6NA69N0kfHzDWO6kPcxNnB9diSVe8uUB4RMRXzUEOV0/siTu4gtvr9fbcQs2ySG1SSTm+Zba8p2bDdmu7FR1G8TovJWb9/IzP6jWepnKMXagaERoi8jV16sf1QBx0MVord+zoeYO+FPJXReh2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331159; c=relaxed/simple;
	bh=S3SnSIZ49gwmwoTwdWshsxCxGiehVpHRapx3gTfoulU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D1xi3cCtMMHBwE18GJwAlfoskKbe88M1m5fAxU6i0ZVZsSzLGv9M4vpWeJIDzXSn7yoLh+e9UFJy8p1gCV7ifiP0+AvLvgMIC8k+ndpBFM7KzRCdz0HATR/IqnvxVGE5Uq1NJzV3YzcWitYWLRfScAdIUtPa1n3/8/v/KhtZbh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkmWtOEY7lK5D8/y3Gjib9iY40SycLIfXKNqrUsxLaSQfuwLErsvz9kBNJPrEL7D6hACBKsGCF+eXDacoWyERn3x10mbvWRbC3NHrSvDqoyw9Xx79zwFwsllVdwUAWMPyUQfyFriJKXyIQB7l3AupRrq7jHOm7WeSaHDk5ANpoL9FVG/xre4xd+xyxbvOV6Vr5PHHsMZ0G+QXG3I7XM78xMPl//UP8eMhsopn1KbHgh81mH49K5j/PSmZow7j/Bz8Ulvs3X6VMvyDBKbrqvfNI4zy8fQBoe4Na8+re687UfOBtzk9cHxI+ksgtfnmdiU6MDnYymxXWDqjj2+Pe0utw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PVqElOND0ylqd3JvhEB2UhIwO0j8TVs+PQqqQQWchQ=;
 b=b+vuEPULOU+8p89zSXha67BCUIg4WVBqg4towPIuazahHNWXlrnJEix/IVHy+wq1Qd2xO+NJWMIVbDS7twXZNKOvao0DYTowWsXksiAobUeaC9UJa4zi/bgxBsPT+fSkyQA5OpEcz+BHtuDbDitCWL4D931OsYlrtQjuVLvm9on+E4LIxGXJNwnYuWxSCRp5Si43SC4felBtr5DfTy8dXlpCBIZPuER4MYerMyXPkm+dV7ixAhM9SgQHIitbMyLJ3t6hJcs1BI2nHmutMshuUmgXMhkgjBih+lMRPYa5CfwiSJ9noUvOxy1jNqRjXdZXtLmg3MhCEizhKtymArbuMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB5749.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:275::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 02:39:14 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Thu, 21 May 2026
 02:39:14 +0000
Date: Wed, 20 May 2026 22:39:11 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com
Cc: aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, kashyap.desai@broadcom.com, 
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com, 
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com, 
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, 
	longman@redhat.com, chenridong@huawei.com, hare@suse.de, kch@nvidia.com, 
	ming.lei@redhat.com, tom.leiming@gmail.com, steve@abita.co, sean@ashe.io, 
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com, nick.lange@gmail.com, 
	marco.crivellari@suse.com, rishil1999@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 5/8] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <vx5hv77g3k4khildtqfyadasorrl7bywkmtnu2v56rmu63msk3@c5wlku2rqgmg>
References: <20260520215030.496803-1-atomlin@atomlin.com>
 <20260520215030.496803-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260520215030.496803-6-atomlin@atomlin.com>
X-ClientProxiedBy: BN0PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:408:141::12) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: bb549b26-db69-47c4-70da-08deb6e225aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	Pyx8Da3VXdhVlGNyyYm44xzX+814mAxOvqMl6fiIAGasCPcYAlUMo1ptNqt+M/PGY/LmwjbPs+QLXdO3wGKAkOWQtjkY64wvAtpcWK8UE0ZLRvT+37tfiBURT+eFoVmfvGsgiennbJC0tFnKMH91OcJTPmKfTa1BhgOyx0g2Yad380sbzdF41Co1tdoh3WfFogLnOeokKl0pi9U/MiWtgJaqni0Y33v5qj/XoKS/HlFoT2jBaKVo85eNSfeqE5x+eYwkPDtJYeUa6x6vm/tCRUyLclOjlxGP5ZOvNSogaWcOTUdetUsYBd8Qv8BFBVnP5+6FIdpbHSuKbGH140XRXyREooIWrkjLokpr1ruPrGD9KnfmKrKNTezcP5rYBmP8tHxhnpn/XfanM1cOT4h5aIqkAG4WFSQ1VoUW9tFsZ3Qbr/YLy/C9TVc/um/mDJJfgvlf412zM71Vr/AdZvdkzuuddxITPpFDk6jVUx8KoRwjITTjrcmHR+7dZbEwg4ZhFreKRfJR0Zkgyd5B/y13o/tMACQIr6+vzmAjJpWXAz92AdyLbFe9IDMStn2gz2Xj+fR0dNksuaX0gEOqmpUHPpV/StXBIxYWKAmj+C2D6Dk80BXDP8btZ8jg7FXN5N8gmyKegTkxj0tG8KljYxaFeNTRnaQbMDDjGwMXNuTbkltcjQt37CQzDL8reo1rpNVG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anJhdG81WnE1UDFPVE1qbS9lbnNpeGNrTzFVcWVaNjI3QkR3TSsveE93TTl5?=
 =?utf-8?B?ei8yMGNnUE9uL3FVbXVDaEoxKy9mNVptMHFNM3NkVHFGSWdCZlNCYmxxZ1V0?=
 =?utf-8?B?eTRRQjUyY1hwUzBsMFdEejI1OXR3b0JxODhWQjg0aVNzUFA1MlhWYlNKd3NJ?=
 =?utf-8?B?bkJUcTZkR1kyMzNUcFZRcFkxVG44TS9VVzNDeHpvWXdKYW9Zb244TzNFTXNJ?=
 =?utf-8?B?bVlaT2hZTmpsd3J2cC85dTJaZGQ0UHl1S2pnUldGSGJlVU5PVWpiTmNJVjNj?=
 =?utf-8?B?UWhYMm5WaWY4R2xYc1dLMER0SE5IWkpBUS84bkwraFB6WWF6NUYyU3NBb24x?=
 =?utf-8?B?RFRGS1lEZkVCL053M2RNRmFVVmNWOHpDZGg1dzNOcDlNNXBJVGF4VEFsek1m?=
 =?utf-8?B?bjh5MXlsdVNZM09VMllUY1FzYW9ML016OUsvNzdHM3ZxeU8vSlFESmpkTUla?=
 =?utf-8?B?THYxOUwwNEFPOXF3eURQOFJVWEl3RXhlcG9hQkZzaTFiVUlLcm96dEdHSmZm?=
 =?utf-8?B?L25RejJhZUIzQjd3ajJUVWI3c2pPQWhDc2swN2MrSXliVHBGenFuMS8vaStl?=
 =?utf-8?B?WEpIWS9uRUlVMTN5dWRwOFRQbTY5NTU5S09ZdkFuNlJKaDI3bjdoZjZzTGdH?=
 =?utf-8?B?RVlHK214VWxtNkFvQTNseUFkV2Y1aXhkQWlyTmVqM2doQ3BhYmduSXdSQVdm?=
 =?utf-8?B?MHRzY0ttZ3NOUHk3MDA0VVA4VGRFWUQyUmRNZnNObGp3aGRkRS9SQnAvaXF1?=
 =?utf-8?B?RzVIeitQc2pWMnJXYjd1YzYxUHNuNXdnQzdXVnVrbmhzOEFVeEx1NkdSQmxW?=
 =?utf-8?B?aElaY2pWWHhQVXpXSXN5VmZxTlNBT3Bub3p6OWIrKzhQbmdNTzdsbk9Pa082?=
 =?utf-8?B?dkd0R0ZRL1dkdUFVTG5DSVI0aHZna1BBQnZVMXNoMHFLeW9iMnRMalg5MHdS?=
 =?utf-8?B?ZXFiVVNvNW1FODh5ZnpSNUZxUVVWdGFtVWRmRkJQeHArVmcwNk1zTTBTSUJu?=
 =?utf-8?B?KzhqaTdKUmhSSVArUHNYTGg5a0h0cjhmZDBLdFd1d3pLV2pvenpHYlowdVpD?=
 =?utf-8?B?TVpVM2wwQWxDOXdIaFdqMlZaMXRLVXpIWEdYNGJDdmp1ZWtxd0hhbGt2b1VZ?=
 =?utf-8?B?NFZFTjFOcGVNaEJOb3ovb3NLcDlpWkJFNUI3U0xsS2ErK1ZwUVA2L2syeURs?=
 =?utf-8?B?RTRIWGgzSzg3TDRDYTViQjlMd2RFTlZQNHdLNXdwak9rMEIxQ29COEl4MEdF?=
 =?utf-8?B?dDNJMDhUbWFoNmFEU05BSnZSZnJVcWxBUXZMN3hxRGtacWdmZFVIWUtVTDdX?=
 =?utf-8?B?SmJFOVVjNzFqZC96RFY1bHJqZEhxMXdFMmdKNFp5YzFCdDhLRDRYeURvb2FR?=
 =?utf-8?B?RGViWTZvM1l5UEtuU1RzekIrbXI4TVJ4WTYzbm9PSkdmamhGWHhTU3k3WjE2?=
 =?utf-8?B?TmVBK0JMYU4rUkJXRkdOd0srNHk2M3hMbTZNTmFxbnlCd2F3Y29sc3Q1UnJH?=
 =?utf-8?B?SVB5ZWhnbFB3eXVsRW95Wlp6WGJJWlhkeWp3N1Rxa0U4dnV2bDVkcThiZlpr?=
 =?utf-8?B?bnh1SkZxZm9tczNVOVhNM1VhZWpDZW5lVDNBTjVFaE5vZTkwOVBsdVFqZG9l?=
 =?utf-8?B?L2kvcXBHRzNZZVc0b1MvMWxuZ3RJZ1BOd1JUUzFCVXhMUUR3S1lkNHZDNzZs?=
 =?utf-8?B?RzdaclVlS3BpMHBUYU4rbFBoYUtFWVNaeitTYWgvMlhSaGc4a1JScG5LL1lj?=
 =?utf-8?B?aTc2Z01JQmVuTlVyQisybVlMSUtIcHB3SHhlekFadTFOWkhCR01ETURFNXpN?=
 =?utf-8?B?dEhJUCtPdGVwSS9oZUJaUmZkZENzdEwxa3lTYi9ycTZZQktXYjRHQzRrT05o?=
 =?utf-8?B?Nm44YjdyMW1WK2xSQS9wNTNiSWhEdU5CY0M0R2VVeXRta05yUy9sbkw1dFVK?=
 =?utf-8?B?UFZ0NjlaQ1QvSXVYbWZHZWQxNFhmOE4wWnBjZWpEb2xWaVBJODRvZUd0T3dB?=
 =?utf-8?B?LzRtd1Y2MXRjZEFTdWpGZ2F2U0dQbDZTbzgrZTJUYXZMKzlVWG4vcU5GWnEr?=
 =?utf-8?B?WjkvWEhJaXhoRDU4QThhTktHU1ZrNDg3V1NKNkF4NVhvN1dBUUx6U0dVbmZY?=
 =?utf-8?B?Y2dTb1c1OC9PaGNyMGVtZWZGTGlwTzhQTXRFelJqK2Mxb1YyYmtNVUtBRjVn?=
 =?utf-8?B?c3hzck9iTC9xUThnTFRXeVUvcHdNbWs1Y1FEd3lCY3R5OEpFSUlDOTN1bUFZ?=
 =?utf-8?B?WVVPak80d0ppRUNhVFNGenlIM3Q3QXRlZHd1KzhVUC9vdVF1QVkzL1JGZDVt?=
 =?utf-8?B?MmVYNGppb2w4YjZ2azZ6ZFpRUEI1NEhEU2l5bGdSQXY3bUYxc25aZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb549b26-db69-47c4-70da-08deb6e225aa
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 02:39:14.5723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96ScPoH+K+5QoDmNJtWFTVz089ikZvo3XEtDHitfiOyjvFsOwoAaXwreBIPJSYasPZ8kgOUqflKI6UlkhOMA8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB5749

On Wed, May 20, 2026 at 05:50:27PM -0400, Aaron Tomlin wrote:
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 705da074ad6c..3df5c368cc08 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -22,7 +22,11 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
>  {
>  	unsigned int num;
>  
> -	num = cpumask_weight(mask);
> +	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
> +		num = cpumask_weight_and(mask, housekeeping_cpumask(HK_TYPE_IO_QUEUE));
> +	else
> +		num = cpumask_weight(mask);
> +
>  	return min_not_zero(num, max_queues);
>  }

I think we could be more defensive here.

It is theoretically possible for the intersection of the provided mask and
the housekeeping mask to hit 0. We cannot allow a generic block layer
utility function to overflow to maximum queues. Therefore, if the
intersection evaluates to 0, we should enforce a safe fallback of 1:

@@ -26,7 +26,11 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
 	else
 		num = cpumask_weight(mask);
 
-	return min_not_zero(num, max_queues);
+	/*
+	 * Ensure that a count of zero does not inadvertently result in
+	 * allocating the maximum number of queues.
+	 */
+	return min_not_zero(num ?: 1U, max_queues);
 }


-- 
Aaron Tomlin
