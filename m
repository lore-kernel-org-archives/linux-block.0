Return-Path: <SRS0=ocky=TZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C2C282CE
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 05:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7D92075E
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 05:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfEYFMn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 May 2019 01:12:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfEYFMn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 May 2019 01:12:43 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 930944A59D84710E374A;
        Sat, 25 May 2019 13:12:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 13:12:35 +0800
Subject: Re: [PATCH 0/2] fixes for block stats
From:   Hou Tao <houtao1@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <osandov@fb.com>, <ming.lei@redhat.com>
References: <20190521075904.135060-1-houtao1@huawei.com>
Message-ID: <e2ba6719-e2f8-1bfb-c5b5-7a4396df60ec@huawei.com>
Date:   Sat, 25 May 2019 13:12:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190521075904.135060-1-houtao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping ?

On 2019/5/21 15:59, Hou Tao wrote:
> The first patch fixes the problem that there is no sample in
> /sys/kernel/debug/block/nvmeXn1/poll_stat and hybrid poll may
> don't work as expected. The second patch tries to ensure
> the latency accounting for block stats will work normally
> even when iostat is disabled.
> 
> Comments are wecome.
> 
> Regard,
> Tao
> 
> Hou Tao (2):
>   block: make rq sector size accessible for block stats
>   block: also check RQF_STATS in blk_mq_need_time_stamp()
> 
>  block/blk-mq.c         | 17 ++++++++---------
>  block/blk-throttle.c   |  3 ++-
>  include/linux/blkdev.h | 15 ++++++++++++---
>  3 files changed, 22 insertions(+), 13 deletions(-)
> 

