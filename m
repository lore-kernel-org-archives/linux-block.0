Return-Path: <SRS0=URwg=33=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23584C352A2
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 12:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0024020720
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 12:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGMZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:25:14 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48970 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbgBGMZO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Feb 2020 07:25:14 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5AD6A72924EC40EACDCD;
        Fri,  7 Feb 2020 20:25:10 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.66) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 7 Feb 2020
 20:25:00 +0800
Subject: Re: [PATCH] block: revert pushing the final release of request_queue
 to a workqueue.
From:   "yukuai (C)" <yukuai3@huawei.com>
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
Message-ID: <63873791-e303-aece-94c5-efb2a6976363@huawei.com>
Date:   Fri, 7 Feb 2020 20:24:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1f2fb027-1d62-2a52-9956-7847fa1baf96@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/2/7 18:26, yukuai (C) wrote:
> The reason of the problem is because the final release of request_queue
> may be called after loop_remove() returns.

The description is not accurate. The reason of the problem is that
__blk_trace_setup() called before the final release of request_queue
returns.(step 4 before step 5)

Thanks!
Yu Kuai

