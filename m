Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0D1C83F3F
	for <linux-block@archiver.kernel.org>; Sat,  2 Sep 2023 14:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjIBO7N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Sep 2023 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjIBO7L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Sep 2023 10:59:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96481702
        for <linux-block@vger.kernel.org>; Sat,  2 Sep 2023 07:58:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so18770b3a.2
        for <linux-block@vger.kernel.org>; Sat, 02 Sep 2023 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693666732; x=1694271532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JqqASAwLidLHNsbo1Ikd5zAnkh2n6j+4MeLGVjK9KeQ=;
        b=DtTUrgGGYNoryzvQliqRAV0I0TqxgBLASK55Il6RmnPNjSEd1gk32t1ZFbF1xYDNQP
         h60r0cicm1R1SiikgC3zKN3Up1dupiLZR/NxCP862eQsdP3+1VnQgqUCY+fuoPvKrpIG
         xoZyTrG+6tCdr6Q9yrSK7kImMqYqTOT9Rlu7PXgaLFdFm7M9YYs0XkXX2SJoO9fDpJzm
         jQONKlDwT5+bzE7MqCVrkOl4hAlca+uEquVvUOqyrjjFq9UGWofyTWnY9bK10RSGedyC
         ZON/luEwINHq0hBeZk8YTLGLo3B868jC47BgEg1NGA3qfB4B5Jw6bmuC6CaLy6iCB+7x
         v0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693666732; x=1694271532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqqASAwLidLHNsbo1Ikd5zAnkh2n6j+4MeLGVjK9KeQ=;
        b=jAwcctC8WBnEF6fdrDSIBmkWgGPXWu0Iwi7XSMy4WCOELCgSARXIc8mQolYY/fECFt
         qAGDtTd58LP76XAN4/9xFZjQ0yYyYmhV9C0xqvA65VnVchFz/z8JHfBw1kdS/tuk0mns
         4K0CNTSWBv0kfChrEpXSAY+f5n5OItbI0C87jguQSGCrOQc+TXdordQVzk2jTXdCp+dU
         BaxhP8fNXRuNIM4JiWEamDuuD991gHq7OG7k/pH2AK1WTDnMIvjDU/EaDlgOaNXu/UcA
         SV0SjUv8PMlvPyuV6BLLL2fS0IVVxb440JH5Up6m4qbmMGwN+3uFX73agPWaCHGulFn8
         s4PQ==
X-Gm-Message-State: AOJu0YyWnr/EWj7p1OQRjuTg1npWdiAQfjb2/fnOY7g0b8GAhkcrzhi6
        QE9zdHPs5VcG2mSzCqkGaoRFhtbuqk5UPReTPuk=
X-Google-Smtp-Source: AGHT+IGd+LVDZeDr4jp9A7Kym84DV1Es5xjo7XwfHT7msRM8+isjvqbRTbPJRfVgoPjHXUck8disWg==
X-Received: by 2002:a05:6a20:8421:b0:14d:446f:7212 with SMTP id c33-20020a056a20842100b0014d446f7212mr8222606pzd.46.1693666732204;
        Sat, 02 Sep 2023 07:58:52 -0700 (PDT)
Received: from [10.254.27.61] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id e14-20020a62aa0e000000b006873aa079aasm4864718pff.171.2023.09.02.07.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 07:58:51 -0700 (PDT)
Message-ID: <a84b5ccb-151a-2de1-c213-de68a6f81f29@bytedance.com>
Date:   Sat, 2 Sep 2023 22:58:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 0/6] blk-mq-tag: remove bt_for_each()
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        bvanassche@acm.org, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230823151803.926382-1-chengming.zhou@linux.dev>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230823151803.926382-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/8/23 23:17, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Changes in v3:
>   - Document the argument 'q' in the patch which add it.
>   - Add Fixes tag and Reviewed-by tags.

Hello, gentle ping.

Thanks.

> 
> Changes in v2:
>   - Split by one change per patch and add Fixes tag.
>   - Improve commit messages, suggested by Bart Van Assche.
> 
> There are two almost identical mechanisms in blk-mq-tag to iterate over
> requests of one tags: bt_for_each() and the newer bt_tags_for_each().
> 
> This series aim to add support of queue filter in bt_tags_for_each()
> then remove bt_for_each(). Fix and update documentation as we're here.
> 
> Thanks for review!
> 
> Chengming Zhou (6):
>   blk-mq-tag: support queue filter in bt_tags_iter()
>   blk-mq-tag: introduce __blk_mq_tagset_busy_iter()
>   blk-mq-tag: remove bt_for_each()
>   blk-mq: delete superfluous check in iterate callback
>   blk-mq-tag: fix functions documentation
>   blk-mq-tag: fix blk_mq_queue_tag_busy_iter() documentation
> 
>  block/blk-mq-tag.c | 176 ++++++++++++---------------------------------
>  block/blk-mq.c     |  12 ++--
>  2 files changed, 49 insertions(+), 139 deletions(-)
> 
