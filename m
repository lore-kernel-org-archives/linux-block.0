Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F431C678D4
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 17:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjAQRYI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjAQRXh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 12:23:37 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8758E4C0C3
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 09:23:04 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id j1so6941273iob.6
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 09:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92h0XMY9EaikZnxcpvvswgmJ+pfFWmReslOm2xWD2c4=;
        b=QPQDnNNt9AptVDLEj1KH0uPd0l9zdFs3HeHISmrUALMGQZyglqoSYB1FNsCYB2KTGB
         LlNiysXHxIHV02kTEXdd7NPOkhAKs97hM7dlk/b9WBn0xM7bn6YQ8DIOm6xLQWm6FpGt
         bplOSqqPWU5eEcZTjlj254Fs1P+LMJv5CdESH8qq4bXHgInIHII1VxVL2L7/mjlpnPJR
         y/PXZdkXN9LCaULduBHcObK4QhDOxzEXcImmwy825V3+uqVQeguGDGGhjM0BHmifykeo
         WTTjE2bljFvco40lJVvVTbu2j4c6s8tTinkRKgWh2c1sphjbg6Mj4/Tm9bentqH0NS0y
         BMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92h0XMY9EaikZnxcpvvswgmJ+pfFWmReslOm2xWD2c4=;
        b=DCoPHJEXFN072EWw45VGQcI8mXohErNXcEu5xgI9ZiiUwRYBdmKugNnHWBxvcvQVzV
         dGpWr2hLBCltxOlP0lqgck/j37k3E2n0RDgVa1IM8v3IZrCnSgXf4ScAruShyQVCd8gm
         AkYjpKsAhy+cnTamyY2TlhIcaVzKPVyC9KiI5CG67fCdBc2OGjqgCauQtLDhX18aFc8d
         AuyRsJvx8O2dYSi1F5FQsXrH1en1/deF7RL1MAObuG5wBtRyo5n4wPbLvhYtEElbr+tS
         4F/juFRyxBESnVMh2pG3F3CBWMUdMQeVpcKpCQXkUO8cDpcjvh74LUtzt9p6mv1OUSEc
         IX6Q==
X-Gm-Message-State: AFqh2krcAm6dheqDEMSW+w/93W4fuSQ/XoHh7+EgaRrpS6fQXyeBENdz
        3t30RL9dE0Ea1NGdX0gI/eqJx2FDd/Ltalsm
X-Google-Smtp-Source: AMrXdXvp2p1DAbTDUvZuqq5o35o8Q6vrxFO3+JrbSo9vfkCgkq5Cmk40Xi+lRfB0weNRQ6tMHTcjAw==
X-Received: by 2002:a5e:dd04:0:b0:6dd:f251:caf7 with SMTP id t4-20020a5edd04000000b006ddf251caf7mr559039iop.0.1673976183850;
        Tue, 17 Jan 2023 09:23:03 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h31-20020a056638339f00b0039e8a5930a2sm7549588jav.8.2023.01.17.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:23:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
In-Reply-To: <20230106041711.914434-1-ming.lei@redhat.com>
References: <20230106041711.914434-1-ming.lei@redhat.com>
Subject: Re: [PATCH V4 0/6] ublk_drv: add mechanism for supporting
 unprivileged ublk device
Message-Id: <167397618329.17297.7950838345623192951.b4-ty@kernel.dk>
Date:   Tue, 17 Jan 2023 10:23:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 06 Jan 2023 12:17:05 +0800, Ming Lei wrote:
> Stefan Hajnoczi suggested un-privileged ublk device[1] for container
> use case.
> 
> So far only administrator can create/control ublk device which is too
> strict and increase system administrator burden, and this patchset
> implements un-privileged ublk device:
> 
> [...]

Applied, thanks!

[1/6] ublk_drv: remove nr_aborted_queues from ublk_device
      commit: d66a012deb6567dd127f38d068806adcfc3a5051
[2/6] ublk_drv: don't probe partitions if the ubq daemon isn't trusted
      commit: 6faa01c8bf3ba4ba6eec95b3ce646a9af9473988
[3/6] ublk_drv: move ublk_get_device_from_id into ublk_ctrl_uring_cmd
      commit: a5d140c503b6d17800911e2cd9070d5933b11a26
[4/6] ublk_drv: add device parameter UBLK_PARAM_TYPE_DEVT
      commit: 620183fd3cda8ef7fa9dec07d81ce2551420af8e
[5/6] ublk_drv: add module parameter of ublks_max for limiting max allowed ublk dev
      commit: 961ccca54ad53c4945c4e36982eaff304c3c2624
[6/6] ublk_drv: add mechanism for supporting unprivileged ublk device
      commit: 56f5160bc1b8d9756a5353f79bd00be989834c7d

Best regards,
-- 
Jens Axboe



