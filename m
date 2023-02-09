Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A755C61DA4
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 15:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBIPNN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBIPNM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 10:13:12 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510A760E7F
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 07:12:58 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id r17so1497233pff.9
        for <linux-block@vger.kernel.org>; Thu, 09 Feb 2023 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRcENQKlVQ+rPzqeQNM0lqT4MIxN6FGTSLK6oawtu1Q=;
        b=BuJvBNNCU1jDek5dKJ/mVPzXGbu3QCMOSs9cMmsSfOH/StLOcY1azLT3EjATuWCMmh
         bMesjZzyucY2c2SKCDUOrb1JDXQBQ3EuCDtzzCpA5BD2U70GEqKs/JxA5Ih5PUe+6Dm3
         UySepf3Xn8ikWAonL+kYZtfhkpB7fdjnftdzVlo17I1ZMZxiD8Q36fy4oP8gcUP7IgnT
         1hPAI39h4g4rke6is6whBXC/DFDA7ARgGOSLjh84RshyQASAUtNP1ZYtmEnXhuJEd3BB
         C3IJwWV7i04YypZ19bGv4ZD9jnYYXsAt3pers4MDzOIMoqh0tt4JQzpqumOIaQl/jZGz
         Vwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRcENQKlVQ+rPzqeQNM0lqT4MIxN6FGTSLK6oawtu1Q=;
        b=29nCx+vwGuIfiph8eENf2wmLCa+Ovn/45usZ7bdUQ7dw7BdO7HusE9Jxah6M7gbGF4
         4mNT2mn3yO+ofUy18c7azfgqu/6KeGgayDDC3iL7FqxZOsvWRoi6Dyfx57RSSYxezSfN
         F7TZ3sRyBCly2EE+HwhorYLT6HCTc9dtf5vmfCvC7bxdP+KfmwaOs1/4JRwwvQnLmhrq
         bfcVORghAipG/wRp+618lJHeXlUbJ096I4+vpXhGpySq/gN0mRZctU/82Qc3gRobOKos
         mUumJpX+aBBG9M3fpYdBnAaDMPKPyaglxPCE/p6XG9fi1Krt9uB05ifs7otdf0Lih/cq
         llfg==
X-Gm-Message-State: AO0yUKUdi4sCENZAj9WIT4uAxL5dxHoVNCHgSd6ANRGoeNuDx+nFprtg
        OsODtb6pZgBTqxUUS3d8ATnVsg==
X-Google-Smtp-Source: AK7set9iwfG5hrjNx0rglj8nDdEBnwCahdPqmnDJd0/pJxrnSnFJ1d3jqQACEKbQVETgGtoaCR9M5g==
X-Received: by 2002:a62:828d:0:b0:593:fe34:96de with SMTP id w135-20020a62828d000000b00593fe3496demr9692920pfd.0.1675955577687;
        Thu, 09 Feb 2023 07:12:57 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78d43000000b00593906a8843sm1585716pfe.176.2023.02.09.07.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:12:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20230208063514.171485-1-hch@lst.de>
References: <20230208063514.171485-1-hch@lst.de>
Subject: Re: [PATCH] blk-cgroup: delay calling blkcg_exit_disk until
 disk_release
Message-Id: <167595557669.325128.2685542541646077531.b4-ty@kernel.dk>
Date:   Thu, 09 Feb 2023 08:12:56 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 08 Feb 2023 07:35:14 +0100, Christoph Hellwig wrote:
> While del_gendisk ensures there is no outstanding I/O on the queue,
> it can't prevent block layer users from building new I/O.
> 
> This leads to a NULL ->root_blkg reference in bio_associate_blkg when
> allocating a new bio on a shut down file system.  Delay freeing the
> blk-cgroup subsystems from del_gendisk until disk_release to make
> sure the blkg and throttle information is still avaіlable for bio
> submitters, even if those bios will immediately fail.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: delay calling blkcg_exit_disk until disk_release
      commit: c43332fe028c252a2a28e46be70a530f64fc3c9d

Best regards,
-- 
Jens Axboe



