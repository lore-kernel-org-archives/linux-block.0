Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E494C5AC75
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 01:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbiAZBIB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jan 2022 20:08:01 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30304 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiAZBIB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jan 2022 20:08:01 -0500
Received: from kwepemi100021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jk5Cx0xQHzbkJk;
        Wed, 26 Jan 2022 09:07:09 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100021.china.huawei.com (7.221.188.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 09:07:59 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 09:07:58 +0800
Subject: Re: [PATCH] dm mpath: fix missing blk_account_io_done() in error path
To:     Christoph Hellwig <hch@infradead.org>
CC:     <snitzer@redhat.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220125122654.2236172-1-yukuai3@huawei.com>
 <YfBgbLVOPWEy60bH@infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <8fe2409e-b433-ca01-ef6a-86d6181dbe7d@huawei.com>
Date:   Wed, 26 Jan 2022 09:07:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YfBgbLVOPWEy60bH@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 2022/01/26 4:41, Christoph Hellwig Ð´µÀ:
> On Tue, Jan 25, 2022 at 08:26:54PM +0800, Yu Kuai wrote:
>> If blk_mq_request_issue_directly() failed from
>> blk_insert_cloned_request(), the request will be accounted start.
>> Currently, blk_insert_cloned_request() is only called by dm, and such
>> request won't be accounted done by dm.
>>
>> In normal path, io will be accounted start from blk_mq_bio_to_request(),
>> when the request is allocated, and such io will be accounted done from
>> __blk_mq_end_request_acct() whether it succeeded or failed. Thus add
>> blk_account_io_done() to fix the problem.
> 
> The patch looks good, but the subject is incorrect, this is not in
> dm-mpath but in the block layer.
> .
> 

Ok, I'll fix that.

Thanks,
Kuai
