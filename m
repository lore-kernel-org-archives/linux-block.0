Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021137.outbound.protection.outlook.com [52.101.65.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F43E5A24
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464983; cv=fail; b=RoUmaHKhBRQVym3vG33k+S0+Uz+UD171FLlrXPLYdHSWqJ24bSqLl22loodHSGlz5vwcuwoKfiPA/WkVu27AZqQehW56HkOnOeOzb3VKS3zjjM+cQLNyF1hSIaQIfFGgHy4KBrM1y6n0SSc5eMd9uJro/FAa1f6JMzLXwpS+Z6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464983; c=relaxed/simple;
	bh=OY+4SZxBrvj3IVwyhrE00da/e9hzF4yd93TX06u1Lx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZztFPpLp+wxU/V97Qk7ezTRRtWskzdHh7RJlvjzl9B2q8avZRpFekY2h81G7F5quy0Yy5aKe1i5YcX0iH3Vg72wSMEvsQPOhL1GnyJiLsYLgl1/moJAVwOvuFgmJl0OHLmXdP+k8zzH+la+fdNJvaj114aY5wpfZh9HVT9AVLX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macqel.be; spf=pass smtp.mailfrom=macq.eu; dkim=pass (1024-bit key) header.d=macq.onmicrosoft.com header.i=@macq.onmicrosoft.com header.b=YCv2FUfC; arc=fail smtp.client-ip=52.101.65.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macqel.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=macq.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=macq.onmicrosoft.com header.i=@macq.onmicrosoft.com header.b="YCv2FUfC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8/atvmiYJlo9mrFeI7LHeIRFJtSOfsrtC5Utn5uXmPgyFOWWLa3FtXE2uOtHx6NmFf2wMXCzvAFRDME7936ZeMI7IbbnxiPpnJBW4IUVjxzeu12E9fATYDXnFFz4Zpl7RHRP3a3I9/wei1xKGJBFfyKarCJiy101Gv0BokRy+loHG9wQYjuJviXRfGQAUBmyku+NSjBVbKeJK7qWrXynwgFlqXBxcXJrOwrjmWs0z1keniIPf863SKoIr85itDdbpY1z3IXZhl82KPASL/1qeCItoE0hZN26s2Yc/uLGi193ELsW8bnKS+rrWrHDcFxy3e1DP6i9JTpBG1e5VV86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKp+LF2JUVUtqiB2fzWTFPA7sk0lUwKp+R7RWwReNJs=;
 b=rQINpO3Rg1hrojaxjMdijS4vA5wvfuuXXKntPKH906ApynXL9dSdisWiWjGbn6rCrOzbMV1zp9fo56Czo0zVFe4V6W/T6bCh/xCV+4DzK1I84rFS9+poQzKcZoSDJWd/RMzPpVAg95bPCMaRJuT2W5xv6eKmIAFm/Dh3s+NtUoTanKw0BzX3fhF4q/IiFCQooYjjQx53jH8t/L1ZzhtHU5XJEyiQYdQI5cLA2iRORogVTkIf7dGkEywLHjsdbE/2RCT4FEOrCjzH/gkUZqKcIN5LRwn7N2W9xUM1dydIejsOyaNF4ISUq6KE5tfvAZts9ppo2dGylo7iYmn7ZoPexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.183.173.212) smtp.rcpttodomain=gmail.com smtp.mailfrom=macqel.be;
 dmarc=none action=none header.from=macqel.be; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macq.onmicrosoft.com;
 s=selector2-macq-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKp+LF2JUVUtqiB2fzWTFPA7sk0lUwKp+R7RWwReNJs=;
 b=YCv2FUfCfmWUsOMDqrmjdTeVTcFb4kphfcjHhh5527jfPM6Zekr7Wx1zyVHphNgECnQp+kKyZFxGqZT8DQDHLo0Toi/l88JjkblRd48ORZw3QEybLjz/TLAlm6SEjoPlb96YBMSg/fapmtIBbOl89G1q2dlje51KWlTWoF68z1Y=
Received: from DUZP191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::18)
 by VE1PR05MB7214.eurprd05.prod.outlook.com (2603:10a6:800:1b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 09:09:30 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:4f9:cafe::a1) by DUZP191CA0014.outlook.office365.com
 (2603:10a6:10:4f9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Fri,
 26 Jun 2026 09:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 91.183.173.212) smtp.mailfrom=macqel.be; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=macqel.be;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 macqel.be discourages use of 91.183.173.212 as permitted sender)
Received: from frolo.macqel.be (91.183.173.212) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server id 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 09:09:29
 +0000
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 52502DF00C7; Fri, 26 Jun 2026 11:09:28 +0200 (CEST)
Date: Fri, 26 Jun 2026 11:09:29 +0200
From: Philippe De Muyter <phdm@macqel.be>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, kees@kernel.org,
	hexlabsecurity@proton.me, objecting@objecting.org,
	akpm@linux-foundation.org, yuantan098@gmail.com, bird@lzu.edu.cn,
	roxy520tt@gmail.com
Subject: Re: [PATCH 1/1] block: partition: aix: bound LV name formatting
Message-ID: <20260626090929.GA4627@frolo.corp.macq.eu>
References: <cover.1782398104.git.roxy520tt@gmail.com> <6f381f63ccfe458e15067fd9b9428884cb8d5f97.1782407859.git.roxy520tt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f381f63ccfe458e15067fd9b9428884cb8d5f97.1782407859.git.roxy520tt@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|VE1PR05MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: a4057593-0e37-48f4-5d6d-08ded362a140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|7416014|376014|36860700016|22082099003|18002099003|4143699003|56012099006|11063799006|3023799007|75936004|14776008;
X-Microsoft-Antispam-Message-Info:
	+lVrIzwpd1p6v7sdmCaiHQVNsxOCNYXgKM5jcj8HEaNxf7eBeoCWyj6P/gFBuiULJMx76cwxGmcdsr6CVYbqFU4dlpbg4VXJ+nDYcaUz9bgcu4EFgWvTH1Ahla2VQNZijabwzyPERL239/VUnqjJ3N9tabFzOZ6aEH56ubgkKV5FjysyLeGZzyzEHtpGTLmx4BNOEOQ99KAvVOIXfZrPKUoE6r6v36kdpwsbE1qmqb9EIlkYMJ5yW0aUaxTOy98TujoDu7x4HxAPaFJQV6ZG6c/OfOvjGYqLpZaqMrnoaUtV9o/7mlK6NpEYorrAwiuq8mtJDSsLpI7tREJ8r2Y7+Y6T/ayx/s41sCJdwcs9bAf4bpT0XT4E7y6PNMrqdomyxGoZVjiA1ofoiNCoW0eery7vEr4mOIP4QVc6HvTaCdlIiPojqnBLzvuNRYFlLObeGeYj1XkY3mJEYrcdW1UqgT3b3fiYz3S8D58nP8cjbCoDF01DVGoF76lbiqaRJ9+BNN9e2aYAX0pVi0MSESj4km+0yY8mJgLiXmSi7LwW3din9zGmbjp2fhaunIhtoHzemlSauPWa5d+Ax7mIgaIXDT9+kS9I4Tqy/yc1t8K7ZYLu6NaW272GdY17Iq6OR+Kqd0zxA6PFnuWP8WGthPZdP+W3KZhiC+xCAqTees6MGXDjvLdWaaCRIw+DTWrbg4KD69C3OwbwnlHKA536PbMZfqQefNjIuAvCoRRhmlCRFp9C9G2f93vsSjjxsUqFRgyk9O/RKY01Wi7V8//QFnuqzQ==
X-Forefront-Antispam-Report:
	CIP:91.183.173.212;CTRY:BE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:frolo.macqel.be;PTR:212.173-183-91.adsl-static.isp.belgacom.be;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(7416014)(376014)(36860700016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(3023799007)(75936004)(14776008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nXNwEOSwa+botlaHb+3MtlU/nvrDepJCEocdxhmFYUN9oJfgSX84yhyc1DrDtAHajIXRBspEh6t3sv7HEsx9H/ntU+XRI4p6Z4XT54B+W6FSav7pLRX+sW3sA3DW0LTmkknEsGmoV0/LYgic/Uv1KGaIij3FprTLzit071F9s4f5OP0VAfKrKVKP0hgS/rPJE22xBWgXhPKPQJksGGFn9yo4OS7MCuyblVuL6fyk29f1NGbryAgiZJqhktbIC02QGsonwaj09FdK1Ba7NEpvoBAc8oKPp8TG/PurcAx4GA+YhRHObwa4ziJ5kEPwKfUcblUYtbraIqZPxi3IC6ILQKlPE6D6/WUgBK8fMQD7sF2ri+rer59fN45SOt6aOsuQu+vTRjgFIqJ/Ky1wZXzghVMRtiNt7yYhJVy48QLm0x7W6cy/AhD9//deVKVHS6bh
X-OriginatorOrg: macqel.be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:09:29.5787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4057593-0e37-48f4-5d6d-08ded362a140
X-MS-Exchange-CrossTenant-Id: 5541087b-384c-4066-992a-42aa5fe171eb
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5541087b-384c-4066-992a-42aa5fe171eb;Ip=[91.183.173.212];Helo=[frolo.macqel.be]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR05MB7214

Hello Ren Wei,

On Fri, Jun 26, 2026 at 03:21:22PM +0800, Ren Wei wrote:
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
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  block/partitions/aix.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/partitions/aix.c b/block/partitions/aix.c
> index f3c4174e003e..de19c19c85b2 100644
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
> @@ -273,7 +274,8 @@ int aix_partition(struct parsed_partitions *state)
>  			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous) {
>  				char tmp[sizeof(n[i].name) + 1]; // null char
>  
> -				snprintf(tmp, sizeof(tmp), "%s", n[i].name);
> +				snprintf(tmp, sizeof(tmp), "%.*s",
> +					 (int)sizeof(n[i].name), n[i].name);

Is this change necessary ? snprintf always adds a NULL terminator and
truncates the input if needed, isn't it ?

>  				pr_warn("partition %s (%u pp's found) is "
>  					"not contiguous\n",
>  					tmp, lvip[i].pps_found);
> -- 
> 2.43.0

Best Regards

Philippe De Muyter
