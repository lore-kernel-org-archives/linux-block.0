Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CB1C77B7E
	for <linux-block@archiver.kernel.org>; Mon, 29 May 2023 07:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjE2HP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 May 2023 03:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjE2HPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 May 2023 03:15:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17329A3
        for <linux-block@vger.kernel.org>; Mon, 29 May 2023 00:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685344476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hdVrizk3grCDqPvx/q6JCYdFLMn2CU0q7rUsrbwKmE=;
        b=g7dgUz8iUykLCe4hDRjfz4je27GQMj0fAm2Oafrt+eG86OKn6u4iiDMgbdFYON9yEeOlXq
        jwT2FpE/AbIgxyOgVCBFQXhNF6nHwZ8kUvxiqEJ9NEZRMUg/Wxs52oA21SnCfmzwMU/SfQ
        49+KIE0mBJHVM/HyzFd86qTQTUzQr4I=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-wfZmg7-OP7Oa-O8GqNGZBA-1; Mon, 29 May 2023 03:14:34 -0400
X-MC-Unique: wfZmg7-OP7Oa-O8GqNGZBA-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4394210b72cso28133137.0
        for <linux-block@vger.kernel.org>; Mon, 29 May 2023 00:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685344474; x=1687936474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hdVrizk3grCDqPvx/q6JCYdFLMn2CU0q7rUsrbwKmE=;
        b=ET8ttFLoLNoCs6X4vF5c0dAN1+NJErkE3Vv5BSSbR+Mkm0IUD5Eehj34lpgnJwIK0G
         vzUZ/9mAK5oGgv+7paFj18/lz2XMaz/1TEwUKgh8gDoyVcx4ryLyku7GM6kE7tncb0pL
         PrDcaCMQGSOvRqD2vQqJ93mOISbf3qXXqgtD5OuJYv9oKDaTH7x20d4YqH8GjEbWc4g/
         xP0LbWsktkTehJ2gWCuPUZU/y3r6kMlYluXAsWpwctAXBGpsheAqRRLW2ldRxkuML7nf
         vqK3dER3wCZ9+p4gfGpG9dqB9MYZfDZYqlb/uDhpzscK5iIoAcErH0PyQyAViWeN3jp6
         j2rw==
X-Gm-Message-State: AC+VfDxXrHW4cLdDIR2mjFAget2SE5zJlSiR/o7GFIbbaz+CrF145n+Z
        TwfGaGbCIrf/r6kcti8WCQ0PjsiWQv/ODLAjGRAgNrJnruufYAqcQ5tkbbqh2vHmBTEAPkSC+XK
        ZnbafQwlCWpi3scfEDItLkhT4n8z+ypBzQLDVA7a5uOjgwMYUTw==
X-Received: by 2002:a05:6102:fa4:b0:439:363d:3b9e with SMTP id e36-20020a0561020fa400b00439363d3b9emr2454527vsv.0.1685344474045;
        Mon, 29 May 2023 00:14:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bQulRuCF3T/oz4um7M2kkAf6Z6QUQapLJosStyLoBhQJXVy5RQy/BXPALq29HrbUg02FJXDa+tZTTGERTutM=
X-Received: by 2002:a05:6102:fa4:b0:439:363d:3b9e with SMTP id
 e36-20020a0561020fa400b00439363d3b9emr2454519vsv.0.1685344473740; Mon, 29 May
 2023 00:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230529023836.1209558-1-dlemoal@kernel.org>
In-Reply-To: <20230529023836.1209558-1-dlemoal@kernel.org>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Mon, 29 May 2023 15:14:22 +0800
Message-ID: <CAFj5m9KePwf7jJhr1p3tacDsTaQ4mJMGixTrrAhj5axs7KhCWw@mail.gmail.com>
Subject: Re: [PATCH] block: fix revalidate performance regression
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Brian Bunker <brian@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 29, 2023 at 10:40=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org=
> wrote:
>
> The scsi driver function sd_read_block_characteristics() always calls
> disk_set_zoned() to a disk zoned model correctly, in case the device
> model changed. This is done even for regular disks to set the zoned
> model to BLK_ZONED_NONE and free any zone related resources if the drive
> previously was zoned.
>
> This behavior significantly impact the time it takes to revalidate disks
> on a large system as the call to disk_clear_zone_settings() done from
> disk_set_zoned() for the BLK_ZONED_NONE case results in the device
> request queued to be quiesced, even if there is no zone resource to

s/quiesced/frozen

> free.
>
> Avoid this overhead for non zoned devices by not calling
> disk_clear_zone_settings() in disk_set_zoned() if the device model
> already was set to BLK_ZONED_NONE.
>
> Reported by: Brian Bunker <brian@purestorage.com>
> Fixes: 508aebb80527 ("block: introduce blk_queue_clear_zone_settings()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

