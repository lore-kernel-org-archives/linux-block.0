Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFEEC83011
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 00:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16789207FF
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 00:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeJHLvPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLAAWq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:22:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727373AbgLAAWq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 19:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606782079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hQKQXqTPRKvVYnv32OOXF3L+vo5VS+wmoEPKC6MdlJU=;
        b=BeJHLvPhjhMM1PHCx6ojhWgfVa4lbFQjujBAM8+0JRPwxcZcwMmo6rIFzK7IKXfPKLg3bk
        0q+uN+mcHbCfy9czBT6O2RvXgNBaFM7k0E2XYDXFIUa/SkxsblPKoXkqnrQkhsgevuAhO0
        tPyzq9Ag8PhqsSKF61mrlsA668oEFuo=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-JpaxDvjbNgKoZwAcBZK6WQ-1; Mon, 30 Nov 2020 19:21:15 -0500
X-MC-Unique: JpaxDvjbNgKoZwAcBZK6WQ-1
Received: by mail-ua1-f72.google.com with SMTP id t8so3871175uap.17
        for <linux-block@vger.kernel.org>; Mon, 30 Nov 2020 16:21:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQKQXqTPRKvVYnv32OOXF3L+vo5VS+wmoEPKC6MdlJU=;
        b=kYch7iI53JtbIVk4dL0WQIpTdyqXmb5TPvRqCrA54Dm1SaRQNcXtndF3uNeEP487bw
         R7wMIgW3eGwa9Yi3NHPqMLffdK5YpJ0TPflHl8PSRUP5KXqOVph/3nTPEM7I4VKWOpPt
         UU4A+f4kzmzYiawuMHwWDBe7gCN3LBFzN/Khw8RUhIjEkRO/9iQdn57o2fALfzo1u8xv
         OksMA/sP1N3ATQqVtw4P2vwfg/l7y1ZBhXGi/z70rYI5SKx/+WwwJ7uQX9HDRfE8BlPo
         bEz6IMZ0OnDVNSVzA4/9MOTHQ62kuvNDgIKrCYGEGI9TsHUScDPVnuKkQllYIqA9R4yW
         dClg==
X-Gm-Message-State: AOAM531Tw18fMTECQkPBLc/FnFRJLc1MTB1vasvOgOIUz/xuGUG6zqnQ
        hzIV0Zv5LabrhW4Mt5qdSRYs6xA1gGBotmOE/W4MmkXMdIz7TBpFDTOkRFCzpCpK6BnrNZOCkCB
        AL1MUEphW72axLlVmEb2QZOuT0IrqA2S8sEDJ+8Q=
X-Received: by 2002:ab0:4d6a:: with SMTP id k42mr367930uag.131.1606782074894;
        Mon, 30 Nov 2020 16:21:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDWgtSzGfeASRxiwB17oIgwbMUloZ9SVF2OH9PFhTAbEtxCVcZCDOG0sUBclEWnbyJtUKFbSRVnMiZIZ47nRQ=
X-Received: by 2002:ab0:4d6a:: with SMTP id k42mr367919uag.131.1606782074669;
 Mon, 30 Nov 2020 16:21:14 -0800 (PST)
MIME-Version: 1.0
References: <20201130171805.77712-1-snitzer@redhat.com> <CAMeeMh8fb2JEBmuSuTP8ys6Xr+GpFqcUr5Py73W4wCQb1MCuAw@mail.gmail.com>
 <20201130232417.GA12865@redhat.com>
In-Reply-To: <20201130232417.GA12865@redhat.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Mon, 30 Nov 2020 19:21:03 -0500
Message-ID: <CAMeeMh9Ykqhc75VCSgLoj+hMpqBaV2uY7XvXUP1-FQdQLF49Ew@mail.gmail.com>
Subject: Re: block: revert to using min_not_zero() when stacking chunk_sectors
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Bruce Johnston <bjohnsto@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> If you're going to cherry pick a portion of a commit header please
> reference the commit id and use quotes or indentation to make it clear
> what is being referenced, etc.
Apologies.

> Quite the tangent just to setup an a toy example of say: thinp with 256K
> blocksize/chunk_sectors ontop of a RAID6 with a chunk_sectors of 128K
> and stripesize of 1280K.

I screwed up my math ... many apologies :/

Consider a thinp of chunk_sectors 512K atop a RAID6 with chunk_sectors 1280K.
(Previously, this RAID6 would be disallowed because chunk_sectors
could only be a power of 2, but 07d098e6bba removed this constraint.)
-With lcm_not_zero(), a full-device IO would be split into 2560K IOs,
which obviously spans both 512K and 1280K chunk boundaries.
-With min_not_zero(), a full-device IO would be split into 512K IOs,
some of which would span 1280k chunk boundaries. For instance, one IO
would span from offset 1024K to 1536K.
-With the hypothetical gcd_not_zero(), a full-device IO would be split
into 256K IOs, which span neither 512K nor 1280K chunk boundaries.

>
> To be clear, you are _not_ saying using lcm_not_zero() is correct.
> You're saying that simply reverting block core back to using
> min_not_zero() may not be as good as using gcd().

Assuming my understanding of chunk_sectors is correct -- which as per
blk-settings.c seems to be "a driver will not receive a bio that spans
a chunk_sector boundary, except in single-page cases" -- I believe
using lcm_not_zero() and min_not_zero() can both violate this
requirement. The current lcm_not_zero() is not correct, but also
reverting block core back to using min_not_zero() leaves edge cases as
above.

I believe gcd provides the requirement, but min_not_zero() +
disallowing non-power-of-2 chunk_sectors also provides the
requirement.

> > But it's possible I'm misunderstanding the purpose of chunk_sectors,
> > or there should be a check that the one of the two devices' chunk
> > sizes divides the other.
>
> Seriously not amused by your response, I now have to do damage control
> because you have a concern that you really weren't able to communicate
> very effectively.

Apologies.

