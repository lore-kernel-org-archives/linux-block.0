Return-Path: <SRS0=t5dV=4R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676C8C3F2C6
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 15:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B0D246A2
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582991913;
	bh=iu22HjzvtCZYDPv+CtkxRKwYp+sLiJKEC2BWNXNvLCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SZqLT68TME2uyzHCWvUwBikrCcQOwyYQiHMr2iDtUzP0NUkyjfdxpl31vXIG934JO
	 M5chuPKORYFJFXGWh+vuQSux/qRJtEYJRUZLi1fQ9VlawLqO/zgKoF1vHYejj9Y52E
	 yqVO3yj3f6E9mYQUafp9P0kSR4f15J6rM2yzFsbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgB2P6c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Feb 2020 10:58:32 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40967 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgB2P6c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Feb 2020 10:58:32 -0500
Received: by mail-lf1-f67.google.com with SMTP id y17so4363059lfe.8
        for <linux-block@vger.kernel.org>; Sat, 29 Feb 2020 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6cMfsy81kHnm1ci8XSZPZeZCFxF3rUOuMFeIL9RyjNQ=;
        b=Nvzi4dIUW38oxwa8h6Q/ImOrapuHG3joT7hNsPpnJcUScDEv12qWwONvOxZ0jk1dn+
         FirQzUBoNCex3HxiW4NQp8LHld3xt/JFJ68qDTsscjma9STzwP5DmgnJsyHGZXgNpUVR
         Jw0FGDFewUZ5e4dtt5w1Jx0iatHjuEkaM5Xgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6cMfsy81kHnm1ci8XSZPZeZCFxF3rUOuMFeIL9RyjNQ=;
        b=lVdsflAo49QB4cD8hOPlpEpc0e7S1NQ49gX+zWjVgmW7s7146RwpZUJwXREHkKIOL0
         Xjk0SjnIgzzbnDfNK3kfWka4vt7OI2fnoXb0ERiW8+bm+YwmVpWyb3Kp1HuvEmYB3Bzo
         9NxoDZmvvYLlN7GrEW98cvdLYdeHsiPVD2uQgm5zp1RHUMOCOUw/y2jFMultGh6hcWD/
         /bG/blazTklX+Cw0wW8v8RttlfwfTU9RVTXaBmQpJXU/ERrRyC9Utd0czQOuMgHLm5+I
         eoM6CtlyB4TsV+HzHSST61W62WMvn767o1GiES6L5wvwEu/n/SzhA3AGxKn+PBQ3oCUI
         pCkw==
X-Gm-Message-State: ANhLgQ1tsdyR3ktugLvuTe9yRw7P11kHTGgsyk87UL4WV6L5koy+6Acf
        N12gHzwyzKPzQcSPhTkkl2gx/URhzsw=
X-Google-Smtp-Source: ADFU+vtUn02NwIAu4KEeZmqbP1b1X73pPZm2/NwOZWYoVwOJr9hb2zJ8cUSVx7B5goyBwsJCiibndA==
X-Received: by 2002:a19:c515:: with SMTP id w21mr5508064lfe.169.1582991909679;
        Sat, 29 Feb 2020 07:58:29 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y12sm7371585lfe.85.2020.02.29.07.58.28
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 07:58:28 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id w27so4402694lfc.1
        for <linux-block@vger.kernel.org>; Sat, 29 Feb 2020 07:58:28 -0800 (PST)
X-Received: by 2002:a19:6144:: with SMTP id m4mr5453322lfk.192.1582991907916;
 Sat, 29 Feb 2020 07:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20200224212352.8640-1-w@1wt.eu> <0f5effb1-b228-dd00-05bc-de5801ce4626@linux.com>
 <CAHk-=whd_Wpi1-TGcooUTE+z-Z-f32n2vFQANszvAou_Fopvzw@mail.gmail.com> <20200229141354.GA23095@1wt.eu>
In-Reply-To: <20200229141354.GA23095@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Feb 2020 09:58:11 -0600
X-Gmail-Original-Message-ID: <CAHk-=whFAAV_TOLFNnj=wu4mD2L9OvgB6n2sKDdmd8buMKFv8A@mail.gmail.com>
Message-ID: <CAHk-=whFAAV_TOLFNnj=wu4mD2L9OvgB6n2sKDdmd8buMKFv8A@mail.gmail.com>
Subject: Re: [PATCH 00/10] floppy driver cleanups (deobfuscation)
To:     Willy Tarreau <w@1wt.eu>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 29, 2020 at 8:14 AM Willy Tarreau <w@1wt.eu> wrote:
>
> So if you or Denis think there's some value in me continuing to explore
> one of these areas, I can continue, otherwise I can simply resend the
> last part of my series with the few missing Cc and be done with it.

It's fine - this driver isn't worth spending a ton of effort on.

The only users are virtualization, and even they are going away
because floppies are so small, and other things have become more
standard anyway (ie USB disk) or easier to emulate (NVMe or whatever).

So I suspect the only reason floppy is used even in that area is just
legacy "we haven't bothered updating to anything better and we have
old scripts and images that work".

              Linus
