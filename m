Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC26C77B75
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 19:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjEETzC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 15:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjEETzB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 15:55:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD91101
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 12:55:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so3873834a12.3
        for <linux-block@vger.kernel.org>; Fri, 05 May 2023 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683316499; x=1685908499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv8lvk1AbBLvhkSN9QZ33lzvEycfnFaITAOJMUFaHQA=;
        b=Hyx+9ZwETWFNgFL2zFcgjp8ZA+6ONl6SfOea54n7JwJeC61ZnZuI2l9VEgChaG2yvq
         eiJRlEXBbkjCD824CDMHW4PbA8N54d12CwnMi1O/79MLRj50vNwCxaiJUxpJi10WHoxJ
         JLUa5PPRZptR1nH/RVIRQuIGx1Lz41SQI2T68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683316499; x=1685908499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv8lvk1AbBLvhkSN9QZ33lzvEycfnFaITAOJMUFaHQA=;
        b=c2zEjBbOFlWAKSqRQyF1Wwv4HRqc80iqj2Ibo1zEpPlYlo00vbnU2MCyEf0KY/elio
         zY48SUSIDIHLyz/mRPkiP/VmV4EiAKBKgCrNu637dqpi7c53L1noov/cEISma3ishS1z
         Rf0zRL/kQ6Bc2qDmX5uwK3+JYEqgmmkV2D3zMcqnr1H37m3URsZzxEySsCzuwgWhbDLd
         tINYT4wc+BEjnp31W4bSsGC1EnPKmhp95GN5D0TryhHvfjxuKYkgkcEtyZRO9weZzuC9
         zzPwJeE79Il7bofV7fi31MxOKHKo/1r0z8NQmw5Jd4lNR75M7+MZSJJs8TiafbN4VYee
         ty4Q==
X-Gm-Message-State: AC+VfDxe3rkpTnU3iqFJ6S229PeoVQa74bdgGhowFrQSzYmAAYGnz3iI
        BezyzYgHDGTJ99LTE8SSEw6Cl8w0JqPAijO3wHkFWQ==
X-Google-Smtp-Source: ACHHUZ79MY/+FX66LwvaEzCWXPtFtRollGB3BTU3aIx7j8kFND0miClEdv9jCJpLnnYIEiTc+Pp+zA==
X-Received: by 2002:a17:907:96a1:b0:95f:f573:bf7e with SMTP id hd33-20020a17090796a100b0095ff573bf7emr2439542ejc.0.1683316498986;
        Fri, 05 May 2023 12:54:58 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id y25-20020a1709063a9900b0094f257e3e05sm1289958ejd.168.2023.05.05.12.54.57
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 12:54:58 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-94a34a14a54so432706266b.1
        for <linux-block@vger.kernel.org>; Fri, 05 May 2023 12:54:57 -0700 (PDT)
X-Received: by 2002:a17:907:e8e:b0:94f:969e:c52b with SMTP id
 ho14-20020a1709070e8e00b0094f969ec52bmr2399020ejc.74.1683316497433; Fri, 05
 May 2023 12:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-13-mathieu.desnoyers@efficios.com>
 <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com> <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
 <3cc72a67-d648-0040-6f60-37663797e360@efficios.com>
In-Reply-To: <3cc72a67-d648-0040-6f60-37663797e360@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 12:54:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com>
Message-ID: <CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com>
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

On Fri, May 5, 2023 at 11:49=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> I would add to this list of exceptions cases where the argument is used
> as an expression within brackets, e.g.
>
> #define m(x) myvar[x]

Yeah, that makes sense not because of any operator precedence rules,
but simply because brackets end up syntactically nesting just like
parentheses themselves do.

IOW, while you can mess up that nesting by having non-nested brackets
in the argument, that's equally true of any added parentheses too.

> The other exception I would add is when a parameter is used as an
> lvalue, as:
>
> #define m(x) do { x =3D 2; } while (0)

I really don't understand why you think '=3D' is so special. It's very
much not special.

It happens to have the lowest precedence, sure, but the keyword is "happens=
".

I think you are confused by the non-C languages that make assignment
be not an expression operator, but a statement.

So I think you are technically correct in that the parentheses aren't
_needed_, but the above is still the same case that in many other
situations parentheses aren't technically *needed*, but not having to
think about it is better than having to do so.

           Linus
