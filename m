Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A5EC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 21:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D036100B
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 21:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFVVSD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 17:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVVSD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 17:18:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E93C061756
        for <linux-block@vger.kernel.org>; Tue, 22 Jun 2021 14:15:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bb20so188373pjb.3
        for <linux-block@vger.kernel.org>; Tue, 22 Jun 2021 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=8aXlZr1F1hmRY/0ubzREtKQU8RqK8VWzIaWz5se5XVM=;
        b=ZiS1KsAuKc+8e/DnZgzyiisLvo+nOkSKaI/nerQhWLjZnEehLJdcKAjvsYi/uNiW8C
         Cn8u55GDy8yD56EI6RN5+DzhZ/3+YnrjQbiNhTJWxxOPSjPBXzOgPvS20TVzBwmT70LD
         Km9N5bu0n4bY8X3x7YkXPQMZil+YpRFx97zYVTrRv/508YeE7tgk3JqIpY/aQOhP3OnJ
         X624Ubf3rqwIGSWgINreXEAMvpSS816RolKEFyFV0ockben/NZ/bXH4SQ7+eUPSYI2k6
         /CYs+idMQ3I03SMtRDbwvepPStHUMA7/USLs0KXLLQR4pO/pOkzFka2+7b79KhC7H2Vo
         af6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=8aXlZr1F1hmRY/0ubzREtKQU8RqK8VWzIaWz5se5XVM=;
        b=ZfLsUatXn4YHYLXLDa1v0WiJVGYwDCkuzDE3N3bpJl3kiv0AI/4mq3j4WM8q+SxA5n
         joRyp7KA9ZP/Rdq7Vyz6QGcNi4d5TCgGW9wQdObIWdicu0ztZ0FuTMgcwJcJIC6hPCvo
         YbrFKRX0KNt5gQsj0ndT95PDQAwv/kqTVS44VPkIYYhI/bJ9T9m+XyQtDZAdjLIN6ezG
         E99Sbu99KK+G7dZ1fz2N+bXzNT4mbIQsSRG4sn9X5fnQispSj2iLzNT8gt6JO8ZqCyiW
         E2nryszFe0pglXOx+8K0pkcsMype5l9V6z3DLwFpaScuCVJlFBcFSjx54trnFCrexLXo
         IUYQ==
X-Gm-Message-State: AOAM5332/iN7zpaffNojQDbvM6e2HYeqGoCoytDFtGQYQI7wrrbRL9M8
        1JpfukmWZ6I27tmDt31b0J6rUA==
X-Google-Smtp-Source: ABdhPJwHR46NOFLdkzfMM5u23p5KB2roPw+3M9Q2TKlyEO2CxhPxzKp7z20Mbyg+OUYuXY7JdXYasg==
X-Received: by 2002:a17:90b:23c5:: with SMTP id md5mr5797330pjb.93.1624396546723;
        Tue, 22 Jun 2021 14:15:46 -0700 (PDT)
Received: from smtpclient.apple ([2600:380:6c63:dde2:1527:d8a2:8789:f1f0])
        by smtp.gmail.com with ESMTPSA id 73sm227423pfy.83.2021.06.22.14.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 14:15:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH][next] block/mq-deadline: remove redundant assignment of variable ret
Date:   Tue, 22 Jun 2021 15:15:45 -0600
Message-Id: <F8A7A6B5-37DB-45D8-971F-85D392618512@kernel.dk>
References: <dce79425-05fb-26a3-2f01-f9893de41513@acm.org>
Cc:     Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <dce79425-05fb-26a3-2f01-f9893de41513@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: iPhone Mail (18G5042c)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 22, 2021, at 3:14 PM, Bart Van Assche <bvanassche@acm.org> wrote:
>=20
> =EF=BB=BFOn 6/22/21 9:17 AM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>=20
>> Variable ret is being assigned a value at the end of the function
>> and the value is never read. The assignment is redundant and can
>> be removed.
>>=20
>> Addresses-Coverity: ("Unused value")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>> block/mq-deadline-main.c | 1 -
>> 1 file changed, 1 deletion(-)
>>=20
>> diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
>> index 4815e536091f..e3091d922ba2 100644
>> --- a/block/mq-deadline-main.c
>> +++ b/block/mq-deadline-main.c
>> @@ -639,7 +639,6 @@ static int dd_init_sched(struct request_queue *q, str=
uct elevator_type *e)
>>    if (ret)
>>        goto free_stats;
>>=20
>> -    ret =3D 0;
>>    q->elevator =3D eq;
>>    return 0;
>=20
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Assuming this is fallout from the recent series, we should add a fixes tag t=
o it.=20

=E2=80=94=20
Jens Axboe=
