Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E145C636CC
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 19:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBGTzg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 14:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjBGTza (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 14:55:30 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FE032503
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 11:55:28 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u12so23960141lfq.0
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 11:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uEXUUXABVU5CpTmI5+WPS3SAiFl2iysjHXRNiSK+RSc=;
        b=NAsrX48xgJfvmnA63/xN8z3ZNZj9KxhAXx9sVPZSipkeGUbQZK47jEZLSxQAZsoKtm
         uQ+0JBwWNuQtqirsFeDAtYVMB9CkREBLzlQqNmAHL0HRnjhjNe2yZnNWhsT7bMRWJVeU
         +5n5j4hE+CqIu6Y+15dkIxcIqIZBV5aROnWdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEXUUXABVU5CpTmI5+WPS3SAiFl2iysjHXRNiSK+RSc=;
        b=S/+O+NFmZBKYfiYqJX5JgqqpMwdMI4nWsCgQFQA8HP5oM/EcUrOEvN6FtoAWcaBwXv
         hGmk7M9Y16+XeknNT04hvHqET3XIVwk3NyBuPMS4oOaVKiIh2gAsLXmEaTdzLGxCV1Gh
         SAhQ7FyoHPaD/iM7Jc4IdQYoza/g0/JgYkDl5o+nNdPWNo0HY6mnso2GzjNuic2KdL9M
         LvnSPI3QAiVo8n+NJh0U/e0uGfAFU9xNJYFnulyAK+AozZ5Si7Qea6VEY2puKobfqcKD
         KCW1OZQA5JvN+mja8lc5+rlXz4BgcpAVlW5cqYs20eXbaSvcSUQEBPN9E2J0ZxOaawzz
         I1Pg==
X-Gm-Message-State: AO0yUKUR9xEJuNLwBLrWZY5u5dQO+dfjE3JR90lHaKWWROwm9Lp0oQ7i
        G6JNWHbAZEIMkNzKHq/iR2rXatO/iO3r4emrz5uaXA==
X-Google-Smtp-Source: AK7set+p4IRELVQqiVjTIPYt3t0j6JJEoe/ZP+cXT8BxlNGmfAVKykhdgrwMVy5Y+dd4bkO/GOGFYA==
X-Received: by 2002:ac2:5ec5:0:b0:4b0:1305:6e02 with SMTP id d5-20020ac25ec5000000b004b013056e02mr1148867lfq.8.1675799726142;
        Tue, 07 Feb 2023 11:55:26 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id u24-20020a196a18000000b004b7033da2d7sm1084306lfu.128.2023.02.07.11.55.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 11:55:25 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id h17so16846889ljq.4
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 11:55:25 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr1026268ejw.78.1675799372087; Tue, 07 Feb
 2023 11:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org> <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam> <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
 <Y+KP/fAQjawSofL1@gmail.com> <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
 <Y+KaGenaX0lwSy9G@gmail.com> <CAHk-=whL+9An7TP-4vCyZUKP_2bZSLe-ZFR1pGA1DbkrTRLyeQ@mail.gmail.com>
 <Y+KoGikLhfhDoMWv@gmail.com>
In-Reply-To: <Y+KoGikLhfhDoMWv@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2023 11:49:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdCBPH0WYK-D5q60u1hvwTabKETWTsEKYXNRgx4tGOPA@mail.gmail.com>
Message-ID: <CAHk-=whdCBPH0WYK-D5q60u1hvwTabKETWTsEKYXNRgx4tGOPA@mail.gmail.com>
Subject: Re: block: sleeping in atomic warnings
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dan Carpenter <error27@gmail.com>, linux-block@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 7, 2023 at 11:35 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> The point of the "test_dummy_encryption" mount option is that you can just add
> it to the mount options and run existing tests, such as a full run of xfstests,
> and test all the encrypted I/O paths that way.  Which is extremely useful; it
> wouldn't really be possible to properly test the encryption feature without it.

Yes, I see how useful that is, but:

> Now, it's possible that "the kernel automatically adds the key for
> test_dummy_encryption" could be implemented a bit differently.  It maybe could
> be done at the last minute, when the key is being looked for due to a user
> filesystem operation, instead of during the mount itself.

Yeah, that sounds like it would be the right solution, and get rid of
the fscrypt_destroy_keyring() case in __put_super().

Hmm.

I guess the filesystem only ever sees the '->get_tree()' call, and
then never gets any "this mount succeeded" callback.

And we do have at least that

        error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
        if (unlikely(error)) {
                fc_drop_locked(fc);
                return error;
        }

error case that does fc_drop_locked() -> deactivate_locked_super() ->
put_super().

Hmm. It does get "kill_sb()", if that happens, so if

 (a) the filesystem registers the keys late only in the success case

and

 (b) ->kill_sb() does the fscrypt_destroy_keyring(s)

then I *think* everything would be fine, and put_super() doesn't need to do it.

Or am I missing some case?

                Linus
