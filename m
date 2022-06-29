Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7784CC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 20:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiF2Uvx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiF2Uvw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 16:51:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9120B3B57D
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 13:51:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so708483pjr.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QzwBZ8MiKHCkHQs6ubFBUeLJm2aPz3uAJ0SJNl3Iybc=;
        b=P/tFMAavejNGyZvqSFU2mkJlZXaYYqOnwQE6I2NFPUtuwMAstEtCx65ohUNqDaIZmC
         MsAwqyZeKRs499JxkU2CIVrGDOLJdfHytpqNlZwZO48HpP/ARLFvaaL+eryw7wawM0iN
         SPzlVDyieLswxUldskHOhk7PVNZ0u0ceT1c5GuTSafrVPdwF0Ov/UoN0H1zKGPUvGufb
         REMdzsHYS2Oh/or4pVyCRa/EPokRPQmRzskkzw6UCXAK1euBekAvQw1VNcLY4Vr7Feo7
         QObeSNT9u7mwtvvY1JIoh3J0NqN26L3uE6OMzymevAKChr3x5DcvYH8e19VoQ7obUreI
         KxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QzwBZ8MiKHCkHQs6ubFBUeLJm2aPz3uAJ0SJNl3Iybc=;
        b=oAqUMolzZ0LXgXQ18TQraNzLp6+QLtenB1s6bx19Xd4Hu06cBcN/UMRdl9oISdsruY
         FHxHkN2NNjPJUImyIrec81njIKWnLAtb0/3rdMy1bBn46fDyhzTsy+El7GIDcMVG5Yrm
         BZp276AF9Vm0IwS9V133e7XgO/SiaFM9IxOawyzx1kU5XwcfmVoJgsAQoPi763XHEeV3
         GrTW7sAhKYvXlvoBUZ33cS6NINKTnfSjT2QdmDARVkbCXEmCeJscyXQPxYfeWCJrht/D
         tRVuPlLbgN4afBAOI2qfdBqVV8rA6XK2AbiLZaFsCwoM1kS7YigbGvjK2OaOamA8YDdA
         hzRw==
X-Gm-Message-State: AJIora+a3U7uJ1/BMok8QNtvexPoTa8jNZwBwjBPx//N71aNh71BQb+G
        rvv/kCJtNPKeRQJBVl1BSSStXg==
X-Google-Smtp-Source: AGRyM1v1OkLy4OUlV7ZRW9VidqYwr1vCmgGeLPlNdNyB/wtkvJBb7FkK3KxiVGvVDMaUmxrLSBvU+A==
X-Received: by 2002:a17:90b:1753:b0:1ef:2e75:8811 with SMTP id jf19-20020a17090b175300b001ef2e758811mr2120687pjb.22.1656535910048;
        Wed, 29 Jun 2022 13:51:50 -0700 (PDT)
Received: from smtpclient.apple ([2600:380:b421:9fb9:5830:e8f6:f44a:f844])
        by smtp.gmail.com with ESMTPSA id s9-20020a62e709000000b00527ab697c6asm6035747pfh.18.2022.06.29.13.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 13:51:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Date:   Wed, 29 Jun 2022 14:51:48 -0600
Message-Id: <788DCE4B-8992-436B-B0D4-D101E9176345@kernel.dk>
References: <20220629192646.aoj5c7xdqkifwjdg@moria.home.lan>
Cc:     Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20220629192646.aoj5c7xdqkifwjdg@moria.home.lan>
To:     Kent Overstreet <kent.overstreet@gmail.com>
X-Mailer: iPhone Mail (19F77)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 29, 2022, at 1:26 PM, Kent Overstreet <kent.overstreet@gmail.com> wro=
te:
>=20
> =EF=BB=BFOn Wed, Jun 29, 2022 at 01:00:52PM -0600, Jens Axboe wrote:
>>> On 6/29/22 12:40 PM, Kent Overstreet wrote:
>>> On Wed, Jun 29, 2022 at 11:16:10AM -0600, Jens Axboe wrote:
>>>> Not sure what Christoph change you are referring to, but all the ones
>>>> that I did to improve the init side were all backed by numbers I ran at=

>>>> that time (and most/all of the commit messages will have that data). So=

>>>> yes, it is indeed still very noticeable. Maybe not at 100K IOPS, but at=

>>>> 10M on a core it most certainly is.
>>>=20
>>> I was referring to 609be1066731fea86436f5f91022f82e592ab456. You
>>> signed off on it, you must remember it...?
>>=20
>> I'm sure we all remember each and every commit that gets applied,
>> particularly with such a precise description of the change.
>>=20
>>>> I'm all for having solid and maintainable code, obviously, but frivolou=
s
>>>> bloating of structures and more expensive setup cannot be hand waved
>>>> away with "it doesn't matter if we touch 3 or 6 cachelines" because we
>>>> obviously have a disagreement on that.
>>>=20
>>> I wouldn't propose inflating struct _bio_ like that. But Jens, to be
>>> blunt - I know we have different priorities in the way we write code.
>>> Your writeback throttling code was buggy for _ages_ and I had users
>>> hitting deadlocks there that I pinged you about, and I could not make
>>> heads or tails of how that code was supposed to work and not for lack
>>> of time spent trying!
>>=20
>> OK Kent, you just wasted your 2nd chance here. Plonk. There are many
>> rebuttals that could be made here, but I won't waste my time on it, nor
>> would it be appropriate.
>>=20
>> Come back when you know how to act professionally. Or don't come back
>> at all.
>=20
> Jens, you're just acting like your code is immune to criticism, and I don'=
t have
> an eyeroll big enough for that. We all know how you care about chasing eve=
ry
> last of those 10 million iops - and not much else.

Kent, the time for your unsolicited opinions and attacks have passed. Just g=
o away, not interested in interacting with you. You have no idea what you=E2=
=80=99re talking about.=20




