Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61157C433DB
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 06:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7F1239CF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 06:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbhANGur (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 01:50:47 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2547 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbhANGur (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 01:50:47 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DGZdg4rrqzW0ds;
        Thu, 14 Jan 2021 14:48:23 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 14 Jan 2021 14:50:04 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 14
 Jan 2021 14:50:02 +0800
Subject: Re: [PATCH v2 0/6] avoid repeated request completion and IO error
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
References: <20210107033149.15701-1-lengchao@huawei.com>
 <879d04a5-c52e-4d21-5003-d369ab5cdaee@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <3a8426ea-1488-b7c7-630e-162e61270190@huawei.com>
Date:   Thu, 14 Jan 2021 14:50:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <879d04a5-c52e-4d21-5003-d369ab5cdaee@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/14 8:15, Sagi Grimberg wrote:
>> First avoid repeated request completion for nvmf_fail_nonready_command.
>> Second avoid IO error and repeated request completion for queue_rq.
> 
> Maybe this is me chiming in v2, but what is this fixing? what
> is the bug you are seeing?The bug is crash and io error in two scenarios.
First inject request time out, crash happens due to request double
completion, the probability is very low. The reason: we will do error
recovery for request time out. When error recovery, new request will
be completed by nvmf_fail_nonready_command in queue_rq, the state of
the request will be changed to MQ_RQ_IN_FLIGHT, the request is freed
asynchronously in nvme_submit_user_cmd, nvme_submit_user_cmd may
run after cancel request(the state of the request is MQ_RQ_IN_FLIGHT)
in error recovery. The request will be double completion.

Second use two HBAs for nvme native multipath, and then inject one HBA
fault, io error happens and a low probability crash happens. The reason
of io error is the blk_status_t of queue_rq is BLK_STS_IOERR, blk-mq
call blk_mq_end_request to complete the request. We expect the request
fail over to normal HBA, but the request is directly completed with
BLK_STS_IOERR. The reason of crash is similar to the first scenario.
