Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF51C678D5
	for <linux-block@archiver.kernel.org>; Wed,  8 Mar 2023 08:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCHIvX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCHIvS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 03:51:18 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB0CB420B
        for <linux-block@vger.kernel.org>; Wed,  8 Mar 2023 00:51:05 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g3so62787198eda.1
        for <linux-block@vger.kernel.org>; Wed, 08 Mar 2023 00:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20210112.gappssmtp.com; s=20210112; t=1678265464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UnwWt1JB4GUlkYJWYTbVJrds3HL5hzeUBTo+KI4WgM=;
        b=cUQCaqnTHY6CDaOisn9ksjZ0PVT7+HkvhadjdS1VRnUxHXgQf6MzelZOT8LKUH9Gn2
         q53scBFMJSNm8rLID/kcq5XcsiE5rM6k+sV3+M6w0h4TdsyoW24wy5MVJbyrknDaIzZN
         Zi5tcddm+cnT+hCfdYrXQmioZdbWbD+Q7whti7slH+d63Zg30EAACbkdNIMCuVJcz2fR
         FrWILvHY2XWNdtcLB7KgjkyZwtx5eyiGIhTGbWdvKEgHJMLR2PA/IF85rc7aPypSPI8F
         cmEBq7DlU0+oq+sgtr6ZQpNX1L+9dw5FJz082rfyzf50BUqNoCaW1ATQ36tioYyyAGME
         0nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UnwWt1JB4GUlkYJWYTbVJrds3HL5hzeUBTo+KI4WgM=;
        b=Ga93ROcj+BerjECgxNatYENtLgYH+iWFIgwxQPJoZ49YuLtWyOxwqrJMt8rTfgs8fT
         k3UkxyQV7cbaVRCIElrZj56YeY9JqSJov+iIXRjPt5OX497pDIHa7UR/YNQJpmW58OAs
         cHc9gxWGjATZHTH/9+cAYL2S8F3jvudeYY+nxYmYzgMTuAKocppjfNqJJXl5ye5hjblL
         FPgRYYyliVQhfCePgwv4lIi1kSnWD+zjxmxx5+Rq8fNyPQacv/uOWDEKxv8orfLj4mcn
         pKCNptiAKKDDku8gPfB9eCcHknLsB5CpevSWOthoNx/z0ZPZLVBK89uwf97vwZa62vML
         GJdQ==
X-Gm-Message-State: AO0yUKWRCC7B9x0DGkAP/M3oYkJfsR5/14IVjGwm1NCyadnuTvdEmhtP
        G0MSMbJ+dUnt88iK+fEWVvhcdbDu3ZmLRM9wNRBfKg==
X-Google-Smtp-Source: AK7set/f9Wzd0vwxHPq9Wigihj53lwHbxxJBU0ydC62i7UUGBx4GnheECHVG0TU7Dk1XFJZeQZKhpBQoDKnJAd3DSsA=
X-Received: by 2002:a17:906:b10d:b0:8b1:7ac3:85d3 with SMTP id
 u13-20020a170906b10d00b008b17ac385d3mr8248125ejy.9.1678265464327; Wed, 08 Mar
 2023 00:51:04 -0800 (PST)
MIME-Version: 1.0
References: <Y+EWCwqSisu3l0Sz@T590> <889dfe23-2e9e-c787-8c20-32f2c40509b5@suse.de>
In-Reply-To: <889dfe23-2e9e-c787-8c20-32f2c40509b5@suse.de>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 8 Mar 2023 09:50:53 +0100
Message-ID: <CANr-nt2S2KWuhDtaK6QAjDK2njGB+rcVjPvHjK1MB9_m+z9Wrg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
To:     Hannes Reinecke <hare@suse.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>, Stefan Hajnoczi <stefanha@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a great topic, so I'd like to be part of it as well.

It would be great to figure out what latency overhead we could expect
of ublk in the future, clarifying what use cases ublk could cater for.
This will help a lot in making decisions on what to implement
in-kernel vs user space.

Cheers,
Hans

On Mon, Feb 6, 2023 at 6:54=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 2/6/23 16:00, Ming Lei wrote:
> > Hello,
> >
> > So far UBLK is only used for implementing virtual block device from
> > userspace, such as loop, nbd, qcow2, ...[1].
> >
> > It could be useful for UBLK to cover real storage hardware too:
> >
> > - for fast prototype or performance evaluation
> >
> > - some network storages are attached to host, such as iscsi and nvme-tc=
p,
> > the current UBLK interface doesn't support such devices, since it needs
> > all LUNs/Namespaces to share host resources(such as tag)
> >
> > - SPDK has supported user space driver for real hardware
> >
> > So propose to extend UBLK for supporting real hardware device:
> >
> > 1) extend UBLK ABI interface to support disks attached to host, such
> > as SCSI Luns/NVME Namespaces
> >
> > 2) the followings are related with operating hardware from userspace,
> > so userspace driver has to be trusted, and root is required, and
> > can't support unprivileged UBLK device
> >
> > 3) how to operating hardware memory space
> > - unbind kernel driver and rebind with uio/vfio
> > - map PCI BAR into userspace[2], then userspace can operate hardware
> > with mapped user address via MMIO
> >
> > 4) DMA
> > - DMA requires physical memory address, UBLK driver actually has
> > block request pages, so can we export request SG list(each segment
> > physical address, offset, len) into userspace? If the max_segments
> > limit is not too big(<=3D64), the needed buffer for holding SG list
> > can be small enough.
> >
> > - small amount of physical memory for using as DMA descriptor can be
> > pre-allocated from userspace, and ask kernel to pin pages, then still
> > return physical address to userspace for programming DMA
> >
> > - this way is still zero copy
> >
> > 5) notification from hardware: interrupt or polling
> > - SPDK applies userspace polling, this way is doable, but
> > eat CPU, so it is only one choice
> >
> > - io_uring command has been proved as very efficient, if io_uring
> > command is applied(similar way with UBLK for forwarding blk io
> > command from kernel to userspace) to uio/vfio for delivering interrupt,
> > which should be efficient too, given batching processes are done after
> > the io_uring command is completed
> >
> > - or it could be flexible by hybrid interrupt & polling, given
> > userspace single pthread/queue implementation can retrieve all
> > kinds of inflight IO info in very cheap way, and maybe it is likely
> > to apply some ML model to learn & predict when IO will be completed
> >
> > 6) others?
> >
> >
> Good idea.
> I'd love to have this discussion.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andre=
w
> Myers, Andrew McDonald, Martje Boudien Moerman
>
