Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75FDC433DB
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 11:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9323D22516
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 11:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgLVLQu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Dec 2020 06:16:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2278 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgLVLQu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Dec 2020 06:16:50 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D0Ybg20Yxz67PcC;
        Tue, 22 Dec 2020 19:13:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 22 Dec 2020 12:16:08 +0100
Received: from [10.47.1.120] (10.47.1.120) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 22 Dec
 2020 11:16:07 +0000
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
 <b2edab2b-8af7-816d-9da2-4720d19b96f8@huawei.com>
 <e97a0603-f9e3-1b00-4a09-c569d4f73d7b@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f98fd31e-89d4-523f-df70-4bd5f39ccbd5@huawei.com>
Date:   Tue, 22 Dec 2020 11:15:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <e97a0603-f9e3-1b00-4a09-c569d4f73d7b@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.1.120]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/12/2020 02:13, Bart Van Assche wrote:
> On 12/21/20 10:47 AM, John Garry wrote:
>> Yes, I agree, and I'm not sure what I wrote to give that impression.
>>
>> About "root partition", above, I'm just saying that / is mounted on a
>> sda partition:
>>
>> root@ubuntu:/home/john# mount | grep sda
>> /dev/sda2 on / type ext4 (rw,relatime,errors=remount-ro,stripe=32)
>> /dev/sda1 on /boot/efi type vfat
>> (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
> Hi John,
> 

Hi Bart, Ming,

> Thanks for the clarification. I want to take back my suggestion about
> adding rcu_read_lock() / rcu_read_unlock() in blk_mq_tagset_busy_iter()
> since it is not allowed to sleep inside an RCU read-side critical
> section, since blk_mq_tagset_busy_iter() is used in request timeout
> handling and since there may be blk_mq_ops.timeout implementations that
> sleep.

Yes, that's why I was going with atomic, rather than some 
synchronization primitive which may sleep.

> 
> Ming's suggestion to serialize blk_mq_tagset_busy_iter() and
> blk_mq_free_rqs() looks interesting to me.
> 

So then we could have something like this:

---8<---

  -435,9 +444,13 @@ void blk_mq_queue_tag_busy_iter(struct request_queue 
*q, busy_iter_fn *fn,
	if (!blk_mq_hw_queue_mapped(hctx))
			continue;

+	while (!atomic_inc_not_zero(&tags->iter_usage_counter));
+
	if (tags->nr_reserved_tags)
		bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
	bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);

+	atomic_dec(&tags->iter_usage_counter);
}

blk_queue_exit(q);

--->8---

And similar for blk_mq_tagset_busy_iter(). How about it?

Thanks,
John
