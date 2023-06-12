Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC18C88CB2
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 15:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjFLP4s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238401AbjFLP43 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 11:56:29 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD00E5
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 08:56:28 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77ad566f7fbso43538439f.1
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686585387; x=1689177387;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDv2++4y4WHcpliO9UwrmYpCoiXZ+M28TkOhP00UkEw=;
        b=D6ZmOLjyzxaHcs6eQLunqJpIwEWY7jErsCxy4YXZMy8YUeZa4hC1v4nWBjFjlgxiat
         F4GFarXBrfWyPoPZyNzH+cJBZos7Piv33/NrTfWCsqlHS+ZBjj77NTbAUvlbw4S10Kqr
         x8lr/AdVbZ1LodiLsSh9jMSHosmau+wYeR2MAH6wj1a3dDfyQ/dhaHEIuS3Fcs+1yFZL
         pgQtLAloz6it7Hj7JSHGme8c3777opKpREUanyhWMdJP1uDdFU1MI/TLW3qnE4RdHE+h
         xll2x/dOweKwGT6+jmP9wT3P0IMeGcAZ4/dUGGb/gPST0A5cgfY+axrLhDng7037RBYp
         wmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686585387; x=1689177387;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDv2++4y4WHcpliO9UwrmYpCoiXZ+M28TkOhP00UkEw=;
        b=NBC/wpjY45KUJsKN8jjqh5QSqZyZi1n/MO1XzknFJY8Rsov0wxZuA4CTv745x3dsWd
         a4XLoY/sBc68x5su0uI0/G8/QQZAQXc8PWLF93qWM4qvvUs2B9qNPMszTJ5WgjcNVPnS
         RNyMRliGXFgnrl85X1HXnLNdzedDa6FdVMPZVwqmUqbIUxvYr06I7tViD7HWRNu2Mkrx
         a/btjt0FH3iGTi8/51TAwsod66A3OHtcBQl8xHZcVHYKH5B4qqw48LFoBOIMU1h+U/Jo
         Q8hC8KjQ/xWQWm7laG3wbQxT9eGkLQStMyIk3XJXcN6kcdd6TDiod4WpgxSyhhbIdKe5
         3wlw==
X-Gm-Message-State: AC+VfDwQ6qRgJcj7HDJLA6/SkO9Vwybc47zR1ZBdWa8bvFCIkePqSzX4
        IUQBcicMyBvaoPzsarwueHDbEw==
X-Google-Smtp-Source: ACHHUZ5D2TB3x2QAL8IlcUNXKrqNOABHBJlGyqgh/qrlzc8p3NCE7wnJM6hOjxnkWc1Joo8I6QmbEg==
X-Received: by 2002:a05:6e02:1a2c:b0:338:4b36:5097 with SMTP id g12-20020a056e021a2c00b003384b365097mr6968899ile.1.1686585387673;
        Mon, 12 Jun 2023 08:56:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m10-20020a924b0a000000b0033355fa5440sm3291980ilg.37.2023.06.12.08.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:56:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, qiulaibin@huawei.com,
        andriy.shevchenko@linux.intel.com,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230610023043.2559121-1-yukuai1@huaweicloud.com>
References: <20230610023043.2559121-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next v2] blk-mq: fix potential io hang by wrong
 'wake_batch'
Message-Id: <168658538673.969588.639148205003839147.b4-ty@kernel.dk>
Date:   Mon, 12 Jun 2023 09:56:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 10 Jun 2023 10:30:43 +0800, Yu Kuai wrote:
> In __blk_mq_tag_busy/idle(), updating 'active_queues' and calculating
> 'wake_batch' is not atomic:
> 
> t1:			t2:
> _blk_mq_tag_busy	blk_mq_tag_busy
> inc active_queues
> // assume 1->2
> 			inc active_queues
> 			// 2 -> 3
> 			blk_mq_update_wake_batch
> 			// calculate based on 3
> blk_mq_update_wake_batch
> /* calculate based on 2, while active_queues is actually 3. */
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix potential io hang by wrong 'wake_batch'
      commit: 4f1731df60f9033669f024d06ae26a6301260b55

Best regards,
-- 
Jens Axboe



