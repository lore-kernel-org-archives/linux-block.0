Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D411DEB64D9
	for <linux-block@archiver.kernel.org>; Mon, 19 Jun 2023 16:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjFSQEG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jun 2023 12:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFSQEG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2023 12:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEBB1AE
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2023 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687190596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUNdeIA/1AzZZbDLoP3YM+3b3mEPJWoa6Vr/dBsi1+Q=;
        b=KzmfcG5aZaTHSqkUhNN8ry+BIlIbmOb2CSQPcMEUzWInKKRKWkw6JG0D5TQNKKGgHqvhVb
        S/OY0gT3rGruWWVLBpKSJHl1LcI5Nfqo9UbIfOwsteKIUMssOb4ndP4ZFsOnkRyVA1HxZI
        cT6P8cWfdGBrVPVuZsFnbHs0/rZFh1Y=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-0pDTGywkMlW5IZOjpjnxKg-1; Mon, 19 Jun 2023 12:03:14 -0400
X-MC-Unique: 0pDTGywkMlW5IZOjpjnxKg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f60dd5ab21so2649916e87.3
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2023 09:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687190593; x=1689782593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUNdeIA/1AzZZbDLoP3YM+3b3mEPJWoa6Vr/dBsi1+Q=;
        b=QG8ioX4giFh4rlrFEKr21DpTeJQzQqHUsR8wxbgruugpuDIJQ2i/CEclxQh6s+CIhE
         SpdOTUYRc3wqMIqegCWK1CsfsvlUBqkyYerskyWhv+wSkSfXiOpk2c8AO0OKR+hhaUFP
         4F41ZKpNJ95i2asHQEcIavOgJAoTPEb5PSCp4ZbRJ7sxVbSoa65bCySulmtCQbYFkNi4
         6kn8SNCdIw7ZfG/lTCWz28noanr1Hza6608cvuUV2sAAUKdsrAo1YG77smuRfyEgvLWG
         TdEGFulmcWGiad6IHbLsjzDAOV9rvNmcKZkHoGLkzQk3RCvp7uCzHtTn+10NTiXd3VCb
         CnSw==
X-Gm-Message-State: AC+VfDxrnCiZdESpNmQfUKTLowQwkdbVtN5q6xWYi9VetKE6nOt5Cmq4
        QqlBFX40DuV39fjf+pGmP9VRsuKTpURJqgBeNEwH3F/aNC9mAX+EQkqSDnXsZU9jOn7x4d7KH8E
        Iz/H8IwqM3yFgyVLZnGIqhS8Mbk5hYKWdeqKQ2vI=
X-Received: by 2002:a05:6512:3139:b0:4f8:6ecc:db15 with SMTP id p25-20020a056512313900b004f86eccdb15mr1829440lfd.49.1687190593327;
        Mon, 19 Jun 2023 09:03:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46ULPdb0Aszzhlb+0iICdef0K8E3EyEAwzL9IcMGe520J56BfeqUyp1JCTVwm4AMUCDW5qbG5XWhVHXCICe+8=
X-Received: by 2002:a05:6512:3139:b0:4f8:6ecc:db15 with SMTP id
 p25-20020a056512313900b004f86eccdb15mr1829416lfd.49.1687190592920; Mon, 19
 Jun 2023 09:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230609180805.736872-1-jpittman@redhat.com> <ZIfIZWthJptVsQ6q@ovpn-8-16.pek2.redhat.com>
In-Reply-To: <ZIfIZWthJptVsQ6q@ovpn-8-16.pek2.redhat.com>
From:   John Pittman <jpittman@redhat.com>
Date:   Mon, 19 Jun 2023 12:02:36 -0400
Message-ID: <CA+RJvhx0G7cLeQ1krpD8Noc7iZYcC4bMaVNzVsrcOrXE=yCdNQ@mail.gmail.com>
Subject: Re: [PATCH] block: set reasonable default for discard max
To:     axboe@kernel.dk
Cc:     djeffery@redhat.com, loberman@redhat.com, emilne@redhat.com,
        minlei@redhat.com, linux-block@vger.kernel.org,
        ming.lei@redhat.com, Mike Snitzer <msnitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, I saw in the v2 of your original patchset that made max
discard rw, you were going to set a 64M default, but Mike mentioned
some issues it might present in dm, so you said you would come back to
it later and decide on a default max [1].  In the link that Ming
provided [2], the general consensus was that the hw manufacturers
should do what they say; they've sold this function as fast, so they
should make it fast.  But unfortunately, from what I've read, it still
seems there are very few, if any, devices that can truly handle a 2TiB
discard well.  Of course, I don't have any insight into the hw
manufacturers intentions, but in my opinion, we shouldn't be keeping
problematic kernel limits based on a selling point by the hw
manufacturers.

So, the thought (after bugging Ming offline) is we could take one of
the below approaches:

1) Set a 64M limit as you've suggested in the past.  It seems more
prudent to tune the value upward for the few devices that can actually
handle a 2TiB discard rather than tune downward for the large
majority.
2) Create a udev rule to go into RHEL that would set 64M as we still
steadily see support cases where max discard needs to be tuned
downward.

In either case, I suppose we'd have to figure a way to not impact dm.
Maybe we could do that with a driver setting or udev rule?

Jens and Mike, Do you guys have any thoughts on this?  Asking here
instead of RH bug (2160828) since Jens said he wanted to come back to
this issue later in the thread mentioned.

Thanks for the continued assistance.

[1] https://lkml.org/lkml/2015/7/15/859
[2] https://lwn.net/Articles/787272/

On Mon, Jun 12, 2023 at 9:37=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Fri, Jun 09, 2023 at 02:08:05PM -0400, John Pittman wrote:
> > Some drive manufacturers export a very large supported max discard size=
.
>
> Most of devices exports very large max discard size, and it shouldn't be
> just some.
>
> > However, when the operating system sends I/O of the max size to the
> > device, extreme I/O latency can often be encountered. Since hardware
>
> It often depends on drive internal state.
>
> > does not provide an optimal discard value in addition to the max, and
> > there is no way to foreshadow how well a drive handles the large size,
> > take the method from max_sectors setting, and use BLK_DEF_MAX_SECTORS t=
o
> > set a more reasonable default discard max. This should avoid the extrem=
e
> > latency while still allowing the user to increase the value for specifi=
c
> > needs.
>
> As Martin and Chaitanya mentioned, reducing max discard size to level
> of BLK_DEF_MAX_SECTORS won't be one ideal approach, and shouldn't be
> accepted, since discarding command is supposed to be cheap from device
> viewpoint, such as, SSD FW usually just marks the LBA ranges as invalid
> for handling discard.
>
> However, how well discard performs may depend on SSD internal, such as
> if GC is in-progress. And it might be one more generic issue for SSD,
> and it was discussed several times, such as "Issues around discard" in
> lsfmm2019:
>
>         https://lwn.net/Articles/787272/
>
> BTW, blk-wbt actually throttles discard, but it is just in queue depth
> level. If max discard size is too big, single big discard request still m=
ay
> cause device irresponsive.
>
>
> Thanks,
> Ming
>

