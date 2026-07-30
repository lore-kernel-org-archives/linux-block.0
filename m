Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020106.outbound.protection.outlook.com [52.101.69.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED62E6116;
	Thu, 30 Jul 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417054; cv=fail; b=UeF4sk5k38l3HxH9xKxQDMz5x2XaSbcsJX0qV+GY5gMXQo1kYnjMUjlK8atcPQtAIljlprQq78oJij02ye6T7FIrcCE5embSChAiA2y9NqeAonc6RpGTGSR2p0bTa8EN0q98tAv60B3YIsLb+vIqGC8i3ZBTM/EYvc2w3miFQSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417054; c=relaxed/simple;
	bh=Vo8aeKjPOj5FmoG3f2bAxsxhopAxd4Z9/3FFf6pASjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv5Ztmf+2JGp6qWdurwLj90WKf5a19XmHBDes3ZEfW6Yk3cTBWcj7UrJTPjExO1Wq7dJfDXLRNAbjJudtJ2fpJdp3iEbNrr8SVLE+4iKa/+smFNYUeIxrQfy3TRK9DoUW10YEmG50ytz/FJ3rCd13r73wTn/BWNOKr2qNiaj+xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macqel.be; spf=pass smtp.mailfrom=macq.eu; dkim=pass (1024-bit key) header.d=macq.onmicrosoft.com header.i=@macq.onmicrosoft.com header.b=V6yaoWGv; arc=fail smtp.client-ip=52.101.69.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macqel.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=macq.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=macq.onmicrosoft.com header.i=@macq.onmicrosoft.com header.b="V6yaoWGv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4VEqkAQnTyxu0RoSZSuFKooR3Aufln8/KXwd6tcyr7piCxsT+Gf7I34S6if6m2shhwNKxHq2j6n2olaTntOb8ZEThYCwkjiBdre9DsIhsK3Ep1A6zmscjcrdL4gZvB4OB3bNo5jmVWTCd2ekoGV1GIZ+g3HV7IMLGeyajvjJ0s8SRl4kd8LDhLDh0oI+xnWsgHHI28lQH1rfaBom+awAHuRLB5qes+8tfpHBIqybf1mRc1z3c1bwJOaHgrzBeO3J6Wwgsc/3w1v9ynm2o0arafeda9hpqYFhphCy7oxrApmyFcVzzxC4Dbidw2kgB3cKtZUPCjiaQmetHQMIFoZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pMaNo6FJ3eAM772gsQ2sJr1KkdU7iy/BfR55VuCPII=;
 b=FSb6MYoT/okHZyAzPcT8kzyvd74MhtF3xCaBrGpa2JP4JF5X3De79sBrFuR6hfoviqrbqqKhusKaD4ZP3JV4DXxIDDnnXtKOSSaZ9pT+ngFQyA4Nyi2mqj9f4R00+8BFl8kMUKeXcez380zn9RJRtOoAjMSdx5Ss6Mui4RG0f+CAXzmD7IV23FRhXnJd4NbhKsNLy9UOcERifhc0AAsDbx1zZYHj2UgvBXTrE3AqwYJqxk7iTRSLRgl1pED1H4ff6Y/R0Sphn+DlqEpZSHB6UMmgliGE7VxAVp92P5/0KRnoARvOpY9e6MTMTiiarVoLSNALaWRBbhgcaK1WfT9GYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.183.173.212) smtp.rcpttodomain=gmail.com smtp.mailfrom=macqel.be;
 dmarc=none action=none header.from=macqel.be; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macq.onmicrosoft.com;
 s=selector2-macq-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pMaNo6FJ3eAM772gsQ2sJr1KkdU7iy/BfR55VuCPII=;
 b=V6yaoWGvgKRnm4JGdtAYJAiiom7rbggI2j8k5S1v1I6M9tQzivKrazA9yOmgqKkmpMUlX6ZKtHa6zEaW/Q8dzGCmlDk2GOpywTbM+mEcC81NoO9bkYd3STOB4pPRV4ZWaRUZC+e7mwM3gu/EmsdWFCoxdNmm04L3bgWSPCIXmVs=
Received: from AS4P250CA0029.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::19)
 by DB4PR05MB10509.eurprd05.prod.outlook.com (2603:10a6:10:3cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 13:10:46 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::66) by AS4P250CA0029.outlook.office365.com
 (2603:10a6:20b:5e3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 13:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 91.183.173.212) smtp.mailfrom=macqel.be; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=macqel.be;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 macqel.be discourages use of 91.183.173.212 as permitted sender)
Received: from frolo.macqel.be (91.183.173.212) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server id 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 13:10:46
 +0000
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 60D66DF00C7; Thu, 30 Jul 2026 15:10:45 +0200 (CEST)
Date: Thu, 30 Jul 2026 15:10:46 +0200
From: Philippe De Muyter <phdm@macqel.be>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] partitions: aix: bound the lvd scan to one sector
Message-ID: <20260730131046.GB4502@frolo.corp.macq.eu>
References: <20260714114806.3761553-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714114806.3761553-1-michael.bommarito@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9D:EE_|DB4PR05MB10509:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3bd516-b728-44b5-c06a-08deee3bf81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|18002099003|22082099003|10067099003|11063799006|56012099006|14776008|75936004;
X-Microsoft-Antispam-Message-Info:
	kUmQRyCwXPPEVs6mLu9YQUW5+G/uuxK5OWFYAqk3gNO1U7x+bRSs1HbDZShYlJITPoMztvj4P3X67D+yZv8hR/o/7OEeeCDNulbbUpPsisO+/JU5UzOyWnKBIaYFM0/8zdDw/SBDj8WI+Y/becCbvghfB2ndJ8SpIAFUxpMBVfNd2c8SJrAUip2gFoSUu4fNI+sOGGoveGrgP1QfPi5G/fJ39ToKFoyFS9XUKOE8EJXBq6/muWn246FQUaTAMrYvxesc9lxkKoYoftykV2MeFe5ajNvejQb74xAP8QGe/yxwH7R4rK9HFh86Gmj54RjCE8kuxfjNVOc2dD7wGVYxmihTBRJQ9whNO7DrIZvDQSvTCVXtUfBTofnW4W+jPQorBimlFTu8dU9swf4z/+T5jb5EAfAl7jonv1oU8RLqrnpElEECDyEqg/uqowz8i51Cuta5wHuz2lzWqAP30jt8JdRDAiIY100YXvALBe+Fmx/GB01XNx1MR/c/Re9gITt+gZqjxFaCzy6ngzYf3+RxCYzOh/tNo/N4FsejYe/DUrumBHtTA5Z3MkjEwYJKlmlzMQVkuOCxAWuS3skm69SlyxYxxm87lT28oej+lGuLY8BUyNh63SMa6icDrUhZgvUmk6h/AyD82ilr5KbbwC+oqLjEElvS3uLD3wCoIpazz+47MkZDp76h/Gsky1A3ekgSNncB5zJI+EIif986wjJP+ucYU7Kr1XRygaNJsxrb2TGEQqLWW/GeVUuOLaQk6VUqc/fGxh8ZLuiIFHvkmLpF7w==
X-Forefront-Antispam-Report:
	CIP:91.183.173.212;CTRY:BE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:frolo.macqel.be;PTR:212.173-183-91.adsl-static.isp.belgacom.be;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(14776008)(75936004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TsaPHCn4u/po+df2+4TmChkDxirDT/ePyXyzLvOdJZPpls+eOQWsUhjn8uah5oo6beDiYePTDecSWsS1+ft/ZUBgCUtifaSOIdX9cVlyBxXtlBFOXA7665KJVqkWBVc4Xr2O1Qy9UoZej15SuZ7+ldXNAZGL50s07Ld0Ifik+uiq1BD4bx4wIiwmLMpFj2fw5LZTl60pkRL3EJtAI3n6+/Jq13HQjiJ/lESyUzWByPEsqvNmtYTwmDWQRxJq2wNok3szcdar5Cj2fiKzFsTgdhRTAQRNZ7GYvGLF2AP0O3xx890Fh/+vctfvQsr+qupOpHbKbPuj8WYwTc2KwGPcMnn69x3eoECZqDljigN378oZGCydaAQgWNnF0U/w3oDv9qfAbCDBI2Ra9IVu2Pt+T55mVe8C+Ps48Z9qK1TGle3wftNQ4i5VBukzKQ1/WuAc
X-OriginatorOrg: macqel.be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:10:46.5789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3bd516-b728-44b5-c06a-08deee3bf81c
X-MS-Exchange-CrossTenant-Id: 5541087b-384c-4066-992a-42aa5fe171eb
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5541087b-384c-4066-992a-42aa5fe171eb;Ip=[91.183.173.212];Helo=[frolo.macqel.be]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR05MB10509

On Tue, Jul 14, 2026 at 07:48:06AM -0400, Michael Bommarito wrote:
> aix_partition() reads the logical-volume descriptor array as a single
> sector and then scans it:
> 
> ...
> 
> Bound the scan to the number of struct lvd entries that fit in the
> sector that was actually read.
> 
> ...
> 
> diff --git a/block/partitions/aix.c b/block/partitions/aix.c
> index f3c4174e003e9..689837deba279 100644
> --- a/block/partitions/aix.c
> +++ b/block/partitions/aix.c
> @@ -208,7 +208,14 @@ int aix_partition(struct parsed_partitions *state)
>  		if (n) {
>  			int foundlvs = 0;
>  
> -			for (i = 0; foundlvs < numlvs && i < state->limit; i += 1) {
> +			/*
> +			 * The lvd array was read as a single sector; only the
> +			 * struct lvd entries that fit in it are valid.  Bound the
> +			 * scan so an on-disk numlvs larger than that cannot walk

I'd prefer the comment not to need wrapping at 80 columns, even in a patch ...
> +			 * the read buffer out of bounds.
> +			 */
> +			for (i = 0; foundlvs < numlvs && i < state->limit &&
> +				    i < SECTOR_SIZE / (int)sizeof(struct lvd); i++) {
>  				lvip[i].pps_per_lv = be16_to_cpu(p[i].num_lps);
>  				if (lvip[i].pps_per_lv)
>  					foundlvs += 1;
> -- 
> 2.53.0

but nevertheless

Reviewed-by: Philippe De Muyter <phdm@macqel.be>

Thanks

Philippe
