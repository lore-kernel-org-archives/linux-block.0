Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D47AC7EE2E
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 17:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjEYR0J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 13:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjEYR0J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 13:26:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1243C19D
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:26:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f6e83e12fso142159766b.1
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685035561; x=1687627561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJa+li1Oy5bbsqG6UFm3MUpvaFnPsLyMyN5vhg0qjCI=;
        b=OYLzxndcW0Aro8j6EGhHjNbZXc806wL/Je0D7ocR6sbo6T37AGbT8iIzPe9vPc1OHc
         VDExFCpAkJmEOTbMOlM4p9xbdKggA+T4HMW+nDsuYH8RC7PAFZbEaZgxrgn0ovA9GB/1
         +SAgbASXOJlo4aYu8koCGbnLPiY5cvnqkpKnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035561; x=1687627561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJa+li1Oy5bbsqG6UFm3MUpvaFnPsLyMyN5vhg0qjCI=;
        b=CLXbng2lK7c1xRXfCp6WglcvRDVvY3BJMqs43vszzzBpeUM6EXPo5zlD4r1ib9tugH
         hv9neGv/QYXYLP/VCrLYxysN+KBKh9xpERRlTulzHeI0DqVYpgB6ohmcXU8PpfVbfbh0
         70DwZSPkW9+kBkaSRIGgg43KTlXQ9+TAt92cbQnJ/ovFrz0B1/lBQdaP1WwTeBy2bqe+
         bPUwb9HcQfbHvklhksegQyUPvk2yUG34AVlt03A2kXS+f+gTqlnxMUgn5Ig3tkUj8c8Y
         oEGXySdUgR3LobV5ZelSbJ9HLjcOXlXl+LXvx9u598iTQf7cYzjhNPUufyb+I2F8wfvL
         jahg==
X-Gm-Message-State: AC+VfDxmzB/FBlsVqZ13echH61reWE6DktQl5yR5pm9nxOpHpELwaxwH
        1FXXb2nEEfPXxBFzmmUJpXt7VokjA9bAfCRQNGVM+ugf
X-Google-Smtp-Source: ACHHUZ4jtxYdJY2Va14SJnUxem2zokpLym+OoE3RWA8uj2thpOWT6EV+Sfqo1zWNI4emCIGWys5eJQ==
X-Received: by 2002:a17:907:707:b0:96b:1608:3563 with SMTP id xb7-20020a170907070700b0096b16083563mr2398958ejb.58.1685035561342;
        Thu, 25 May 2023 10:26:01 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id oy11-20020a170907104b00b0096f7e6d0063sm1088830ejb.75.2023.05.25.10.25.59
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:26:00 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-970056276acso141436466b.2
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:25:59 -0700 (PDT)
X-Received: by 2002:a17:906:7954:b0:96a:37af:ff37 with SMTP id
 l20-20020a170906795400b0096a37afff37mr2274160ejo.15.1685035559397; Thu, 25
 May 2023 10:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org>
 <3215177.1684918030@warthog.procyon.org.uk> <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
 <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com> <CAHk-=wgPWUCyhiM+=S3nmh4JK8qtBQteYvtiXpoYpDjfKHnEhQ@mail.gmail.com>
 <144598.1685034915@warthog.procyon.org.uk>
In-Reply-To: <144598.1685034915@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:25:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirrJNoVSOSVK2ae9pa7Q5kJKFYMk2ad-_6YrS1cEScqA@mail.gmail.com>
Message-ID: <CAHk-=wirrJNoVSOSVK2ae9pa7Q5kJKFYMk2ad-_6YrS1cEScqA@mail.gmail.com>
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

On Thu, May 25, 2023 at 10:15=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
>  It doesn't seem I can add it to mm.h as an inline function.

What? We already have that pattern inside is_longterm_pinnable_page(),
so that's really strange.

But regardless, please don't duplicate that odd conditional for no
reason, and don't scream.

So regardless of where it is, make that "is_zero_folio()" just do
"is_zero_page(&folio->page)" rather than repeat the question.

I also wonder whether we shouldn't just use the "transparent union"
argument thing more aggressively. Something like

   typedef union {
        struct page *page;
        struct folio *folio;
   } page_or_folio_t __attribute__ ((__transparent_union__));

and then you should be able to do something like this:

    static inline bool is_zero_page(const page_or_folio_t arg)
    {
        return is_zero_pfn(page_to_pfn(arg.page));
    }

and we don't have to keep generating the two versions over and over
and over again.

                Linus
