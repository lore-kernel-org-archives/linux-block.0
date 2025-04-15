Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303618460
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744683733; cv=none; b=AT6C4A7ebTirmXz8cgWpHqW6zohcKLggCWAeY0ez9uJuxDF0791n8g5MwniysM6K3Y3R2YdmGwSNARNP9vE5HJp6Z6/i+hjugBPGCLZ7JK64NATygYjL82uI2lTAkmNN7wQSq8hKnTukjKSSECWaC0Bsn9J3p2r6QtN2/FqiHZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744683733; c=relaxed/simple;
	bh=iCUIqRXH+CT/rz4i36J2QM6r8c9MD//1gzksULxtTHE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rimYrFwwr+8AlJaEq+OEQ6U+Bqe888IOSM23KzPeYrRlqItVv+J7PbUEhHyQiF0VBfTrL5kw+fK6mKDQPrbJSwmN6BY+P+H13dcu5kM7zziyLTbLxpANaUFJjecLTRiE+aUpad+SpuzzHoVi7hC3kJtvPwnkzW4/WmjBf54TSkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zc7Fd3dmxz4f3lgB
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:21:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B1A2A1A0ADD
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:22:06 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAHa1_Nwv1nHKYRJg--.38118S3;
	Tue, 15 Apr 2025 10:22:06 +0800 (CST)
Subject: Re: [PATCH 3/7] blk-throttle: Split throtl_charge_bio() into bps and
 iops functions
To: Zizhi Wo <wozizhi@huawei.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
 <20250414132731.167620-4-wozizhi@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ca0840d7-bf70-1cdb-2d2b-d39ebc993adb@huaweicloud.com>
Date: Tue, 15 Apr 2025 10:22:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250414132731.167620-4-wozizhi@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHa1_Nwv1nHKYRJg--.38118S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr45KF48GrW3Cw15Ww47twb_yoW5Ww4Upa
	yUCFs8uw4kJF4DKr43XF17GF95tw4xAry2y39xG34UAanI9w1Dtr1DZryrAFW8uFZ3Ww1x
	ZF90qwnrG3WUJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUot
	CzDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/14 21:27, Zizhi Wo Ð´µÀ:
> Split throtl_charge_bio() to facilitate subsequent patches that will
> separately charge bps and iops after queue separation.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   block/blk-throttle.c | 35 ++++++++++++++++++++---------------
>   1 file changed, 20 insertions(+), 15 deletions(-)
> 
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 0633ae0cce90..91ee1c502b41 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -736,6 +736,20 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>   	return jiffy_wait;
>   }
>   
> +static void throtl_charge_bps_bio(struct throtl_grp *tg, struct bio *bio)
> +{
> +	unsigned int bio_size = throtl_bio_data_size(bio);
> +
> +	/* Charge the bio to the group */
> +	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
> +		tg->bytes_disp[bio_data_dir(bio)] += bio_size;
> +}
> +
> +static void throtl_charge_iops_bio(struct throtl_grp *tg, struct bio *bio)
> +{
> +	tg->io_disp[bio_data_dir(bio)]++;
> +}
> +
>   /*
>    * If previous slice expired, start a new one otherwise renew/extend existing
>    * slice to make sure it is at least throtl_slice interval long since now.
> @@ -808,18 +822,6 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
>   	return max(bps_wait, iops_wait);
>   }
>   
> -static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
> -{
> -	bool rw = bio_data_dir(bio);
> -	unsigned int bio_size = throtl_bio_data_size(bio);
> -
> -	/* Charge the bio to the group */
> -	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
> -		tg->bytes_disp[rw] += bio_size;
> -
> -	tg->io_disp[rw]++;
> -}
> -
>   /**
>    * throtl_add_bio_tg - add a bio to the specified throtl_grp
>    * @bio: bio to add
> @@ -906,7 +908,8 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
>   	bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
>   	sq->nr_queued[rw]--;
>   
> -	throtl_charge_bio(tg, bio);
> +	throtl_charge_bps_bio(tg, bio);
> +	throtl_charge_iops_bio(tg, bio);
>   
>   	/*
>   	 * If our parent is another tg, we just need to transfer @bio to
> @@ -1633,7 +1636,8 @@ bool __blk_throtl_bio(struct bio *bio)
>   	while (true) {
>   		if (tg_within_limit(tg, bio, rw)) {
>   			/* within limits, let's charge and dispatch directly */
> -			throtl_charge_bio(tg, bio);
> +			throtl_charge_bps_bio(tg, bio);
> +			throtl_charge_iops_bio(tg, bio);
>   
>   			/*
>   			 * We need to trim slice even when bios are not being
> @@ -1656,7 +1660,8 @@ bool __blk_throtl_bio(struct bio *bio)
>   			 * control algorithm is adaptive, and extra IO bytes
>   			 * will be throttled for paying the debt
>   			 */
> -			throtl_charge_bio(tg, bio);
> +			throtl_charge_bps_bio(tg, bio);
> +			throtl_charge_iops_bio(tg, bio);
>   		} else {
>   			/* if above limits, break to queue */
>   			break;
> 

