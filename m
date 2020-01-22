Return-Path: <SRS0=Jk+C=3L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A81C2D0CE
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 02:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA7B24655
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 02:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAVCpo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 21:45:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbgAVCpo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 21:45:44 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A014D63E922200D617CC;
        Wed, 22 Jan 2020 10:45:41 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.66) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 Jan 2020
 10:45:40 +0800
Subject: Re: [PATCH] nbd: add a flush_workqueue in nbd_start_device
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        <mchristi@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
References: <20200121124813.13332-1-sunke32@huawei.com>
 <82a3eb7e-883c-a091-feec-27f3937491ab@toxicpanda.com>
 <83d21549-66a0-0e76-89e5-1303c5b19102@kernel.dk>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <a180649a-d73b-24ad-14d5-d3ed992bba0d@huawei.com>
Date:   Wed, 22 Jan 2020 10:45:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <83d21549-66a0-0e76-89e5-1303c5b19102@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2020/1/22 5:25, Jens Axboe 写道:
> On 1/21/20 7:00 AM, Josef Bacik wrote:
>> On 1/21/20 7:48 AM, Sun Ke wrote:
>>> When kzalloc fail, may cause trying to destroy the
>>> workqueue from inside the workqueue.
>>>
>>> If num_connections is m (2 < m), and NO.1 ~ NO.n
>>> (1 < n < m) kzalloc are successful. The NO.(n + 1)
>>> failed. Then, nbd_start_device will return ENOMEM
>>> to nbd_start_device_ioctl, and nbd_start_device_ioctl
>>> will return immediately without running flush_workqueue.
>>> However, we still have n recv threads. If nbd_release
>>> run first, recv threads may have to drop the last
>>> config_refs and try to destroy the workqueue from
>>> inside the workqueue.
>>>
>>> To fix it, add a flush_workqueue in nbd_start_device.
>>>
>>> Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
>>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>>> ---
>>>    drivers/block/nbd.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>> index b4607dd96185..dd1f8c2c6169 100644
>>> --- a/drivers/block/nbd.c
>>> +++ b/drivers/block/nbd.c
>>> @@ -1264,7 +1264,12 @@ static int nbd_start_device(struct nbd_device *nbd)
>>>    
>>>    		args = kzalloc(sizeof(*args), GFP_KERNEL);
>>>    		if (!args) {
>>> -			sock_shutdown(nbd);
>>> +			if (i == 0)
>>> +				sock_shutdown(nbd);
>>> +			else {
>>> +				sock_shutdown(nbd);
>>> +				flush_workqueue(nbd->recv_workq);
>>> +			}
>>
>> Just for readability sake why don't we just flush_workqueue()
>> unconditionally, and add a comment so we know why in the future.
> 
> Or maybe just make it:
> 
> 	sock_shutdown(nbd);
> 	if (i)
> 		flush_workqueue(nbd->recv_workq);
> 
> which does the same thing, but is still readable. The current code with
> the shutdown duplication is just a bit odd. Needs a comment either way.
> 

OK, I will improve it in my v2 patch.

Thanks,

Sun Ke

