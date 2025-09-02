Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E60F2F532D;
	Tue,  2 Sep 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832797; cv=pass; b=e8Se9wzieok1iCSYkvg0MQO3FzPUPby6J84UE0CPdGTfV09bCVZtWUdRGIqmLQkECzms6xlaK2U6Uq0aQem3tnM0TUmYPB3sr2phS1nHmD8AeUj67Cw7OAuVYwryHOoYJFms1D5xU3f+Axl/tjRKpBNhAoD4GysEJg9kpOvYcRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832797; c=relaxed/simple;
	bh=LsSwBEqBg8wDoOXM3KCaeTXSSXXwqmFlVcHTO7XMbqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eib+QLQPQ/NQZOL+pAH2I/wbAJAC3LvOmo0TsL/QXX2ZoeHwbddmVMJjSY53sKcPGOrNlvG+sfLbjfDrhJSdMBsyKWHmBK/hbwDbX6k6dI1RTWzye8c0C5TuqU81hcMmxDfeEFm+FVK8eF4GXwiaUwd8MRGLaiGe4fQnIlxtea0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=EcVjAz9/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="EcVjAz9/"
ARC-Seal: i=1; a=rsa-sha256; t=1756832776; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XTY4usUn/PgTlHHjleZLXrrcxt74FtUvas8T/RxfyMryMO5lqj+K8gkTVERpJeZmaKPOCZNF79cT+fqnKjTH/R73v3akYEGu8s9zBlrCzkmWHrSb78DJR++1wRv+hJTxUuyPi+PDltaXJlVHwR/jBIuJ/IYI0EXlemnOwbhI2h8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756832776; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NzVP+zUryRLDdvJz9XOCb9M4nvPv514WoofrpXOZnDs=; 
	b=IJ+XDtRu2E/krS1SjdLoVoHsSHpI2tnpmJdqh9YVpnIKxrpE0krkffzcPQTbHYfCiLY3PxF/jMHDUmtdG8+dQt8550hy3Kj3I2In/4l9tWmCHv/5870G6yVnMt1NSXxBgmwYbyIzEDVmn5L84MiHmZozrIUvGJaUv0MeExXVye8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756832776;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NzVP+zUryRLDdvJz9XOCb9M4nvPv514WoofrpXOZnDs=;
	b=EcVjAz9/mroRMmCrNvdKeekckKT+ADPkbaoRfq7AvdQKydc/74gFRinvcQIib8na
	2mI/j9iJH77pMl1KbWJAIVcCSLLcds4fR9y3LopgzCBK1tC1AtC92kes4NMz02Wm5yG
	6pHUYg/X6Fl2si6inX89++pzcYLfxziYuziwoZ/M=
Received: by mx.zohomail.com with SMTPS id 1756832773969782.1350344792148;
	Tue, 2 Sep 2025 10:06:13 -0700 (PDT)
Message-ID: <59464ad0-856c-4ec3-b5b7-e7799c337a84@yukuai.org.cn>
Date: Wed, 3 Sep 2025 01:06:05 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
To: gj.han@foxmail.com, Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: hanguangjiang@lixiang.com, fanggeng@lixiang.com, yangchen11@lixiang.com,
 liangjie@lixiang.com
References: <tencent_E4C0C41415118E05F82833A1453A097DD10A@qq.com>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <tencent_E4C0C41415118E05F82833A1453A097DD10A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/2 20:39, gj.han@foxmail.com 写道:
> From: Han Guangjiang <hanguangjiang@lixiang.com>
>
> On repeated cold boots we occasionally hit a NULL pointer crash in
> blk_should_throtl() when throttling is consulted before the throttle
> policy is fully enabled for the queue. Checking only q->td != NULL is
> insufficient during early initialization, so blkg_to_pd() for the
> throttle policy can still return NULL and blkg_to_tg() becomes NULL,
> which later gets dereferenced.
>
>   Unable to handle kernel NULL pointer dereference
>   at virtual address 0000000000000156
>   ...
>   pc : submit_bio_noacct+0x14c/0x4c8
>   lr : submit_bio_noacct+0x48/0x4c8
>   sp : ffff800087f0b690
>   x29: ffff800087f0b690 x28: 0000000000005f90 x27: ffff00068af393c0
>   x26: 0000000000080000 x25: 000000000002fbc0 x24: ffff000684ddcc70
>   x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
>   x20: 0000000000080000 x19: ffff000684ddcd08 x18: ffffffffffffffff
>   x17: 0000000000000000 x16: ffff80008132a550 x15: 0000ffff98020fff
>   x14: 0000000000000000 x13: 1fffe000d11d7021 x12: ffff000688eb810c
>   x11: ffff00077ec4bb80 x10: ffff000688dcb720 x9 : ffff80008068ef60
>   x8 : 00000a6fb8a86e85 x7 : 000000000000111e x6 : 0000000000000002
>   x5 : 0000000000000246 x4 : 0000000000015cff x3 : 0000000000394500
>   x2 : ffff000682e35e40 x1 : 0000000000364940 x0 : 000000000000001a
>   Call trace:
>    submit_bio_noacct+0x14c/0x4c8
>    verity_map+0x178/0x2c8
>    __map_bio+0x228/0x250
>    dm_submit_bio+0x1c4/0x678
>    __submit_bio+0x170/0x230
>    submit_bio_noacct_nocheck+0x16c/0x388
>    submit_bio_noacct+0x16c/0x4c8
>    submit_bio+0xb4/0x210
>    f2fs_submit_read_bio+0x4c/0xf0
>    f2fs_mpage_readpages+0x3b0/0x5f0
>    f2fs_readahead+0x90/0xe8
>
> Tighten blk_throtl_activated() to also require that the throttle policy
> bit is set on the queue:
>
>    return q->td != NULL &&
>           test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);
>
> This prevents blk_should_throtl() from accessing throttle group state
> until policy data has been attached to blkgs.
>
> Fixes: a3166c51702b ("blk-throttle: delay initialization until configuration")
> Co-developed-by: Liang Jie <liangjie@lixiang.com>
> Signed-off-by: Liang Jie <liangjie@lixiang.com>
> Signed-off-by: Han Guangjiang <hanguangjiang@lixiang.com>
> ---
>   block/blk-throttle.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 3b27755bfbff..9ca43dc56eda 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -156,7 +156,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk);
>   
>   static inline bool blk_throtl_activated(struct request_queue *q)
>   {
> -	return q->td != NULL;
> +	return q->td != NULL && test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);
>   }

Instead of add checking from hot path, do you consider delaying setting q->td
until policy is activated from the slow path? I think this is better solution.

Thanks,
Kuai

>   
>   static inline bool blk_should_throtl(struct bio *bio)
