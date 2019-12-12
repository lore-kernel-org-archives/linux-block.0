Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56518C43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 01:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B3C22527
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 01:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576114897;
	bh=6pi1QKFs3ihe469ogQOJBlCrHTgEHvChQo3qNeylyyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v+7UHcM5UJzSf7ymKiojBAJT/U5EVgv7n8y1UpFHJ4eDWu6amSfymuDQ7womaiGZK
	 pAWSFjMmwfsmbVOeB+839PP9VmoKXpzje5O9fnrh1LwgOBUgNcTIpsL0nHENW/RaB2
	 V5laEvJr8eWTC+b1kEHz7ZdwUbBAVBnetuvMhu/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfLLBlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:41:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37652 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfLLBlg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 20:41:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so377194lfc.4
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 17:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qkGwL2n2COMGi/65rr06OKZlwq6a94CxCGW0s5lEfc0=;
        b=KgSvodEa7eLrcqdNK9kKIImqn5jEmRctWpRgCEnbVU+jw3hmZb5+262OnTWzIHVrKB
         4bckfwrJrGys15oOES9fMPyMF2VG1oJxHymVlnVo7XzOorvhCUqVrbg00X+UKrC2vXFo
         SG8r+gelbxFlvgfg2uzQmA5lr/M+IXcQCtoKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkGwL2n2COMGi/65rr06OKZlwq6a94CxCGW0s5lEfc0=;
        b=qazhWflt0eQymwhFmvuxFP/LupsA8hKyG8eM3XX2zFI+N8vU2+YqXCm2ZdsY2mXemv
         +uH1sVyj5l1RCEtUCSO8t27cySIiTn84Z4GYEnWsTIti7BFfQcqzsB1R3VgmYDRgjE2C
         q5Sr8wi8cXSsOZO1pqX3sCJwK3tVXFV5wCHlP4vW27gELZY2DU048mF7YAVDU0QT1xXX
         USJZobSVGvMMM8zHW3gyGokhXbGa6KqfZ1YgqHpZOxnZOv5qjuuXsh2mD5zaaGGM0d31
         WZtRvWpNlM+SFB7JQPwaAIe3KJXMg5LT6HZIADn2B99ME4G81miOqGXtlD75HCc4RJF5
         leig==
X-Gm-Message-State: APjAAAVVkLSDLJnzfM5BaL1QioBPl/sEN7xQea9CK3puMrX/pDHRBRfr
        UlE83f7YKIyNbSLOdEB7kN/uaPBjucY=
X-Google-Smtp-Source: APXvYqyNP/Sa3DDaPiIiPLfnmUEvw/1kvefMXNzh5t97NUcHWF3O/WstYaaxaIQDuebxtT3aTNgOLQ==
X-Received: by 2002:ac2:508e:: with SMTP id f14mr3787084lfm.72.1576114894097;
        Wed, 11 Dec 2019 17:41:34 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2sm2009122ljq.38.2019.12.11.17.41.32
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:41:33 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id e28so333448ljo.9
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 17:41:32 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr4229397ljj.148.1576114892571;
 Wed, 11 Dec 2019 17:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk> <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk> <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk> <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk> <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
 <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk>
In-Reply-To: <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 17:41:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=whtf0-f5wCcSAj=oTK2TEaesF43UdHnPyvgE9X1EuwvBw@mail.gmail.com>
Message-ID: <CAHk-=whtf0-f5wCcSAj=oTK2TEaesF43UdHnPyvgE9X1EuwvBw@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 5:29 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> I'd very much argue that it IS a bug, maybe just doesn't show on your
> system.

Oh, I agree. But I also understand why people hadn't noticed, and I
don't think it's all that critical - because if you do 1M iops cached,
you're doing something really really strange.

I too can see xas_create using 30% CPU time, but that's when I do a
perf record on just kswapd - and when I actually look at it on a
system level, it looks nowhere near that bad.

So I think people should look at this. Part of it might be for Willy:
does that xas_create() need to be that expensive? I hate how "perf"
callchains work, but it does look like it is probably
page_cache_delete -> xas_store -> xas_create that is the bulk of the
cost there.

Replacing the real page with the shadow entry shouldn't be that big of
a deal, I would really hope.

Willy, that used to be a __radix_tree_lookup -> __radix_tree_replace
thing, is there perhaps some simple optmization that could be done on
the XArray case here?

                Linus
