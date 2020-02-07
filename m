Return-Path: <SRS0=URwg=33=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E94C352A2
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 10:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F142082E
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 10:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgBGK0e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:26:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbgBGK0d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Feb 2020 05:26:33 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 17A707A47D09D112A8BB;
        Fri,  7 Feb 2020 18:26:32 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.66) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 7 Feb 2020
 18:26:26 +0800
Subject: Re: [PATCH] block: revert pushing the final release of request_queue
 to a workqueue.
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <chaitanya.kulkarni@wdc.com>,
        <damien.lemoal@wdc.com>, <bvanassche@acm.org>,
        <dhowells@redhat.com>, <asml.silence@gmail.com>,
        <ajay.joshi@wdc.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>, <luoshijie1@huawei.com>
References: <20200206111052.45356-1-yukuai3@huawei.com>
 <20200207093012.GA5905@ming.t460p>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <1f2fb027-1d62-2a52-9956-7847fa1baf96@huawei.com>
Date:   Fri, 7 Feb 2020 18:26:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200207093012.GA5905@ming.t460p>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/2/7 17:30, Ming Lei wrote:

> I guess your test case is more complicated than the above CVE, which
> should be triggered in single queue case.

No, the test case is from Syzkaller, you can get it from [1]
> Looks this approach isn't correct:
> 
> 1) there are other sleepers in __blk_release_queue(), such blk-mq sysfs
> kobject_put(), or cancel_delayed_work_sync(), ...
> 
commit dc9edc44de6c pushing the final release of request_queue to a
workqueue because sleepers are not allowed. However, since since
commit db6d99523560, sleeper is ok because blk_exit_rl() is removed
form blkg_free().

> 2) wrt. loop, the request queue's release handler may not be called yet
> after loop_remove() returns, so this patch may not avoid the issue in
> your step 3 in which blk_mq_debugfs_register fails when adding new loop
> device. So release not by wq just reduces the chance, instead of fixing
> it completely.
> 
The reason of the problem is because the final release of request_queue
may be called after loop_remove() returns.
And I think it will be fixed if we revert commit db6d99523560.

Thanks
Yu Kuai
> 
> 
> .
> 

