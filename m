Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBA4C61DA4
	for <linux-block@archiver.kernel.org>; Fri, 27 Jan 2023 15:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjA0P6s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Jan 2023 10:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjA0P6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 10:58:47 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCBE86637
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 07:58:41 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 36so3465114pgp.10
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 07:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLM9fJV2OakKqd36YJxxEJYAlIbXLOshTjOPLX8PU4c=;
        b=VpL/jhAfmgxTZiKa9pK4rSG5AUZUiNfO1qMX9Z/MFlW2cTsUwk2IEUji//2c37ACVW
         87jg3kuYQscpybE7Xk5XWJYixUvz5AG71KBllyuo+hG4t4zbJxmHwf5wKGr33bwFkaH/
         WFbRWD62OenZYXyv0FR4CUzsbm8md7tTo4KcRO+9EXs4tKFYmfp4N4tHIJCblBU8RgeL
         YaxSWz8q6b0wDDTTUQ8fkc2qu1OkgEvB4q2m+fSnILZF72EviUkk2xIkUtkzcvdXWmZB
         o6nHG1ZcHPU4T0Ea3StcApx/ZFhaBTUCVSwMN0yTNrYWTinH5K7MuFDaKA9GThTtc2Wp
         Gsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLM9fJV2OakKqd36YJxxEJYAlIbXLOshTjOPLX8PU4c=;
        b=Qya7H1RPDScIWm4EzDI5l0RUPSImrpBurTc1Lzagaetr+oH3L9jVfl90Cql/JVCYyp
         kDlwbIHZjvnXfXFlWRqH0SL3yIVTHd+5heSuN1ftI/bDxYHvhf5ZU9boFU8wqZ9oi7VN
         c2mXwN/R0pHJLIZCv3wFAmrL/1QLAubORNO1gCPcwAwnjEXmcpq13BOABUEX0CsAu0lE
         jYmJWMKaYw6xFgVl0C9tnnckeOHCsHysez/4WqlRFZGhdf8Lb6Rko06KiJ1zBuWMKMDQ
         h8R9jZVf7xotaSfyz/uYmePN1PDR3RgwlWqEM59pze97F0LavPVD092eeEkkGjM8ENLr
         NmIQ==
X-Gm-Message-State: AO0yUKVgdJGhby9QhqFE6C4meICSygGqDy9bvgNLEbGaLiPWwowVcIfr
        sS/aOJAYLRQBrGU2FBLmUurrosvT8rASlkTAW0Vs2w==
X-Google-Smtp-Source: AK7set8Lvh1ZvALlREZDK1x12Ja5QDTTn/XlXrMHn/IHabRBY+Ekk/B6e9azuI+e7w5Vjk85sHbngcoBtygXHUBUmbQ=
X-Received: by 2002:a62:1a4c:0:b0:592:5cbf:c71f with SMTP id
 a73-20020a621a4c000000b005925cbfc71fmr700905pfa.29.1674835120584; Fri, 27 Jan
 2023 07:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20230127154339.157460-1-ulf.hansson@linaro.org> <5743fb1b-eb4b-d169-a467-ee618bcd75f5@kernel.dk>
In-Reply-To: <5743fb1b-eb4b-d169-a467-ee618bcd75f5@kernel.dk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Jan 2023 16:58:04 +0100
Message-ID: <CAPDyKFqFrB4h21F0901nBp-mpiP70nObOrCpRA0ZRfOD_kD5ug@mail.gmail.com>
Subject: Re: [PATCH] block: Default to build the BFQ I/O scheduler
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 27 Jan 2023 at 16:48, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/27/23 8:43=E2=80=AFAM, Ulf Hansson wrote:
> > Today BFQ is widely used and it's also the default choice for some of t=
he
> > single-queue-based storage devices. Therefore, let's make it more
> > convenient to build it as default, along with the other I/O schedulers.
> >
> > Let's also build the cgroup support for BFQ as default, as it's likely =
that
> > it's wanted too, assuming CONFIG_BLK_CGROUP is also set, of course.
>
> This won't make much of a difference, when the symbols are already in
> the .config. So let's please not. It may be a 'y' for you by default,
> but for lots of others it is not. Don't impose it on folks.

This isn't about folkz, but HW. :-)

I was thinking that it makes sense for the similar reason to why kyber
and deadline are being built as default. Or are there any particular
other reasons to why we build those in as default, but not BFQ?

Kind regards
Uffe
