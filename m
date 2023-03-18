Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2E1C74A5B
	for <linux-block@archiver.kernel.org>; Sat, 18 Mar 2023 18:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCRSUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Mar 2023 14:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCRSUp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2023 14:20:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA3F25976
        for <linux-block@vger.kernel.org>; Sat, 18 Mar 2023 11:20:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o12so32169097edb.9
        for <linux-block@vger.kernel.org>; Sat, 18 Mar 2023 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679163641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx8RcyjGbjYoysYjRF/7k04CTiu60fPMXIq+lfuhvoc=;
        b=MRcSROQn1tpKqbDALq1faBS3ChqwPnWc9YUm7698f3nMFZ8HVf4NfNs17ErBoCP/h3
         ZvqaBafV27apM27pLnGysIHyaxQIQ8VKQtERqy6AeoSWutu8skTZYZpmwCtNtsBwfq3S
         X80yKmH2wphT9MGNdllZSbaRK1ascZGKpw5y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679163641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx8RcyjGbjYoysYjRF/7k04CTiu60fPMXIq+lfuhvoc=;
        b=mKS4zzTt8DfTfM9Qf4ibT24L0R7ULmG2AKmHu+lwhvOyWE4dSMARxHg3tq9fQPrGmz
         orUy1mSL8SNMYwxIJ8vS3MK4FXPxyoLpx+JgW05o2qm2VYQmLoW4Z3DSYBZD7dXFPkIE
         oB9HdUCxk2kp5x748lAi4GY4M46PQi2rtYaaWXgvRarwkkTfx/vlnzvB0+I4dIzo3tge
         yaZMHq08L/Beu4NQzC0KjjW32gZHa5gWTiKO/NDz63NWgceqWGuDwkJaf3ldCm42UI4L
         TOCig4Eny2KTfk+tUWkdW2JTqNTeBlD8QOIZfuR0CvMPIlJDT/HMiz5/O9HuFxEPfvSB
         g6Yg==
X-Gm-Message-State: AO0yUKXnWqk+jmyEcnNwAWPEXlCy0g4JWw2gzLU9OnN2JPivw+SGYheU
        2o6dqwtLchOW3OqC4IxJvFzaV9pPEI5SJt33qF5+SA==
X-Google-Smtp-Source: AK7set++QH7NGc/el0cnE7HEp8j4NwPw/DANhq5cDNNPIl73pT1+1KabzqjH3H5uin5+W7xzYMmFiw==
X-Received: by 2002:a17:906:4b4a:b0:8aa:c090:a9ef with SMTP id j10-20020a1709064b4a00b008aac090a9efmr3499267ejv.55.1679163641102;
        Sat, 18 Mar 2023 11:20:41 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 21-20020a508755000000b004fc920655basm2673882edv.54.2023.03.18.11.20.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 11:20:39 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id eh3so32151655edb.11
        for <linux-block@vger.kernel.org>; Sat, 18 Mar 2023 11:20:39 -0700 (PDT)
X-Received: by 2002:a50:ce54:0:b0:4fa:794a:c0cc with SMTP id
 k20-20020a50ce54000000b004fa794ac0ccmr3796617edj.2.1679163639042; Sat, 18 Mar
 2023 11:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
 <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
 <CAKwvOdmJkQUe6bhvQXHo0XOncdso0Kk26n8vdJZufm4Ku72tng@mail.gmail.com>
 <6414c470.a70a0220.6b62f.3f02@mx.google.com> <CAHk-=wi5yk0+NeqB34fRC-Zvt+8QZVPTiny9MvCxxjg+ZqDhKg@mail.gmail.com>
 <CANiq72m46OzQPtZbS_VaQGgGknFV-hKvhBw8sVZx9ef=AzupTQ@mail.gmail.com> <CAHk-=wgTSdKYbmB1JYM5vmHMcD9J9UZr0mn7BOYM_LudrP+Xvw@mail.gmail.com>
In-Reply-To: <CAHk-=wgTSdKYbmB1JYM5vmHMcD9J9UZr0mn7BOYM_LudrP+Xvw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Mar 2023 11:20:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYUWaa676WN5hoyarKeKFDq3nfPg0haRRXeirtHyMg=A@mail.gmail.com>
Message-ID: <CAHk-=wiYUWaa676WN5hoyarKeKFDq3nfPg0haRRXeirtHyMg=A@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "HeungJun, Kim" <riverful.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 1:51=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do think that on the kernel side, the fix is to just change
>
>         } while (type++ !=3D SIZE_DEFAULT_FFMT);
>
> to
>
>         } while (++type !=3D SIZE_DEFAULT_FFMT);

Ok, I ended up deciding to just commit that minimal change, even
though it might have been better to just make it a normal for-loop
(and use M5MOLS_RESTYPE_MAX instead as the end condition).

So maybe it would be more legible (and less likely to have had that
off-by-one) if the loop had been

        for (type =3D 0; type < M5MOLS_RESTYPE_MAX; type++)

instead. But I'll leave that decision to the driver authors (now cc'd).

For people brought in late, this is now commit efbcbb12ee99 ("media:
m5mols: fix off-by-one loop termination error") with link to the
discussion here

    https://lore.kernel.org/linux-block/CAHk-=3DwgTSdKYbmB1JYM5vmHMcD9J9UZr=
0mn7BOYM_LudrP+Xvw@mail.gmail.com/

so you can see the history of it (me having initially blamed UBSAN,
but the problem can be triggered at least in theory without it).

                  Linus
