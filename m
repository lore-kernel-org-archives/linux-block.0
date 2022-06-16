Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78621C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 08:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376635AbiFPIvz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 04:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376576AbiFPIvd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 04:51:33 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842B85FF34
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 01:49:37 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-316287dc2d2so7456357b3.6
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 01:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4EhHBsPEoGDynj/GWwfSMGe6o2SfeALT5mjq/P4vmI=;
        b=uihogzk3XBrPzw8sph34Oye90P12Pjl/5IddUn1IQ7RaQVtFyCa33TUO4FJy1X0jBV
         cRIjeLqHYnw3c6TNw4nkB4QZM9OZ5trdHA1sPzzBGeNUaw2um+QcpoWh1QLGVEt6QfV7
         YvzVfKf9hfUhDNz75eUWJ9u0G9EOqbcqrkxLYJWevZAVI0K6qMQKHebMllAqMg4CYoiL
         jYrj2MoRpbH4/vPmLwVUalEy9tAfHA6L+3g2+d3D/EYjmQVEXi9QiZ8bnJGVXAqBIuBG
         5F0P7SASZH6sI2k/aivuonV+ic3DnM2vCY7SHRJOwg/wG41r0rjrKspxibl1pyX9Beop
         Mg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4EhHBsPEoGDynj/GWwfSMGe6o2SfeALT5mjq/P4vmI=;
        b=vB4fpKWc5ImfNeOWP4+QBdVd8O6ngOcwJ/pG7YDtSXBK0Cozvo17gJruGSylbTXeJM
         BPNzGYh0vv6rj+mtLQP1vLQ4NSt9F3X2rzk8u8PK8FXvm31QSbfg0IKDjAdBgh4DyGtt
         AORPTkRoSIuh5CwbUzZLKeGSqMoFtSEx7rX8Hun2Qy5Ngu1f+PhAADMPUrnryiJu4mXI
         K7DGLHbAK8X9Ndj8MlGGKIKA8ROvq8EeZwMtc5WWqsy680ocsNLe9ivSbWapJj86bPiM
         XXvoCQunri5fcD5at8M2NIJAxiDRIHcMbTkP7BoVL3whHN0Q5swXF459SkeMH990P1VA
         dGHw==
X-Gm-Message-State: AJIora84tK9vIaDiMn5gh67r46yrPI7Q7EMqNVqNdbtLFXdlDMF5FAhU
        yZJxHKDJd4cpp3Wcjaf5gQJXyLrjdcJ39zpfKAFe5RoPtPdX9vODXjQ=
X-Google-Smtp-Source: AGRyM1tb4WNybmuVdppOyiaexzWe/SL8A5HBwHvhf88dHUgwJR9n5ru0AsqSH6wZ0G1kFD/y93/OOyyMNgg1WOeJDA8=
X-Received: by 2002:a81:a50c:0:b0:30c:1f68:a375 with SMTP id
 u12-20020a81a50c000000b0030c1f68a375mr4258856ywg.106.1655369376438; Thu, 16
 Jun 2022 01:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAMSo37WW9veYH6=tHqUR2pa_7YX1UuzHqLBHit60P2QyzQmCEw@mail.gmail.com>
 <Yqd9xjOiOapfBt/A@kroah.com>
In-Reply-To: <Yqd9xjOiOapfBt/A@kroah.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Thu, 16 Jun 2022 16:49:25 +0800
Message-ID: <CAMSo37W8E-=ceGHwky2Rs0NWeVrzcAMdeQdEnp7NTjWXAu3voQ@mail.gmail.com>
Subject: Re: Please help cherry pick four mmc related changes into the 4.14
 stable kernel
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Benjamin Copeland <benjamin.copeland@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Alistair Delva <adelva@google.com>,
        Steve Muckle <smuckle@google.com>,
        Todd Kjos <tkjos@google.com>,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Greg

Sorry for the confusion here, please ignore this request.

I made a mistake there with cherry picking the changes based on one vendor tree,
and there are actually more out of tree changes necessary for the commit
23161bed631a("mmc: sdhci-omap: Fix busy detection by enabling
MMC_CAP_NEED_RSP_BUSY")
to be cherry picked into the 4.14 stable branch.

All the necessary changes are in 4.19, but not in 4.14, and
backporting all of the changes
would be a bit complex task, for the moment. I will cherry pick the
changes to the vendor tree
which has the changes to make the build work.

Sorry again for the confusion here:(

Thanks,
Yongqin Liu

On Tue, 14 Jun 2022 at 02:11, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 08, 2022 at 01:09:54AM +0800, Yongqin Liu wrote:
> > Hi, All
> >
> > With the 4.14.281 version[1], there were three mmc related changes merged,
> > but that causes one boot failure with the X15 Android builds, a problem
> > similar to one reported before here[2].
> > After being confirmed with Ulf Hansson, and verified with the X15 Android build,
> > it needs to have the following four commits cherry-picked to the 4.14
> > branch as well.
> >
> >     4f32b45c9a2c mmc: core: Allow host controllers to require R1B for CMD6
> >     5fc615c1e3eb mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
> >     d091259b8d7a mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC sleep command
> >     23161bed631a mmc: sdhci-omap: Fix busy detection by enabling
> > MMC_CAP_NEED_RSP_BUSY
> >
> > The above four commits are from the 4.19 branch, as they are a little
> > easier to be cherry-picked
> > into the 4.14 branch, compared to the commits from the mainline branch.
> > (I have confirmed that the four commits are all in 4.19, 5.4, 5.10 and
> > mainline branches already).
> >
> > Saying that, there will be still one merge conflict reported when
> > cherry picking the commit of
> > 4f32b45c9a2c, it's easy to resolve though.
> > To avoid the merge conflict, it could be done like this as well:
> > 1. revert the 327b6689898b commit from 4.14 first, so that the commits in step#2
> >     could be cherry-picked without any problem
> >         327b6689898b mmc: core: Default to generic_cmd6_time as
> > timeout in __mmc_switch()
> > 2. git cherry-pick the following commits from 4.19 into the 4.14 branch
> >         4f32b45c9a2c mmc: core: Allow host controllers to require R1B for CMD6
> >         5fc615c1e3eb mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for
> > erase/trim/discard
> >         d091259b8d7a mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC
> > sleep command
> >         23161bed631a mmc: sdhci-omap: Fix busy detection by enabling
> > MMC_CAP_NEED_RSP_BUSY
> >         26c6f614cf02 mmc: mmc: core: Default to generic_cmd6_time as
> > timeout in __mmc_switch()
> >     The last commit of 26c6f614cf02 is for the revert in step#1.
> >
> > I am not sure which way is more convenient for the maintenance work
> > here, so just list both of them here
> > for your information.
> > And please let me know if there is anything else I could help on this
> > cherry pick work here.
>
> Please send properly backported patches to us, trying to do the revert
> and fixup like you describe above is going to be hard to verify I got it
> right.  A series of patches is best as that way we know you tested it
> properly and sent us the correct patches.
>
> thanks,
>
> greg k-h



-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
