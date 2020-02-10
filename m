Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8F8C352A4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 08:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD83214DB
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 08:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBJIud (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:50:33 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727753AbgBJIuD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 03:50:03 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 22D81B666CC3AA688394;
        Mon, 10 Feb 2020 16:49:58 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.66) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 10 Feb 2020
 16:49:49 +0800
Subject: Re: [PATCH] block: revert pushing the final release of request_queue
 to a workqueue.
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>, <chaitanya.kulkarni@wdc.com>,
        <damien.lemoal@wdc.com>, <dhowells@redhat.com>,
        <asml.silence@gmail.com>, <ajay.joshi@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <luoshijie1@huawei.com>, jan kara <jack@suse.cz>
References: <20200206111052.45356-1-yukuai3@huawei.com>
 <70ce8830-2594-2b7b-9ca9-5fb7edd374d7@acm.org>
 <f89ae154-d6b7-0a3b-060d-f3131b0c1c1d@huawei.com>
 <46a5ec83-5a26-fc8a-4cd9-a77d100b7833@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <b1fead0a-5508-33e8-7aa0-5d061884716a@huawei.com>
Date:   Mon, 10 Feb 2020 16:49:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <46a5ec83-5a26-fc8a-4cd9-a77d100b7833@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/2/10 11:14, Bart Van Assche wrote:
> I think that calling blk_mq_exit_queue() from blk_unregister_queue()
> would break at least the sd driver. The sd driver can issue I/O after
> having called del_gendisk(). See also the sd_sync_cache() call in
> sd_shutdown().

If blk_mq_exit_queue() can't move to blk_unregister_queue(),
neither can blk_mq_debugfs_unregister(). It'a dead end.

The purpose is that when __blk_trace_setup() is called, the cleanup of
last loop_device(__blk_release_queue()) should finish aready.

I wonder if we can test that if the dir still exist in loop_add():

static int loop_add(struct loop_device **l, int i)
{
...
           char disk_name[DISK_NAME_LEN];
           struct dentry *dir, *root;

           sprintf(disk_name, "loop%d", i);
           root = debugfs_lookup("block", NULL);
           if (root) {
                   dir = debugfs_lookup(disk_name, root);
                   if (dir) {
                           dput(dir);
                           dput(root);
                          pr_err("Directory '%s' with parent 'block' 
already present!\n",disk_name);
                           return -EBUSY;
                   }
                   dput(root);
           }
...

Thanks!
Yu Kuai

