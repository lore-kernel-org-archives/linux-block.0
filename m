Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F1C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F8A2077C
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfDWHPe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:15:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:33496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfDWHPe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:15:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4B2BAD17;
        Tue, 23 Apr 2019 07:15:31 +0000 (UTC)
Subject: Re: [RFC PATCH v2 12/16] bcache: add pendings_cleanup to stop pending
 bcache device
To:     Hannes Reinecke <hare@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-13-colyli@suse.de>
 <96814d71-8359-35a7-524d-6a4a3d8002fa@suse.de>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <45840731-be97-3917-cbc6-63dd76c8ff1b@suse.de>
Date:   Tue, 23 Apr 2019 15:15:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <96814d71-8359-35a7-524d-6a4a3d8002fa@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/4/23 3:08 下午, Hannes Reinecke wrote:
> On 4/19/19 6:05 PM, Coly Li wrote:
>> If a bcache device is in dirty state and its cache set is not
>> registered, this bcache deivce will not appear in /dev/bcache<N>,
>> and there is no way to stop it or remove the bcache kernel module.
>>
>> This is an as-designed behavior, but sometimes people has to reboot
>> whole system to release or stop the pending backing device.
>>
>> This sysfs interface may remove such pending bcache devices when
>> write anything into the sysfs file manually.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> ---
>>   drivers/md/bcache/super.c | 55
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index 9b41e0b62cc0..e988e46a6479 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -2246,9 +2246,13 @@ static int register_cache(struct cache_sb *sb,
>> struct page *sb_page,
>>     static ssize_t register_bcache(struct kobject *k, struct
>> kobj_attribute *attr,
>>                      const char *buffer, size_t size);
>> +static ssize_t bch_pending_bdevs_cleanup(struct kobject *k,
>> +                     struct kobj_attribute *attr,
>> +                     const char *buffer, size_t size);
>>     kobj_attribute_write(register,        register_bcache);
>>   kobj_attribute_write(register_quiet,    register_bcache);
>> +kobj_attribute_write(pendings_cleanup,    bch_pending_bdevs_cleanup);
>>     static bool bch_is_open_backing(struct block_device *bdev)
>>   {
>> @@ -2373,6 +2377,56 @@ static ssize_t register_bcache(struct kobject
>> *k, struct kobj_attribute *attr,
>>       goto out;
>>   }
>>   +
>> +struct pdev {
>> +    struct list_head list;
>> +    struct cached_dev *dc;
>> +};
>> +
>> +static ssize_t bch_pending_bdevs_cleanup(struct kobject *k,
>> +                     struct kobj_attribute *attr,
>> +                     const char *buffer,
>> +                     size_t size)
>> +{
>> +    LIST_HEAD(pending_devs);
>> +    ssize_t ret = size;
>> +    struct cached_dev *dc, *tdc;
>> +    struct pdev *pdev, *tpdev;
>> +    struct cache_set *c, *tc;
>> +
>> +    mutex_lock(&bch_register_lock);
>> +    list_for_each_entry_safe(dc, tdc, &uncached_devices, list) {
>> +        pdev = kmalloc(sizeof(struct pdev), GFP_KERNEL);
>> +        if (!pdev)
>> +            break;
>> +        pdev->dc = dc;
>> +        list_add(&pdev->list, &pending_devs);
>> +    }
>> +
>> +    list_for_each_entry_safe(pdev, tpdev, &pending_devs, list) {
>> +        list_for_each_entry_safe(c, tc, &bch_cache_sets, list) {
>> +            char *pdev_set_uuid = pdev->dc->sb.set_uuid;
>> +            char *set_uuid = c->sb.uuid;
>> +
>> +            if (!memcmp(pdev_set_uuid, set_uuid, 16)) {
>> +                list_del(&pdev->list);
>> +                kfree(pdev);
>> +                break;
>> +            }
>> +        }
>> +    }
>> +    mutex_unlock(&bch_register_lock);
>> +
>> +    list_for_each_entry_safe(pdev, tpdev, &pending_devs, list) {
>> +        pr_info("delete pdev %p", pdev);
>> +        list_del(&pdev->list);
>> +        bcache_device_stop(&pdev->dc->disk);
>> +        kfree(pdev);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   static int bcache_reboot(struct notifier_block *n, unsigned long
>> code, void *x)
>>   {
>>       if (code == SYS_DOWN ||
>> @@ -2483,6 +2537,7 @@ static int __init bcache_init(void)
>>       static const struct attribute *files[] = {
>>           &ksysfs_register.attr,
>>           &ksysfs_register_quiet.attr,
>> +        &ksysfs_pendings_cleanup.attr,
>>           NULL
>>       };
>>  
> _Actually_ I would like it better if the bcache device would be present
> in sysfs for these cases, too, albeit in a disabled state.
> That would allow us to remove the device like normal and we wouldn't
> need to worry about yet another interface.

Hi Hannes,

I see. The awkward condition is,
- If only show up the bcache device in /sys/block/bcache<?>/ directory
but not show up in /dev/bcache<?> node, it might be more confused for users.
- If show up both bcache devices in /sys/block/bcache<?> and
/dev/bcache<?>, it means such device can be read/written, but it is
staled (there are dirty data on cache device), which may corrupt
existing data.

So I choose to not change current code behavior and just add a sysfs
interface.

-- 

Coly Li
