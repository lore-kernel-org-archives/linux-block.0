Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B422AC433E0
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 18:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1AA22AAB
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 18:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgLUSsx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:48:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2277 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgLUSsx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Dec 2020 13:48:53 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D07hW0cyTz67ShL;
        Tue, 22 Dec 2020 02:45:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 21 Dec 2020 19:48:11 +0100
Received: from [10.210.168.224] (10.210.168.224) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 21 Dec 2020 18:48:10 +0000
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <hare@suse.de>, <ppvk@codeaurora.org>,
        <kashyap.desai@broadcom.com>, <linuxarm@huawei.com>
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
 <4d2004bb-4444-7a63-7c72-1759e3037cfd@huawei.com>
 <31de2806-bbc1-dcc3-b9eb-ce9257420432@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b2edab2b-8af7-816d-9da2-4720d19b96f8@huawei.com>
Date:   Mon, 21 Dec 2020 18:47:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <31de2806-bbc1-dcc3-b9eb-ce9257420432@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.168.224]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21/12/2020 18:09, Bart Van Assche wrote:
> On 12/21/20 4:06 AM, John Garry wrote:
>> On 18/12/2020 22:43, Bart Van Assche wrote:
>>> Does this mean that we do not yet have
>>> a full explanation about why the above call stack can be triggered?
>>
>> We understand it, and I'll describe my experiment in detail:
>> a. fio runs on 2x disks, sda (root partition disk) and sdb.
>> b. for sda, userpace triggers blk_mq_queue_tag_busy_iter(), as in
>> stackframe above. Since its request queue is not frozen, it will iter
>> the busy tags.
>> c. on sdb, I continuously change the IO scheduler.
>>
>> So sdb request queue gets frozen as we switch IO sched, but we could
>> have this sequence of events:
>> - blk_mq_queue_tag_busy_iter() on sda takes reference to a sdb request
>>     - Getting a tag and updating ->rqs[] in tagset is not atomic
>> - requests for sdb cleared in tagset and request memory is freed
>> - blk_mq_queue_tag_busy_iter() on sda still holds reference to sdb
>> request and dereferences it -> UAF
>>
>> Hope it's clear. It is a bit unlikely, I will admit, but it still can
>> happen and UAF is never good. So please let me know if other idea to solve.
> 
> Hi John,
> 
> Do you agree that all partitions (struct block_device) of a disk share a
> request queue (block_device.bd_disk->queue)? I'm asking this because it
> seems like in the above explanation it has been assumed that different
> partitions use different request queues.
> 
> Thanks,
> 
> Bart.
> 

Hi Bart,

Yes, I agree, and I'm not sure what I wrote to give that impression.

About "root partition", above, I'm just saying that / is mounted on a 
sda partition:

root@ubuntu:/home/john# mount | grep sda
/dev/sda2 on / type ext4 (rw,relatime,errors=remount-ro,stripe=32)
/dev/sda1 on /boot/efi type vfat 
(rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)

Thanks,
John

