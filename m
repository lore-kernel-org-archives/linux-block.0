Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A7EC433EF
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 07:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EC061179
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 07:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350210AbhIHHia (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:38:30 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19017 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349925AbhIHHiY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Sep 2021 03:38:24 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H4DPz3nV5zbmMy;
        Wed,  8 Sep 2021 15:33:11 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 15:37:07 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 8 Sep 2021 15:37:06 +0800
Subject: Re: [PATCH v4 2/6] nbd: convert to use blk_mq_find_and_get_req()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <josef@toxicpanda.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yi.zhang@huawei.com>
References: <20210907140154.2134091-1-yukuai3@huawei.com>
 <20210907140154.2134091-3-yukuai3@huawei.com> <YThmhhI1/fZd29b1@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <e295605c-bc8e-cbb9-ca51-1355fdfc0264@huawei.com>
Date:   Wed, 8 Sep 2021 15:37:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YThmhhI1/fZd29b1@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/08 15:30, Ming Lei wrote:

>> +put_req:
>> +	if (req)
>> +		blk_mq_put_rq_ref(req);
>>   	return ret ? ERR_PTR(ret) : cmd;
> 
> After the request's refcnt is dropped, it can be freed immediately, then
> one stale command is returned to caller.

Hi, Ming

It's right this patch leave this problem. Please take a look at patch 3
and patch 4, the problem should be fixed with these patches.

Thanks,
Kuai
> 
> Thanks,
> Ming
> 
> .
> 
