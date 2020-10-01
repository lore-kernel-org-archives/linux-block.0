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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9CEC4741F
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 18:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA5F20878
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 18:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdfnfK1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbgJASrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 14:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgJASrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 14:47:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598C2C0613D0;
        Thu,  1 Oct 2020 11:47:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so6984233wrn.10;
        Thu, 01 Oct 2020 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=vBNgwRRGY9uJ0bKBJoC+SDh8VJ4r0cHyoogyU7fjpEw=;
        b=SdfnfK1sKJ6zVq5lKGc7v/4rZTE3i1lmAA+PEUtKT227TeflVetUV5WVidsTWk+Waw
         Hes/VktNGqMYuK2tIQ0EpwUe71jKQkK+dRBfKnwRfXCm7UtyeCGJKARUdn0wTNs3atyN
         gS4PIMmNbH+tEPvxQ4038A6IjSR9xefoQRO+mphaJQLwV8DsTCzBXmqWEM+fTnSy2EGr
         NTEqVLYuTHABkwLP2J87PcDxPEZY8suVksOan3BQGR6S2EzeYOVupLwdEix926QpvKEm
         IB9OlN8n2b/eCmjIW8xcDZ8m7YH1QaHAcdr1zoZPLBL3Vmo3okAPTH4cUkRXcnaKpXC2
         vnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=vBNgwRRGY9uJ0bKBJoC+SDh8VJ4r0cHyoogyU7fjpEw=;
        b=kHZwMwCjQIKwaFqwOqKdvAWd6LmM121eBGTOSZEyf38K4mjnazS0tVv0P0IPseTLfC
         zeCI+A5CB8LeQb7X3GVaH6xaQy9Kj2sY956UdTHyr00GISIP25E8CKtGw9H6rqF8dy9t
         BxN6QaekGR8v8qWhU1DcFwUmSm1uafgak2MPJiFMuy45J6+LlFGYO4y0qDYYHP283WQ3
         tvyobRglpTcS0wL1bX0vqvWm5NBfIMYE48IHbJkMe7XY+jTaICgeZGdAH1OaVQqHqM/q
         X79HTbRmm/NT6//4MnPcWFvg/S9hc/+udhsTCqaiQ8V5bbTfdOxi8wnfxX9cwOfq8/G+
         BRyA==
X-Gm-Message-State: AOAM531JEK/vmH+CpDGP/JDM6Qfdq3We5ZVYfJXEU3YVkY94tyuTXX8p
        9+oA15r4cpcNHTCTRkpkWo4=
X-Google-Smtp-Source: ABdhPJwt8erLW4gJgt3o1NQloFrwHdbIbRYWGbJQrfRxoXfCwVKso78iB9sGKxDE2dHilUdtwwLNCg==
X-Received: by 2002:adf:eb04:: with SMTP id s4mr11313112wrn.81.1601578052037;
        Thu, 01 Oct 2020 11:47:32 -0700 (PDT)
Received: from localhost ([170.253.46.69])
        by smtp.gmail.com with ESMTPSA id 70sm1320001wmb.41.2020.10.01.11.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 11:47:31 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Coly Li <colyli@suse.de>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: core: don't set =?iso-8859-1?Q?limits.discard=5Fgranularity_as_0?=
Date:   Thu, 01 Oct 2020 20:47:29 +0200
MIME-Version: 1.0
Message-ID: <b3cdb5fe-40df-41df-ae10-0b7be4dcd7a6@gmail.com>
In-Reply-To: <20201001071824.24995-1-colyli@suse.de>
References: <20201001071824.24995-1-colyli@suse.de>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thursday, October 1, 2020 9:18:24 AM CEST, Coly Li wrote:
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
> x29: ffff800011dd3b10 x28: 0000000000000000 x27:=20
> ffff800011dd3cc4 x26: ffff800011dd3e18 x25: 000000000004e69b=20
> x24: 0000000000000c40 x23: ffff0000f1deaaf0 x22:=20
> ffff0000f2849200 x21: 00000000002734d8 x20: 0000000000000008=20
> x19: 0000000000000000 x18: 0000000000000000 x17:=20
> 0000000000000000 x16: 0000000000000000 x15: 0000000000000000=20
> x14: 0000000000000394 x13: 0000000000000000 x12:=20
> 0000000000000000 x11: 0000000000000000 x10: 00000000000008b0 x9=20
> : ffff800011dd3cb0 x8 : 000000000004e69b x7 : 0000000000000000=20
> x6 : ffff0000f1926400 x5 : ffff0000f1940800 x4 :=20
> 0000000000000000 x3 : 0000000000000c40 x2 : 0000000000000008 x1=20
> : 00000000002734d8 x0 : 0000000000000000 Call trace:
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
> Fixes: e056a1b5b67b ("mmc: queue: let host controllers specify=20
> maximum discard timeout")
> Fixes: b35fd7422c2f ("block: check queue's=20
> limits.discard_granularity in __blkdev_issue_discard()").
> Reported-by: Vicente Bergas <vicencb@gmail.com>
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
> @@ -190,7 +190,7 @@ static void mmc_queue_setup_discard(struct=20
> request_queue *q,
>  =09q->limits.discard_granularity =3D card->pref_erase << 9;
>  =09/* granularity must not be greater than max. discard */
>  =09if (card->pref_erase > max_discard)
> -=09=09q->limits.discard_granularity =3D 0;
> +=09=09q->limits.discard_granularity =3D SECTOR_SIZE;
>  =09if (mmc_can_secure_erase_trim(card))
>  =09=09blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
>  }

Tested on rk3399-gru-kevin with f2fs filesystem over the mmc driver, that
is, the same setup that reproduced the issue.
The kernel warning message is no longer reported.
So,
Tested-by: Vicente Bergas <vicencb@gmail.com>

