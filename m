Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B16C43219
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 11:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiKXLt3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Nov 2022 06:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKXLt2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2022 06:49:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD66B193F9;
        Thu, 24 Nov 2022 03:49:26 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHx901wkczmW8K;
        Thu, 24 Nov 2022 19:48:52 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 19:49:24 +0800
Subject: Re: [PATCH 02/11] blk-throttle: Fix that bps of child could exceed
 bps limited in parent
To:     Tejun Heo <tj@kernel.org>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-3-shikemeng@huawei.com>
 <Y35h9SmFeEJtBNgM@slm.duckdns.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <d102136f-5a2a-fade-bce9-1c7550599331@huawei.com>
Date:   Thu, 24 Nov 2022 19:49:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y35h9SmFeEJtBNgM@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



on 11/24/2022 2:09 AM, Tejun Heo wrote:
> On Wed, Nov 23, 2022 at 02:03:52PM +0800, Kemeng Shi wrote:
>> @@ -964,10 +963,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
>>  	unsigned int bio_size = throtl_bio_data_size(bio);
>>  
>>  	/* Charge the bio to the group */
>> -	if (!bio_flagged(bio, BIO_BPS_THROTTLED)) {
>> -		tg->bytes_disp[rw] += bio_size;
>> -		tg->last_bytes_disp[rw] += bio_size;
>> -	}
>> +	tg->bytes_disp[rw] += bio_size;
>> +	tg->last_bytes_disp[rw] += bio_size;
> 
> Are you sure this isn't gonna lead to double accounting? IIRC, the primary
> purpose of this flag is avoiding duplicate accounting of bios which end up
> going through the throttling path multiple times for whatever reason and
> we've had numerous breakages around it.
Sorry for the mistake, this change does lead to double accounting.
> To address the problem you're describing in this patch, wouldn't it make
> more sense to set the flag only when the bio traversed the entire tree
> rather than after each tg?
I will address the problem in this way in next version. Thanks for the
advice.

-- 
Best wishes
Kemeng Shi
