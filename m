Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84368C4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 13:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CFC613A5
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 13:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhHWN7O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhHWN7M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 09:59:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F6BC061575
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 06:58:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i6so26359528edu.1
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WX1ehOUsUxkPxZH7RkUnUxxcQ85HX+NQzLUrF1ef8mE=;
        b=L7LBOQo/c8YwrF3id6S1pN1pKfI1xG1HLGCih6AYDiwiwzDv6c3h/1JarHtJPHp1Q6
         gSy8M2fkbwV8gmosyvzb9ifJT2L2CEJoWT7uM6NozOPxcYTZzAPCm2OuzS0ToVbC5C5W
         GCDO9icJV9ZDrfowPc9/iBfwAJ1mnx4gtZ26P3l6vTUZoKF/E0k1yAyhPd+Q/9/u7dWM
         jO2s0NDAK6Fx6jFEFw28XWuawbr4j1KDnLSFPx+cCU9gIN4arFoEQBsYdjcwx9L+H3hX
         Ol26gKNfIwVpUkYhR3ComLGn+aUS74EpWXfyBxNkKhnciqeLitaH/551okwT5kWjIX3k
         jDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WX1ehOUsUxkPxZH7RkUnUxxcQ85HX+NQzLUrF1ef8mE=;
        b=Fhy0II43RPIt+mP8PZ71/smWIIKBng6TPzohgRatcTKujIEgeR5SOZp1a1cVlfeYFi
         ERzgU5toLlvNjg05Xpiy5gQF4P+IOgP/hmvyMgq//qOKfUZZeh9FdKdEeec39gQrtol4
         NjAN7eKvTfF/75BfaGIB0wkcOBwZ7QPgGtlZuaSgh0dmKnjrtHlj7FewNGFMJXwjro+6
         9WQ2XUwcqORAnObeAkf43Y5y4NDgRoT/ENYw8K1DCc7mMY0iKhU9ReuJt9xZrTYZI3vK
         ehTQ+oeUsrLFub8AB0Br4gKz0I6/njUCg6yMl4Speegau2P+B4ak4Fqxu9KI+TEtszKK
         iW0w==
X-Gm-Message-State: AOAM533PfiqBTA8xQ7bMRRnxGvg2PBXdlOeJ6vIHb0u/Bf4rENxmakX7
        sAoC0CEi+bJR7eyPA40I8dsCUg+bKnMkSA==
X-Google-Smtp-Source: ABdhPJySaakZOYVDiJ4QCOzS/7V0OmYNCi+KvVxdNgskmTZmoAWN1Nwp5B7M2cnTwhXma7+BrqoW3Q==
X-Received: by 2002:a05:6402:d6f:: with SMTP id ec47mr5853235edb.95.1629727108005;
        Mon, 23 Aug 2021 06:58:28 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id g10sm7469097ejj.44.2021.08.23.06.58.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Aug 2021 06:58:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: False waker detection in BFQ
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210813140111.GG11955@quack2.suse.cz>
Date:   Mon, 23 Aug 2021 15:58:25 +0200
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A72B321A-3952-4C00-B7DB-67954B05B99A@linaro.org>
References: <20210505162050.GA9615@quack2.suse.cz>
 <FFFA8EE2-3635-4873-9F2C-EC3206CC002B@linaro.org>
 <20210813140111.GG11955@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 13 ago 2021, alle ore 16:01, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> Hi Paolo!
>=20
> On Thu 20-05-21 17:05:45, Paolo Valente wrote:
>>> Il giorno 5 mag 2021, alle ore 18:20, Jan Kara <jack@suse.cz> ha =
scritto:
>>>=20
>>> Hi Paolo!
>>>=20
>>> I have two processes doing direct IO writes like:
>>>=20
>>> dd if=3D/dev/zero of=3D/mnt/file$i bs=3D128k oflag=3Ddirect =
count=3D4000M
>>>=20
>>> Now each of these processes belongs to a different cgroup and it has
>>> different bfq.weight. I was looking into why these processes do not =
split
>>> bandwidth according to BFQ weights. Or actually the bandwidth is =
split
>>> accordingly initially but eventually degrades into 50/50 split. =
After some
>>> debugging I've found out that due to luck, one of the processes is =
decided
>>> to be a waker of the other process and at that point we loose =
isolation
>>> between the two cgroups. This pretty reliably happens sometime =
during the
>>> run of these two processes on my test VM. So can we tweak the waker =
logic
>>> to reduce the chances for false positives? Essentially when there =
are only
>>> two processes doing heavy IO against the device, the logic in
>>> bfq_check_waker() is such that they are very likely to eventually =
become
>>> wakers of one another. AFAICT the only condition that needs to get
>>> fulfilled is that they need to submit IO within 4 ms of the =
completion of
>>> IO of the other process 3 times.
>>>=20
>>=20
>> Hi Jan!
>> as I happened to tell you moths ago, I feared some likely cover case
>> to show up eventually.  Actually, I was even more pessimistic than =
how
>> reality proved to be :)
>>=20
>> I'm sorry for my delay, but I've had to think about this issue for a
>> while.  Being too strict would easily run out journald as a waker for
>> processes belonging to a different group.
>>=20
>> So, what do you think of this proposal: add the extra filter that a
>> waker must belong to the same group of the woken, or, at most, to the
>> root group?
>=20
> Returning back to this :). I've been debugging other BFQ problems with =
IO
> priorities not really leading to service differentiation (mostly =
because
> scheduler tag exhaustion, false waker detection, and how we inject IO =
for a
> waker) and as a result I have come up with a couple of patches that =
also
> address this issue as a side effect - I've added an upper time limit
> (128*slice_idle) for the "third cooperation" detection and that mostly =
got
> rid of these false waker detections.

Great!

> We could fail to detect waker-wakee
> processes if they do not cooperate frequently but then the value of =
the
> detection is small and the lack of isolation may do more harm than =
good
> anyway.
>=20

IIRC, dbench was our best benchmark for checking whether the detection =
is
(still) effective.


> Currently I'm running wider set of benchmarks for the patches to see
> whether I didn't regress anything else. If not, I'll post the patches =
to
> the list.
>=20

Any news?

Thanks,
Paolo

> 								Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

