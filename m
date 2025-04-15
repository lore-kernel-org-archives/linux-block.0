Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415444204E
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744683902; cv=none; b=ebzGy0eIIWzo0JobpBb9B/u594kZ6Z04JmXhl56mOF8eIH9c0Gl28NTmZ3yYdntqb2sq8mi5VdXU+NGiF8f2eopBfLTW6rLzJsnc5PjnXK4b1C0XbJFOZQ/HDE24kt9faWnBazT4xIB0PNQ+r5kBTkJKnEcixcP67sVkTUtcSdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744683902; c=relaxed/simple;
	bh=smXRa4Ls1Eeblm+eyIlZ5ONVezSaGheL3SuBn/SgwSo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Xooy/ztiNI867KIrSADLzESksvMz+3mFlmOEghqc2np/OjQJ/GnNIkfkERdrW1owrmp/1fS33YOXwKhb4Ahm+3E8tP2CRlcLBfIC1X81b+KDHpdDekkpuBb/ZYbLCeqA+XVFrAKJ0ZbnwbkYHjhQNwXYT4AnuTC/z2+E9/SVWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zc7Jq3lRhz4f3lgL
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:24:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B72181A0CC2
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:24:52 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHq190w_1nQNcRJg--.37851S3;
	Tue, 15 Apr 2025 10:24:52 +0800 (CST)
Subject: Re: [PATCH 4/7] blk-throttle: Introduce flag "BIO_TG_BPS_THROTTLED"
To: Zizhi Wo <wozizhi@huawei.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
 <20250414132731.167620-5-wozizhi@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <692878bd-9f80-537e-0f75-13d0c855e2ce@huaweicloud.com>
Date: Tue, 15 Apr 2025 10:24:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250414132731.167620-5-wozizhi@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHq190w_1nQNcRJg--.37851S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF45Xw4rZF1rWFW3tw4DCFg_yoW5WrW5pF
	W8uFs5Cw18Jr4v9rn3J3W2vFZ7Jr4xCry5ArZxJr1SvF17Kr1DKr1kur1Fva1Fka9a9F40
	vFsYgFWxC3WUGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFB
	T5DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/04/14 21:27, Zizhi Wo Ð´µÀ:
> Subsequent patches will split the single queue into separate bps and iops
> queues. To prevent IO that has already passed through the bps queue at a
> single tg level from being counted toward bps wait time again, we introduce
> "BIO_TG_BPS_THROTTLED" flag. Since throttle and QoS operate at different
> levels, we reuse the value as "BIO_QOS_THROTTLED".
> 
> We set this flag when charge bps and clear it when charge iops, as the bio
> will move to the upper-level tg or be dispatched.
> 
> This patch does not involve functional changes.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   block/blk-throttle.c      | 9 +++++++--
>   include/linux/blk_types.h | 5 +++++
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 91ee1c502b41..caae2e3b7534 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -741,12 +741,16 @@ static void throtl_charge_bps_bio(struct throtl_grp *tg, struct bio *bio)
>   	unsigned int bio_size = throtl_bio_data_size(bio);
>   
>   	/* Charge the bio to the group */
> -	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
> +	if (!bio_flagged(bio, BIO_BPS_THROTTLED) &&
> +	    !bio_flagged(bio, BIO_TG_BPS_THROTTLED)) {
> +		bio_set_flag(bio, BIO_TG_BPS_THROTTLED);
>   		tg->bytes_disp[bio_data_dir(bio)] += bio_size;
> +	}
>   }
>   
>   static void throtl_charge_iops_bio(struct throtl_grp *tg, struct bio *bio)
>   {
> +	bio_clear_flag(bio, BIO_TG_BPS_THROTTLED);
>   	tg->io_disp[bio_data_dir(bio)]++;
>   }
>   
> @@ -772,7 +776,8 @@ static unsigned long tg_dispatch_bps_time(struct throtl_grp *tg, struct bio *bio
>   
>   	/* no need to throttle if this bio's bytes have been accounted */
>   	if (bps_limit == U64_MAX || tg->flags & THROTL_TG_CANCELING ||
> -	    bio_flagged(bio, BIO_BPS_THROTTLED))
> +	    bio_flagged(bio, BIO_BPS_THROTTLED) ||
> +	    bio_flagged(bio, BIO_TG_BPS_THROTTLED))
>   		return 0;
>   
>   	tg_update_slice(tg, rw);
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index dce7615c35e7..f9d1230e27a7 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -296,6 +296,11 @@ enum {
>   				 * of this bio. */
>   	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
>   	BIO_QOS_THROTTLED,	/* bio went through rq_qos throttle path */
> +	/*
> +	 * This bio has undergone rate limiting at the single throtl_grp level bps
> +	 * queue. Since throttle and QoS are not at the same level, reused the value.
resued -> resue

Other than the typo, LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> +	 */
> +	BIO_TG_BPS_THROTTLED = BIO_QOS_THROTTLED,
>   	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
>   	BIO_REMAPPED,
>   	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
> 

