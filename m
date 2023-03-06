Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F59CC64EC4
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 16:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCFQp5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 11:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjCFQpq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 11:45:46 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7683342BE5
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 08:45:23 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536be69eadfso195073667b3.1
        for <linux-block@vger.kernel.org>; Mon, 06 Mar 2023 08:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678121053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeiIC64U0Z4KW/12XhxzzRMgmpMS8kWmBn6nLpulo1U=;
        b=kaD2PqTaB/ea8nXHhWrl4Jp+K7sCYuw8r/yztKErZ/V8pD4rICzrjdMAaXjHR+UXBO
         SSglNg7BCo82wE/P8ZcQofXCPEHeVa5TlfVSs1vdNhzDzBwzds4Ur42auM6pzyphFSDZ
         pNbY82UO5L5DlyZ72K1qyt0W1/l6KSIK5492azWFvw81qUqyElMNYjokqh802Y/R00JC
         +7ps3GK1R5fUDcev6WzZZfIatn78Wl7XvEHcUotPGXCBhrGkJuIhdZ5Qk7OyMvh4O36D
         X53uKn3sF9A7SPpr0md0ReK04jo96hCIkpSbeL4XJPGg/N5R4m9H2LJrBw1+W8qcMbw2
         Ww6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678121053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeiIC64U0Z4KW/12XhxzzRMgmpMS8kWmBn6nLpulo1U=;
        b=sQrXnQLK5/i0zXO/Kh30Z/nPjjq62ukyCIviXfnCq2i7QDgRl8Yhx2ie/o1fDbulwO
         ZKJCgKwfv2qGIK1F1411z0+uQUAnTENVgMU0POmZumnrorgn6+2/WPa4sSzN9spNDnPI
         iYxPZa4gSgQTJe9oZpLiwy7uqe5b9bbgopTPcgXn+4TZU3lmzJZnOt4CX6+yk14zVKKY
         rdy4WJyDR7XI+eYcL454cd/MSc9ppDrmBnE4gz9qYvIvakHIdPJ0YcmuzNk4sIm2HJ1P
         vFRJKWIAAdK8XaAYXSWB8GceFAXOaArs93NNB59qcVx7Dk4hdkp0ZZeBNrN1T9MDRRt0
         9LOg==
X-Gm-Message-State: AO0yUKW9g10Ky9aeD/3B3Pak+Py+FmXA0PjXN/5dtOxYHcA90mv+e9WI
        44Cx7h3N57cmr7L1DXew3+MiEhbh5ObEw39fxIgA0Wj7toAOIht6
X-Google-Smtp-Source: AK7set+NnWaCzrTEP71yE2+cXUuCLs0EFXhNixWkzifFZLjCZYrvBQTjFgc2Mj/c/naCO6xdhZK0ikwZCgKn5NGQ2yY=
X-Received: by 2002:a17:90a:ea0b:b0:237:5e4c:7d78 with SMTP id
 w11-20020a17090aea0b00b002375e4c7d78mr4115345pjy.9.1678119028271; Mon, 06 Mar
 2023 08:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <5712c69ae37447c5b576d87b247f5756@hyperstone.com> <a35f3d45cab0442b9491c0b120e3fb47@hyperstone.com>
 <CAPDyKFpv3hHvg5X8WNpQEnnsNdGCBMybT-32EGPNYtBtSgK9Fw@mail.gmail.com> <5d7d48ff-b007-e339-8177-d0a7b7b8adc4@intel.com>
In-Reply-To: <5d7d48ff-b007-e339-8177-d0a7b7b8adc4@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Mar 2023 17:09:52 +0100
Message-ID: <CAPDyKFrW61y6B3xg9tyht505-mSHw=hAP4bGcUs68-zu7-=F7w@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>,
        Bean Huo <huobean@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 3 Mar 2023 at 15:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 3/03/23 14:01, Ulf Hansson wrote:
> > On Fri, 3 Mar 2023 at 12:40, Christian L=C3=B6hle <CLoehle@hyperstone.c=
om> wrote:
> >>
> >>
> >>>>
> >>>> REQ_FUA is in general supported for eMMC cards, which translates int=
o so called "reliable writes". To support these write operations, the CMD23=
 (MMC_CAP_CMD23), needs to be supported by the mmc host too, which is commo=
n but not always the case.
> >>>>
> >>>> For some eMMC devices, it has been reported that reliable writes are=
 quite costly, leading to performance degradations.
> >>>>
> >>>> In a way to improve the situation, let's avoid announcing REQ_FUA su=
pport if the eMMC supports an internal cache, as that allows us to rely sol=
ely on flush-requests (REQ_OP_FLUSH) instead, which seems to be a lot cheap=
er.
> >>>> Note that, those mmc hosts that lacks CMD23 support are already usin=
g this type of configuration, whatever that could mean.
> >>>
> >>> Just note that reliable write is strictly weaker than turning cache o=
ff/flushing, if card loses power during cache off/flush programming / busy,=
 sector-wise atomicity is not mandated by the spec.
> >>> (And that is assuming cache off/flush is actually respected by the ca=
rd as intended by the spec, should some cards be checked?) Maybe some FS pe=
ople can also chime in?
> >>
> >> Nevermind, the sector-wise atomicity should not matter on 5.1 cards or=
 if the block length isn't being played with, which it isn't in our case.
> >> If reliable write is implemented only according to spec, I don't see w=
hy the cache flushing should be less expensive, which would only make sense=
 if
> >> a) < sector chunks are committed to flash
> >> b) reliable write is implemented much stricter than the spec, ensuring=
 atomicity for the entire write.
> >
> > Right, I agree!
> >
> > Note 1) Reliable write was introduced way before cache management in
> > the eMMC spec. So, if the support for reliable write would have a
> > stricter implementation than needed, I would not be surprised.
>
> I am not sure when you say stricter than needed.  Historically
> file systems assumed that sectors are updated atomically i.e.
> there is never a sector with a mixture of old and new data.
> The eMMC spec does not guarantee that, except for reliable
> write.

Yes, I agree. With stricker, I was merely thinking of whether the eMMC
makes the entire write request (multiple sectors) being atomic, or the
guarantee is only per sector basis.

According to the eMMC spec, that seems to be implementation specific.
One option could be heavier than the other, I guess.

>
> File systems may use REQ_FUA for important information, like the
> superblock or a journal commit record, so using reliable write
> for REQ_FUA would seem to give better protection against file system
> corruption than a cache flush which could leave a sector
> half-written.

Yes, I agree. If we should fully conform to what is stated in the eMMC
spec, we should probably keep the current path to support REQ_FUA.

>
> On the other hand, sudden power loss is probably rare in battery
> powered systems because they are designed to monitor the battery
> power and shutdown when it gets too low.
>
> And file systems can use checksums to detect half-written updates.
>
> And there is anyway no protection for other (non REQ_FUA) writes a
> file system might do and expect not to tear sectors.
>
> And you are more likely to smash the screen than bounce the battery
> out and cause an unrecoverable file system error.

Right, these are good arguments to why $subject patch perhaps makes
sense to move forward with anyway.

Moreover, it seems like some eMMC vendors don't really have any
concerns with us moving away from reliable writes, to instead use only
"cache flushing". I guess it can indicate that the regular writes may
already be treated in an atomic kind of way, but who knows.

>
> Nevertheless, the commit message of this patch reads like the change
> is an optimization, whereas it seems more like a policy change.
> The commit message should perhaps say something like:
> "The consensus is that the benefit of improved performance by not
> using reliable-write for REQ_FUA is much greater than any potential
> benefit that reliable-write might provide to avoid file system
> corruption in the event of sudden power loss."

I agree. I will improve it along the lines of what you suggest.

>
> As for allowing for the policy to be overridden, perhaps an mmc_core
> module option?

Even if I am not very fond of module parameters, this seems like a
reasonable thing to use for this case.

I was also looking at using a card quirk.

>
> >
> > Note 2) In the eMMC v5.1 spec, the cache flushing support has been
> > extended to allow an explicit barrier operation. Perhaps, we should
> > let that option take precedence over a regular flush+barrier, for
> > REQ_OP_FLUSH!?
> >
> >>
> >> I guess the cards which increase performance do b)? Or something else?
> >
> > That's the tricky part to know, as it's the internals of the eMMC.
>
> It is the natural conclusion though.  The eMMC probably does not
> update mapping information with every write, instead if power is
> lost, it scans the updated areas at the next initialization. (The
> power-off notify feature would commit the mapping information to
> media to avoid that).  So a reliable write might have to:
> 1. write information to record that the old mapping
> should be used, not what might be discovered by scanning
> 2. do the actual write
> 3. write mapping information to record the new mapping

Yes. And depending on the eMMC device, some may be more clever than
others for how to actually deal with this.

>
> >
> > Although, it seems like both Avri (WDC) and Bean (Micron) would be
> > happy to proceed with $subject patch, which makes me more comfortable
> > to move forward.
> >
> >> Anyway regarding FUA i don't have any concerns regarding reliability w=
ith cache flush.
> >> I can add some performance comparisons with some eMMCs I have around t=
hough.
> >
> > That would be great, thanks a lot for helping out with testing!
> >

Kind regards
Uffe
