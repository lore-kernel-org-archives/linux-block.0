Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE43C433F5
	for <linux-block@archiver.kernel.org>; Thu,  2 Dec 2021 12:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346782AbhLBMcV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 07:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbhLBMcU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Dec 2021 07:32:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86552C06174A
        for <linux-block@vger.kernel.org>; Thu,  2 Dec 2021 04:28:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o20so114623594eds.10
        for <linux-block@vger.kernel.org>; Thu, 02 Dec 2021 04:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIHJduGhi+IgJjblRtFiKjHLP7Ao4GSCzCbgjV6AI0g=;
        b=bEYsv4wF853W8UKT+8STBH1C/eBQtC+ON3Re4sV3zlkHai540cHzD6xE96e+vYUGZi
         UiohbLIkxHnwTZfDMk8iBLuuZC1mkyxp+elc2Tf9JiPj9KoORf+AfZ+2kv8le9J9oo7X
         lm/NBTxhXW4+XeCD2V/KGi9weCBYzO1T6Rc+PzBInJF1bevBYSVqQO7J3gCUriljU9nr
         FAHXa71KoufMw1NkUz2bQnW9uZUm+9EdfJHuxCZwSpEaKB6GCghqJGU8t4DAgaKVsEJ9
         pGJ8mZC7zq3UTM1ntOtki3tLCO0ktvnYf0xTP8MdHcy821ym/i1+0j6sccsMWHLCfqAL
         4huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIHJduGhi+IgJjblRtFiKjHLP7Ao4GSCzCbgjV6AI0g=;
        b=JqSUGuAkIpki+GOVhSrI8ogUe1DNzbXyEgn4V/dV2JnxlMCI1iZTqitGDqv3CL1tZq
         O0I3jFHOIFS4Pa22tUP5WcjZu3RoxYrLsSHKvfIJQSiOIU5ubSjYRhVkC8C4Z490/k/j
         FGQTJPf7CwJ7dU1oW8M2ZezClhOa1JUBTdaKJnvwOMMvl7gHfLFa6coqCCDAm1Qy9bcg
         x7jWuIJP+H2dFysMiULX+v2LeWqVTDOX3C689DdcP+l6x6uoKB/5eumYUsxVPSlAGhtn
         gylsSfFiNgQCglAwIv04rG6+ChrE2z2esn3lRVsL1L3nAqUeW+vgRkgqI6iG47kolqIS
         DVyQ==
X-Gm-Message-State: AOAM531yn1hgh7A7OAnEB7RSHvOrBkYO4e+kL7pZr7rthTib8g1mVjBT
        Q4UGsqt0CyZ8bujxUCPErVfMKNxQxFY0CG3ERaBLlw==
X-Google-Smtp-Source: ABdhPJwVLTfOeFrJH1vtaO5VgCmVt8kl/7m1GwfsGdFPILzfElCaVjFePEsuiYfj32fzPRUhQkb9mSEvHSNwJ50Wmo0=
X-Received: by 2002:a05:6402:4389:: with SMTP id o9mr17620193edc.138.1638448137066;
 Thu, 02 Dec 2021 04:28:57 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuupqqemLbgoVL2kYL4d2AtZLBo1xcshWWae7gX5Ln-iA@mail.gmail.com>
In-Reply-To: <CA+G9fYuupqqemLbgoVL2kYL4d2AtZLBo1xcshWWae7gX5Ln-iA@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 2 Dec 2021 13:28:46 +0100
Message-ID: <CADYN=9KeKhZ-OSbx1QHKYfXu+p-nXVjubbay1sXd_g75LLSZRg@mail.gmail.com>
Subject: Re: [next] WARNING: CPU: 2 PID: 66 at kernel/locking/rwsem.c:1298 __up_read
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        sean@geanix.com, Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 30 Nov 2021 at 18:01, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> [Please ignore this email if it is already reported]
>
> Regression found on qemu_arm64.
> Following kernel warnings reported on Linux next-20211130 while booting.

I bisected down to 1ebe2e5f9d68 ("block: remove GENHD_FL_EXT_DEVT")

and when I reverted 1ebe2e5f9d68 ("block: remove GENHD_FL_EXT_DEVT") and the
3 releated patches so patch 1ebe2e5f9d68 was reverted cleanly I
managed to boot without
a warning.

Related patches from next-20211130:
9f18db572c97 ("block: don't set GENHD_FL_NO_PART for hidden gendisks")
430cc5d3ab4d ("block: cleanup the GENHD_FL_* definitions")
a4561f9fccc5 ("sr: set GENHD_FL_REMOVABLE earlier")

With this said, if I revert 9d6abd489e70 ("mtd: core: protect access
to MTD devices while in suspend")
I didn't see the warning either.

Any idea what can be wrong here or what a fix could be?

Only apply this patch from Geert
https://lore.kernel.org/lkml/c26dfdf9ce56e92d23530a09db386b283e62845d.1638289204.git.geert+renesas@glider.be/
makes the warning go away too.

Cheers,
Anders
