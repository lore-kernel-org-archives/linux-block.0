Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC2CC47088
	for <linux-block@archiver.kernel.org>; Thu,  1 Dec 2022 21:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiLAVuQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Dec 2022 16:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLAVuP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2022 16:50:15 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C71EBD0F4
        for <linux-block@vger.kernel.org>; Thu,  1 Dec 2022 13:50:13 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id 135so1968109iou.7
        for <linux-block@vger.kernel.org>; Thu, 01 Dec 2022 13:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1pWvUbunFu8qJy01nXVZgfaYmmAMyJq1KIdCNOTnoA=;
        b=eBB/HH/uNbSa9YfgvcxMSM9ENCf/LcoXe3WuQ3eNCpDLTkSn2Z091fJXVtfWobGdK4
         TaXHQNriByyo8azKMbiY0v0QY3AmB+wxr7LMDNuFUceYFvSfEijTwG4E7fFun5l0fUU9
         rdQbVqVCQweZ0+9fOCJVg87D2gRiy1ubjGgQunqxYSctfTl7e8AM3xwikd/aUb2FJ+Au
         d4l2k/q0r3yV6IMxjk6ERwrVt5HCazJc+4wYy3gpt03Dh04D7Uz+P8iFipBXqehgDUy8
         f7iN+PhumAJudA0F7MIv3mEpP7+Ds3kPonjLVr9EjJjI3RSb7IqvbtfryQlhclfBGAV4
         dOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1pWvUbunFu8qJy01nXVZgfaYmmAMyJq1KIdCNOTnoA=;
        b=JxiaNhFjdio23QFCb85Sv4ka21Kz+ZYnWP7D5HaZfta4bMiPhW/2wuoncOUToOhedD
         6GanhJodYJ3aCjrlYoLXeyKpqN+TJkSPE1A+OtvrQiA3W8R4aCYcz61YFpmWiZv0MKho
         yqSXmVVjKXZUQR19ob+m2G2GpwpXA3zzKoJ8ZX0mIf5tWepOAlYxZkNJvTtwGHVkwE6l
         +jVLO2f7AGQ9RS9MwaxKZ99p3mEdF5sZhNASmllkLERDmtmra89F9HcaXfdCJap0Ax3M
         aNMOR+Vx8JnKmzP1JSqNbfmbBvP5lV3k4VnYxqcFnVlFzZSQLJa2qR1KeibpMYIYjnQ4
         F7eg==
X-Gm-Message-State: ANoB5pljcWSXGgYq3aM/gkM+Nob/LBgA3jEO53uiexdCCyoAAtfL8ZQb
        eF79C+2RXJdMs21Qw3VFM3SuIF5Brzai9ecl
X-Google-Smtp-Source: AA0mqf4Yh3wWaVGpjTG+ApfOs8nHLnOWmwOpE/hjXpxDIjb1WVIADvqDIKF0m1t/xG2LYH8mpAHGvg==
X-Received: by 2002:a05:6638:3e13:b0:374:32e6:4b3c with SMTP id co19-20020a0566383e1300b0037432e64b3cmr31905436jab.197.1669931412669;
        Thu, 01 Dec 2022 13:50:12 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r23-20020a02c857000000b00356738a2aa2sm2058877jao.55.2022.12.01.13.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:50:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
In-Reply-To: <20221201061036.2342206-1-shinichiro.kawasaki@wdc.com>
References: <20221201061036.2342206-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] null_blk: support read-only and offline zone conditions
Message-Id: <166993141185.864226.14318075470596584756.b4-ty@kernel.dk>
Date:   Thu, 01 Dec 2022 14:50:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.2-dev-ebe49
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 01 Dec 2022 15:10:36 +0900, Shin'ichiro Kawasaki wrote:
> In zoned mode, zones with write pointers can have conditions "read-only"
> or "offline". In read-only condition, zones can not be written. In
> offline condition, the zones can be neither written nor read. These
> conditions are intended for zones with media failures, then it is
> difficult to set those conditions to zones on real devices.
> 
> To test handling of zones in the conditions, add a feature to null_blk
> to set up zones in read-only or offline condition. Add new configuration
> attributes "zone_readonly" and "zone_offline". Write a sector to the
> attribute files to specify the target zone to set the zone conditions.
> For example, following command lines do it:
> 
> [...]

Applied, thanks!

[1/1] null_blk: support read-only and offline zone conditions
      commit: d3a5738849e03990618cbb12e10db4eb82dbfda0

Best regards,
-- 
Jens Axboe


