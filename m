Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF9DC6FD18
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 08:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjDYIJn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Apr 2023 04:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjDYIJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2023 04:09:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203FEA2;
        Tue, 25 Apr 2023 01:09:39 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q5F0w0f5GzSsln;
        Tue, 25 Apr 2023 16:05:20 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 16:09:35 +0800
Subject: Re: [PATCH] Remove blkg node after destroying blkg
To:     Tao Su <tao1.su@linux.intel.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230425075911.839539-1-tao1.su@linux.intel.com>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <aa5de32c-c92b-d032-e9bb-83d2436ff72c@huawei.com>
Date:   Tue, 25 Apr 2023 16:09:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230425075911.839539-1-tao1.su@linux.intel.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

ÔÚ 2023/04/25 15:59, Tao Su Ð´µÀ:
> Kernel hang when poweroff or reboot, due to infinite restart in function
> blkg_destroy_all. It will goto restart label when a batch of blkgs are
> destroyed, but not remove blkg node in blkg_list. So the blkg_list is
> same in every 'restart' and result in kernel hang.
> 
> By adding list_del to remove blkg node after destroying, can solve this
> kernel hang issue and satisfy the previous will to 'restart'.
> 
> Reported-by: Xiangfei Ma <xiangfeix.ma@intel.com>
> Tested-by: Xiangfei Ma <xiangfeix.ma@intel.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
>   block/blk-cgroup.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index bd50b55bdb61..960eb538a704 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -530,6 +530,7 @@ static void blkg_destroy_all(struct gendisk *disk)
>   
>   		spin_lock(&blkcg->lock);
>   		blkg_destroy(blkg);
> +		list_del(&blkg->q_node);

blkg should stay on the queue list until blkg_free_workfn(), otherwise
parent blkg can be freed before child, which will cause some known
issue.

I think this hung happens when total blkg is greater than
BLKG_DESTROY_BATCH_SIZE, right?

Can you try if following patch fix your problem?

index 1c1ebeb51003..0ecb4cce8af2 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -527,6 +527,9 @@ static void blkg_destroy_all(struct gendisk *disk)
         list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
                 struct blkcg *blkcg = blkg->blkcg;

+               if (hlist_unhashed(&blkg->blkcg_node))
+                       continue;
+
                 spin_lock(&blkcg->lock);
                 blkg_destroy(blkg);
                 spin_unlock(&blkcg->lock);

>   		spin_unlock(&blkcg->lock);
>   
>   		/*
> 
