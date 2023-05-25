Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C4CC77B7A
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 17:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbjEYRFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjEYRFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 13:05:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652191A4
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:05:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso4906237a12.2
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685034311; x=1687626311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSr58RBXCv1EwUMOYtICqFDX8H+m5pyEj79JnZvBvqM=;
        b=FUBX4bX4Rtu2T0f2hT26650q+dMnkZkzNX0I0hBfyLgOH2Ax4epbIripcg6b1UDFpM
         o3prOgLKFbhWUaC45DzFa9SPMncTSsRCM3jaIgaKdONEpkKIUcalhdfLJHBraYaiCHV8
         h8i1H4qHYaOI0fXj3tt41b8ArUeOIe7GFAM0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685034311; x=1687626311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSr58RBXCv1EwUMOYtICqFDX8H+m5pyEj79JnZvBvqM=;
        b=i1udT/ARHv8AkULq09bYp95nmgCI4R94+/8HFA8/+RJmGWPdLtWngFVyrgKejLnDFf
         aAQqkIoOuAVuslCFW3bgK7PejDq1Uj4WcLHhAwHFfy4nROrP5uHGFczPO07prat2ERIx
         3XF0nfQ2HfopgC52PYbl7eGPaiBsLnzeZ+gtokaFe6EYY3X83xFjPuNlYsu1Q3C1F/UZ
         ygWQPrfEz0pLnosebMLsRdiM2u9tHuNn8bQI4Yglnvvyic4XZKUIqbGO5ucYxhtuQUJA
         26B7stjFpcwZ02Pyj7eJb5JqY8RiFwkZOQymEthFCsf2EMhIq9PNvcvVAStZTP1Rrxs8
         hT5w==
X-Gm-Message-State: AC+VfDxIlKr9iV7WKXdn231cf/a7aQ8tWpR0fmnjQoswVr+0OHKZQWxv
        te2UAZaYZgiFMqkk8bGQj9EVBtTXOzEs0e9iL0MXXKZn
X-Google-Smtp-Source: ACHHUZ4us0ShiQqImIu6Y8o8BunYVY9B/oQNoPq2ZLhn00wNfhMIfjRPuwnBJxSARgGXOy178SRaog==
X-Received: by 2002:a17:906:c155:b0:96a:41ed:e3fa with SMTP id dp21-20020a170906c15500b0096a41ede3famr2578947ejc.22.1685034311712;
        Thu, 25 May 2023 10:05:11 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id gz15-20020a170906f2cf00b00965ac8f8a3dsm1064754ejb.173.2023.05.25.10.05.10
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:05:10 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9700219be87so159231566b.1
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:05:10 -0700 (PDT)
X-Received: by 2002:a17:907:3185:b0:970:925:6563 with SMTP id
 xe5-20020a170907318500b0097009256563mr2076202ejb.8.1685034310240; Thu, 25 May
 2023 10:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org>
 <3215177.1684918030@warthog.procyon.org.uk> <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
 <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com>
In-Reply-To: <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:04:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPWUCyhiM+=S3nmh4JK8qtBQteYvtiXpoYpDjfKHnEhQ@mail.gmail.com>
Message-ID: <CAHk-=wgPWUCyhiM+=S3nmh4JK8qtBQteYvtiXpoYpDjfKHnEhQ@mail.gmail.com>
Subject: Re: Extending page pinning into fs/direct-io.c
To:     David Hildenbrand <david@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
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

On Thu, May 25, 2023 at 9:45=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> I think the correct way to test for a zero page is
> is_zero_pfn(page_to_pfn(page).

Yeah. Except it's really ugly and strange, and we should probably add
a helper for that pattern.

The reason it has that odd "look at pfn" is just because I think the
first users were in the page table code, which had the pfn already,
and the test is basically based on the zero_page_mask thing that the
affected architectures have.

So I suspect we should add that

    is_zero_pfn(page_to_pfn(page))

as a helper inline function rather than write it out even more times
(that "is this 'struct page' a zero page" pattern already exists in
/proc and a few other places.

is_longterm_pinnable_page() already has it, so adding it as a helper
there in <linux/mm.h> is probably a good idea.

                Linus
