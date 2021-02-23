Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312A3C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 10:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D685464E00
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 10:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhBWKw3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 05:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhBWKwK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 05:52:10 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E12C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 02:51:29 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i14so25079189eds.8
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 02:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q+UV3BwksE2A5FoYCsUYtR1UzUkCKhiI+6UGSUFMTV0=;
        b=beqvtU/iUol2CnoC5Ex3HV2qYSg5nyw/MyPQ3KAf75PVrmU6ohqn48fNuOXaQogU28
         qN8esoydQMKtBwd0sEHgxdH13iT/mxGVrEJiqT9RGypEKTwbLJCz5IKn95byGwTkjvBK
         wJIVLr7+CciBlRCEGt2Jv2L+8205/4li7PibqKTgW4hYFdihVEspSC47tlSLZIlqei8E
         /rwiBgqbMj72baqcdKf9o7R5QqEm2vN3sx6zUvxwn8W/pzYYvf4iQBkTHEj81bhSTHnO
         +Y2kJ6hg2miyDWqDGj9hgZImlARb00g9dG6hx/4T1QSTx8mbv1WtTgAj8+QHmZEcediq
         dTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q+UV3BwksE2A5FoYCsUYtR1UzUkCKhiI+6UGSUFMTV0=;
        b=rJTL5Gb9T40NEpHDAQiTHuKQVOaFQqxfIL8QZpDOyXfYE6KQspsx42pN6fxw9/4BUf
         MOvLeZAq45u/BBZjLiMm4CboVBWLOd2qar02ld2yV0p5iR20V6HfSvGZY0dqNCx/JHZ7
         PiqgNuQn/PrEAxYh9NVfLvFk4Mn5RsBHUF4vaXpWlozqyMSdpBbfYzoVpEcxQyYiG94s
         +UY/zRKtBDCVCyXeMDsjZB6Hbsd6ZixQMpg3riVQEWzXOU8KG2HvF4Xz1DJbaJ+7H5km
         IR04wgen8wKWQq6YM60UHvDfFdHB7+2YsNT/W5VwDZHAiYgPcdR9YcWbHHlqkVRQCXuU
         rNHA==
X-Gm-Message-State: AOAM5316D+UefYg22aVYvDkiEfNxfhOh/b2gZ5totjFvRfqFPnoXH5wZ
        /hCTxQP3ELyeNz4HTqw8IhX23g==
X-Google-Smtp-Source: ABdhPJx7fw8MubfL7hH9xpBIdF0m1l+bU5MazpWNXfnjVZO8jNofi+fLTEG2IuPL3gWNuDIk9n1egw==
X-Received: by 2002:aa7:d8da:: with SMTP id k26mr27327733eds.364.1614077488467;
        Tue, 23 Feb 2021 02:51:28 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id c9sm10399789edt.6.2021.02.23.02.51.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2021 02:51:27 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: question about relative control for sync io using bfq
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <6ba9537b-052c-715b-111b-34a7d53179ec@huawei.com>
Date:   Tue, 23 Feb 2021 11:52:17 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        chenzhou <chenzhou10@huawei.com>,
        "houtao (A)" <houtao1@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E3D68B7-35D3-412E-8196-BF5AACDB1377@linaro.org>
References: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
 <7E41BC22-33EA-4D0F-9EBD-3AB0824E3F2E@linaro.org>
 <7c28a80f-dea9-d701-0399-a22522c4509b@huawei.com>
 <554AE702-9A13-4FB5-9B29-9AF11F09CE5B@linaro.org>
 <97ce5ede-0f7e-ce63-7a92-01c3356f4e44@huawei.com>
 <3E4B9F62-7376-4CA5-9C9D-21F6B9437313@linaro.org>
 <6ba9537b-052c-715b-111b-34a7d53179ec@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 19 feb 2021, alle ore 13:03, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
>=20
> On 2021/02/09 3:05, Paolo Valente wrote:
>>> Il giorno 7 feb 2021, alle ore 13:49, yukuai (C) =
<yukuai3@huawei.com> ha scritto:
>>>=20
>>>=20
>>> On 2021/02/05 15:49, Paolo Valente wrote:
>>>>> Il giorno 29 gen 2021, alle ore 09:28, yukuai (C) =
<yukuai3@huawei.com> ha scritto:
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> Thanks for your response, and my apologize for the delay, my tmie
>>>>> is very limited recently.
>>>>>=20
>>>> I do know that problem ...
>>>>> On 2021/01/22 18:09, Paolo Valente wrote:
>>>>>> Hi,
>>>>>> this is a core problem, not of BFQ but of any possible solution =
that
>>>>>> has to provide bandwidth isolation with sync I/O.  One of the =
examples
>>>>>=20
>>>>> I'm not sure about this, so I test it with iocost in mq and cfq in =
sq,
>>>>> result shows that they do can provide bandwidth isolation with =
sync I/O
>>>>> without significant performance degradation.
>>>> Yep, that means just that, with your specific workload, bandwidth
>>>> isolation gets guaranteed without idling.  So that's exactly one of
>>>> the workloads for which I'm suggesting my handling of a special =
case.
>>>>>> is the one I made for you in my other email.  At any rate, the =
problem
>>>>>> that you report seems to occur with just one group.  We may think =
of
>>>>>> simply changing my condition
>>>>>> bfqd->num_groups_with_pending_reqs > 0
>>>>>> to
>>>>>> bfqd->num_groups_with_pending_reqs > 1
>>>>>=20
>>>>> We aredy tried this, the problem will dispeare if only one group =
is
>>>>> active. And I think this modification is reasonable because
>>>>> bandwidth isolation is not necessary in this case.
>>>>>=20
>>>> Thanks for your feedback. I'll consider submitting this change.
>>>>> However, considering the common case, when more than one
>>>>> group is active, and one of the group is issuing sync IO, I think
>>>>> we need to find a way to prevent the preformance degradation.
>>>> I agree.  What do you think of my suggestion for solving the =
problem?
>>>> Might you help with that?
>>>=20
>>> Hi
>>>=20
>>> Do you mead the suggestion that you mentioned in another email:
>>> "a varied_rq_size flag, similar to the varied_weights flag" ?
>>> I'm afraid that's just a circumvention plan, not a solution to the
>>> special case.
>>>=20
>> I'm a little confused.  Could you explain why you think this is a
>> circumvention plan?  Maybe even better, could you describe in detail
>> the special case you have in mind?  We could start from there, to =
think
>> of a possible, satisfactory solution.
> Hi,
>=20
> First of all, there are two conditions to trigger the problem in bfq:
> a. issuing sync IO concurrently. (I was testing in one cgroup, and
> I think multiple cgroups is the same.)
> b. not issuing in root cgroup.
>=20
> The phenomenon is that the performance will degradated to single
> process. The reason is that bfq_queue will never expired untill
> BUDGET_TIMEOUT since num_groups_with_pending_reqs will always be
> nonzero after issuing io to driver, which means that there is only
> one request in progress(during D2C) at any given moment.
>=20
> I was trying to skip the checking of active group if bfq.weight is not
> changed, and it's implemented by adding a varible =
'check_active_group',
> it'll only set to true if bfq.weight is changed.
>=20
> This approach will work fine is the weight stay unchanged, and will
> not be effective if the weight ever changed. This is why I said it's
> a circumvention plan.
>=20
> By the way, while testing with cfq, I found that the current active =
cfq
> queue can be preempted in such special case. I wonder if it's worth
> referring to bfq.
>=20

Hi,
thank you very much for this information.

You confirm my suspect: your case is one of those for which idling is
not needed. It only kills throughput.

Unfortunately, the preemption mechanism of cfq that you cite kills
service guaranteed in asymmetric cases.  That's why I have never added
it to bfq.

Turning to solutions, now I also understand why you speak about a
circumvention plan.  Yet the solution I described is not yours, and is
effective with any history of weight changes.

In a sense, my solution is an evolution of your initial solution.  It
is conceptually very simple: just track whether all weights and all
I/O sizes are equal.  When this condition holds true, no idling is
needed.  When it does not hold, idling is needed.  Your case would be
solved, service guarantees would be always preserved.

Thanks.
Paolo

> Thanks,
> Yu Kuai
>=20
>>> By the way, I'm glad if there is anything I can help, however it'll
>>> wait for a few days cause the Spring Festival is coming.
>>>=20
>> Ok, Happy Spring Festival then.
>> Thanks.
>> Paolo
>>> Thanks,
>>> Yu Kuai
>>>=20
>>>> Thanks,
>>>> Paolo
>>>>>> If this simple solution does solve the problem you report, then I
>>>>>> could run my batch of tests to check whether it causes some
>>>>>> regression.
>>>>>> What do you think?
>>>>>> Thanks.
>>>>>> Paolo
>>>>>=20
>>>>> Thanks
>>>>> Yu Kuai
>>>>>> .
>>>> .
>> .

