Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020143.outbound.protection.outlook.com [52.101.69.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82F73B71DA
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606696; cv=fail; b=gJu77cmZj6wobaGao3Mm+Gna94Ps8jHRWXfrGi8HkBkMoPmHNoRy70LJM4v/MlqRC7Ug+UR/A9P6faOdwAZnDhADscqIkVjRx0xicCqhgN6HhY7zRZLUSSzu2kxSG4EWzrjmuB/BU8Qe8h8N8/u4bCbNYOi0jwO+YzrZTC+eIYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606696; c=relaxed/simple;
	bh=CNrgBw7Ap9OJgzWg3X/m2yKfvLQgSMspWXfE7DjuHgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRoohKeGBkBE6L1Ir6lJbvFxm9lestlsv/niV6Y53NpeGcNvNMcgW4FDdLhLZKwDCal2SVdIGKtJsV+FmoPYPSw2gvSqWFbAyS+PFrxH8gGZwSzSAXqTh+84W4m6GqGLv1jTULIzq0lNGtdut+1nkWmmxsK5ff7NtCECHO8/uHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macqel.be; spf=pass smtp.mailfrom=macq.eu; dkim=pass (1024-bit key) header.d=macq.onmicrosoft.com header.i=@macq.onmicrosoft.com header.b=L3to7lc2; arc=fail smtp.client-ip=52.101.69.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macqel.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=macq.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=macq.onmicrosoft.com header.i=@macq.onmicrosoft.com header.b="L3to7lc2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0pMvfSs0LEJb97smkGPEcScbpbPLKDJMMm0bKnt1WtexxjSVAmAj4MTxaSzBbF2GfZCYO+hWUE35bTLUWv60s+oPaOSfjFDjGkWIGMiuM6muESmtKALEx/qDWRVYaa9RboSaVVvBhFCg7cDf4+ZZjzHkZc8uIKXbqZ6XxL6940o76GMgwrBEXBu7VQFdItgMa2D5W0fVLDcLL/GTDG8y0LD6aYAuFaif+zykazeLuw80fG5t+cqhBqMW3pGc6Ibj7JX7T4eeh6CG/Iby8ApPBblx2VdywSmNYNC+B7b8G487rR9xses7QkaFbSfQK0VwUOXKaEYyYeoalMxpwZRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0C1afydmM6hJamBdtA0K38Llo2F+Uho8Fh/+Yh3Has=;
 b=aCjEfIx5d1QVzF+HbyY+bHImhL0KZUB8faxB9qd8eOvSvkyh3Fj/ob1/dX3nhNRwQLxrpx4AvCAOrE1sPl5FkjF4z/2PIDsBml1aKlxrBKajPYOqvs174BpYhlNC+X5ET/j/wvK2YL5XUFo0DVJysF7n7mnm8mCTP80jffXwD78Ov3pktk+8Z5oGS+iQWqBXGvCkterxBVEiCE6foW7YOzSaVq1aBbpSmqSnXRgnkyZY07zltEFO5pnDT0DZX3EpomBp1gXSL2fq+s8Ca7YSghjrMakV08E3ZSOUp9pKZ5R/DiKHPKkA6SU1Sw22GMs/9RnHJVAWh6xuURLaI0tAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.183.173.212) smtp.rcpttodomain=gmail.com smtp.mailfrom=macqel.be;
 dmarc=none action=none header.from=macqel.be; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macq.onmicrosoft.com;
 s=selector2-macq-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0C1afydmM6hJamBdtA0K38Llo2F+Uho8Fh/+Yh3Has=;
 b=L3to7lc29E9kKxo7wSLC8oISHR3u0shggZs02vV18k6m+n4KA4VzEXioQepwSbP4IJ7IXzZlmSiQftzIvmKkpB1OiBXRCj3JC3zryTqpJrc+9iSX7xxEp3M3l/4UCsvO3F4CI4qd0CGUPaCwSxOGEZOuyhsKlncO/6fpRGIaKvo=
Received: from DB8P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::14)
 by VI0PR05MB12609.eurprd05.prod.outlook.com (2603:10a6:800:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 10:44:47 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::60) by DB8P191CA0004.outlook.office365.com
 (2603:10a6:10:130::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 10:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 91.183.173.212) smtp.mailfrom=macqel.be; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=macqel.be;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 macqel.be discourages use of 91.183.173.212 as permitted sender)
Received: from frolo.macqel.be (91.183.173.212) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server id 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 10:44:47 +0000
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 00920DF00C7; Tue, 16 Jun 2026 12:44:46 +0200 (CEST)
Date: Tue, 16 Jun 2026 12:44:46 +0200
From: Philippe De Muyter <phdm@macqel.be>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-block@vger.kernel.org, kees@kernel.org, axboe@kernel.dk,
	objecting@objecting.org, akpm@linux-foundation.org,
	yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn,
	zzhan461@ucr.edu
Subject: Re: [PATCH 1/1] block: partitions: bound sysv68 slice table count
Message-ID: <20260616104446.GA20822@frolo.corp.macq.eu>
References: <cover.1781036698.git.zzhan461@ucr.edu> <f16321f7378d613d81af13f288de82217fc7d934.1781036698.git.zzhan461@ucr.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f16321f7378d613d81af13f288de82217fc7d934.1781036698.git.zzhan461@ucr.edu>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|VI0PR05MB12609:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ab01cb-ada9-4368-28e0-08decb944904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|82310400026|1800799024|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|75936004|14776008;
X-Microsoft-Antispam-Message-Info:
	ttdmzsyaOtDeHeGY3SQyESje+/chwm/pymdycuxEzOdQmsvsWgIBMO/p4F0R0/ty1GzaH/MKnNlr37rZwao4Q4ClfFAybEtdmzRjtT6lO1jlHBkARUBrMRbJYQD20SXyRqnQnITlhSAxzeUFvieAbCNhkDfF4osDw5Ki0a99VQTSXdpVFl9dRcuuKxeaMTrD7o0/tdkuTBz33F6eMNdchzIsrwX/7WPo6R69AHkNxl0V6zNQVCsMMxLnqxgMdDOoVmgG0lU1dr1rHQWQhe4lVJCWTX3ld/1S7eRimTEFis8jFwAN35YCkm0899O4JVGusVpYb7/pv2Wpsf8yAkpT3O5uo2iEZ6JOKyF68Be0NOEoG9gBMmfmEyLLgbU5JYM8M3gpucix+YfE4WbRxnHXawKd4UKHQZoJOIpZpdYw0FSVrZDrkcjsAXs5ptkCzEDalpFg1YEehz+vvLj2dL7UJkJmvqdRwl79EVW+8d7CQlxmJbLsP+FFVqwVRIkIW4A2buXlhQgRwEgLhsbAQEtI4JbeOTNOGX2yPjy58krNDCrP0CRJO2SKk77F6L4P0hlZ7+e79ygDy/Q1w5kCRFFISOUBI1WPdS/9o7ogvOsYnEVhNmUo2BLbD1B5WsYBo6kL/r0Pfw6FGiGdxgjS1nMzcUPu667p6Za9YwJ1bPW1K03IBC/WhkRMY6ikGvEp0KmLnVzws3QkmuL+zpUWwkYAaNFq7AqWmqgqaIcMBWN8+ZKM7n3lBFmmuLLXwP6mJfVmyojs3HNLn+8RQMvs46832MGIwvcreZXC+bEISiLhUH2tmrsozE0Ap5KVAyaD1ZTC
X-Forefront-Antispam-Report:
	CIP:91.183.173.212;CTRY:BE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:frolo.macqel.be;PTR:212.173-183-91.adsl-static.isp.belgacom.be;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(82310400026)(1800799024)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(75936004)(14776008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RwaNTEDB4o9XFz2JBazxKd7IGtkTxQXEjyFEmqpawFY8qroQN8oXHUggJDCnzX2X6KYPKsQ26rmhv8t/hDdDdYyHeTJgWlQKIhUCRbSGwHB+HNAY8VJjjTcGJXQCNB3/bpZFsTQvdKQ9NitKeAUv08m9BXWIYQ3JuAbLQOGASekeFLvUsv0IX9qjapLIclxdwM7LVjmDw6uoJly/7XFHPwYIGZgW+EV10JgszLToP5EY4rwRXcLVunYCP9FEUKzkdqYq/kiPvMNK53jV8MgR+WFcnBPDulUHql9LS1+EitY1ONg5vagvafysJMNXED5KGOj5VPR+UqsL3Rf8ewZHhjdD1lPkeQq8PW8J05clnyF5Wo/I5sxRmK8cUcj1EdL4sj0uXgO1JTb8qqVegNZVpoosLahxpSt6uwyu3rsC6gn5JIVarRI9/q40dDS1rl4C
X-OriginatorOrg: macqel.be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 10:44:47.2751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ab01cb-ada9-4368-28e0-08decb944904
X-MS-Exchange-CrossTenant-Id: 5541087b-384c-4066-992a-42aa5fe171eb
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5541087b-384c-4066-992a-42aa5fe171eb;Ip=[91.183.173.212];Helo=[frolo.macqel.be]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR05MB12609

Hi Ren Wei,

On Thu, Jun 11, 2026 at 12:58:13AM +0800, Ren Wei wrote:
> From: Zhao Zhang <zzhan461@ucr.edu>
> 
> sysv68_partition() reads a single sector for the slice table, but it
> trusts ios_slccnt from disk and walks that many entries after skipping
> the synthetic whole-disk slice. A crafted image can set ios_slccnt
> larger than the 64 struct slice records that fit in one sector and
> trigger an out-of-bounds read while scanning partitions.
> 
> Limit the slice count to the number of records that fit in the sector
> returned by read_part_sector(), then drop the whole-disk entry only
> when the bounded count is non-zero.
> 
> Fixes: 19d0e8ce856a ("partition: add support for sysv68 partitions")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  block/partitions/sysv68.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/block/partitions/sysv68.c b/block/partitions/sysv68.c
> index 470e0f9de7be..5110ed83c541 100644
> --- a/block/partitions/sysv68.c
> +++ b/block/partitions/sysv68.c
> @@ -48,7 +48,8 @@ struct slice {
>  
>  int sysv68_partition(struct parsed_partitions *state)
>  {
> -	int i, slices;
> +	sector_t slice_sector;
> +	unsigned int i, slices;
>  	int slot = 1;
>  	Sector sect;
>  	unsigned char *data;
> @@ -65,14 +66,16 @@ int sysv68_partition(struct parsed_partitions *state)
>  		return 0;
>  	}
>  	slices = be16_to_cpu(b->dk_ios.ios_slccnt);
> -	i = be32_to_cpu(b->dk_ios.ios_slcblk);
> +	slice_sector = be32_to_cpu(b->dk_ios.ios_slcblk);
>  	put_dev_sector(sect);
>  
> -	data = read_part_sector(state, i, &sect);
> +	data = read_part_sector(state, slice_sector, &sect);
>  	if (!data)
>  		return -1;
>  
> -	slices -= 1; /* last slice is the whole disk */
> +	slices = min_t(unsigned int, slices, SECTOR_SIZE / sizeof(*slice));
> +	if (slices)
> +		slices -= 1; /* last slice is the whole disk */
>  	seq_buf_printf(&state->pp_buf, "sysV68: %s(s%u)", state->name, slices);
>  	slice = (struct slice *)data;
>  	for (i = 0; i < slices; i++, slice++) {
> -- 
> 2.47.3

That does the job.  IIRC 'last slice' had number 7, so ios_slccnt had to be
8.  I do not have such a partition handy at the moment, so

Reviewed-by: Philippe De Muyter <phdm@macqel.be>

Best regards

Philippe
