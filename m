Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020136.outbound.protection.outlook.com [52.101.84.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A325374183
	for <linux-block@vger.kernel.org>; Sun, 12 Jul 2026 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894794; cv=fail; b=BnkB3UMm7X8UT9sS6ktI58W50zdeHH1N9Kdkrn81HbtrnASlrAKQIQSGviLA/RsMhzh9jGosN47GsnKJx46QDx7zhPeb1TeDVN8Rrz7oLxvkAEeZtWJThZ8pJL8TVCx18RHooyPgtVC/WPc9ze/npuTSHvizz5U7QKkCoC0oyh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894794; c=relaxed/simple;
	bh=xgy2fqQ5b7ipGoHmU7PvDdnNzJpI4YeG3FGog87tyo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+qkgD8KSs/co1JZeOwtuLlpWhymYNewMAzDWBmIDL7sssS5DAbuZMg0rzAxWwzETS04KqwMY9ruYd/NCOWaxRj3lzfQ3W4vPaxFoKn2SE0Il4iIHmVxqYZs2qdMCX8jMBw0IfOndoPrbNqLFdKIGeTXtMXOX6rdiVo0JsdvIdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macqel.be; spf=pass smtp.mailfrom=macq.eu; dkim=pass (1024-bit key) header.d=macq.onmicrosoft.com header.i=@macq.onmicrosoft.com header.b=1QcQAs/Q; arc=fail smtp.client-ip=52.101.84.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macqel.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=macq.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=macq.onmicrosoft.com header.i=@macq.onmicrosoft.com header.b="1QcQAs/Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udNC7l4yqUKmfRiAoOi3FVmyZOUXGP14B08D6jcKkQNaDocBr6Oh8rnRejPZVMcd6+GB5+XztzmhKomh9FdjWYDEiTN4sxb4G/tKb4kDzzD7TGbYlLKdNuJIN6SKEoN9THv6dzUgOz5ScbWziKKkkoVufNpmayIWBVVaH8FKztQH/6tk+nsVph7m88PiRH3ScwV51OAStb7gPjfxRNsmjW7M9GyhvpSFf8CHMurRpL1XO3vrnHpFFuVzANYyscBOpsffjiwmjCLDXNoQ+tarFTBxQTQEXr3oriMUTWNf8Fqo+Iye9QrR4b3jtkIAsFlbL2ON/1ixXvR6o26ENqkcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/Xb8R0g0f+1moIoHPmMbUzlkbNr9xXuq3Ty736rAU4=;
 b=E9k40wCzGf+9fpQZBtSPBBUXfdjeLwhsbkv5meb5BagQ+AU5B2nqedOraqw5krdk1FFmaZvMDFmmTYmY+SAEyN8+aXBaSOcHdaqcKNMhpgbEVXkLmnGtNZ13NbHMq/7PEua80qf46kXZRE/wHT8uG9hIKNbTn7kaYwThvb4RaR0poMvuldlgBCYdvYv46Fk7kYhcKWw8IgKPGq7DqTkaEkaDFVrEBdn3rFCDdsh9RpWUgnDHC4g4TeakVHaE2wytFmQpSS9LmtdKylnQn12GXHjGP+CmKWYLIrX/bw4b7cr86kYLU8bcg8zJoOyZKaQaQqYXRMtWIDLQUTEhx1eovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.183.173.212) smtp.rcpttodomain=gmail.com smtp.mailfrom=macqel.be;
 dmarc=none action=none header.from=macqel.be; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macq.onmicrosoft.com;
 s=selector2-macq-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Xb8R0g0f+1moIoHPmMbUzlkbNr9xXuq3Ty736rAU4=;
 b=1QcQAs/QZJ41TM/sWknDs2uGN9TWNU5TysVpuH4fM121o6ciRJWbnbFMuTQHv+XL7TAVfU8mtiTQlngUljyfH4tGhXZwnv7jtZ+0pLpUWLcEnU8UJG1C9/FERx1kz3M/DvsMXnCNHmtw/8tZoPj90UaZI9OwyuujtbPwkIigR3c=
Received: from AM8P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::11)
 by DB9PR05MB9756.eurprd05.prod.outlook.com (2603:10a6:10:3df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Sun, 12 Jul
 2026 22:19:47 +0000
Received: from AMS0EPF0000019F.eurprd05.prod.outlook.com
 (2603:10a6:20b:21a:cafe::2f) by AM8P191CA0006.outlook.office365.com
 (2603:10a6:20b:21a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Sun,
 12 Jul 2026 22:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 91.183.173.212) smtp.mailfrom=macqel.be; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=macqel.be;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 macqel.be discourages use of 91.183.173.212 as permitted sender)
Received: from frolo.macqel.be (91.183.173.212) by
 AMS0EPF0000019F.mail.protection.outlook.com (10.167.16.251) with Microsoft
 SMTP Server id 15.21.223.9 via Frontend Transport; Sun, 12 Jul 2026 22:19:46
 +0000
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 8903CDF00C7; Mon, 13 Jul 2026 00:19:46 +0200 (CEST)
Date: Mon, 13 Jul 2026 00:19:46 +0200
From: Philippe De Muyter <phdm@macqel.be>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, kees@kernel.org,
	objecting@objecting.org, hexlabsecurity@proton.me,
	akpm@linux-foundation.org, yuantan098@gmail.com, bird@lzu.edu.cn,
	roxy520tt@gmail.com
Subject: Re: [PATCH v2 1/1] block: partition: aix: bound LV name formatting
Message-ID: <20260712221946.GA28524@frolo.corp.macq.eu>
References: <c945e129867d9c0b22d673a7e9ee0d14261d4a27.1783669882.git.roxy520tt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c945e129867d9c0b22d673a7e9ee0d14261d4a27.1783669882.git.roxy520tt@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019F:EE_|DB9PR05MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee29c20-0872-4f50-86af-08dee063ae94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|13003099007|56012099006|11063799006|18002099003|22082099003|3023799007|75936004|14776008;
X-Microsoft-Antispam-Message-Info:
	eefag3R5I4AOMCpNIqSKhifsSB4FHyG6Vk5y4vdJPKeCkZRXm93LojPP6jBxL+1MKDTgZ+236Fvz1rXefrn0s37nvwCyfxn6S8v8m/2HVsUQb5LM3nzvc26pI/GWoaKrYzmq/jD44gKBrNO0adovw75+6lwRRP2VPIDxZ6DadosPqGa+OozIyVKAwxT50V6WvcDwfsL46TmKwsLrSIYD4ujVll/sCxTlLEW1K6xdyrp1dr0tZFdjpEUueRLLUqGF4f8HAIE6Bdr/1uCQahB4Auu6hCjDsTnJriXZ2plHxjBVu5hB5b886UMIQYkWrNzasqA4S/DXGyn9BKr1njopc6uxxLC05/y2fLU+SspxeU0u45xRV+pAwTTp+l+rQrTA7c9rectaTEFEOfWoF4c7GA/+mB5xQD1CgYUM+o2ujLzQ86DRDUnpJz6IoLWNiqGe3BuZJTEOHEuMacRqwOoTZsc5IttDih4J00M0G/UW9tL9mX6dJb8ordk4s6Ls2lckQRwkmdzPo6WR1lEiRgzS/8vbzWeOSCIhGCMrmyi1PGVvIUFmW7q7UIvhXzZkmEdkHjVpnAzt4a55sE8GScDqrNuzL39aB3z+xnmUL0HDyDaXRngcXZ7yumMec6oiaThDQF15zAJoeU6hKi0b0F3g4+EdSmnYDpKzPU15jqRnWCP1aYsngFdDeKkvN6/FHQxI1Qaa/iV0ByJfgFi//mHXroBebuGDfddGuU8gWhQE9EdEQPepsFU6DhoO2JKooe0Ola0Ni/hhO9kFdeUlbUQA9Q==
X-Forefront-Antispam-Report:
	CIP:91.183.173.212;CTRY:BE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:frolo.macqel.be;PTR:212.173-183-91.adsl-static.isp.belgacom.be;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(13003099007)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007)(75936004)(14776008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JDKu4X4KOcSmrzWTs31zilknpMokQpM2ch2xfj4WXngDnYOW8XuP/WEBr5bUXh7xuh+liZlsmx2q/B0Ly91kKH1ZPzIa9Rt09rz9Lgy9x8bWrFU9DDyjzwIAc9ZJZ+ApmBWDWsQU7Mrf7/0q2oWo03lAYBWUzgov8Z4jOSfYPdQSmMKPJwF8+eP3fiR++kJXFe90F+FF+Lpm0g1iAl8chPjqqTsJKOrhhaQAiqDSm//2JnBgFzSSV/LMz3LnKPOeOwLTY4wzUt6il0b2OlQPibHx7UFt4DJYFKZKPGgrqjrog2E0Bvrp2cl1mrm/KaaGG2NtpkWdgafGeJoPK5BUJxQHiIGMJZIixplDPQELVNLwekKDCST7+L+CU95Gfl34vJ9bHDSRzhTEj/PpIM+THNi94SDtcDRNhpwXcus+5fKDrEK17y1DenHLTZDt/Ri9
X-OriginatorOrg: macqel.be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 22:19:46.7948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee29c20-0872-4f50-86af-08dee063ae94
X-MS-Exchange-CrossTenant-Id: 5541087b-384c-4066-992a-42aa5fe171eb
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5541087b-384c-4066-992a-42aa5fe171eb;Ip=[91.183.173.212];Helo=[frolo.macqel.be]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB9756

Hello Ren Wei,

On Sat, Jul 11, 2026 at 03:22:52PM +0800, Ren Wei wrote:
> From: Zhiling Zou <roxy520tt@gmail.com>
> 
> AIX logical volume names are stored on disk as fixed-size fields.
> The partition parser reads them into struct lvname, but later formats
> the fields with %s. If an on-disk name is not NUL-terminated, the string
> formatting code can keep reading past the end of the 64-byte name field.
> 
> Limit the formatted string length to the size of the on-disk name field
> when printing AIX logical volume names.
> 
> Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> changes in v2:
> - Print non-contiguous LV names directly with a bounded %.*s format
>   in pr_warn() instead of copying them through a temporary buffer.
> - v1 Link: https://lore.kernel.org/all/6f381f63ccfe458e15067fd9b9428884cb8d5f97.1782407859.git.roxy520tt@gmail.com/
> 
>  block/partitions/aix.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/block/partitions/aix.c b/block/partitions/aix.c
> index f3c4174e003e..fe2d2cb0c4e7 100644
> --- a/block/partitions/aix.c
> +++ b/block/partitions/aix.c
> @@ -261,7 +261,8 @@ int aix_partition(struct parsed_partitions *state)
>  				put_partition(state, lv_ix + 1,
>  				  (i + 1 - lp_ix) * pp_blocks_size + psn_part1,
>  				  lvip[lv_ix].pps_per_lv * pp_blocks_size);
> -				seq_buf_printf(&state->pp_buf, " <%s>\n",
> +				seq_buf_printf(&state->pp_buf, " <%.*s>\n",
> +					       (int)sizeof(n[lv_ix].name),
>  					       n[lv_ix].name);
>  				lvip[lv_ix].lv_is_contiguous = 1;
>  				ret = 1;
> @@ -271,12 +272,10 @@ int aix_partition(struct parsed_partitions *state)
>  		}
>  		for (i = 0; i < state->limit; i += 1)
>  			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous) {
> -				char tmp[sizeof(n[i].name) + 1]; // null char
> -
> -				snprintf(tmp, sizeof(tmp), "%s", n[i].name);
> -				pr_warn("partition %s (%u pp's found) is "
> +				pr_warn("partition %.*s (%u pp's found) is "
>  					"not contiguous\n",
> -					tmp, lvip[i].pps_found);
> +					(int)sizeof(n[i].name), n[i].name,
> +					lvip[i].pps_found);
>  			}
>  		kfree(pvd);
>  	}
> -- 
> 2.43.0

Reviewed-by: Philippe De Muyter <phdm@macqel.be>

Thanks

Philippe
