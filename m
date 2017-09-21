Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:49807 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbdIULOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 07:14:06 -0400
Received: by mail-wm0-f51.google.com with SMTP id r74so772800wme.4
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2017 04:14:05 -0700 (PDT)
Subject: Re: [PATCH V2] lightnvm: protect target type list with correct locks
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        Rakesh Pandit <rakesh@tuxera.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170916183931.GA2824@hercules.tuxera.com>
 <3891AF6A-D87D-4727-BF9C-E6689C232BC9@lightnvm.io>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <dbbfb813-714b-c0cf-9ecd-454ccbee24ad@lightnvm.io>
Date: Thu, 21 Sep 2017 13:14:03 +0200
MIME-Version: 1.0
In-Reply-To: <3891AF6A-D87D-4727-BF9C-E6689C232BC9@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/18/2017 09:53 AM, Javier González wrote:
>> On 16 Sep 2017, at 20.39, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>
>> nvm_tgt_types list was protected by wrong lock for NVM_INFO ioctl call
>> and can race with addition or removal of target types.  Also
>> unregistering target type was not protected correctly.
>>
>> Fixes: 5cd907853 ("lightnvm: remove nested lock conflict with mm")
>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>> ---
>>
>> V2: also add correct lock while unregistering and fix "Fixes" tag at
>> end.  Note I found these while investigating another issue and
>> skimming the core code but worth fixing.
>>
>> drivers/lightnvm/core.c | 8 ++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 9f9a137..1b8338d 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -589,9 +589,9 @@ void nvm_unregister_tgt_type(struct nvm_tgt_type *tt)
>> 	if (!tt)
>> 		return;
>>
>> -	down_write(&nvm_lock);
>> +	down_write(&nvm_tgtt_lock);
>> 	list_del(&tt->list);
>> -	up_write(&nvm_lock);
>> +	up_write(&nvm_tgtt_lock);
>> }
>> EXPORT_SYMBOL(nvm_unregister_tgt_type);
>>
>> @@ -1190,7 +1190,7 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
>> 	info->version[1] = NVM_VERSION_MINOR;
>> 	info->version[2] = NVM_VERSION_PATCH;
>>
>> -	down_write(&nvm_lock);
>> +	down_write(&nvm_tgtt_lock);
>> 	list_for_each_entry(tt, &nvm_tgt_types, list) {
>> 		struct nvm_ioctl_info_tgt *tgt = &info->tgts[tgt_iter];
>>
>> @@ -1203,7 +1203,7 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
>> 	}
>>
>> 	info->tgtsize = tgt_iter;
>> -	up_write(&nvm_lock);
>> +	up_write(&nvm_tgtt_lock);
>>
>> 	if (copy_to_user(arg, info, sizeof(struct nvm_ioctl_info))) {
>> 		kfree(info);
>> --
>> 2.7.4
> 
> LGTM.
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> 

Thanks Rakesh.
