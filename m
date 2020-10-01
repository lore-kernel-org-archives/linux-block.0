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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC847C4727C
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 08:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58268208B6
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 08:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxT+icRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgJAIia (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJAIia (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 04:38:30 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D37C0613D0;
        Thu,  1 Oct 2020 01:38:30 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t12so5314816ilh.3;
        Thu, 01 Oct 2020 01:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ON+opjPHh020IQmczBcWo4ofg8g1dUfmPb5G/fCa/xM=;
        b=UxT+icRRDjkJqTwowa+yksEbAFoaVgOcdX5i9ootPoFm8eByk2RqgID5LGYe4eDu+T
         9LXj64mErLGO7AOnF1xcqEEZm1MnXZQ7jGrb+YFY91tXtjJT701jIWv6k6KNW9DEdScX
         c///UmuzY8emR42MbtkBvPP3MJeRHqTGtrRfdTKeiiMzM0MoAwuby/T+l3OU9w9WmBZR
         P/DilkKhwM73elyF+ptm4Ua8L7M951+8F/WI0FUJOy7ELDrUiYyZyZVSfWwreuvDmxJQ
         D0zdRWhhUQ3iQc17bzKO8U3RqgRinzFx/PEsDFJnCphHTBxu3MrcRtfI481Fhx//8CkD
         dzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ON+opjPHh020IQmczBcWo4ofg8g1dUfmPb5G/fCa/xM=;
        b=iLvfe4mVySTqnlPMMB3G+eO04KyRia4Xc3baLh8QnPTQ0uEuP0M6IBypIBwsX6qFQB
         QnHtNCOfaijLzwmpx4P0qcezP7kXryQFzTPm2SOgJvC8PnCpsqddV8TA0JheSJHSptoN
         zAZ4cKcZBVh1Uml82LMuVWyUyAetII3+ekWUXLYENpXwBfTlDBjCqnt1lRp3KFuTPXwg
         Z2QI5NPQINsEuiFRfeMqfufr+r9UGXOp5sHkDKM+2FHaQcHCEJchDItNudSUp+pqsE9G
         QLA98JBpfacLsr6HgK/ZyYY/XPF8POHCvP8OdH0tDvHUASqnK+TfHEUrDue2KHh2qhGu
         RPYw==
X-Gm-Message-State: AOAM533DmECNP/IxqCrfv9c6HfoklgcS6D/NbsNb/wCmf0Tn/Ua6uZjA
        fSC4jY2ii40T6DnjAP6JmieT5/F4IJqFSmDkLAQ=
X-Google-Smtp-Source: ABdhPJyP/Kis1ixw1glVmQd3wC94hDNv72egaBNUhNfr283RbQ5OTHGCLB7GaqHRRwlQ/aIs0deVlk+1bfQeLif2hJs=
X-Received: by 2002:a92:aa8f:: with SMTP id p15mr1639564ill.100.1601541509515;
 Thu, 01 Oct 2020 01:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201001071824.24995-1-colyli@suse.de>
In-Reply-To: <20201001071824.24995-1-colyli@suse.de>
From:   Vicente Bergas <vicencb@gmail.com>
Date:   Thu, 1 Oct 2020 10:38:18 +0200
Message-ID: <CAAMcf8Ao8Go7GdB2XFXAHsWrcxb0VqtDRpHReOGTsjegq2XP0Q@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: core: don't set limits.discard_granularity as 0
To:     Coly Li <colyli@suse.de>, Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 1, 2020 at 9:18 AM Coly Li <colyli@suse.de> wrote:
>
> In mmc_queue_setup_discard() the mmc driver queue's discard_granularity
> might be set as 0 (when card->pref_erase > max_discard) while the mmc
> device still declares to support discard operation. This is buggy and
> triggered the following kernel warning message,
>
> WARNING: CPU: 0 PID: 135 at __blkdev_issue_discard+0x200/0x294
> CPU: 0 PID: 135 Comm: f2fs_discard-17 Not tainted 5.9.0-rc6 #1
> Hardware name: Google Kevin (DT)
> pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=3D--)
> pc : __blkdev_issue_discard+0x200/0x294
> lr : __blkdev_issue_discard+0x54/0x294
> sp : ffff800011dd3b10
> x29: ffff800011dd3b10 x28: 0000000000000000 x27: ffff800011dd3cc4 x26: ff=
ff800011dd3e18 x25: 000000000004e69b x24: 0000000000000c40 x23: ffff0000f1d=
eaaf0 x22: ffff0000f2849200 x21: 00000000002734d8 x20: 0000000000000008 x19=
: 0000000000000000 x18: 0000000000000000 x17: 0000000000000000 x16: 0000000=
000000000 x15: 0000000000000000 x14: 0000000000000394 x13: 0000000000000000=
 x12: 0000000000000000 x11: 0000000000000000 x10: 00000000000008b0 x9 : fff=
f800011dd3cb0 x8 : 000000000004e69b x7 : 0000000000000000 x6 : ffff0000f192=
6400 x5 : ffff0000f1940800 x4 : 0000000000000000 x3 : 0000000000000c40 x2 :=
 0000000000000008 x1 : 00000000002734d8 x0 : 0000000000000000 Call trace:
> __blkdev_issue_discard+0x200/0x294
> __submit_discard_cmd+0x128/0x374
> __issue_discard_cmd_orderly+0x188/0x244
> __issue_discard_cmd+0x2e8/0x33c
> issue_discard_thread+0xe8/0x2f0
> kthread+0x11c/0x120
> ret_from_fork+0x10/0x1c
> ---[ end trace e4c8023d33dfe77a ]---
>
> This patch fixes the issue by setting discard_granularity as SECTOR_SIZE
> instead of 0 when (card->pref_erase > max_discard) is true. Now no more
> complain from __blkdev_issue_discard() for the improper value of discard
> granularity.
>
> This issue is exposed after commit b35fd7422c2f ("block: check queue's
> limits.discard_granularity in __blkdev_issue_discard()"), a "Fixes:" tag
> is also added for the commit to make sure people won't miss this patch
> after applying the change of __blkdev_issue_discard().
>
> Fixes: e056a1b5b67b ("mmc: queue: let host controllers specify maximum di=
scard timeout")
> Fixes: b35fd7422c2f ("block: check queue's limits.discard_granularity in =
__blkdev_issue_discard()").
> Reported-by: Vicente Bergas <vicencb@gmail.com>

Hi Coly, Adrian,
would you like me to reply with a tested-by?
before testing it: what are the chances of losing data?
Regards,
  Vicente.

> Signed-off-by: Coly Li <colyli@suse.de>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> Changelog,
> v3, add Fixes tag for both commits.
> v2, change commit id of the Fixes tag.
> v1, initial version.
>
>  drivers/mmc/core/queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 6c022ef0f84d..350d0cc4ee62 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -190,7 +190,7 @@ static void mmc_queue_setup_discard(struct request_qu=
eue *q,
>         q->limits.discard_granularity =3D card->pref_erase << 9;
>         /* granularity must not be greater than max. discard */
>         if (card->pref_erase > max_discard)
> -               q->limits.discard_granularity =3D 0;
> +               q->limits.discard_granularity =3D SECTOR_SIZE;
>         if (mmc_can_secure_erase_trim(card))
>                 blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
>  }
> --
> 2.26.2
>
