Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3B3C433E0
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DC123B06
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbhAJJW1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 04:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbhAJJWZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 04:22:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C39EC06179F
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:21:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c133so11248978wme.4
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UQ67TvKAZwTSJJyS4wfyfVxfRuP3N4HdanGuCfvJ1aQ=;
        b=OYOb+lN9SXoMjHJsumjJyccR07w/tvMrkzNg5s3kvsXFq8R5RZwzv7VhXSNvSkgHv3
         YNZ4U7Zvx7GAOiidt/v9JPIEebSkbok6XOFeDdHXnDX07fUJV6ffOyh0sOQh1TajaCiB
         lpOvxBOK83lSHUEl+wbKStsBsgaDaFlBgZYNrCengsrus6If2ji+FzPxv+KGbVrQ3hn3
         NbEXU+Wxsv2HFInzNrPoERGraKuXgzBxxw9F3alj0+RAIcaX9yFa62CYuM5wl93fvoB5
         ctoO+wrPp9HtzQSCQFPDWG1hrrfgGLJkP4PIWMfJAitliP2f6IDUqejVZgdEC9aJ3FKn
         trSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UQ67TvKAZwTSJJyS4wfyfVxfRuP3N4HdanGuCfvJ1aQ=;
        b=pGFXorhh0h6U1FSwTQoKOHKnKbvnGK832B5GEf9e420pzkPu64X6Xo2TFR16MYnYvX
         Ig2BuIl7jko6dOBqrYoO+E19wPuf8QNHRW/nT7Hbn8xrZNguSPo1Y9M8tzeavf/DyloG
         JhP2erJO1BRXONGX82Tb+82dbYPISxnU+9uv8lq1iPcSX5C4NWJgGaQVyyRP0RdnQBSe
         Eh9IgkwbUWnUlpMag7W15yWFFcJygsaA7UlJFPPUkPeZ7ygcZ/E2+1lQfUE2O+sNcqqb
         +QzF5ZYWyVcoHTe9RJJDSGUjEhFGke9VjxCjd7M9yfdOm1BEgiu6ysFAFU7rjN3xgK6L
         h9dw==
X-Gm-Message-State: AOAM530Rm2eswiZ8UeTZATliPgCf8tyX9YWqzdKNgMqbKm4DxvMKUfil
        m7LgrIQKp9ElQ1FULI6S7yj7WA==
X-Google-Smtp-Source: ABdhPJzt9b0N+a68pfVGpZPovrnWaf51VRJ2VrCFZxFQNrXUcC0f+sF/yPgmonBM/sKIHnvgprj4cw==
X-Received: by 2002:a1c:2ed2:: with SMTP id u201mr10156613wmu.79.1610270503751;
        Sun, 10 Jan 2021 01:21:43 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id s6sm21676723wro.79.2021.01.10.01.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 01:21:43 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/3] bfq: Avoid false bfq queue merging
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <AF7DA035-BC93-42D2-B0B6-8ECC3273DEBC@linaro.org>
Date:   Sun, 10 Jan 2021 10:21:42 +0100
Cc:     linux-block <linux-block@vger.kernel.org>, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <58F09812-52B9-4B55-A37B-E180364DD4AA@linaro.org>
References: <20200605140837.5394-1-jack@suse.cz>
 <20200605141629.15347-1-jack@suse.cz>
 <FC3651A1-DB65-4A77-9BFB-ACAB80E54F3E@linaro.org>
 <20200611083149.GB18088@quack2.suse.cz>
 <AF7DA035-BC93-42D2-B0B6-8ECC3273DEBC@linaro.org>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 11 giu 2020, alle ore 16:12, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 11 giu 2020, alle ore 10:31, Jan Kara <jack@suse.cz> ha =
scritto:
>>=20
>> On Thu 11-06-20 09:13:07, Paolo Valente wrote:
>>>=20
>>>=20
>>>> Il giorno 5 giu 2020, alle ore 16:16, Jan Kara <jack@suse.cz> ha =
scritto:
>>>>=20
>>>> bfq_setup_cooperator() uses bfqd->in_serv_last_pos so detect =
whether it
>>>> makes sense to merge current bfq queue with the in-service queue.
>>>> However if the in-service queue is freshly scheduled and didn't =
dispatch
>>>> any requests yet, bfqd->in_serv_last_pos is stale and contains =
value
>>>> from the previously scheduled bfq queue which can thus result in a =
bogus
>>>> decision that the two queues should be merged.
>>>=20
>>> Good catch!=20
>>>=20
>>>> This bug can be observed
>>>> for example with the following fio jobfile:
>>>>=20
>>>> [global]
>>>> direct=3D0
>>>> ioengine=3Dsync
>>>> invalidate=3D1
>>>> size=3D1g
>>>> rw=3Dread
>>>>=20
>>>> [reader]
>>>> numjobs=3D4
>>>> directory=3D/mnt
>>>>=20
>>>> where the 4 processes will end up in the one shared bfq queue =
although
>>>> they do IO to physically very distant files (for some reason I was =
able to
>>>> observe this only with slice_idle=3D1ms setting).
>>>>=20
>>>> Fix the problem by invalidating bfqd->in_serv_last_pos when =
switching
>>>> in-service queue.
>>>>=20
>>>=20
>>> Apart from the nonexistent problem that even 0 is a valid LBA :)
>>=20
>> Yes, I was also thinking about that and decided 0 is "good enough" =
:). But
>> I just as well just switch to (sector_t)-1 if you think it would be =
better.
>>=20
>=20
> 0 is ok :)
>=20

Hi Jan,
I've finally tested this patch of yours. No regression.

Once again:
Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thanks,
Paolo

> Thanks,
> Paolo
>=20
>>> Acked-by: Paolo Valente <paolo.valente@linaro.org>
>>=20
>> Thanks!
>>=20
>> 								Honza
>>=20
>> --=20
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR

