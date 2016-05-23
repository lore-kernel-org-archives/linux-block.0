Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36380 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044AbcEWNo7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 23 May 2016 09:44:59 -0400
MIME-Version: 1.0
In-Reply-To: <5742F686.7050408@lightnvm.io>
References: <1463994814-3388-1-git-send-email-wwtao0320@163.com>
	<1463994814-3388-2-git-send-email-wwtao0320@163.com>
	<5742CA7F.4030000@lightnvm.io>
	<CACygaLCjhH=JKMJ=cML=LUb4=jvwqq_9P2ay-YGr376aLgZiVg@mail.gmail.com>
	<5742F686.7050408@lightnvm.io>
Date: Mon, 23 May 2016 21:31:34 +0800
Message-ID: <CACygaLCVipKvso0=w57V+ML6HXsC9rjfspYy6JT6Z5Me0uswPw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] lightnvm: Append device name to target name
From: Wenwei Tao <ww.tao0320@gmail.com>
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: Wenwei Tao <wwtao0320@163.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Eh.. my lock patch can only prevent concurrent creation of the same
name target on the same backend device, not the concurrent creation of
same name target on different backend devices, since target management
is protect by per  device's gn->lock not
the global nvm_lock now.

2016-05-23 20:24 GMT+08:00 Matias Bjørling <mb@lightnvm.io>:
> On 05/23/2016 01:05 PM, Wenwei Tao wrote:
>>
>> 2016-05-23 17:16 GMT+08:00 Matias Bjørling <mb@lightnvm.io>:
>>>
>>> On 05/23/2016 11:13 AM, Wenwei Tao wrote:
>>>>
>>>>
>>>> From: Wenwei Tao <ww.tao0320@gmail.com>
>>>>
>>>> We may create targets with same name on different
>>>> backend devices, this is not what we want, so append
>>>> the device name to target name to make the new target
>>>> name unique in the system.
>>>>
>>>> Signed-off-by: Wenwei Tao <ww.tao0320@gmail.com>
>>>> ---
>>>>    drivers/lightnvm/gennvm.c | 13 +++++++++++--
>>>>    1 file changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
>>>> index 39ff0af..ecb09cb 100644
>>>> --- a/drivers/lightnvm/gennvm.c
>>>> +++ b/drivers/lightnvm/gennvm.c
>>>> @@ -43,9 +43,18 @@ static int gen_create_tgt(struct nvm_dev *dev, struct
>>>> nvm_ioctl_create *create)
>>>>          struct gendisk *tdisk;
>>>>          struct nvm_tgt_type *tt;
>>>>          struct nvm_target *t;
>>>> +       char tgtname[DISK_NAME_LEN];
>>>>          void *targetdata;
>>>>          int ret = -ENOMEM;
>>>>
>>>> +       if (strlen(dev->name) + strlen(create->tgtname) + 1 >
>>>> DISK_NAME_LEN) {
>>>> +               pr_err("nvm: target name too long. %s:%s\n",
>>>> +                               dev->name, create->tgtname);
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       sprintf(tgtname, "%s%s", dev->name, create->tgtname);
>>>> +
>>>>          tt = nvm_find_target_type(create->tgttype, 1);
>>>>          if (!tt) {
>>>>                  pr_err("nvm: target type %s not found\n",
>>>> create->tgttype);
>>>> @@ -53,7 +62,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct
>>>> nvm_ioctl_create *create)
>>>>          }
>>>>
>>>>          mutex_lock(&gn->lock);
>>>> -       t = gen_find_target(gn, create->tgtname);
>>>> +       t = gen_find_target(gn, tgtname);
>>>>          if (t) {
>>>>                  pr_err("nvm: target name already exists.\n");
>>>>                  ret = -EINVAL;
>>>> @@ -73,7 +82,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct
>>>> nvm_ioctl_create *create)
>>>>          if (!tdisk)
>>>>                  goto err_queue;
>>>>
>>>> -       sprintf(tdisk->disk_name, "%s", create->tgtname);
>>>> +       sprintf(tdisk->disk_name, "%s", tgtname);
>>>>          tdisk->flags = GENHD_FL_EXT_DEVT;
>>>>          tdisk->major = 0;
>>>>          tdisk->first_minor = 0;
>>>>
>>>
>>> Hi Wenwei, what about the case where a target instance has multiple
>>> devices
>>> associated?
>>>
>> You mean a target may be build on multiple backend devices ?
>
>
> Yes. Over time, we want a single target to manage many devices.
>
>>
>>> I am okay with having the user choosing a unique name for the target to
>>> be
>>> exposed.
>>
>> You mean user should check the name before create the target?
>
>
> Sure. It is him that decides the name of the device. Your lock patch fixes
> the panic that could happen. I am happy with that.
>
>
>> Before move target mgmt into media mgr, that would be okay(after apply
>> lightnvm: hold lock until finish the target creation), since all
>> targets are in the global list.
>> Now consider below case:
>> There are two users A and B. A want to create target test0 upon
>> device0 B want to create test0 upon device1,
>> before creation they both check whether test0 is exist (e.g. by list
>> /dev/test0) , they all find test0 is not exist now, and they continue
>> their
>> creation. Both of them use disk name test0 to call add_disk, that
>> would cause panic.
>>
>
