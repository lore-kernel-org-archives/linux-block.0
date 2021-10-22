Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D88DC4332F
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 14:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2D060EB1
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 14:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhJVOg1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhJVOg0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 10:36:26 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E08CC061766
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 07:34:09 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so4630553otb.1
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=cVIkN7spVzTPEdd4zRywRhu6vbYcErn5dveld+XryVI=;
        b=Ur+Mvyqn99O6jN3E0jkVFqf9805z10mp5/40B+7nLv9zqcmQ1CtMADHzRpLs+tQouB
         UFPUYS2LYRGvo8AWdiDb+XHhO2MccQWADs2k4dUKlDPdMZy0PHYKJ1eb2200+aJVer/W
         khdLrWcgTb0llVUws46pKoxPwywbciFj/dQ5tBAk3k2FQqiNhaOAqKRzLbMzR4csWDXE
         iPK6veZxA/M8/py/4GMM7BbTDO4uCb5OC1bskGUgWp9p+RGc7hQeVimEndbnGNIqgUgC
         missiNglxRjxPfT9+ySwNE7ysOfmHLU8v1nJdgIemhNu7TX2HGYIZc4x6yC8QUF+/fen
         +keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=cVIkN7spVzTPEdd4zRywRhu6vbYcErn5dveld+XryVI=;
        b=Nyco7oYQWZha+cyxpwa371Fe4zixBQcmLjRVWW3keiGt2Bs7xwvaAT9sqtsFs/++/k
         gcvQJMILd2CKY8f0rARYfj5C04QxgnVeePBAAnoMQdm5dWeT92pbn/rOlWeUyC+R/Beq
         xXnqM6P6n7h/hzQzBBnaTsGVzjQ9xL35bCrvYO2gw8kbnrWAbCXvj/Rl/L/uqlb6mexQ
         xpKJoyXdcgSTefyJ4DgWO1tregRMnIw6PUDAOwFJYiYj1t9vtmSL6RzUtwppT3bzkO+Y
         QVmglBTaV38T+YG6PRG47omkUjFSky7VQ0i481a6+a1zlZ1LJv9oty+9oKAZMmIvquXh
         EHJA==
X-Gm-Message-State: AOAM533hyUgzciuuLjCmb4I+AayFNdDrCe3+jD0qfoqaESbxnHv6jRvj
        7bJRkIXyCF1fbRlGs1sTf/7a/A==
X-Google-Smtp-Source: ABdhPJyuiPNrRYPNrfo5wVQ8g0bjX6wWrWnAp1uFHcyyQBUjTV6PXzqQvYbvXQUQdeR6vd8WU8y3HQ==
X-Received: by 2002:a9d:6d03:: with SMTP id o3mr201035otp.87.1634913248614;
        Fri, 22 Oct 2021 07:34:08 -0700 (PDT)
Received: from [127.0.1.1] (rrcs-24-173-18-66.sw.biz.rr.com. [24.173.18.66])
        by smtp.gmail.com with ESMTPSA id w2sm1490386ooa.26.2021.10.22.07.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:34:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-scsi@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20211021060607.264371-1-hch@lst.de>
References: <20211021060607.264371-1-hch@lst.de>
Subject: Re: remove QUEUE_FLAG_SCSI_PASSTHROUGH v3
Message-Id: <163491324565.82952.710827573154554710.b4-ty@kernel.dk>
Date:   Fri, 22 Oct 2021 08:34:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 21 Oct 2021 08:06:00 +0200, Christoph Hellwig wrote:
> this series removes the QUEUE_FLAG_SCSI_PASSTHROUGH and thus the last
> remaining SCSI passthrough concept from the block layer.
> 
> The changes to support pktcdvd are a bit ugly, but I can't think of
> anything better (except for removing the driver entirely).
> If we'd want to support packet writing today it would probably live
> entirely inside the sr driver.
> 
> [...]

Applied, thanks!

[1/7] block: add a ->get_unique_id method
      commit: 9208d414975895f69e9aca49153060ddd31b18d0
[2/7] sd: implement ->get_unique_id
      commit: b83ce214af3885437ff223b3a0c8ec6072a84167
[3/7] nfsd/blocklayout: use ->get_unique_id instead of sending SCSI commands
      commit: 8c6aabd1c72bc241c55f5b71a86cea5ef28bceca
[4/7] bsg-lib: initialize the bsg_job in bsg_transport_sg_io_fn
      commit: 237ea1602fb4cd14cd31b745a56fd0639c58eea3
[5/7] scsi: add a scsi_alloc_request helper
      commit: 68ec3b819a5d600a4ede8b596761dccac9f39ebc
[6/7] block: remove the initialize_rq_fn blk_mq_ops method
      commit: 4abafdc4360d993104c2b2f85943938a0c6ad025
[7/7] block: remove QUEUE_FLAG_SCSI_PASSTHROUGH
      commit: 4845012eb5b4e56cadb5f484cb55dd4fd9d1df80

Best regards,
-- 
Jens Axboe


