Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAC2C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44F52077C
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfDWHSL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:18:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:33834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDWHSL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:18:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3DA3AD1A;
        Tue, 23 Apr 2019 07:18:09 +0000 (UTC)
Subject: Re: [RFC PATCH v2 15/16] bcache: improve bcache_reboot()
To:     Hannes Reinecke <hare@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-16-colyli@suse.de>
 <2ae959a2-bb2a-34cf-1dd4-dd7c6f06a0d2@suse.de>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <f4ca2eaa-4b27-f282-b2a2-441e9c3bb4d6@suse.de>
Date:   Tue, 23 Apr 2019 15:18:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2ae959a2-bb2a-34cf-1dd4-dd7c6f06a0d2@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/4/23 3:13 下午, Hannes Reinecke wrote:
> On 4/19/19 6:05 PM, Coly Li wrote:
>> This patch tries to release mutex bch_register_lock early, to give
>> chance to stop cache set and bcache device early.
>>
>> This patch also expends time out of stopping all bcache device from
>> 2 seconds to 10 seconds, because stopping writeback rate update worker
>> may delay for 5 seconds, 2 seconds is not enough.
>>
>> After this patch applied, stopping bcache devices during system reboot
>> or shutdown is very hard to be observed any more.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> ---
>>   drivers/md/bcache/super.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index e988e46a6479..2d377a4a182f 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -2453,10 +2453,13 @@ static int bcache_reboot(struct notifier_block
>> *n, unsigned long code, void *x)
>>           list_for_each_entry_safe(dc, tdc, &uncached_devices, list)
>>               bcache_device_stop(&dc->disk);
>>   +        mutex_unlock(&bch_register_lock);
>> +
>>           /* What's a condition variable? */
>>           while (1) {
>> -            long timeout = start + 2 * HZ - jiffies;
>> +            long timeout = start + 10 * HZ - jiffies;
>>   +            mutex_lock(&bch_register_lock);
>>               stopped = list_empty(&bch_cache_sets) &&
>>                   list_empty(&uncached_devices);
>>   @@ -2468,7 +2471,6 @@ static int bcache_reboot(struct notifier_block
>> *n, unsigned long code, void *x)
>>                 mutex_unlock(&bch_register_lock);
>>               schedule_timeout(timeout);
>> -            mutex_lock(&bch_register_lock);
>>           }
>>             finish_wait(&unregister_wait, &wait);
>> Maybe you should even call 'schedule()' after the first mutex_unlock() 
> to force execution of other tasks.
> But anyway:
> 

Hi Hannes,

It makes sense for an explicit schedule(). I will add it in next
version. Thanks.


> Reviewed-by: Hannes Reinecke <hare@suse.com>
> 
> Cheers,
> 
> Hannes


-- 

Coly Li
