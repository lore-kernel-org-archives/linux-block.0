Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E726CC433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 06:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346665AbiCKGkS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 01:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiCKGkR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 01:40:17 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ACF3EF13
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 22:39:13 -0800 (PST)
Received: from kwepemi100026.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KFGP84WgYzcb1G;
        Fri, 11 Mar 2022 14:34:20 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100026.china.huawei.com (7.221.188.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Mar 2022 14:39:12 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 14:39:11 +0800
Subject: Re: [PATCH 0/4 v5] bfq: Avoid use-after-free when moving processes
 between cgroups
To:     Jan Kara <jack@suse.cz>
CC:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20220121105503.14069-1-jack@suse.cz>
 <4b44e8db-771f-fc08-85f1-52c326f3db18@huawei.com>
 <20220124140224.275sdju6temjgjdu@quack3.lan>
 <75bfe59d-c570-8c1c-5a3c-576791ea84ec@huawei.com>
 <20220202190210.xppvatep47duofbq@quack3.lan>
 <20220202215356.iomsjb57jmbfglt4@quack3.lan>
 <6ec28c27-1dce-33e3-1cb7-2e08892471bb@huawei.com>
 <20220209174055.yrlipalcrtetxelm@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <c238763f-cbac-d722-11c2-e0c6db9603ea@huawei.com>
Date:   Fri, 11 Mar 2022 14:39:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220209174055.yrlipalcrtetxelm@quack3.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/02/10 1:40, Jan Kara 写道:
>
> I had a look into debug data and now I think I understand both the WARN_ON
> hit in bic_set_bfqq() as well as the final BUG_ON in bfq_add_bfqq_busy().
> 
> The first problem is apparently hit because __bio_blkcg() can change while
> we are processing the bio. So bfq_bic_update_cgroup() sees different
> __bio_blkcg() than bfq_get_queue() called from bfq_get_bfqq_handle_split().
> This then causes mismatch between what bic & bfqq think about cgroup
> membership which can lead to interesting inconsistencies down the road.
> 
> The second problem is hit because clearly __bio_blkcg() can be pointing to
> a blkcg that has been already offlined. Previously I didn't think this was
> possible but apparently there is nothing that would prevent this race. So
> we need to handle this gracefully inside BFQ.
> 
> I need to think what would be best fixes for these issues since especially
> the second one is tricky.

Hi, Jan

Just to be curiosity, do you have any ideas on how to fix these issues?

Thanks,
Kuai
> 
> 								Honza
> 
