Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854B0C433DB
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 08:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E7064E4B
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 08:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhCKIXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 03:23:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2684 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhCKIX2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 03:23:28 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dx20N5kFxz67wjQ;
        Thu, 11 Mar 2021 16:19:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Mar 2021 09:23:25 +0100
Received: from [10.47.4.196] (10.47.4.196) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 11 Mar
 2021 08:23:24 +0000
Subject: Re: [RFC PATCH v3 2/3] blk-mq: Freeze and quiesce all queues for
 tagset in elevator_exit()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <hare@suse.de>, <bvanassche@acm.org>, <axboe@kernel.dk>,
        <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pragalla@codeaurora.org>,
        <kashyap.desai@broadcom.com>, <yuyufen@huawei.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-3-git-send-email-john.garry@huawei.com>
 <YElrSFGyim3rjDN+@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8c6c6783-6152-2332-2f50-14c409e40320@huawei.com>
Date:   Thu, 11 Mar 2021 08:21:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YElrSFGyim3rjDN+@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.4.196]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/03/2021 00:58, Ming Lei wrote:
>> Indeed, blk_mq_queue_tag_busy_iter() already does take a reference to its
>> queue usage counter when called, and the queue cannot be frozen to switch
>> IO scheduler until all refs are dropped. This ensures no stale references
>> to IO scheduler requests will be seen by blk_mq_queue_tag_busy_iter().
>>
>> However, there is nothing to stop blk_mq_queue_tag_busy_iter() being
>> run for another queue associated with the same tagset, and it seeing
>> a stale IO scheduler request from the other queue after they are freed.
>>
>> To stop this happening, freeze and quiesce all queues associated with the
>> tagset as the elevator is exited.
> I think this way can't be accepted since switching one queue's scheduler
> is nothing to do with other request queues attached to same HBA.
> 
> This patch will cause performance regression because userspace may
> switch scheduler according to medium or workloads, at that time other
> LUNs will be affected by this patch.

Hmmm..that was my concern also. Do you think that it may cause a big 
impact? Depends totally on the workload, I suppose.

FWIW, it is useful though for solving both iterator problems.

Thanks,
John
