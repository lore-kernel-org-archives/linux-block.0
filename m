Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39141C433EF
	for <linux-block@archiver.kernel.org>; Thu,  5 May 2022 00:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiEEBBK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 May 2022 21:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiEEBBJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 May 2022 21:01:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EE1220F3;
        Wed,  4 May 2022 17:57:32 -0700 (PDT)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KtwJh5VgFzhYsv;
        Thu,  5 May 2022 08:57:08 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 08:57:30 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 08:57:29 +0800
Subject: Re: [PATCH -next 0/6] nbd: bugfix and cleanup patches
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220426130746.885140-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <a8f0b55b-625c-3393-fadb-5724e129abdf@huawei.com>
Date:   Thu, 5 May 2022 08:57:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220426130746.885140-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

friendly ping ...

ÔÚ 2022/04/26 21:07, Yu Kuai Ð´µÀ:
> path 1-2 fix races between nbd setup and module removal.
> patch 3 fix io can't be completed in some error path.
> patch 4 fix io hung when disconnecting failed.
> patch 5 fix sysfs warning about duplicate creation.
> patch 6 use pr_err to output error message.
> 
> Yu Kuai (5):
>    nbd: call genl_unregister_family() first in nbd_cleanup()
>    nbd: fix race between nbd_alloc_config() and module removal
>    nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
>    nbd: fix io hung while disconnecting device
>    nbd: use pr_err to output error message
> 
> Zhang Wensheng (1):
>    nbd: fix possible overflow on 'first_minor' in nbd_dev_add()
> 
>   drivers/block/nbd.c | 119 +++++++++++++++++++++++++++-----------------
>   1 file changed, 74 insertions(+), 45 deletions(-)
> 
