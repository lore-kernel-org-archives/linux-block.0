Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B4C433F5
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 07:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347210AbiCYHbV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 03:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiCYHbU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 03:31:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF631BF01C;
        Fri, 25 Mar 2022 00:29:46 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KPtwn6bMSzfZvx;
        Fri, 25 Mar 2022 15:28:09 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 15:29:44 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 15:29:43 +0800
Subject: Re: [PATCH 0/3] optimizations for io accounting
To:     <axboe@kernel.dk>, <mpatocka@redhat.com>, <snitzer@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220317112653.1019490-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <29eab4a3-10de-0ea3-cbcc-7031aa394cb2@huawei.com>
Date:   Fri, 25 Mar 2022 15:29:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220317112653.1019490-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

friently ping ...

ÔÚ 2022/03/17 19:26, Yu Kuai Ð´µÀ:
> Yu Kuai (3):
>    block: don't show disk stats if io accounting is disabled
>    block: factor out common code for part_stat_show() and
>      diskstats_show()
>    block: update nsecs[] in part_stat_show() and diskstats_show()
> 
>   block/bdev.c              |   2 +
>   block/blk-mq.c            |  63 +++++++++++++++-
>   block/blk-mq.h            |   2 +
>   block/genhd.c             | 154 ++++++++++++++++++--------------------
>   include/linux/blk-mq.h    |   2 +
>   include/linux/blk_types.h |   5 ++
>   6 files changed, 146 insertions(+), 82 deletions(-)
> 
