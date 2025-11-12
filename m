Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DD1296BB6
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912937; cv=none; b=QXOvtwUwfhK8s/pAY1IWiIvyqzqz+uIQ1qrk36vjCDcdVATXPkbW2480yRC4ftSnapOkDQl8oBZlt175DdEhID1jFf+3Wq3BG0nt4nbwySvynboSLyINI1CIe7Xl06HY3Sa+SrmmzyYmC/TrQTkI/mfvj/pUOyLsx/vY0udJkq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912937; c=relaxed/simple;
	bh=9yBkmFjX0BTdmGTaus/EfJdbv16QgnTQmTdabBOZ3os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXfmASXhG3K4Uahml3btpJm2tk3fC7SWClB7KVHgMJHvIMOIuzu7L94iEr5z0/KXV40weCKwLkoem5hyf0ONkzyyvt1PtXWhu7eR5S85RIVrhuB1+88BeLz0djyClhKoGju9EtoeQCnq6Mv0iYisMTQelj76SCaAx8YM9eGO2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieOg/LOc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieOg/LOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A966C4CEF5;
	Wed, 12 Nov 2025 02:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762912935;
	bh=9yBkmFjX0BTdmGTaus/EfJdbv16QgnTQmTdabBOZ3os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieOg/LOcPTkJVycz9NRlyWZ/60xtRSJe2eO3TmS4fes5TIoRDJn13D2TJhGTzoQ9l
	 4zTIDsw9yUndSSUwkwuNIzPQ54EEZsHs6LV1tzGKsLm8D37YqppYZ9DncHf2t040+S
	 kKu4bgpqHO4k4Mv7SYLQ/4tiOv2IWlZyB7apeCDmSmoA8WPLfIqJZ7eJ7sBfvcFlBT
	 btEvrh7a9bDmsLshYzZMzRbUO8dbdw7yNtxsvg1zQmr4Ok5z8Aqa5zaNbHx6MYS/Pf
	 HcZNTm3cTkhxjcULRN4COAovaSySBewE4zk+KNqw2dd4eC28OUSB/8SQftNEstIiJd
	 NQq/uvOz6oWlg==
Date: Tue, 11 Nov 2025 21:02:10 -0500
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Zheng Qixing <zhengqixing@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH] Revert "null_blk: allow byte aligned memory offsets"
Message-ID: <aRPqoinLQjYFBJsO@kbusch-mbp>
References: <20251111220838.926321-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111220838.926321-1-bvanassche@acm.org>

On Tue, Nov 11, 2025 at 02:08:33PM -0800, Bart Van Assche wrote:
> This reverts commit 3451cf34f51bb70c24413abb20b423e64486161b and fixes
> the following KASAN complaint when running test zbd/013

Can I please just get one chance to fix it before a kneejerk revert??

This was in v1, it was mistakenly dropped from v2.

---
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f1e67962ecaeb..55c3f4d62c2e3 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1240,9 +1240,12 @@ static blk_status_t null_transfer(struct nullb *nullb, struct page *page,

        p = kmap_local_page(page) + off;
        if (!is_write) {
-               if (dev->zoned)
+               if (dev->zoned) {
                        valid_len = null_zone_valid_read_len(nullb,
                                pos >> SECTOR_SHIFT, len);
+                       if (valid_len != len)
+                               valid_len -= (pos & (SECTOR_SIZE - 1));
+               }

                if (valid_len) {
                        copy_from_nullb(nullb, p, pos, valid_len);
--
