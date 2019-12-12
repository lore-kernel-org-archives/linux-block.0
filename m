Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692BBC2D0C6
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 01:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC702173E
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 01:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576112956;
	bh=+LRDLip2A7AzoJ5f7Bw9yuSF6PeJ15ESLMZFnW+1rGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WZPg4L6p1turad5prdgdIEVRGPAN35iMbNsQK/1mYgnS6cqjyGZ0wWRLhr1MNcSGf
	 ttMnJgJOWMBxe0WYOAjdZ5CofAE7utTvTou0Eio8JOov/MIWiVZhH2j2r6KrJrV3KY
	 9FTSyhv2TtGUHbZSTxBnS2JcrtCjDbj/WyPbmWpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfLLBJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:09:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35852 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfLLBJP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 20:09:15 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so297495ljg.3
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 17:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSsy1oK6dlgjeYC31DOAb3aczfIQDJbif+gCxstOAL4=;
        b=W0o5DFnebCMTaJ6AV7omtLbXbKiiCh8i9FH/yFc2h2qbvsuqylgRcBksJ+bXJasJuy
         mRautiQaOn3pAv13zA8lsp9sl3W+5w5u3qrODNrmLA3c6R8XTAvXGSldhsFP8XDeHm69
         SVC414oav1bFwT9QRTew9YkNXqTSPHaerPO3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSsy1oK6dlgjeYC31DOAb3aczfIQDJbif+gCxstOAL4=;
        b=bxU/kx/d1SSWRHvLEKhytV12mOFoKpsOnQLPUS/mAM56fk+S//xHXKQGPA1HTaCeUh
         vE4deDWYqczvIxZecTIxvN3JAPcQUERT9/Qoz01QDPeQgUiOLhMo/1OWYmY2V3Wa8OtZ
         Od8XafuZ3uygL/ZFWfhPnVSt90tYyLRZPVKIv7eIa4/fJW5ciOpzYT7Xy/ug6T5QMkvD
         Q2gKUtheFR2KvPx7teobIAk2PPedjSXrFqvbE75MOIRM5MYCimYWfhD/UcbxNzk4n5q9
         tTI21gfn1gtdE3nKdZXP17Fmt93IEWuAom9WZmL9vjBcfSN15aS0ogTnrmuSn1k4jsId
         P+PA==
X-Gm-Message-State: APjAAAVWYZF6w5kmVJWg0DP9I/NA/piCJ6yGjrMq/ucvEBtIhMxDzPi8
        I5NfQEtWcTusYEriSjShvksaCVqIFrY=
X-Google-Smtp-Source: APXvYqwLnrdEJZiUIWHKk9GUwVxXOgPvVRbZIXGXcUZDKNH09RJmqSumm0y9ABNBLKVX9C0drnuk6A==
X-Received: by 2002:a2e:9755:: with SMTP id f21mr4179372ljj.23.1576112951227;
        Wed, 11 Dec 2019 17:09:11 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 140sm2004319lfk.78.2019.12.11.17.09.09
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:09:10 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id l18so346788lfc.1
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 17:09:09 -0800 (PST)
X-Received: by 2002:a19:4351:: with SMTP id m17mr4171510lfj.61.1576112949682;
 Wed, 11 Dec 2019 17:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk> <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk> <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
In-Reply-To: <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 17:08:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
Message-ID: <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
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

On Wed, Dec 11, 2019 at 3:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Here's what I did to reproduce:

Gaah. I have a fairly fast ssd (but it's "consumer fast" - Samsung 970
Pro - I'm assuming yours is a different class), but I encrypt my disk,
so I only get about 15k iops and I see kcyrptd in my profiles, not
kswapd.

I didn't even try to worry about RWF_UNCACHED or RWF_NOACCESS, since I
wanted to see the problem. But I think that with my setup, I can't
really see it just due to my IO being slow ;(

I do see xas_create and kswapd0, but it's 0.42%. I'm assuming it's the
very first signs of this problem, but it's certainly not all that
noticeable.

               Linus
