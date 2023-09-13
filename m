Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC09EE020A
	for <linux-block@archiver.kernel.org>; Wed, 13 Sep 2023 19:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjIMToI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjIMToH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Sep 2023 15:44:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCD49B
        for <linux-block@vger.kernel.org>; Wed, 13 Sep 2023 12:44:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so2881922a12.1
        for <linux-block@vger.kernel.org>; Wed, 13 Sep 2023 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694634241; x=1695239041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ymH1v6cOBwI8SJ/5mETElIehW/IG9VVdKuCvlgGH9zI=;
        b=elNSeP8alEUGgVYDzjaZ1rI04g/Bl6hl2aqv7tgWUnZu5jlWZ1efX4bC3dv1ZT/F7m
         +QgfhRzNU+h07E9Dj70vqkdSwx6s8OEsHmRuyO3OHMo55UwqlhF77IHvBRGfDqumUfXS
         /BXmO3S1MbQwPCCW084U2p3mrCCMp5HcLPLYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694634241; x=1695239041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymH1v6cOBwI8SJ/5mETElIehW/IG9VVdKuCvlgGH9zI=;
        b=gk8dxHAcWauz/oVm8YopXI0r8WUraN1Yr/Zd3PaR45JPDwB+tvqte6n65R3fQuoX3Z
         9YxwnY1hLzet4Cx8jDqFh4lyDqdwOakqgtI2ySxrWt0fwaIq8rqkrq/1Wp8IuNdIdQKl
         KEO/kG1enxhiUlCTvOeKWOnCWvYg69S5+dKxFTjd2sBzE8059gFAZKsOBwvgeXJnTAad
         Cqg1tlBiTTCuWbSjAbAnj8uw9DlwJ0ROjm09bowWeW30wa1KOftmV/fnK/id0wvBCzVo
         qs33ypG9aI/LJIYV/06X7pztGYTQRKHn5Dh9DhWqGRf1KTjTrXmM9sr3isp7sKW8u1ih
         ff8w==
X-Gm-Message-State: AOJu0YzvRzNpdWPuKT0Wv4/VHN2u7WgnQZmm0X2NqE0qj6WXtv6a8Am1
        xDdM5Dhrvj8P4VYNkRCpg1sp2AU37WgTRoO6PngX2IP6
X-Google-Smtp-Source: AGHT+IEs5LfCo4+349s6cRe/5h+3BxXUIK6HGKMfYhgjAchek0LCZUFh2IY3d1CbJaK5Phalg5X62A==
X-Received: by 2002:a17:907:3f01:b0:9a5:b247:3ab with SMTP id hq1-20020a1709073f0100b009a5b24703abmr9369607ejc.19.1694634241555;
        Wed, 13 Sep 2023 12:44:01 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906b30d00b0099cc36c4681sm8870204ejz.157.2023.09.13.12.44.01
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 12:44:01 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9a9d6b98845so298493466b.0
        for <linux-block@vger.kernel.org>; Wed, 13 Sep 2023 12:44:01 -0700 (PDT)
X-Received: by 2002:a17:907:6e92:b0:9ad:7840:ab29 with SMTP id
 sh18-20020a1709076e9200b009ad7840ab29mr11942207ejc.32.1694634240890; Wed, 13
 Sep 2023 12:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230913165648.2570623-1-dhowells@redhat.com> <20230913165648.2570623-8-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-8-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Sep 2023 12:43:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiULvMMcdf36JU3daqnTG2KqtJwm788k6fR4bJo7LvAiw@mail.gmail.com>
Message-ID: <CAHk-=wiULvMMcdf36JU3daqnTG2KqtJwm788k6fR4bJo7LvAiw@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] iov_iter: Make copy_from_iter() always handle MCE
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 13 Sept 2023 at 09:57, David Howells <dhowells@redhat.com> wrote:
>
> Make copy_from_iter() always catch an MCE and return a short copy and make
> the coredump code rely on that.  This requires arch support in the form of
> a memcpy_mc() function that returns the length copied.

What?

This patch seems to miss the point of the machine check copy entirely.

You create that completely random memcpy_mc() function, that has
nothing to do with our existing copy_mc_to_kernel(), and you claim
that the issue is that it should return the length copied.

Which is not the issue at all.

Several x86 chips will HANG due to internal CPU corruption if you use
the string instructions for copying data when a machine check
exception happens (possibly only due to memory poisoning with some
non-volatile RAM thing).

Are these chips buggy? Yes.

Is the Intel machine check architecture nasty and bad? Yes, Christ yes.

Can these machines hang if user space does repeat string instructions
to said memory? Afaik, very much yes again. They are buggy.

I _think_ this only happens with the non-volatile storage stuff (thus
the dax / pmem / etc angle), and I hope we can put it behind us some
day.

But that doesn't mean that you can take our existing
copy_mc_to_kernel() code that tries to work around this and replace it
with something completely different that definitely does *not* work
around it.

See the comment in arch/x86/lib/copy_mc_64.S:

 * copy_mc_fragile - copy memory with indication if an exception /
fault happened
 *
 * The 'fragile' version is opted into by platform quirks and takes
 * pains to avoid unrecoverable corner cases like 'fast-string'
 * instruction sequences, and consuming poison across a cacheline
 * boundary. The non-fragile version is equivalent to memcpy()
 * regardless of CPU machine-check-recovery capability.

and yes, it's disgusting, and no, I've never seen a machine that does
this, since it's all "enterprise hardware", and I don't want to touch
that shite with a ten-foot pole.

Should I go on another rant about how "enterprise" means "over-priced
garbage, but with a paper trail of how bad it is, so that you can
point fingers at somebody else"?

That's true both when applied to software and to hardware, I'm afraid.

So if we get rid of that horrendous "copy_mc_fragile", then pretty
much THE WHOLE POINT of the stupid MC copy goes away, and we should
just get rid of it all entirely.

Which might be a good idea, but is absolutely *not* something that
should be done randomly as part of some iov_iter rewrite series.

I'll dance on the grave of that *horrible* machine check copy code,
but when I see this as part of iov_iter cleanup, I can only say "No.
Not this way".

> [?] Is it better to kill the thread in the event of an MCE occurring?

Oh, the thread will be dead already. In fact, if I understand the
problem correctly, the whole f$^!ng machine will be dead and need to
be power-cycled.

                 Linus
