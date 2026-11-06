Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793946312;
	b=4ZFqqXwrg5V4DoiZxOF37AzjV4wf391rLB9wcSTmOiDuMRbm5dAyM+Vg6qgaIETb4WQW
	 uqAcE+W84L3CIwtCTa4ckRuOm8K4fgSYMlTIjY+EC64X+pX3SmR3lJU1dj2DKNGdI4ICH
	 xVEHseII65fZGTC7znwd0HBbmr9/TdMBaLfKcF0uRv+E1mA4uFBmjhLe79RldB4Jqw10H
	 dhjbpDL69HFECRzDgfKTDSsh3Kd2Upwu+l0pLOwoLqEf3Ixk3tSYbDcoOQX0WOkzmZw+P
	 jzTKlgjM1VH5HYJiyc/ykSE8eGFn54ELOAT84cCnAve4Yfh10163U08LKpjkvmuGXJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793946312;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=4D5Aw1kmCq4DsiYS+lucaHDE9Hk1hB54tE80B9HVb3c=;
	b=r255fUOdFJlXl6cOLrrmtSc75S7WgENzKncA521QhpR6VCOZSiEocf3Jp0d5Z5zpPFjh
	 5EKJqLoU8AJauenxaXoYjS9VfygG7lxVeZN1mZH0/2HvKSkcVgmQ22XmvaShCNOsXqx9v
	 KWkyh8WCCElumj8Lm2Q7oBD3FMgCBCHN3nPmfCWCRQB3huvfmyyRySsabFiW3FH/2k1JP
	 UhtBUtWb7YO045r7nnvyg51yPEZyTgVDAORcuARofENSWg8jTvpPyRtwYZCce5OhTZvHo
	 KAESV6sKiLsvuxF/39PeiBSH0s/9JkWyWUoUxL9CVTc1w6HJQ0sYP0DG9RxnTaV1RXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=n2GjRFhM;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC10606A326;
	Fri,  6 Nov 2026 06:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CC10606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=n2GjRFhM
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4D5Aw1kmCq4DsiYS+lucaHDE9Hk1hB54tE80B9HVb3c=;
	b=n2GjRFhMc3wafmSu0U5/Vh/pP/CTWJY5KQGQzAJoCaPmgHNoYobyrykNuXv3IfCpBNR349n5D
	dHjjVD1bcXbz/NWYOSjsG02TYia5VQFMujxyP9bCTVYI96kqfKVLMSlesCdP62ogF/w/M0RGXIW
	vvlTZHrUzYGEDVnK1WmNFL4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jLTgB4lPHz1prmZ;
	Fri,  6 Nov 2026 14:24:54 +0800 (CST)
Received: from kwepemr200011.china.huawei.com (unknown [7.202.195.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 606B940561;
	Fri,  6 Nov 2026 14:25:00 +0800 (CST)
Received: from localhost.localdomain (10.50.159.234) by
 kwepemr200011.china.huawei.com (7.202.195.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 6 Nov 2026 14:24:59 +0800
From: zhangqiuhao <zhangqiuhao@huawei.com>
To: <ldm@flatcap.org>, <axboe@kernel.dk>
CC: <hewenliang4@huawei.com>, <yangyun50@huawei.com>,
	<chenrenhui1@huawei.com>, <wuguanghao3@h-partners.com>, <wozizhi@huawei.com>,
	<linux-ntfs-dev@lists.sourceforge.net>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: partitions: ldm: avoid overflow in VMDB size check
Date: Fri, 6 Nov 2026 14:16:15 +0800
Message-ID: <20261106061615.1688398-1-zhangqiuhao@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <179360149774.20265.17257530536010482220@huawei.com>
References: <179360149774.20265.17257530536010482220@huawei.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr200011.china.huawei.com (7.202.195.32)

Hi, maintainers

Kindly ping.

On Mon, 2 Nov 2026 14:38:17 +0800, zhangqiuhao wrote:
> ldm_validate_vmdb() can accept a VMDB whose declared VBLK extent
> exceeds the TOCBLOCK configuration bitmap.
>
> For example, these fields on a 4 MiB image pass the preceding PRIVHEAD
> and TOCBLOCK bounds checks:
>
>     disk capacity = 8192 sectors
>     config_start  = 6144 sectors
>     config_size   = 2048 sectors
>     bitmap1_start =   17 sectors
>     bitmap1_size  = 1024 sectors (524288 bytes)
>     vblk_size     =  128 bytes
>     last_vblk_seq = 0x02000008 (33554440)
>
> The configuration area fits on the disk, and the bitmap ends at sector
> 1041 within the 2048-sector area. The VBLK extent is 128 * 33554440 =
> 4294968320 bytes (4 GiB + 1024 bytes), so the VMDB should be rejected.
> Both multiplicands are u32, however, so the product wraps to 1024 before
>
> it is promoted to u64 for the comparison. The check evaluates
> 1024 > 524288 as false and incorrectly accepts the VMDB.
>
> Cast vblk_size to u64 before multiplying. The check then evaluates
>
> 4294968320 > 524288 as true and rejects the out-of-range extent.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: zhangqiuhao <zhangqiuhao@huawei.com>
> ---
>
> Based on Jens Axboe's for-next at
> 70866cfa169d5ee149364267289e71d50f9a7ae9.
>
>  block/partitions/ldm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
> index c0bdcae58..d5c133a33 100644
> --- a/block/partitions/ldm.c
> +++ b/block/partitions/ldm.c
> @@ -458,7 +458,8 @@ static bool ldm_validate_vmdb(struct parsed_partitions *state,
>  	 * The last_vblkd_seq can be before the end of the vmdb, just make sure
>  	 * it is not out of bounds.
>  	 */
> -	if ((vm->vblk_size * vm->last_vblk_seq) > (toc->bitmap1_size << 9)) {
> +	if (((u64)vm->vblk_size * vm->last_vblk_seq) >
> +	    (toc->bitmap1_size << 9)) {
>  		ldm_crit ("VMDB exceeds allowed size specified by TOCBLOCK.  "
>  				"Database is corrupt.  Aborting.");
>  		goto out;
> --
> 2.33.0
