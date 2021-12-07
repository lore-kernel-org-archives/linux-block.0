Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381A6C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 17:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbhLGRtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240170AbhLGRtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Dec 2021 12:49:19 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93621C061748
        for <linux-block@vger.kernel.org>; Tue,  7 Dec 2021 09:45:48 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y13so59906902edd.13
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 09:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCz8dGlbcF+sMn1q+rwc1GqBThV14yxrl/bbuNcC8yg=;
        b=YO5EjeN1u4d1oNpRT1doTRBON845Y7orrNijyuDtDONnciEIfIPav5TWcm3vRfGEo4
         PdmedxTKjCGmD8y2kpaQqLeDigWtuTSI7VsieaLeOeCjePWL7oSibmGiEDUBbmHJTZVQ
         ebZxToLSOoL9OOkmCSdKvGQbqtUJLJNS5Zqr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCz8dGlbcF+sMn1q+rwc1GqBThV14yxrl/bbuNcC8yg=;
        b=CoiOSUjrOpXaAG+vte4rS8vY1jGJIbNACh83WXUlcp6wRO375qRKdDJrJr7MZKBFx5
         TxcW5dHGUBNREleJ8nfeiw+Pt6eBVDWvsVzAyE+7wPwPQDxTKq2SflwwQfcD0Ohi7aIw
         j0ZkayI1+zLIz84YsUx3C072ZtxZIt0OZVLKZ2SU1F3IkLKXcn1F8/XGHQ9zL68eGirG
         oK67s+nXJVyvKakgvm9ubT8bGOgknUIbAuLLir/H1kis14ExpWtXJ64WQdLYZNKb1fXr
         Uu19Di3McHp3xGu3f9AkCzcDCKo6JV3niQSMvQSfeFeVX/aBRhhPEtWNoaRZglc97nOf
         Crsg==
X-Gm-Message-State: AOAM532aH59hweXg8qMFWa0n7FIR8/AO1Cpo+aY8s8APILRucC6bKe9p
        WjgSnhLQPB4FQriHWcoOfb3zRgkwpM5KxMYO
X-Google-Smtp-Source: ABdhPJzDdD25XnhzfaOtspKUZkWd9S4HR8dznTvUe1H3iiIypwL0UJl6tFXdJKM94XGS+Wb3IpoM6g==
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr11034660edf.400.1638899147023;
        Tue, 07 Dec 2021 09:45:47 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id cy26sm288394edb.7.2021.12.07.09.45.45
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 09:45:46 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id c4so31065828wrd.9
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 09:45:45 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr53850398wrn.318.1638899145701;
 Tue, 07 Dec 2021 09:45:45 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net> <CAHk-=wjtvUDbbcXw0iqAPn3dmZK+RnqVMFrU9i53HzvPtWx_vw@mail.gmail.com>
 <Ya+RPbdgEn6l6RbS@hirez.programming.kicks-ass.net> <CAHk-=whkx24ON4Ow0xkz-FSyb6nsZxxps5gEh7gCaSOvq4MNMw@mail.gmail.com>
In-Reply-To: <CAHk-=whkx24ON4Ow0xkz-FSyb6nsZxxps5gEh7gCaSOvq4MNMw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 09:45:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHtZqTdZYv7o7cKyj9rozWeX+MrYCPpo0ik3kHWRdFdw@mail.gmail.com>
Message-ID: <CAHk-=wjHtZqTdZYv7o7cKyj9rozWeX+MrYCPpo0ik3kHWRdFdw@mail.gmail.com>
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 7, 2021 at 9:43 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In the case of "dec_and_test" the "decrement to zero" case may not be
> hugely exceptional, but if you do the same for "increment with
> overflow protection" you do end up having the two different "zero vs
> too big", so it would actually be more consistent, I think..

Hmm.. Of course, that "increment with overflow protection" might not
actually want two targets in the first place, so maybe this argument
is BS.

Particularly if you can do the "zero or overflow" case with just one
test, maybe you really do want both cases to be one single error case.

And then your "refcount_dec_and_test()" with a return value (for
decrement to zero) and a separate error case (for errors) looks fine.

               Linus
