Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9A2C433F5
	for <linux-block@archiver.kernel.org>; Mon, 21 Mar 2022 12:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbiCUMgj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343891AbiCUMgi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 08:36:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AD41A3AD
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 05:35:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t14so10210661pgr.3
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=onACZXDZl27m156/eaOWifIBtRaPHqJh1NxL/lC2ubE=;
        b=f8hKHn4bycHX7tgjFWM7rZV0wYgU7rjKPTd9hyz9oT0IDRyWD1IsUn/3eXVGU2ehED
         0j3ouJR0OAovvWike0nVFzFydONMCKs/gS8OQ+QMHRj24d4kCscpmivK7tmpqwE4Ax9e
         shEP4xjzwduRBxi1lI2ZBN9gnMnFPRHnJXvbbMtrOYgGwrtEBDqDz64Mv31cNKPAxiFj
         PXXKI9H2tJCjNgHr44D8kVnMV7CSUDLowQXMlTyhuTqjiEb9JRy4RBfGFnVI6gj+pAYt
         DpEqiLdJta7a6UeQpvoD605rlvWB66PGCHtklIjRiy4UZkxAJNeUqEzDSa2CE08DQUbZ
         cwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=onACZXDZl27m156/eaOWifIBtRaPHqJh1NxL/lC2ubE=;
        b=UDwXO2+G+CcTbshpWXcZTmF5pgvgrBp5pRcTjClU2Atp4apuBoJkST5UtXG7c7MxC/
         nGW6SCiXPwMa3ZjX6bKQmU0LmKLLLKjK8VVLFeVUOavaIFm/wHy/HrxCoYf91n24PONA
         AdyBmqhLEH0ZV6QHd0cnbqh/Glzn8uAp+i3XFJMcQ4/7jjnShN3Qd23Lf5Qio6rLG4ls
         rE+CVWNSh0QxcP4N1nE28DU/CzIy2JgNSYH9ynvl6JEHAR62JUEclAX5lQ+pefrFH5tD
         50y8DNz/ixGDDRrmuNJYA8cIMnBoBOToFc9ztCcJWC735zCPpZCqgyrYaMA4iObmXGA8
         voOw==
X-Gm-Message-State: AOAM530SsfOi9CyL0RO9tcbqFKQ/WOOuSgV9xPShVzHD32Ot67/oW6dQ
        axdlb+mAY9Hsw5bnzYn/6UfDkQ==
X-Google-Smtp-Source: ABdhPJxckeVQLRmyNjwevGkNf2Fqh889Oi/PKU0Ewz6p/y2C5MRQXrM7GdtZ7A+tHByfDBUVTwAb4w==
X-Received: by 2002:a63:4448:0:b0:382:6f3e:a1d8 with SMTP id t8-20020a634448000000b003826f3ea1d8mr5546625pgk.334.1647866113035;
        Mon, 21 Mar 2022 05:35:13 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00218600b004f65315bb37sm20416382pfi.13.2022.03.21.05.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 05:35:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220321071216.1549596-1-liu.yun@linux.dev>
References: <20220321071216.1549596-1-liu.yun@linux.dev>
Subject: Re: [PATCH] n64cart: convert bi_disk to bi_bdev->bd_disk fix build
Message-Id: <164786611230.8280.1981884777773487370.b4-ty@kernel.dk>
Date:   Mon, 21 Mar 2022 06:35:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 21 Mar 2022 15:12:16 +0800, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> My kernel robot report below:
> 
>   drivers/block/n64cart.c: In function ‘n64cart_submit_bio’:
>   drivers/block/n64cart.c:91:26: error: ‘struct bio’ has no member named ‘bi_disk’
>      91 |  struct device *dev = bio->bi_disk->private_data;
>         |                          ^~
>     CC      drivers/slimbus/qcom-ctrl.o
>     CC      drivers/auxdisplay/hd44780.o
>     CC      drivers/watchdog/watchdog_core.o
>     CC      drivers/nvme/host/fault_inject.o
>     AR      drivers/accessibility/braille/built-in.a
>   make[2]: *** [scripts/Makefile.build:288: drivers/block/n64cart.o] Error 1
> 
> [...]

Applied, thanks!

[1/1] n64cart: convert bi_disk to bi_bdev->bd_disk fix build
      commit: b2479de38d8fc7ef13d5c78ff5ded6e5a1a4eac0

Best regards,
-- 
Jens Axboe


