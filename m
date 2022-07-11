Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B99C43334
	for <linux-block@archiver.kernel.org>; Mon, 11 Jul 2022 13:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGKN5T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jul 2022 09:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGKN5S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jul 2022 09:57:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9C561B08
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 06:57:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b2so4498977plx.7
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=4BDmuvmLC+MAzqCPtJlOslwKnjdM2U9zITj+MEW5baM=;
        b=P+eHot1DvZbd7vBZG6f+rqXYFm4G7zcJvtho1ykvtpWTGws+TLX8cxOYfIsdH4ZzgJ
         eu9yETZlnLjXxfis90Ed9PLUd7Wo0zceCvDHRcs2w3yKXHFJGw0lOyRB/R+xT8VizaZx
         M1DWdFn/3G7arywhBb7GfLz6kni2GHB2JdO14izP4STr182pui9ZDd+l70+jot6vXQ7F
         TxK7AzgU5w0CZ/MVyd4JXJGoiESFvGbbCG29JhPItPzULisqLfEX8qPwUXZ8OHFKx7I8
         e+k8xz4YB4hT/GBMB8MsxmWj1BFoSn9KqBhJ2Jqan+0QBX0iP+W9TNQ3hnS9C56nmKeN
         SAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=4BDmuvmLC+MAzqCPtJlOslwKnjdM2U9zITj+MEW5baM=;
        b=5RsmWcKSn5tLo7ZXaG6EgOusIU/teCW5VFtR97/GEge1q1P5R3zFwKowpOkXiqzt1t
         CYchxx/QUvtqmRaIjLNIy7Su8u5aTQlR/C7yHocR4+RyvR2jsx9xsjEI3zO2WHl311vG
         Bliergrf6eKmJwDBPXe6Uv7ivJkRzmoBi1peBI+EW3DNPvLPZ9R5UqhKoCPr/nMGpMZu
         velZhBZ5WaqVJaeN6UrVT6FL6tTH7CTLyUTiz5G1ADr6n9FByjLvbmFRJldJotifY7Wl
         NWUiHOb7K+ISjopgscUvKuOPQiVRtg3CjdwMEraMcanrxvyWrgb7LrQpCFGdiuI9clMM
         Qg2Q==
X-Gm-Message-State: AJIora/wLNjVsmfG32Ws2pMzD+f/JZXnp+JTEF1aUnoMcDXG9FfSpEVs
        CvNsCKpuEm38FEfIXv00pZXU9l5rFrJ+wQ==
X-Google-Smtp-Source: AGRyM1tb0WzcNh6t+J729LyVurkoWQ6j58sSlUOF/dVu9IT05NVK6RLVPJlu5UP2zx0PJbQFWH+eCw==
X-Received: by 2002:a17:90a:fe4:b0:1ef:8564:4f4 with SMTP id 91-20020a17090a0fe400b001ef856404f4mr18059016pjz.118.1657547837256;
        Mon, 11 Jul 2022 06:57:17 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b0016bf28cc606sm4727537pln.156.2022.07.11.06.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 06:57:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     yi.zhang@redhat.com, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
In-Reply-To: <20220711090808.259682-1-ming.lei@redhat.com>
References: <20220711090808.259682-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: don't create hctx debugfs dir until q->debugfs_dir is created
Message-Id: <165754783650.7917.5694202019226561843.b4-ty@kernel.dk>
Date:   Mon, 11 Jul 2022 07:57:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 11 Jul 2022 17:08:08 +0800, Ming Lei wrote:
> blk_mq_debugfs_register_hctx() can be called by blk_mq_update_nr_hw_queues
> when gendisk isn't added yet, such as nvme tcp.
> 
> Fixes the warning of 'debugfs: Directory 'hctx0' with parent '/' already present!'
> which can be observed reliably when running blktests nvme/005.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-mq: don't create hctx debugfs dir until q->debugfs_dir is created
      commit: 52b0e38ae7985386d5b5e4653cc20fc2c6c95ce9

Best regards,
-- 
Jens Axboe


