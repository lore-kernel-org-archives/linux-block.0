Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDB0C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 19:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhKWT0Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhKWT0X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 14:26:23 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C46EC061714
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 11:23:15 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id k21so28641ioh.4
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 11:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=P0UlrE3JLYM2iRVLNwxEz7e2iIGzjeeB2wgi99A1a2M=;
        b=RLanxKZ8xUh4lVTw4pim7JethPsowsgBClppObeRNuNtVZRXf0SOkavNbkkXgCdyxw
         IuQxtzZm4Oco8X2SOXzLQnKlxL5d5U3gWuFZ2dwWd81Z7t3azfqP6C4lAOvqQl8pJsb6
         SeGoq8751ab/azktrQVB2Z9g2OsfEwKqA3w2CgweH8TmxM65MR61/vmrDVtC88Qu4A9X
         8dJ3DgIBYm/7nooA1NFWmwt1/NJPIJEQZ1zF/v3YEKrOZDDuRnNKfa+l1SmQYeq07e6Q
         S5KCDX35sfLPCUUziRwJ2xCRbDNeWZxpHMEJtqV1RubQVer4PMi2gVkYb64YexvO+T3Q
         m9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=P0UlrE3JLYM2iRVLNwxEz7e2iIGzjeeB2wgi99A1a2M=;
        b=Tt4G8wcERfRxNti6O9EvWL1wXQ1rGNtKoCBTmjKp19XXU0wCsgqMz4GXOLZze8CTop
         h7ZyV5Qkd5Y019eHpZjSjUulbBWqLnMvAqf8tRezz5tgVTYqCGJfBAoHXrLc16dn98dm
         YC3KoKHlhApEmBixRJozkRdK628xGoT0AUDqnATWoir3vPhPry3E489YJmCSbYpb6Gpe
         qBTM2UJunEZzZwISbawffGa8dMVCWmyFwZ/chmVcyar/Bv5HrKFqDv0WrXkEW0jiSxEi
         nyEkzfqZLRYAvB9eTBnZK1oAO58haHjhXhnV3bRt890GM5oAZG/1ZZRuZI66UcPfsNuo
         J8dQ==
X-Gm-Message-State: AOAM531Tc3ydSdKIY5G/jR5DxW9eGkcmhHja4lNudOrUQlH58evFVM9e
        TlMtDB9XryZjEV+oeLm1hF485ZqNSRPyPlfY
X-Google-Smtp-Source: ABdhPJxWqLnNT9uKLVt1MRPiZDNGc8diHt8sStCGOyok1pk2j+jDQMQtY7GiCJlLRal4n89GGU0YwA==
X-Received: by 2002:a05:6638:1348:: with SMTP id u8mr9210231jad.95.1637695394216;
        Tue, 23 Nov 2021 11:23:14 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i12sm9171820ilb.17.2021.11.23.11.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:23:13 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20211123160443.1315598-2-hch@lst.de>
References: <20211123160443.1315598-1-hch@lst.de> <20211123160443.1315598-2-hch@lst.de>
Subject: Re: [PATCH 1/3] blk-mq: simplify the plug handling in blk_mq_submit_bio
Message-Id: <163769539373.430487.11627407262608252937.b4-ty@kernel.dk>
Date:   Tue, 23 Nov 2021 12:23:13 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 23 Nov 2021 17:04:41 +0100, Christoph Hellwig wrote:
> blk_mq_submit_bio has two different plug cases, one that uses full
> plugging and a limited plugging one.
> 
> The limited plugging case is only used for a corner case that does
> not matter in real life:
> 
>  - no ->commit_rqs (so not NVMe)
>  - no shared tags (so not SCSI)
>  - not rotational (so no old disk or floppy driver)
>  - must have multiple queues (so no eMMC)
> 
> [...]

Applied, thanks!

[1/3] blk-mq: simplify the plug handling in blk_mq_submit_bio
      commit: bb5b684ffe6deb797ed36b2b323f747a5f7d1a2c
[2/3] blk-mq: move more plug handling from blk_mq_submit_bio into blk_add_rq_to_plug
      commit: da7bdd66a69b14d13ff8f9064efc524081e64335
[3/3] blk-mq: cleanup request allocation
      (no commit info)

Best regards,
-- 
Jens Axboe


