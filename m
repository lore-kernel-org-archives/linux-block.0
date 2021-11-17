Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3829C433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 04:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9683861B30
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 04:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhKQEOj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 23:14:39 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:42805 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhKQEOj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 23:14:39 -0500
Received: by mail-pf1-f170.google.com with SMTP id m14so1389468pfc.9
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 20:11:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bjo6JYh6swD0+7pP1y5ezzsjdxB7C1Snz29o1nBUET8=;
        b=XsB9I4+h4BPlqYZIVTSsIFvEz4m9pm7vnWzGuksoNhuoCANdtCvbX/0Ok9nlLynunl
         CvuCn25YzzmsefsvRUfw+FbdgVc8d7vSEQDKO/FseebrgX6iWAN4eUcvZQkpZPXou6J1
         aVPGKA93IENJ070UhHEvT6soHMlPnUAFjiGfV5D1zixMZh+KRWFbcheKlnf2jclYKV05
         i+jSbM2Ei4r49ObIihpGbY9t1KReLGT8C02sr3itChGhLs5pFs5BZNlgOVkcBSPFIDu7
         ELrlyVjjf/Nz90LJg2KhC95Cr8O2OTca0By673cFnSru+8TnNLva9Fs8O0UB3S9JLY8X
         JjHA==
X-Gm-Message-State: AOAM531JDGhfkOPhZgmtYhuokR1XCcP7vmGXw/77bwmA6YjZLnMW2hZh
        EVUZL0HiF6xkua8wZdpL3l2xMEs5fDI6DQ==
X-Google-Smtp-Source: ABdhPJxdovCRZWHCUQmOXeEIepOsGeHCMeOPUMgMASc6+IqAP1LSKlMrUCGgVueBcWmjWd+R1CZCrA==
X-Received: by 2002:a05:6a00:1150:b0:4a2:7328:cce6 with SMTP id b16-20020a056a00115000b004a27328cce6mr36018798pfm.67.1637122301246;
        Tue, 16 Nov 2021 20:11:41 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id ng9sm4111639pjb.4.2021.11.16.20.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 20:11:40 -0800 (PST)
Message-ID: <59cb2cfd-3890-9fb4-9e77-a4b084d088e9@acm.org>
Date:   Tue, 16 Nov 2021 20:11:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [QUESTION] blk_mq_freeze_queue in elevator_init_mq
Content-Language: en-US
To:     yangerkun <yangerkun@huawei.com>, ming.lei@redhat.com,
        damien.lemoal@wdc.com, axboe@kernel.dk, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-block@vger.kernel.org, linux-mtd@lists.infradead.org,
        yi.zhang@huawei.com, yebin10@huawei.com, houtao1@huawei.com
References: <d9113bf8-4654-cb04-f79c-38e11493cb2c@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d9113bf8-4654-cb04-f79c-38e11493cb2c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/21 19:37, yangerkun wrote:
> This commit add blk_mq_freeze_queue in elevator_init_mq which try to
> make sure no in-flight request while we go through blk_mq_init_sched.
> But does there any drivers can leave IO alive while we go through
> elevator_init_mq？ And if no, maybe we can just remove this logical to
> fix the regression...

Does this untested patch help? Please note that I'm not recommending to
integrate this patch in the upstream kernel but if it helps it can be a
building block of a solution.

Thanks,

Bart.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ab34c4f20da..b85dcb72a579 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -167,6 +167,7 @@ void blk_freeze_queue_start(struct request_queue *q)
  		mutex_unlock(&q->mq_freeze_lock);
  		if (queue_is_mq(q))
  			blk_mq_run_hw_queues(q, false);
+		synchronize_rcu_expedited();
  	} else {
  		mutex_unlock(&q->mq_freeze_lock);
  	}
