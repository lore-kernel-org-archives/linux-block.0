Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11897C77B78
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 20:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjEDUiR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 16:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjEDUiB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 16:38:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4860E191D6
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 13:31:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ab26a274d6so1425545ad.0
        for <linux-block@vger.kernel.org>; Thu, 04 May 2023 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683232236; x=1685824236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gHEhMKT9GBaN9OxubZFLqV6RzaUkfxxEP2gzqQjTJo=;
        b=LNZN/U448JRJlscsDbGuN9sNKHfqBTNuBhboKDn9GjpONGfVjxsHQn9v7QtyfwSJ/L
         hPQM/uyisqSgmYPn71ju7jxoI/FIxjCeluRakiCjkIL3kegvAZmbImqCTaMPIyjRxduZ
         +/NdN/XmGnb1myXRodYcgYIqIHs95osqrE0YGMnLUlT2P4e2dXJkxGhkOGAU1y0yzo17
         +2IsAfLIYL3cZj/eq5jHD17X/HnIdZveLDnbw7N1aQW6cJWraiq6j7uGqNd7StTR6M1Z
         dPmN/nMLZ0YWjNTUJNDUsXJDC9iVlM5Joo/duylJ5wlDbymdsoibthkZ6gYtb1TR0s0V
         sK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683232236; x=1685824236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gHEhMKT9GBaN9OxubZFLqV6RzaUkfxxEP2gzqQjTJo=;
        b=Iaa8GEhMlFILAUR5aXunDNcOrlgWZViSkdNo2hQTAJuxhZuuoB5lS5SIXT33AXfghs
         ClzQ6eD1Jz7dcQIagmVWAReHHN9yuDSIOYdiyO0SwhhfSbFyQnzjMfA1hPZVVpt3cB1c
         iOXRJ712bEAKbXkcyCVxtWlkPZOhc+FG07oeT+Sa7UxkrcdvspL/sPey0TLgMpFSNwJs
         1wHYulrBTToC5R7FTlNH+pUuDSLfATOikzFqX2cXoXahUuEPN8Sm0uA5VBv0cZdjDCYz
         Al2aGvmXQtRDwMWPkKBhYdgnJcc90C8CsaoAx+VdJwnqlKZRj1Sy8+AHxn6nHrBIajBR
         TmsA==
X-Gm-Message-State: AC+VfDy7LoEwjf8hISi5l9QdGdPkxb9LM2XHWC06EL16qVSnBCeJ6GsX
        88k2Ct0wTr4sSuOFmlwY5LJme9fFFy6ULZpvaiE=
X-Google-Smtp-Source: ACHHUZ7cSRKGSnvkFB0S4zZLqTu1C+ROgHFBUfU+QKoNjODu/ChiksCC/9eWmF7IDIxRWC1tOOWE+g==
X-Received: by 2002:a05:6602:493:b0:763:86b1:6111 with SMTP id y19-20020a056602049300b0076386b16111mr8372024iov.2.1683231778063;
        Thu, 04 May 2023 13:22:58 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c4-20020a5d9a84000000b00763601c4bfesm9164423iom.55.2023.05.04.13.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 13:22:57 -0700 (PDT)
Message-ID: <80ed2c0e-54db-777a-175b-1aa3ff776724@kernel.dk>
Date:   Thu, 4 May 2023 14:22:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Daniel Vetter <daniel@ffwll.ch>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org> <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
 <CANiq72nAMH1SfGmPTEjGHfevbb9tMLN4W7gJ3nBpJcvkCEsZ4g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANiq72nAMH1SfGmPTEjGHfevbb9tMLN4W7gJ3nBpJcvkCEsZ4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/4/23 2:11?PM, Miguel Ojeda wrote:
> On Thu, May 4, 2023 at 9:02?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> But back to the real question... This is obviously extra burden on
>> maintainers, and that needs to be sorted out first. Block drivers in
> 
> Regarding maintenance, something we have suggested in similar cases to
> other subsystems is that the author gets involved as a maintainer of,
> at least, the Rust abstractions/driver (possibly with a different
> `MAINTAINERS` entry).

Right, but that doesn't really solve the problem when the rust bindings
get in the way of changes that you are currently making. Or if you break
them inadvertently. I do see benefits to that approach, but it's no
panacea.

> Of course, that is still work for the existing maintainer(s), i.e.
> you, since coordination takes time. However, it can also be a nice way
> to learn Rust on the side, meanwhile things are getting upstreamed and
> discussed (I think Daniel, in Cc, is taking that approach).

This seems to assume that time is plentiful and we can just add more to
our plate, which isn't always true. While I'd love to do more rust and
get more familiar with it, the time still has to be there for that. I'm
actually typing this on a laptop with a rust gpu driver :-)

And this isn't just on me, there are other regular contributors and
reviewers that would need to be onboard with this.

> And it may also be a way for you to get an extra
> maintainer/reviewer/... later on for the C parts, too, even if Rust
> does not succeed.

That is certainly a win!

>> general are not super security sensitive, as it's mostly privileged code
>> and there's not a whole lot of user visibile API. And the stuff we do
>> have is reasonably basic. So what's the long term win of having rust
>> bindings? This is a legitimate question. I can see a lot of other more
>> user exposed subsystems being of higher interest here.
> 
> From the experience of other kernel maintainers/developers that are
> making the move, the advantages seem to be well worth it, even
> disregarding the security aspect, i.e. on the language side alone.

Each case is different though, different people and different schedules
and priorities. So while the above is promising, it's also just
annecdotal and doesn't necessarily apply to our case.

-- 
Jens Axboe

