Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8A5C433ED
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 09:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFB6613E3
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 09:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347834AbhERJvr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 05:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348278AbhERJvM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 05:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621331393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xw/goXPvFheZsSlM5qbIIld4E4qboTY4W+fWzoyFrhk=;
        b=B9qtUB3pAB0Oq3CarKZ3h+1Ltl3tg2XuAjI9Pg8o3hJNpv41eGvAV3WmSONG7pLaR1RIZE
        dJE3gDKc/KfiCAOsaKEZvkeq99w4HXJ7lucWyMcVQ+dtnjJ5iuJInZMDhIksVn3gjmvsxp
        BqZLfpnD4pFNMzv+idgWFb16Cn31JEY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-q8jTCoYjPVC_8Lz4acfjDg-1; Tue, 18 May 2021 05:49:50 -0400
X-MC-Unique: q8jTCoYjPVC_8Lz4acfjDg-1
Received: by mail-wr1-f69.google.com with SMTP id q15-20020adfc50f0000b0290111f48b865cso1860699wrf.4
        for <linux-block@vger.kernel.org>; Tue, 18 May 2021 02:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xw/goXPvFheZsSlM5qbIIld4E4qboTY4W+fWzoyFrhk=;
        b=Vtsabk6SFxsJkH2Ku5Lyxc5xIjqFixDrXykhxMBcjr4JFe7Wc5WPftlfcIHKxJtney
         vWvaav2pBIxkJemVX6GwKA00hiORViMsgwYiG5ZSPY0IWccJ83xJx6oLjekHqchYaHh9
         uHuBGAF+cmTL87oOmz07mxHrlnHQNDKQiqnTSLHPZSz3IDTw/x8Qp07p+kZlpSV4w2DL
         xnyPQzR9JiBohveQ2Ik+UOuNL0oB0HXU04Zdmi8FHhWrBHtIWEwzkyz/YkkfRaq1yUHB
         EbGcJrjNQ+SpVyelCurz9Qj6Q9I3KEkix0IinNvLwu7Sd54YF2+PnZXl0aNttEFLeSIR
         Ubmw==
X-Gm-Message-State: AOAM532o/+KCCuNEvFm1+hZuXTVKST613b5yckPr53cB6SD70o9sRZHB
        392Te4uBxUP/zu2azhIxHIOceqpfJFN1VeDiiJBVw8fTla34uTL9yqLVesIo+XMGMDzgmOfhkWl
        PRomgvXg8TuWODNWebY7YSI7AeNc6sYRK1QO4wk0=
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr4416380wmq.38.1621331389144;
        Tue, 18 May 2021 02:49:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/0NPHA/2ZKm4TmhuLWzfEfI5L1uvCr50nQ90+pknjx8xcmDRTg8BLv6cZjQXUG7h1jeTne2Rj7DXrfSxZdek=
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr4416347wmq.38.1621331388777;
 Tue, 18 May 2021 02:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210429102828.31248-1-prasanna.kalever@redhat.com>
 <YKMKdHPFCNhR1SXx@T590> <CANwsLLH0HyZ-VGPMc+VmuLivG1fiZHnSqUyLx3UWb76ZMCgYSg@mail.gmail.com>
 <YKOHuNd0Kp+lcQHY@T590>
In-Reply-To: <YKOHuNd0Kp+lcQHY@T590>
From:   Prasanna Kalever <pkalever@redhat.com>
Date:   Tue, 18 May 2021 15:19:37 +0530
Message-ID: <CANwsLLE6FK3eCmDwQ+7ghwFx0Hi1KDr6TaiKX1VW2Yt+5xe+WA@mail.gmail.com>
Subject: Re: [PATCH] nbd: provide a way for userspace processes to identify
 device backends
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, Josef Bacik <josef@toxicpanda.com>,
        axboe@kernel.dk, Ilya Dryomov <idryomov@redhat.com>,
        Xiubo Li <xiubli@redhat.com>,
        Matteo Croce <mcroce@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 18, 2021 at 2:54 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, May 18, 2021 at 01:22:19PM +0530, Prasanna Kalever wrote:
> > On Tue, May 18, 2021 at 6:00 AM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > Hello Prasanna,
> > >
> > > On Thu, Apr 29, 2021 at 03:58:28PM +0530, Prasanna Kumar Kalever wrote:
> > > > Problem:
> > > > On reconfigure of device, there is no way to defend if the backend
> > > > storage is matching with the initial backend storage.
> > > >
> > > > Say, if an initial connect request for backend "pool1/image1" got
> > > > mapped to /dev/nbd0 and the userspace process is terminated. A next
> > > > reconfigure request within NBD_ATTR_DEAD_CONN_TIMEOUT is allowed to
> > > > use /dev/nbd0 for a different backend "pool1/image2"
> > > >
> > > > For example, an operation like below could be dangerous:
> > >
> >
> > Hello Ming,
> >
> > > Can you explain a bit why it is dangerous?
> >
> > Yes, sure. Please check the below comments inline,
> >
> > >
> > > >
> > > > $ sudo rbd-nbd map --try-netlink rbd-pool/ext4-image
> > > > /dev/nbd0
> > > > $ sudo blkid /dev/nbd0
> > > > /dev/nbd0: UUID="bfc444b4-64b1-418f-8b36-6e0d170cfc04" TYPE="ext4"
> >
> > On Map the rbd-nbd attempting to send NBD_CMD_CONNECT, for backend
> > 'rbd-pool/ext4-image'. Post which kernel will allocate a new device
> > say /dev/nbd0 for backend file rbd-pool/ext4-image (format:
> > <pool>/<backendfile>)
> >
> > > > $ sudo pkill -9 rbd-nbd
> >
> > Assume normally or abnormally the userspace process (rbd-nbd here) is
> > terminated, but then as per the settings the device /dev/nbd0 is not
> > returned immediately, the kernel will wait for the
> > NBD_ATTR_DEAD_CONN_TIMEOUT to expire.
> >
> > At this point two things could be possible:
> > 1. if there is a reconfigure request from userspace within the timeout
> > then the kernel might reassign the same device /dev/nbd0.
> > 2. if the timeout has expired, then the device will be relieved.
> >
> > > > $ sudo rbd-nbd attach --try-netlink --device /dev/nbd0 rbd-pool/xfs-image
> > > > /dev/nbd0
> > > > $ sudo blkid /dev/nbd0
> > > > /dev/nbd0: UUID="d29bf343-6570-4069-a9ea-2fa156ced908" TYPE="xfs"
> >
> > On attach the rbd-nbd attempt to send NBD_CMD_RECONFIGURE, after which
> > the kernel will assign '--device /dev/nbd0' to specified backend.
> >
> > But there is a chance that userspace processes might accidentally send
> > NBD_CMD_RECONFIGURE claiming for /dev/nbd0 for a different backend
> > (rbd-pool/xfs-image instead of original rbd-pool/ext4-image).
> > Currently, there is no mechanism to verify if the backend provided
> > later with attach(NBD_CMD_RECONFIGURE) is matching with the one
> > provided originally with map(NBD_CMD_CONNECT) before granting for a
> > attach or reconfigure.
> >
> > For example in the above-explained scenario:
> > Assume EXT4 on rbd-pool/ext4-image was mounted, after attach (Note:
> > device /dev/nbd0 is reconfigured to a different backend file) XFS on
> > rbd-pool/xfs-image would get corrupted. If there was an application
> > using /dev/nbd0 directly (as a raw block volume), it wouldn't be happy
> > either.
>
> OK, got it. If I understand correctly, what you need is to not allow
> reconfigure if the nbd disk is mounted, right?

Excuse me, not exactly. Mount was one example scenario to showcase why
allowing attaching without any validation could be dangerous.
Basically, we want a way to check and verify if the backend specified
at map time and backend specified at attach(reconfigure) time are
matching for a given device, only if they are matching proceed to
attach else fail.

>
> >
> > > >
> > > > Solution:
> > > > Provide a way for userspace processes to keep some metadata to identify
> > > > between the device and the backend, so that when a reconfigure request is
> > > > made, we can compare and avoid such dangerous operations.
> > > >
> > > > With this solution, as part of the initial connect request, backend
> > > > path can be stored in the sysfs per device config, so that on a reconfigure
> > > > request it's easy to check if the backend path matches with the initial
> > > > connect backend path.
> > > >
> > > > Please note, ioctl interface to nbd will not have these changes, as there
> > > > won't be any reconfigure.
> > >
> > > BTW, loop has similar issue, and patch of 'block: add a sequence number to disks'
> > > is added for addressing this issue, what do you think of that generic
> > > approach wrt. this nbd's issue? such as used the exposed sysfs sequence number
> > > for addressing this issue?
> > >
> > > https://lore.kernel.org/linux-block/YH81n34d2G3C4Re+@gardel-login/#r
> >
> > If I understand the changes and the background of the fix correctly, I
> > think with that fix author is trying to monotonically increase the seq
> > number and add it to the disk on every single device map/attach and
> > expose it through the sysfs, which will help the userspace processes
> > further to correlate events for particular and specific devices that
> > reuse the same loop device.
> >
> > Coming back to my changes:
> > I think here with this fix, we are trying to solve a different
> > problem. The fix with this patch accepts a cookie or a backend string
> > (could be file-path or whatever id userspace choose to provide) from
> > userspace at the time of map and stores it in the sysfs
> > /sys/block/nbdX/backend path and persists it until unmap is issued on
> > the device (meaning that identity stays throughout the life cycle of
> > that device, no matter how many detach and attaches happen).
>
> Your solution needs change from userspace side, so it isn't flexible.
>
> > If there
> > is a detach request in between (not unmap) then on the next attach
> > (reconfigure request to reuse the same device) the stored
> > cookie/UUID/backend-string will stand as a reference to verify if the
> > newly passed backend is matching with the actual backend passed at map
> > time to avoid any misconfigurations by accident and to safely proceed
> > with attach.
>
> We can avoid reconfigure if the nbd disk is opened exclusively, such as
> mount, please see if the following patch can solve your problem:

IMHO, we should almost never allow reconfigure/reattaching a given
device with a different backend (except in cases like live migration,
which the application should take care of), and not just when nbd disk
is opened exclusively.

When an attach (reconfigure) is issued, Its application's logic to
provide the same matching cookie (or device-string or a uuid) so that
kernel can validate it with /sys/block/nbdX/backend and continue
safely to attach and reassign the device back.

This is how it is supposed to be used:
https://github.com/ceph/ceph/pull/41323#issuecomment-842148450

Thanks!
--
Prasanna


>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 4ff71b579cfc..045532a68d1e 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2063,6 +2063,11 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>                 return -EINVAL;
>         }
>
> +       /* avoid changing device under exclusive owner */
> +       ret = bd_prepare_to_claim(nbd->disk->part0, nbd_genl_reconfigure);
> +       if (ret)
> +               goto out_no_abort_claim;
> +
>         mutex_lock(&nbd->config_lock);
>         config = nbd->config;
>         if (!test_bit(NBD_RT_BOUND, &config->runtime_flags) ||
> @@ -2141,6 +2146,8 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>                 }
>         }
>  out:
> +       bd_abort_claiming(nbd->disk->part0, nbd_genl_reconfigure);
> +out_no_abort_claim:
>         mutex_unlock(&nbd->config_lock);
>         nbd_config_put(nbd);
>         nbd_put(nbd);
>
>
> Thanks,
> Ming
>

