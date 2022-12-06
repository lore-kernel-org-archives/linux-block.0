Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812C5C3A5A7
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 19:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLFT4n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 14:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLFT4m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 14:56:42 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C0732BAC
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 11:56:41 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id x11so6122526ilo.13
        for <linux-block@vger.kernel.org>; Tue, 06 Dec 2022 11:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr5A82QMDS3439cV/l0TiwyD6oe8HTmjdxBAYHIenkw=;
        b=5gZ4Gpu/Xoh5ChxX8vn4yDQ839Y02gORAbRJKicZwrHFBH0NIchUZDW6Y615MW8Cuo
         ZdO4L3CqvKD9JNcgHJjpe9/mjrs85Al83QInqMzjcK62pr1wgEqU8ZhTAJi4Ib3ahj7k
         BZlEtq3KfssqlsY9tZQIx0vaLlC9u3vbxT8LvjuAL1GnsClNkR2tm4WIKQeodHoXdkZE
         KiPCEIcEoxIg4QSjQNTqtlAXIew+2ghnCH4ev8+TU75YzUKjhKWJSMnNxTy27fwj8JCb
         XWwul5V7p/Z+1rXby5ETA9G2t4IWGRXtyRcQ3Cmi0XJKOmS3YkN3oRqED74z2Db+6nws
         ZSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pr5A82QMDS3439cV/l0TiwyD6oe8HTmjdxBAYHIenkw=;
        b=SU9sAf+g2BpVeEpA6/cpyqodBZXERNpv0zYN8o5FZZfeL0h2tD9W77hLEj1/0b1yzm
         xKz0XwgOqIGg37FFiYSz53mvWzXF3xlb5qBp8YG0Hlh7p/U7v4DchkoCBtvVOBaNKxAg
         L1j6vlp1N5x7DIWSQII7wQZbJUuXMZsw15kjqN9AVe9cl1RrDA7HAK/PkqEljCNdSwCZ
         dSGUQ7qVaS3JPgumelzj75TV5jjRyFogZ64FGLUDOjWX7mh0km+HuVl+WR+swAahCkWA
         DIXGTTjFZ9J1SOCO6EdiB4PGq8wYQBV/z4mTEu9PveZM0VA3Bvo1/5TPt/e85cCT37Wh
         9YbQ==
X-Gm-Message-State: ANoB5pnisHczQKGveHx2tubPh9Rtgk0/w/MG/7Ah0BufRqwBf06V+uHY
        TFPtBxELs330yRtCcPsS0lHSzIAOAx/tp8MwoOyuA3Jt/SXP0auRgNA=
X-Google-Smtp-Source: AA0mqf5weYpfxnfmeNEaWEQd5GuamfhCWZUc6GKCqEjTgjj47RKtDegoyGS/7Ff3WUue6RAch00gS/qlXcQ0t/Pzp84=
X-Received: by 2002:a05:6e02:1c8d:b0:303:71ee:7b6b with SMTP id
 w13-20020a056e021c8d00b0030371ee7b6bmr2852396ill.147.1670356600505; Tue, 06
 Dec 2022 11:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com> <1d1c946d-2739-6347-f453-8ccf92c6a0cc@acm.org>
In-Reply-To: <1d1c946d-2739-6347-f453-8ccf92c6a0cc@acm.org>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Tue, 6 Dec 2022 21:56:05 +0200
Message-ID: <CAJs=3_CWrO34KBxN_eNVyibRNYUP9tzmywnmq2W+9uMYwbQdBA@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

> Why does the above data structure only refer to SLC and MLC but not to
> TLC or QLC?

This has been discussed before.
The data structure follows the virtio spec
(https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html)

> How will this data structure be extended without having to introduce a
> new ioctl?

There are no more lifetime parameters defined in the virtio spec.
Please note that this is a virtio block specific ioctl, not a block generic one.
