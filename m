Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB6FC3A59E
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 00:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B58922D6D
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 00:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfICApT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Sep 2019 20:45:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfICApT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Sep 2019 20:45:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57A1443D5B;
        Tue,  3 Sep 2019 00:45:18 +0000 (UTC)
Received: from [10.72.12.60] (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4014196AE;
        Tue,  3 Sep 2019 00:45:15 +0000 (UTC)
Subject: Re: [PATCH 2/2 v3] nbd: fix possible page fault for nbd disk
To:     Mike Christie <mchristi@redhat.com>, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20190822075923.11996-1-xiubli@redhat.com>
 <20190822075923.11996-3-xiubli@redhat.com> <5D686498.5090602@redhat.com>
 <78d16d10-1d06-6ce1-7c51-64c42e51f549@redhat.com>
 <5D6D89ED.6020700@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <e3c0f330-26b4-a305-8e36-b452e46bed8f@redhat.com>
Date:   Tue, 3 Sep 2019 08:45:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5D6D89ED.6020700@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 03 Sep 2019 00:45:18 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/9/3 5:30, Mike Christie wrote:
> On 08/29/2019 07:58 PM, Xiubo Li wrote:
>> On 2019/8/30 7:49, Mike Christie wrote:
>>> On 08/22/2019 02:59 AM, xiubli@redhat.com wrote:
[...]
>>> @@ -1596,6 +1614,7 @@ static int nbd_dev_add(int index)
>>>        nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
>>>            BLK_MQ_F_BLOCKING;
>>>        nbd->tag_set.driver_data = nbd;
>>> +    init_completion(&nbd->destroy_complete);
>>>          err = blk_mq_alloc_tag_set(&nbd->tag_set);
>>>        if (err)
>>> @@ -1761,6 +1780,16 @@ static int nbd_genl_connect(struct sk_buff
>>> *skb, struct genl_info *info)
>>>            mutex_unlock(&nbd_index_mutex);
>>>            return -EINVAL;
>>>        }
>>> +
>>> +    if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
>>> Why does this have to be set? If this is not set would you end up
>>> hitting the config_refs check:
>>>
>>> if (refcount_read(&nbd->config_refs)) {
>>>
>>> and possibly returning failure?
>> Yeah, this is a good question. Before I have also tried to fix it with
>> this, but it still won't work for me.
>>
>>  From my test cases almost more than 50% times, the crash will be hit in
>> the gap just after the nbd->config already been released, and before the
>> nbd itself not yet, so the nbd->config_refs will be 0.
>>
>>
>>> If you moved the complete() to nbd_config_put would it work if this bit
>>> was set or not?
>> Tried it already, it still won't work.
>>
>> There is one case that when disconnecting the nbd device, the userspace
>> service will do the open()/release()  things, please see [1], and the
>> sequence is not the same every time, if the
>> NBD_CFLAG_DESTROY_ON_DISCONNECT bit is set the crash still exists.
>>
>> So sometimes when the nbd_put() called from the nbd_config_put(), the
>> &nbd->refs in nbd_put won't be 0, it could be 1. And it will be 0 just
>> after the release() is triggered later.
>>
>> So I just place the complete() before "free(nbd);", or there will be
>> another Call trace will be seen very often:
> Did this happen because you race with
>
> nbd_put->nbd_dev_remove->del_gendisk->device_del->sysfs_remove_dir
>
> ? If so, does that still happen after you moved
>
> mutex_unlock(&nbd_index_mutex);
>
> in nbd_put?

Currently with this fix, there is no any Call Traces anymore from my 
test cases. I ran the test for almost a whole night long without any 
problem.


>   It seems before that part of your patch was added we could
> hit this race and got the duplicate sysfs entry trace below:
>
> 1. nbd_put -> idr_remove.
> 2. nbd_put drops mutex.
> 3. nbd_genl_connect takes mutex (index != -1 for this call).
> 4. nbd_genl_connect-> idr_find fails due to remove in #1.
> 5. nbd_genl_connect->nbd_dev_add is then able to try to add the device
> to sysfs before the nbd_put->nbd_dev_remove path has deleted the device.

Yeah, it is. Just before the old stale sysfs entry is totally 
removed/released, the nbd driver is trying to create it again with the 
same nbd_index.


>
> When you now do the idr and sysfs removal and idr addition/search and
> sysfs addition all under the nbd_index_mutex it shouldn't happen anymore.
>
Correctly.

Thanks,
BRs


>
>
>>     2489 Aug 20 18:10:04 lxbfd2 kernel: sysfs: cannot create duplicate
>> filename '/devices/virtual/block/nbd0'
>>     2490 Aug 20 18:10:04 lxbfd2 kernel: CPU: 0 PID: 8635 Comm: nbd-clid
>> Kdump: loaded Tainted: G      D 5.1.18-300.fc30.x86_64 #1
>>     2491 Aug 20 18:10:04 lxbfd2 kernel: Hardware name: Red Hat KVM, BIOS
>> 0.5.1 01/01/2011
>>     2492 Aug 20 18:10:04 lxbfd2 kernel: Call Trace:
>>     2493 Aug 20 18:10:04 lxbfd2 kernel: dump_stack+0x5c/0x80
>>     2494 Aug 20 18:10:04 lxbfd2 kernel: sysfs_warn_dup.cold+0x17/0x2d
>>     2495 Aug 20 18:10:04 lxbfd2 kernel: sysfs_create_dir_ns+0xb6/0xd0
>>     2496 Aug 20 18:10:04 lxbfd2 kernel: kobject_add_internal+0xb7/0x280
>>     2497 Aug 20 18:10:04 lxbfd2 kernel: kobject_add+0x7e/0xb0
>>     2498 Aug 20 18:10:04 lxbfd2 kernel: ? _cond_resched+0x15/0x30
>>     2499 Aug 20 18:10:04 lxbfd2 kernel: device_add+0x12b/0x690
>>     2500 Aug 20 18:10:04 lxbfd2 kernel: __device_add_disk+0x1b5/0x470
>>     2501 Aug 20 18:10:04 lxbfd2 kernel: nbd_dev_add+0x21d/0x2b0 [nbd]
>>     2502 Aug 20 18:10:04 lxbfd2 kernel: nbd_genl_connect+0x16e/0x630 [nbd]
>>     2503 Aug 20 18:10:04 lxbfd2 kernel: genl_family_rcv_msg+0x1a9/0x3b0
>>     2504 Aug 20 18:10:04 lxbfd2 kernel: ? __switch_to_asm+0x35/0x70
>>     2505 Aug 20 18:10:04 lxbfd2 kernel: ? __switch_to_asm+0x41/0x70
>>     2506 Aug 20 18:10:04 lxbfd2 kernel: ? __switch_to+0x11f/0x4c0
>>     2507 Aug 20 18:10:04 lxbfd2 kernel: ? __switch_to_asm+0x41/0x70
>>     [...]
>>

