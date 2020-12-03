Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46830C63777
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 09:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA92E217A0
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 09:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgLCJ1M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:27:12 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2197 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbgLCJ1L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 04:27:11 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cmr5D6xLDz67LZT;
        Thu,  3 Dec 2020 17:24:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 3 Dec 2020 10:26:29 +0100
Received: from [10.47.8.200] (10.47.8.200) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 3 Dec 2020
 09:26:28 +0000
Subject: Re: [RFC PATCH] blk-mq: Clean up references when freeing rqs
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@lst.de>, <hare@suse.de>,
        <ppvk@codeaurora.org>, <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>
References: <1606827738-238646-1-git-send-email-john.garry@huawei.com>
 <20201202033134.GD494805@T590>
 <aaf77015-3039-6b04-3417-d376e3467444@huawei.com>
 <20201203005505.GB540033@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fa222311-2184-0041-61ab-b3d70fb92585@huawei.com>
Date:   Thu, 3 Dec 2020 09:26:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201203005505.GB540033@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.200]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/12/2020 00:55, Ming Lei wrote:

Hi Ming,

>> Yeah, so I said that was another problem which you mentioned there, which
>> I'm not addressing, but I don't think that I'm making thing worse here.
> The thing is that this patch does not fix the issue completely.
> 
>> So AFAICS, the blk-mq/sched code doesn't wait for any "readers" to be
>> finished, such as those running blk_mq_queue_tag_busy_iter or
>> blk_mq_tagset_busy_iter() in another context.
>>
>> So how about the idea of introducing some synchronization primitive, such as
>> semaphore, which those "readers" must grab and release at start and end (of
>> iter), to ensure the requests are not freed during the iteration?
> It looks good, however devil is in details, please make into patch for
> review.

OK, but another thing to say is that I need to find a somewhat reliable 
reproducer for the potential problem you mention. So far this patch 
solves the issue I see (in that kasan stops warning). Let me analyze 
this a bit further.

Thanks,
John
