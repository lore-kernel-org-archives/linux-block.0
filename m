Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43536C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 04:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B79160F6F
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 04:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhIMEdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 00:33:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19032 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhIMEdz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 00:33:55 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H7D4f10s3zbmLl;
        Mon, 13 Sep 2021 12:28:34 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 12:32:38 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 12:32:38 +0800
Subject: Re: [PATCH v2 3/3] nbd: fix race between nbd_alloc_config() and
 module removal
To:     Christoph Hellwig <hch@lst.de>
CC:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20210904122519.1963983-1-houtao1@huawei.com>
 <20210904122519.1963983-4-houtao1@huawei.com> <20210906093051.GC30790@lst.de>
 <ce3e1ea8-ebda-4372-42ce-e8a4b2d12514@huawei.com>
 <20210906102521.GA3082@lst.de>
 <730dae5e-5af8-3554-18bf-e22ff576e2b1@huawei.com>
 <20210909064035.GA26290@lst.de>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <6434d4e8-984d-97df-34e5-b86a0e69cf58@huawei.com>
Date:   Mon, 13 Sep 2021 12:32:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210909064035.GA26290@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On 9/9/2021 2:40 PM, Christoph Hellwig wrote:
> On Tue, Sep 07, 2021 at 11:04:16AM +0800, Hou Tao wrote:
>> Let me explain first. The reason it works is due to genl_lock_all() in netlink code.
> Btw, please properly format your mail.  These overly long lines are really
> hard to read.
Thanks for reminding.
>> If the module removal happens before calling try_module_get(), nbd_cleanup() will
>>
>> call genl_unregister_family() first, and then genl_lock_all(). genl_lock_all() will
>>
>> prevent ops in nbd_connect_genl_ops() from being called, because the calling
>>
>> of nbd ops happens in genl_rcv() which needs to acquire cb_lock first.
> Good.
>
>> I have checked multiple genl_ops, it seems that the reason why these genl_ops
>>
>> don't need try_module_get() is that these ops don't create new object through
>>
>> genl_ops and just control it. However genl_family_rcv_msg_dumpit() will try to
>>
>> call try_module_get(), but according to the history (6dc878a8ca39 "netlink: add reference of module in netlink_dump_start"),
>>
>> it is because inet_diag_handler_cmd() will call __netlink_dump_start().
> And now taking a step back:  Why do we even need this extra module
> reference?  For the case where nbd_alloc_config is called from nbd_open
> we obviously don't need it.  In the case where it is called from
> nbd_genl_connect that prevents unloading nbd when there is a configured
> but not actually nbd device.  Which isn't reallyed need and counter to
> how other drivers work.
Yes, the purpose of module ref-counting in nbd_alloc_config() is to force
the user to disconnect the nbd device manually before module removal.
And loop device works in the same way. If a file is attached to a loop device,
an extra module reference will be taken in loop_configure() and the removal
of loop module will fail. The only difference is that loop driver takes the
extra ref-count by ioctl, and nbd does it through netlink.
>
> Did you try just removing the extra module refcounting?
Yes, removing the module refcounting in nbd_alloc_config() and cleaning
the nbd_config in nbd_cleanup() also work, but not sure whether or not
it will break some nbd user-case which depends on the extra module
reference count. I prefer to keep the extra module refcounting considering
that loop driver does it as well, so what is your suggestion ?

Regards,
Tao

> .

