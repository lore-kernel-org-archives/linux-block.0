Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D75C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 13:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61DCF61214
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 13:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241636AbhIWNdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:33:22 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16233 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241467AbhIWNdM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 09:33:12 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HFbdG6sFrz1DH59;
        Thu, 23 Sep 2021 21:30:26 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 21:31:38 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 23 Sep 2021 21:31:37 +0800
Subject: Re: [PATCH 4/4] block: cancel all throttled bios in
 blk_cleanup_queue()
To:     Christoph Hellwig <hch@infradead.org>
CC:     <axboe@kernel.dk>, <tj@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20210922125115.381752-1-yukuai3@huawei.com>
 <20210922125115.381752-5-yukuai3@huawei.com> <YUs/CcSKqNoIIXoW@infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <aab71a7e-830b-ac48-67f1-83be4e8e364f@huawei.com>
Date:   Thu, 23 Sep 2021 21:31:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YUs/CcSKqNoIIXoW@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/22 22:34, Christoph Hellwig wrote:
> On Wed, Sep 22, 2021 at 08:51:15PM +0800, Yu Kuai wrote:
>> Throttled bios can't be issued after queue is dying in
>> blk_cleanup_queue(), thus it's better to cancel them immediately
>> rather than waiting for throttle is done.
>>
>> For example, if user thread is throttled with low bps while is
>> issuing large io, and the device is deleted. The user thread will
>> wait for a long time for io to return.
> 
> blk_cleanup_queue is too late, this will need to go into del_gendisk
> and on top of my "tear down file system I/O in del_gendisk" series.
> .
> 

Hi,

I see what your series is trying to do, it semms not easy to
collaborate. I'll wait for your series to applied if you don't mind,
or you can take over this series.

Thanks,
Kuai
