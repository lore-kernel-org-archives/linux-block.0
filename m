Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DA1C433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 03:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243969AbiBHDxs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Feb 2022 22:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiBHDxr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Feb 2022 22:53:47 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D83C0401DC;
        Mon,  7 Feb 2022 19:53:46 -0800 (PST)
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jt8H006zdzccpM;
        Tue,  8 Feb 2022 11:52:43 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 11:53:43 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 11:53:43 +0800
Subject: Re: [PATCH v3 2/3] block, bfq: avoid moving bfqq to it's parent bfqg
To:     <paolo.valente@linaro.org>, <jack@suse.cz>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220129015924.3958918-1-yukuai3@huawei.com>
 <20220129015924.3958918-3-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <c85b10ce-fb41-9e0a-772a-63c226227207@huawei.com>
Date:   Tue, 8 Feb 2022 11:53:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220129015924.3958918-3-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 2022/01/29 9:59, Yu Kuai Ð´µÀ:
> Moving bfqq to it's parent bfqg is pointless.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/bfq-cgroup.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Hi, Paolo

I make a clerical error in last version of this patch:

bfq_group should be bfqq_group

Can you please take a look of this patch? I do compile and
test the patch this time...

Thanks,
Kuai
