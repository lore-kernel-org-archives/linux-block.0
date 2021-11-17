Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACBDC433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 14:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE3361C12
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 14:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhKQOqe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbhKQOqd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 09:46:33 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F38C061570
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 06:43:35 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 14so3475004ioe.2
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 06:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=b4EWSHcj3yYffAng3nh3Sy3lOl+K0vBDxYY6h81LOYs=;
        b=QQXTxRuXAA+UPo2ox2eu9OvxDjt1Zi9/J2SX0K2kW+Qk+Kebfv06GqqGUQ/V92P2TZ
         8DPN+DaX188TjVoxIyMJCrNMsIPIEwBRNXFX/GAKGOORFqek5sqsgPTL8aVH4vTTEfNi
         C+s9+olga+s7vgsioheKDalzHmgBGCcaBkOjdDrQAxoeWLkkmvI6HHdMthnrA8YTmLmn
         L3kqesHaavwx9uGS721PxClFSlN9PHAupOrTVM7nU1Jq5Xqs86vTSVQ+2+9MBdwvlg7Q
         JnMkAgXkHV9Fh4+2gxsy6DDqEF6Uc7MoMmix1Fm1oAAt6sB+4oToxifdObN/v7tF7Uyv
         RSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=b4EWSHcj3yYffAng3nh3Sy3lOl+K0vBDxYY6h81LOYs=;
        b=wOVP6b1VY1vDWxMrqRvj6kgkNWPEVKyYTQyfmtNoBIFUrvnl4b31g29KzAU5kZuv6h
         BqP35rtnMCQMRn+RlJFFgrNODqhNgXYkibnKtqiQnXw8jEEzH883EBMYcEFDkaU4u7ih
         qcOSAxW1IsLVG3/agifZ+G/zGvLnJOw9X4Gr92C3gKOt/nqRh9+uhTlN0AXCPXC+V/l1
         vW1B9lkTaON9LtU2t+tLey9aphL3ex/CjLNouCLFYKMsUoS1S568vFOVCaj90hcFCx4K
         1mKpjERZ9Skaf7IcAwoKv44wGC4+I2wpJGGawxgIjmBqc1utyACaSo7qku0Pf/TszjDW
         tu/w==
X-Gm-Message-State: AOAM530BVPfkimpFr2J52Jik6qKHWTvU1RFxfzefU/LEelAlRLAp0VLC
        +S3p0SZF5sazAFGUFruKlzNfzAOrSEddQWsk
X-Google-Smtp-Source: ABdhPJxwOfnJW2SS1EwBrFNM7GjyB9ogsQkjX84WyF3mi9/ipzfYgUpScy3ZCdTKMT/kBcnUNtOolQ==
X-Received: by 2002:a05:6602:2b89:: with SMTP id r9mr11401161iov.32.1637160214413;
        Wed, 17 Nov 2021 06:43:34 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x2sm40043ilm.43.2021.11.17.06.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:43:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
In-Reply-To: <20211117115502.1600950-1-ming.lei@redhat.com>
References: <20211117115502.1600950-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: avoid to quiesce queue in elevator_init_mq
Message-Id: <163716021436.208920.8677969979207220917.b4-ty@kernel.dk>
Date:   Wed, 17 Nov 2021 07:43:34 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 17 Nov 2021 19:55:02 +0800, Ming Lei wrote:
> elevator_init_mq() is only called before adding disk, when there isn't
> any FS I/O, only passthrough requests can be queued, so freezing queue
> plus canceling dispatch work is enough to drain any dispatch activities,
> then we can avoid synchronize_srcu() in blk_mq_quiesce_queue().
> 
> Long boot latency issue can be fixed in case of lots of disks added
> during booting.
> 
> [...]

Applied, thanks!

[1/1] block: avoid to quiesce queue in elevator_init_mq
      commit: 245a489e81e13dd55ae46d27becf6d5901eb7828

Best regards,
-- 
Jens Axboe


