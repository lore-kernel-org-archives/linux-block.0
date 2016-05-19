Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:33758 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbcESPTi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 19 May 2016 11:19:38 -0400
MIME-Version: 1.0
In-Reply-To: <573DB4B1.1050501@lightnvm.io>
References: <1463639921-1824-1-git-send-email-wwtao0320@163.com>
	<1463639921-1824-2-git-send-email-wwtao0320@163.com>
	<573DB4B1.1050501@lightnvm.io>
Date: Thu, 19 May 2016 23:19:36 +0800
Message-ID: <CACygaLACBmg_gu1FB8fbbBSYL_EP=xHbMaeqWsasoH88M8EgdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] lightnvm: hold nvm_lock until finish the target creation
From: Wenwei Tao <ww.tao0320@gmail.com>
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: Wenwei Tao <wwtao0320@163.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Okay, I will rebase it on for-4.8/core.

2016-05-19 20:42 GMT+08:00 Matias Bjørling <mb@lightnvm.io>:
> On 05/19/2016 08:38 AM, Wenwei Tao wrote:
>>
>> From: Wenwei Tao <ww.tao0320@gmail.com>
>>
>> When create a target, we check whether the target is
>> already exist first. If the answer is no, we release
>> the lock and continue the creation. This cannot prevent
>> concurrent creation of the same target, so hold the lock
>> until finish the target creation.
>>
>> Signed-off-by: Wenwei Tao <ww.tao0320@gmail.com>
>> ---
>>   drivers/lightnvm/core.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 160c1a6..a622081 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -791,6 +791,7 @@ static int nvm_create_target(struct nvm_dev *dev,
>>         struct nvm_tgt_type *tt;
>>         struct nvm_target *t;
>>         void *targetdata;
>> +       int ret = -ENOMEM;
>>
>>         if (!dev->mt) {
>>                 pr_info("nvm: device has no media manager registered.\n");
>> @@ -801,21 +802,20 @@ static int nvm_create_target(struct nvm_dev *dev,
>>         tt = nvm_find_target_type(create->tgttype);
>>         if (!tt) {
>>                 pr_err("nvm: target type %s not found\n",
>> create->tgttype);
>> -               up_write(&nvm_lock);
>> -               return -EINVAL;
>> +               ret = -EINVAL;
>> +               goto err_unlock;
>>         }
>>
>>         t = nvm_find_target(create->tgtname);
>>         if (t) {
>>                 pr_err("nvm: target name already exists.\n");
>> -               up_write(&nvm_lock);
>> -               return -EINVAL;
>> +               ret = -EINVAL;
>> +               goto err_unlock;
>>         }
>> -       up_write(&nvm_lock);
>>
>>         t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
>>         if (!t)
>> -               return -ENOMEM;
>> +               goto err_unlock;
>>
>>         tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
>>         if (!tqueue)
>> @@ -848,8 +848,6 @@ static int nvm_create_target(struct nvm_dev *dev,
>>         t->type = tt;
>>         t->disk = tdisk;
>>         t->dev = dev;
>> -
>> -       down_write(&nvm_lock);
>>         list_add_tail(&t->list, &nvm_targets);
>>         up_write(&nvm_lock);
>>
>> @@ -860,7 +858,9 @@ err_queue:
>>         blk_cleanup_queue(tqueue);
>>   err_t:
>>         kfree(t);
>> -       return -ENOMEM;
>> +err_unlock:
>> +       up_write(&nvm_lock);
>> +       return ret;
>>   }
>>
>>   static int __nvm_configure_create(struct nvm_ioctl_create *create)
>>
>
> Thanks. There is a couple of patches in the for-4.8/core that moves this
> logic to the gennvm media manager. Could you rebase this on top?
