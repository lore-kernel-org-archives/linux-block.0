Return-Path: <SRS0=r/dS=67=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A42CC433E2
	for <linux-block@archiver.kernel.org>; Sun, 17 May 2020 04:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E0D206D4
	for <linux-block@archiver.kernel.org>; Sun, 17 May 2020 04:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftTPMc3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgEQEIx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 00:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgEQEIw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 00:08:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841FBC05BD09
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 21:08:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 50so7808081wrc.11
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 21:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hPLrut3n9KdZVQDJD+Jk+dBPR+HabU1MDbSmq3XDgwg=;
        b=ftTPMc3EnA50L5wNa2yS5L5JRacyabvdxxCiUTq7vYK8cf1B4tge3e0YxQkghr2yH1
         v6bJgqB9D4gcY4TICXAfUW1+iRFDzhmPOXUkYWi7HqRXVivqD619Rud7vkPs8Bpx4tbi
         wnCmBVEc1b/mEfmOoEV2xP11DXDf0a8I7d9oEoQMcu2+yczniULalPYVPxfvR8tw2B8t
         LlLRvYdE2kMsNCfzolIRkg5SWPnJ1VvgYAcmavi7J1WYNIZmGcYhmNgThtoVre2oM4OQ
         0VIkL9fy9aOwaXAIrmvuBOKTXi+u0TQBM7vC8wCz993bOawLmWbjcADSrvNiDmFkv2Za
         Fi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hPLrut3n9KdZVQDJD+Jk+dBPR+HabU1MDbSmq3XDgwg=;
        b=lPp2XUQ3jlUz7U2v5UzZhnoOglh9M+7MkAeruQIsHmkn49g9OKysIFlHtYP2NwintZ
         v4Km6Xw2fi9wFVGTqStGWFh8EP6s7qoZKNRaB49Bcej/plDtHXurm4Au1RLZkqNhpC51
         EG1wNxWd0XNbvV0jePmys90obnsobk9o7xs9fyCfav8ybJU05aVnyETWWC2WDDxdYjTU
         y5Y/d9Hu/2Nf1C5U5I3G41tFOsLgtiKaDRR3/zje+AWL9YSKyidWyjoDTwzEQSbtNvil
         M5gy0MsJX9LEmHUbFi5zlYNpTVr7etax55ZgnYWEsmnXanAyct7woSKbrnJEq5TY0t76
         RLtA==
X-Gm-Message-State: AOAM532Yxuri9WuSQbq7V52MyN70yurLDIn4NhhFUcJyGHFzEZDSFVyu
        LcJ5b+oG32N390RvE319Ujrnb2G4+X9YXANkr0yj1XsGzQ0=
X-Google-Smtp-Source: ABdhPJxy2wvaDmpUSRYKKikPSe+YYeIdvhSSovNFG3PnL98H+rIELfG0ICYV7pOh63oDFHrowKDuxk3/fzO8w28erj8=
X-Received: by 2002:adf:e9d0:: with SMTP id l16mr12016238wrn.69.1589688531346;
 Sat, 16 May 2020 21:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200515014153.2403464-1-ming.lei@redhat.com> <20200516123555.GA13448@lst.de>
In-Reply-To: <20200516123555.GA13448@lst.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sun, 17 May 2020 12:08:40 +0800
Message-ID: <CACVXFVNou_dMjzxYs-4KvbKmBnrqaBk2sG2pqWuJeLeh_tZoug@mail.gmail.com>
Subject: Re: [PATCH 0/6] blk-mq: improvement CPU hotplug(simplified version)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 16, 2020 at 8:37 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I took at stab at the series this morning, and fixed the fabrics
> crash (blk_mq_alloc_request_hctx passed the cpumask of a NULL hctx),
> and pre-loaded a bunch of c=C4=BCeanups to let your changes fit in better=
.
>
> Let me know what you think, the git branch is here:
>
>     git://git.infradead.org/users/hch/block.git blk-mq-hotplug
>
> Gitweb:
>
>     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-=
mq-hotplug
>

I think the approach is fine, especially the driver tag related
change, that was in my mind too, :-)

I guess you will post them all soon, and I will take a close look
after they are out.

Thanks,
Ming Lei
