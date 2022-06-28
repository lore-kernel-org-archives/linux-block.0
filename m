Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F7DC43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 12:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbiF1MeB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 08:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiF1MeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 08:34:01 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C502BB2F
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 05:34:00 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r66so12090257pgr.2
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 05:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ncZu9QeNwesIDvwuN0nRCa+RA4zJPygz1FbKAHuDk4Q=;
        b=jlQBg4GA+qGByflsaNY5PFzYbkUmR/b3BXo6EoWEkKBfPBj6XEyuagbfqQ2Y6GtaKC
         xj0VPvOSrJ++NwFL+GZdK3hBw8B2iPf1jFQMROcamc7J7WAhzMSJwMHg3wglRn9Oakg2
         XSI7COhBcWJ5EBfinCDcjbGricNccTkhOxtLxkD+aqj1rDIKZPCT1oX9uct+tHhSPL5y
         ZCFUcjC+VRRsYNs+8VA6E9hDWg4AXKwBabHXqs9LpKxun0CICR4KZCRJa/GHHfhrDmK0
         riikK3Rqa9xZUz6VyQN8XycZlMB0kvJ5q5grcaQ++O2FwGLZwylWhKVvjdAgWZf5cHko
         47SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ncZu9QeNwesIDvwuN0nRCa+RA4zJPygz1FbKAHuDk4Q=;
        b=PSRmWbJ4xxnsn80zwe5fHCrrlWkNffAbJK7TvVWQ0Slui/PQ7AolygD60I95w6z0ci
         9XaBgzZi+apVzW7mLE9x3/48ymfDIU/XESItZjmdZMEVG+rdud1c1YokCURcZv2kF3LD
         IBXApGErCQgPOTzEwDSR24jgTFdLXVLm3PuqD5Uy4Z1hPnOHX+msZIk3F6fdNC/hrqKx
         TSxFIKAbFVYZ/ycdDh1H3kwNdZs61vz1A4EDYlOtNMeiDLt7Gmpa0Wg6wP5HPQR3YJzE
         7ovrzYz2ElNuZQs3e8gKGcUQsgt7/y3/DURD0nNg3yBWSINw9edSYIwNfwRja1a9urm2
         4csw==
X-Gm-Message-State: AJIora9Ap064KMHxzzYwHVTflYvph0NpcDDvbB9eB//O64zorlIgcgIk
        dWibokaAgPdGUJWpnfOOVk3z6/3kTWwhfQ==
X-Google-Smtp-Source: AGRyM1tSBw/Wzhr4QKN2zaKAMN/YDQAriRlpQy5Q5I6ZCXnhryz8b/YONBvaJl3yj1HZM+nmgvWYRw==
X-Received: by 2002:a63:6b0a:0:b0:40d:ffa6:85c5 with SMTP id g10-20020a636b0a000000b0040dffa685c5mr8789089pgc.327.1656419639692;
        Tue, 28 Jun 2022 05:33:59 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t19-20020a170902e1d300b0016a16bd25ebsm9116127pla.36.2022.06.28.05.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:33:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
In-Reply-To: <20220619060552.1850436-1-hch@lst.de>
References: <20220619060552.1850436-1-hch@lst.de>
Subject: Re: fully tear down the queue in del_gendisk
Message-Id: <165641963896.1239145.5148845838882380394.b4-ty@kernel.dk>
Date:   Tue, 28 Jun 2022 06:33:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 19 Jun 2022 08:05:46 +0200, Christoph Hellwig wrote:
> this series simplifies teardown for most block drivers.  Right now they
> also have to call blk_cleanup_queue after calling del_gendisk, making
> the teardown process rather confusing.
> 
> Instead this series records if the request_queue is owned by the gendisk,
> which is always the case except for scsi and dasd or queues without a
> gendisk at all, and then does the entire teardown in del_gendisk.
> 
> [...]

Applied, thanks!

[1/6] mtip32xx: remove the device_status debugfs file
      commit: ec5263f422a3364442e0db2d9c2866d9154cbcc4
[2/6] mtip32xx: fix device removal
      commit: e8b58ef09e84c15cf782b01cfc73cc5b1180d519
[3/6] block: remove QUEUE_FLAG_DEAD
      commit: 1f90307e5f0d7bc9a336ead528f616a5df8e5944
[4/6] block: stop setting the nomerges flags in blk_cleanup_queue
      commit: 0e3534022f26ae51f7cf28347a253230604b6f4e
[5/6] block: simplify disk shutdown
      commit: 6f8191fdf41d3a53cc1d63fe2234e812c55a0092
[6/6] block: remove blk_cleanup_disk
      commit: 8b9ab62662048a3274361c7e5f64037c2c133e2c

Best regards,
-- 
Jens Axboe


