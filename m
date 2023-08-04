Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68338C001DF
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 10:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjHDKeC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 06:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjHDKeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 06:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D581D2118
        for <linux-block@vger.kernel.org>; Fri,  4 Aug 2023 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691145200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYiqSi4DodEOlaOomALCTsLyCZXw6UfvQ3KXAk6gbxE=;
        b=Qkvio3GEUuxenkeyCsImvBMW1bNhk6INR9iC6+DLNpVsFVUXSh6QRBDquhT+0tdJwbpz9F
        YMdHdsimvEQ+PLerSHLFRUtc0EjXA8WmFTOlRVA+nI2YYPUjmI78hLW8VRXJyHzbubSjEh
        DHeLMcvO7i8tm5onR6VawfQtpEqXtEU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-A6qGR0VjNDyxnO-dkQb1kg-1; Fri, 04 Aug 2023 06:33:18 -0400
X-MC-Unique: A6qGR0VjNDyxnO-dkQb1kg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-267f61da571so1605241a91.0
        for <linux-block@vger.kernel.org>; Fri, 04 Aug 2023 03:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691145197; x=1691749997;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYiqSi4DodEOlaOomALCTsLyCZXw6UfvQ3KXAk6gbxE=;
        b=cgCwb5AEagWXjBjYtXWXVkY4EJ3/qXdDlSwp782hDM1ojQ5KHrraIDY+OXNM4paH/1
         0Zp6/TOXj+QhPkLgm+x114OskXEqleqfVuM1a87kz8D1HGxSwka7+D0bKo8WJbPk5SDa
         FhZTpHIxGdJA4mYAjW3l4SswZyDKDrvRUog+x+XtY7OmXnynoO4Ez87P22iikZm9ODy2
         9pQw1d3crJXA3INkvmRYdjpJiYriUx07lUR5wLHkty+NmV3Je0v/aDdlNgGbUTq9QOgo
         IrkoBWRi4JLNJMvOjVTkAUiQOM1cOV2Sc2bNjGh24bo6W1Oqn0l3MSx4hoXDggFawrho
         moHA==
X-Gm-Message-State: AOJu0YzzXJP88DfWM3SlDtdnaPb24gz0Kh7PD/GutYM+FqrImj2ltJB+
        sVMjpMKJURNuBEBmleDIH72ArGLVTHM5RY+6drffXsC61wEw+ZOXHYRnNSn69dnk4J5yeLtyf6C
        uJGJm9g4twucgPezjP1X1ulzX5URtX19FofRhM+epFMpuA493/l2l
X-Received: by 2002:a17:90b:3b4f:b0:262:f06d:c0fc with SMTP id ot15-20020a17090b3b4f00b00262f06dc0fcmr1384839pjb.7.1691145197682;
        Fri, 04 Aug 2023 03:33:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF81eckYJqc1+gwa1EwjNj3rqlJJA6x/ZAxR713Dj1IuEDl9lZjyBwP8DHBTAaI45pg010f6iMGvfVyFgK4T4o=
X-Received: by 2002:a17:90b:3b4f:b0:262:f06d:c0fc with SMTP id
 ot15-20020a17090b3b4f00b00262f06dc0fcmr1384831pjb.7.1691145197391; Fri, 04
 Aug 2023 03:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
In-Reply-To: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 4 Aug 2023 18:33:04 +0800
Message-ID: <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 1, 2023 at 7:28=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrote=
:
>
> Hello
>
> I found random nvme/047 failure on linux-block/for-next when I do
> stress blktests nvme/tcp nvme/047 test:

I tried to add one "sleep 0.05" after connecting that can workaround this i=
ssue.

>
> Kernel config: https://pastebin.com/6i3sZWAx
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D0
> nvme/047 (test different queue types for fabric transports)  [failed]
>     runtime  71.129s  ...  7.096s
>     --- tests/nvme/047.out 2023-07-16 23:04:30.052101710 -0400
>     +++ /root/blktests/results/nodev/nvme/047.out.bad 2023-07-19
> 09:17:35.949908134 -0400
>     @@ -1,2 +1,198 @@
>      Running nvme/047
>     +fio: looks like your file system does not support direct=3D1/buffere=
d=3D0
>     +fio: looks like your file system does not support direct=3D1/buffere=
d=3D0
>     +fio: looks like your file system does not support direct=3D1/buffere=
d=3D0
>     +fio: looks like your file system does not support direct=3D1/buffere=
d=3D0
>     +fio: destination does not support O_DIRECT
>     +fio: destination does not support O_DIRECT
>     ...
>     (Run 'diff -u tests/nvme/047.out
> /root/blktests/results/nodev/nvme/047.out.bad' to see the entire diff)
>
> After some investigating, I found it was due to the /dev/nvme0n1 node
> couldn't be created in time which lead to the following fio failing.
> + nvme connect -t tcp -a 127.0.0.1 -s 4420 -n blktests-subsystem-1
> --hostnqn=3Dnqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60=
b8de349
> --hostid=3D0f01fb42-9f7f-4856-b0b3-51e60b8de349 --nr-write-queues=3D1
> + ls -l /dev/nvme0 /dev/nvme-fabrics
> crw-------. 1 root root 234,   0 Aug  1 05:50 /dev/nvme0
> crw-------. 1 root root  10, 122 Aug  1 05:50 /dev/nvme-fabrics
> + '[' '!' -b /dev/nvme0n1 ']'
> + echo '/dev/nvme0n1 node still not created'
> dmesg:
> [ 1840.413396] loop0: detected capacity change from 0 to 10485760
> [ 1840.934379] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 1841.018766] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [ 1846.782615] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [ 1846.808392] nvme nvme0: creating 33 I/O queues.
> [ 1846.874298] nvme nvme0: mapped 1/32/0 default/read/poll queues.
> [ 1846.945334] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420
>
> BTW, I also found after disabling nvme_core.multipath, seems this
> issue cannot be reproduced.
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang

