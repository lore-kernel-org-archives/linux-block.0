Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BF5C433F5
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 08:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiAQINO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:13:14 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16714 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbiAQINN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 03:13:13 -0500
Received: from kwepemi500003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jcl1N3h3DzZf6H;
        Mon, 17 Jan 2022 16:09:28 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500003.china.huawei.com (7.221.188.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 16:13:11 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 16:13:10 +0800
Subject: Re: [PATCH 0/4 v4] bfq: Avoid use-after-free when moving processes
 between cgroups
To:     Jan Kara <jack@suse.cz>, <linux-block@vger.kernel.org>
CC:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20220114164215.28972-1-jack@suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <9ee09c05-13c4-ec9d-5859-ed91dea39e13@huawei.com>
Date:   Mon, 17 Jan 2022 16:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220114164215.28972-1-jack@suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 2022/01/15 1:01, Jan Kara Ð´µÀ:
> Hello,
> 
> here is the third version of my patches to fix use-after-free issues in BFQ
> when processes with merged queues get moved to different cgroups. The patches
> have survived some beating in my test VM, but so far I fail to reproduce the
> original KASAN reports so testing from people who can reproduce them is most
> welcome. Kuai, can you please give these patches a run in your setup? Thanks
> a lot for your help with fixing this!
> 
> Changes since v3:
> * Changed handling of bfq group move to handle the case when target of the
>    merge has moved.
Hi, Jan

The problem can still be reporduced...

Do you implement this in patch 4? If so, I don't understand how you
chieve this.

For example: 3 bfqqs were merged:
q1->q2->q3

If __bfq_bic_change_cgroup() is called with q2, the problem can be
fixed. However, if __bfq_bic_change_cgroup() is called with q3, can
the problem be fixed?

Thanks,
Kuai
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
> .
> 
