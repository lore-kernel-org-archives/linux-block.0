Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28598C2FC04
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 04:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348008AbjHQEZN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 00:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348007AbjHQEYj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 00:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923732D5E
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 21:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692246229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xi6GCIvYMrXK0lOa4BzgiNbthh1VOoylxGCNWn6oKms=;
        b=TOgHHEaspISR3hftMVxniQo8Lg+rfZ40GCwEsTfg+Vv3zIzaCuvFGVPlPxdgfEWjCdft7n
        J8zC386cJq7wtUXS4QM0n0D64u0CErX1rURgSFnNmmIYq4Ef21kaAtw1K+wZ70vLYUlDbr
        jc4bkEzywt4M/hgkMVVoI4YLUnBzavA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-2N1WJtbtP5CHEud0IDUFxg-1; Thu, 17 Aug 2023 00:23:47 -0400
X-MC-Unique: 2N1WJtbtP5CHEud0IDUFxg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26b418aa07bso2192441a91.1
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2023 21:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692246226; x=1692851026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xi6GCIvYMrXK0lOa4BzgiNbthh1VOoylxGCNWn6oKms=;
        b=c5T0Y0JGxbOX9AJLVdF2XdJRuPhpImUQtO4dxiAu4TbOCJfO5zKaVlg4krwdynzFTT
         7zKmQhg302xNfF+UE7ot+KkjWavZou+GxpuueZ/o5fmyVcBq2PqdjsTL2CylIvLDPJ9P
         IPxX6+MJKO9roubs7YXG8IIw4amdXJb5tVBpyCz66w9BCTDJC+ZaZl+Z9RGNyRHi/elL
         CAQDnrnY36yLmECpGJfbKmb7vftY3JNahQmQD5FfpNaTrrov9UKWDrPUMHrek4oikyug
         BEeQsYitvRrApYGhqhwVvaNhTwdXq5muTP9E1JLZe3r3gTCJI03ZpVldK08A86wVuuz1
         kp6Q==
X-Gm-Message-State: AOJu0YxqKpQgtYsuQTKrGOHZnqCnUgNuUOeQYH4iXcX5PKCO8/k+zVLa
        TN+w778Q6K54U7d7JDjcHTo1SVMsVjqv1ZVZms9a9ZwdA5B+pyiHof4LuODkILua++K/q0eiMer
        J46T0dwz6BK8+M82PV1knL0ZtlStRjuXqxDYoQao=
X-Received: by 2002:a17:90b:3692:b0:26b:51a6:4879 with SMTP id mj18-20020a17090b369200b0026b51a64879mr3285196pjb.6.1692246226693;
        Wed, 16 Aug 2023 21:23:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU1onVSXGuWAOE2c/XJazPwZ0lwqHUTGDRZ5bFw8NnKI3WTHOgUe2yRXPrkw21yNqNF3VSvDjL9d3P5TNKiBk=
X-Received: by 2002:a17:90b:3692:b0:26b:51a6:4879 with SMTP id
 mj18-20020a17090b369200b0026b51a64879mr3285185pjb.6.1692246226443; Wed, 16
 Aug 2023 21:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
 <149f023e-e4f4-3b36-56d5-e2d0f486439f@grimberg.me> <3zmxxrhmcpn2ogavpuropzmqbhwzqtgurkgx7cgpws3rt7qq4n@guspsox5d73u>
In-Reply-To: <3zmxxrhmcpn2ogavpuropzmqbhwzqtgurkgx7cgpws3rt7qq4n@guspsox5d73u>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 17 Aug 2023 12:23:35 +0800
Message-ID: <CAHj4cs-jn-cPTFr0Le7mkwgenTYY4g+YsCN=_3vNPLFK6CQTZg@mail.gmail.com>
Subject: Re: [PATCH blktests] nvme/rc: fix nvme device readiness check after _nvme_connect_subsys
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 16, 2023 at 8:11=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Aug 14, 2023 / 12:37, Sagi Grimberg wrote:
> >
> > > The helper function _nvme_connect_subsys() creates a nvme device. It =
may
> > > take some time after the function call until the device gets ready fo=
r
> > > I/O. So it is expected that the test cases call _find_nvme_dev() afte=
r
> > > _nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path =
of
> > > the created device, and it also waits for uuid and wwid sysfs attribu=
tes
> > > of the created device get ready. This wait works as the wait for the
> > > device I/O readiness.
> >
> > Shouldn't this call udevadm --settle or something?
>
> Ah, it will be more stable to add "udevadm settle" before the readiness c=
heck.
> Will add it.
>
Yes, I just tried to add "udevadm --settle" and it works well.

--=20
Best Regards,
  Yi Zhang

