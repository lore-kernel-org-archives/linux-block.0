Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3193AC43214
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 07:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCF960F56
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 07:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhHCHIK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 03:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhHCHIJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 03:08:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1DEC0613D5
        for <linux-block@vger.kernel.org>; Tue,  3 Aug 2021 00:07:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x14so27689104edr.12
        for <linux-block@vger.kernel.org>; Tue, 03 Aug 2021 00:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U0jio5+xFSbV7SP/KZIWsJ9guYPyBzSqjq6PsiTDQC0=;
        b=eLJEyLouuLRMx/jBModUrxmH+ISNHhOKpcMdKIQd9Ph7RNTyBWhDNRE0X28L3xLfVu
         WfaYl9PvuHZSKJcDNIb/q26uEMuQlfKF2om4KnMbvTBL1Quh5DfEbmqJodg6e4Wjpvr0
         g/4QEGzN56tIuMb2eKiaNVlCjTEO+/orr6ef+JbaIO6M5cR7kMUhyPXfcZTAsM1hFmFp
         aHChXwWuMeKlXZSNh561ANrr/itmau9zFqxOTyZPCOYiICCfY4F14evcgIDyHY/eE7e1
         3dgp3A3Dup+0bad0UzREiHfahwfYf10aNyV4bqi6jnQbEgaHUbAQYj4rSQkYBqMZcj4U
         lHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U0jio5+xFSbV7SP/KZIWsJ9guYPyBzSqjq6PsiTDQC0=;
        b=Cbc66DFCQClAnHPIPldJLZkcF2zaMXH0dCcYfQHFy9+s1YqVe2pUwmJbBEy4yfEHOf
         i3BEMMKxGwShepCWQTNm4haJAihjFbzG5dMYr9RtN8WtBLGv38LSs0bCm/K39TnLi4Wt
         p4gsgCHCjtdrbnHlRGzUh6G57PdePn/XaOK9nJ5orqMS0ckcH+onq1Otyg1sfwMdN5Cc
         ohMfms0TuZqirtXfb3haDdjaiJoQGMY4AEUMzOXShD04zPSm7ABjwhf+vGWdiMtJX36P
         j7bcCZbot0cIhj0ndygdil3f/stba53c8m+Eo2ZayCmkR7XgqpmFvrY+m4Vey4uHf1eI
         Zd1A==
X-Gm-Message-State: AOAM530IxjDr7AIJCXAuOOsyitQkaU2NVDNeyBbM0NrYmUmd9eHr2bE4
        JyCQxIv3bAUTU5xeE08pxeOTtA==
X-Google-Smtp-Source: ABdhPJz4M10SjISdU0pltgjPaL4f+YaI0qG47iOi1pjOPhxq/nbVQat6ri3yJpfU+tnlMkOFDIIUIg==
X-Received: by 2002:a05:6402:1b11:: with SMTP id by17mr24060442edb.110.1627974477469;
        Tue, 03 Aug 2021 00:07:57 -0700 (PDT)
Received: from [192.168.61.233] ([37.160.213.115])
        by smtp.gmail.com with ESMTPSA id i11sm7537591eds.72.2021.08.03.00.07.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Aug 2021 00:07:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/3] block, bfq: do not idle if only one cgroup is
 activated
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <c0b97b5b-c961-6d9f-7033-6da194c6b220@huawei.com>
Date:   Tue, 3 Aug 2021 09:07:54 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D4774E6-0DEB-4DC4-B28B-13F5A933E12F@linaro.org>
References: <20210714094529.758808-1-yukuai3@huawei.com>
 <20210714094529.758808-2-yukuai3@huawei.com>
 <7DF40BD4-8F57-4C2E-88A9-CBC3DA2A891E@linaro.org>
 <c0b97b5b-c961-6d9f-7033-6da194c6b220@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 31 lug 2021, alle ore 09:10, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> On 2021/07/24 15:12, Paolo Valente wrote:
>>> Il giorno 14 lug 2021, alle ore 11:45, Yu Kuai <yukuai3@huawei.com> =
ha scritto:
>>>=20
>>> If only one group is activated, specifically
>>> 'bfqd->num_groups_with_pending_reqs =3D=3D 1', there is no need to =
guarantee
>>> the same share of the throughput of queues in the same group.
>>>=20
>>> Thus change the condition from '> 0' to '> 1' in
>>> bfq_asymmetric_scenario().
>> I see your point, and I agree with your goal.  Yet, your change seems
>> not to suffer from the following problem.
>> In addition to the groups that are created explicitly, there is the
>> implicit root group.  So, when bfqd->num_groups_with_pending_reqs =3D=3D=

>> 1, there may be both active processes in the root group and active
>> processes in the only group created explicitly.  In this case, idling
>> is needed to preserve service guarantees.
>> Probably your idea should be improved by making sure that there is
>> pending I/O only from either the root group or the explicit group.
>> Thanks,
>> Paolo
>=20
>=20
> Hi, Paolo
>=20

Hi

> I'm trying to add support to judge if root group have pending rqs, the
> implementation involve setting and clearing the busy state.
>=20

I wouldn't use the busy state, as it does not take in-flight requests
into account.  For I/O control, the latter are as important as the
ones still queued in the scheduler.  For this reason, I take in-flight
requests into account when counting
bfqd->num_groups_with_pending_reqs.

See, e.g., this

	if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq)) {
		...
		bfq_weights_tree_remove(bfqd, bfqq);
	}

in bfq_completed_request.

I would replicate the same logic in deciding whether the root group
has pending I/O.


> I'm thinking about setting busy in __bfq_activate_entity() if
> bfq_entity_to_bfqq() return valid bfqq, however I'm not sure where to
> clear the busy state.
>=20
> On the other hand, do you think the way I record rq size info in patch =
2
> is OK?

First, let's see what you reply to my suggestion above.

Thanks,
Paolo

>  If so, I can do this the similar way: say that root group doesn't
> have any pending requests if bfq haven't dispatch rq from root group =
for
> a period of time.
>=20
> Thanks
> Kuai

