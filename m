Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1B4C433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 09:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbiCBJDq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbiCBJDp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 04:03:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5FD19C18
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 01:02:56 -0800 (PST)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K7p6b111xz687Sl;
        Wed,  2 Mar 2022 17:02:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 2 Mar 2022 10:02:54 +0100
Received: from [10.47.80.134] (10.47.80.134) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 2 Mar
 2022 09:02:54 +0000
Message-ID: <7d112d9f-6ab1-4f8e-6005-b940074f1071@huawei.com>
Date:   Wed, 2 Mar 2022 09:02:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/6] blk-mq: figure out correct numa node for hw queue
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Yu Kuai <yukuai3@huawei.com>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-2-ming.lei@redhat.com>
 <45adf246-176a-b4a5-d973-4c885c37d821@huawei.com> <Yh7MqBLsE2FJvT2Z@T590>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <Yh7MqBLsE2FJvT2Z@T590>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.134]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/03/2022 01:47, Ming Lei wrote:
>>>    static struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
>>>    					       unsigned int hctx_idx,
>>>    					       unsigned int nr_tags,
>>>    					       unsigned int reserved_tags)
>>>    {
>>>    	struct blk_mq_tags *tags;
>>> -	int node;
>>> +	int node = blk_mq_get_hctx_node(set, hctx_idx);
>> nit: the code originally had reverse firtree ordering, which I suppose is
>> not by mistake
> What is reverse firtree ordering here? I don't know what is wrong
> with the above one line change from patch style viewpoint, and
> checkpatch complains nothing here.

checkpath would not complain about this. I'm talking about:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst#n587

The original code had:

	struct blk_mq_tags *tags;
	int node;

as opposed to:

	int node;
	struct blk_mq_tags *tags;

That's all. The block code seems to mostly follow this style when 
possible. It's just a style issue.

thanks,
John
