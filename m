Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0C4C433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 10:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C08D60F70
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 10:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbhIFKKH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 06:10:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9004 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241464AbhIFKKH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Sep 2021 06:10:07 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H33xl3c6YzVqsq;
        Mon,  6 Sep 2021 18:08:11 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 6 Sep 2021 18:08:58 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 6 Sep 2021 18:08:55 +0800
Subject: Re: [PATCH v2 3/3] nbd: fix race between nbd_alloc_config() and
 module removal
To:     Christoph Hellwig <hch@lst.de>
CC:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20210904122519.1963983-1-houtao1@huawei.com>
 <20210904122519.1963983-4-houtao1@huawei.com> <20210906093051.GC30790@lst.de>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <ce3e1ea8-ebda-4372-42ce-e8a4b2d12514@huawei.com>
Date:   Mon, 6 Sep 2021 18:08:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210906093051.GC30790@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 9/6/2021 5:30 PM, Christoph Hellwig wrote:
> On Sat, Sep 04, 2021 at 08:25:19PM +0800, Hou Tao wrote:
>> When nbd module is being removing, nbd_alloc_config() may be
>> called concurrently by nbd_genl_connect(), although try_module_get()
>> will return false, but nbd_alloc_config() doesn't handle it.
>>
>> The race may lead to the leak of nbd_config and its related
>> resources (e.g, recv_workq) and oops in nbd_read_stat() due
>> to the unload of nbd module as shown below:
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000040
>>   Oops: 0000 [#1] SMP PTI
>>   CPU: 5 PID: 13840 Comm: kworker/u17:33 Not tainted 5.14.0+ #1
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>>   Workqueue: knbd16-recv recv_work [nbd]
>>   RIP: 0010:nbd_read_stat.cold+0x130/0x1a4 [nbd]
>>   Call Trace:
>>    recv_work+0x3b/0xb0 [nbd]
>>    process_one_work+0x1ed/0x390
>>    worker_thread+0x4a/0x3d0
>>    kthread+0x12a/0x150
>>    ret_from_fork+0x22/0x30
>>
>> Fixing it by checking the return value of try_module_get()
>> in nbd_alloc_config(). As nbd_alloc_config() may return ERR_PTR(-ENODEV),
>> assign nbd->config only when nbd_alloc_config() succeeds to ensure
>> the value of nbd->config is binary (valid or NULL).
>>
>> Also adding a debug message to check the reference counter
>> of nbd_config during module removal.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  drivers/block/nbd.c | 28 +++++++++++++++++++---------
>>  1 file changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index cedd3648e1a7..fa6c069b79dc 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1473,15 +1473,20 @@ static struct nbd_config *nbd_alloc_config(void)
>>  {
>>  	struct nbd_config *config;
>>  
>> +	if (!try_module_get(THIS_MODULE))
>> +		return ERR_PTR(-ENODEV);
> try_module_get(THIS_MODULE) is an indicator for an unsafe pattern.  If
> we don't already have a reference it could never close the race.
>
> Looking at the callers:
>
>  - nbd_open like all block device operations must have a reference
>    already.
Yes. nbd_open() has already taken a reference in dentry_open().
>  - for nbd_genl_connect I'm not an expert, but given that struct
>    nbd_genl_family has a module member I suspect the networkinh
>    code already takes a reference.

That was my original though, but the fact is netlink code doesn't take a module reference

in genl_family_rcv_msg_doit() and netlink uses genl_lock_all() to serialize between module removal

and nbd_connect_genl_ops calling, so I think use try_module_get() is OK here.

Regards,

Tao


> So this should be able to use __module_get.

> .
