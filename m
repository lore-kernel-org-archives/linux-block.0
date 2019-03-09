Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB18C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 00:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5895720866
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 00:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552090124;
	bh=bgJVwW+JSc00lxQ0p3+I77MSMilfGxOya0jbgnxrW0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bC5Ibc2CYU3Xkq/MZPO9/BkVNl/AJhU5ycJWcbIPWKZchd7/Jke+Axge6m4XI3t/0
	 kCw8r7VusednMO0cKLjAaa/o6pZ1qeCdtZCeVNg3qaIqLmZpjIefs3PFIQZxmsz1dj
	 JzuJSfpf4Ny4+GLFElFiTah5624N1sRCbK7wz3hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCIAIn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:08:43 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:39124 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfCIAIn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 19:08:43 -0500
Received: by mail-lj1-f179.google.com with SMTP id g80so18859946ljg.6
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJ7J+/Pf+0pg4gBWpEk5mf+L7PfqkJfJOnNm7X5FkfY=;
        b=AmLR5QJ/GFSHVWoEsU80HpSS+HgLtQAScTb5yxIn/NqDYIqCwpRV5vg9r+7tMj2bmQ
         E08r0O+lP++iHSAu8O2b/s5bki84IgzcLDOxKEQHxzo3WIe3RE5mgCssKSRBPyK1eI5z
         R7tDSFrV/WtUtLTQ4lRPGKqYmCZiOzmMPj69k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJ7J+/Pf+0pg4gBWpEk5mf+L7PfqkJfJOnNm7X5FkfY=;
        b=ggAo+jp8QTVbgQqPAnRCJc6dGwvnueRMjNclxrn8FZuB1QJzPQedHRTXist8jtu7Ym
         o27bqblxGGHGeVbXnOt2JfyPEf3rR7MXrdKfWUwfRVd98L6bxyc7roFE9UbPmPw5MRUq
         icJb0paFPm4lR2b+oLjb5DSrguumB9gRiuXPZjHmgeRz9+yeOh8icnjh286bbGqEaKRS
         QKOyXgvAyca6c3R5w6bHnQjeRIpx9ruFDsl5xtgLxvTgI3A7KD7YidJCrcVq45fuhTWb
         R7SSxsMDozWnagcQsZPlKsRgiDdHHOhjLNXfIuvgZJY92hUt3fCHaT8wVq2sb8AkALse
         Ssbw==
X-Gm-Message-State: APjAAAWJuKw0xMLyIxkQr9M+t4mJ24dSRJGgqS7lK4FVpEvC88EhJive
        NYQpLMzORsKESS2p8ERXQIp9LYk806s=
X-Google-Smtp-Source: APXvYqz46E/mP6fo/atzp3WUOJHp/Xp9wsydGMFz17ZPqOXAwb8BvB7hkN/217ctC+pO8qeQZ0toDw==
X-Received: by 2002:a2e:4285:: with SMTP id h5mr10596823ljf.32.1552090120755;
        Fri, 08 Mar 2019 16:08:40 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id i185sm1810010lji.81.2019.03.08.16.08.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 16:08:40 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id l5so18868057lje.1
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 16:08:39 -0800 (PST)
X-Received: by 2002:a2e:208a:: with SMTP id g10mr10581028lji.135.1552090119516;
 Fri, 08 Mar 2019 16:08:39 -0800 (PST)
MIME-Version: 1.0
References: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk>
 <5c128dfd-9e6c-21fe-7b2b-397d495e112a@kernel.dk> <CAHk-=whtxVReSOZ2NpP7O-N+fwNw0hctBr1LdbTZ6Fu32=xcWg@mail.gmail.com>
 <CAHk-=whCvMXSbuDmPAZ1sHzuQFxzuVsrh4Q8rQmB9nooP8QOKA@mail.gmail.com> <CAHk-=whu3uojbKwdtaq8vwGfsvSpVUPfhvJPv+LMR=6kNT0XgA@mail.gmail.com>
In-Reply-To: <CAHk-=whu3uojbKwdtaq8vwGfsvSpVUPfhvJPv+LMR=6kNT0XgA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Mar 2019 16:08:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh36F+2iXMz1dxGxVebfFYtqypGXRchqttJuJ_=A9ctZw@mail.gmail.com>
Message-ID: <CAHk-=wh36F+2iXMz1dxGxVebfFYtqypGXRchqttJuJ_=A9ctZw@mail.gmail.com>
Subject: Re: [GIT PULL] Support for the io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Oh well. I'm obviously not entirely happy about it, but the refcount
issues look fixable.

So I pushed it out. Al, mind taking a look? Jens claimed in his pull
request that you've already looked at the refcounting, so I think the
only issue is whether it shares the bug with fs/aio.c that I think it
does, or whether it might be avoiding it because of doing things
slightly differently.

                    Linus
