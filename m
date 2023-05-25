Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F61DC7EE29
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 17:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjEYRRj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 13:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjEYRRi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 13:17:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24702B6
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:17:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f9cfa7eddso162405266b.2
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685035055; x=1687627055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TG2KiabOTIRDETeuidPveq5vd/DC84WzmbIAz8Xbn0=;
        b=I1UXhhMny59jRMNBe8QuD/3GrYMpDqAeNOO04Q2PakDjtxMEi4bd4E6d7pqAWOuZie
         1VUf5LS3CJ8JM9LyWHaSyPCDbbrdwgq06kWbLVu9OJSGQayBTu5PXVxWEl8GBbOOU8pO
         E+o0B7bWRItdmw09lDzLwop4jaNCQ0LsrjtSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035055; x=1687627055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TG2KiabOTIRDETeuidPveq5vd/DC84WzmbIAz8Xbn0=;
        b=AYCF2qr8acvHLmUwoZvMYL4t2lhjnRm15C8owjH5tfJBp1z4V6a+FAcwthadmD9ryU
         iZdGUjtKCYvsQdS7QvOs6g/OUKutxypnYvUj2JvM0ozHgr47lxRHhK+A9DRthSWs6owV
         p5UtrSMakNs1X29EZkNE3TvvIotzOW84ST4OoiidLvTguDEivShWhqbQ6pA7S7zd8pU/
         5UFPwL47xJcRrTDT+PR+JrsPR65CrE38o1LeuSftzjzT/kDthOI4tczuC0LLXRqKuOJ9
         qqrdKKFvsrgWkNzXwIRsEb26BaHUXZw8rIHWjJKfKcYx6UyxzYvQUv8HIkfy2V295+bJ
         tEvg==
X-Gm-Message-State: AC+VfDwKKqAdokHRZz8zmy5izSnYr4XtN8BbHjxGhlD/cW/v7kleshqi
        9Rl7JAE/+c7ZnXky2MmHHxTtiGrkDpVhyX61+cVXHFkf
X-Google-Smtp-Source: ACHHUZ6i/bVIf4ZtPpD868CGaQhEMmdhcjvXHFn1I1tipRU6IPQvv/Nq8sJohxkiUKvcCt9PBtASBg==
X-Received: by 2002:a17:907:9349:b0:966:4d99:b0aa with SMTP id bv9-20020a170907934900b009664d99b0aamr2097777ejc.59.1685035055504;
        Thu, 25 May 2023 10:17:35 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id f6-20020a1709064dc600b0094f4d2d81d9sm1114186ejw.94.2023.05.25.10.17.34
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:17:34 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-96f53c06babso162093466b.3
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:17:34 -0700 (PDT)
X-Received: by 2002:a17:907:9289:b0:96a:6723:da48 with SMTP id
 bw9-20020a170907928900b0096a6723da48mr1860929ejc.75.1685035054236; Thu, 25
 May 2023 10:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org>
 <3215177.1684918030@warthog.procyon.org.uk> <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
 <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com> <98511.1685034443@warthog.procyon.org.uk>
In-Reply-To: <98511.1685034443@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:17:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wht8Z=Vm-WkvZ2fMcBkF+CZSwm0nMpbtFoKc5_o+0oEbQ@mail.gmail.com>
Message-ID: <CAHk-=wht8Z=Vm-WkvZ2fMcBkF+CZSwm0nMpbtFoKc5_o+0oEbQ@mail.gmail.com>
Subject: Re: Extending page pinning into fs/direct-io.c
To:     David Howells <dhowells@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
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

On Thu, May 25, 2023 at 10:07=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Should everywhere that is using ZERO_PAGE(0) actually be using my_zero_pf=
n()?

No, that would just make code uglier for no reason, because then you
have to turn that pfn into a virtual address.

So if what you *want* is a pfn to begin with, then use, use my_zero_pfn().

But if what you want is just the virtual address, use ZERO_PAGE().

And if you are going to map it at some address, give it the address
you're going to use, otherwise just do zero for "whatever".

The only thing you can't use ZERO_PAGE(0) for is literally that "is
this a zero page" address comparison, because ZERO_PAGE(0) is just
_one_ address.

                   Linus
