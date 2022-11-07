Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871B9C4332F
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 07:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiKGHpq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 02:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGHpo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 02:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E2A13DF1
        for <linux-block@vger.kernel.org>; Sun,  6 Nov 2022 23:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667807089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y7z2W2hOxemz6tv67+J3i16DweKsS7PYaPjormYEZtI=;
        b=Iek/KzOm2J73QybFzp5A+L2iWxWBjp2WXKoPDaaLNgq+N12aBMniEGJVmp+lnwadQ0jdrx
        8tERIGfc1oWzKh9Wei61CpARNySIbq1b9XWTR+qFX5N/e6TLJhvgN4TTD0sXPLivHcwSIH
        aumi2rfkX6IlRZvFDTxjFS0dTCclSoM=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-yUa_iMCnN-KJ_vjbN2eI6Q-1; Mon, 07 Nov 2022 02:44:47 -0500
X-MC-Unique: yUa_iMCnN-KJ_vjbN2eI6Q-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-13bb98bb80fso5294237fac.23
        for <linux-block@vger.kernel.org>; Sun, 06 Nov 2022 23:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7z2W2hOxemz6tv67+J3i16DweKsS7PYaPjormYEZtI=;
        b=NzHim/IUlIQqNH/M/xiCRrJnHhzt97pzX4dwoeDD711Xlf5ckxDzawf7z59KATu+YR
         M1j3qYcP3TOBu8owdvm2kn2HAU1ClrMz1A0k+S0MNWHvkq3gCovyrz876Os1BgfT74Ie
         qVsAdH1Dkj1d+dZv6v6Bi7jbDg9bD3DG9qpUeZm25EuFz/vXw+v3wQhGZTYLPpGUJKCr
         lokFmNPvOvir2ePLXTJEGtaC4WkOXB5vp5zu5gBqiiHaO46prnW3PYIti95HBxShdZex
         1bUxv5cE+7qY0NYlTjSSrQ9F2Xn+TN/LOj6YJ7R3EwoRzgbr3WVjBcMKU/xWhM3xaeh1
         ZufA==
X-Gm-Message-State: ACrzQf08DZR9wKwZ2ZmYW+x6so4ykylpDoG6n91Afbtqz368XkBnDPu3
        bfOGfGswvNpAjn2NS5oNr8Jh6kGPvJqAOH/N88RkrpOWFnQ1cdBU53UpUV6qGp6NIX/eYKyCKU1
        LTQvUx3Bic+H9vC0h/hpSlTrfdicH4yC2Z4DPgZM=
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id t14-20020a056871054e00b0013b29b7e2e8mr37655789oal.35.1667807087057;
        Sun, 06 Nov 2022 23:44:47 -0800 (PST)
X-Google-Smtp-Source: AMsMyM43CuZtbbZUUL09mIBdM0KXhoZTHYA7ejIPeVZeiGHn6tLwkEXQi3wb+5rVf+Ne1rZHUmGFX/lGOM+1MoRzqcc=
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr37655777oal.35.1667807086875; Sun, 06
 Nov 2022 23:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20221021204126.927603-1-rafaelmendsr@gmail.com>
In-Reply-To: <20221021204126.927603-1-rafaelmendsr@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 7 Nov 2022 15:44:35 +0800
Message-ID: <CACGkMEtPGK1rkpbtDNQYKNZTMpgx+iPSMyK_aBQ_e=7356mLTA@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: Fix signedness bug in virtblk_prep_rq()
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 22, 2022 at 4:42 AM Rafael Mendonca <rafaelmendsr@gmail.com> wrote:
>
> The virtblk_map_data() function returns negative error codes, however, the
> 'nents' field of vbr->sg_table is an unsigned int, which causes the error
> handling not to work correctly.
>
> Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Do we need to cc the stable?

Thanks

> ---
>  drivers/block/virtio_blk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 19da5defd734..291f705e61a8 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -321,16 +321,18 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
>                                         struct virtblk_req *vbr)
>  {
>         blk_status_t status;
> +       int num;
>
>         status = virtblk_setup_cmd(vblk->vdev, req, vbr);
>         if (unlikely(status))
>                 return status;
>
> -       vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
> -       if (unlikely(vbr->sg_table.nents < 0)) {
> +       num = virtblk_map_data(hctx, req, vbr);
> +       if (unlikely(num < 0)) {
>                 virtblk_cleanup_cmd(req);
>                 return BLK_STS_RESOURCE;
>         }
> +       vbr->sg_table.nents = num;
>
>         blk_mq_start_request(req);
>
> --
> 2.34.1
>

