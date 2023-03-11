Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A3AC6FD1C
	for <linux-block@archiver.kernel.org>; Sat, 11 Mar 2023 12:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCKMX6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Mar 2023 07:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCKMX5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Mar 2023 07:23:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0EF1287C
        for <linux-block@vger.kernel.org>; Sat, 11 Mar 2023 04:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678537389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0ncK7kQPU4tM41Xw7Dto2fGmFTmgA/05JfWF548UL4=;
        b=NPlsiPloiG+YmxFk0KemWKo0rdhPCzqj2Sb2ZH1qHjjdGKE/n9OihGGWjb2iQh5Oe4kmU7
        XT/ue6OzFBDjxtKlsSpiWzn1siJQEK1Qj70yuE9q28sT0fOf1sAZs8W8auXie3++dKbs1I
        Lw/s6WSaoXJijgtucNVj0t54mFegoiw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-0LTSoWwUNiOdU-ta7h0wYA-1; Sat, 11 Mar 2023 07:23:08 -0500
X-MC-Unique: 0LTSoWwUNiOdU-ta7h0wYA-1
Received: by mail-qv1-f70.google.com with SMTP id s13-20020ad44b2d000000b00570ccb820abso4375923qvw.5
        for <linux-block@vger.kernel.org>; Sat, 11 Mar 2023 04:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678537387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0ncK7kQPU4tM41Xw7Dto2fGmFTmgA/05JfWF548UL4=;
        b=7py2GBtAmWrBIdJY8jP3IlZuRwyYVw/L3WUcQroq6t1QsXzUE72Jb3EO6lqE0ynBRM
         MRcVwQG4FsYxCXTrKhefniok9N1tTtmSn6jlskg6+oo90m8qNyOkmFnXsjPGqju2ijl7
         DE7f/9hF/rjoNKn6ITbKeNR6EWveBFCZ2tLicNiLJcDyqNRmuAgvXNSskTsEpBtnyaAo
         pK5NxWKmLyDiTUW6T7DTgUz6vVmQSCI7dQ5BwN+AwHij9VLTL56kQQIgQHk6TYiBzf9d
         tSEx5+aSBrXFhTauREGio9gTwOCeIS3Sp4K4mnytZwPHDt1hj6hQ3bFAc+xv65xcVazY
         6IQw==
X-Gm-Message-State: AO0yUKVVgASbR8WI7q7VwCRsHjfD93GEHGchrqMSyhb2KR5YU8vPX2fC
        rObV+59rGHBl+VFO7QTn1Z2grYe1WNHd14oksGDgi+3/yR/lq4l4gw1h0trG+jnJHmJ5L+bqpzX
        qWsI1jG25myGGn8nJYz2n28A8/+RdM90Zxd9iR5kKKTRruh5LlA==
X-Received: by 2002:ae9:f00a:0:b0:742:6e03:4091 with SMTP id l10-20020ae9f00a000000b007426e034091mr1365177qkg.6.1678537387415;
        Sat, 11 Mar 2023 04:23:07 -0800 (PST)
X-Google-Smtp-Source: AK7set+ahdPUjKtqLXS4t/tIFiVrX+FhWFPj4c7AdJccBkphBZCKDMNyJB/8I64SarjmIvrKHtooaHXg7cKfznTu95I=
X-Received: by 2002:ae9:f00a:0:b0:742:6e03:4091 with SMTP id
 l10-20020ae9f00a000000b007426e034091mr1365155qkg.6.1678537387081; Sat, 11 Mar
 2023 04:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20230310201525.2615385-1-eblake@redhat.com> <20230310201525.2615385-4-eblake@redhat.com>
In-Reply-To: <20230310201525.2615385-4-eblake@redhat.com>
From:   Nir Soffer <nsoffer@redhat.com>
Date:   Sat, 11 Mar 2023 14:22:51 +0200
Message-ID: <CAMRbyyv59L9GiLr5tJvnNdwnBNdNGw+xveG7S63WC9ycOuJYrA@mail.gmail.com>
Subject: Re: [PATCH 3/3] block nbd: use req.cookie instead of req.handle
To:     Eric Blake <eblake@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 10, 2023 at 10:16=E2=80=AFPM Eric Blake <eblake@redhat.com> wro=
te:
>
> A good compiler should not compile this any differently, but it seems
> nicer to avoid memcpy() when integer assignment will work.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  drivers/block/nbd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 592cfa8b765a..672fb8d1ce67 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -606,7 +606,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struc=
t nbd_cmd *cmd, int index)
>                 request.len =3D htonl(size);
>         }
>         handle =3D nbd_cmd_handle(cmd);

This returns native u64 (likely little endian) but the new interface
specifies __be64. Should we swap the bytes if needed?

This will help tools like the wireshark plugin to display the right value
when checking traces from machines with different endianness. Or help
the nbd server to show the same *cooike* value in the logs. The value
is opaque but reasonable code can assume that __be64 can be safely
parsed as an integer.

> -       memcpy(request.handle, &handle, sizeof(handle));
> +       request.cookie =3D handle;
>
>         trace_nbd_send_request(&request, nbd->index, blk_mq_rq_from_pdu(c=
md));
>
> @@ -732,7 +732,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_de=
vice *nbd, int index,
>         u32 tag;
>         int ret =3D 0;
>
> -       memcpy(&handle, reply->handle, sizeof(handle));
> +       handle =3D reply->cookie;
>         tag =3D nbd_handle_to_tag(handle);
>         hwq =3D blk_mq_unique_tag_to_hwq(tag);
>         if (hwq < nbd->tag_set.nr_hw_queues)
> --
> 2.39.2
>

Also the same file has references to *handle* like:

static u64 nbd_cmd_handle(struct nbd_cmd *cmd)
{
    struct request *req =3D blk_mq_rq_from_pdu(cmd);
    u32 tag =3D blk_mq_unique_tag(req);
    u64 cookie =3D cmd->cmd_cookie;

    return (cookie << NBD_COOKIE_BITS) | tag;
}

static u32 nbd_handle_to_tag(u64 handle)
{
    return (u32)handle;
}

static u32 nbd_handle_to_cookie(u64 handle)
{
    return (u32)(handle >> NBD_COOKIE_BITS);
}

So this change is a little bit confusing.

I think we need to use a term like *nbd_cookie* instead of
*handle* to make this more clear.

Nir

