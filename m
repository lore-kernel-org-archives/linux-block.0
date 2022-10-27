Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30792FA3742
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 10:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiJ0Kk0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 06:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiJ0KkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 06:40:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4906C356EC
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 03:40:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w14so1435138wru.8
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qUyKekqQXP1A77Nfhdhnu6HVFwoVkomjd35RqiC4M7Q=;
        b=iHrsOrL2YJJSDB9n60I6cv5yELDHpuJcsIuap1bhD356DClcjLQFaKyuuNwwA1Qvwz
         AyvaOr04tRJ3U853X5bfBK0hXQcJc2SBvspvdutTJ3gfEuXK9+fqbbM8YNpVwczOgy81
         jP5hTYvAq5Vd/iLvjDW6KuIEBX6UGTPKGyATQJWBKbgTR2XQ9SjEmhm78uEbnhB4Q3oc
         yM/d0jYhkslpfSO1k6ODFJgLe3LHtuNG5NspNAMkMuaSHqKuoKviRMHVHaa9lB2tthhU
         +t3T5AsajedgUejSChhrM16jakBXCn0zmz02SYgmGSIfRjAgehp8kZIwIcXRooDo4qzI
         C5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUyKekqQXP1A77Nfhdhnu6HVFwoVkomjd35RqiC4M7Q=;
        b=6efwXB39b7gG7Nx3GqYR/2FutqGHz24J1xnblMmhZXlgSwn2acrCI5ryyNm9U0lcOf
         AuEI/0P620WzUJQEu8U4R+qNCdmw4r/3HZH/ShSwS159HImIBfUdbxGV7/hEWli8q5jn
         d6hVF2z+X1w/a6Zbokwb/468tFhdljqNG7qp1NOpfkHwNkjnNZFoOLh9TVLiwwBLF95r
         MUkSfbKBe5OZQmqjtWf+RkWAfiBRj8XGFwPMvudIP4R4Hui3CXBkBx46n++iKHf+4vhF
         UsG95d9HATykimUTajIBSVJOb/HBG25W+vtWxZd4hfyOwl1OGIoKswxy/qjOs89gnkqv
         /+BA==
X-Gm-Message-State: ACrzQf3ErZdYUOnIjZEM/Yiy/0xwDDvgQE+zkb9i9Q2NsfMxCl0sB4Vu
        soxHGZ3RM10I4jSeFHhE9mI=
X-Google-Smtp-Source: AMsMyM7yCs6I+G2jFqZ2QuMYFLkub7gU1G4VSyzzQ7y2nviGyCIKrR8GfllBjgpGBMF2eFSOYSBR6A==
X-Received: by 2002:a5d:484f:0:b0:236:9c97:6f85 with SMTP id n15-20020a5d484f000000b002369c976f85mr203129wrs.636.1666867209210;
        Thu, 27 Oct 2022 03:40:09 -0700 (PDT)
Received: from [10.1.2.99] (wifi-guest-gw.tecnico.ulisboa.pt. [193.136.152.65])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6847000000b00236545edc91sm841878wrw.76.2022.10.27.03.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 03:40:08 -0700 (PDT)
Message-ID: <b7c3d003-d808-a57f-c645-48cfc06d7a52@gmail.com>
Date:   Thu, 27 Oct 2022 11:38:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] block: fix bio-allocation from per-cpu cache
To:     Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
References: <CGME20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee@epcas5p3.samsung.com>
 <20221027100410.3891-1-joshi.k@samsung.com>
Content-Language: en-US
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20221027100410.3891-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/22 11:04, Kanchan Joshi wrote:
> If cache does not have any entry, make sure to detect that and return
> failure. Otherwise this leads to null pointer dereference.

Damn, it was done right in v2

https://lore.kernel.org/all/9fd04486d972c1f3ef273fa26b4b6bf51a5e4270.1666122465.git.asml.silence@gmail.com/

Perhaps I based v3 on a wrong version. Thanks


> Fixes: 13a184e26965 ("block/bio: add pcpu caching for non-polling bio_put")
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
> Can be reproduced by:
> fio -direct=1 -iodepth=1 -rw=randread -ioengine=io_uring -bs=4k -numjobs=1 -size=4k -filename=/dev/nvme0n1 -hipri=1 -name=block
> 
> BUG: KASAN: null-ptr-deref in bio_alloc_bioset.cold+0x2a/0x16a
> Read of size 8 at addr 0000000000000000 by task fio/1835
> 
> CPU: 5 PID: 1835 Comm: fio Not tainted 6.1.0-rc2+ #226
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x34/0x48
>   print_report+0x490/0x4a1
>   ? __virt_addr_valid+0x28/0x140
>   ? bio_alloc_bioset.cold+0x2a/0x16a
>   kasan_report+0xb3/0x130
>   ? bio_alloc_bioset.cold+0x2a/0x16a
>   bio_alloc_bioset.cold+0x2a/0x16a
>   ? bvec_alloc+0xf0/0xf0
>   ? iov_iter_is_aligned+0x130/0x2c0
>   blkdev_direct_IO.part.0+0x16a/0x8d0
> 
>   block/bio.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 8f624ffaf3d0..66f088bb3736 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -439,13 +439,14 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
>   
>   	cache = per_cpu_ptr(bs->cache, get_cpu());
>   	if (!cache->free_list &&
> -	    READ_ONCE(cache->nr_irq) >= ALLOC_CACHE_THRESHOLD) {
> +	    READ_ONCE(cache->nr_irq) >= ALLOC_CACHE_THRESHOLD)
>   		bio_alloc_irq_cache_splice(cache);
> -		if (!cache->free_list) {
> -			put_cpu();
> -			return NULL;
> -		}
> +
> +	if (!cache->free_list) {

Let's nest it under the other "if (!cache->free_list)"


> +		put_cpu();
> +		return NULL;
>   	}
> +
>   	bio = cache->free_list;
>   	cache->free_list = bio->bi_next;
>   	cache->nr--;

-- 
Pavel Begunkov
