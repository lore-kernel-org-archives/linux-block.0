Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023099.outbound.protection.outlook.com [52.101.83.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A2369D57;
	Mon,  8 Jun 2026 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919198; cv=fail; b=tZQ9qFdfKLw5uDPjGG6/KL8h9PYg80ZPeDNtgMX246pwDl3BJ7gHqC6u2bjIFoIfzmBNJS8NtggXxL53T2RMTjtu6qyxdKCxVnQMGarH4IkAjS53Zs7Dzz5Kqs8rsaOozutv6ye9N5qU5+s0mYVYkt26bWv9DNHBl2VelAhH0AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919198; c=relaxed/simple;
	bh=nVmInWNVQslybj7WvXJ9LqAk4UMZbJH/aedFzKVHmZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXsvGmAB2rYY80FlbgadBra0sxA/vq3a9x2nE/pTmhCqQWPdqCW+e8x5WjHjG2YO3M6hKme8u25Grsd4oS7ixtOio6XfgzF2mJ891Z++ncphS4gysOy5RbFyJEg3Yl13rfQWufFsK2IS/exWXKMV6ctC3mrHMSdjz6nHorjIaBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macqel.be; spf=pass smtp.mailfrom=macq.eu; dkim=pass (1024-bit key) header.d=macq.onmicrosoft.com header.i=@macq.onmicrosoft.com header.b=SlHPPXCg; arc=fail smtp.client-ip=52.101.83.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macqel.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=macq.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=macq.onmicrosoft.com header.i=@macq.onmicrosoft.com header.b="SlHPPXCg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHY5OsP1JuHSrvvCdNJKUKJHC0ykQQaUQsl8zeXT8GjZ0gvnsTvobOCJ5yq3aYnplUxY7ldmAqGYFqzTbsqKHFqYpsszv7YfHuQbrTboQc9RWBhXMeklbx4DUC5nkWokoc4b/jGZq+DrYxoeCqLM0ZjlkgTJ4bKj+7Edq2SxVsDB0rowvYRFStTvn5KcLdwOshS4nICY1gEQpLZuXmF1aeMCDqL7bY92+kydmX8fsuhK9qaGADBs1/X9c7edwMJQ4elbDg0w2Dy7eKY7KGsx14oEQrkorbMdNd8/W+XGw79ceUT0tMemS+Qkq/dotB/UTthmdx4mzBLUwbpx4C3R8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTurFPVGKlTlYGSc0PWDRYymcL3lYa+zGy5DWdVL/q8=;
 b=OnLI7SAIsaSALzY6b8mlK6RYXEOB7tJTwr7h4ZnUVjeeH+xpw2iw+6u/kt1EDLWS5zFmnyFskHOGZTi9vqeilIvJw7qwG4YT1Cx7m2HRWNqPicJ6Hvb4WuPLQlC7W1KXxztvCoevB6JV401XCKgWIDYb//uE+00+5XXr0eAAEpwxuU6P3OtFlj114tW3e9BH5AiZ7B9b50RmIXo2yW9i38OlvVhyQTnw0Mftdg7ArdJLK5HbEpHEzQBHorrLJE/XlVbQYHQOnkA4iWseP3RLnWp8yY8n9H1yDc+zGmuFzbpt9Cl1sPOhuNtbg+VDogC/6M0K1xggr0/2XW+yUXfdGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.183.173.212) smtp.rcpttodomain=gmail.com smtp.mailfrom=macqel.be;
 dmarc=none action=none header.from=macqel.be; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macq.onmicrosoft.com;
 s=selector2-macq-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTurFPVGKlTlYGSc0PWDRYymcL3lYa+zGy5DWdVL/q8=;
 b=SlHPPXCguKGXQBJPgBj9T1BUjDykYOGBhZi+AeuegCcej4UJLr6qy6S6oWoHafD/O/6aueVKscMjRIXujD4errrsP19Gt5gLsiwT73x5L9vskSiWh337SfuyWSOUnipR/DYsujfM8k9zJg8/2IywpLauH4/b9HVSPoymOqo+N9M=
Received: from DU6P191CA0048.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::7) by
 AM7PR05MB6993.eurprd05.prod.outlook.com (2603:10a6:20b:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 11:46:28 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::72) by DU6P191CA0048.outlook.office365.com
 (2603:10a6:10:53f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Mon, 8
 Jun 2026 11:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 91.183.173.212) smtp.mailfrom=macqel.be; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=macqel.be;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 macqel.be discourages use of 91.183.173.212 as permitted sender)
Received: from frolo.macqel.be (91.183.173.212) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server id 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 11:46:26
 +0000
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id E2AC5DF00C7; Mon,  8 Jun 2026 13:46:25 +0200 (CEST)
Date: Mon, 8 Jun 2026 13:46:25 +0200
From: Philippe De Muyter <phdm@macqel.be>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Kees Cook <kees@kernel.org>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions: aix: bound the pp_count scan to the ppe
	array
Message-ID: <20260608114625.GA8545@frolo.corp.macq.eu>
References: <20260607064137.302574-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607064137.302574-1-hexlabsecurity@proton.me>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|AM7PR05MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: a745f345-902a-4c35-b8a5-08dec5539263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099006|11063799006|14776008|75936004;
X-Microsoft-Antispam-Message-Info:
	/v80JGFDggOF1ZWe2KsZ2U/+Jyg1GB9dWNl+MzgBf99L72oG8HA7CW0AUXNYLgdoY1YUCUk4Ifv9NICwEUj+rJZUVzRNxWLtTCuBlvUld9Hto7/PwxvTlcaXqr6E0eRsAmxVQTdaFK+o6Pmg5XWIz06u5geco25dNUvyHwMTomCU70aRyHdX2GkWfpXLtTmSwHl0W5Kn4dcApMVhYvkVW81lOL5OrfE2wQVcGKV6rG+ygs/ra4v1mmji3b6dIIiqai6wy7pFoGhLOsqcRlE2JBm9o+zeVYKlI8BlB5GxgdI5LnQxGvyaT9MXEorujz1S5RrHHHhvdcnFimDX2NXgPJfBzILVeB+o0qi7UfEDno/2ojM7PLCZt9LJWzVBhLeNul7oKcvE5gmwQY34AmMGDtY8h6zZs6PGg7xqmx7673CE+HriDRsPZBY54XD1w+7ABYjK+TO7NyFjAHzK0rN0fmFMJgy83WmJsd7O+Q14A0nr4SNl3LTDc7StIU5au99UmwR8QRrfLE4HQcq9DvqLPLiJllqld/wxTykmCNWHDSzu/6lRXhtxiPbo4LAlcDHQTRyXKvxBnMwqcwoNeIBPWE8vYnoIAnZ04fdrEvW/t6L87WUnm0KLzU+1mib4PkMP0NiKKnNI6+HOLB6etcSFA8LYdoy79KGXneOf7XF2noVqvDD0piBQANXR0LtbthL3QoMmGK3Ub9h/9ByWgxa6U8jD2uwd1qL2Sbhi44IvuMgtsslkjGUIGj2Gew+QpZ4TleAG0rOHcsxYWR/5IMByuila0nWI/Jn1QmsgU1UFpg7MeARzgYcC0BQyUmDEzUFi
X-Forefront-Antispam-Report:
	CIP:91.183.173.212;CTRY:BE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:frolo.macqel.be;PTR:212.173-183-91.adsl-static.isp.belgacom.be;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006)(14776008)(75936004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sbVq6rK/D1j3ruHlghYaGB65O46yE7x4AM2XOyz6jSS9Kzw47X6r+xanCRks73Yat2Oor21t6gAiAKGd0CIBKghsPK5pFkbWR+VPPbvMOHgaqVLjcOH/OrE9O8fSKPUkuYa9+VSxetiDiNWda0TkkdiqapDxA3IWd2Tdz/4LV0rAJXixod3Hj+ZgCjm5v1K1YhXb5UvPPV5tHCDANZfKFhVWOHHBM3MCVBZAqINlgPEvUE6k8puo7oN/3EJ0wx0CTp4WQ9VfTUlEWtrLK6K+HmhAmKhwLGlYXaOC5rJIN5c2g/pBOAYtM+MGJyGYdv+s/rz8Lv3feAbP+fkKAKN6svUlegighb71Q0pgYgEqI6N3BGRD73Yg1MBRkgYmvbM2kImA2oWouC1WHMIEzZy1uJCu4zm0f/M+8GH8Ae+HVmuFgA/HrFvGjE3j36TBAn50
X-OriginatorOrg: macqel.be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 11:46:26.1080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a745f345-902a-4c35-b8a5-08dec5539263
X-MS-Exchange-CrossTenant-Id: 5541087b-384c-4066-992a-42aa5fe171eb
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5541087b-384c-4066-992a-42aa5fe171eb;Ip=[91.183.173.212];Helo=[frolo.macqel.be]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6993

Hello Bryam,

On Sun, Jun 07, 2026 at 06:41:43AM +0000, Bryam Vargas wrote:
> aix_partition() reads the physical volume descriptor into a fixed-size
> struct pvd and then scans its physical-partition-extent array:
> 
> 	int numpps = be16_to_cpu(pvd->pp_count);
> 	...
> 	for (i = 0; i < numpps; i += 1) {
> 		struct ppe *p = pvd->ppe + i;
> 		...
> 		lp_ix = be16_to_cpu(p->lp_ix);
> 
> pvd points at a single kmalloc()'d struct pvd whose ppe[] member holds a
> fixed ARRAY_SIZE(pvd->ppe) (1016) entries, but the loop runs up to the
> on-disk pp_count.  pp_count is an unvalidated __be16 read straight from
> the descriptor, so a crafted AIX image with pp_count larger than 1016
> drives the loop to read pvd->ppe[i] past the end of the allocation (up to
> 65535 entries, ~2 MB out of bounds).
> 
> The partition scan runs without mounting anything, when a block device
> with a crafted AIX/IBM partition table appears (an attacker-supplied
> image attached with losetup -P, or a device auto-scanned by udev), via
> msdos_partition() -> aix_partition().
> 
> Clamp the scan to the number of entries the ppe[] array can hold.
> 
> Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> Reproduced on v7.1-rc6 with KASAN (CONFIG_PARTITION_ADVANCED +
> CONFIG_AIX_PARTITION).  A crafted disk image whose AIX/IBM partition table
> sets pp_count to 0xffff, attached with `losetup -fP image.img` (in-kernel
> partition scan, no mount), is reported by KASAN:
> 
>   BUG: KASAN: slab-out-of-bounds in aix_partition+0xb6e/0xee0
>   Read of size 2 at addr ... by task losetup
>    aix_partition
>    msdos_partition
>    bdev_disk_changed
>    loop_reread_partitions
>    loop_configure
>    lo_ioctl
>    __x64_sys_ioctl
> 
> i.e. a read past the end of the kmalloc(sizeof(struct pvd)) object.  A control
> image with pp_count == 1016 (== ARRAY_SIZE(pvd->ppe)) is clean.  With this
> patch the crafted image is parsed with no out-of-bounds access.
> 
> This is the read-loop sibling of the lvd scan bounded by Michael Bommarito's
> "partitions: aix: bound the lvd scan to one sector"; that change does not
> touch the pp_count/ppe[] loop, so the two are complementary (separate hunks).
> 
>  block/partitions/aix.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/block/partitions/aix.c b/block/partitions/aix.c
> index 29b8f4cebb63..f3c4174e003e 100644
> --- a/block/partitions/aix.c
> +++ b/block/partitions/aix.c
> @@ -226,6 +226,15 @@ int aix_partition(struct parsed_partitions *state)
>  		int next_lp_ix = 1;
>  		int lp_ix;
>  
> +		/*
> +		 * pvd was read into a fixed-size struct pvd whose ppe[] array
> +		 * holds ARRAY_SIZE(pvd->ppe) entries.  pp_count is an
> +		 * unvalidated on-disk __be16, so clamp the scan to the array
> +		 * size to avoid walking past the allocation.
> +		 */
> +		if (numpps > ARRAY_SIZE(pvd->ppe))
> +			numpps = ARRAY_SIZE(pvd->ppe);
> +
>  		for (i = 0; i < numpps; i += 1) {
>  			struct ppe *p = pvd->ppe + i;
>  			unsigned int lv_ix;
> -- 
> 2.43.0

Thank you for your patch.

Acked-by: Philippe De Muyter <phdm@macqel.be>

Best regards

Philippe
