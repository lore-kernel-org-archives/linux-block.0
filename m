Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9175C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 03:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKBDGb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 23:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiKBDGI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 23:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B70623BFD
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 20:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667358307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G5NMWhMkmWxmf5M1uFdOOWDQWXjoBKJy5nQdDufybsA=;
        b=igTG+h2ib87tCuzQRARNoqIOKHl0AL26AqzJE3bgeHa6nDkt/TZD7GltpsJBVmZeQicTVh
        knv4Bz5EitWYehrqWBEbvNcoTbepTJNE9zyMkIIJ5t3CMP6qdL8j4ht5QSbuPqqGeNXrEr
        PGAWGZ6CdC4ekxGSqrFjqQhyVjvBKH8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-HLcauwVcOPq_pwjILyfT4g-1; Tue, 01 Nov 2022 23:05:04 -0400
X-MC-Unique: HLcauwVcOPq_pwjILyfT4g-1
Received: by mail-pj1-f72.google.com with SMTP id oo18-20020a17090b1c9200b0020bdba475afso590727pjb.4
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 20:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5NMWhMkmWxmf5M1uFdOOWDQWXjoBKJy5nQdDufybsA=;
        b=deCmqFNS/iD4LNwLkbUpFkXO00E8Fyy62dLgxWnqnRdRKmU2uMie3vcUh4zs/ZNkvb
         W0Ij5iYV/TO7NqicPF0C9sN/v7Jw6y9o6kycNOeLcxRIbOC3IbvHOdbKE38zkwRNWjVL
         G4u+m/aZ2so0okGClVqP2zK11687RDyOEKa4eE/6fwAL+VZEqi4co1MGjH4AHAT6m4oA
         q4LL4yoSOwgE1fWtbz4LuQpi8/sbqB7V0f+tv+pOI5jHezTk4w0x6Cisas2njPaifEan
         F28d83wX7ph7by/WbWNqsBAv5ZaJPD9SctmmTIQt6I1eIju8ynEl5+uw2+hkCpeUwngU
         vjsg==
X-Gm-Message-State: ACrzQf2blEDvek97x9v9+LMOObdiES7STgp4Kl5Qqpt4cMK3um7uQhLG
        tkTfcrwCR9caQyipV3vbyoEDcOoA0HNNEdxt9KrqGs/0wkx6AL1Ts5zt1xlFd9UoY1G89BvNgO0
        wQRF73i8oh/etmbAi78AOXH/6c6texthfxjJc88o=
X-Received: by 2002:a17:90a:fa46:b0:20d:5efa:84fc with SMTP id dt6-20020a17090afa4600b0020d5efa84fcmr39580262pjb.20.1667358302890;
        Tue, 01 Nov 2022 20:05:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Vnp1D1oyvAFre7PKpajAh/v35UnqO0uC/YJk5yqsq92HQY/+ZFUYwuiWD8jdg/bflB3f5qK8IGfcBHgNc5AU=
X-Received: by 2002:a17:90a:fa46:b0:20d:5efa:84fc with SMTP id
 dt6-20020a17090afa4600b0020d5efa84fcmr39580248pjb.20.1667358302650; Tue, 01
 Nov 2022 20:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221024061319.1133470-1-yi.zhang@redhat.com> <20221024061319.1133470-4-yi.zhang@redhat.com>
 <20221025024924.mmtyrb34jvbzyotl@shindev>
In-Reply-To: <20221025024924.mmtyrb34jvbzyotl@shindev>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 2 Nov 2022 11:04:51 +0800
Message-ID: <CAHj4cs--m+QYLnHR5Xv5Cbxy0o+JKfo9xcm55Cb8gBgk9ow-NA@mail.gmail.com>
Subject: Re: [PATCH blktests 3/3] common/xfs: update _xfs_run_fio_verify_io to
 accept the size parameter
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 25, 2022 at 10:49 AM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Oct 24, 2022 / 14:13, Yi Zhang wrote:
> > This commit alo updated nvme/012 nvme/013 nvme/035 to pass the size
>
> Let's note why we do this. How about this descprtion?
>
>   Change fio I/O size of nvme/012,013,035 from 950m to 900m, since recent
>   change increased the xfs log size and it caused fio failure with I/O
>   size 950m.
>
>   Also add size parameter to _run_fio_verify_io. This allows to move the
>   fio I/O size definition from common/xfs to the test case, so that device
>   size and fio I/O size are both defined at single place.
>
> I think the commit title needs to reflect the motivations above, like:

Agree, updated the title and description in V2.

>
>   nvme/012,013,035: change fio I/O size and move size definition place
>
> > parameter to _xfs_run_fio_verify_io
> >
> > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
>
> How about to add "Link:" tag to refer our discussion?
>
>   Link: https://lore.kernel.org/linux-block/20221019051244.810755-1-yi.zhang@redhat.com/

Added in V2.
Again, thanks Shinichiro for the review.


>
>
> > ---
> >  common/xfs     | 3 ++-
> >  tests/nvme/012 | 2 +-
> >  tests/nvme/013 | 2 +-
> >  tests/nvme/035 | 9 ++++++++-
> >  4 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/common/xfs b/common/xfs
> > index 846a5ef..2c5d961 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -23,10 +23,11 @@ _xfs_mkfs_and_mount() {
> >  _xfs_run_fio_verify_io() {
> >       local mount_dir="/mnt/blktests"
> >       local bdev=$1
> > +     local sz=$2
> >
> >       _xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
> >
> > -     _run_fio_verify_io --size=950m --directory="${mount_dir}/"
> > +     _run_fio_verify_io --size="$sz" --directory="${mount_dir}/"
> >
> >       umount "${mount_dir}" >> "${FULL}" 2>&1
> >       rm -fr "${mount_dir}"
> > diff --git a/tests/nvme/012 b/tests/nvme/012
> > index c9d2438..e60082c 100755
> > --- a/tests/nvme/012
> > +++ b/tests/nvme/012
> > @@ -44,7 +44,7 @@ test() {
> >       cat "/sys/block/${nvmedev}n1/uuid"
> >       cat "/sys/block/${nvmedev}n1/wwid"
> >
> > -     _xfs_run_fio_verify_io "/dev/${nvmedev}n1"
> > +     _xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
> >
> >       _nvme_disconnect_subsys "${subsys_name}"
> >
> > diff --git a/tests/nvme/013 b/tests/nvme/013
> > index 265b696..9d60a7d 100755
> > --- a/tests/nvme/013
> > +++ b/tests/nvme/013
> > @@ -41,7 +41,7 @@ test() {
> >       cat "/sys/block/${nvmedev}n1/uuid"
> >       cat "/sys/block/${nvmedev}n1/wwid"
> >
> > -     _xfs_run_fio_verify_io "/dev/${nvmedev}n1"
> > +     _xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
> >
> >       _nvme_disconnect_subsys "${subsys_name}"
> >
> > diff --git a/tests/nvme/035 b/tests/nvme/035
> > index ee78a75..31de0d1 100755
> > --- a/tests/nvme/035
> > +++ b/tests/nvme/035
> > @@ -21,14 +21,21 @@ test_device() {
> >       local ctrldev
> >       local nsdev
> >       local port
> > +     local test_dev_sz
> >
> >       echo "Running ${TEST_NAME}"
> >
> >       _setup_nvmet
> >       port=$(_nvmet_passthru_target_setup "${subsys}")
> >       nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
> > +     test_dev_sz=$(_get_test_dev_size_mb)
> >
> > -     _xfs_run_fio_verify_io "${nsdev}"
> > +     if (( "$test_dev_sz" < 1024 )); then
> > +             echo "Test dev: $TEST_DEV should at leat 1024m"
> > +             return 1
> > +
> > +     fi
>
> As I commented on the second patch, I suggest to move this device size check
> part to the second patch.

Done in V2.

>
> Other changes looks good tome.
>
> > +     _xfs_run_fio_verify_io "${nsdev}" "900m"
> >
> >       _nvme_disconnect_subsys "${subsys}"
> >       _nvmet_passthru_target_cleanup "${port}" "${subsys}"
> > --
> > 2.34.1
> >
>
> --
> Shin'ichiro Kawasaki
>


-- 
Best Regards,
  Yi Zhang

