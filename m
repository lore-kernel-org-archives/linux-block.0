Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0016AC433F5
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 09:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiCaJdh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiCaJdc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 05:33:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093931BBF6D
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 02:31:44 -0700 (PDT)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KTdL06rV2zCqxX;
        Thu, 31 Mar 2022 17:29:28 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 17:31:42 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 17:31:42 +0800
Subject: Re: [PATCH 0/9 v6] bfq: Avoid use-after-free when moving processes
 between cgroups
To:     Jan Kara <jack@suse.cz>, <linux-block@vger.kernel.org>
CC:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20220330123438.32719-1-jack@suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <0be66300-7fe3-1fe5-780b-0ff843ac3329@huawei.com>
Date:   Thu, 31 Mar 2022 17:31:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220330123438.32719-1-jack@suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 2022/03/30 20:42, Jan Kara Ð´µÀ:
> Hello,
> 
> with a big delay (I'm sorry for that) here is the sixth version of my patches
> to fix use-after-free issues in BFQ when processes with merged queues get moved
> to different cgroups. The patches have survived some beating in my test VM, but
> so far I fail to reproduce the original KASAN reports so testing from people
> who can reproduce them is most welcome. Kuai, can you please give these patches
> a run in your setup? Thanks a lot for your help with fixing this!

Thanks for the patch, I'll run reporducer and feedback to you soon.

Kuai
> 
> Changes since v5:
> * Added handling of situation when bio is submitted for a cgroup that has
>    already went through bfq_pd_offline()
> * Convert bfq to avoid using deprecated __bio_blkcg() and thus fix possible
>    races when returned cgroup can change while bfq is working with a request
> 
> Changes since v4:
> * Even more aggressive splitting of merged bfq queues to avoid problems with
>    long merge chains.
> 
> Changes since v3:
> * Changed handling of bfq group move to handle the case when target of the
>    merge has moved.
> 
> Changes since v2:
> * Improved handling of bfq queue splitting on move between cgroups
> * Removed broken change to bfq_put_cooperator()
> 
> Changes since v1:
> * Added fix for bfq_put_cooperator()
> * Added fix to handle move between cgroups in bfq_merge_bio()
> 
> 								Honza
> Previous versions:
> Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
> Link: http://lore.kernel.org/r/20220105143037.20542-1-jack@suse.cz # v2
> Link: http://lore.kernel.org/r/20220112113529.6355-1-jack@suse.cz # v3
> Link: http://lore.kernel.org/r/20220114164215.28972-1-jack@suse.cz # v4
> Link: http://lore.kernel.org/r/20220121105503.14069-1-jack@suse.cz # v5
> .
> 
