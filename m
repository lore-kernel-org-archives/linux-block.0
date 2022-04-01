Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD45EC433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 09:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiDAJmq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Apr 2022 05:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbiDAJmp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 05:42:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138DE4F9EA
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 02:40:55 -0700 (PDT)
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KVFXJ68XFzdZQG;
        Fri,  1 Apr 2022 17:40:32 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 17:40:53 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 17:40:52 +0800
Subject: Re: [PATCH 0/9 v6] bfq: Avoid use-after-free when moving processes
 between cgroups
To:     Jan Kara <jack@suse.cz>
CC:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20220330123438.32719-1-jack@suse.cz>
 <ab844fb5-ba5e-6007-91b5-a971c8712354@huawei.com>
 <20220401092655.l4vnbnbzygld2v33@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <a1fabd26-d0f6-6888-e53d-97e2d0fffb63@huawei.com>
Date:   Fri, 1 Apr 2022 17:40:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220401092655.l4vnbnbzygld2v33@quack3.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/04/01 17:26, Jan Kara 写道:
> On Fri 01-04-22 11:40:39, yukuai (C) wrote:
>> 在 2022/03/30 20:42, Jan Kara 写道:
>>> Hello,
>>>
>>> with a big delay (I'm sorry for that) here is the sixth version of my patches
>>> to fix use-after-free issues in BFQ when processes with merged queues get moved
>>> to different cgroups. The patches have survived some beating in my test VM, but
>>> so far I fail to reproduce the original KASAN reports so testing from people
>>> who can reproduce them is most welcome. Kuai, can you please give these patches
>>> a run in your setup? Thanks a lot for your help with fixing this!
>>>
>> Hi, Jan
>>
>> I ran the reproducer for more than 12 hours aready, and the uaf is not
>> reporduced anymore. Before this patchset this problem can be reporduced
>> within an hour.
> 
> Great to hear that! Thanks a lot for testing and help with analysis! Can I
> add your Tested-by tag?

Of course.

Cheers for address this problem
Kuai
> 
> 									Honza
> 
>>> Changes since v5:
>>> * Added handling of situation when bio is submitted for a cgroup that has
>>>     already went through bfq_pd_offline()
>>> * Convert bfq to avoid using deprecated __bio_blkcg() and thus fix possible
>>>     races when returned cgroup can change while bfq is working with a request
>>>
>>> Changes since v4:
>>> * Even more aggressive splitting of merged bfq queues to avoid problems with
>>>     long merge chains.
>>>
>>> Changes since v3:
>>> * Changed handling of bfq group move to handle the case when target of the
>>>     merge has moved.
>>>
>>> Changes since v2:
>>> * Improved handling of bfq queue splitting on move between cgroups
>>> * Removed broken change to bfq_put_cooperator()
>>>
>>> Changes since v1:
>>> * Added fix for bfq_put_cooperator()
>>> * Added fix to handle move between cgroups in bfq_merge_bio()
>>>
>>> 								Honza
>>> Previous versions:
>>> Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
>>> Link: http://lore.kernel.org/r/20220105143037.20542-1-jack@suse.cz # v2
>>> Link: http://lore.kernel.org/r/20220112113529.6355-1-jack@suse.cz # v3
>>> Link: http://lore.kernel.org/r/20220114164215.28972-1-jack@suse.cz # v4
>>> Link: http://lore.kernel.org/r/20220121105503.14069-1-jack@suse.cz # v5
>>> .
>>>
