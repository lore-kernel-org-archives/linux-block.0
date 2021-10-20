Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE27C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021FA61374
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTO0H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:26:07 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26175 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhJTO0G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:26:06 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HZCVv52JDz8tjk;
        Wed, 20 Oct 2021 22:22:31 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Wed, 20 Oct 2021 22:23:45 +0800
Subject: Re: [PATCH -next] nbd: Fix hungtask when nbd_config_put
To:     Josef Bacik <josef@toxicpanda.com>
References: <20211020094830.3056325-1-yebin10@huawei.com>
 <YXAh7tWFbpukMi6+@localhost.localdomain>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <nbd@other.debian.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <61702671.6050807@huawei.com>
Date:   Wed, 20 Oct 2021 22:23:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <YXAh7tWFbpukMi6+@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/10/20 22:04, Josef Bacik wrote:
> On Wed, Oct 20, 2021 at 05:48:30PM +0800, Ye Bin wrote:
>> I got follow issue:
>> [  247.381177] INFO: task kworker/u10:0:47 blocked for more than 120 seconds.
>> [  247.382644]       Not tainted 4.19.90-dirty #140
>> [  247.383502] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  247.385027] Call Trace:
>> [  247.388384]  schedule+0xb8/0x3c0
>> [  247.388966]  schedule_timeout+0x2b4/0x380
>> [  247.392815]  wait_for_completion+0x367/0x510
>> [  247.397713]  flush_workqueue+0x32b/0x1340
>> [  247.402700]  drain_workqueue+0xda/0x3c0
>> [  247.403442]  destroy_workqueue+0x7b/0x690
>> [  247.405014]  nbd_config_put.cold+0x2f9/0x5b6
>> [  247.405823]  recv_work+0x1fd/0x2b0
>> [  247.406485]  process_one_work+0x70b/0x1610
>> [  247.407262]  worker_thread+0x5a9/0x1060
>> [  247.408699]  kthread+0x35e/0x430
>> [  247.410918]  ret_from_fork+0x1f/0x30
>>
>> We can reprodeuce issue as follows:
>> 1. Inject memory fault in nbd_start_device
>> @@ -1244,10 +1248,18 @@ static int nbd_start_device(struct nbd_device *nbd)
>>          nbd_dev_dbg_init(nbd);
>>          for (i = 0; i < num_connections; i++) {
>>                  struct recv_thread_args *args;
>> -
>> -               args = kzalloc(sizeof(*args), GFP_KERNEL);
>> +
>> +               if (i == 1) {
>> +                       args = NULL;
>> +                       printk("%s: inject malloc error\n", __func__);
>> +               }
>> +               else
>> +                       args = kzalloc(sizeof(*args), GFP_KERNEL);
>> 2. Inject delay in recv_work
>> @@ -757,6 +760,8 @@ static void recv_work(struct work_struct *work)
>>
>>                  blk_mq_complete_request(blk_mq_rq_from_pdu(cmd));
>>          }
>> +       printk("%s: comm=%s pid=%d\n", __func__, current->comm, current->pid);
>> +       mdelay(5 * 1000);
>>          nbd_config_put(nbd);
>>          atomic_dec(&config->recv_threads);
>>          wake_up(&config->recv_wq);
>> 3. Create nbd server
>> nbd-server 8000 /tmp/disk
>> 4. Create nbd client
>> nbd-client localhost 8000 /dev/nbd1
>> Then will trigger above issue.
>>
>> Reason is when add delay in recv_work, lead to relase the last reference
>> of 'nbd->config_refs'. nbd_config_put will call flush_workqueue to make
>> all work finish. Obviously, it will lead to deadloop.
>> To solve this issue, we must ensure 'recv_work' all exit before release
>> the last 'nbd->config_refs' reference count.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> This isn't the way to fix this.  The crux of the problem is the fact that we
> destroy the recv_workq at config time anyway, since it is tied to the nbd
> device.
>
> Fix this instead by getting rid of that, and have the nbd device teardown the
> recv_workq when we destory the nbd device.  Alloc it on device allocation and
> stop alloc'ing it with the config.  That way we don't have this weird thing
> where we need recv threads to drop their config before the last thing.
>
> And while you're at it would you fix recv_work() so it doesn't modify config
> after it drops it's reference?  Thanks,
>
> Josef
> .
Thank you for your reply, I'll make another patch according to your 
suggestion.

