Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB831C35E01
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 18:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A54206E6
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 18:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582654151;
	bh=3z9DJSPwKU7LT01/i+GtZZurxG5ZqfAbO0PMax6MAEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nkWl2tzZ3mPlBO4Vuvf30OGENKiP9kjKJa6aE77EYDBbZPJ6LtI3vEa8bd/JZ8lwP
	 h3xgaSf5iZAshKzEXWkG0ak6Zp8MoXSAlKXForgwfblEuS2US+S8VmAGfB8WmP6GNP
	 qvot3gtWjDZhcD+9bt3Wc0nN0gz9YRpqXFtdWGRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbgBYSJL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:09:11 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43212 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbgBYSJL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 13:09:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so15067066ljm.10
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2020 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZj7OE/AEXTNTWMBPQHvBKDqkcJwx1C7Z4An7x1Nm6U=;
        b=hHcBd9t2SzG6GRzXGR/mlF1Hw96u3fivqizE/4XEZF2XKT3vjc/66UmfCvsIAK8miD
         Er1UoTiiGLOhLDhtdaN5nX8PUWHYXn2CoVpux4hudCe/PVSGle1Ey1idxU70dMRG02qq
         vUEKlXCx3wt7cMV6NOJo8//NTEdOol4kRReL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZj7OE/AEXTNTWMBPQHvBKDqkcJwx1C7Z4An7x1Nm6U=;
        b=ibWdCezNP6mxqN92e7cGTc3dHjs38ULB/sYUvBSA6DfOxEzlzaIbvRtxEOivHkkUoa
         yr8+X9iBeVRprRxqJd+02bNUZcBLacnBvpv1ucoZbm8F3SQ86e/4qk14evq6qrCaBJBj
         zbqiY/jpUezbxwI+UxVashmXspNIBKPIh8eAXuMTpvT2Awl8BGfW93zVPDF+meHc4ihY
         pPXJxFxxqTnb07LzlCpH7ssY1OIELTwXh1KHq80OSfdu0vIolB8HDYELcdf5T38fMtVB
         BSuR0vcbkg/BmYfkPtYSne14IkYuS0/a7u0WS4iwlQRSU4NKnSvHVEux0KqOoai5wS+G
         GMrg==
X-Gm-Message-State: APjAAAUwEvW6H1+17c9zh1mkPZy3naXe2Oe+qCI0NhU4xsM0IQU/Dn6p
        lPqJeBlMLivDmBI0yr9ZmlWF408iVd0=
X-Google-Smtp-Source: APXvYqwLb2ebeKujmrVfW1dRuHGZjZnGJ/2H5/uOo1SlMh3IYT3S5FgLcW5L5JJFZvUgXD+Entif0A==
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr162913lja.81.1582654148822;
        Tue, 25 Feb 2020 10:09:08 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id f8sm3464913lfc.10.2020.02.25.10.09.07
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 10:09:08 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id w1so15081462ljh.5
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2020 10:09:07 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr188557ljb.150.1582654147202;
 Tue, 25 Feb 2020 10:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20200224212352.8640-1-w@1wt.eu> <20200224212352.8640-2-w@1wt.eu>
 <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
 <28e72058-021d-6de0-477e-6038a10d96da@linux.com> <20200225034529.GA8908@1wt.eu>
 <c181b184-1785-b221-76fa-4313bbada09d@linux.com> <20200225140207.GA31782@1wt.eu>
 <10bc7df1-7a80-a05a-3434-ed0d668d0c6c@linux.com>
In-Reply-To: <10bc7df1-7a80-a05a-3434-ed0d668d0c6c@linux.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Feb 2020 10:08:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggnfCR2JcC-U9LxfeBo2UMagd-neEs8PwDHsGVfLfS=Q@mail.gmail.com>
Message-ID: <CAHk-=wggnfCR2JcC-U9LxfeBo2UMagd-neEs8PwDHsGVfLfS=Q@mail.gmail.com>
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
To:     Denis Efremov <efremov@linux.com>
Cc:     Willy Tarreau <w@1wt.eu>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 25, 2020 at 7:22 AM Denis Efremov <efremov@linux.com> wrote:
>
> I think that for the first attempt changing will be enough:
> -static int fdc;                        /* current fdc */
> +static int current_fdc;                        /* current fdc */
> and
> -#define FD_IOPORT fdc_state[fdc].address
> +#define FD_IOPORT fdc_state[current_fdc].address

Please don't do this blindly - ie without verifying that there are no
cases of that "local fdc variable shadowing" issue.

Of course, such a verification might be as easy as "generates exact
same code" rather than looking at every use.

And btw, don't worry too much about this being in an UAPI file. I'm
pretty sure that's because of specialty programs that use the magical
ioctls to do special formatting. They want the special commands
(FD_FORMAT etc), but I don't think they really use the port addresses.

So I think it's in a UAPI file entirely by mistake.

We should at least try moving those bits to the floppy.c file and
remove it from the header file.

For example, doing a Debian code search on "FDPATCHES" doesn't find
any user space hits. Searching for "FD_STATUS" gets a lot of hits, but
thos all seem to be because it's a symbol used by user space programs,
("file descriptor status"), not because those hits actually used the
fdreg.h header file.

So we can remove at least the FD_IOPORT mess from the header file, I bet.

Worst case - if somebody finds some case that uses them, we can put it back.

                Linus
