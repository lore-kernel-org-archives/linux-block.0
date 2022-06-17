Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F09C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 13:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiFQNbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 09:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiFQNba (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 09:31:30 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EE6CF5
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 06:31:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id w29so4069147pgl.8
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=0ofgUTDXejw/stkJnliERbhPvuNdkIVVYb65LS+lZxI=;
        b=JErvVNAf2ggPU6BgDGKtrm0hp7KNlNy0Jd/WCNoc5MI6IhqvILFNNMsfZF2pNneQH9
         C9ZNxji1NTS2JMFGlJJ5QbzLvBviehj/JTHTyhVc0lF5dzb0dbmcm7/S0AQAYbiKeZdX
         T17/FiovYsMhB9tRBUWCOvzfobFTnHahmLpklsPQWJ2GQRPAweX0dNo7AtjGWkyjJ64X
         8nqkNKfO2CayhrfsVIWzbAn4GKWBnLvI7tpsv86BTOqG77iMhGZt1N9bsj3npL0tMZzW
         LPkfx2coh+B47YE66pYR2sgqaYmgLkmGbTvHpw0RMBhmUcfrOkeO+n4wyagKmhGZ0hKB
         HrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=0ofgUTDXejw/stkJnliERbhPvuNdkIVVYb65LS+lZxI=;
        b=m3TqWZUsSOl5zQFOtcyf1kRgi2pRPvvfkHJsiedyBvCykM+Z9r9AWC6+LzXhjoCwZh
         15OqAwvwPclclNyeNdpoiFj3PIK4fLiAXo+jmgNxe8s6PjAM2OPnr3Oze6gXM4pdBqgm
         DQbIoPIGVquFuAE8c5hHQ7hsRrdjx8Zal+ORzJPe3wL9RNI8Tk4WluBP9eMbVK9Bte5e
         8EAErDq0hg+HXjDRcczOwgWIK5eLtu6wUX88hpM8YUsdUJIukCmhbQnmzTRoG7Ayt8pm
         OK2T75UtguB6sO6YsK3YB/Xh1LfM7RvlB3aGoImNU1NQexOy5uL5WkzBwsjzEhaAxdAE
         KsjQ==
X-Gm-Message-State: AJIora8rBgQbL1UbYY1TxLaroG+Sfzqt3r56sIqq0mofQ/ZW5HE9b58z
        4ZHSgMvx0PM0teqH0T7iyojLOTdxP7xEAw==
X-Google-Smtp-Source: AGRyM1urQHt8eb/aj4FiloRfY3pBEs5LzF7NvReIfkoVGFlQt+G/w/GBtLEHGhT05RM7EZ36PYKKpg==
X-Received: by 2002:a63:6a85:0:b0:3fa:722a:fbdc with SMTP id f127-20020a636a85000000b003fa722afbdcmr9114159pgc.174.1655472688420;
        Fri, 17 Jun 2022 06:31:28 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w68-20020a628247000000b00522c1146e90sm3716648pfd.118.2022.06.17.06.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 06:31:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        dan.j.williams@intel.com, ming.lei@redhat.com,
        shinichiro.kawasaki@wdc.com
In-Reply-To: <20220614074827.458955-1-hch@lst.de>
References: <20220614074827.458955-1-hch@lst.de>
Subject: Re: fix tag freeing use after free and debugfs name reuse
Message-Id: <165547268742.360172.6417506114396990966.b4-ty@kernel.dk>
Date:   Fri, 17 Jun 2022 07:31:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 14 Jun 2022 09:48:23 +0200, Christoph Hellwig wrote:
> the first patch fixes a use after free, and the others deal with debugfs
> name reuse that spews warnings and makes debugfs use impossible for
> quickly reused gendisk instances.  Both of those are rooted in sloppy
> life time rules for block device tear down.
> 
> Compared to the previous separate postings this adds a missing queue
> quiesce and documents debugfs_mutex better.
> 
> [...]

Applied, thanks!

[1/4] block: disable the elevator int del_gendisk
      commit: 50e34d78815e474d410f342fbe783b18192ca518
[2/4] block: serialize all debugfs operations using q->debugfs_mutex
      commit: 5cf9c91ba927119fc6606b938b1895bb2459d3bc
[3/4] block: remove per-disk debugfs files in blk_unregister_queue
      commit: 99d055b4fd4bbb309c6cdb51a0d420669f777944
[4/4] block: freeze the queue earlier in del_gendisk
      commit: a09b314005f3a0956ebf56e01b3b80339df577cc

Best regards,
-- 
Jens Axboe


