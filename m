Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD5EC433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 01:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE96C2073A
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 01:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vAqLc3ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgIABSr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 21:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgIABSU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 21:18:20 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917A7C061757
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 18:18:20 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 189so5160794ybw.3
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 18:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0wYlSA3cHYki5gsFVqLhdp+ENDbt9ydt7+x6+7SREo=;
        b=vAqLc3ye4tAkbUzBez7KtaXrNbXiwqBmECZ4PJ+/dVfdRvUS44WTDu0vViDCXJQMJ8
         rPavriCm17xr7fk1sCcjhVRpJJmb0Ht/BA/rSbXz+tT7Xl5unZ1hnBdcIdTErvrslifo
         9KQjqVEGcSo7auZRBA5vnPtm01fK7gedjK8MqWXos4/X2DuNNIXyXb/OSa+LXVq75n5d
         zA00i95UPq9yiynbubsrg1tIhYawlOFUt2yeHVkuiRq2gTSVhsMW74IPAuJtfyKu2cau
         PoaO7DX/Wo031iySoXHK1MNjfBHNPZCTy/TD88ev4gziJyCNQ+YkbzgeT5Lk2YAIkSsq
         kDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0wYlSA3cHYki5gsFVqLhdp+ENDbt9ydt7+x6+7SREo=;
        b=c0hzgRKL/iuNX4pdusCMPvDO1F+c5YgtcSO54bBijByu+gjivDoKaQdbPxotdYv8bM
         FdhtU/QTMbLAvNpgKXepG5A2Qs/O2W3wrK3XO+edaR/ZHDhcHUfU75/wwt3EjTURUaci
         m5LEMobG4R5zfb6hkYsGS+PcFRmZWLVgvVtIUdNHKOSzchD7M7vM9xb8whmaFk24Lsm1
         Ckl7z8uR3s9x4rE3vTa0lzIXPyTe5vw3PyOjDx9zB+84pgxfVYRU+06EjjIQBRPueQwv
         L1fOLxXeTsHn7kT6789I0j/cHhFrLSlVlxkpVUq0eDKdI3sklz5lAXhVFm+ASKRioNGp
         T/Dg==
X-Gm-Message-State: AOAM5312TmoBCY9NSR7YSF80I9TdZss2Gk1fi8fz75cCRyd8uHtzDzqc
        o0WkVGO7tKJ9q9k1DnLK1gD54PZFpmxX57RqMsg=
X-Google-Smtp-Source: ABdhPJw00+nKKkmV/chpzy6SM3TNtYj8HXqiOEwYMa+ylxmCe/YVQihaQsqy8RHMySKQicAeTddxCWv6DnTLJUgM9Yc=
X-Received: by 2002:a5b:38a:: with SMTP id k10mr6737571ybp.428.1598923099693;
 Mon, 31 Aug 2020 18:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200831153127.3561733-1-krisman@collabora.com>
In-Reply-To: <20200831153127.3561733-1-krisman@collabora.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 1 Sep 2020 09:18:08 +0800
Message-ID: <CACVXFVM21GWTrWs=6w3OXm7vQ-gmR_3PGss+9TE=swVN-Uzn7Q@mail.gmail.com>
Subject: Re: [PATCH] block: Fix inflight statistic for MQ submission with !elevator
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 31, 2020 at 11:37 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> According to Documentation/block/stat.rst, inflight should not include
> I/O requests that are in the queue but not yet dispatched to the device,
> but blk-mq identifies as inflight any request that has a tag allocated,
> which, for queues without elevator, happens at request allocation time
> and before it is queued in the ctx (default case in blk_mq_submit_bio).
>
> A more precise approach would be to only consider requests with state
> MQ_RQ_IN_FLIGHT.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0015a1892153..997b3327eaa8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -105,7 +105,7 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>  {
>         struct mq_inflight *mi = priv;
>
> -       if (rq->part == mi->part)
> +       if (rq->part == mi->part && rq->state == MQ_RQ_IN_FLIGHT)
>                 mi->inflight[rq_data_dir(rq)]++;

The fix looks fine. However, we have helper of
blk_mq_request_started() for this purpose.


Thanks,
Ming Lei
