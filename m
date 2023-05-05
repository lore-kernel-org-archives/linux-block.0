Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137E7C77B7D
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 20:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjEEUXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 16:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjEEUXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 16:23:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697F9C3
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 13:23:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso392552866b.2
        for <linux-block@vger.kernel.org>; Fri, 05 May 2023 13:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683318179; x=1685910179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL4O4xBkvv61r8l6fiCzi2l8LZqK+hvp7Gt2L2M0kwA=;
        b=Oykg45fTdrjAbY7eTF+V20gWgchrThB6dOjgbfRUrV1Kck6I16pUPviTyqrqjHqAiP
         TnC7UCf+c5OdiFhpfpupimUE29Y1qAdpBx0xAl3K5IQI7MO3FSiWS9bpRvLEJhjcTOaV
         kdakVLv/4CObDj6PG19nXp0JJSbAj+kKnOwwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683318179; x=1685910179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL4O4xBkvv61r8l6fiCzi2l8LZqK+hvp7Gt2L2M0kwA=;
        b=VBEBhwcruFYLt3GtxY1JMZDfgrZJRr0IIkU4fAPS6o6wMGB9M2RWGeabTFygEzeJhW
         vo54v6ejwXy7JA+RGV7hH2HKL+BzY5AbrXdJxOOH07WSqBUVh/SQKAYpd5NMSxyWOnwd
         wLaq1laSWYy3hxIGzB/QzCpex9weuCCEO0Vi4xpRovdfOH1Cvgj/u0XFb+KyaJb6cAZz
         aSs7vVCBRzQfSF0RBU5+1bu2dORHf9A5/1VLpWbMyAWixNafas6tF58XJbOnfaY6LOGm
         I/GCY/LfA+/o3GnyftZh+gKPno11m4zpq4RhUzZZT/hnAD5YHxSZrnGGUdOUP7k50AYF
         7efg==
X-Gm-Message-State: AC+VfDw/bImoxbwNQePGR1M919wFKsO4z88qRMN4imXg2dIbcR0k6NJm
        kVp+KDuauBz1GKs9xa897i1/nbCbGvYDfgrnIfJC7g==
X-Google-Smtp-Source: ACHHUZ7zHGfa28VGxisrkmxOTJKUbAYMD427JD8+U7X/+FzyhYJ8yLdvMyAb+56RwpF5o3lyw+2rmw==
X-Received: by 2002:a17:907:36c4:b0:960:6489:b2ff with SMTP id bj4-20020a17090736c400b009606489b2ffmr2125508ejc.31.1683318178706;
        Fri, 05 May 2023 13:22:58 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id jy1-20020a170907762100b0094e6a9c1d24sm1348867ejc.12.2023.05.05.13.22.57
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 13:22:58 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso392548666b.2
        for <linux-block@vger.kernel.org>; Fri, 05 May 2023 13:22:57 -0700 (PDT)
X-Received: by 2002:a17:906:9b89:b0:965:a5b5:e075 with SMTP id
 dd9-20020a1709069b8900b00965a5b5e075mr2580600ejc.75.1683318177525; Fri, 05
 May 2023 13:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-13-mathieu.desnoyers@efficios.com>
 <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com> <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
 <3cc72a67-d648-0040-6f60-37663797e360@efficios.com> <CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com>
 <d8dfd1af-5b82-ddd8-24f5-fa9dfbb4b1fb@efficios.com>
In-Reply-To: <d8dfd1af-5b82-ddd8-24f5-fa9dfbb4b1fb@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 13:22:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg27iiFZWYmjKmULxwkXisOHuAXq=vbiazBabgh9M1rqg@mail.gmail.com>
Message-ID: <CAHk-=wg27iiFZWYmjKmULxwkXisOHuAXq=vbiazBabgh9M1rqg@mail.gmail.com>
Subject: Re: [RFC PATCH 12/13] blk-mq.h: Fix parentheses around macro
 parameter use
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 5, 2023 at 1:08=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> The reason why I think the lvalue of a "=3D" operator can be argued to be
> "special" is because it is simply invalid to apply many of the C
> operators to an lvalue (e.g. +, -, /, ...),

Mathieu, you are simply objectively wrong.

See here:

  #define m1(x) (x =3D 2)
  #define m2(x) ((x) =3D 2)

and then try using the argument "a =3D b" to those macros.

Guess which one flags it as an error ("lvalue required") and which one does=
 not?

m2 is the only "good" one. Yes, m1 works in 99% of all cases in
practice, but if you want a safer macro, you *will* add the
parentheses.

So *STOP*ARGUING* based on an incorrect "lowest precedence" basis.
Even for the "lowest precedence" case, you have the *same* precedence.

The fact is, assignment is not in any way special operation in macros,
and does not deserve - and should absolutely not have - any special
"doesn't need parentheses around argument" rules.

           Linus
