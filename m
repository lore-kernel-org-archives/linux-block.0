Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB697C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 10:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CAC2085A
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 10:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="g8TQ+ryy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfCYKuC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:50:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37524 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYKuC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 06:50:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id v21so7084567edq.4
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 03:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OR+3RusBPPM7ADh+cvGXBNi+2P2lEAASTqZge2IkoVo=;
        b=g8TQ+ryyVd+FLiSQqHJerDUG8BM4vhUAc80GqQceaX+Kyiwh5yT4Ob1JLKjBGrCfh6
         hqy8MDHzCbv2dnikoHLG13w2Vr+HC5sjyQVZwDbYyt2MNaqaCAuKbBfI9KnzTIeGizMp
         aI+7JlVFSg3CLCcWcL1zUYPh1H+5sSLlr6gIgwJJ6UIkmHP5iYlMay8ADvdq5JWxPqll
         J5gZVhK/BSmAqNQPwtRxXeV+84bXh5a4Fk+bivenkbqU1M2Am+yZZXNGyNwAkWbsIClO
         mKtIarbC/onlXaT9gWA2DCnxATVzAKhOgLNqaOFFFKdBhj6k87+awUtsElp7KZcx02Xw
         ThVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OR+3RusBPPM7ADh+cvGXBNi+2P2lEAASTqZge2IkoVo=;
        b=bHESV03lRgKLmr3PzcokGVrgtHxLszjarB+bdsvYDO15Z9PB3RvQdLwXeXASkHlVZx
         8oGo69sHyXYVlZxUX8ynDZxEFjX512wWF5JviyOxLzi7Ixfp4oFpj7PnkOmNxdOCAovu
         6XldYgiblpI2lad1Y5KwiSZkCXGVGTtFWg2rO1ItEwkuV461tkqcq3EXHpb0YW/s4kG5
         V3ZflMxCp/+1eMm8t/0vixIjgxS64se5654dMwCj7e00K+H7t2EjQZjpEm0D9tIdfut0
         ytvuWjH5izeFbfhyjC9m+OirtIX4ypAm6H1YrsRtmjCGKkrTSnaGZMNft9yVttpLAx2L
         ruAQ==
X-Gm-Message-State: APjAAAWvKzKzbEj0Z77z1fzSTre37FAE/1L4ul8EpiCg7FaM5Vj0g+ku
        uVKnlD5DtOYprI0uPY+4ecSTxQ==
X-Google-Smtp-Source: APXvYqx2eHPIhoUsDmFQtEwo8Y5ZWAUBZ7Vo1pqPB8pHky6bbEvNqgT4UckJp6eC5Q2Mm4ia0bYzqg==
X-Received: by 2002:a17:906:a85a:: with SMTP id dx26mr13168927ejb.206.1553510999769;
        Mon, 25 Mar 2019 03:49:59 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id z39sm2900385edz.26.2019.03.25.03.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 03:49:58 -0700 (PDT)
Subject: Re: [RFC PATCH v2] lightnvm: add mechanism to trigger pblk close on
 reboot
To:     Hans Holmberg <hans@owltronix.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Cc:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>
References: <1553278047-13115-1-git-send-email-marcin.dziegielewski@intel.com>
 <CANr-nt2jvcbtxMC8LLqkKikKEUkdiZE1jT-oEw-sghY5-VGnOA@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5f79c149-2b41-83db-bfd6-366775a8242c@lightnvm.io>
Date:   Mon, 25 Mar 2019 11:49:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt2jvcbtxMC8LLqkKikKEUkdiZE1jT-oEw-sghY5-VGnOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/19 11:11 AM, Hans Holmberg wrote:
> On Fri, Mar 22, 2019 at 7:07 PM Marcin Dziegielewski
> <marcin.dziegielewski@intel.com> wrote:
>>
>> Currently if we issue reboot to the system pblk will close
>> ungracefully and in consequence it will need recovery on load.
>>
>> This patch propose utilize of reboot notifier feature to trigger
>> gracefull pblk shutdown on reboot.
> 
> 
> To put in my two-penny worth, this seems unmotivated.
> 
> If user-land chooses to reboot, why should we delay the reboot in the
> order of second(s)?
> Recovering should be faster than padding anyway, so why not take the hit there?
> 
> Also, It's nice to be able to test OOB recovery by just rebooting the
> system, and I have not found this sort of thing being done anywhere
> else in the block layer.
> 
> / Hans

I believe this is taken care of in user-space. E.g., /etc/rc0.d/ has all 
the scripts to properly close down file-systems, device mappers, etc. 
This should be handled at the distribution level.

>>
>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>> ---
>>   drivers/lightnvm/core.c | 65 ++++++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 51 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 5f82036..4a421f5 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/miscdevice.h>
>>   #include <linux/lightnvm.h>
>>   #include <linux/sched/sysctl.h>
>> +#include <linux/reboot.h>
>>
>>   static LIST_HEAD(nvm_tgt_types);
>>   static DECLARE_RWSEM(nvm_tgtt_lock);
>> @@ -1138,9 +1139,52 @@ struct nvm_dev *nvm_alloc_dev(int node)
>>   }
>>   EXPORT_SYMBOL(nvm_alloc_dev);
>>
>> +static void _nvm_unregister(struct nvm_dev *dev, bool graceful)
>> +{
>> +       struct nvm_target *t, *tmp;
>> +
>> +       mutex_lock(&dev->mlock);
>> +       list_for_each_entry_safe(t, tmp, &dev->targets, list) {
>> +               if (t->dev->parent != dev)
>> +                       continue;
>> +               __nvm_remove_target(t, graceful);
>> +       }
>> +       mutex_unlock(&dev->mlock);
>> +
>> +       list_del(&dev->devices);
>> +
>> +       nvm_free(dev);
>> +}
>> +
>> +static int nvm_notify_reboot(struct notifier_block *this,
>> +                           unsigned long code, void *x)
>> +{
>> +       struct nvm_dev *dev, *t;
>> +
>> +       down_write(&nvm_lock);
>> +       if (list_empty(&nvm_devices)) {
>> +               up_write(&nvm_lock);
>> +               return NOTIFY_DONE;
>> +       }
>> +
>> +       list_for_each_entry_safe(dev, t, &nvm_devices, devices)
>> +               _nvm_unregister(dev, true);
>> +
>> +       up_write(&nvm_lock);
>> +
>> +       return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block nvm_notifier = {
>> +       .notifier_call  = nvm_notify_reboot,
>> +       .next           = NULL,
>> +       .priority       = INT_MAX, /* before any real devices */
>> +};
>> +
>>   int nvm_register(struct nvm_dev *dev)
>>   {
>>          int ret, exp_pool_size;
>> +       bool is_first;
>>
>>          if (!dev->q || !dev->ops)
>>                  return -EINVAL;
>> @@ -1161,32 +1205,25 @@ int nvm_register(struct nvm_dev *dev)
>>                  return -ENOMEM;
>>          }
>>
>> -       /* register device with a supported media manager */
>>          down_write(&nvm_lock);
>> +       is_first = list_empty(&nvm_devices);
>> +
>> +       /* register device with a supported media manager */
>>          list_add(&dev->devices, &nvm_devices);
>>          up_write(&nvm_lock);
>>
>> +       if (is_first)
>> +               register_reboot_notifier(&nvm_notifier);
>> +
>>          return 0;
>>   }
>>   EXPORT_SYMBOL(nvm_register);
>>
>>   void nvm_unregister(struct nvm_dev *dev)
>>   {
>> -       struct nvm_target *t, *tmp;
>> -
>> -       mutex_lock(&dev->mlock);
>> -       list_for_each_entry_safe(t, tmp, &dev->targets, list) {
>> -               if (t->dev->parent != dev)
>> -                       continue;
>> -               __nvm_remove_target(t, false);
>> -       }
>> -       mutex_unlock(&dev->mlock);
>> -
>>          down_write(&nvm_lock);
>> -       list_del(&dev->devices);
>> +       _nvm_unregister(dev, false);
>>          up_write(&nvm_lock);
>> -
>> -       nvm_free(dev);
>>   }
>>   EXPORT_SYMBOL(nvm_unregister);
>>
>> --
>> 1.8.3.1
>>

