Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E516C05027
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 15:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBFPoi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 10:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBFPoc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 10:44:32 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621F42A146
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 07:43:56 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y2so4584803iot.4
        for <linux-block@vger.kernel.org>; Mon, 06 Feb 2023 07:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbOVsyDnCoY8+Err5r/y+UvRFXZXBfg2HkGKIlPU+Fo=;
        b=ew2jxCNQwWb/7yzKjfuSwmhAJlRlz0tbCl2vsaARsz4xL4QxjFT2pnxc2+BqtNcoRI
         f1rY67N6VRaaQqZsCNTZTSFzuZsr1M+CEnDRfeldORqAwR5x8nVj4oTUGgz2OV5lgUMc
         Z0X61uwIBORDGqCeJtQg1Z+Jd2/tOTaN+jb/ZIlGzIPbRFgjapUn/fp+0hv/JXRKm82G
         f6VQ1hOlhVrwlUGLqg/tS4p8vgvDWduVrmhAb5FpCksFZnLR5yFnGZh6Wy/WfP9FpVTp
         zcaldGBbpcl3JTya9YEAUOY7/yWJgn8fzULtlzk2oXgniAKre8A5kY6XbAlPtKZr2U4P
         0Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbOVsyDnCoY8+Err5r/y+UvRFXZXBfg2HkGKIlPU+Fo=;
        b=N+LllTz7y5IYZaPOc+Fm87U8hQBmHnY96tRhQL/uMCO23974BExRV2f5VbqEybdAuM
         NMXRJSa+FKwRUE0+FQx7SrVnnjGEgsP+Ujr9Fqp5UHVgGQGkQHYKzJDUStRFu97EHZDh
         miMo2DUJFakORl3VNivHreB00LX1Pb6Qqu6lAPFKm8y4rN2bBuOZKgmtx9WQ7U1roKq1
         IMy9xBWmDtFILvqI30WUURMylVw22WmSxzgDz+bM0tBCPQu2w8aFnR3NidaLDaI8/oEb
         zZf/k9A2ZxJCbx9LTqM7MiaPuHZYFKrXoLxhLTgEFAzc9H1WLxoddneCe4QNVCltx2wo
         iKaw==
X-Gm-Message-State: AO0yUKXf3K6KhYkxwmtzOCAOjhsif9kIRjSfwzKJ+B09FJTTqILSxMc2
        pzgY7gfIJcd6V1no0IVK6azKUeJZg2jUYCUi
X-Google-Smtp-Source: AK7set94a0Im3hoYbQ5+bq97ghKzgKqFSZuCj8Z57SQF2ik6+e7qNWwPBZRIm1sTIuVmxgWfnvO7Bg==
X-Received: by 2002:a5e:de07:0:b0:716:8f6a:f480 with SMTP id e7-20020a5ede07000000b007168f6af480mr13592446iok.0.1675698234087;
        Mon, 06 Feb 2023 07:43:54 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f20-20020a056638119400b003a60da2bf58sm3525617jas.39.2023.02.06.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 07:43:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
In-Reply-To: <20230206150201.3438972-1-hch@lst.de>
References: <20230206150201.3438972-1-hch@lst.de>
Subject: Re: [PATCH] blk-cgroup: fix freeing NULL blkg in blkg_create
Message-Id: <167569823336.16197.3510051673541208273.b4-ty@kernel.dk>
Date:   Mon, 06 Feb 2023 08:43:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 06 Feb 2023 16:02:01 +0100, Christoph Hellwig wrote:
> new_blkg can be NULL if the caller didn't pass in a pre-allocated blkg.
> Don't try to free it in that case.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: fix freeing NULL blkg in blkg_create
      commit: 28e538a3093833cbac3e28dd511a8b74629d737a

Best regards,
-- 
Jens Axboe



