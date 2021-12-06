Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC974C433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 17:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbhLFRiw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbhLFRiw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 12:38:52 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CDBC0611F7
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 09:35:23 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x15so46471149edv.1
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8umLnxkQDgi96rJjwGXauJbyfOBhd/Q4eq0+fA0pj4=;
        b=GgGJB+R0LyUMIljalT2P610uyhWqSzmVzWTfYAaVG9JKs22KYrGSzdp/WQqDo9mdgg
         +IGu14R485pYnYs9PS+e1DyxU7/CuuaymG7wMaGu0ykbYL/P60NEJPUrSP7cv+udmhTg
         q3Yd4KitjWWfifbPjo7dI8KBc67WVxrc4jkiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8umLnxkQDgi96rJjwGXauJbyfOBhd/Q4eq0+fA0pj4=;
        b=gofTpejXAyUOL5oePVUdQ+9wmS1V8omhT8M5Jb5x5lBoGOAdxeVteFCJPpNDa0Nu80
         B/zNLobZr0f6Y669Rc2WsdBNvk7XBsXrt5O4uuIsIOnqo8NyluUg9UW4nQgoxnodhzcs
         YWbOWq9ixofVR22HADQyZo8SEYVhf61gQRguRLtc6FRRgdl8S8MVGwnn75OanLdVEi7+
         jiqiWImEb8yMutuV+0VxvV9gnERrSAqMzxfxbTeCq7Ve2lKLjB8nnbGX0MZ+eKIWhjqR
         87lKVfa6+rFSc1yTOV87PLSoNzfbt77zw6B4HA46DawnKq7KciiqZZEyvT/eW3ZCVHkJ
         /Wfw==
X-Gm-Message-State: AOAM532ExWMYU2gUtJZZe9u3sEG1jFztCbLTF4+eBxkMl9/zqoOkrH1r
        uCsCOHAzJwa/QcxZSEq/MXsgELA0GFfMXWBg
X-Google-Smtp-Source: ABdhPJxMxI/gFYny3dNgZ4d523puGdz3BL5LStvvOcFOcCc0R35ttf3lBR/Xh9qF7RhklvHJQUrlUg==
X-Received: by 2002:a17:907:94d4:: with SMTP id dn20mr46503461ejc.379.1638812121313;
        Mon, 06 Dec 2021 09:35:21 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id d19sm7550716edt.34.2021.12.06.09.35.20
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 09:35:21 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id j3so24105478wrp.1
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 09:35:20 -0800 (PST)
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr43315963wrx.378.1638812120016;
 Mon, 06 Dec 2021 09:35:20 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Dec 2021 09:35:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
Message-ID: <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
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

On Mon, Dec 6, 2021 at 12:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Quite; and for something that pretends to be about performance, it also
> lacks any actual numbers to back that claim.
>
> The proposed implementation also doesn't do nearly as much as the
> refcount_t one does.

Stop pretending refcoutn_t is that great.

It's horrid. The code it generators is disgusting. It should never
have been inlines in the first place, and the design decsisions were
questionable to begin with.

There's a reason core stuff (like the page counters) DO NOT USE REFCOUNT_T.

I seriously believe that refcount_t should be used for things like
device reference counting or similar issues, and not for _any_ truly
core code.

                  Linus
