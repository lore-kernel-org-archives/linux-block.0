Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DE2C7EE29
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 16:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjEYQcG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 12:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjEYQcF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 12:32:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DB210B
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 09:32:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-514447e8578so1535289a12.0
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685032322; x=1687624322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNfCUobrUAUA40iHcw/nxcay95zNsz3B8ogepnZvesE=;
        b=ICrIOcda6AMBM43VWJv1RHuhunVTuDPpT0zRfXFYeuhYKUr3/W0YGlGBjpzXRuEhfR
         pZgQNdwUs9/cJ754n8Gmsen8YXfpWb3qJ5qN7bo2MOmneMamy/3ca2DU5yQM3XySfjse
         KlXCC8TTRmW9wapoybBWA4OtF5xiKLzoWcv2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685032322; x=1687624322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNfCUobrUAUA40iHcw/nxcay95zNsz3B8ogepnZvesE=;
        b=V7qE2e2K0oThyA90l/IlNB70afHPsU5XYCH8N0VfwqX3Oij6Ly6dKWYPaWq28K63NE
         Q2kRL/j2b0E69eawHT3Vq6G/NssrMypY6sEWoe1Dsm+nenrPZwuWcaHfcEWsi7XsbDHy
         0K3l28WmnbZUNYVUgTwF1s9atY075Kv2G5OegM6ZhWKoMtx+bAcHl7mU3eT7gs1edp2I
         ehJvx43KbtoUYf4fQUw4lcFes4ct5T1RKIsDygAyqPIUnquPTlQ/CRAyapZL68PX51dA
         Obqa+bSFerXzZMh0dYrD9n2ki526tiL+VBRW72FyaUp0EC+pBZHuqZgfSKdt8Xs/5XBM
         R59Q==
X-Gm-Message-State: AC+VfDznhhXEVOm7OgRnHpX81XkF1JGI8y1mpV8i12UCcBiE+lFlK7n1
        0rbGLyxlSgYY8eu9o5o07Yha23eM3u8zQtuIIVjBbxZd
X-Google-Smtp-Source: ACHHUZ7eyg3LmREASbmg+MQgT3YIqsckx0y/8w2hQt8JlwFwgbzSJOeeoJdDvSTeZAPZcfryO7f89Q==
X-Received: by 2002:a17:907:1c8c:b0:973:93c3:16a1 with SMTP id nb12-20020a1709071c8c00b0097393c316a1mr2267233ejc.19.1685032322372;
        Thu, 25 May 2023 09:32:02 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709064d4800b00965f31ff894sm1034415ejv.137.2023.05.25.09.32.01
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:32:01 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-514447e8578so1535232a12.0
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 09:32:01 -0700 (PDT)
X-Received: by 2002:a17:907:a407:b0:96f:5511:8803 with SMTP id
 sg7-20020a170907a40700b0096f55118803mr1880847ejc.22.1685032321217; Thu, 25
 May 2023 09:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org> <3215177.1684918030@warthog.procyon.org.uk>
In-Reply-To: <3215177.1684918030@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 09:31:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
Message-ID: <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
Subject: Re: Extending page pinning into fs/direct-io.c
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 24, 2023 at 1:47=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> True - but I was thinking of just treating the zero_page specially and ne=
ver
> hold a pin or a ref on it.  It can be checked by address, e.g.:
>
>     static inline void bio_release_page(struct bio *bio, struct page *pag=
e)
>     {
>             if (page =3D=3D ZERO_PAGE(0))
>                     return;

That won't actually work.

We do have cases that try to use the page coloring that we support.

Admittedly it seems to be only rmda that does it directly with
something like this:

        vmf->page =3D ZERO_PAGE(vmf->address);

but you can get arbitrary zero pages by pinning or GUPing them from
user space mappings.

Now, the only architectures that *use* multiple zero pages are - I
think - MIPS (including Loongarch) and s390.

So it's rare, but it does happen.

             Linus
