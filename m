Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F637C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 08:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC2760FED
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 08:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhJUIKp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 04:10:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4011 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhJUIKp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 04:10:45 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HZg3t30tdz686th;
        Thu, 21 Oct 2021 16:04:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 10:08:26 +0200
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 09:08:26 +0100
Subject: Re: [PATCH v2] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
To:     Kashyap Desai <kashyap.desai@broadcom.com>, <axboe@kernel.dk>
CC:     <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>
References: <1634550083-202815-1-git-send-email-john.garry@huawei.com>
 <2f09315210261e82c42a1353cab48dcd@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <afdde2fe-21b3-2509-72fa-7f705338d8c7@huawei.com>
Date:   Thu, 21 Oct 2021 09:08:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <2f09315210261e82c42a1353cab48dcd@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/10/2021 19:49, Kashyap Desai wrote:
>> -----Original Message-----
>> From: John Garry [mailto:john.garry@huawei.com]
>> Sent: Monday, October 18, 2021 3:11 PM
>> To:axboe@kernel.dk
>> Cc:ming.lei@redhat.com;linux-block@vger.kernel.org; linux-
>> kernel@vger.kernel.org;kashyap.desai@broadcom.com;hare@suse.de; John
>> Garry<john.garry@huawei.com>
>> Subject: [PATCH v2] blk-mq: Fix blk_mq_tagset_busy_iter() for shared
> tags
>> Since it is now possible for a tagset to share a single set of tags, the
> iter
>> function should not re-iter the tags for the count of #hw queues in that
> case.
>> Rather it should just iter once.
>>
>> Fixes: e0fdf846c7bb ("blk-mq: Use shared tags for shared sbitmap
> support")
>> Reported-by: Kashyap Desai<kashyap.desai@broadcom.com>
>> Signed-off-by: John Garry<john.garry@huawei.com>
>> Reviewed-by: Ming Lei<ming.lei@redhat.com>
>> ---
>> Diff to v1:
>> - Add Ming's RB tag
> Now I noticed proper host_busy in my test. Still CPU hogging is not
> resolved, but issue addressed by this patch is resolved.
> 
> Tested-by: Kashyap Desai<kashyap.desai@broadcom.com>

Hi Jens,

Can you kindly consider picking up this patch?

I'm still waiting for feedback from Kashyap on whether we should 
optimize the other iter functions for shared tags, but this one is a fix.

Thanks!
