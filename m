Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7D9EB64D8
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 13:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjFTNUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjFTNS6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 09:18:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4401994
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 06:18:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-66872dbc2efso759332b3a.0
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687267104; x=1689859104;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGyDV6BAlg2AW/b3jzXgRhCmGRr6ZLpwHtOc10fjN3o=;
        b=j+JSnZaHENkk6/gyOUztdn3Bz7GVJiGgbR2rn91th1p+H5cIq6OskGo/CrHrzH9r0J
         3Q1kk3beuF8Ihyxzi2rUZMUPd18f9Xb0O0Y9TxLQOYvOky1Ko3gULNob6mFcjeBSc0vb
         5ANtL2EhMJaAg+0fY1UoylFmGteRl/0e8eV6bcU9L9t/K80CpFtePvT2e94HOplf6w9b
         OZJymRSOdf+uLxDObA6QxLhzb+gc6CLrf/CBJ4Bj271Ifma7t6oZzp2qPqhDijr90syL
         tyzXj/Slr11cRhbQt/iMIKclr3q+y1FhNqAcKNhPPq4TH1fzw7E4NNz1d3NAxjupdPXC
         zgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267104; x=1689859104;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGyDV6BAlg2AW/b3jzXgRhCmGRr6ZLpwHtOc10fjN3o=;
        b=GadSEFqUdlFGBTwTwtetMBrHi8xFrXLx9f+HI/7OWjhfjdL0drWDdBKtFvalpIsaFw
         Glb46SGoMUQOugMYWjkae3VZiB6BWBkOCOizZCedCb3vvqRRQb2C8TTABy7f3bsi7RKz
         99F1P0HX/Utk4iPisgMrb4XMvyDPBnXmbZ1f7HB2C/bCZgrla9h0ni9njPJOXUBIg99S
         o8vP0pemDNxzisBJXM4LUb98KjejvS8bNKtyCj7n28I7WCSDaKvoWpuARgBsVNt8m3lz
         pBLO9k2iX4Ed6juHgCjzjvqrltZI3fZaO4BRFYaspQgTgu7AnU1sdozMUD4vFXw3uqRn
         oVdg==
X-Gm-Message-State: AC+VfDxVlbmarwP1MZic94OIUtSknae3zBBC+epYthzIhQqiGfnIImIP
        iGRksQD8gyr8EH/sCi017iq2ew==
X-Google-Smtp-Source: ACHHUZ5gYPvoG00x00nmpR0yqB5Lt+RQG9FPGP61KvB/cZ+yjJBGT7Mb+6dVhaCB8APIEa2UxlxcJQ==
X-Received: by 2002:a05:6a20:a10d:b0:121:84ce:c629 with SMTP id q13-20020a056a20a10d00b0012184cec629mr8053947pzk.0.1687267104438;
        Tue, 20 Jun 2023 06:18:24 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r23-20020a634417000000b005143448896csm1399994pga.58.2023.06.20.06.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:18:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, brauner@kernel.org, dsterba@suse.com, hare@suse.de,
        jinpu.wang@ionos.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230618140402.7556-1-yukuai1@huaweicloud.com>
References: <20230618140402.7556-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next v2] block: fix wrong mode for blkdev_get_by_dev()
 from disk_scan_partitions()
Message-Id: <168726710308.3595534.13269294720973239157.b4-ty@kernel.dk>
Date:   Tue, 20 Jun 2023 07:18:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sun, 18 Jun 2023 22:04:02 +0800, Yu Kuai wrote:
> After commit 2736e8eeb0cc ("block: use the holder as indication for
> exclusive opens"), blkdev_get_by_dev() will warn if holder is NULL and
> mode contains 'FMODE_EXCL'.
> 
> holder from blkdev_get_by_dev() from disk_scan_partitions() is always NULL,
> hence it should not use 'FMODE_EXCL', which is broben by the commit. For
> consequence, WARN_ON_ONCE() will be triggered from blkdev_get_by_dev()
> if user scan partitions with device opened exclusively.
> 
> [...]

Applied, thanks!

[1/1] block: fix wrong mode for blkdev_get_by_dev() from disk_scan_partitions()
      commit: 985958b8584cc143555f1bd735e7ab5066c944a7

Best regards,
-- 
Jens Axboe



