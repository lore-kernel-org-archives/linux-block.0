Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892EDC433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 03:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6107B6109F
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 03:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhIGDFZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 23:05:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9005 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhIGDFY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Sep 2021 23:05:24 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H3VTC0QKQzVqHM;
        Tue,  7 Sep 2021 11:03:27 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 7 Sep 2021 11:04:16 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 7 Sep 2021 11:04:16 +0800
Subject: Re: [PATCH v2 3/3] nbd: fix race between nbd_alloc_config() and
 module removal
To:     Christoph Hellwig <hch@lst.de>
CC:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20210904122519.1963983-1-houtao1@huawei.com>
 <20210904122519.1963983-4-houtao1@huawei.com> <20210906093051.GC30790@lst.de>
 <ce3e1ea8-ebda-4372-42ce-e8a4b2d12514@huawei.com>
 <20210906102521.GA3082@lst.de>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <730dae5e-5af8-3554-18bf-e22ff576e2b1@huawei.com>
Date:   Tue, 7 Sep 2021 11:04:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210906102521.GA3082@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 9/6/2021 6:25 PM, Christoph Hellwig wrote:
> On Mon, Sep 06, 2021 at 06:08:54PM +0800, Hou Tao wrote:
>>>> +	if (!try_module_get(THIS_MODULE))
>>>> +		return ERR_PTR(-ENODEV);
>>> try_module_get(THIS_MODULE) is an indicator for an unsafe pattern.  If
>>> we don't already have a reference it could never close the race.
>>>
>>> Looking at the callers:
>>>
>>>  - nbd_open like all block device operations must have a reference
>>>    already.
>> Yes. nbd_open() has already taken a reference in dentry_open().
>>>  - for nbd_genl_connect I'm not an expert, but given that struct
>>>    nbd_genl_family has a module member I suspect the networkinh
>>>    code already takes a reference.
>> That was my original though, but the fact is netlink code doesn't take a module reference
>>
>> in genl_family_rcv_msg_doit() and netlink uses genl_lock_all() to serialize between module removal
>>
>> and nbd_connect_genl_ops calling, so I think use try_module_get() is OK here.
> How it this going to work?  If there was a race you just shortened it,
> but it can still happen before you call try_module_get.  So I think we
> need to look into how the netlink calling conventions are supposed to
> look and understand the issues there first.
> .

Let me explain first. The reason it works is due to genl_lock_all() in netlink code.

If the module removal happens before calling try_module_get(), nbd_cleanup() will

call genl_unregister_family() first, and then genl_lock_all(). genl_lock_all() will

prevent ops in nbd_connect_genl_ops() from being called, because the calling

of nbd ops happens in genl_rcv() which needs to acquire cb_lock first.


process A                                       process B

module removal

genl_unregister_family()

  genl_lock_all()

    down_write(&cb_lock)

                                                receive a new netlink message

                                                genl_rcv()

                                                   // will wait for the removal of nbd ops

                                                   down_read(&cb_lock)

If nbd_alloc_config() happens before the module removal, genl_rcv() must

have been acquired cb_lock & genl_mutex, so nbd_cleanup() will block in

genl_unregister_family(). When nbd_alloc_config() calls try_module_get(),

it will find out the module is dying, so fail nbd_genl_connect().


process A                                     process B

a new netlink message

genl_rcv()

  down_read(&cb_lock)

    mutex_lock(&genl_mutex)

      nbd_genl_connect()

        nbd_alloc_config()

                                               module removal

                                               genl_unregister_family

          // module is dying, so fail

          try_module_get()

                                                 genl_lock_all()

                                                   // wait for the completion of nbd ops

                                                   down_write(&cb_lock)

I have checked multiple genl_ops, it seems that the reason why these genl_ops

don't need try_module_get() is that these ops don't create new object through

genl_ops and just control it. However genl_family_rcv_msg_dumpit() will try to

call try_module_get(), but according to the history (6dc878a8ca39 "netlink: add reference of module in netlink_dump_start"),

it is because inet_diag_handler_cmd() will call __netlink_dump_start().

Regards,

Tao


