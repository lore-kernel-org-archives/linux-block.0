Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E74C4708D
	for <linux-block@archiver.kernel.org>; Mon,  5 Dec 2022 18:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiLESkg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Dec 2022 13:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiLESkG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Dec 2022 13:40:06 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3497B2316B
        for <linux-block@vger.kernel.org>; Mon,  5 Dec 2022 10:37:10 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q190so3033115iod.10
        for <linux-block@vger.kernel.org>; Mon, 05 Dec 2022 10:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bKqfMwQzWVOYOX0yr/2heukDSWlHU0sCLL6O1tBRc7A=;
        b=r2nugea+/S+x1+A/NKJxhGhSo46KlCg0/YSPkE4xZ65fZB3u3y4swnhKZToZJV53y9
         W9ZuR4fGX6HPrGTQoaamF83HV2266vhVLmtnTqs0f08R19v4/QjYZHxHkxNpukL6bq0T
         2RNtr7QF3zxGwPNAWXt2lxtnP8HKNHLrQNZWZRjIkLp+m6CJBuuAzxLg7wn6L7NeH5Br
         Ykj6XHfBLizr5eRdyrLbdpPVKMOx9NAw8tufqLVjkmkB+eGjAdId2ThIt3wJmqhKSbJT
         h7O2hmgsO0npQxMPs01kiVL2/tcv7qdJOM/Wj3xa/a2hq4E1YFE6m6+itmy/n/6DMF31
         q9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKqfMwQzWVOYOX0yr/2heukDSWlHU0sCLL6O1tBRc7A=;
        b=JaunakVb83pW+86xfgZvS44njyi5Lbn7YSYkK5pW9QoXE17qLpdTo/ne5FCZLDAUFR
         nVg3dPo5jCVkfjKMWjGY6q09AGQ9T9HfuTyo7/K0lebsjCF9bkZMJBWY0nhCEDkDPESk
         x7Dc7ybwTHSYVDHYMUNlQfA3dMsKY92TUIJQDp2RSPlGTjjWlTlMvL6PWC2+v4lhMVK7
         Kac+67mNjYdB86kMx1OaRP1+6ADHwcEB+6R8VRb62ayla+UDLRXX2DPgKjEs29XN8fQz
         gPtC6qnzem+PWdLCNHNcawJoBOFQUOlADXq+o/MFhrVK2jo3QF82SkUl1/EDkhCLfUCr
         Pg5w==
X-Gm-Message-State: ANoB5pmVzm1NYRFryYCTL8GBXNslalhVobl6NkDlOXotrin16kMtQQeC
        X+I36TmnxpTq4uhAZkGd4HQMVUpxXNk7WmISfcVyIQ==
X-Google-Smtp-Source: AA0mqf7iS69oYWO13rn/6u9i2SOCARyk4OODHe8uFql4/VPC3ttbr8u6HDq0kZnXhGPO5q+l052KxdhC7ngmMQnNADM=
X-Received: by 2002:a02:6603:0:b0:375:9e02:b459 with SMTP id
 k3-20020a026603000000b003759e02b459mr38421363jac.30.1670265429512; Mon, 05
 Dec 2022 10:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com> <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
In-Reply-To: <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Mon, 5 Dec 2022 20:36:33 +0200
Message-ID: <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To:     Jens Axboe <axboe@kernel.dk>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

> Is this based on some spec? Because it looks pretty odd to me. There
> can be a pretty wide range of two/three/etc level cells with wildly
> different ranges of durability. And there's really not a lot of slc
> for generic devices these days, if any.

Yes, this is based on the virtio spec
https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html
section  5.2.6
