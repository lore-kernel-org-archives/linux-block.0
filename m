Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAE3C4708C
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 08:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74BB3611C9
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 08:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhE1IpO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 04:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhE1IpN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 04:45:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A829C061574
        for <linux-block@vger.kernel.org>; Fri, 28 May 2021 01:43:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so1919291wmh.4
        for <linux-block@vger.kernel.org>; Fri, 28 May 2021 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9Rn/dvCJ1EBNdJn6yZGrDKZ19J2/Rv+QliUmrrNiwfI=;
        b=KJRBd5bjqGvcKfI3MiHnA9RsGjmNmzo+JhuTMvse2W0Blov20Wg3Hlsq/TrQXm0QU+
         Ha/BVbQo/Bosd8ngJh5mGguSO0RaVtruOJwglyu5dtxL3TEvbGrVCyd1IoQlOy3kt92H
         mDENAfSDdnJDKCrIoBQWzDwNYan2L85Ywu/6AoBXqnKvCCm87DEAoMCYFAAzAtvwQg9s
         07vwcvoO9w81rQ2a/nMwikkiy5NcHMu9znQiLPJoyXhCvr+4KgDf7Li1f+BKMYebGeqq
         cic0+7B6m9WUJJROa2sQ2m8cNMpoUywS/FQqWjyNmzGPE+jW4QL9OFe9C7be70QmeyOU
         /LFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9Rn/dvCJ1EBNdJn6yZGrDKZ19J2/Rv+QliUmrrNiwfI=;
        b=CrW+V3mWi7IohZ2VIW30Q1COV7Y7UkcK9BpWFA9Xe6MITaX2glp4oaTORanm7Zq8q7
         eCiE4EfRYgzKqJPjw3FgCCGO8isjklxK+6X/AusoDDpwJxsi7Nqb9mKlzJL01Po6qgf7
         yc6etO4RCIt9zmGnlQ5XYOxK2lrBT6WfTDqRnucIMQTbjFHVWB04CR72M/EnZhUZkSs2
         hn8CPCe8AbBKihV4VqIuKxAHtkw2mWTNYfKf1aROQkZSFsgRLeEEdyMSAVmbQHjZpGFG
         PrDZni/9pvwsAbOx1H28viZRW+sdwe4DNNEpIYc6yxgTxvRg8zk3zqDprsFn9mS85nSJ
         /LOw==
X-Gm-Message-State: AOAM5309cQtWWXSNb0sfqjeGwGqnSPaZC6x9cFAAqryyYusW/qe7brRr
        XlNbnAb8jIe/6t+ddDS/7uPm0g==
X-Google-Smtp-Source: ABdhPJxctLEsUjGk9taMJSb+03wYpqv5F1BHVY9nBPAwNAHvpxmNP17DlJcZ2n5GJoqD2AR1SC6klQ==
X-Received: by 2002:a1c:f70d:: with SMTP id v13mr7162629wmh.183.1622191415870;
        Fri, 28 May 2021 01:43:35 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id v7sm6669843wrf.26.2021.05.28.01.43.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 May 2021 01:43:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/9] Improve I/O priority support
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <b3878299-ae9b-d03a-eaa8-b1890afcbfe2@gmail.com>
Date:   Fri, 28 May 2021 10:43:33 +0200
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CCCB28B-E241-4382-8F6A-4C825DDD028A@linaro.org>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <b58840a8-0122-26cd-e756-92562064075a@gmail.com>
 <ef81558a-cab2-ca2f-dba8-e032ecdb8154@gmail.com>
 <22c245e9-469c-0a0f-ad31-455a33f1e073@acm.org>
 <b3878299-ae9b-d03a-eaa8-b1890afcbfe2@gmail.com>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 28 mag 2021, alle ore 04:05, Wang Jianchao =
<jianchao.wan9@gmail.com> ha scritto:
>=20
>=20
>=20
> On 2021/5/28 2:40 AM, Bart Van Assche wrote:
>> On 5/27/21 1:05 AM, Wang Jianchao wrote:
>>> On 2021/5/27 2:25 PM, Wang Jianchao wrote:
>>>> On 2021/5/27 9:01 AM, Bart Van Assche wrote:
>>>>> A feature that is missing from the Linux kernel for storage =
devices that
>>>>> support I/O priorities is to set the I/O priority in requests =
involving page
>>>>> cache writeback. Since the identity of the process that triggers =
page cache
>>>>> writeback is not known in the writeback code, the priority set by =
ioprio_set()
>>>>> is ignored. However, an I/O cgroup is associated with writeback =
requests
>>>>> by certain filesystems. Hence this patch series that implements =
the following
>>>>> changes for the mq-deadline scheduler:
>>>>=20
>>>> How about implement this feature based on the rq-qos framework ?
>>>> Maybe it is better to make mq-deadline a pure io-scheduler.
>>>=20
>>> In addition, it is more flexible to combine different io-scheduler =
and rq-qos policy
>>> if we take io priority as a new policy ;)
>>=20
>> Hi Jianchao,
>>=20
>> That's an interesting question. I'm in favor of flexibility. However,
>> I'm not sure whether it would be possible to combine an rq-qos policy
>> that submits high priority requests first with an I/O scheduler that
>> ignores I/O priorities. Since a typical I/O scheduler reorders =
requests,
>> such a combination would lead to requests being submitted in the =
wrong
>> order to storage devices. In other words, when using an I/O =
scheduler,> proper support for I/O priority in the I/O scheduler is =
essential. The
>=20
> Hi Bart,
>=20
> Does it really matter that issue IO request by the order of io =
priority ?
>=20
> Given a device with a 32 depth queue and doesn't support io priority, =
even if
> we issue the request by the order of io priority, will the fw of =
device handle
> them by the same order ? Or in the other word, we always issue 32 io =
requests
> to device one time and then the fw of device decides how to handle =
them.
> The order of dispatching request from queue may only work when the =
device's
> queue is full and we have a deeper queue in io scheduler. And at this =
moment,
> maybe the user needs to check why their application saturates the =
block device.
>=20
> As for the qos policy of io priority, it seems similar with wbt in =
which read,
> sync write and background write have different priority. Since we =
always want
> the io with higher priority to be served more by the device, adapting =
the depth
> of queue of different io priority may work ;)
>=20

That's exactly what BFQ does, as this is the only option to truly
control I/O in a device with internal queueing :)

Thanks,
Paolo

> Best regards
> Jianchao
>=20
>> BFQ I/O scheduler is still maturing. The purpose of the Kyber I/O
>> scheduler is to control latency by reducing the queue depth without
>> differentiating between requests of the same type. The mq-deadline
>> scheduler is already being used in combination with storage devices =
that
>> support I/O priorities in their controller. Hence the choice for the
>> mq-deadline scheduler.
>>=20
>> Thanks,
>>=20
>> Bart.

