Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7A9C32771
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 00:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD192072E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 00:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4LQddkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgAGATX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 19:19:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50895 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727217AbgAGATX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 19:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578356362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P6DKJqEOe4vhsCWKNTqOKkUCkY52yGXVAFKOlUKBEWs=;
        b=B4LQddkf/6YhUODI9BvwUFDr0RqmUcgaAH+HX6x2uPqu1EDL/SK5wILumMRC5DbEZ4hpmV
        +xUR9xBEbOuUryL+fLMc6XC+hOo5uPd/GfZWgSGHnbLrEzhRtyJkJNVLTT+/1xw4h1XrBw
        AQvKOhW2XEAc1gVvYp5YNgs9E6Jur8M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-DcGGQcKcNMyLvgb34J-yVQ-1; Mon, 06 Jan 2020 19:19:19 -0500
X-MC-Unique: DcGGQcKcNMyLvgb34J-yVQ-1
Received: by mail-qv1-f71.google.com with SMTP id z9so13025248qvo.10
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2020 16:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6DKJqEOe4vhsCWKNTqOKkUCkY52yGXVAFKOlUKBEWs=;
        b=bRsnhsL4IfAYylvTSphNTr0uPnkwaOohljMKdYlqafoJXgiA0o+n8qeOKubV7IgABG
         S2rtx6Op9rsNoKeo78iH9fxKcmhMaE7litwLRx6EZOlKtYFZBWZvTAoYevw4GX9aJd8u
         Yo7HpnZRq/ijarMRbYASX9xY2DzqyhNKeph/o4hEpq/g0srmQw9+kN2ofZE7Vcvqu//o
         qh6jqS6Kvw/zwAIFl1SBK5y1VcHfhRyXXD4IgA7ldKP9jWQKoXwlZwP0sKTAYG/DIQRY
         iPiT8glKvN7whwJ4gcOv5w/s3DZH5VPg4tglO2XcnmnviYwFL0GpMEr5vPP1ACksSdtv
         Sinw==
X-Gm-Message-State: APjAAAV18+3iYLmjJFjJeegJVfYXsXVkPhjK6sl4Af8+BB/hOKScIkWX
        +MaR+G0xXllwOj5FVJege42LQktuepM9xLOAR0LoOGeGu97tQucvzE6nxYIuM5+mlCaSB3aO21c
        smndmP+ZWe30vqyd2eLk85D8pc3Zm1QTgUY/DdPI=
X-Received: by 2002:a05:620a:78f:: with SMTP id 15mr10781734qka.295.1578356358797;
        Mon, 06 Jan 2020 16:19:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJKN93GGwNU9UovvnmTG1xqjy4nzbN2izviq9dtjrnRSJfQEtYKlj5BpLwckCuiU2VHx3CPvzGp0ntCgA4OY4=
X-Received: by 2002:a05:620a:78f:: with SMTP id 15mr10781716qka.295.1578356358552;
 Mon, 06 Jan 2020 16:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20191223225558.19242-1-tasleson@redhat.com> <20191223225558.19242-10-tasleson@redhat.com>
 <20200104025620.GC23195@dread.disaster.area> <5ad7cf7b-e261-102c-afdc-fa34bed98921@redhat.com>
 <20200106220233.GK23195@dread.disaster.area>
In-Reply-To: <20200106220233.GK23195@dread.disaster.area>
From:   Sweet Tea Dorminy <sweettea@redhat.com>
Date:   Mon, 6 Jan 2020 19:19:07 -0500
Message-ID: <CAMeeMh-zr309TzbC3ayKUKRniat+rzurgzmeM5LJYMFVDj7bLA@mail.gmail.com>
Subject: Re: [RFC 9/9] __xfs_printk: Add durable name to output
To:     Dave Chinner <david@fromorbit.com>
Cc:     Tony Asleson <tasleson@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > >> +
> > >>    if (mp && mp->m_fsname) {
> > >
> > > mp->m_fsname is the name of the device we use everywhere for log
> > > messages, it's set up at mount time so we don't have to do runtime
> > > evaulation of the device name every time we need to emit the device
> > > name in a log message.
> > >
> > > So, if you have some sooper speshial new device naming scheme, it
> > > needs to be stored into the struct xfs_mount to replace mp->m_fsname.
> >
> > I don't think we want to replace mp->m_fsname with the vpd 0x83 device
> > identifier.  This proposed change is adding a key/value structured data
> > to the log message for non-ambiguous device identification over time,
> > not to place the ID in the human readable portion of the message.  The
> > existing name is useful too, especially when it involves a partition.
>
> Oh, if that's all you want to do, then why is this identifier needed
> in every log message? It does not change over the life of the
> filesystem, so it the persistent identifier only needs to be emitted
> to the log once at filesystem mount time. i.e.  instead of:
>
> [    2.716841] XFS (dm-0): Mounting V5 Filesystem
>
> It just needs to be:
>
> [    2.716841] XFS (dm-0): Mounting V5 Filesystem on device <persistent dev id>
>
> If you need to do any sort of special "is this the right device"
> checking, it needs to be done immediately at mount time so action
> can be taken to shutdown the filesystem and unmount the device
> immediately before further damage is done....
>
> i.e. once the filesystem is mounted, you've already got a unique and
> persistent identifier in the log for the life of the filesystem (the
> m_fsname string), so I'm struggling to understand exactly what
> problem you are trying to solve by adding redundant information
> to every log message.....
>

Log rotation loses that identifier though; there are plenty of setups
where a mount-time message has been rotated out of all logs by the
time something goes wrong after a month or two.

