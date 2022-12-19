Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E98C4167B
	for <linux-block@archiver.kernel.org>; Mon, 19 Dec 2022 08:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiLSIkU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Dec 2022 03:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiLSIkS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2022 03:40:18 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162A6A19A
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 00:40:17 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e190so1247211pgc.9
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 00:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f8+bSmaA0cmp16x26bRQ/cm+4zQqtY1wbwdEpQv5OiY=;
        b=x3TU33kLDcq/fKKT5qEHxp4k2dRmZICETK7MtPkScTvO3f4q0zn/lKiLXv5/E4poHh
         ohcn17PYGrtMr7icJoKrtIh1wNpyHZrW8qXbxXAJuCD7Cu60bPhfFEtBZJrqAqyzdZ4k
         BfpPqfxo/eY7Rbs8thLo2rI+w4ExHV84kb8cnzQzgyXEO9j+fLgl9NqWIjcv/UOfM6MJ
         h2r8rSKyhv6IS16fz9VXUNe70HAEbgY2CbzOb7K0nchnNIyNmEnZhm3HNK1umwI2830K
         AkAG9tBUOawIoOK8pjc76Mc9/yazdENIRmrWYKP3MSbdTk6aBVOaXrXuTXaUl8TYmmWh
         sZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8+bSmaA0cmp16x26bRQ/cm+4zQqtY1wbwdEpQv5OiY=;
        b=gxeAO5CoaOHT64SiZk07w1qdvGC1HOuOufJUWrfWJunLi9b15hvJ+efQBVTFkLITOs
         QPCxHBaI+mF4jTqo1cXS09WPNFlfEMo2otmRvU03Sa6f/FzTZx5GYn5P9WVdIyji+U5K
         Ai3zdAAQ4KkyuJnl5Fk8QhrP6T5TH9pSP40H9wDageyKmrwlIDGW85GLDx9MjVBvIKCW
         M56/RphOWUhOFXWyuVoQ/3dB4tZOcuBDRXctEAqjLfGdj1zfHU8CL5nufRJIkwc9FCiQ
         PQ+3xqHRJJzt44pdll30fMvpdXATCg7A2gs5K4OvZtVqn7K/A0thRzXUo4IRmL2B2o4L
         sLXg==
X-Gm-Message-State: ANoB5pkmuR2H/Rfk3ZplB9fCKDbOvvs+5G7Dnz8MN+RaV8UM4mCbzyNo
        Fa3jIHqoVm9gQhLWtzNxA16bZrdtehCaW1ZGXyQS/A==
X-Google-Smtp-Source: AA0mqf6fHrB24kpKRZtxJ/jl4cyycBpONCwoE9u9Hwo5PX1mANCykQgJBY1PwHfLY1yPaXCstzW+unZ0wtSJyelyLd8=
X-Received: by 2002:aa7:9acc:0:b0:577:81cb:4761 with SMTP id
 x12-20020aa79acc000000b0057781cb4761mr9183983pfp.46.1671439216472; Mon, 19
 Dec 2022 00:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com> <20221219025404-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219025404-mutt-send-email-mst@kernel.org>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Mon, 19 Dec 2022 10:39:39 +0200
Message-ID: <CAJs=3_CWQ3T1O5RofstwkczpgoJym5X4xBQmdQCtt573sHUOKg@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael,
Sorry, I had no time to create a new version.
I'll do it today.

Alvaro
