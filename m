Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C1FC433DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 16:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C064A2053B
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 16:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgFEQKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:10:20 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbgFEQKU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 12:10:20 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 4D94275863788912D03A;
        Fri,  5 Jun 2020 17:10:14 +0100 (IST)
Received: from [127.0.0.1] (10.210.169.114) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 5 Jun 2020
 17:10:13 +0100
Subject: Re: [PATCH 0/2] blk-mq: fix handling cpu hotplug
From:   John Garry <john.garry@huawei.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200605114410.2416726-1-ming.lei@redhat.com>
 <e99f7770-f7b1-291b-d8bb-0ad30d774078@huawei.com>
Message-ID: <24ccc829-8528-0f05-c9e3-72594515c4c9@huawei.com>
Date:   Fri, 5 Jun 2020 17:08:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <e99f7770-f7b1-291b-d8bb-0ad30d774078@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.114]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/06/2020 12:49, John Garry wrote:
> On 05/06/2020 12:44, Ming Lei wrote:
>> Hi Jens,
>>
>> The 1st patch avoids to fail driver tag allocation because of inactive
>> hctx, so hang risk can be killed during cpu hotplug.
>>
>> The 2nd patch fixes blk_mq_all_tag_iter so that we can drain all
>> requests before one hctx becomes inactive.
>>
>> Both fixes bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are
>> offline").
>>
>> John has verified that the two can fix his request timeout issue during
>> cpu hotplug.
> 
> But let me test it again my afternoon. My test branch earlier had some
> debug stuff.
> 

it looks ok, so the tested-by stands.

BTW, do you agree that the following comment from 
__blk_mq_run_hw_queue() is now stale:

"... we depend on blk-mq timeout handler to handle dispatched requests 
to this hctx"

Thanks,
John

