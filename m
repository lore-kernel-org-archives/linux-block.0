Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1356DC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 10:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1A32084D
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 10:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfCYKKM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:10:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:64363 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbfCYKKM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 06:10:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 03:10:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="155537909"
Received: from mdziegie-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.237.143.1])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2019 03:10:07 -0700
Subject: Re: [RFC PATCH v2] lightnvm: add mechanism to trigger pblk close on
 reboot
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <1553278047-13115-1-git-send-email-marcin.dziegielewski@intel.com>
 <796F80BA-E8ED-4AAC-880D-623C0C245B2A@javigon.com>
From:   Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Message-ID: <3840e896-f269-390b-3e2c-17ac728aaacb@intel.com>
Date:   Mon, 25 Mar 2019 11:10:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <796F80BA-E8ED-4AAC-880D-623C0C245B2A@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/25/19 7:35 AM, Javier González wrote:
>> On 23 Mar 2019, at 02.07, Marcin Dziegielewski <marcin.dziegielewski@intel.com> wrote:
>>
>> Currently if we issue reboot to the system pblk will close
>> ungracefully and in consequence it will need recovery on load.
>>
>> This patch propose utilize of reboot notifier feature to trigger
>> gracefull pblk shutdown on reboot.
>>
>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>> —
> 
> Please, add changes since V1 next time.
Yes, I forgot about it, my mistake.
> 
>> drivers/lightnvm/core.c | 65 ++++++++++++++++++++++++++++++++++++++-----------
>> 1 file changed, 51 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 5f82036..4a421f5 100644
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
>> @@ -1138,9 +1139,52 @@ struct nvm_dev *nvm_alloc_dev(int node)
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
> Nip: Can you align all values at ‘=‘?
Sure, I can change something, but I'm not sure what do you mean? Would 
you describe more explicitly or put example? Thanks in advance.
> 
>> +};
>> +
>> int nvm_register(struct nvm_dev *dev)
>> {
>> 	int ret, exp_pool_size;
>> +	bool is_first;
>>
>> 	if (!dev->q || !dev->ops)
>> 		return -EINVAL;
>> @@ -1161,32 +1205,25 @@ int nvm_register(struct nvm_dev *dev)
>> 		return -ENOMEM;
>> 	}
>>
>> -	/* register device with a supported media manager */
>> 	down_write(&nvm_lock);
>> +	is_first = list_empty(&nvm_devices);
>> +
>> +	/* register device with a supported media manager */
>> 	list_add(&dev->devices, &nvm_devices);
>> 	up_write(&nvm_lock);
>>
>> +	if (is_first)
>> +		register_reboot_notifier(&nvm_notifier);
>> +
>> 	return 0;
>> }
>> EXPORT_SYMBOL(nvm_register);
>>
>> void nvm_unregister(struct nvm_dev *dev)
>> {
>> -	struct nvm_target *t, *tmp;
>> -
>> -	mutex_lock(&dev->mlock);
>> -	list_for_each_entry_safe(t, tmp, &dev->targets, list) {
>> -		if (t->dev->parent != dev)
>> -			continue;
>> -		__nvm_remove_target(t, false);
>> -	}
>> -	mutex_unlock(&dev->mlock);
>> -
>> 	down_write(&nvm_lock);
>> -	list_del(&dev->devices);
>> +	_nvm_unregister(dev, false);
>> 	up_write(&nvm_lock);
>> -
>> -	nvm_free(dev);
>> }
>> EXPORT_SYMBOL(nvm_unregister);
>>
>> --
>> 1.8.3.1
> 
> Otherwise, it looks good to me.
> 
> Reviewed-by: Javier González <javier@javigon.com>
> 
> 
