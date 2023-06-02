Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE62AC7EE24
	for <linux-block@archiver.kernel.org>; Fri,  2 Jun 2023 16:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjFBQhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jun 2023 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjFBQhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jun 2023 12:37:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBFB194
        for <linux-block@vger.kernel.org>; Fri,  2 Jun 2023 09:37:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9700219be87so325865666b.1
        for <linux-block@vger.kernel.org>; Fri, 02 Jun 2023 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685723833; x=1688315833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzJT3HyKG2J4xiGoewlppsTGaruPJowM8pRCfo3JmUA=;
        b=YSWipyxtRYE4aRsDx5kpWeNsJaCCphIsrGhQvjZ+/BMhyCSkf4uEQLXkrVhWP7CDlu
         qN17+0sbc3gtoOv5SZ2CUZ68i8hS72K0bHyO0AqBAYkzVnsWGpQbFZqdLfe0L7n1Ewf6
         WSGhzHTQoSTj8eo9ruZ5OJukGtLsMqqkI5OJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723833; x=1688315833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzJT3HyKG2J4xiGoewlppsTGaruPJowM8pRCfo3JmUA=;
        b=M3sl2U/rPOU7P3AJAUu7EkJ4r//O6HaMcFz1HYD+BNLkFGISFKC9fkm8lf7q5junun
         b+ofKQy6YTiel6ED/WrmDG8HvwKegrQoxzPBeogDhNhlP0C9XuDN5KV6u2wje47+ebTV
         lXnY63gJo34BrvIciCAaXrfo5QQ+qLu6ZMpUXzMAQ2CG3KYsbt5y46oMjXjX2yf0x81v
         OMWz5q9Zv+7EKzHF2fipj1s9jazcUImJ2QXnBZhbsTTyRhBDd5mD8mNiq2DvEN9xV9Wr
         6S9i513wNl76MOH73XCsHI41K0t7crofoJeTFZoKOcbUajl2wHNxbsLJMWsHa8IWxxI+
         wTfA==
X-Gm-Message-State: AC+VfDw4t0A6M10V/UU0Jtj1Xq6tmHeisn4CaXzpZwRRo3XPahQoDIYP
        9x+JRqPemBBB97DhbCCHmoDegUEAybGZIL3sPiFoeKhZ
X-Google-Smtp-Source: ACHHUZ64GM8CZAnbNOJoJqjmkX0SfBgJd88e3Q/5tXGkrZtHCeOQMOwTugVUamemRcRCgrOhtA1nZA==
X-Received: by 2002:a17:907:6088:b0:973:e034:fd47 with SMTP id ht8-20020a170907608800b00973e034fd47mr12085492ejc.29.1685723832734;
        Fri, 02 Jun 2023 09:37:12 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id n12-20020a170906118c00b0096fbc516a93sm916464eja.211.2023.06.02.09.37.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 09:37:12 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-96fbe7fbdd4so325105166b.3
        for <linux-block@vger.kernel.org>; Fri, 02 Jun 2023 09:37:12 -0700 (PDT)
X-Received: by 2002:a2e:7302:0:b0:2af:1681:2993 with SMTP id
 o2-20020a2e7302000000b002af16812993mr311009ljc.49.1685723811492; Fri, 02 Jun
 2023 09:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230602150752.1306532-1-dhowells@redhat.com> <20230602150752.1306532-6-dhowells@redhat.com>
In-Reply-To: <20230602150752.1306532-6-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 12:36:34 -0400
X-Gmail-Original-Message-ID: <CAHk-=wg-9vyvbQPy_Aa=BQmkdX7b=ANinNUU+22tMELuxmH99g@mail.gmail.com>
Message-ID: <CAHk-=wg-9vyvbQPy_Aa=BQmkdX7b=ANinNUU+22tMELuxmH99g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/11] splice, net: Fix SPLICE_F_MORE
 signalling in splice_direct_to_actor()
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 2, 2023 at 11:08=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Fix this by making splice_direct_to_actor() always signal SPLICE_F_MORE i=
f
> we haven't yet hit the requested operation size.

Well, I certainly like this patch better than the previous versions,
just because it doesn't add random fd-specific code.

That said, I think it might be worth really documenting the behavior,
particularly for files where the kernel *could* know "the file is at
EOF, no more data".

I hope that if user space wants to splice() a file to a socket, said
user space would have done an 'fstat()' and actually pass in the file
size as the length to splice(). Because if they do, I think this
simplified patch does the right thing automatically.

But if user space instead passes in a "maximally big len", and just
depends on the kernel then doing tha

                ret =3D do_splice_to(in, &pos, pipe, len, flags);
                if (unlikely(ret <=3D 0))
                        goto out_release;

to stop splicing at EOF, then the last splice_write() will have had
SPLICE_F_MORE set, even though no more data is coming from the file,
of course.

And I think that's fine. But wasn't that effectively what the old code
was already doing because 'read_len' was smaller than 'len'? I thought
that was what you wanted to fix?

IOW, I thought you wanted to clear SPLICE_F_MORE when we hit EOF. This
still doesn't do that.

So now I'm confused about what your "fix" is. Your patch doesn't
actually seem to change existing behavior in splice_direct_to_actor().

I was expecting you to actually pass the 'sd' down to do_splice_to()
and then to ->splice_read(), so that the splice_read() function could
say "I have no more", and clear it.

But you didn't do that.

Am I misreading something, or did I miss another patch?

               Linus
