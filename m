Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13DAC4727C
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 09:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D53621481
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 09:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JarCYdPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbgJAJ1e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAJ1d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 05:27:33 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BBCC0613D0;
        Thu,  1 Oct 2020 02:27:33 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e5so5417611ilr.8;
        Thu, 01 Oct 2020 02:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qUia3HgPOs5osTmAsLb1Vjj65TsZDjcpJemkNk78TI4=;
        b=JarCYdPrqxm+TFo/whyh8Xy7DlG5ExMrNDp5yNFJuFFR18qPfnv3SHhGcswvEizkmm
         yrqF0JsvDk04/RDpbvPOsMRZFTj8mqCeedjPB0l1Sbjklflvo+nSgsjCk2H59y0nIf8g
         HhGL6xjfe9dnkyuIhesRNPfMMlHLfghRYnweApamNFp8uVLvuV7vX9vzKR5vKzEac6hw
         fePGIpgAiLa1zGEarMiHC4NdRzN63ekxFDZt3kM+BRByrMhNSOBnousKb8U+gdLUscS1
         wGsgAswIWqr1VwhiLTAldr4h8M6xnZG2ZWBvYRiNmyobCk2NBFp8yxzy92tlM9myS3co
         BhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qUia3HgPOs5osTmAsLb1Vjj65TsZDjcpJemkNk78TI4=;
        b=Hiqhwom35a58MtsxIaXwuQWZ7KH1Bu6AnFlpYnauPPuV8DDVuGWkERrEF71OFJcco+
         ccS9LvP7KGfuN/Z3XSsO36yrza8i2+lJEVEzNS3Fr2vWa0VyH0WGFBv1wWB707tK8Xrd
         B9wmNND9nqSbjNORKvo6zWkKt6C4GMwE+CHOWy2BtIWE5teNSHCDRx8Ov8SxY6rqlxgj
         mORdCgh6shNh89DIurLGPWj1fzHZb5+uAH1YUUgVwGiqrqnTdqhgfpkgp1deCWhDIaqt
         g++yKp6x3Mm/d4QyOA+nIeTQufTadLVRYYRn7wcg/Nb2oqGhgtIhIzqbV+03UZy9Zb5Y
         kBtg==
X-Gm-Message-State: AOAM530fubN1XIDCP3sNxs3/2hCBiJWY4BG9+VT6iostBl7vO/4zRlUP
        ZzTMc9DIZdlac5iUGEPMrHqJR2Kf/JCjhT0cDZU=
X-Google-Smtp-Source: ABdhPJzQYydYHuL/8miRQc2QEYeHPaCHZx0iwcPD4xPSGr/YYmKlgcmWeAPgSiuboZD2dRyt3UqfW2rJzZGskF8ybrM=
X-Received: by 2002:a92:9a55:: with SMTP id t82mr1630056ili.24.1601544451890;
 Thu, 01 Oct 2020 02:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201001071824.24995-1-colyli@suse.de> <CAAMcf8Ao8Go7GdB2XFXAHsWrcxb0VqtDRpHReOGTsjegq2XP0Q@mail.gmail.com>
 <ebd42dfe-d39c-5c13-bbd9-1c6463d73ff0@intel.com>
In-Reply-To: <ebd42dfe-d39c-5c13-bbd9-1c6463d73ff0@intel.com>
From:   Vicente Bergas <vicencb@gmail.com>
Date:   Thu, 1 Oct 2020 11:27:20 +0200
Message-ID: <CAAMcf8AXUx8UwJvGyBaSvuMaN8u0i1CTbz=WvC+snvLBe=mtLQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: core: don't set limits.discard_granularity as 0
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Coly Li <colyli@suse.de>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 1, 2020 at 11:07 AM Adrian Hunter <adrian.hunter@intel.com> wro=
te:
>
> On 1/10/20 11:38 am, Vicente Bergas wrote:
> > On Thu, Oct 1, 2020 at 9:18 AM Coly Li <colyli@suse.de> wrote:
> >>
> >> In mmc_queue_setup_discard() the mmc driver queue's discard_granularit=
y
> >> might be set as 0 (when card->pref_erase > max_discard) while the mmc
> >> device still declares to support discard operation. This is buggy and
> >> triggered the following kernel warning message,
> >>
> >> WARNING: CPU: 0 PID: 135 at __blkdev_issue_discard+0x200/0x294
> >> CPU: 0 PID: 135 Comm: f2fs_discard-17 Not tainted 5.9.0-rc6 #1
> >> Hardware name: Google Kevin (DT)
> >> pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=3D--)
> >> pc : __blkdev_issue_discard+0x200/0x294
> >> lr : __blkdev_issue_discard+0x54/0x294
> >> sp : ffff800011dd3b10
> >> x29: ffff800011dd3b10 x28: 0000000000000000 x27: ffff800011dd3cc4 x26:=
 ffff800011dd3e18 x25: 000000000004e69b x24: 0000000000000c40 x23: ffff0000=
f1deaaf0 x22: ffff0000f2849200 x21: 00000000002734d8 x20: 0000000000000008 =
x19: 0000000000000000 x18: 0000000000000000 x17: 0000000000000000 x16: 0000=
000000000000 x15: 0000000000000000 x14: 0000000000000394 x13: 0000000000000=
000 x12: 0000000000000000 x11: 0000000000000000 x10: 00000000000008b0 x9 : =
ffff800011dd3cb0 x8 : 000000000004e69b x7 : 0000000000000000 x6 : ffff0000f=
1926400 x5 : ffff0000f1940800 x4 : 0000000000000000 x3 : 0000000000000c40 x=
2 : 0000000000000008 x1 : 00000000002734d8 x0 : 0000000000000000 Call trace=
:
> >> __blkdev_issue_discard+0x200/0x294
> >> __submit_discard_cmd+0x128/0x374
> >> __issue_discard_cmd_orderly+0x188/0x244
> >> __issue_discard_cmd+0x2e8/0x33c
> >> issue_discard_thread+0xe8/0x2f0
> >> kthread+0x11c/0x120
> >> ret_from_fork+0x10/0x1c
> >> ---[ end trace e4c8023d33dfe77a ]---
> >>
> >> This patch fixes the issue by setting discard_granularity as SECTOR_SI=
ZE
> >> instead of 0 when (card->pref_erase > max_discard) is true. Now no mor=
e
> >> complain from __blkdev_issue_discard() for the improper value of disca=
rd
> >> granularity.
> >>
> >> This issue is exposed after commit b35fd7422c2f ("block: check queue's
> >> limits.discard_granularity in __blkdev_issue_discard()"), a "Fixes:" t=
ag
> >> is also added for the commit to make sure people won't miss this patch
> >> after applying the change of __blkdev_issue_discard().
> >>
> >> Fixes: e056a1b5b67b ("mmc: queue: let host controllers specify maximum=
 discard timeout")
> >> Fixes: b35fd7422c2f ("block: check queue's limits.discard_granularity =
in __blkdev_issue_discard()").
> >> Reported-by: Vicente Bergas <vicencb@gmail.com>
> >
> > Hi Coly, Adrian,
> > would you like me to reply with a tested-by?
> > before testing it: what are the chances of losing data?
>
> Very low I would hope, but that is no reason not to have backups :-)

I do have backup, it is for the hassle of reinstalling the OS and
restoring the backup.
I'll test it later, maybe today.

> > Regards,
> >   Vicente.
> >
> >> Signed-off-by: Coly Li <colyli@suse.de>
> >> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >> ---
> >> Changelog,
> >> v3, add Fixes tag for both commits.
> >> v2, change commit id of the Fixes tag.
> >> v1, initial version.
> >>
> >>  drivers/mmc/core/queue.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> >> index 6c022ef0f84d..350d0cc4ee62 100644
> >> --- a/drivers/mmc/core/queue.c
> >> +++ b/drivers/mmc/core/queue.c
> >> @@ -190,7 +190,7 @@ static void mmc_queue_setup_discard(struct request=
_queue *q,
> >>         q->limits.discard_granularity =3D card->pref_erase << 9;
> >>         /* granularity must not be greater than max. discard */

Just out of curiosity, wouldn't it be more performant something like:
q->limits.discard_granularity =3D minimum(card->pref_erase, max_discard) <<=
 9;
or is just that SECTOR_SIZE is a number guaranteed to work?

> >>         if (card->pref_erase > max_discard)
> >> -               q->limits.discard_granularity =3D 0;
> >> +               q->limits.discard_granularity =3D SECTOR_SIZE;
> >>         if (mmc_can_secure_erase_trim(card))
> >>                 blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
> >>  }
> >> --
> >> 2.26.2
> >>
>
