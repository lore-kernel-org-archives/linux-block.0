Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455B9C5479D
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 03:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjAIDaI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Jan 2023 22:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjAIDaI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Jan 2023 22:30:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151E05F82
        for <linux-block@vger.kernel.org>; Sun,  8 Jan 2023 19:30:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p24so8130999plw.11
        for <linux-block@vger.kernel.org>; Sun, 08 Jan 2023 19:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1Q0s3QZP3zgMoieH09ETwIZdLie5eQr6iy50h+rqPs=;
        b=53o2f2czGsiadqF8jeoKIJ9bjpIMB+3jP+24mrPAyfFwUmUX6qSkx0LpX8JBjk/y2D
         /zVzBFSraoYAG/2RZZNqZm6+7XyQ8qGpOB0d97N2ATqfS0AFBsBGjmD7dbUtaoD1Efti
         EPDzn3gUBg+rAFjHwy8VAxPg8a/RIxruvrKbFg2/DyWNnrXa/XM6FpphPhyG/0fd4JyK
         8mccONWce58PXfyURCPRZbDGQpwgBzQyLLzLV9d6oY5Ztgu7hQl0cdT+X4jPwYPnwMfB
         tQ56VmDyFhqMj94Z3D6Y+XPiJLF4L61cTueI67N2tar93NMNbYTBMFECfnTAAvZ6D3E/
         B7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1Q0s3QZP3zgMoieH09ETwIZdLie5eQr6iy50h+rqPs=;
        b=Sfl4fw2y6ZUkGtT/hqo8URXABmsa/QNbuN2Cn5KDy4P0sd0A417CegIVKcaafLeaFe
         TiZ8iKtGXzNPyeQsaut8351DEyF5Dmf1t0Wv9b7+t2JMbA8LmUPBS1PSEtLJr9yew9Va
         jeEfnmzmwhY/3ks0KRHqL7uRnctef8tbewP85tnTHlgDLwg/qZX4XOXLU2yitT2BqiTt
         T9wCmS0pcV6lwh7ZaGkIubbi+nwfAXokDI8BUZH0PPX1n0MoG6SxO9Mbuc9v24EMadvv
         Knk+C1Mk4tAK566At3i/MFQtTJZzaB18lGGgcA99nHygmSOVRVm09Pek+MqQp9y2QonI
         aoow==
X-Gm-Message-State: AFqh2kqU1wEAab4Cn5WtSVIERfdc7G1L8r77182aVOInj1TwxY39H/j5
        O6j/iiSp/9hsh/zFYtcPy6T2NA==
X-Google-Smtp-Source: AMrXdXsxPtBfJ2yhCEFV7jgfVbDZJ4zEnmdJgwY/fXZ8EruCYvaNWOFlrqmk9onvRakIQ2QISugdbQ==
X-Received: by 2002:a05:6a20:a6a7:b0:b5:c751:78ac with SMTP id ba39-20020a056a20a6a700b000b5c75178acmr780704pzb.2.1673235003564;
        Sun, 08 Jan 2023 19:30:03 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ik9-20020a170902ab0900b00183c67844aesm4858264plb.22.2023.01.08.19.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 19:30:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>
Cc:     Dan Carpenter <error27@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Y7iFwjN+XzWvLv3y@slm.duckdns.org>
References: <Y7g3L6fntnTtOm63@kili> <Y7hbYPSdLqW++y/p@slm.duckdns.org>
 <9ac3390c-055b-546c-f1f4-68350dfe04f8@kernel.dk>
 <Y7iFwjN+XzWvLv3y@slm.duckdns.org>
Subject: Re: [PATCH block/for-6.2-fixes] block: Drop spurious might_sleep()
 from blk_put_queue()
Message-Id: <167323500264.3803.6715346209932603598.b4-ty@kernel.dk>
Date:   Sun, 08 Jan 2023 20:30:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-cc11a
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 06 Jan 2023 10:34:10 -1000, Tejun Heo wrote:
> Dan reports the following smatch detected the following:
> 
>   block/blk-cgroup.c:1863 blkcg_schedule_throttle() warn: sleeping in atomic context
> 
> caused by blkcg_schedule_throttle() calling blk_put_queue() in an
> non-sleepable context.
> 
> [...]

Applied, thanks!

[1/1] block: Drop spurious might_sleep() from blk_put_queue()
      commit: 49e4d04f0486117ac57a97890eb1db6d52bf82b3

Best regards,
-- 
Jens Axboe


