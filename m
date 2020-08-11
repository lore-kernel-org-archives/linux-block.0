Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54ACC433E0
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 08:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800EC2065C
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 08:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ht50QYP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgHKILs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:11:48 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:42020 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728220AbgHKILs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 04:11:48 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net (myt5-23f0be3aa648.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 24DFC2E1560;
        Tue, 11 Aug 2020 11:11:41 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 0rut9IppPM-Bdv8jECI;
        Tue, 11 Aug 2020 11:11:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1597133501; bh=PuCQppw5yvKWaRbNWfdPn6kPoqPtCT6+wym5Nq8Ag6g=;
        h=Message-ID:Subject:Date:References:To:From:In-Reply-To:Cc;
        b=ht50QYP/VrHri3zUr/kcSrlFy3vne+KR9OjJgf8oON6xmsSoT9z5VCt+D8AjLStPQ
         nSFbXID901Bl9345oVzmzRtxLKAUxeKupwMg8goXnsITBagZZSRIoapcu87s4lWzog
         LCk8I5pIFG5QmtWRmaIda4uHVhUyNuBoNjLwZgAA=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Q47qbSy1my-Bdlm5cof;
        Tue, 11 Aug 2020 11:11:39 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH] bfq: fix blkio cgroup leakage
In-Reply-To: <22087F19-BC93-447E-848A-109392E0622D@linaro.org>
References: <20200702105751.20482-1-dmonakhov@gmail.com> <429E50C6-83BA-4A3F-BE9C-06C7C762AF33@linaro.org> <87k0zdrj7s.fsf@dmws.yandex.net> <545F1ABF-B2B2-4523-9259-D3F93A9BB330@linaro.org> <87h7uhqewn.fsf@dmws.yandex.net> <22087F19-BC93-447E-848A-109392E0622D@linaro.org>
Date:   Tue, 11 Aug 2020 11:11:39 +0300
Message-ID: <87h7t9r490.fsf@dmws.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Paolo Valente <paolo.valente@linaro.org> writes:

>> Il giorno 9 lug 2020, alle ore 10:19, Dmitry Monakhov <dmonakhov@gmail.com> ha scritto:
>> 
>> Paolo Valente <paolo.valente@linaro.org> writes:
>> 
>>>> Il giorno 8 lug 2020, alle ore 19:48, Dmitry Monakhov <dmonakhov@gmail.com> ha scritto:
>>>> 
>>>> Paolo Valente <paolo.valente@linaro.org> writes:
>>>> 
>>>>> Hi,
>>>>> sorry for the delay.  The commit you propose to drop fix the issues
>>>>> reported in [1].
>>>>> 
>>>>> Such a commit does introduce the leak that you report (thank you for
>>>>> spotting it).  Yet, according to the threads mentioned in [1],
>>>>> dropping that commit would take us back to those issues.
>>>>> 
>>>>> Maybe the solution is to fix the unbalance that you spotted?
>>>> I'm not quite shure that do I understand which bug was addressed for commit db37a34c563b.
>>>> AFAIU both bugs mentioned in original patchset was fixed by:
>>>> 478de3380 ("block, bfq: deschedule empty bfq_queues not referred by any proces")
>>>> f718b0932 ( block, bfq: do not plug I/O for bfq_queues with no proc refs)"
>>>> 
>>>> So I review commit db37a34c563b as independent one.
>>>> It introduces extra reference for bfq_groups via bfqg_and_blkg_get(),
>>>> but do we actually need it here?
>>>> 
>>>> #IF CONFIG_BFQ_GROUP_IOSCHED is enabled:
>>>> bfqd->root_group is holded by bfqd from bfq_init_queue()
>>>> other bfq_queue objects are owned by corresponding blkcg from bfq_pd_alloc()
>>>> So bfq_queue can not disappear under us.
>>>> 
>>> 
>>> You are right, but incomplete.  No extra ref is needed for an entity
>>> that represents a bfq_queue.  And this consideration mistook me before
>>> I realized that that commit was needed.  The problem is that an entity
>>> may also represent a group of entities.  In that case no reference is
>>> taken through any bfq_queue.  The commit you want to remove takes this
>>> missing reference.
>> Sorry, It looks like I've mistyped sentance above, I ment to say bfq_group.
>> So here is my statement corrected:
>> #IF CONFIG_BFQ_GROUP_IOSCHED is enabled:
>> bfqd->root_group is holded by bfqd from bfq_init_queue()
>> other *bfq_group* objects are owned by corresponding blkcg, reference get from bfq_pd_alloc()
>> So *bfq_group* can not disappear under us.
>> 
>> So no extra reference is required for entity represents bfq_group. Commit is not required.
>
> No, the entity may remain alive and on some tree after bfq_pd_offline has been invoked.
But  bfq_group's entity stil holded by child's entity from here,
 -> bfq_init_entity()
    ->bfqg_and_blkg_get(bfqg);
    ->entity->parent = bfqg->my_entity

 -> bfq_put_queue(bfqq)
    FINAL_PUT
    ->bfqg_and_blkg_put(bfqq_group(bfqq))
    ->kmem_cache_free(bfq_pool, bfqq);

so group can not just disappear us while tree is in service. Please corect me if I'm wrong.
BTW, I've send new version with updated description here [1]

Footnotes:
[1] https://lore.kernel.org/linux-block/20200811064340.31284-1-dmtrmonakhov@yandex-team.ru
>
> Paolo
>
>>> 
>>> Paolo
>>> 
>>>> #IF CONFIG_BFQ_GROUP_IOSCHED is disabled:
>>>> we have only one  bfqd->root_group object which allocated from bfq_create_group_hierarch()
>>>> and bfqg_and_blkg_get() bfqg_and_blkg_put() are noop
>>>> 
>>>> Resume: in both cases extra reference is not required, so I continue to
>>>> insist that we should revert  commit db37a34c563b because it tries to
>>>> solve a non existing issue, but introduce the real one.
>>>> 
>>>> Please correct me if I'm wrong.
>>>>> 
>>>>> I'll check it ASAP, unless you do it before me.
>>>>> 
>>>>> Thanks,
>>>>> Paolo
>>>>> 
>>>>> [1] https://lkml.org/lkml/2020/1/31/94
>>>>> 
>>>>>> Il giorno 2 lug 2020, alle ore 12:57, Dmitry Monakhov <dmonakhov@gmail.com> ha scritto:
>>>>>> 
>>>>>> commit db37a34c563b ("block, bfq: get a ref to a group when adding it to a service tree")
>>>>>> introduce leak forbfq_group and blkcg_gq objects because of get/put
>>>>>> imbalance. See trace balow:
>>>>>> -> blkg_alloc
>>>>>> -> bfq_pq_alloc
>>>>>>   -> bfqg_get (+1)
>>>>>> ->bfq_activate_bfqq
>>>>>> ->bfq_activate_requeue_entity
>>>>>>  -> __bfq_activate_entity
>>>>>>     ->bfq_get_entity
>>>> ->>         ->bfqg_and_blkg_get (+1)  <==== : Note1
>>>>>> ->bfq_del_bfqq_busy
>>>>>> ->bfq_deactivate_entity+0x53/0xc0 [bfq]
>>>>>>  ->__bfq_deactivate_entity+0x1b8/0x210 [bfq]
>>>>>>    -> bfq_forget_entity(is_in_service = true)
>>>>>> 	 entity->on_st_or_in_serv = false   <=== :Note2
>>>>>> 	 if (is_in_service)
>>>>>> 	     return;  ==> do not touch reference
>>>>>> -> blkcg_css_offline
>>>>>> -> blkcg_destroy_blkgs
>>>>>> -> blkg_destroy
>>>>>> -> bfq_pd_offline
>>>>>>  -> __bfq_deactivate_entity
>>>>>>       if (!entity->on_st_or_in_serv) /* true, because (Note2)
>>>>>> 		return false;
>>>>>> -> bfq_pd_free
>>>>>>  -> bfqg_put() (-1, byt bfqg->ref == 2) because of (Note2)
>>>>>> So bfq_group and blkcg_gq  will leak forever, see test-case below.
>>>>>> If fact bfq_group objects reference counting are quite different
>>>>>> from bfq_queue. bfq_groups object are referenced by blkcg_gq via
>>>>>> blkg_policy_data pointer, so  neither nor blkg_get() neither bfqg_get
>>>>>> required here.
>>>>>> 
>>>>>> 
>>>>>> This patch drop commit db37a34c563b ("block, bfq: get a ref to a group when adding it to a service tree")
>>>>>> and add corresponding comment.
>>>>>> 
>>>>>> ##TESTCASE_BEGIN:
>>>>>> #!/bin/bash
>>>>>> 
>>>>>> max_iters=${1:-100}
>>>>>> #prep cgroup mounts
>>>>>> mount -t tmpfs cgroup_root /sys/fs/cgroup
>>>>>> mkdir /sys/fs/cgroup/blkio
>>>>>> mount -t cgroup -o blkio none /sys/fs/cgroup/blkio
>>>>>> 
>>>>>> # Prepare blkdev
>>>>>> grep blkio /proc/cgroups
>>>>>> truncate -s 1M img
>>>>>> losetup /dev/loop0 img
>>>>>> echo bfq > /sys/block/loop0/queue/scheduler
>>>>>> 
>>>>>> grep blkio /proc/cgroups
>>>>>> for ((i=0;i<max_iters;i++))
>>>>>> do
>>>>>>  mkdir -p /sys/fs/cgroup/blkio/a
>>>>>>  echo 0 > /sys/fs/cgroup/blkio/a/cgroup.procs
>>>>>>  dd if=/dev/loop0 bs=4k count=1 of=/dev/null iflag=direct 2> /dev/null
>>>>>>  echo 0 > /sys/fs/cgroup/blkio/cgroup.procs
>>>>>>  rmdir /sys/fs/cgroup/blkio/a
>>>>>>  grep blkio /proc/cgroups
>>>>>> done
>>>>>> ##TESTCASE_END:
>>>>>> 
>>>>>> Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
>>>>>> ---
>>>>>> block/bfq-cgroup.c  |  2 +-
>>>>>> block/bfq-iosched.h |  1 -
>>>>>> block/bfq-wf2q.c    | 15 +++++----------
>>>>>> 3 files changed, 6 insertions(+), 12 deletions(-)
>>>>>> 
>>>>>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>>>>>> index 68882b9..b791e20 100644
>>>>>> --- a/block/bfq-cgroup.c
>>>>>> +++ b/block/bfq-cgroup.c
>>>>>> @@ -332,7 +332,7 @@ static void bfqg_put(struct bfq_group *bfqg)
>>>>>> 		kfree(bfqg);
>>>>>> }
>>>>>> 
>>>>>> -void bfqg_and_blkg_get(struct bfq_group *bfqg)
>>>>>> +static void bfqg_and_blkg_get(struct bfq_group *bfqg)
>>>>>> {
>>>>>> 	/* see comments in bfq_bic_update_cgroup for why refcounting bfqg */
>>>>>> 	bfqg_get(bfqg);
>>>>>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>>>>>> index cd224aa..7038952 100644
>>>>>> --- a/block/bfq-iosched.h
>>>>>> +++ b/block/bfq-iosched.h
>>>>>> @@ -986,7 +986,6 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
>>>>>> struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
>>>>>> struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
>>>>>> struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node);
>>>>>> -void bfqg_and_blkg_get(struct bfq_group *bfqg);
>>>>>> void bfqg_and_blkg_put(struct bfq_group *bfqg);
>>>>>> 
>>>>>> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>>>>>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>>>>>> index 34ad095..6a363bb 100644
>>>>>> --- a/block/bfq-wf2q.c
>>>>>> +++ b/block/bfq-wf2q.c
>>>>>> @@ -529,13 +529,14 @@ static void bfq_get_entity(struct bfq_entity *entity)
>>>>>> {
>>>>>> 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
>>>>>> 
>>>>>> +	/* Grab reference only for bfq_queue's objects, bfq_group ones
>>>>>> +	 * are owned by blkcg_gq
>>>>>> +	 */
>>>>>> 	if (bfqq) {
>>>>>> 		bfqq->ref++;
>>>>>> 		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
>>>>>> 			     bfqq, bfqq->ref);
>>>>>> -	} else
>>>>>> -		bfqg_and_blkg_get(container_of(entity, struct bfq_group,
>>>>>> -					       entity));
>>>>>> +	}
>>>>>> }
>>>>>> 
>>>>>> /**
>>>>>> @@ -649,14 +650,8 @@ static void bfq_forget_entity(struct bfq_service_tree *st,
>>>>>> 
>>>>>> 	entity->on_st_or_in_serv = false;
>>>>>> 	st->wsum -= entity->weight;
>>>>>> -	if (is_in_service)
>>>>>> -		return;
>>>>>> -
>>>>>> -	if (bfqq)
>>>>>> +	if (bfqq && !is_in_service)
>>>>>> 		bfq_put_queue(bfqq);
>>>>>> -	else
>>>>>> -		bfqg_and_blkg_put(container_of(entity, struct bfq_group,
>>>>>> -					       entity));
>>>>>> }
>>>>>> 
>>>>>> /**
>>>>>> -- 
>>>>>> 2.7.4
