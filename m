Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03534C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 20:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiCNUZI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiCNUZH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 16:25:07 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAE033A00
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 13:23:57 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id p2so11893029ile.2
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=SJsceeI+x/18/bx+nnK2r3dBC17UiaTuZ4Tjl8b2uiU=;
        b=CTaH/p16a2Sxs97Dit9pUbwBat8DsAfQUdY95CWRgDTx5YYyCQyqaj6KRDL8Sskayz
         C8cuMCEVdrFRm45EkBZPyJndAVbYeCg5cKuEeEw547J6UUUYzjWIYoT5eGE/oN40A9P5
         6NGjeyn6gk3QYpLC/YA7NKD3p5hQMsGf5HfJ87meNOO5dA0m/gjZTYDXq09LKIXWwEVI
         j11xSkB4ZYlgapb7REdEe8rwZfwjeDWDiXwy2RAzrihzq5Z8g3mernKwT+x0FVlE78wf
         4sBfifsX9uV9zh8K0CmL+bwVEJf2KhWsKpacndB4P9bq8itVLyImeSr4qJhS6GM2I8Tz
         Bz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=SJsceeI+x/18/bx+nnK2r3dBC17UiaTuZ4Tjl8b2uiU=;
        b=L/m+wJxkxIHQbUE/rU8YXmCrgU6i0H2ouFnIjtDbn6Sp+/vvLGbIF3VcA+lzLUZnQN
         v185n23rlv5c4onGbndabA4+ua2m4GqTO2ozWqihDhNskJKsxa9q2U6dwPf++ap6o/kP
         FpJ+eqcRVpz+jlcMN7gdre0s3RYsoaiZO2FguS2rkmYj45SJG6Uq1eyyW3UrlNbHKx9O
         X1SBMaQJPvFpcdtSdBIL6AJQiJMJ7MXiEpgjp+sF2EEunfEpELc0zedRTjZCA/qGtl5N
         L1Arm+e8BXppGPVv3nCL9IOmXgHqmwWuRVCcPBRXaq5BoZPEJm8IF5jvi88aOKLxDziX
         T+SA==
X-Gm-Message-State: AOAM533BPGfd5ulVktiRzTTSfIjG1rIC9DzjPz5Hu9PizL6BbjnKCBoG
        S91vPstF9vScMzYi6VCbSD/c3A==
X-Google-Smtp-Source: ABdhPJzpRB0X86YH4PVUZTRije8pATz86fN/GG1G1V7Wkk6POPcEh8B+S61zsDs4Ys7WnT/w5eGMlg==
X-Received: by 2002:a05:6e02:1709:b0:2c6:6d6e:6dac with SMTP id u9-20020a056e02170900b002c66d6e6dacmr19664334ill.53.1647289436933;
        Mon, 14 Mar 2022 13:23:56 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g10-20020a056e021a2a00b002c780e4f32esm5711362ile.62.2022.03.14.13.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:23:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     syzbot+b42749a851a47a0f581b@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        stable@vger.kernel.org
In-Reply-To: <20220314043018.177141-1-ming.lei@redhat.com>
References: <20220314043018.177141-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: release rq qos structures for queue without disk
Message-Id: <164728943636.144820.16345673188217476627.b4-ty@kernel.dk>
Date:   Mon, 14 Mar 2022 14:23:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 14 Mar 2022 12:30:18 +0800, Ming Lei wrote:
> blkcg_init_queue() may add rq qos structures to request queue, previously
> blk_cleanup_queue() calls rq_qos_exit() to release them, but commit
> 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
> moves rq_qos_exit() into del_gendisk(), so memory leak is caused
> because queues may not have disk, such as un-present scsi luns, nvme
> admin queue, ...
> 
> [...]

Applied, thanks!

[1/1] block: release rq qos structures for queue without disk
      commit: daaca3522a8e67c46e39ef09c1d542e866f85f3b

Best regards,
-- 
Jens Axboe


