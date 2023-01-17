Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE022C38142
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 22:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjAQWp5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 17:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAQWnf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 17:43:35 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA166CF2
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 14:30:32 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id v127so29494598vsb.12
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 14:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ScEkSv/4ujt+FscJGahMwM/oQgqzcSsBVgCxU70QRJI=;
        b=g2jwoIxQwdTnr1B7YJPOxcb2LNHairUXX0OqXhUcefSUqfesJfyBh6TTKdZh2u/frr
         btO0PTYoDQPJuS1xetwC9tGF45q7xFo8K/czu2UqDUjOM5OPHWVkW/YMHlN/AkTRYQJ4
         NMOCD1DNUSXb/N07F+oIjlhs4p8j3Zb9YsAU+n0/Gt1R+PDRdr5E6zP7MJUcXC3Ukjuh
         yAqgC2od1nSX98bQRUs7rndYvCGOOwmIS8v/7raRWbYykEwv8WGVQUb2hyXYLbeR4R4/
         NQbmbUX1HjuteCKPj4XZ+/dOnefbi7/2I2+ij8iMNJlsEA7JjGV2J2LMUN61elv3nEzA
         wKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScEkSv/4ujt+FscJGahMwM/oQgqzcSsBVgCxU70QRJI=;
        b=Ft/rhHCsgqSXb9zwzZ3dZOaPS1EPucvFK6/DjR1m38eLEHrNyuGbLEAkZPtZdsIdqc
         BhPuYEVRDhEReie0XG6G6r5+UTX4iORM9S1V3+IDKS8TB6SaI+HX+1ciSurKQg0srmyL
         zWsKU0LS+j/ohspkcflaZxWkt2x1mC0DHWgluniilwVSU97QrQwGzLNkS6uPXRYUSc45
         S/akZrW6vFxgQiFUwTl4wG2cbIk9dHcwuJL0Am7JQZ/YlJBbfGxzxEaw5Uk0CrIrEp47
         xvqnVu3FSLu0VMoIVclAYiBG4eKxfUDbmL0nNsWdXWe9hK5vE1fKmdOcu9bXyewF+BFG
         e5UA==
X-Gm-Message-State: AFqh2krhpB/FFCWmAidkrFx/4S4zsj+Hojc03G2tMg1XDPyM1mJp3nqq
        dj3/zJqFmRQCdk+/N4v6anuSp9vbNV9rX7MC6Cz52Q==
X-Google-Smtp-Source: AMrXdXsasxzFes28B36W71fU5Iue+c6SDhtfvo6j1Ld/ub9DRIvDly3xpJu8wO0cQ3K8NP967lAk53nFxEnNJD9i4tI=
X-Received: by 2002:a67:fb42:0:b0:3d0:d3fe:3d48 with SMTP id
 e2-20020a67fb42000000b003d0d3fe3d48mr557188vsr.32.1673994631663; Tue, 17 Jan
 2023 14:30:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJs=3_C+K0iumqYyKhphYLp=Qd7i6-Y6aDUgmYyY_rdnN1NAag@mail.gmail.com>
In-Reply-To: <CAJs=3_C+K0iumqYyKhphYLp=Qd7i6-Y6aDUgmYyY_rdnN1NAag@mail.gmail.com>
From:   Enrico Granata <egranata@google.com>
Date:   Tue, 17 Jan 2023 15:30:20 -0700
Message-ID: <CAPR809uYp6vGvCk4ugWOjbmd13WTm8fRg0f2Mdq3pxj6=d1McQ@mail.gmail.com>
Subject: Re: Virtio-blk extended lifetime feature
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        Jahdiel Alvarez <jahdiel@google.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
I am going to add +Jahdiel Alvarez who is also looking into a similar
issue, and also I would like to hear thoughts of people who may have
worked with (embedded or otherwise) storage more recently than I have

One thought that Jahdiel and myself were pondering is whether we need
"type_a" and "type_b" fields at all, or if there should simply be a
"wear estimate" field, which for eMMC, it could be max(typ_a, typ_b)
but it could generalize to any number of cell or other algorithm, as
long as it produces one unique estimate of wear

Thanks,
- Enrico

Thanks,
- Enrico


On Sun, Jan 15, 2023 at 12:56 AM Alvaro Karsz
<alvaro.karsz@solid-run.com> wrote:
>
> Hi guys,
>
> While trying to upstream the implementation of VIRTIO_BLK_F_LIFETIME
> feature, many developers suggested that this feature should be
> extended to include more cell types, since its current implementation
> in virtio spec is relevant for MMC and UFS devices only.
>
> The VIRTIO_BLK_F_LIFETIME defines the following fields:
>
> - pre_eol_info:  the percentage of reserved blocks that are consumed.
> - device_lifetime_est_typ_a: wear of SLC cells.
> - device_lifetime_est_typ_b: wear of MLC cells.
>
> (https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html)
>
> Following Michael's suggestion, I'd like to add to the virtio spec
> with a new, extended lifetime command.
> Since I'm more familiar with embedded type storage devices, I'd like
> to ask you guys what fields you think should be included in the
> extended command.
>
> Thanks,
>
> Alvaro
