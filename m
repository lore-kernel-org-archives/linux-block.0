Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E66EC7EE2D
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 04:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjEYECx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 00:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjEYECv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 00:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B5483
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684987326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCerHac62JvlOiz3RRBeoQjGK8ozIWRHElJCCYu4sgo=;
        b=NSabuYJPElSA0AKDFNbzk5QteVU9f8zTZ8r5ZsdwAOw7rk4qvke6R6NmndAtk++PfrAFf4
        LWrpUNVoHwsctCv+SkBjxbaxR5XM60QY1onfoW21Qo4N8dmXP1pMi/PWU8B43R00g7FAo+
        K+HXi1girmprkfKRsuz9kY/hq59H6Fk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-bC9lGirFMlWF23G7T4qR_A-1; Thu, 25 May 2023 00:02:02 -0400
X-MC-Unique: bC9lGirFMlWF23G7T4qR_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0481C80027F;
        Thu, 25 May 2023 04:02:02 +0000 (UTC)
Received: from [10.22.17.224] (unknown [10.22.17.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F12E200B401;
        Thu, 25 May 2023 04:02:01 +0000 (UTC)
Message-ID: <eb88c7a5-e29d-9ab1-93db-544aeabcc90c@redhat.com>
Date:   Thu, 25 May 2023 00:02:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2] blk-cgroup: Flush stats before releasing blkcg_gq
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, mkoutny@suse.com,
        Yosry Ahmed <yosryahmed@google.com>
References: <20230524035150.727407-1-ming.lei@redhat.com>
 <f2c10b18-8d83-91a5-bf22-03894bf3c910@redhat.com>
 <ZG2R+jYuAZMpx49d@ovpn-8-17.pek2.redhat.com>
 <76a863b4-112e-82ae-59e4-6326fff48ffc@redhat.com>
 <bde4174a-ace4-6e2a-6536-855fb18d0890@redhat.com>
 <ZG7CJtN7ATaYZ5Ao@ovpn-8-21.pek2.redhat.com>
 <7ffbb748-46e3-44b2-388d-9199f47dc9a7@redhat.com>
 <ZG7aZF8T+I0DjNw9@ovpn-8-21.pek2.redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZG7aZF8T+I0DjNw9@ovpn-8-21.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 5/24/23 23:47, Ming Lei wrote:
> On Wed, May 24, 2023 at 10:50:29PM -0400, Waiman Long wrote:
>> On 5/24/23 22:04, Ming Lei wrote:
>>> On Wed, May 24, 2023 at 01:28:41PM -0400, Waiman Long wrote:
>>>> On 5/24/23 11:43, Waiman Long wrote:
>>>>
>>> llist_del_all() moves all 'bis' into one local list, and bis is one percpu
>>> variable of blkg, so in theory same bis won't be flushed at the same
>>> time. And one bis should be touched in just one of stat flush code path
>>> because of llist_del_all().
>>>
>>> So 'bis' still can be thought as being flushed in serialized way.
>>>
>>> However, blk_cgroup_bio_start() runs concurrently with blkcg_rstat_flush(),
>>> so once bis->lqueued is cleared in blkcg_rstat_flush(), this same bis
>>> could be added to the percpu llist and __blkcg_rstat_flush() from blkg_release()
>>> follows. This should be the only chance for concurrent stats update.
>> That is why I have in mind. A __blkcg_rstat_flush() can be from
>> blkg_release() and another one from the regular cgroup_rstat_flush*().
> But the two blkg can't be same because blkg_release() is run from rcu
> callback.

I am not talking about the parent blkg which can have a concurrent 
update. It is probably safe at the blkg level, but the lockless list may 
contain another bisc from a blkg that is not being destroyed.


>
>>
>>> But, blkg_release() is run in RCU callback, so the previous flush has
>>> been done, but new flush can come, and other blkg's stat could be added
>>> with same story above.
>>>
>>>> One way to
>>>> avoid that is to synchronize it by cgroup_rstat_cpu_lock. Another way is to
>>>> use the bisc->lqueued for synchronization.
>>> I'd avoid the external cgroup lock here.
>>>
>>>> In that case, you need to move
>>>> WRITE_ONCE(bisc->lqueued, false) in blkcg_rstat_flush() to the end after all
>>>> the  blkcg_iostat_update() call with smp_store_release() and replace the
>>>> READ_ONCE(bis->lqueued) check in blk_cgroup_bio_start() with
>>>> smp_load_acquire().
>>> This way looks doable, but I guess it still can't avoid concurrent update on parent
>>> stat, such as when  __blkcg_rstat_flush() from blkg_release() is
>>> in-progress, another sibling blkg's bis is added, meantime
>>> blkcg_rstat_flush() is called.
>> I realized that the use of cgroup_rstat_cpu_lock or the alternative was not
>> safe enough for preventing concurrent parent blkg rstat update.
> Indeed.
>
>>> Another way is to add blkcg->stat_lock for covering __blkcg_rstat_flush(), what
>>> do you think of this way?
>> I am thinking of adding a raw spinlock into blkg and take it when doing
>> blkcg_iostat_update(). This can guarantee no concurrent update to rstat
>> data. It has to be a raw spinlock as it will be under the
>> cgroup_rstat_cpu_lock raw spinlock.
> We still need to be careful since both child and parent are updated
> in the following blkcg_iostat_update().
>
>                  if (parent && parent->parent)
>                          blkcg_iostat_update(parent, &blkg->iostat.cur,
>                                              &blkg->iostat.last);
>
> But the concurrent update on parent blkg can be avoided by holding
> parent->stat_lock only.

That is true. Perhaps we can use Yosry's suggestion of adding a helper 
to acquire and release cgroup_rstat_lock before calling 
__blkcg_rstat_flush(). That will also guarantee no concurrent update.

Cheers,
Longman

