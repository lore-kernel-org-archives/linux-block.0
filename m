Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8306CDB474
	for <linux-block@archiver.kernel.org>; Mon, 16 Oct 2023 20:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjJPUGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Oct 2023 16:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJPUGt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2023 16:06:49 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B38B0
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 13:06:47 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-419b232fc99so23093831cf.1
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697486807; x=1698091607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaHWZ++raSb5lyMsNQf39E3EcgWl93LaF644FrH4GdU=;
        b=hBIUf8VAGVmxV4BERjwzHyWP1LZP/hNjaKFR6sNPCtdtH4vuoyCxGksddkmE/dcVFj
         Ygtbyji8J132bRiUG7ku5RUgYUM+vMUxeBumpfMAqYjsrWOX5evBR8VBq+P/HwGn14S3
         Tjh8L1YhuUlxXHDL5QtAVQoGu7NG+30D2Um+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486807; x=1698091607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaHWZ++raSb5lyMsNQf39E3EcgWl93LaF644FrH4GdU=;
        b=ZO5K85ZYROg19VkG3hCPkxwfW+gFgbQtarqb6rWYIOv5aoeUybN1ab/d5VqtU4oP1q
         xh7VbUYklXeXpnfQnW1dfG9k51xJZsihTgc1IgU46YpL443zvC7/dcg3bAbYyuULrXV+
         cx+Bw98tW/ZASOYwqd+uzQa8MTchw0irk83fDvdwqiEoMFSFXXmVKXUn2h25ZQL30dRz
         qwxmG3VnIT+652XnTNwrAVU1ihPGAayyOnUgfa9SPer22JDzsXZXVMg2/jSTo5JIvpxr
         n9/l+Plnf7jzNuHstMdaK77R0cU7LqkGRVNrDnJWanvYJ6mK9WwEGFvVvPJYGYFGWeBY
         TcqQ==
X-Gm-Message-State: AOJu0YzIZvRbNbeeacPAn5KPjaAJ27Jqq7J+/api1ErqajJeUqOkhBAX
        If/1zVY+RayAK/fblONj42+Gmt99SRo/JY0wRe8=
X-Google-Smtp-Source: AGHT+IG/a4K4BPf9EecLMujdW2Y/FTmTFvBHHpfhPvyzVnR0woh4IruL2zFR+75BvhwcohqbTZ3AAg==
X-Received: by 2002:ac8:7c4e:0:b0:415:138e:d858 with SMTP id o14-20020ac87c4e000000b00415138ed858mr306226qtv.60.1697486806714;
        Mon, 16 Oct 2023 13:06:46 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id h5-20020ac87145000000b0041969bc2e4csm22330qtp.32.2023.10.16.13.06.45
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 13:06:45 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4195fe5cf73so9341cf.1
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 13:06:45 -0700 (PDT)
X-Received: by 2002:a05:622a:2c43:b0:418:1464:37bf with SMTP id
 kl3-20020a05622a2c4300b00418146437bfmr55093qtb.16.1697486805442; Mon, 16 Oct
 2023 13:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com> <20231005162417.GA32420@redhat.com>
 <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com> <20231007151607.GA24726@redhat.com>
 <21843836-7265-f903-a7d5-e77b07dd5a71@huaweicloud.com> <20231008113602.GB24726@redhat.com>
 <CACGdZY+OOr4Q5ajM0za2babr34YztE7zjRyPXHgh_A64zvoBOw@mail.gmail.com> <e9165cd0-9c9d-1d1a-1c5b-402556a1a31f@huaweicloud.com>
In-Reply-To: <e9165cd0-9c9d-1d1a-1c5b-402556a1a31f@huaweicloud.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Mon, 16 Oct 2023 13:06:31 -0700
X-Gmail-Original-Message-ID: <CACGdZYLxnL91S4RxfvLmN8j3rcvbsqdkouj4Lgc05mnCo2fZSw@mail.gmail.com>
Message-ID: <CACGdZYLxnL91S4RxfvLmN8j3rcvbsqdkouj4Lgc05mnCo2fZSw@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Li Nan <linan666@huaweicloud.com>,
        tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 15, 2023 at 6:47=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/10/14 5:51, Khazhy Kumykov =E5=86=99=E9=81=93:
> > Looking at the generic mul_u64_u64_div_u64 impl, it doesn't handle
> > overflow of the final result either, as far as I can tell. So while on
> > x86 we get a DE, on non-x86 we just get the wrong result.
> >
> > (Aside: after 8d6bbaada2e0 ("blk-throttle: prevent overflow while
> > calculating wait time"), setting a very-high bps_limit would probably
> > also cause this crash, no?)
> >
> > Would it be possible to have a "check_mul_u64_u64_div_u64_overflow()",
> > where if the result doesn't fit in u64, we indicate (and let the
> > caller choose what to do? Here we should just return U64_MAX)?
> >
> > Absent that, maybe we can take inspiration from the generic
> > mul_u64_u64_div_u64? (Forgive the paste)
> >
> >   static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy=
_elapsed)
> >   {
> > +       /* Final result probably won't fit in u64 */
> > +       if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
>
> I'm not sure, but this condition looks necessary, but doesn't look
> sufficient, for example, jiffy_elapsed cound be greater than HZ, while
> ilog2(jiffy_elapsed) is equal to ilog2(HZ).
I believe 62 is correct, although admittedly it's less "intuitive"
than the check in mul_u64_u64_div_u64()....

The result overflows if log2(A * B / C) >=3D 64, so we want to ensure that:
log2(A) + log2(B) - log2(C) < 64

Given that:
ilog2(A) <=3D log2(A) < ilog2(A) + 1  // truncation defn
It follows that:
-log2(A) <=3D -ilog2(A)  // Inverse rule
log2(A) - 1 < ilog2(A)

Starting from:
ilog2(A) + ilog2(B) - ilog2(C) <=3D X

We can show:
(log2(A) - 1) + (log2(B) - 1) + (-log2(C)) < ilog2(A) + ilog2(B) +
(-ilog2(C)) // strict inequality here since the substitutions for A
and B terms are strictly less
(log2(A) - 1) + (log2(B) - 1) + (-log2(C)) < X
log2(A) + log2(B) - log2(C) < X + 2

So for X =3D 62, log2(A) + log2(B) - log2(C) < 64 must be true, and we
must be safe from overflow.

So... by converse, if ilog2(A) + ilog2(B) - ilog2(C) > 62, we cannot
guarantee that the result will not overflow - thus we bail out.

// end math

It /is/ less exact than your proposal (sufficient, but not necessary),
but saves an extra 128bit mul.

I mostly just want us to pick /something/, since 6.6-rc and the LTSs
with the patch in question are busted currently. :)



>
> Thanks,
> Kuai
>
> > +               return U64_MAX;
> >          return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64=
)HZ);
> >   }
> >
> > .
> >
>
