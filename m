Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E34EC433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 22:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353979AbiBKWLR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 17:11:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353972AbiBKWLR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 17:11:17 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F55CFE
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 14:11:15 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so772186pjv.5
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 14:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=fuqucsrtjzhFOnShAcnpOlcGjDP8Je+DQDR+021Gu6w=;
        b=VAWa0yWHIPiPVE04LKxUKF2fqDdJ9WTgIbi+ZumgQGTb90REXQJ5CWtLFak0JwVDNB
         p2WtN6j6P1RutnA1ctpRxFnwFjJSIiYPxJjiAHapNFYUEaDm6MvdmQIA3TaeTfGoTkiB
         uP0cz1JTqCKqzZHPYyNvzxXVWqzhmM76gVzJ/2XuLgtYPSPdGT5aDXvys4OJa8pw2uXn
         liQPje7PHi4d0i+wyIC2StA8s+E0wxw8gFjfddcIQHgWEZ2ubVVUT/5gC7rpM8XFFCqr
         MeJE6JFTvsOxlp5O2oqZZP5FU7mVEMRDnMEClqHtkciVlC3Khv82Bz9Glv/OLz4u7yzt
         25Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=fuqucsrtjzhFOnShAcnpOlcGjDP8Je+DQDR+021Gu6w=;
        b=0Jv46/HJF+e0oK3MGjp1vvLKMG0ZsRQdEITcExp6BeMR/dVOUt1Ig4wcR9ihjW7COG
         VXrOBVGPDPvQhmMdpDyOkgK06pNKenD9xJHcQoWzab4NvKkf+d+7zJ/ssHJ7dVFv3Pmu
         ufZB7Aa8iLnH0ltF53/AWGg5CfQbrWNqmBAhNO5Q9OtdCg6LUtisOn33TkHuynWaUqqS
         hZ/1CUfFfjaWqqRBGeerNKs3JwEIxZ1IdrdrKTW0EFr8JrlUV7qD2RUsvaWgcx/G3MVb
         wdSrqZvkQHUXYv/lj3RIO8ZBoLum34SCvFhrCDnJeeFYZmoFdTrIwx3gDys0S9uzgeUG
         /i/A==
X-Gm-Message-State: AOAM531JtgTTtK6mgcvZlZojMNmEuTReqc0yeZJYgQbnfWMnxgi49AtI
        5omOc80LPLvKdCDo6vVcIWPd5nGszfOCCg==
X-Google-Smtp-Source: ABdhPJzDBHf3mHfhvPgpPq/AkIDad/JqA6eCMm1xHa4Ie9LEwwM0c7TOJDiUa4AJOhmeAwze00MdDQ==
X-Received: by 2002:a17:902:a9c6:: with SMTP id b6mr3546355plr.90.1644617474875;
        Fri, 11 Feb 2022 14:11:14 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w4sm19812343pgs.28.2022.02.11.14.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 14:11:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Pei Zhang <pezhang@redhat.com>
In-Reply-To: <20220126035830.296465-1-ming.lei@redhat.com>
References: <20220126035830.296465-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3] block: loop:use kstatfs.f_bsize of backing file to set discard granularity
Message-Id: <164461747401.23683.16043772172792062024.b4-ty@kernel.dk>
Date:   Fri, 11 Feb 2022 15:11:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 26 Jan 2022 11:58:30 +0800, Ming Lei wrote:
> If backing file's filesystem has implemented ->fallocate(), we think the
> loop device can support discard, then pass sb->s_blocksize as
> discard_granularity. However, some underlying FS, such as overlayfs,
> doesn't set sb->s_blocksize, and causes discard_granularity to be set as
> zero, then the warning in __blkdev_issue_discard() is triggered.
> 
> Christoph suggested to pass kstatfs.f_bsize as discard granularity, and
> this way is fine because kstatfs.f_bsize means 'Optimal transfer block
> size', which still matches with definition of discard granularity.
> 
> [...]

Applied, thanks!

[1/1] block: loop:use kstatfs.f_bsize of backing file to set discard granularity
      (no commit info)

Best regards,
-- 
Jens Axboe


