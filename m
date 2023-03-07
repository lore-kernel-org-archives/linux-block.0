Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B225DC678D5
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 14:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCGObT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 09:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjCGOaq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 09:30:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C1185365
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 06:26:24 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y2so13340470pjg.3
        for <linux-block@vger.kernel.org>; Tue, 07 Mar 2023 06:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678199184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mtoab8jV4fMKG0SxVL3Rmz1aa/YyxFaXCGqp2jwpOL4=;
        b=02vts+Cm8GZ3tAEn1W+C3MHqE/bVOXrBhSQeydeI4MdD5XPmUA74ZHP4QA0mtMmof1
         GH1GIrPpzthleGtZVA2yTUydvS395RHuWQg2xQega7Ph2/4k+vyqeyIZnGCd8QMpHcxA
         87+QkqguBYkuoiKry9uR6NzulZqIYN/IMMro9M64jt3h5yZIYY1Pj3avsZ61H14FqPJv
         gK2Rz1o8sJ3V4R5Dkg2RxXRlrtvAYuCGVGZJM/VmeS7PQNfbv5x8ZHFalXFNJf9OG2Vn
         BsmszalT8GNfERrkcYj8cnDUv6xJyYz5+NFDMkREo8BBll3szQKuwRH6hjM/Ez5hj4pP
         n2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678199184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtoab8jV4fMKG0SxVL3Rmz1aa/YyxFaXCGqp2jwpOL4=;
        b=TwekrqAfTJ6JP2g8cqr/itYlgIeAlFFDGrcbISSRaA3D4PnLaw349GA5fEzRKzu7Rs
         lhwAVU/Mprzbyqa8+mIW8NZYC1DkgORJTjk4iDbmFliADZ8a+Iy0Gm4FYxYXQTvfMKvs
         k32mV1kWwbeV7Cg3CwTiVrfZVE9aj2QWr0chRE9OYY138Rqe42IzCRaysaALEx9NBw3O
         icArptfZJWAMzGKZB7h7ZhLd+AmxmckJuKkDHFsGCzggIobm544CZdf7ky6MhbCfPSYX
         vRuNfDgMgAT8ETLmThC/PyDh3i1iDY70VwN8iVPQxwx3hbvyPqLyxcBS4pKBhQ+0GqsQ
         eB+A==
X-Gm-Message-State: AO0yUKXYZOFfd4W8INZZUtX/TYmEaQwkFLtNSBvEQM1M8QIa0/Ixdzy0
        hfrWnHETsbmyOXNxxrs1Omlfqg==
X-Google-Smtp-Source: AK7set/QqoS3SAPvhVekNH4EXm23OJq40Rv6r+ZgHATZSKQdmCyZiuIQMFoaoJUIROJZ9TyGrhlQ1A==
X-Received: by 2002:a17:902:7e88:b0:199:3f82:ef62 with SMTP id z8-20020a1709027e8800b001993f82ef62mr16360500pla.5.1678199183956;
        Tue, 07 Mar 2023 06:26:23 -0800 (PST)
Received: from [172.20.4.229] ([50.233.106.125])
        by smtp.gmail.com with ESMTPSA id kf3-20020a17090305c300b0019cb9764340sm8508761plb.225.2023.03.07.06.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 06:26:23 -0800 (PST)
Message-ID: <4e6e1606-1d9e-9903-8a44-ccac58a1fe06@kernel.dk>
Date:   Tue, 7 Mar 2023 07:26:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [bug report] BUG: KASAN: slab-use-after-free in
 bfq_setup_cooperator
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230307071448.rzihxbm4jhbf5krj@shindev>
 <220e7ee3-e294-753f-d9df-8957a8f047e9@huaweicloud.com>
 <20230307091336.p2mzdo225zkoldmd@shindev>
 <076cb738-6f44-e731-d2a6-cad4ff464ae1@huaweicloud.com>
 <20230307102040.3t6qiojxj72fqrlc@quack3>
 <73a84d09-9b64-f23a-1d24-a41cc1187b4b@huaweicloud.com>
 <20230307114949.mh7fbo4e2zepcllg@shindev>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230307114949.mh7fbo4e2zepcllg@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/23 4:49 AM, Shinichiro Kawasaki wrote:
> On Mar 07, 2023 / 18:28, Yu Kuai wrote:
>> Hi, Jan
>>
>> 在 2023/03/07 18:20, Jan Kara 写道:
> 
> [...]
> 
>>> So rather doing something like:
>>>
>>> 		bfqq_data->stable_merge_bfqq = NULL;
>>> 		new_bfqq = bfq_setup_stable_merge(bfqd, bfqq,
>>> 						  stable_merge_bfqq, bfqq_data);
>>> 		bfq_put_stable_ref(stable_merge_bfqq);
>>> 		return new_bfqq;
>>>
>>> should work in bfq_setup_cooperator().
>>
>> Yes, this will work.
> 
> Based on the description above, I quickly created the dirty patch below, and
> confirmed it avoids the BUG. Looks good. Jan, Yu, thanks for the quick actions.
> Let me wait for the formal patch.
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 8a8d4441519c..50eb435efed0 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2932,15 +2932,15 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  					   msecs_to_jiffies(bfq_late_stable_merging))) {
>  			struct bfq_queue *stable_merge_bfqq =
>  				bfqq_data->stable_merge_bfqq;
> +			static struct bfq_queue *new_bfqq;
>  
>  			/* deschedule stable merge, because done or aborted here */
> -			bfq_put_stable_ref(stable_merge_bfqq);
> -
>  			bfqq_data->stable_merge_bfqq = NULL;
> -
> -			return bfq_setup_stable_merge(bfqd, bfqq,
> -						      stable_merge_bfqq,
> -						      bfqq_data);
> +			new_bfqq = bfq_setup_stable_merge(bfqd, bfqq,
> +							  stable_merge_bfqq,
> +							  bfqq_data);
> +			bfq_put_stable_ref(stable_merge_bfqq);
> +			return new_bfqq;
>  		}
>  	}

Can you or Jan post this as a real patch so we can get it queued
up?

-- 
Jens Axboe


