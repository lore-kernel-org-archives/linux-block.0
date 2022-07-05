Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EAFC433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 10:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiGEKij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jul 2022 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiGEKif (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jul 2022 06:38:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B35D13D31
        for <linux-block@vger.kernel.org>; Tue,  5 Jul 2022 03:38:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d2so20921087ejy.1
        for <linux-block@vger.kernel.org>; Tue, 05 Jul 2022 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+KTPQ0EW4by9O0ZZopVQU1IQ5mmcvSbu19io1bxOPU=;
        b=Nkp7FUnvUtSXSDIWPfa5cxzbYEYLoK7DT0XJXOwGN19z+8YHe+HlNfc1s6swFFgppm
         iyIpUm09qM7aY+cv3jMbmk8NduXPZdWxPP2cg7fUjLJRYiocDruStIm+evkYYphBO867
         ArFwkQu09E9eV/OXk5KbumG1OabNpFLPamrtlhkSeaxtTS9loppVtfNGaVtXNTeNQHvL
         nYYbP/lDYkYIkubTfsMFXH6jnlbfYRumvAqu2J8ose7TVfEMnHuITyYlQwjxpPd+3Scd
         GYo4hDT2nlEegQvFd7rVtFi5lKhoylQNdunr9iasUCJJlEdU59fV55XaP8vtcy0VjeYV
         ad+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+KTPQ0EW4by9O0ZZopVQU1IQ5mmcvSbu19io1bxOPU=;
        b=DGhAit9wgarszy8Oin9yQIpyefELnecZwdp2kua7Zj+GJfZSXttJWWLjB02DlgzWuc
         DGSW89pB1OIqMni3NIxRg0pQCsi2tDhpUOdu4l12lgtUKQVrb7R6dlbQckwDfJ6xUJ8p
         szCk+W5qtu0sFCTVaVWTIxMcrx3Nny3RzXPC14G+KqhDKME65OzGDCNFhkrbugmRUM/V
         aXllU2bfgsRuVR5vTtvEQDHNEUuXyT1QC2QJV05lLt2bfikK6HFOjHr7immVaQGPZceQ
         Y2XRHwRQ4KJCa++1oTEPmRz9WmHrDqdjCgbsFEWLjx4ZmlhvbiGtm/5XZNOudK8bzT5t
         BJLg==
X-Gm-Message-State: AJIora+LHMv72D4P48QZPR1SYjSa7cGxyRGonF501OU9+v9u35Oyo/pD
        mMAd+V7rZ5LOOGmQq54H/dSjgOwKrJzVP3WqvftLK0EQfVU=
X-Google-Smtp-Source: AGRyM1vx+9DQzNhXZMzVLIiMKEACMkObtIETj3ZPe6NE9YnW8xDnk3xwmZyCuFpGZrZwGQkQZokqELpzSQ+BTfBiczU=
X-Received: by 2002:a17:907:1c8f:b0:6e8:f898:63bb with SMTP id
 nb15-20020a1709071c8f00b006e8f89863bbmr33787958ejc.721.1657017510025; Tue, 05
 Jul 2022 03:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220125215248.6489-1-luca.boccassi@gmail.com>
 <10a8fbc8-c242-af90-2a3f-d55cd27497a8@linux.vnet.ibm.com> <CAMw=ZnTJxFhcVgApcj6YNtU2Djcybrf9gN_6dmfr7QM+jxXmww@mail.gmail.com>
In-Reply-To: <CAMw=ZnTJxFhcVgApcj6YNtU2Djcybrf9gN_6dmfr7QM+jxXmww@mail.gmail.com>
From:   Luca Boccassi <luca.boccassi@gmail.com>
Date:   Tue, 5 Jul 2022 11:38:18 +0100
Message-ID: <CAMw=ZnTnPrbadQdwLLzL6419V=8hcB9hT1_tbinRONGLsB4qjQ@mail.gmail.com>
Subject: Re: [PATCH v3] block: sed-opal: Add ioctl to return device status
To:     Douglas Miller <dougmill@linux.vnet.ibm.com>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 30 Jan 2022 at 16:19, Luca Boccassi <luca.boccassi@gmail.com> wrote:
>
> On Tue, 25 Jan 2022 at 22:03, Douglas Miller
> <dougmill@linux.vnet.ibm.com> wrote:
> >
> > On 1/25/22 15:52, luca.boccassi@gmail.com wrote:
> > > From: "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>
> > >
> > > Provide a mechanism to retrieve basic status information about
> > > the device, including the "supported" flag indicating whether
> > > SED-OPAL is supported. The information returned is from the various
> > > feature descriptors received during the discovery0 step, and so
> > > this ioctl does nothing more than perform the discovery0 step
> > > and then save the information received. See "struct opal_status"
> > > and OPAL_FL_* bits for the status information currently returned.
> > >
> > > Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> > > Tested-by: Luca Boccassi <bluca@debian.org>
> > > ---
> > > v2: https://patchwork.kernel.org/project/linux-block/patch/612795b5.tj7FMS9wzchsMzrK%25dougmill@linux.vnet.ibm.com/
> > > v3: resend on request, after rebasing and testing on my machine
> >
> > I would like to withdraw this patch. We are going a different direction
> > for our SED-OPAL support and will be submitting a new set of patches
> > soon, which includes a different method of obtaining the discovery0 data.
>
> Hi,
>
> Do you have a rough ETA on the new series? Also would you mind CC'ing
> me when you send it, please? Thanks!

Hello Douglas,

It's been more than half a year now, any progress on this new set of
patches? I really need this functionality.

Kind regards,
Luca Boccassi
