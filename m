Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CDBC04A6A
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 14:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjHJOj0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjHJOj0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 10:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385EE2719
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691678314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7W0c0lPm/+AXFw1hghT8af4Ha098Ln/xEqAt+UBUVk=;
        b=aYmcl+pfOXFo4+bXZyncD5yqXSShV9TZDPg5kQEmCXswuAgPTA2sCHaGyRYCdZIIiwkVwU
        5HLpidbrehfNnl5dNR7J0SKzGe8s1eoPsb8tXMSesTkdGIDVVBt2uFXcaxhm5zxGe4SLmI
        6aRnXYk9uE8/za5pZ2V4fdj65sqGPzo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-1gkwh4XVMtGQkCALtYR3Mg-1; Thu, 10 Aug 2023 10:38:33 -0400
X-MC-Unique: 1gkwh4XVMtGQkCALtYR3Mg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-267f00f6876so1119674a91.3
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 07:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691678312; x=1692283112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7W0c0lPm/+AXFw1hghT8af4Ha098Ln/xEqAt+UBUVk=;
        b=L9pFaKgbO1BEO2gWnar8sAAp5PUDVhHlpo+Tx15XXljmNP3U5ZaE0nyHOKKuYH+tvd
         06vOpvatm/fcdlFFaqkU4Z21oXZhvyuU9s9grNVuhzv9Iyy33ff58rIppsnS+aUnnX/k
         SURstlEKyLcQxLU/43162Ngubl4bGVGTKdu6sjn0u88a30NaEK/y+l2uCZZTb4EErv1m
         nQX/+8oGEXE0Cl8tNxRQHXldSbNqw2Lbsuu9yDt4cbpmsBSqx5l3cuhg1avYCzMOT3Ts
         9s62DaHJLLl7QXzukuvHl00w/SoqV4q7ly+3Mp6G5EeY7pIv4piqi1tgGVK6wjPiTfor
         XPvg==
X-Gm-Message-State: AOJu0Yzo+Hy5K048SYkN0vNcBCC6meAf0Roi3MmitawE0JXwjim5LWtc
        NW9xhdFX0+iqgAUDdgDp1ltaVziNE5j1RFhD/p66DSidB+jtw47+yFfxs81FEB28ZKP/1+faWJp
        XSX6uqmYUfZltquLl4MDEPqhhNPLzkv78p0RQMd4=
X-Received: by 2002:a17:90a:fe5:b0:269:2356:19fb with SMTP id 92-20020a17090a0fe500b00269235619fbmr1973770pjz.15.1691678312103;
        Thu, 10 Aug 2023 07:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEknc/uFiNFwgJkb8GLMBu5GIVbyWK9XpeUzVzAXC+QoqHBqvXCKKZs9+YcOrzvD0+gtpjE8Tftb4E87x/Y05A=
X-Received: by 2002:a17:90a:fe5:b0:269:2356:19fb with SMTP id
 92-20020a17090a0fe500b00269235619fbmr1973753pjz.15.1691678311836; Thu, 10 Aug
 2023 07:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
 <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
 <vxeo2ucxhvdcm2z673keqerkpxay6dgfluuvxawukkbunddzm2@jdkdk7y3a5nu>
 <xrqutkdhz7v6axohfxipv4or7k4jhoa57semwcxde7gletk76z@5kcashfdezhk>
 <adgkdt52d6qvcbxq4aof7ggun3t77znndpvzq5k7aww3jrx2tk@6ispx7zimxhy>
 <o2443ezmpny7dyvhiteajzgt3j7wcxo2fv7dik3h7hkjpc2h74@xeetbva55fx2>
 <CAHj4cs8TBsEct9P6iiYwsiRhgCkPbdVL0-8KkXuKZbYhVsQV0Q@mail.gmail.com> <git5brh4yq7ij65oskwd7m4pwnhfcqbvwdn7pzsbrmzv3wgsk4@xvb43h5dbo4g>
In-Reply-To: <git5brh4yq7ij65oskwd7m4pwnhfcqbvwdn7pzsbrmzv3wgsk4@xvb43h5dbo4g>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 10 Aug 2023 22:38:18 +0800
Message-ID: <CAHj4cs-RqFEWFxdCGfZA7+qHLA+JJYs6qynCvKqTDdfW+V66ug@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 8:51=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Aug 10, 2023 / 18:21, Yi Zhang wrote:
> > Hi Daniel/Shinichiro
> > Thanks for looking into this issue, I checked the 047 code, and we are
> > missing _find_nvme_dev after the second connect, and the below change
> > could fix this issue now.
> >
> > diff --git a/tests/nvme/047 b/tests/nvme/047
> > index 6a7599b..8c0a024 100755
> > --- a/tests/nvme/047
> > +++ b/tests/nvme/047
> > @@ -52,6 +52,8 @@ test() {
> >                 --nr-write-queues 1 \
> >                 --nr-poll-queues 1 || echo FAIL
> >
> > +       nvmedev=3D$(_find_nvme_dev "${subsys_name}")
> > +
> >         _run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" --size=3D"${r=
and_io_size}"
> >
> >         _nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
> >
> >
>
> Ah, I overlooked that the test case calls _nvme_connect_subsys twice. Goo=
d to
> know that the above changes avoid the failure.
>
> Having said that, the fix above does not look the best. As discussed in a=
nother
> e-mail, _find_nvme_dev() just does 1 second wait, and it actually does no=
t check
> readiness of the device. This needs fix. Also I think the check and wait =
should
> move from _find_nvme_dev()to _nvme_connect_subsys(). Could you try the pa=
tch

Yeah, move to _nvme_connect_subsys looks more reasonable.

> below and see if it avoid the failure?

This change works well :)

>
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 4f3a994..d09e7b4 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -425,6 +425,7 @@ _nvme_connect_subsys() {
>         local keep_alive_tmo=3D""
>         local reconnect_delay=3D""
>         local ctrl_loss_tmo=3D""
> +       local dev i
>
>         while [[ $# -gt 0 ]]; do
>                 case $1 in
> @@ -529,6 +530,16 @@ _nvme_connect_subsys() {
>         fi
>
>         nvme connect "${ARGS[@]}" 2> /dev/null
> +
> +       dev=3D$(_find_nvme_dev "$subsysnqn")
> +       for ((i =3D 0; i < 10; i++)); do
> +               if [[ -b /dev/${dev}n1 &&
> +                             -e /sys/block/${dev}n1/uuid &&
> +                             -e /sys/block/${dev}n1/wwid ]]; then
> +                       return
> +               fi
> +               sleep .1
> +       done
>  }
>
>  _nvme_discover() {
> @@ -739,13 +750,6 @@ _find_nvme_dev() {
>                 subsysnqn=3D"$(cat "/sys/class/nvme/${dev}/subsysnqn")"
>                 if [[ "$subsysnqn" =3D=3D "$subsys" ]]; then
>                         echo "$dev"
> -                       for ((i =3D 0; i < 10; i++)); do
> -                               if [[ -e /sys/block/$dev/uuid &&
> -                                       -e /sys/block/$dev/wwid ]]; then
> -                                       return
> -                               fi
> -                               sleep .1
> -                       done
>                 fi
>         done
>  }
>


--=20
Best Regards,
  Yi Zhang

