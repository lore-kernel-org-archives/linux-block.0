Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02A5C10F1B
	for <linux-block@archiver.kernel.org>; Mon, 19 Dec 2022 12:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiLSMHR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Dec 2022 07:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiLSMGW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2022 07:06:22 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EF726D
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 04:06:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c13so6065668pfp.5
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 04:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z72tIQTWQKkjxDurYXeM6jJeyau+4C8onKiYHe9/trg=;
        b=G2HZQFMXJq/yO7qYguX3SI9vwa+Fg+dl+KAOIQpSnjCzocme99clJuWqSURnCi0kiZ
         kWQ6s5aQ9sc86L0s7HtzBFZD13/LfDtpEttRph5geZmQcPVpfMfUFWy6lq8qiWShSvma
         ZhtoFgdizl1Cp+qFU7SF3DYp2aUG6d6ms3zezQZ59OrUNbLbNCChVyO95/T+ckN85Fep
         bR68f9LsGazTThq2KkwfggEEzIAZth0oOf5GNziDZAUu2R9Yx3Qu8SZr2HqBonciRbuY
         Yx1kC9+85Te+WnedIaIdt0CHVnSWOEvEdWMnsHiL2VxwKvdmSdkkVmUOJ4UMohTljf4y
         M4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z72tIQTWQKkjxDurYXeM6jJeyau+4C8onKiYHe9/trg=;
        b=2gdizUQchHmJaxwCWwUzCkEjV6HwE48rn4dBMnUs1wMSzlTfXhU4knYDp1xowiyM53
         1OugFiOVHeMuIUI+wnEGX02dydqONUy+wGm57LNkef6ZAwJD18A1kyz22CPMwdfB1u3u
         ObwbaDw8N46mjFMGcI7DH4KWn/0NAsUtOJWjM3QykX2pLVUTReP6Pq7Eqc6lYUMomxsM
         bjQmdT0/tc3+kT9tGYQt1hRPHQTttqoRKZnOOQAgcjv99hlyzuf+W8gwd0Mx4DKwSrJ6
         fBagoygM5chk8EZhL8aPctIOMAFVqlJVjarmHsAHfdKPz4p42Hq2bI4b8Tq+DAXw4nkt
         /V8w==
X-Gm-Message-State: ANoB5pkswhb73nD79HXE26llAD4qc2R+e1raeJoNyC7LLf2LczeeijFs
        u7x+BDHcxevh1wLMruj+60Nih3+Ay7KCNW8ryy9XbQ==
X-Google-Smtp-Source: AA0mqf4DLQIVeU9mqz0c3srK4iXrfd3+uIvASXdVmprAScfuQJoaKDdja5IykdXV2wtbAurs6Tel0VZtrHbW3IvhuFQ=
X-Received: by 2002:a05:6a00:d47:b0:577:8bad:4f9e with SMTP id
 n7-20020a056a000d4700b005778bad4f9emr8100637pfv.77.1671451566978; Mon, 19 Dec
 2022 04:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20221219101307.131279-1-alvaro.karsz@solid-run.com> <20221219053022-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219053022-mutt-send-email-mst@kernel.org>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Mon, 19 Dec 2022 14:05:30 +0200
Message-ID: <CAJs=3_DSJkgVrZsBRhRqtU0BJbWSB3yWsYyrQAN9YYETtx3UzQ@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
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

> Since you repin it anyway, do you mind rebasing on top of my tree?
Sure, no problem.

> I would maybe add a comment
Ok, i will add the comment in the new version.
