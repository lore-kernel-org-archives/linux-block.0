Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDAEC4361B
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 22:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC07C207CC
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 22:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406767AbgLMWgo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 17:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgLMWgh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 17:36:37 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBA7C0613D6;
        Sun, 13 Dec 2020 14:35:57 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id i9so14598699wrc.4;
        Sun, 13 Dec 2020 14:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T/iMHlNe3EXqKdrKSSOGAg78Pv8UK8/sm1Ps+5hAae8=;
        b=QK+uEcUR3n45dcppnC8rUI7SUt+EekvZqDXgpILUe5MQzMidUgXUdXP6v2zHyi7et7
         goQaIJNNrV/2I3d9VJvUg6zH8xL6UGl5CevK8Xn4QzGwy7q5cPHyhG0BXMXtLb1+IHke
         pmBO18GSzVNgq/x7Ex+ZKUCiLvPSoM8SLfHOqaN4EiYNmvd8ZRyAmX7BsMDaS+LhQRCD
         0mTVnPddDK6nW4sfRG/4IzHu6oSJvw0DjzizGLsnRPholfMkPgyexF8zPYCvNoozF/Ct
         9NXpcNyVEYZnh+pUR/vvtB1T0AKqAZyizff6x5Zx9LfRWHVjMxSQo9QhAzogmtTUsw5Z
         ZL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T/iMHlNe3EXqKdrKSSOGAg78Pv8UK8/sm1Ps+5hAae8=;
        b=J4ph4u1OWb4oXiofemhKInPZ8v8qoqvEdSUcx9n9HbxadVj0tcCIxFd74aofApMrgY
         LP4uJcIspdjSxHsHR9j4JeXce1OSK7aiW3txXmdaAvD8xAJiWYQD5UfSQUr8uG8U3pU+
         jptYL2VAQ42C/UZObFnj7Izxl3syZ7d1Ub8oFgUoaoeN7d6DFRG397FppANddFAtsY6k
         vGh/vsk1k3bTEhVqZZum15aF8pnkBmj2Yk1lHgUcnDXeS/hOy1vmQMbGAesuOhqEefuq
         aQZio+Z42k6VTGCYxx754zP+SR3mIJTTqDXk6zwiQJQA4OBf13m2Lpf9oKgh+aRltzmR
         Zjfw==
X-Gm-Message-State: AOAM530iFOw3ZKnv+tPxYHmeNE/aCJB8XcW9hRjzZDmDCSsO9DYQbGBp
        vARO3zF4y/dpP90AhrGa1pR5PkJo7kLtmA==
X-Google-Smtp-Source: ABdhPJyg/gyoUQy3dn1LFAtjEiAf3m7z89efUHD5gS8vI43ipZaPHHNRS7jKvU5zRONSbr+6BukzGg==
X-Received: by 2002:adf:a551:: with SMTP id j17mr25470714wrb.217.1607898955703;
        Sun, 13 Dec 2020 14:35:55 -0800 (PST)
Received: from [192.168.8.124] ([85.255.232.163])
        by smtp.gmail.com with ESMTPSA id h98sm31473084wrh.69.2020.12.13.14.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Dec 2020 14:35:55 -0800 (PST)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1605799583.git.asml.silence@gmail.com>
 <9bc27cb3ef6ab49b6b2ccee3db6613838aee17af.1605799583.git.asml.silence@gmail.com>
 <20201119170340.GA6179@infradead.org>
 <ce79f47e-2ec0-ba29-a991-c537a8990dee@gmail.com>
 <20201211020100.GB107834@ZenIV.linux.org.uk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 2/2] iov_iter: optimise iter type checking
Message-ID: <857a3161-fbd5-5ff8-d733-ca57923302b5@gmail.com>
Date:   Sun, 13 Dec 2020 22:32:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201211020100.GB107834@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/2020 02:01, Al Viro wrote:
> On Thu, Nov 19, 2020 at 05:12:44PM +0000, Pavel Begunkov wrote:
>> On 19/11/2020 17:03, Christoph Hellwig wrote:
>>> On Thu, Nov 19, 2020 at 03:29:43PM +0000, Pavel Begunkov wrote:
>>>> The problem here is that iov_iter_is_*() helpers check types for
>>>> equality, but all iterate_* helpers do bitwise ands. This confuses
>>>> a compiler, so even if some cases were handled separately with
>>>> iov_iter_is_*(), it can't eliminate and skip unreachable branches in
>>>> following iterate*().
>>>
>>> I think we need to kill the iov_iter_is_* helpers, renumber to not do
>>> the pointless bitmask and just check for equality (might turn into a
>>> bunch of nice switch statements actually).
>>
>> There are uses like below though, and that would also add some overhead
>> on iov_iter_type(), so it's not apparent to me which version would be
>> cleaner/faster in the end. But yeah, we can experiment after landing
>> this patch.
>>
>> if (type & (ITER_BVEC|ITER_KVEC))
> 
> There are exactly 3 such places, and all of them would've been just as well
> with case ITER_BVEC: case ITER_KVEC: ... in a switch.
> 
> Hmm...  I wonder which would work better:
> 
> enum iter_type {
>         ITER_IOVEC = 0,
>         ITER_KVEC = 2,
>         ITER_BVEC = 4,
>         ITER_PIPE = 6,
>         ITER_DISCARD = 8,
> };
> iov_iter_type(iter)	(((iter)->type) & ~1)
> iov_iter_rw(iter)	(((iter)->type) & 1)
> 
> or
> 
> enum iter_type {
>         ITER_IOVEC,
>         ITER_KVEC,
>         ITER_BVEC,
>         ITER_PIPE,
>         ITER_DISCARD,
> };
> iov_iter_type(iter)	(((iter)->type) & (~0U>>1))
> // callers of iov_iter_rw() are almost all comparing with explicit READ or WRITE
> iov_iter_rw(iter)	(((iter)->type) & ~(~0U>>1) ? WRITE : READ)
> with places like iov_iter_kvec() doing
> 	i->type = ITER_KVEC | ((direction == WRITE) ? BIT(31) : 0);
> 
> Preferences?

For the bitmask version (with this patch) we have most of
iov_iter_type() completely optimised out. E.g. identical

iov_iter_type(i) & ITER_IOVEC <=> iter->type & ITER_IOVEC

It's also nice to have iov_iter_rw() to be just
(type & 1), operations with which can be optimised in a handful of ways.

Unless the compiler would be able to heavily optimise switches,
e.g. to out-of-memory/calculation-based jump tables, that I doubt,
I'd personally leave it be. Though, not like it should matter much.

-- 
Pavel Begunkov
