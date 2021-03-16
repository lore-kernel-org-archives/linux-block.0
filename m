Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1E5C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 07:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6970364FE1
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 07:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhCPHyS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbhCPHxw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 03:53:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777F0C06174A
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 00:53:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w11so9903831wrr.10
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EplFI/+IkCYDz04tRciG+1yq3e5iX5f+nLtqXSocxr8=;
        b=ZNqrhCghG4J07QrmUoNUJ+2voMiGHwiejrVts9zj4aELQ/eRVzLjEEmBDDHYbqjAuC
         pgDexLZh5HyAYNf3KxXYtM8UsSxIYYR/qqEAWboxxbjuQLc4ndlidHGTPKYQX9RJGzbO
         omCqMLEP+qcqWtqAwExlwjfJJwGb1YpzvEUDiP+WvsRIIR43BxsVYna007g+UO+ZDbxc
         0ib34SN2PTlhYOXTT0Oju+l+LY8eQSJc9UnwLLW/4xtvB5RbEdIg0aAb9oAfujPGOlmI
         jnnIUz0sW3jaRbs7mJ3DvCiBfF7dAQSIwAboGDPXgoGqFV0JbZglURgZWtOETQ5AKv9t
         7/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EplFI/+IkCYDz04tRciG+1yq3e5iX5f+nLtqXSocxr8=;
        b=I+luvcm+pV7Z0eMvNKEu5CqL+x8G9TAcuenOyY6aBPHtTVhVn+mlBNr9d/m44MZ2L+
         vH+MgwL3OP9nvBX1M7cXXcCE1ylQ/rtLZtbfo91kp18w1bkuvzcL2KI3vm5EjGJv/TuN
         j7Xwd27oZ4YeseViRD5XBdDJuY6GNv+8Nb06pmtisk+q+MkSRvR0F483XF20pjDCJfXd
         Ai6gpCGquaa3CeqlLDtDQkDjhzQ7pyM5j4uEfwDUqyX9FfE1ZjFbszHKmkzym96zmn/r
         SHArvRjb7d/cFYseeV0SJhPjTT30qaz12dA6qotlpH6/j6BY4hBBH+jXCMWmHgQlv0VO
         Qydw==
X-Gm-Message-State: AOAM53205hcYTOgPWENA6/bFI0M/WItJhXTS7JdaZ7PDyUHJXp40N8C4
        nDcVxfmVKqO1jnEhoeH3sG7T/g==
X-Google-Smtp-Source: ABdhPJyo/T9hm7YjTuV301fPaIYEHZj9LDTQUlrBqPYcVE69LpLlMnLME3GWdS0E06evh08MM9e/Qw==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr3492569wrm.145.1615881231181;
        Tue, 16 Mar 2021 00:53:51 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id c8sm2298077wmb.34.2021.03.16.00.53.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Mar 2021 00:53:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [BUG] block/bfq-wf2q: A Use After Free bug in bfq_del_bfqq_busy
From:   Paolo Valente <paolo.valente@linaro.org>
X-Priority: 3
In-Reply-To: <3c562db4.1111e.1782be320c5.Coremail.lyl2019@mail.ustc.edu.cn>
Date:   Tue, 16 Mar 2021 08:55:44 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        security@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <369719A6-7C64-451F-89C9-1A36436F9B82@linaro.org>
References: <24de85db.8011.1781a216e77.Coremail.lyl2019@mail.ustc.edu.cn>
 <275344D4-8DF4-4F7B-A3C9-592CE2DB0AC8@linaro.org>
 <3c562db4.1111e.1782be320c5.Coremail.lyl2019@mail.ustc.edu.cn>
To:     lyl2019@mail.ustc.edu.cn
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 13 mar 2021, alle ore 15:00, lyl2019@mail.ustc.edu.cn ha =
scritto:
>=20
>=20
>=20
>=20
>> -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Paolo Valente" =
<paolo.valente@linaro.org>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021-03-12 22:47:22 (=E6=98=9F=E6=
=9C=9F=E4=BA=94)
>> =E6=94=B6=E4=BB=B6=E4=BA=BA: lyl2019@mail.ustc.edu.cn
>> =E6=8A=84=E9=80=81: "Jens Axboe" <axboe@kernel.dk>, =
linux-block@vger.kernel.org, security@kernel.org
>> =E4=B8=BB=E9=A2=98: Re: [BUG] block/bfq-wf2q: A Use After Free bug in =
bfq_del_bfqq_busy
>>=20
>>=20
>>=20
>>> Il giorno 10 mar 2021, alle ore 04:15, lyl2019@mail.ustc.edu.cn ha =
scritto:
>>>=20
>>> File: block/bfq-wf2q.c
>>>=20
>>> There exist a feasible path to trigger a use after free bug in
>>> bfq_del_bfqq_busy, since v4.12-rc1. It could cause denial of =
service.
>>>=20
>>=20
>> Thank you very much for analyzing this.
>>=20
>>> In the implemention of bfq_del_bfqq_busy,
>>=20
>> I've checked all invocations of bfq_del_bfqq_busy, comments below.
>>=20
>>> it calls bfq_deactivate_bfqq()
>>> and use `bfqq` later. Whereas bfq_deactivate_bfqq() could free =
`bfqq`.
>>>=20
>>> The trigger path is as follow:
>>> |- bfq_deactivate_bfqq(.., bfqq, true, ..)
>>> |--  entity =3D &bfqq->entity;   // get entity
>>> |--  bfq_deactivate_entity(entity, true, ...); //has a path to free =
`bfqq`
>>> |--  if (!bfqq->dispatched) // use after free!
>>> 	=09
>>>=20
>>> |- bfq_deactivate_entity(entity, true, ...)
>>> |--  ...
>>> |--  for_each_entity_safe(entity, parent) { // in the first loop,
>>>                            //entity is the same as before
>>> 		if (!__bfq_deactivate_entity(entity, true)) {
>>>=20
>>> |- __bfq_deactivate_entity(entity, true)
>>> |--  ...
>>> |--  if (!ins_into_idle_tree || !bfq_gt(entity->finish, st->vtime))
>>> 		bfq_forget_entity(st, entity, is_in_service);=20
>>>=20
>>> |- bfq_forget_entity(st, entity, is_in_service)
>>> |--   bfqq =3D bfq_entity_to_bfqq(entity); // recover `bfqq` by =
entity
>>> |--	if (bfqq && !is_in_service)
>>> 		 bfq_put_queue(bfqq); // free the `bfqq`
>>>=20
>>=20
>> For this put to turn into a free, bfqq should have only one ref.  But
>> I did not find any invocation of bfq_del_bfqq_busy with bfqq->ref =3D=3D=
 1.
>>=20
>> Did you spot any?
>>=20
>> Looking forward to your feedback,
>> Paolo
>>=20
>>> The bug fix needs to add some checks to avoid freeing `bfqq` in the =
first
>>> loop in __bfq_deactivate_entity(). I can't come out a good patch for =
it,
>>> so i report it for you.
>>=20
>=20
> I the file block/bfq-iosched.c, function bfq_remove_request get bfqq =
by=20
> "RQ_BFQQ(rq);". Can we assume bfqq->ref =3D=3D1 at this time? After =
bfq_remove_request=20
> got the bfqq, there is no ref increase operation before calls =
bfq_del_bfqq_busy().
>=20

The scheme is: a ref is taken for a request arrival into a bfq_queue,
in __bfq_insert_request, and then that ref is released on the
completion of that request, in bfq_finish_requeue_request_body.  In
this respect, bfq_remove_request is invoked for a request only before
bfq_finish_requeue_request_body is invoked for the same request.  So
the bfq_del_bfqq_busy invocation that you highlight should not lead to
a free, because the ref counter should remain always higher than 0.
If you think I'm missing something (which is possible and welcome!),
try to write the sequence of events that leads to the free you
suspect, and to show that the counter actually reaches zero.  Recall
that a deactivate should be paired with an activation, and an
activation should always cause the ref counter to be increased.

Looking forward to your feedback,
Paolo

