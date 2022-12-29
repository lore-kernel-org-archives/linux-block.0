Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D40BC3DA79
	for <linux-block@archiver.kernel.org>; Thu, 29 Dec 2022 12:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiL2MJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 07:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiL2MJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 07:09:13 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4226CD
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 04:09:11 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w26so12510581pfj.6
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 04:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LKQAf165q2GYAJ6df90mK2ocE6dVs8653dgRlwxP66g=;
        b=brKW5+n6g6R87cN9ldLAAVHhujsMyACQw/WW8LJ8itT9uECTC2xu6/cinuX693zryl
         c9ifvMNoLgSiKBh95nO7VPq4n20oBVpj81adNyWYd/lPp5moANi+BiOwA5p1ul/PCHXU
         FGP2b5euRdrVlJaGdykXbN93b5ZpXNiMmY4/EEwUGIWuxQxDyM5KcrXPRDlJsz3D4srs
         sXk2vkSc6+wpgBKLE9RBBsfCF5dZiagch33wEPIx+1L1bshI1uDbssseUxcjlff3T5cg
         1t6lvgBkSyKGlS0N4tC/+tf/wVc1NsV1+ae5kMupEyhTdfcMcxNVQUA4OZVy+AkWUpGs
         sRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKQAf165q2GYAJ6df90mK2ocE6dVs8653dgRlwxP66g=;
        b=etva6YJwr+8RpibSoZWvQ/N2hYfhZii/L4fxPRfXwlHRwWPjmkbUFFiJMrzMjI8b3U
         1lQ5OczYC4Yzk74Z4j6Bu/t8NdyngCWTSEqj6nhVsho5GiQbhSiLZ4GRTeTzQ3P9pfef
         Z1GuW82eWaPzpcH59vtSoAAfuYStx7ZX0v93Cnf5SfP7ugmr8vu32f3w2D9ncNxaCKdu
         2Bk1cZhcn6OtxWxhGbW/kbkqAh+2Qjg+X1R8bS1MnqXzFsN2aG14bKJCjS7E4ie225Io
         AZc5PpefrgdzzymclPfOF9rfMKxhGVZH5htRenZvVCN6uTQUVEfpUxTsghCy5DpPgXrr
         fnRw==
X-Gm-Message-State: AFqh2kqK061zB9rcdmtScb/krp0em1SSPWxN742QO38JKUOuqe7iHsos
        D1V/nBtcb9orU97pidCuiDlwgedixJ0IgrpZLW0LENebkcbJcQ==
X-Google-Smtp-Source: AMrXdXt1Us6Pft3if2DIPzlyzIT7EAJIu1P91kWQa+fhnUWxIU8z8EocAyjDtOp7TIQ01F5RBw3Yuffmq6Fi4rBkrDA=
X-Received: by 2002:a65:45c8:0:b0:48c:5903:2f5b with SMTP id
 m8-20020a6545c8000000b0048c59032f5bmr1452115pgr.504.1672315750885; Thu, 29
 Dec 2022 04:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20221219122155.333099-1-alvaro.karsz@solid-run.com> <20221229030850-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221229030850-mutt-send-email-mst@kernel.org>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Thu, 29 Dec 2022 14:08:34 +0200
Message-ID: <CAJs=3_ApAnMTC0O81vO=hvRLssLYRnJsVUE5gd_aomCB+5eWLQ@mail.gmail.com>
Subject: Re: [PATCH v5] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> So due to my mistake this got pushed out to next linux release.
> Sorry :(

No problem at all :)

> I'd like to use this opportunity to write a new better
> interface that actually works with modern backends,
> and add it to the virtio spec.
>
> Do you think you can take up this task?

Sure, I can do it.
So, the idea is to:

* Drop this patch
* Implement a new, more general virtio block feature for virtio spec
* Add linux support for the new feature

right?
