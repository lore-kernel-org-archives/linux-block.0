Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42792C433EF
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 22:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiADWNH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jan 2022 17:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiADWNE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jan 2022 17:13:04 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342EDC061784
        for <linux-block@vger.kernel.org>; Tue,  4 Jan 2022 14:13:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z9so84059293edm.10
        for <linux-block@vger.kernel.org>; Tue, 04 Jan 2022 14:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGQEQrzle6DevMFJ4K42KWx6BHQfeEOEZJrq7IL0b4w=;
        b=geze8owlEWghLZKdzqDII97nIqUl+iYZLB63F8fWFCGYwdUVgvbL3LjxIOPpo/Ht2s
         ijK7p4kWV7/JXiNcHyv1dxd8bc0SVLxb57usXBLuyAjL8ihVdxpfoDvUaENon4D61JV6
         O6csQehRxWB/SKtQeWPSbwhSvGB9GdCA2vayc/6cCYdA/O8iYDlUqREW3+uFbHInsUAr
         +WiAWpHxzbQgxP7t3rJPVAZ8mvh+8X6dlavD4v7x8Hja3iZqdXkpkjpytb4YXbMBerM9
         5g9ExGoINcKbrFsXDicGS1XRdFr7bHOKXr2XO7GYQj1veU6Pft8iS9JyF+wc+ArZvsVo
         mCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGQEQrzle6DevMFJ4K42KWx6BHQfeEOEZJrq7IL0b4w=;
        b=AVo/pe0N4/Vyf2+olyzKKjARaJcRyGiyTPxDE9XhHLAvDGqOAC+Tg2ZOokjsNEyDrm
         slmfYmLopy9XYT2GeCq799FsLnpYErVKJFsF4x0f4TOWz4rnewtphHSHwubAowI32eTq
         X+4MiqY5g00wiEZml0/p5aEnBQr1ddVKAW2oUKSMrZftdKfrA8Pfb1lNugjeCaqCEYVB
         5hVOwwmRKyMAGyiRiO2RkuB4OQdaT5X7KbgoKRCCoPs9klAFztwYr2rpqu/QetSvUuyz
         pzapfUkIYiXbTu2dAxDzuqjGQ7ZzTHD2EhwJYIqzMxRrdTWbg7wEADAaDpTpRgrIHke5
         /yMw==
X-Gm-Message-State: AOAM533d4ObBe1H4aJCe1zomAERwRL3AweHBIBqpw9q26JYuAGLHBjrs
        CVRL8Tx0i+iBQNITSEcu+7qJX5NeqEqH65wgtRIMLQ==
X-Google-Smtp-Source: ABdhPJzXzykcOIf8e9duXoNYAsoGKpNohu4iMo/tE5ZXQUjWxxlY4IL2hbx0jtUzt5sSHZsTzm++8gbyzQ+Jo8qoEcY=
X-Received: by 2002:a17:907:7295:: with SMTP id dt21mr40132694ejc.441.1641334382743;
 Tue, 04 Jan 2022 14:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20220104162947.1320936-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220104162947.1320936-1-gregkh@linuxfoundation.org>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 4 Jan 2022 23:12:52 +0100
Message-ID: <CAMGffEmc=2m6xs_QOCRDbFgU5=3EpYOJqce-DRi=k=Yr4YbJYw@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd-clt-sysfs: use default_groups in kobj_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 4, 2022 at 5:29 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the rnbd controller sysfs code to use default_groups field
> which has been the preferred way since aa30f47cf666 ("kobject: Add
> support for default attribute groups to kobj_type") so that we can soon
> get rid of the obsolete default_attrs field.
>
> Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thanks!
> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
> index 44e45af00e83..2be5d87a3ca6 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -452,6 +452,7 @@ static struct attribute *rnbd_dev_attrs[] = {
>         &rnbd_clt_nr_poll_queues.attr,
>         NULL,
>  };
> +ATTRIBUTE_GROUPS(rnbd_dev);
>
>  void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
>  {
> @@ -474,7 +475,7 @@ void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
>
>  static struct kobj_type rnbd_dev_ktype = {
>         .sysfs_ops      = &kobj_sysfs_ops,
> -       .default_attrs  = rnbd_dev_attrs,
> +       .default_groups = rnbd_dev_groups,
>  };
>
>  static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev *dev)
> --
> 2.34.1
>
