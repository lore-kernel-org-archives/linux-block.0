Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A53DC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 13:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0268B20857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 13:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfCRNSr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:18:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:44609 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfCRNSr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 09:18:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 06:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="126385677"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.164]) ([10.237.142.164])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 06:18:45 -0700
Subject: Re: [PATCH 17/18] lightnvm: allow to use full device path
To:     Hans Holmberg <hans@owltronix.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-18-igor.j.konopko@intel.com>
 <CANr-nt3poAp1NQmK35=X=mrKgvEJnUHVN_ROxMWB1hrGoZpHdQ@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <2683438c-2d8d-c450-8b6f-639d0d757185@intel.com>
Date:   Mon, 18 Mar 2019 14:18:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CANr-nt3poAp1NQmK35=X=mrKgvEJnUHVN_ROxMWB1hrGoZpHdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 18.03.2019 11:28, Hans Holmberg wrote:
> On Thu, Mar 14, 2019 at 5:11 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> This patch adds the possibility to provide full device path (like
>> /dev/nvme0n1) when specifying device on top of which pblk instance
>> should be created/removed.
>>
>> This makes creation of targets from nvme-cli (or other ioctl based
>> tools) more unified with other commands in comparison with current
>> situation where almost all commands uses full device path with except
>> of lightnvm creation/removal parameter which uses just 'nvme0n1'
>> naming convention. After this changes both approach will be valid.
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>>   drivers/lightnvm/core.c | 23 ++++++++++++++++++-----
>>   1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index c01f83b..838c3d8 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -1195,6 +1195,21 @@ void nvm_unregister(struct nvm_dev *dev)
>>   }
>>   EXPORT_SYMBOL(nvm_unregister);
>>
>> +#define PREFIX_STR "/dev/"
>> +static void nvm_normalize_path(char *path)
>> +{
>> +       path[DISK_NAME_LEN - 1] = '\0';
>> +       if (!memcmp(PREFIX_STR, path,
>> +                               sizeof(char) * strlen(PREFIX_STR))) {
>> +               /*
>> +                * User provide name in '/dev/nvme0n1' format,
>> +                * so we need to skip '/dev/' for comparison
>> +                */
>> +               memmove(path, path + sizeof(char) * strlen(PREFIX_STR),
>> +                       (DISK_NAME_LEN - strlen(PREFIX_STR)) * sizeof(char));
>> +       }
>> +}
>> +
> 
> I don't like this. Why add string parsing to the kernel? Can't this
> feature be added to the nvme tool?

Since during target creation/removal in kernel, we already operate on 
strings multiple times (strcmp calls for target types, nvme device, 
target names) my idea was to keep this in the same layer too.

> 
>>   static int __nvm_configure_create(struct nvm_ioctl_create *create)
>>   {
>>          struct nvm_dev *dev;
>> @@ -1304,9 +1319,9 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
>>                  return -EINVAL;
>>          }
>>
>> -       create.dev[DISK_NAME_LEN - 1] = '\0';
>> +       nvm_normalize_path(create.dev);
>> +       nvm_normalize_path(create.tgtname);
>>          create.tgttype[NVM_TTYPE_NAME_MAX - 1] = '\0';
>> -       create.tgtname[DISK_NAME_LEN - 1] = '\0';
>>
>>          if (create.flags != 0) {
>>                  __u32 flags = create.flags;
>> @@ -1333,7 +1348,7 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
>>          if (copy_from_user(&remove, arg, sizeof(struct nvm_ioctl_remove)))
>>                  return -EFAULT;
>>
>> -       remove.tgtname[DISK_NAME_LEN - 1] = '\0';
>> +       nvm_normalize_path(remove.tgtname);
>>
>>          if (remove.flags != 0) {
>>                  pr_err("nvm: no flags supported\n");
>> @@ -1373,8 +1388,6 @@ static long nvm_ioctl_dev_factory(struct file *file, void __user *arg)
>>          if (copy_from_user(&fact, arg, sizeof(struct nvm_ioctl_dev_factory)))
>>                  return -EFAULT;
>>
>> -       fact.dev[DISK_NAME_LEN - 1] = '\0';
>> -
>>          if (fact.flags & ~(NVM_FACTORY_NR_BITS - 1))
>>                  return -EINVAL;
>>
>> --
>> 2.9.5
>>
