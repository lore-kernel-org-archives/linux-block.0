Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FE7C00140
	for <linux-block@archiver.kernel.org>; Wed, 10 Aug 2022 10:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiHJKtP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Aug 2022 06:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiHJKtP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Aug 2022 06:49:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5CB85FB8
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 03:49:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gk3so26936550ejb.8
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=l9usa1vuL2H6KZQuz+LzUAEvl04HjNXt9CmOhLLJBSQ=;
        b=BTCabf1ZCfvLejWJAHR1SmlS6q6MgM/0QU8EF47Wf41/rboIWcOWDmFYVni5+WIj86
         7NeEzoDJZVzVZXjwTlGmnLn+NV9HhWuPbqf2Yyjnjpqy4nkDx42aw8s8wopgq98SJKpa
         gZwfBWT9VSTz+FF8YmbCzGRxOa3BTQLc0ZZSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=l9usa1vuL2H6KZQuz+LzUAEvl04HjNXt9CmOhLLJBSQ=;
        b=OZDvm2oGYp61tcAKEGFu+Hdc0CK7c7hH6Egj9pRmrC2Z6gqjX829h3bBKzckhBeA7p
         CE1DriiamCk3Jn4zZAG4zp8wKKGyZUCDuoYI1/x5BED2gCferwQ+p4KI6vOxFQdwhiaw
         6vfNGqzZrqrTGbWd17aNfZi1vhBkgrFksIe26fo9E0jozdDbY0yEGHt2g4/EawtZP7Jn
         0OSRrUfBfNP9cc3NEQ/h2AHPtqEzqN9bIutcFIplpspeIq5oD7o29IWmSBwXP25X7iW3
         VKmjFIHjR6Q6pO9hvP7qVJbJQaIAN2v9GMfZmg8xdQUxa2ny6V2Wg+wvFYd+C6Vv1MhK
         6eiw==
X-Gm-Message-State: ACgBeo0GmGn0nc30nnQ1BVFzkgI0CLExvUlq0Dg/OpmkjMLV4lbPK9O0
        swuunkcZll4mGA9IPlv8QK/wCmLJ/M1l
X-Google-Smtp-Source: AA6agR5oQvEj/s7bSddVrjIAacVoWMaOUcaPEbxOsKLxnw3UtyE01z9/EZrnD+u6mN5X+ztmAhIkTg==
X-Received: by 2002:a17:907:6d8c:b0:731:6c60:eced with SMTP id sb12-20020a1709076d8c00b007316c60ecedmr8306368ejc.266.1660128550558;
        Wed, 10 Aug 2022 03:49:10 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-70-86-43.cust.vodafonedsl.it. [93.70.86.43])
        by smtp.gmail.com with ESMTPSA id y12-20020a170906518c00b007306a4ecc9dsm2233295ejk.18.2022.08.10.03.49.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Aug 2022 03:49:08 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v10 3/4] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
From:   Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <2f94f241-445f-1beb-c4a8-73f6efce5af2@huaweicloud.com>
Date:   Wed, 10 Aug 2022 12:49:04 +0200
Cc:     Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <55A07102-BE55-4606-9E32-64E884064FB9@unimore.it>
References: <20220610021701.2347602-1-yukuai3@huawei.com>
 <20220610021701.2347602-4-yukuai3@huawei.com>
 <27F2DF19-7CC6-42C5-8CEB-43583EB4AE46@linaro.org>
 <abdbb5db-e280-62f8-0670-536fcb8ec4d9@huaweicloud.com>
 <C2CF100A-9A7C-4300-9A70-1295BC939C66@unimore.it>
 <9b2d667f-6636-9347-08a1-8bd0aa2346f2@huaweicloud.com>
 <2f94f241-445f-1beb-c4a8-73f6efce5af2@huaweicloud.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 27 lug 2022, alle ore 14:11, Yu Kuai =
<yukuai1@huaweicloud.com> ha scritto:
>=20
> Hi, Paolo
>=20

hi

> Are you still interested in this patchset?
>=20

Yes. Sorry for replying very late again.

Probably the last fix that you suggest is enough, but I'm a little bit
concerned that it may be a little hasty.  In fact, before this fix, we
exchanged several messages, and I didn't seem to be very good at
convincing you about the need to keep into account also in-service
I/O.  So, my question is: are you sure that now you have a
clear/complete understanding of this non-trivial matter?
Consequently, are we sure that this last fix is most certainly all we
need?  Of course, I will check on my own, but if you reassure me on
this point, I will feel more confident.

Thanks,
Paolo

> =E5=9C=A8 2022/07/20 19:38, Yu Kuai =E5=86=99=E9=81=93:
>> Hi
>>=20
>> =E5=9C=A8 2022/07/20 19:24, Paolo VALENTE =E5=86=99=E9=81=93:
>>>=20
>>>=20
>>>> Il giorno 12 lug 2022, alle ore 15:30, Yu Kuai =
<yukuai1@huaweicloud.com <mailto:yukuai1@huaweicloud.com>> ha scritto:
>>>>=20
>>>> Hi!
>>>>=20
>>>> I'm copying my reply with new mail address, because Paolo seems
>>>> didn't receive my reply.
>>>>=20
>>>> =E5=9C=A8 2022/06/23 23:32, Paolo Valente =E5=86=99=E9=81=93:
>>>>> Sorry for the delay.
>>>>>> Il giorno 10 giu 2022, alle ore 04:17, Yu Kuai =
<yukuai3@huawei.com <mailto:yukuai3@huawei.com>> ha scritto:
>>>>>>=20
>>>>>> Currently, bfq can't handle sync io concurrently as long as they
>>>>>> are not issued from root group. This is because
>>>>>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>>>>>> bfq_asymmetric_scenario().
>>>>>>=20
>>>>>> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>>>>>>=20
>>>>>> Before this patch:
>>>>>> 1) root group will never be counted.
>>>>>> 2) Count if bfqg or it's child bfqgs have pending requests.
>>>>>> 3) Don't count if bfqg and it's child bfqgs complete all the =
requests.
>>>>>>=20
>>>>>> After this patch:
>>>>>> 1) root group is counted.
>>>>>> 2) Count if bfqg have pending requests.
>>>>>> 3) Don't count if bfqg complete all the requests.
>>>>>>=20
>>>>>> With this change, the occasion that only one group is activated =
can be
>>>>>> detected, and next patch will support concurrent sync io in the
>>>>>> occasion.
>>>>>>=20
>>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com =
<mailto:yukuai3@huawei.com>>
>>>>>> Reviewed-by: Jan Kara <jack@suse.cz <mailto:jack@suse.cz>>
>>>>>> ---
>>>>>> block/bfq-iosched.c | 42 =
------------------------------------------
>>>>>> block/bfq-iosched.h | 18 +++++++++---------
>>>>>> block/bfq-wf2q.c    | 19 ++++---------------
>>>>>> 3 files changed, 13 insertions(+), 66 deletions(-)
>>>>>>=20
>>>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>>>> index 0ec21018daba..03b04892440c 100644
>>>>>> --- a/block/bfq-iosched.c
>>>>>> +++ b/block/bfq-iosched.c
>>>>>> @@ -970,48 +970,6 @@ void __bfq_weights_tree_remove(struct =
bfq_data *bfqd,
>>>>>> void bfq_weights_tree_remove(struct bfq_data *bfqd,
>>>>>>     struct bfq_queue *bfqq)
>>>>>> {
>>>>>> -struct bfq_entity *entity =3D bfqq->entity.parent;
>>>>>> -
>>>>>> -for_each_entity(entity) {
>>>>>> -struct bfq_sched_data *sd =3D entity->my_sched_data;
>>>>>> -
>>>>>> -if (sd->next_in_service || sd->in_service_entity) {
>>>>>> -/*
>>>>>> -* entity is still active, because either
>>>>>> -* next_in_service or in_service_entity is not
>>>>>> -* NULL (see the comments on the definition of
>>>>>> -* next_in_service for details on why
>>>>>> -* in_service_entity must be checked too).
>>>>>> -*
>>>>>> -* As a consequence, its parent entities are
>>>>>> -* active as well, and thus this loop must
>>>>>> -* stop here.
>>>>>> -*/
>>>>>> -break;
>>>>>> -}
>>>>>> -
>>>>>> -/*
>>>>>> -* The decrement of num_groups_with_pending_reqs is
>>>>>> -* not performed immediately upon the deactivation of
>>>>>> -* entity, but it is delayed to when it also happens
>>>>>> -* that the first leaf descendant bfqq of entity gets
>>>>>> -* all its pending requests completed. The following
>>>>>> -* instructions perform this delayed decrement, if
>>>>>> -* needed. See the comments on
>>>>>> -* num_groups_with_pending_reqs for details.
>>>>>> -*/
>>>>>> -if (entity->in_groups_with_pending_reqs) {
>>>>>> -entity->in_groups_with_pending_reqs =3D false;
>>>>>> -bfqd->num_groups_with_pending_reqs--;
>>>>>> -}
>>>>>> -}
>>>>> With this part removed, I'm missing how you handle the following
>>>>> sequence of events:
>>>>> 1.  a queue Q becomes non busy but still has dispatched requests, =
so
>>>>> it must not be removed from the counter of queues with pending =
reqs
>>>>> yet
>>>>> 2.  the last request of Q is completed with Q being still idle =
(non
>>>>> busy).  At this point Q must be removed from the counter.  It =
seems to
>>>>> me that this case is not handled any longer
>>>> Hi, Paolo
>>>>=20
>>>> 1) At first, patch 1 support to track if bfqq has pending requests, =
it's
>>>> done by setting the flag 'entity->in_groups_with_pending_reqs' when =
the
>>>> first request is inserted to bfqq, and it's cleared when the last
>>>> request is completed(based on weights_tree insertion and removal).
>>>>=20
>>>=20
>>> In patch 1 I don't see the flag cleared for the request-completion =
event :(
>>>=20
>>> The piece of code involved is this:
>>>=20
>>> static void bfq_completed_request(struct bfq_queue *bfqq, struct =
bfq_data *bfqd)
>>> {
>>> u64 now_ns;
>>> u32 delta_us;
>>>=20
>>> bfq_update_hw_tag(bfqd);
>>>=20
>>> bfqd->rq_in_driver[bfqq->actuator_idx]--;
>>> bfqd->tot_rq_in_driver--;
>>> bfqq->dispatched--;
>>>=20
>>> if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq)) {
>>> /*
>>> * Set budget_timeout (which we overload to store the
>>> * time at which the queue remains with no backlog and
>>> * no outstanding request; used by the weight-raising
>>> * mechanism).
>>> */
>>> bfqq->budget_timeout =3D jiffies;
>>>=20
>>> bfq_weights_tree_remove(bfqd, bfqq);
>>> }
>>> ...
>>>=20
>>> Am I missing something?
>>=20
>> I add a new api bfq_del_bfqq_in_groups_with_pending_reqs() in patch 1
>> to clear the flag, and it's called both from bfq_del_bfqq_busy() and
>> bfq_completed_request(). I think you may miss the later:
>>=20
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 0d46cb728bbf..0ec21018daba 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -6263,6 +6263,7 @@ static void bfq_completed_request(struct =
bfq_queue *bfqq, struct bfq_data *bfqd)
>>           */
>>          bfqq->budget_timeout =3D jiffies;
>>=20
>> +        bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
>>          bfq_weights_tree_remove(bfqd, bfqq);
>>      }
>>=20
>> Thanks,
>> Kuai
>>>=20
>>> Thanks,
>>> Paolo
>=20

