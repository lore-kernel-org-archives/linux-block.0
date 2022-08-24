Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B90C00140
	for <linux-block@archiver.kernel.org>; Wed, 24 Aug 2022 13:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiHXNQY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Aug 2022 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiHXNQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Aug 2022 09:16:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D083DBF3
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 06:16:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z2so22020844edc.1
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 06:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9ZX9mHa+dW5Pscz7wJSd23y4ej0zn7AgqqZBm8xZJt8=;
        b=N85N8ZzwgHkgBU3m7+EkiqII0fNvqxLV9Xe9YnV06PK820xql4WKoRnpVpM4s0r8c9
         GXrNIN9iAJ5WWlldUjYBSfmfIWpscyA6tfoaeRtIDHhvF9bS20mulAb3acOKHF4eN0uE
         7Kviq+cxFGDpgMwaV1aUH3eT0OHr5Sy/zjtNx045WAMi8879dIzzVSwzRHuXKFBVVakI
         TLUWECzqOMEWEBujMP9GVOZjIOwxjaxAr2MJb+dAUjjCi4XKii16cKz+4ABfdEQF30+r
         Pb9sa1J6dGIWN5mSdkBlXMRAda9X8FdPP/mNQ0sXYCoKSJaNXU4QJvD7URpsNIUc6lvX
         /O6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9ZX9mHa+dW5Pscz7wJSd23y4ej0zn7AgqqZBm8xZJt8=;
        b=ky/EciM6qjGxCllsIqiJ8c8mLUZSnBePsj6iLaGp5kohmt0rCpTMziZ4buQSvZxT0h
         9De1ioPrb5feZOdBHJdIY6E5CDF7Qtse6qz0yjksyeIgAfh0V1m9BszkXCeHE1fovWfd
         hhDRIF4wB9yQYxj0m1hX40PSXWO+tZXhEKI8k04GsYYh9Cqhd0uSFWQYiVqU6pv2Hbho
         gNla+YDmMHhv3lx/l4LhduaQun8aWHrWvzEVoXBa2IBUY/CDSivwud4cLnFt7He44oh6
         PbMd3cCd+0Dhr5EggoG88CEX88g6p/12RrelDG6JcQkZeuN/1Uufc6MC/CxtFe3eRm7j
         mgMw==
X-Gm-Message-State: ACgBeo205vcr/YIL90w6AL8T90iLCtPxcibZFVhAnQJRzOGi5lomQyH+
        eA72rd9RyDzwZT3/FxdfagdSN5SJpm1j85T3KYE=
X-Google-Smtp-Source: AA6agR6VpGoeYtKw+cpnENYsf80iXylonPbMe1Rs+RREAVNYP7P3zV1NA5CuiDauyO3V9xKRe72gL016OjFcgQivVgQ=
X-Received: by 2002:a05:6402:320d:b0:446:bc66:5a6a with SMTP id
 g13-20020a056402320d00b00446bc665a6amr7525398eda.326.1661346981258; Wed, 24
 Aug 2022 06:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220823145005.26356-1-suwan.kim027@gmail.com> <YwU/EVxT0a6q2BfD@fedora>
In-Reply-To: <YwU/EVxT0a6q2BfD@fedora>
From:   Kim Suwan <suwan.kim027@gmail.com>
Date:   Wed, 24 Aug 2022 22:16:10 +0900
Message-ID: <CAFNWusaXc3H78kx1wxUDLht3PuV0A_VxvdmmY-yMJNefvih-1Q@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        acourbot@chromium.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Stefan,

On Wed, Aug 24, 2022 at 5:56 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Aug 23, 2022 at 11:50:05PM +0900, Suwan Kim wrote:
> > @@ -409,6 +409,8 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
> >                       virtblk_unmap_data(req, vbr);
> >                       virtblk_cleanup_cmd(req);
> >                       rq_list_add(requeue_list, req);
> > +             } else {
> > +                     blk_mq_start_request(req);
> >               }
>
> The device may see new requests as soon as virtblk_add_req() is called
> above. Therefore the device may complete the request before
> blk_mq_start_request() is called.
>
> rq->io_start_time_ns = ktime_get_ns() will be after the request was
> actually submitted.
>
> I think blk_mq_start_request() needs to be called before
> virtblk_add_req().
>

But if blk_mq_start_request() is called before virtblk_add_req()
and virtblk_add_req() fails, it can trigger WARN_ON_ONCE() at
virtio_queue_rq().

With regard to the race condition between virtblk_add_req() and
completion, I think that the race condition can not happen because
virtblk_add_req() holds vq lock with irq saving and completion side
(virtblk_done, virtblk_poll) need to acquire the vq lock also.
Moreover, virtblk_done() is irq context so I think it can not be
executed until virtblk_add_req() releases the lock.

Regards,
Suwan Kim
