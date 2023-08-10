Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FB8C001B0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 10:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjHJKWc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 06:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjHJKWK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 06:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C6483
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691662882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97EnLhuROKiA5XU6sdqPiWoCqvYENz+CWlSWUkPCvf4=;
        b=N1bxD7AIVsinxjdqSqgj1CN9yn5hISi8uhdijasODV8STOwNFsBSzrRBqLJ/NQM62qUciH
        ovFyPOtwA5SKwuK2IjsQcBByyoVS4ubdH36EUU+EfuZCEPhqpfgoCdAMcXflWxwKc6sq4+
        NcPptz8DlKXMJW5+fGkrsyGPrFviGlc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-RKumFiYKNE2uWZqCF-e6kg-1; Thu, 10 Aug 2023 06:21:21 -0400
X-MC-Unique: RKumFiYKNE2uWZqCF-e6kg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-268099fd4f5so828412a91.1
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 03:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691662880; x=1692267680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97EnLhuROKiA5XU6sdqPiWoCqvYENz+CWlSWUkPCvf4=;
        b=cHFzDXNlhPy4T1sLK+ubiI+YxoH5sJA0frSN0cZiKHgFwWCyuTbEOiQsvujDftzuEn
         lnQAEbp4dOfJTm5cggyX4AwC3nlc4PKDIwCl5gn9MfONGWxaSFeHVZRBlxIDZj125M+s
         I/zt2F9yq9L5ZDwhkdUoBCtCn5f+jo1crKVU9VsiBESUXzpMOd1p26GcjqAWKux6po0m
         0PKI6xS3VBxA6ag3LxUMqrLqvB9F3Um36zJbBvJY3LQlkqTT3TXTBdSE+cjxXoIdaitH
         LJH07z6nWkAQBDLW0r22fjaHMA9ahzZNNX5BlApgFExSub+UHIt6tth2cBet2ZVuxNiD
         o+2w==
X-Gm-Message-State: AOJu0YynsWqOSE43YYyWBYUxxE1oDrIySKMftTrQ7jZdWIJBrIU3yvvP
        TScDs2IBce+pA0KCcqAu83+GayxsYpwcIjFPWx9Uw8Cx1AIp1GdtsL8f1zWtmBASGl04vT6hPIK
        hTfYc7zo+zsg4BxuDDCsPn/J59MVCjGIhtpC6Z0c=
X-Received: by 2002:a17:90a:9a4:b0:263:fc45:4091 with SMTP id 33-20020a17090a09a400b00263fc454091mr1361097pjo.15.1691662880260;
        Thu, 10 Aug 2023 03:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcHNBMvFDBk7y0QhwsuUlmRcVRHLwkbRLjYKPP87oSA7v3s9ExCPraMelKe7GWxlh/LHUGAO7F9bQzhjOj7kc=
X-Received: by 2002:a17:90a:9a4:b0:263:fc45:4091 with SMTP id
 33-20020a17090a09a400b00263fc454091mr1361090pjo.15.1691662879954; Thu, 10 Aug
 2023 03:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
 <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
 <vxeo2ucxhvdcm2z673keqerkpxay6dgfluuvxawukkbunddzm2@jdkdk7y3a5nu>
 <xrqutkdhz7v6axohfxipv4or7k4jhoa57semwcxde7gletk76z@5kcashfdezhk>
 <adgkdt52d6qvcbxq4aof7ggun3t77znndpvzq5k7aww3jrx2tk@6ispx7zimxhy> <o2443ezmpny7dyvhiteajzgt3j7wcxo2fv7dik3h7hkjpc2h74@xeetbva55fx2>
In-Reply-To: <o2443ezmpny7dyvhiteajzgt3j7wcxo2fv7dik3h7hkjpc2h74@xeetbva55fx2>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 10 Aug 2023 18:21:07 +0800
Message-ID: <CAHj4cs8TBsEct9P6iiYwsiRhgCkPbdVL0-8KkXuKZbYhVsQV0Q@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Daniel/Shinichiro
Thanks for looking into this issue, I checked the 047 code, and we are
missing _find_nvme_dev after the second connect, and the below change
could fix this issue now.

diff --git a/tests/nvme/047 b/tests/nvme/047
index 6a7599b..8c0a024 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -52,6 +52,8 @@ test() {
                --nr-write-queues 1 \
                --nr-poll-queues 1 || echo FAIL

+       nvmedev=3D$(_find_nvme_dev "${subsys_name}")
+
        _run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" --size=3D"${rand_=
io_size}"

        _nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1


On Thu, Aug 10, 2023 at 5:18=E2=80=AFPM Daniel Wagner <dwagner@suse.de> wro=
te:
>
> On Thu, Aug 10, 2023 at 12:19:39AM +0000, Shinichiro Kawasaki wrote:
> > Yi, could you try and see if it avoids the failure?
> >
> > diff --git a/tests/nvme/rc b/tests/nvme/rc
> > index 4f3a994..005db80 100644
> > --- a/tests/nvme/rc
> > +++ b/tests/nvme/rc
> > @@ -740,7 +740,7 @@ _find_nvme_dev() {
> >               if [[ "$subsysnqn" =3D=3D "$subsys" ]]; then
> >                       echo "$dev"
> >                       for ((i =3D 0; i < 10; i++)); do
> > -                             if [[ -e /sys/block/$dev/uuid &&
> > +                             if [[ -e /dev/$dev && -e /sys/block/$dev/=
uuid &&
> >                                       -e /sys/block/$dev/wwid ]]; then
> >                                       return
> >                               fi
>
> The path for uuid is not correct. It's needs to be something like
>
>         if [[ -e /dev/$dev && -e /sys/block/"${dev}n1"/uuid &&
>                 -e /sys/block/"${dev}n1"/wwid ]]; then
>                         return
>         fi
>


--=20
Best Regards,
  Yi Zhang

