Return-Path: <SRS0=UW8z=34=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41097C35254
	for <linux-block@archiver.kernel.org>; Sat,  8 Feb 2020 06:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0466121775
	for <linux-block@archiver.kernel.org>; Sat,  8 Feb 2020 06:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgBHGMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Feb 2020 01:12:44 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbgBHGMo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 8 Feb 2020 01:12:44 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 393EE18D214EAB1F1FAA;
        Sat,  8 Feb 2020 14:12:40 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.66) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sat, 8 Feb 2020
 14:12:31 +0800
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
 <1f2fb027-1d62-2a52-9956-7847fa1baf96@huawei.com>
 <63873791-e303-aece-94c5-efb2a6976363@huawei.com>
 <20200207130446.GA14465@ming.t460p>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <93d1c4fd-847f-fbec-7013-708f166722f8@huawei.com>
Date:   Sat, 8 Feb 2020 14:12:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200207130446.GA14465@ming.t460p>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/2/7 21:04, Ming Lei wrote:
> But blk_mq_debugfs_register() in your step 3 for adding loop still may
> fail, that is why I suggest to consider to move
> blk_mq_debugfs_register() into blk_unregister_queue().

I think therer might be a problem.

static void loop_remove(struct loop_device *lo)
{
         del_gendisk(lo->lo_disk);
         blk_cleanup_queue(lo->lo_queue);
         blk_mq_free_tag_set(&lo->tag_set);
         put_disk(lo->lo_disk);
         kfree(lo);
}

blk_unregister_queue() is called in del_gendisk(), while
blk_cleanup_queue() remove other files or dirs. And
blk_mq_debugfs_register() should be called at last since it
will remove everything.

Thanks
Yu Kuai

