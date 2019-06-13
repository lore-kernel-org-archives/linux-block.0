Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D3DC31E4A
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9322B20679
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="OhQ1gd9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391061AbfFMQFw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:05:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33570 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391018AbfFMQFw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 12:05:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so3991089edq.0
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLABAOBxUi7apPgtRPROSyumsCPedDiB3eVS3aen4Uc=;
        b=OhQ1gd9hI7gUmtNiW/OqjsHiQzwW6iZW8IGNtHnPK8zug5HhC3kYfdVVJXheeoRaC6
         tbmDhYFOS083pJUz6jcfjmqIHLpaa597AhPSvEEAQBLMcwwRZdZ9O7lGn8Jrx1FkCvdA
         RfoNRWL1Q1taE5K1YXiR/zwm5WR9EoJjDgXouRhoyKnyxhNXGKOCVqG682PKrplC0mP1
         Qpfiw8SI/tUrfiIzQe/qG1BF+PWPkB7bpYVgOpQ13Zx0Rbd4MCnxbKjoLNKRwofxot0+
         wUn9KJjxcqacAAr3a+vEKvbp/n79eMo2Fiugl2fTd1aDgFw1RPt3MF66M1s1hvXWy13C
         7JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLABAOBxUi7apPgtRPROSyumsCPedDiB3eVS3aen4Uc=;
        b=IMS/SezGvSQmyYV+rC4cVF4Yxrp0RLYIr6qgutQVfiNM1lq4GzC7MSquwmall/i5RU
         HLXKjlL92Hra5aEzeWocrXCplo+f+ue2SiP+hkMHTqSt7GIkUZGzai1rZnO8XB6c3uyX
         deAhVasVU2MdUPnRvj4nJFfES38qBKmgIcyZys6wCqT0Ki/G4fO0So3760v78NJNRR7X
         SxwufAgyAlAG87A7Tfk5sYSGpZ1NY7pgnrss0C1PWdQRfDIlKF2iJJ8sD874yZasMk3A
         Mm+5G17GJ+8IUNOTzLCMY5ZZUmeNYBq0fUY0gRjvJ/qPBrW4Y8k0jZm/VMuyrMldRnvL
         vEnQ==
X-Gm-Message-State: APjAAAXDZigXhlhM9gzIUuCTSAGfBKiE/wrd6G+6Vy91zK4vYNE9vyUE
        /0I9igRiIo5spmHYgi4EQ+zIFLliRVCdQRDrC+eh1g==
X-Google-Smtp-Source: APXvYqw9eTL1smFdgM5CBMWe55qQwq7Ixm6mxLmSKQlk/U+TTmtbbBQA33hoHb3lK2Sjp3Q8KGTRfudgroyIOzz5krs=
X-Received: by 2002:a50:9918:: with SMTP id k24mr47972367edb.173.1560441949919;
 Thu, 13 Jun 2019 09:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
 <20190613135241.aghcrrz7rg2au3bw@MacBook-Pro-91.local> <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>
 <adc59944-7654-ea38-8dfc-f91361a80987@redhat.com>
In-Reply-To: <adc59944-7654-ea38-8dfc-f91361a80987@redhat.com>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Thu, 13 Jun 2019 19:05:38 +0300
Message-ID: <CAODwZ7u+f9vco8h1ZAwwoCefB6kM9gi4L_Mc7muLXYkwHRVc8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
To:     Eric Blake <eblake@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
        nbd@other.debian.org,
        Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>,
        linux-block@vger.kernel.org, axboe@kernel.dkn.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 13, 2019 at 6:14 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 6/13/19 9:45 AM, Roman Stratiienko wrote:
>
> >>
> >> Just throw nbd-client in your initramfs.  Every nbd server has it's own
> >> handshake protocol, embedding one particular servers handshake protocol into the
> >> kernel isn't the answer here.  Thanks,
>
> The handshake protocol is well-specified:
> https://github.com/NetworkBlockDevice/nbd/blob/cdb0bc57f3faefd7a5562d57ad57cd990781c415/doc/proto.md
>
> All servers implement various subsets of that document for the handshake.
>
> > Also, as far as I know mainline nbd-server daemon have only 2
> > handshake protocols. So called OLD-STYLE and NEW-STYLE. And OLD-STYLE
> > is no longer supported. So it should not be a problem, or please fix
> > me if I'm wrong.
>
> You are correct that oldstyle is no longer recommended. However, the
> current NBD specification states that newstyle has two different
> flavors, NBD_OPT_EXPORT_NAME (which you used, but is also old) and
> NBD_OPT_GO (which is newer, but is more likely to encounter differences
> where not all servers support it).
>
> The NBD specification includes a compatibility baseline:
> https://github.com/NetworkBlockDevice/nbd/blob/cdb0bc57f3faefd7a5562d57ad57cd990781c415/doc/proto.md#compatibility-and-interoperability
>
> and right now, NBD_OPT_GO (and _not_ NBD_OPT_EXPORT_NAME) is the
> preferred way forward.  As long as your handshake implementation
> complies with the baseline documented there, you'll have maximum
> portability to the largest number of servers that also support the
> baseline - but not all servers are up to that baseline yet.
>
> So, this becomes a question of how much are you reinventing baseline
> portability handshake concerns in the kernel, vs. in initramfs.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>

Thank you for the review comments, I will address them in v2.

--
Regards,
Roman
