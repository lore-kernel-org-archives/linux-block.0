Return-Path: <SRS0=YKm5=AU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91A4C433E1
	for <linux-block@archiver.kernel.org>; Thu,  9 Jul 2020 07:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDF320674
	for <linux-block@archiver.kernel.org>; Thu,  9 Jul 2020 07:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/nDcgXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgGIHTW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGIHTW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jul 2020 03:19:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B3DC08C5CE
        for <linux-block@vger.kernel.org>; Thu,  9 Jul 2020 00:19:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so745663wmf.0
        for <linux-block@vger.kernel.org>; Thu, 09 Jul 2020 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rK4Ffv5aG0A0EOhQbqugqrEy785eJT1rmoFf8+WDBIg=;
        b=O/nDcgXcPcuLsPcTqokgWlvfmwYLB1G+AJmlT3fF9FI+1m1lCdP4neWb1mOBhXAmyJ
         jaq4rncghlyjaWe/Zl6UiyUS+u1lVlj+O6NNUe0f6aQvRkFfpf37Wk/hBiS4v/DHng5g
         xZzyj3vgUwU8AETvgF9EuhSAPXCOj6xUSg+nLeOdnEDBLNqKHOC4FcG5+2c8Y2jkhuR8
         ydZ6ujll8z9DvvT4PXwO74EdU/tkMjI1XDkwhfeBU87h9E3vLj+dQZo3s5StZqM31KD7
         EC1WYrevJ9aLm5o3AX96QI9eCgTYXZHy07j+QynQjsQ1PebN1EvEGuB8k72jAlM2CHvX
         Efiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rK4Ffv5aG0A0EOhQbqugqrEy785eJT1rmoFf8+WDBIg=;
        b=J5eqMcDH/FRcvf+VV9foMeOxGuioKBoaLSzv3Y8WtfzM2kzE1bLRp3+HbOSDwoG5Kz
         OilQHuiYLLLBMFsiu7jRSX1uqcibiTCY/OjsCuasEzHFNvL99zNlxvTDdYnBoUgH+G5h
         pT+ifdCuIz03leCfL96eFvh9fpEy1vjoobgMZZ0aO15YuOkAaQ4GF9domxvX5tW19Hyy
         CiJPsrqi5lmA8mITJa/CxwmPUvSkO5MrQgYCQEyZBoe0CDIWqTzDXIyML2saxDmSyTfw
         QlnkPhljDEqCcF8WDZH/WOC04etCBXcLwPcV+M5hgtut3fIV2tmB3mdFVfb0VUJkCcRw
         6IiA==
X-Gm-Message-State: AOAM533jFOzUHH4WGy9YgvTR1JrJvn2pWfdwhYmT+XHMaB3zsaMWiexB
        91cTTjz5UQ51sz0uthWJ1rJOLQ==
X-Google-Smtp-Source: ABdhPJwBCpkDGamuVQ/7Ir2TYO9kU5rpW5yt14ZDk+k17eCtccoVc2zuP0q7QedVcIV93FkVr/OemA==
X-Received: by 2002:a7b:c210:: with SMTP id x16mr12783446wmi.178.1594279160233;
        Thu, 09 Jul 2020 00:19:20 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id c25sm3269720wml.18.2020.07.09.00.19.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 00:19:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] bfq: fix blkio cgroup leakage
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <87k0zdrj7s.fsf@dmws.yandex.net>
Date:   Thu, 9 Jul 2020 09:19:41 +0200
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Content-Transfer-Encoding: quoted-printable
Message-Id: <545F1ABF-B2B2-4523-9259-D3F93A9BB330@linaro.org>
References: <20200702105751.20482-1-dmonakhov@gmail.com>
 <429E50C6-83BA-4A3F-BE9C-06C7C762AF33@linaro.org>
 <87k0zdrj7s.fsf@dmws.yandex.net>
To:     Dmitry Monakhov <dmonakhov@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 8 lug 2020, alle ore 19:48, Dmitry Monakhov =
<dmonakhov@gmail.com> ha scritto:
>=20
> Paolo Valente <paolo.valente@linaro.org> writes:
>=20
>> Hi,
>> sorry for the delay.  The commit you propose to drop fix the issues
>> reported in [1].
>>=20
>> Such a commit does introduce the leak that you report (thank you for
>> spotting it).  Yet, according to the threads mentioned in [1],
>> dropping that commit would take us back to those issues.
>>=20
>> Maybe the solution is to fix the unbalance that you spotted?
> I'm not quite shure that do I understand which bug was addressed for =
commit db37a34c563b.
> AFAIU both bugs mentioned in original patchset was fixed by:
> 478de3380 ("block, bfq: deschedule empty bfq_queues not referred by =
any proces")
> f718b0932 ( block, bfq: do not plug I/O for bfq_queues with no proc =
refs)"
>=20
> So I review commit db37a34c563b as independent one.
> It introduces extra reference for bfq_groups via bfqg_and_blkg_get(),
> but do we actually need it here?
>=20
> #IF CONFIG_BFQ_GROUP_IOSCHED is enabled:
> bfqd->root_group is holded by bfqd from bfq_init_queue()
> other bfq_queue objects are owned by corresponding blkcg from =
bfq_pd_alloc()
> So bfq_queue can not disappear under us.
>=20

You are right, but incomplete.  No extra ref is needed for an entity
that represents a bfq_queue.  And this consideration mistook me before
I realized that that commit was needed.  The problem is that an entity
may also represent a group of entities.  In that case no reference is
taken through any bfq_queue.  The commit you want to remove takes this
missing reference.

Paolo

> #IF CONFIG_BFQ_GROUP_IOSCHED is disabled:
> we have only one  bfqd->root_group object which allocated from =
bfq_create_group_hierarch()
> and bfqg_and_blkg_get() bfqg_and_blkg_put() are noop
>=20
> Resume: in both cases extra reference is not required, so I continue =
to
> insist that we should revert  commit db37a34c563b because it tries to
> solve a non existing issue, but introduce the real one.
>=20
> Please correct me if I'm wrong.
>>=20
>> I'll check it ASAP, unless you do it before me.
>>=20
>> Thanks,
>> Paolo
>>=20
>> [1] https://lkml.org/lkml/2020/1/31/94
>>=20
>>> Il giorno 2 lug 2020, alle ore 12:57, Dmitry Monakhov =
<dmonakhov@gmail.com> ha scritto:
>>>=20
>>> commit db37a34c563b ("block, bfq: get a ref to a group when adding =
it to a service tree")
>>> introduce leak forbfq_group and blkcg_gq objects because of get/put
>>> imbalance. See trace balow:
>>> -> blkg_alloc
>>>  -> bfq_pq_alloc
>>>    -> bfqg_get (+1)
>>> ->bfq_activate_bfqq
>>> ->bfq_activate_requeue_entity
>>>   -> __bfq_activate_entity
>>>      ->bfq_get_entity
> ->>         ->bfqg_and_blkg_get (+1)  <=3D=3D=3D=3D : Note1
>>> ->bfq_del_bfqq_busy
>>> ->bfq_deactivate_entity+0x53/0xc0 [bfq]
>>>   ->__bfq_deactivate_entity+0x1b8/0x210 [bfq]
>>>     -> bfq_forget_entity(is_in_service =3D true)
>>> 	 entity->on_st_or_in_serv =3D false   <=3D=3D=3D :Note2
>>> 	 if (is_in_service)
>>> 	     return;  =3D=3D> do not touch reference
>>> -> blkcg_css_offline
>>> -> blkcg_destroy_blkgs
>>> -> blkg_destroy
>>>  -> bfq_pd_offline
>>>   -> __bfq_deactivate_entity
>>>        if (!entity->on_st_or_in_serv) /* true, because (Note2)
>>> 		return false;
>>> -> bfq_pd_free
>>>   -> bfqg_put() (-1, byt bfqg->ref =3D=3D 2) because of (Note2)
>>> So bfq_group and blkcg_gq  will leak forever, see test-case below.
>>> If fact bfq_group objects reference counting are quite different
>>> from bfq_queue. bfq_groups object are referenced by blkcg_gq via
>>> blkg_policy_data pointer, so  neither nor blkg_get() neither =
bfqg_get
>>> required here.
>>>=20
>>>=20
>>> This patch drop commit db37a34c563b ("block, bfq: get a ref to a =
group when adding it to a service tree")
>>> and add corresponding comment.
>>>=20
>>> ##TESTCASE_BEGIN:
>>> #!/bin/bash
>>>=20
>>> max_iters=3D${1:-100}
>>> #prep cgroup mounts
>>> mount -t tmpfs cgroup_root /sys/fs/cgroup
>>> mkdir /sys/fs/cgroup/blkio
>>> mount -t cgroup -o blkio none /sys/fs/cgroup/blkio
>>>=20
>>> # Prepare blkdev
>>> grep blkio /proc/cgroups
>>> truncate -s 1M img
>>> losetup /dev/loop0 img
>>> echo bfq > /sys/block/loop0/queue/scheduler
>>>=20
>>> grep blkio /proc/cgroups
>>> for ((i=3D0;i<max_iters;i++))
>>> do
>>>   mkdir -p /sys/fs/cgroup/blkio/a
>>>   echo 0 > /sys/fs/cgroup/blkio/a/cgroup.procs
>>>   dd if=3D/dev/loop0 bs=3D4k count=3D1 of=3D/dev/null iflag=3Ddirect =
2> /dev/null
>>>   echo 0 > /sys/fs/cgroup/blkio/cgroup.procs
>>>   rmdir /sys/fs/cgroup/blkio/a
>>>   grep blkio /proc/cgroups
>>> done
>>> ##TESTCASE_END:
>>>=20
>>> Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
>>> ---
>>> block/bfq-cgroup.c  |  2 +-
>>> block/bfq-iosched.h |  1 -
>>> block/bfq-wf2q.c    | 15 +++++----------
>>> 3 files changed, 6 insertions(+), 12 deletions(-)
>>>=20
>>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>>> index 68882b9..b791e20 100644
>>> --- a/block/bfq-cgroup.c
>>> +++ b/block/bfq-cgroup.c
>>> @@ -332,7 +332,7 @@ static void bfqg_put(struct bfq_group *bfqg)
>>> 		kfree(bfqg);
>>> }
>>>=20
>>> -void bfqg_and_blkg_get(struct bfq_group *bfqg)
>>> +static void bfqg_and_blkg_get(struct bfq_group *bfqg)
>>> {
>>> 	/* see comments in bfq_bic_update_cgroup for why refcounting =
bfqg */
>>> 	bfqg_get(bfqg);
>>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>>> index cd224aa..7038952 100644
>>> --- a/block/bfq-iosched.h
>>> +++ b/block/bfq-iosched.h
>>> @@ -986,7 +986,6 @@ struct bfq_group *bfq_find_set_group(struct =
bfq_data *bfqd,
>>> struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
>>> struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
>>> struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, =
int node);
>>> -void bfqg_and_blkg_get(struct bfq_group *bfqg);
>>> void bfqg_and_blkg_put(struct bfq_group *bfqg);
>>>=20
>>> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>>> index 34ad095..6a363bb 100644
>>> --- a/block/bfq-wf2q.c
>>> +++ b/block/bfq-wf2q.c
>>> @@ -529,13 +529,14 @@ static void bfq_get_entity(struct bfq_entity =
*entity)
>>> {
>>> 	struct bfq_queue *bfqq =3D bfq_entity_to_bfqq(entity);
>>>=20
>>> +	/* Grab reference only for bfq_queue's objects, bfq_group ones
>>> +	 * are owned by blkcg_gq
>>> +	 */
>>> 	if (bfqq) {
>>> 		bfqq->ref++;
>>> 		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
>>> 			     bfqq, bfqq->ref);
>>> -	} else
>>> -		bfqg_and_blkg_get(container_of(entity, struct bfq_group,
>>> -					       entity));
>>> +	}
>>> }
>>>=20
>>> /**
>>> @@ -649,14 +650,8 @@ static void bfq_forget_entity(struct =
bfq_service_tree *st,
>>>=20
>>> 	entity->on_st_or_in_serv =3D false;
>>> 	st->wsum -=3D entity->weight;
>>> -	if (is_in_service)
>>> -		return;
>>> -
>>> -	if (bfqq)
>>> +	if (bfqq && !is_in_service)
>>> 		bfq_put_queue(bfqq);
>>> -	else
>>> -		bfqg_and_blkg_put(container_of(entity, struct bfq_group,
>>> -					       entity));
>>> }
>>>=20
>>> /**
>>> --=20
>>> 2.7.4
>>>=20

