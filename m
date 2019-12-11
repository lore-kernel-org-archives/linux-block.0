Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F53C2D0C8
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 17:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B94E2073D
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576084813;
	bh=DP2MNW53VRFFIzJwXCJd0qsxIsMcv2YK30FUd10Dzrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NI5DZD8PfE/QStYm7brJE49yFqg+H+Qf0CC4khzzSWvZqt+qLdew5lHZRrcEgEcAU
	 2rPdoiUMaOATzAO/nT0p8XuvEpGkgbCgvYxMeFZLY71JitqP18NNad7bgi8LvXxMk3
	 cYD/ZEqSHHgKqy3B0FRcF0KvtYUCRvNoOl6lu+ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfLKRUN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:20:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45865 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbfLKRUM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 12:20:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id d20so24921221ljc.12
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 09:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLrgzTUFBpKEKDqVCWUZZ1/wbtzXH039tj4vagWGMGg=;
        b=Nc8xSo/JfaYDi4Oz/DWIpDtDq6loKj0f0sSoSmwqGnkRytexbEyNqycOYwbfzKVi0J
         cSGVsT5W9MpTwY+UdZRBw3LsrkeoYgYwl0ZhxQ2o4YErz3CWWBXmZqc7NNPMVhSI8nRf
         vh7vqyXDlMy5+GQPAGclDZumV++kQ990r6WdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLrgzTUFBpKEKDqVCWUZZ1/wbtzXH039tj4vagWGMGg=;
        b=Cyu+4Jk+2aor9f4FFshtxVgDSukP4llkHAl0CIQKvZDB79YwWzjz/vWPWDVNxUiSSg
         5pFxRamRyEw8NfNKrwPYSmp7RCr0l58cXc34/bUbPMo1W330oFIBYupnfJXb1UJS7ndv
         wD91hbC7aN7oz6PeKKV8/FkW0E02J2LibbmKrWM4EWm8ZCQKelDm6T9vkYrPS8/2Ijcu
         o6JfI3fyY83vrmvEhCpPqXseIwSZhD85wiavWo1Swnzr7KVhmAJVA9ZxJRQXMEaj/ZFy
         rUUQ8Scy6P4YVKg9ztzbto7RnTIg7zOt/8PeTKaSY8XDP+GVbeutu7D0PjXvv9NLa9VO
         fgUg==
X-Gm-Message-State: APjAAAXwIWRV7U0ZIrMxRBXQ6aal4NPhaA/3J3PZLU46gadk5mRIIQPU
        l5U6cu2/ScAxjNSy9riASaaVbZ+qFto=
X-Google-Smtp-Source: APXvYqyc2wuhq+UebDNxLJG0h8j4PZvPlM7WcYAyKeKYbEH14osODSSn2gqBoFKCaOx7OcqOUSEhfw==
X-Received: by 2002:a05:651c:c4:: with SMTP id 4mr2952387ljr.131.1576084809845;
        Wed, 11 Dec 2019 09:20:09 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id o69sm1534467lff.14.2019.12.11.09.20.08
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 09:20:08 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id r14so17329930lfm.5
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 09:20:08 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr2995836lfi.170.1576084808314;
 Wed, 11 Dec 2019 09:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <20191211152943.2933-5-axboe@kernel.dk>
In-Reply-To: <20191211152943.2933-5-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 09:19:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj07S-Ee4z6_L=7B=RvL96zZ6mXOTJqiUdyhji6503_yQ@mail.gmail.com>
Message-ID: <CAHk-=wj07S-Ee4z6_L=7B=RvL96zZ6mXOTJqiUdyhji6503_yQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] iomap: pass in the write_begin/write_end flags to iomap_actor
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 7:29 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> This is in preparation for passing in a flag to the iomap_actor, which
> currently doesn't support that.

This really looks like we should use a struct for passing the arguments, no?

Now on 64-bit, you the iomap_actor() has seven arguments, which
already means that it's passing some of them on the stack on most
architectures.

On 32-bit, it's even worse, because two of the arguments are "loff_t",
which means that they are 2 words each, so you have 9 words of
arguments. I don't know a single architecture that does register
passing for things like that.

If you were to change the calling convention _first_ to do a "struct
iomap_actor" or whatever, then adding the "flags" field would be a
trivial addition.

               Linus
