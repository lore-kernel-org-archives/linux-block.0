Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F39C4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 14:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKBOf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiKBOf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 10:35:56 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069FA2A24A
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 07:35:55 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id o13so3200434ilq.6
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qz6ea+Kr8k2MiaKZRozhl4QfX9wlsZ49scAW5YgmpE8=;
        b=bXDUwcGlpoxz37InLUAP4K3juVLgX9H9o2uH3oek7Ir5N65Vab9M9WHD5giL4IVT6e
         kdV7yZ9lLG9FpzZKaxdMLBfL1VHTMo7OkW0+J7nOIUByYy+LyRYgXjS1Hsv9xXNoe9os
         5NNq+XXL8BDRiduDgqr/QmHvGJKhH3YtaynMzHWkaz225Bs3r2rYtWbUWhFCftWRSK0r
         2tVprrlPWYdHFMC0tm+dDjb9AiHRgMZbWiUDqN+yPYIk+AnEXqkvc7EsSSqURDrjPkMR
         XpZVxQlzDo/1u5Z/H3uxPt+JQesFceCqopobWYujLZqgrDbImVovUabBQyhb0y4amf9E
         194w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qz6ea+Kr8k2MiaKZRozhl4QfX9wlsZ49scAW5YgmpE8=;
        b=JEpzpjVXJqu3tc//+xKiFoSqpnFgUoTcZM+qSPSs68JXm/tUrvQ3YC33aRhjldQyHs
         6DJ9rJwMgSnjqUfcEClxLbWO1s07vE+AuHBbRZo60LpVyLUhsjLOktom5o2z6DPcbBiy
         GeX9CXccb/VKD7Cc26U6ijufTkiig1ZUjp5xO2aNslFYppY2VthX3W4LDxa4dsdHCpJo
         0mLaqN4yAItz40xf3LXPyGPS0KwvDEmZxhuN7OZCHzBOpzYLHC/u0Gt81ElA2AO/FBzU
         Nto4lQPp9sQ6zGlDpJLMUzaDBQAkBh32JHLA0pWvb5axfJJy9L5vnYaQR3DIzmGrGDIo
         8rLA==
X-Gm-Message-State: ACrzQf2wWBfrJzZAY5geILhXsrGkodl/B/kS7hfpS7uolEiggLUiUht9
        ss2IyIWUgIQ7Jm5VaF8C5cLktg==
X-Google-Smtp-Source: AMsMyM76hs7+c9NebQPMkC81RNNN+f4ouHprG2iYyY7hXqgOWCzUfCf4ildt0w7TEmJBi6sZE8AvOQ==
X-Received: by 2002:a92:6912:0:b0:300:c48d:19cd with SMTP id e18-20020a926912000000b00300c48d19cdmr5975428ilc.216.1667399754142;
        Wed, 02 Nov 2022 07:35:54 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id ca11-20020a0566381c0b00b003711ce0dc15sm4978244jab.68.2022.11.02.07.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:35:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20221101150050.3510-2-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de> <20221101150050.3510-2-hch@lst.de>
Subject: Re: [PATCH 01/14] block: set the disk capacity to 0 in blk_mark_disk_dead
Message-Id: <166739975247.45121.7499768633850018123.b4-ty@kernel.dk>
Date:   Wed, 02 Nov 2022 08:35:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 1 Nov 2022 16:00:37 +0100, Christoph Hellwig wrote:
> nvme and xen-blkfront are already doing this to stop buffered writes from
> creating dirty pages that can't be written out later.  Move it to the
> common code.
> 
> This also removes the comment about the ordering from nvme, as bd_mutex
> not only is gone entirely, but also hasn't been used for locking updates
> to the disk size long before that, and thus the ordering requirement
> documented there doesn't apply any more.
> 
> [...]

Applied, thanks!

[01/14] block: set the disk capacity to 0 in blk_mark_disk_dead
        commit: 71b26083d59cd4ab22489829ffe7d4ead93f5546
[02/14] nvme-pci: refactor the tagset handling in nvme_reset_work
        commit: 0ffc7e98bfaa45380b800deeb9b65ce0371c652d
[03/14] nvme: don't remove namespaces in nvme_passthru_end
        commit: 23a908647efade186576c9628dd7bb560f6e759b
[04/14] nvme: remove the NVME_NS_DEAD check in nvme_remove_invalid_namespaces
        commit: 4f17344e9daeb6e9f89976d811a5373710ed1f04
[05/14] nvme: remove the NVME_NS_DEAD check in nvme_validate_ns
        commit: fde776afdd8467a09395a7aebdb2499f86315945
[06/14] nvme: don't unquiesce the admin queue in nvme_kill_queues
        commit: 6bcd5089ee1302e9ad7072ca0866f0c5a1158359
[07/14] nvme: split nvme_kill_queues
        commit: cd50f9b24726e9e195a0682c8d8d952396d57aef
[08/14] nvme-pci: don't unquiesce the I/O queues in nvme_remove_dead_ctrl
        commit: bad3e021ae2bb5ac9d650c9a04788efe753367f3
[09/14] nvme-apple: don't unquiesce the I/O queues in apple_nvme_reset_work
        commit: 2b4c2355c5e155cdf341d9ce2c2355b4b26c32c9
[10/14] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
        commit: 8537380bb9882c201db60a1eb201aac6e74083e8
[11/14] blk-mq: move the srcu_struct used for quiescing to the tagset
        commit: 80bd4a7aab4c9ce59bf5e35fdf52aa23d8a3c9f5
[12/14] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
        commit: 483239c75ba768e0e2c0e0c503e5fc13c3d5773a
[13/14] blk-mq: add tagset quiesce interface
        commit: 414dd48e882c5a39e7bd01b096ee6497eb3314b0
[14/14] nvme: use blk_mq_[un]quiesce_tagset
        commit: 98d81f0df70ce6fc48517d938026e3c684b9051a

Best regards,
-- 
Jens Axboe


