Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0D3C48BC2
	for <linux-block@archiver.kernel.org>; Mon, 28 Jun 2021 01:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE08619B6
	for <linux-block@archiver.kernel.org>; Mon, 28 Jun 2021 01:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhF1BVO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Jun 2021 21:21:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8468 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhF1BVO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Jun 2021 21:21:14 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GCqRg6S0NzZnC3;
        Mon, 28 Jun 2021 09:15:43 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 09:18:48 +0800
Received: from [10.174.179.197] (10.174.179.197) by
 dggpeml500009.china.huawei.com (7.185.36.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 09:18:48 +0800
Subject: Re: [PATCH] block: remove redundant bio_uninit from simple direct io
To:     Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>
References: <20210626104736.911941-1-yuyufen@huawei.com>
 <37173158-c49b-def1-6722-df7135df9d4a@kernel.dk>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <eb8deffd-4d6f-634f-9cff-5d273c7dfdba@huawei.com>
Date:   Mon, 28 Jun 2021 09:18:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <37173158-c49b-def1-6722-df7135df9d4a@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.197]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/6/28 6:24, Jens Axboe wrote:
> On 6/26/21 4:47 AM, Yufen Yu wrote:
>> Since bio_endio() will call bio_uninit() for us, we can remove
>> it from current code path.
> 
> What about the error path?
> 

Before calling submit_bio(), we don't need bio_uninit(). After
calling submit_bio(), any error path will call bio_endio() to
end the bio. So, I think we can remove it in current path.

Thanks
Yufen
