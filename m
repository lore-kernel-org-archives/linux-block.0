Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A22C2BBD4
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 15:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D4723B53
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 15:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgLRPeS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Dec 2020 10:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgLRPeR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Dec 2020 10:34:17 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C710C061282
        for <linux-block@vger.kernel.org>; Fri, 18 Dec 2020 07:33:37 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cw27so2775128edb.5
        for <linux-block@vger.kernel.org>; Fri, 18 Dec 2020 07:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQLHp84/L9U/ihCT8VfX+s5+pC9qLQ5ItLSujKOjqfo=;
        b=PSaCXVorV9N6hgWS5S2oA6nGbi2jvEosNxw2csDkCTtQwSh9dq6ZLjcNN/zQ8w62KX
         d7DMqdLUJ3hqRA4B79yg/w0mdqtCH2aqZJ6Szpcw389A8TwD6k65+gh39HITRzkk2ekf
         yziVZK6lwzW+4fDMkNbILlTUyMPzmMTkyOTOhzRasliNm9kV+IZBNCkxfqaecBrwV/TB
         fIo6kuHI40S8XOlyQRH60Scl9BahJl/QBzsmrmCw2JPUpL2zP487pvTviFqeN7jnqSmr
         qfeXMBsvccF/uQ1zeVonCgyzXzbFnqKDm3tp1prSwWIveKW7jBZFs+vh1DSk8tf9Mewv
         FoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQLHp84/L9U/ihCT8VfX+s5+pC9qLQ5ItLSujKOjqfo=;
        b=LxCPk3jPkP+yvL462VZrPC73sSpEquDq2DC0U5gV5fmTrDCb18ohg6OmxM4vQhD+D6
         LINd/TgLNGhmfS8XsXVd9Eu1jxhPEUTj8bkSlQ6DBvLjSmi7kcrnCc2SZC+lXxijwkvG
         tl/VmQUMwhm8hnet4BHb02IVT7EzDuqdUqgNf/wzSNVpIg99lU032JWH6FnuQ4xKQNye
         E4KAfcCPFcvKOjkCKDViCTxSZZ0nEG16padch92L7H+T7N/czon1M5h71H21ARv4sK7t
         zVT8+px8xyHRVpHlBWgLPZo2nKZDU8I7WlMy3ZMnIovndJ6G1+E6t2GcO19kT8hH8TmD
         glhA==
X-Gm-Message-State: AOAM533gHzZKTdSBavl1/W/zlcXC6Crq50AV1GuNWO8ZYNnvm/dEV3yE
        hCAW8/tanhqHA2SUcsQB9iLB0K3BkXB5VezWl7Y3Dw==
X-Google-Smtp-Source: ABdhPJy7/5uKUHba6f7gwuVlwUuuX2xLgWtneNUdQVPgyORTO3atXdYK91RrwgHjFhEAr8oKn0iG2Olkp/Zn9Oe6zcE=
X-Received: by 2002:a05:6402:a53:: with SMTP id bt19mr5029336edb.104.1608305615830;
 Fri, 18 Dec 2020 07:33:35 -0800 (PST)
MIME-Version: 1.0
References: <1606479915-7259-1-git-send-email-ingleswapnil@gmail.com>
 <CAHg0HuzKb0e21bo3V53zskKtk+zaJXhxkU8m4w6Q2DWoWPkU6w@mail.gmail.com>
 <CAJCWmDdEPa23XDZ8pdStH=PgMszq4N6mHmNWtUA5Fn4THSNRmw@mail.gmail.com>
 <CAMGffEm2LVxXJP-HseTqihcCvPeYOkCsaFHVNKXDZAYxCPzwTA@mail.gmail.com> <a36bef5e-f7e3-c29b-8e65-38dc92812850@kernel.dk>
In-Reply-To: <a36bef5e-f7e3-c29b-8e65-38dc92812850@kernel.dk>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 18 Dec 2020 16:33:25 +0100
Message-ID: <CAMGffEk9mB=obJTtUq-xaay4XTx37OM7VQN24SLSTfcXoC-2GA@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: Adding name to the Contributors List
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        swapnil ingle <ingleswapnil@gmail.com>,
        linux-rdma@vger.kernel.org,
        "open list:RNBD BLOCK DRIVERS" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Jens
On Fri, Dec 18, 2020 at 3:53 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/17/20 11:46 PM, Jinpu Wang wrote:
> > Hi Jens,
> >
> > On Thu, Dec 17, 2020 at 6:44 PM swapnil ingle <ingleswapnil@gmail.com> wrote:
> >>
> >> Adding linux-rdma@vger.kernel.org
> >>
> >> On Fri, Nov 27, 2020 at 1:54 PM Danil Kipnis <danil.kipnis@cloud.ionos.com> wrote:
> >>>
> >>> On Fri, Nov 27, 2020 at 1:31 PM Swapnil Ingle <ingleswapnil@gmail.com> wrote:
> >>>>
> >>>> Adding name to the Contributors List
> >>>>
> >>>> Signed-off-by: Swapnil Ingle <ingleswapnil@gmail.com>
> >>>
> >>> Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Can you pick up this patch, or do you need a resend from me or Swapnil?
>
> Just include as part of the next series of patches. Though I do question
> why we need such a contributors list to begin with, if you do git log on
> the rnbd/ directory it'd show you anyway.
Thanks for the suggestion, we will include it as part of next series.
The initial reason to have such contributors list was to give credit
to people who worked on
the project in the past, Swapnil's name was missed.
>
> I'd also suggest moving the parts of the README that makes sense into a
> proper Documentation/ file, nobody is going to find it deep in the
> kernel source tree as it is.
Sounds good, will do it.
>
> --
> Jens Axboe
>
Thanks
Jack
