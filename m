Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E42C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 07:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF3364DA3
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 07:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBEHuD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 02:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhBEHuC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Feb 2021 02:50:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C674C0613D6
        for <linux-block@vger.kernel.org>; Thu,  4 Feb 2021 23:49:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 7so6600672wrz.0
        for <linux-block@vger.kernel.org>; Thu, 04 Feb 2021 23:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7ydqOIs4baH+Bed3mkw9y1vXZxx7LTXeVAGKgV4SZ1Y=;
        b=qYgBU+mzkXDkiUPbO31jBBL4EDZoopQBPKDgwMxaeFq+4Yx6PLvG/LwjvcmWmtZBQI
         VsbZ7QWVNS3ADnown5woF+7PHBcH375MGEuhbnKTxPOlc4kAGL/D6ExVSv2PCzRBtDke
         eQiMHIc1Zi64mgY9fsen6+aJ34bVuRg2gYwd1Eb8QFXlPy9AjuOqQmF4Aa/d4QDrPOIy
         sTnqHD7HrMzzZj3TrNv0mOx/643kVcuZ71TxjG9t+5TaG7kwrCR/LQyZzZonx4Pk9BIP
         08EiP7LNMWqqVvga3mJ3lm/gx/T7njqHPpPhqjOpqJEYA/NQ2XTxAqSw9htDP22u+VgJ
         FPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7ydqOIs4baH+Bed3mkw9y1vXZxx7LTXeVAGKgV4SZ1Y=;
        b=NUvvULwkaxboR9BuUts2dpn2p9x1dgKyIkBA8tPxttWo3n8+asI7Hr+KKOoEftIKO3
         2HMp/GUcZaBLfte5Ngn8xkv1NR5Ikm53Jtq4HfVd7NlDMYcUjOsm7o+z7vh/Y0rFWkDh
         o4z0ZA5/kKqgNhZjFppFs0Z6xh8+p2QNaeG7uwkcZ4ckDnp+vYZyvVbZL3zhMNM7DTb6
         eKgI47QbtoS10wUd1SZpBTtqcRmmuggG1gJEh186csdpA0QZILwdM/UnJYVyCCoq6l7g
         tdVbjCEAzNkgfusRpOIRe/oguPy+KqC+s5rthDJYeiTrtLqn9MqQd89Dh3YxjYSSt8ex
         4Kpw==
X-Gm-Message-State: AOAM5303YR2ZJMLQIK0rwinAknidUSXwfYIBQ0ZuZTlqoOLXEivwN1nz
        O5LqGDkx/2KD0VKXX0arVquKJWJ1wRVqAQ==
X-Google-Smtp-Source: ABdhPJwqfW/q8H7vQtx2/QI65CRRmwugstxLl3XaNFvErVVfFPKQC/flepCd+yzQpWOStY5J5Gqr1A==
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr3361747wrv.303.1612511361046;
        Thu, 04 Feb 2021 23:49:21 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id g14sm11834506wru.45.2021.02.04.23.49.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 23:49:20 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: question about relative control for sync io using bfq
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <7c28a80f-dea9-d701-0399-a22522c4509b@huawei.com>
Date:   Fri, 5 Feb 2021 08:49:19 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        chenzhou <chenzhou10@huawei.com>,
        "houtao (A)" <houtao1@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <554AE702-9A13-4FB5-9B29-9AF11F09CE5B@linaro.org>
References: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
 <7E41BC22-33EA-4D0F-9EBD-3AB0824E3F2E@linaro.org>
 <7c28a80f-dea9-d701-0399-a22522c4509b@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 29 gen 2021, alle ore 09:28, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> Hi,
>=20
> Thanks for your response, and my apologize for the delay, my tmie
> is very limited recently.
>=20

I do know that problem ...

> On 2021/01/22 18:09, Paolo Valente wrote:
>> Hi,
>> this is a core problem, not of BFQ but of any possible solution that
>> has to provide bandwidth isolation with sync I/O.  One of the =
examples
>=20
> I'm not sure about this, so I test it with iocost in mq and cfq in sq,
> result shows that they do can provide bandwidth isolation with sync =
I/O
> without significant performance degradation.

Yep, that means just that, with your specific workload, bandwidth
isolation gets guaranteed without idling.  So that's exactly one of
the workloads for which I'm suggesting my handling of a special case.


>> is the one I made for you in my other email.  At any rate, the =
problem
>> that you report seems to occur with just one group.  We may think of
>> simply changing my condition
>> bfqd->num_groups_with_pending_reqs > 0
>> to
>> bfqd->num_groups_with_pending_reqs > 1
>=20
> We aredy tried this, the problem will dispeare if only one group is
> active. And I think this modification is reasonable because
> bandwidth isolation is not necessary in this case.
>=20

Thanks for your feedback. I'll consider submitting this change.

> However, considering the common case, when more than one
> group is active, and one of the group is issuing sync IO, I think
> we need to find a way to prevent the preformance degradation.

I agree.  What do you think of my suggestion for solving the problem?
Might you help with that?

Thanks,
Paolo

>> If this simple solution does solve the problem you report, then I
>> could run my batch of tests to check whether it causes some
>> regression.
>> What do you think?
>> Thanks.
>> Paolo
>=20
> Thanks
> Yu Kuai
>> .

