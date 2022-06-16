Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADE2C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 20:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiFPUqd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiFPUqb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 16:46:31 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471945B8AA
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 13:46:31 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id f7so1722369ilr.5
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=1Wmdzf+SLYFYEGaU0a/5wCQXv7pyOOyUVG5qJJuRfo4=;
        b=wqpwK0+4LV6EY76QXgDAWdHjseePl1YOWDrETi/zBrMqZRyWNOJ2ZSvHVHTkPj61OY
         iOP/cLiE371TtEEQNM7B5W/8UJEeTgbNVhvUFRpSfmHn6FbBT34eJe9OWNARC5Xz4hY5
         cySo7zzXMszzi6QBNPJG+g1ueOcS4DzF42zXZe6XO8IIn/Mhx3x3Tn0gmZm+EH3Gb34Z
         SThm5giGn5zPC/XP5buI4EevcMAUr8Tc/6Xv2lsuN0/rtSwrsyHBvZh6pK989pQhie91
         ZmD8G5nklMMY9bgXEyYqWo81udJfLqXfmssevOCdYLoMylduJWltjGx5Wh6JMQ5OZPb4
         yEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=1Wmdzf+SLYFYEGaU0a/5wCQXv7pyOOyUVG5qJJuRfo4=;
        b=Ltdnj/8RmiaILBAcRWxkR9Ln3cM3CwqOWZC8+ZDiUVjGa0JAYJdELIylfuuSr+B/eF
         KZ56GIfy6cuWc6icNw2Ubn6rH8MQxJ9FMQCehwLiel3W2ZnDDLfgxG2hCz3RSaEhy8H1
         LvbY6HMuAVC36pX47Zz4aF04lsX3WvzQ8g7J18H+k+L1wpPI6sODAbtBKXrpWyj/iG9x
         Xh2AUWdArnHQqeM+qDoHCL4+b2tlGF0PJUZdDQ/guFqBjXXyQdZX2LTEN8Z0h8XPa8xn
         Yl52YeVL4vCDdZy/zhrqdqeH5akVVk4mzJ10dNnjt5WmSG91IuWreOd+XMEz/f4c4QQZ
         seLQ==
X-Gm-Message-State: AJIora/jUcxY7Or6iGWgJRvm85N05uHSv+CBlmOEutMVVpALnQzujkVj
        nAsTaC6WU+biSKDMGLhFdxzw6NXBJX95FA==
X-Google-Smtp-Source: AGRyM1uiJW4X4BzWYsSvWF8i3foB7dItaVjBcF0izb5f/TxkYSKhybE1AC8UqRxhcbVFfRzD9FNX3g==
X-Received: by 2002:a05:6e02:1b0c:b0:2d3:bfdf:e3c5 with SMTP id i12-20020a056e021b0c00b002d3bfdfe3c5mr3962231ilv.138.1655412390462;
        Thu, 16 Jun 2022 13:46:30 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a2-20020a056638004200b00331850520c1sm1308954jap.120.2022.06.16.13.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:46:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220616014401.817001-1-ming.lei@redhat.com>
References: <20220616014401.817001-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3 0/3] blk-mq: three misc patches
Message-Id: <165541238980.250932.12751410043683500171.b4-ty@kernel.dk>
Date:   Thu, 16 Jun 2022 14:46:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 16 Jun 2022 09:43:58 +0800, Ming Lei wrote:
> The 1st two patches make referring to q->elevator more reliable, and
> avoid potential use-after-free on q->elevator in two code paths.
> 
> The 3rd patch improves boot time for scsi host with lots of hw queues.
> 
> V3:
> 	- clear QUEUE_FLAG_SQ_SCHED for none & kyber explicitly
> 
> [...]

Applied, thanks!

[1/3] blk-mq: protect q->elevator by ->sysfs_lock in blk_mq_elv_switch_none
      commit: 5fd7a84a09e640016fe106dd3e992f5210e23dc7
[2/3] blk-mq: avoid to touch q->elevator without any protection
      commit: 4d337cebcb1c27d9b48c48b9a98e939d4552d584
[3/3] blk-mq: don't clear flush_rq from tags->rqs[]
      commit: 6cfeadbff3f8905f2854735ebb88e581402c16c4

Best regards,
-- 
Jens Axboe


