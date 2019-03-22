Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CA8C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 12:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B1C2070D
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 12:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfCVMCE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:02:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:27517 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387966AbfCVMCD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 05:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="127695300"
Received: from mdziegie-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.237.143.1])
  by orsmga008.jf.intel.com with ESMTP; 22 Mar 2019 05:01:59 -0700
Subject: Re: [RFC PATCH] lightnvm: add mechanism to trigger pblk close on
 reboot
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <1553096315-11128-1-git-send-email-marcin.dziegielewski@intel.com>
 <3925EE02-8AE8-4F99-BF85-A73B195C601C@javigon.com>
From:   Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Message-ID: <45ed5eee-ec10-5fa3-fda2-33f413d68ced@intel.com>
Date:   Fri, 22 Mar 2019 13:01:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <3925EE02-8AE8-4F99-BF85-A73B195C601C@javigon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/21/19 10:32 AM, Javier González wrote:
>> On 20 Mar 2019, at 16.38, Marcin Dziegielewski <marcin.dziegielewski@intel.com> wrote:
>>
>> Currently if we issue reboot to the system pblk will close
>> ungracefully and in consequence it will need recovery on load.
>>
>> This patch propose utilize of reboot notifier feature to trigger
>> gracefull pblk shutdown on reboot.
>>
>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>> ---
>> drivers/lightnvm/core.c | 64 +++++++++++++++++++++++++++++++++++++++----------
>> 1 file changed, 51 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 5f82036..5488051 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -27,6 +27,7 @@
>> #include <linux/miscdevice.h>
>> #include <linux/lightnvm.h>
>> #include <linux/sched/sysctl.h>
>> +#include <linux/reboot.h>
>>
>> static LIST_HEAD(nvm_tgt_types);
>> static DECLARE_RWSEM(nvm_tgtt_lock);
>> @@ -1138,6 +1139,48 @@ struct nvm_dev *nvm_alloc_dev(int node)
>> }
>> EXPORT_SYMBOL(nvm_alloc_dev);
>>
>> +static void _nvm_unregister(struct nvm_dev *dev, bool graceful)
>> +{
>> +	struct nvm_target *t, *tmp;
>> +
>> +	mutex_lock(&dev->mlock);
>> +	list_for_each_entry_safe(t, tmp, &dev->targets, list) {
>> +		if (t->dev->parent != dev)
>> +			continue;
>> +		__nvm_remove_target(t, graceful);
>> +	}
>> +	mutex_unlock(&dev->mlock);
>> +
>> +	list_del(&dev->devices);
>> +
>> +	nvm_free(dev);
>> +}
>> +
>> +static int nvm_notify_reboot(struct notifier_block *this,
>> +			    unsigned long code, void *x)
>> +{
>> +	struct nvm_dev *dev, *t;
>> +
>> +	down_write(&nvm_lock);
>> +	if (list_empty(&nvm_devices)) {
>> +		up_write(&nvm_lock);
>> +		return NOTIFY_DONE;
>> +	}
>> +
>> +	list_for_each_entry_safe(dev, t, &nvm_devices, devices)
>> +		_nvm_unregister(dev, true);
>> +
>> +	up_write(&nvm_lock);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block nvm_notifier = {
>> +	.notifier_call	= nvm_notify_reboot,
>> +	.next		= NULL,
>> +	.priority	= INT_MAX, /* before any real devices */
> 
> Why this priority?

I believe that is the safest priority for our case, I based on bcache 
approach. Should I use other priority?

>> +};
>> +
>> int nvm_register(struct nvm_dev *dev)
>> {
>> 	int ret, exp_pool_size;
>> @@ -1161,8 +1204,11 @@ int nvm_register(struct nvm_dev *dev)
>> 		return -ENOMEM;
>> 	}
>>
>> -	/* register device with a supported media manager */
>> 	down_write(&nvm_lock);
>> +	if (list_empty(&nvm_devices))
>> +		register_reboot_notifier(&nvm_notifier);
>> +
>> +	/* register device with a supported media manager */
>> 	list_add(&dev->devices, &nvm_devices);
>> 	up_write(&nvm_lock);
>>
>> @@ -1172,21 +1218,13 @@ int nvm_register(struct nvm_dev *dev)
>>
>> void nvm_unregister(struct nvm_dev *dev)
>> {
>> -	struct nvm_target *t, *tmp;
>> +	down_write(&nvm_lock);
>>
>> -	mutex_lock(&dev->mlock);
>> -	list_for_each_entry_safe(t, tmp, &dev->targets, list) {
>> -		if (t->dev->parent != dev)
>> -			continue;
>> -		__nvm_remove_target(t, false);
>> -	}
>> -	mutex_unlock(&dev->mlock);
>> +	_nvm_unregister(dev, false);
> 
> You are adding an extra lock dependency here. I cannot see any obvious
> problem with it, but you probably want to test this with lock debugging
> enabled.

It was good suggestion, thanks. With enabled lock debugging I have found
one potential deadlock, I will send second version of this patch.

> 
>>
>> -	down_write(&nvm_lock);
>> -	list_del(&dev->devices);
>> +	if (list_empty(&nvm_devices))
>> +		unregister_reboot_notifier(&nvm_notifier);
>> 	up_write(&nvm_lock);
>> -
>> -	nvm_free(dev);
>> }
>> EXPORT_SYMBOL(nvm_unregister);
>>
>> --
>> 1.8.3.1
> 
> Otherwise, I think adding this functionality is beneficial.
> 
> 
