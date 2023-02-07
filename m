Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9825AC636CC
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 19:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjBGTJ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 14:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBGTJ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 14:09:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB8298C4
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 11:09:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n13so11750405wmr.4
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 11:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/n3a3WEivcW8sAV5wyEILdqLrkNxDcEUpLKGmNfk7jI=;
        b=ddasHqAa0E9yK1S96YnKAu6/DAT3yiPo7GUsTdjv4nlES2M324WvvK4RdM5FvBOeBF
         stIuAYlv2yI9HqAJiXfvu1WsRHgHIQc4S72EmoX9Nez5Ly2YF3iVgnui4xYg9Yl5+mQ1
         730miCTKjFS7JO9J1qlY81YoTNLTqKxXga97s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/n3a3WEivcW8sAV5wyEILdqLrkNxDcEUpLKGmNfk7jI=;
        b=Cg7MrwRfADJSdVnZPVE8+FT8+zx8spd3AiZ4/km9rjAG91DnTzIw3uoG8ZYHUGxnfn
         kuG0zCFuM9nVrCbcNkQo+3iD1lF+d0/1CPLg3pwfvE5BKowCiB6q/dNUghMucfKmSMqa
         DDrmALN3ik+sgfo9h3/cO27+tiycUToCRefTFC7TmI59ZQp7BGeSKugh+QfR51ySj2ua
         FdvI/BbTdOKrWlHLVP+EN83Ds++GQ4+P8uWioAeeWwuw5s3WobqQeS8j90Z2d2hrDTAj
         C98u9O4dro8i+q+JoSm2CF/ZBp5XH9Tu3YdKYA+BklyajC5eCWo7DtOZkvhVOirB+16z
         znjA==
X-Gm-Message-State: AO0yUKXXTi+c/5/zcGiJfunYm+GF8U/SDR7VsbiQSlgUgav/rz8tjmqv
        QxGgK2K/VOykruJlNO8KaaJcbw66uJHLwOqfHCng3A==
X-Google-Smtp-Source: AK7set+YKhKV7BWFk6xu9ObZKVxwHa3A3wWJgmjjd/kGOr2nlvV6916zZSg0kl7xeuGuRjahRR8Bzw==
X-Received: by 2002:a05:600c:4393:b0:3de:1d31:1043 with SMTP id e19-20020a05600c439300b003de1d311043mr3919734wmn.21.1675796990119;
        Tue, 07 Feb 2023 11:09:50 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id c17-20020a7bc851000000b003dc530186e1sm19953172wml.45.2023.02.07.11.09.48
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 11:09:49 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id fi26so17404983edb.7
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 11:09:48 -0800 (PST)
X-Received: by 2002:a50:f604:0:b0:4aa:9bd9:d81b with SMTP id
 c4-20020a50f604000000b004aa9bd9d81bmr1162081edn.70.1675796988297; Tue, 07 Feb
 2023 11:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org> <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam> <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
 <Y+KP/fAQjawSofL1@gmail.com> <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
 <Y+KaGenaX0lwSy9G@gmail.com> <CAHk-=whL+9An7TP-4vCyZUKP_2bZSLe-ZFR1pGA1DbkrTRLyeQ@mail.gmail.com>
In-Reply-To: <CAHk-=whL+9An7TP-4vCyZUKP_2bZSLe-ZFR1pGA1DbkrTRLyeQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2023 11:09:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdr07iKGF2+9yPyW3SQN9qry_R0R45XYmdHHK1iFWNAQ@mail.gmail.com>
Message-ID: <CAHk-=wgdr07iKGF2+9yPyW3SQN9qry_R0R45XYmdHHK1iFWNAQ@mail.gmail.com>
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

On Tue, Feb 7, 2023 at 10:57 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Looking at Jens' reply to the other cases, Dan's tool seems to be on
> the money here except for this self-inflicted bogus crypto key thing.

Oh, except you probably wouldn't have seen it, because Jens replied to
the original message where you weren't cc'd.

So here's the context for you wrt the other parts of the report:

  https://lore.kernel.org/all/4321724d-9a24-926c-5d2d-5d5d902bda72@kernel.dk/

where there isn't that same indirection through the super-block, but
more of a clear-cut "this is all in the block layer".

           Linus
