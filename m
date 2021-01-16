Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410AEC433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 10:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CFB205CB
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 10:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbhAPKqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Jan 2021 05:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbhAPKqe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jan 2021 05:46:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9ADC061757
        for <linux-block@vger.kernel.org>; Sat, 16 Jan 2021 02:45:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k10so9474268wmi.3
        for <linux-block@vger.kernel.org>; Sat, 16 Jan 2021 02:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2jwSQz6bJhpxXlgpJkDfzKgw0g8RlHkHOBK/+dYUf+s=;
        b=cnByPiYxKz6i0F6DQJ24mXU/uIXpa9aLS5f3tdws0elQ+RP7dC6gCImK6W27Dgnp2M
         HwlVglFJ1fQfN8p/4UTG4nNaablXMYVkBh2chHr7TWpjuAr+e2V/xSRlTGGbA9CQVR/D
         /rEMT2SnpgHbTA0njh/QUUg6kW0UD1kbTCuczHajNN5H5giYFjfdrXkUzFBB2W73M+ml
         BybE14XzHL8xPmnyOUp2YAltyPrqgdFshog4QU/6F50/xDh6ZhYV9WS3G9Z9g7w5T1Eo
         Te8IT2ei0r5e9NjQmXBn13iqYlZGB5l2ZOgSJDJBvDUY9uYcsncBOi9v4KcbSRPRwdV5
         +hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2jwSQz6bJhpxXlgpJkDfzKgw0g8RlHkHOBK/+dYUf+s=;
        b=DF6IsSgFWKH8XX9a1fSjvwhkPBVFaRZugkte32TF2tYf3yimu+7WufPR2E0olGG92q
         /QmAxpGXe6JGg3A6p2pJsZt1epAI+uoUlEhff8zktCiPqgss1+LYqVXqV5HBcy7Gc3FL
         g0kWi1fw03JDAKspJ/V94KaWhOHUDgNS2dBTVCiDb+1ObVT3W44VezfNSVfhfDYPDQ74
         rZwTcLjPBarRORGQUuw1FwLqGEoM9ZFCQqJM1MzGmAbsTbK/ZwFapx55RY3ZThj9KxoB
         t/MQYPH0P+NA+urKVQFk4Ob4bVEvCfE5ISs5X7cuam10iSV9sY02H+w5jeTJqvK+xUnF
         kObA==
X-Gm-Message-State: AOAM532V1zPb0k9xHEXoADS22rjT+/UTte7e8bsAaQ/7sEMBKFOiS5UK
        /2EqBaq/oxjiJdwV5Cf3LD3R+YHUAmGK7noN
X-Google-Smtp-Source: ABdhPJwZ1t2bCay/8UxZltJ439a5aoUqTDRYC0InUKcf+uAqAerZMYfvqWCLVPxwVLKiVyh6U3tx9Q==
X-Received: by 2002:a7b:c00a:: with SMTP id c10mr5909996wmb.66.1610793953162;
        Sat, 16 Jan 2021 02:45:53 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id s19sm16536937wrf.72.2021.01.16.02.45.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jan 2021 02:45:52 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: question about relative control for sync io using bfq
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <d2ea385c-1b19-002e-665a-6bfd23ff1c6e@huawei.com>
Date:   Sat, 16 Jan 2021 11:45:49 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        hch@lst.de, linux-block@vger.kernel.org,
        chenzhou <chenzhou10@huawei.com>,
        "houtao (A)" <houtao1@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D064AB48-7CFA-4A93-9136-D2702FC6B77B@linaro.org>
References: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
 <d2ea385c-1b19-002e-665a-6bfd23ff1c6e@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, give me a few days, unfortunately my time is very limited.

Thanks for reporting this interesting problem,
Paolo

> Il giorno 16 gen 2021, alle ore 09:59, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> ping...
>=20
> On 2021/01/11 21:15, yukuai (C) wrote:
>> Hi,
>> We found a performance problem:
>> kernel version: 5.10
>> disk: ssd
>> scheduler: bfq
>> arch: arm64 / x86_64
>> test param: direct=3D1, ioengine=3Dpsync, bs=3D4k, rw=3Drandread, =
numjobs=3D32
>> We are using 32 threads here, test results showed that iops is equal
>> to single thread.
>> After digging into the problem, I found root cause of the problem is =
strange:
>> bfq_add_request
>>  bfq_bfqq_handle_idle_busy_switch
>>   bfq_add_bfqq_busy
>>    bfq_activate_bfq
>>     bfq_activate_requeue_entity
>>      __bfq_activate_requeue_entity
>>       __bfq_activate_entity
>>        if (!bfq_entity_to_bfqq(entity))
>>         if (!entity->in_groups_with_pending_reqs)
>>          entity->in_groups_with_pending_reqs =3D true;
>>          bfqd->num_groups_with_pending_reqs++
>> If test process is not in root cgroup, num_groups_with_pending_reqs =
will
>> be increased after request was instered to bfq.
>> bfq_select_queue
>>  bfq_better_to_idle
>>   idling_needed_for_service_guarantees
>>    bfq_asymmetric_scenario
>>     return varied_queue_weights || multiple_classes_busy || =
bfqd->num_groups_with_pending_reqs > 0
>> After issuing IO to driver, num_groups_with_pending_reqs is ensured =
to
>> be nonzero, thus bfq won't expire the queue. This is the root cause =
of
>> degradating to single-process performance.
>> One the other hand, if I set slice_idle to zero, bfq_better_to_idle =
will
>> return false early, and the problem will disapear. However, relative
>> control will be inactive.
>> My question is that, is this a known flaw for bfq? If not, as cfq =
don't
>> have such problem, is there a suitable solution?
>> Thanks!
>> Yu Kuai
>> such problem,

