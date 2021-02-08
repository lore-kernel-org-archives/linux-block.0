Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E1BC4332D
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 19:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B5E64E8C
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 19:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhBHTIv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbhBHTG1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Feb 2021 14:06:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB38C06178B
        for <linux-block@vger.kernel.org>; Mon,  8 Feb 2021 11:05:39 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u14so18568746wri.3
        for <linux-block@vger.kernel.org>; Mon, 08 Feb 2021 11:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=52hVI1QjdSKjmLoZkmIxI4d+tbUWjziBzYnb90oqlm4=;
        b=PvmEo2DyQjfIGVfx9h0JYZAn2HiTNRuXYTmDYn6SrWPSDr//6iwb33SmBiCTuQoBao
         lXePLw9Qc1ueHrmq3tREV1Z1qeQhnnNGVjE9tMRRE0SUe8nI85+etB2tA5dBF8lTfTEI
         CjLETI8fNsG8ZGO4/r7ZT9gOvQPybM3SerSCMM4yr7r44I9W+XVIpw3ELwi6REInGvYv
         d5VFwjcHtGSd/fQCZMDpzs7v4HjmIg/yhzN2GpOSxEDdrzj+gUokYE1y+b6tdHEFzve6
         sL5vPp06JOPPhElunUX64bX3rPecoKYB5L9awFNhH22pirZxfK+rZPnK74TuCjJ7M9ms
         hUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=52hVI1QjdSKjmLoZkmIxI4d+tbUWjziBzYnb90oqlm4=;
        b=CpXsoKS9pM8dcqZQBD9t3z1sTmwj5F/0oUin6ze7RfgIEpsV3KYH+Gboac5R8UEEpD
         a75LdnwSNz+gX6yXVwrwr3UD3UPR+PIC7H4mAuHSZdqXwyHlSfHotxQTWHmWpPG13WUT
         rhM0F+3G+byH7OPKQ8e7NxXVc+U3wcXMePLYzCmdtFZZ+1FCMCmlCzrTNBmV+xtbxz2a
         7DlbyaNbiNHs864FWGKBJQUXBi9FyTXDW38hu2uKwkpyBY7Vl0Lzm+rQDQoc8DbTvFPj
         NL70ZRo19K0obKskK42zXPFpogG0uJL+/GqnbbVZicx5SVyMRo2cHZ0PIePczLLP6lJj
         BXRg==
X-Gm-Message-State: AOAM5325Vpe3UHnYu1pmra14Bugy95HhVCjrEejnUyE/RdBPv7Sxoa5P
        LAvDJV9VJMk4X4/PwkANSbL9xB7bomB0+A==
X-Google-Smtp-Source: ABdhPJzhKjbnK/6FifB1EK1tC1JznpN5so27ADa4ssdnXEbYZPYefpPnrIVFXmcXaz/csoDgunbRaw==
X-Received: by 2002:adf:f285:: with SMTP id k5mr8661500wro.285.1612811137592;
        Mon, 08 Feb 2021 11:05:37 -0800 (PST)
Received: from [192.168.159.233] ([37.161.163.37])
        by smtp.gmail.com with ESMTPSA id q19sm213860wmj.23.2021.02.08.11.05.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 11:05:36 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: question about relative control for sync io using bfq
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <97ce5ede-0f7e-ce63-7a92-01c3356f4e44@huawei.com>
Date:   Mon, 8 Feb 2021 20:05:40 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        chenzhou <chenzhou10@huawei.com>,
        "houtao (A)" <houtao1@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E4B9F62-7376-4CA5-9C9D-21F6B9437313@linaro.org>
References: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
 <7E41BC22-33EA-4D0F-9EBD-3AB0824E3F2E@linaro.org>
 <7c28a80f-dea9-d701-0399-a22522c4509b@huawei.com>
 <554AE702-9A13-4FB5-9B29-9AF11F09CE5B@linaro.org>
 <97ce5ede-0f7e-ce63-7a92-01c3356f4e44@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 7 feb 2021, alle ore 13:49, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
>=20
> On 2021/02/05 15:49, Paolo Valente wrote:
>>> Il giorno 29 gen 2021, alle ore 09:28, yukuai (C) =
<yukuai3@huawei.com> ha scritto:
>>>=20
>>> Hi,
>>>=20
>>> Thanks for your response, and my apologize for the delay, my tmie
>>> is very limited recently.
>>>=20
>> I do know that problem ...
>>> On 2021/01/22 18:09, Paolo Valente wrote:
>>>> Hi,
>>>> this is a core problem, not of BFQ but of any possible solution =
that
>>>> has to provide bandwidth isolation with sync I/O.  One of the =
examples
>>>=20
>>> I'm not sure about this, so I test it with iocost in mq and cfq in =
sq,
>>> result shows that they do can provide bandwidth isolation with sync =
I/O
>>> without significant performance degradation.
>> Yep, that means just that, with your specific workload, bandwidth
>> isolation gets guaranteed without idling.  So that's exactly one of
>> the workloads for which I'm suggesting my handling of a special case.
>>>> is the one I made for you in my other email.  At any rate, the =
problem
>>>> that you report seems to occur with just one group.  We may think =
of
>>>> simply changing my condition
>>>> bfqd->num_groups_with_pending_reqs > 0
>>>> to
>>>> bfqd->num_groups_with_pending_reqs > 1
>>>=20
>>> We aredy tried this, the problem will dispeare if only one group is
>>> active. And I think this modification is reasonable because
>>> bandwidth isolation is not necessary in this case.
>>>=20
>> Thanks for your feedback. I'll consider submitting this change.
>>> However, considering the common case, when more than one
>>> group is active, and one of the group is issuing sync IO, I think
>>> we need to find a way to prevent the preformance degradation.
>> I agree.  What do you think of my suggestion for solving the problem?
>> Might you help with that?
>=20
> Hi
>=20
> Do you mead the suggestion that you mentioned in another email:
> "a varied_rq_size flag, similar to the varied_weights flag" ?
> I'm afraid that's just a circumvention plan, not a solution to the
> special case.
>=20

I'm a little confused.  Could you explain why you think this is a
circumvention plan?  Maybe even better, could you describe in detail
the special case you have in mind?  We could start from there, to think
of a possible, satisfactory solution.


> By the way, I'm glad if there is anything I can help, however it'll
> wait for a few days cause the Spring Festival is coming.
>=20

Ok, Happy Spring Festival then.

Thanks.
Paolo

> Thanks,
> Yu Kuai
>=20
>> Thanks,
>> Paolo
>>>> If this simple solution does solve the problem you report, then I
>>>> could run my batch of tests to check whether it causes some
>>>> regression.
>>>> What do you think?
>>>> Thanks.
>>>> Paolo
>>>=20
>>> Thanks
>>> Yu Kuai
>>>> .
>> .

