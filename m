Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38489C30632
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 14:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352020AbjHQOin (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 10:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352087AbjHQOil (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 10:38:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90C730D6
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 07:38:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b974031aeaso122002881fa.0
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692283118; x=1692887918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9vWSNOyQ40/a//fJoXOBwGUU2y6drxoj4nh46dmg+4=;
        b=f0DQNOu2XllsKp9A83uUucKVByjF5khsYOV8Y0ek4Xwwpx1SxPDzzOUlX1hhpYtT0Q
         tm03gvimjn641e1zxTf3Bute5qUBdkUDwjAz74eEkos0PmytErGZ7oPOsV4tRtaDFgNt
         w+oPgfaZeB8R0O4GghoyquLvtEE/jLlyQJtMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283118; x=1692887918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9vWSNOyQ40/a//fJoXOBwGUU2y6drxoj4nh46dmg+4=;
        b=LlMhePnvtBQ07NyctLrmnvqBM+v05yLJoGbIWbhNE3wruq073nUDpe+H80xD1h0lgO
         tycwL4PNdURuJ1YhKQOZyHN+h1cqXvsxcT+r/XUjA4+h9yai/fRE+OOx+hGqLglgNM/F
         noCbtwpTRG3lI05+QJ2gy6R6ntWxT/5yInqS44iuyi/Hevni5wFfhVAo7R8r4EZ7S1yz
         1XPzf92HMup7FUtFz4HTWLx1sdLHo7O0KZl6AOZeKNzAR+oiMTNVJKOmtoCFcd8QUZYu
         Aby5lZF2REWPHBu5gx7EVy7F8rFw7bOPFfpdqqBy9Xganqvu9UDZXS428Icu6ng76UxR
         CelQ==
X-Gm-Message-State: AOJu0Yyw0buVOVlLvjCCeXVQfOYQJaFGQq9nv2zhTQ5wq0mZE2q08EeW
        ekijefAv1S064w+IkJc1YCZnxeevWYSz8rAPkxbmqeE9
X-Google-Smtp-Source: AGHT+IGd3r6aJpCFVdexJGXuWEfL0u0y7eYhwmvnY27n1VpMXW0Y931Cg+Walcu/uexcezSvSF4R1g==
X-Received: by 2002:a2e:b6ce:0:b0:2b9:b4eb:c39c with SMTP id m14-20020a2eb6ce000000b002b9b4ebc39cmr5339845ljo.8.1692283117954;
        Thu, 17 Aug 2023 07:38:37 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906660c00b00992c92af6f4sm10263574ejp.144.2023.08.17.07.38.36
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 07:38:36 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99357737980so1030891766b.2
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 07:38:36 -0700 (PDT)
X-Received: by 2002:a17:907:a067:b0:99c:570a:e23e with SMTP id
 ia7-20020a170907a06700b0099c570ae23emr5392064ejc.24.1692283115907; Thu, 17
 Aug 2023 07:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
 <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
 <665724.1692218114@warthog.procyon.org.uk> <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
 <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com>
In-Reply-To: <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Aug 2023 16:38:18 +0200
X-Gmail-Original-Message-ID: <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
Message-ID: <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
To:     David Laight <David.Laight@aculab.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 17 Aug 2023 at 10:42, David Laight <David.Laight@aculab.com> wrote:
>
> Although I'm not sure the bit-fields really help.
> There are 8 bytes at the start of the structure, might as well
> use them :-)

Actually=C3=A7 I wrote the patch that way because it seems to improve code
generation.

The bitfields are generally all set together as just plain one-time
constants at initialization time, and gcc sees that it's a full byte
write. And the reason 'data_source' is not a bitfield is that it's not
a constant at iov_iter init time (it's an argument to all the init
functions), so having that one as a separate byte at init time is good
for code generation when you don't need to mask bits or anything like
that.

And once initialized, having things be dense and doing all the
compares with a bitwise 'and' instead of doing them as some value
compare again tends to generate good code.

Then being able to test multiple bits at the same time is just gravy
on top of that (ie that whole "remove user_backed, because it's easier
to just test the bit combination").

> OTOH the 'nofault' and 'copy_mc' flags could be put into much
> higher bits of a 32bit value.

Once you start doing that, you often get bigger constants in the code strea=
m.

I didn't do any *extensive* testing of the code generation, but the
stuff I looked at looked good.

               Linus
