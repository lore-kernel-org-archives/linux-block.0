Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F91DC63797
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 13:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbjAQNMw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 08:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbjAQNMr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 08:12:47 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C57336095
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 05:12:44 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id h192so21908281pgc.7
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 05:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67VThcpI2x2PWH5UFNvSAgzY9u26UXk66nDlvm2jIEc=;
        b=PK2BVU4ZjH3qP7V1qf6i9aQ+cp6pMV6URQxbcsaTkO25a8xtIQDnCFqF3Yp6WrwnPu
         gj5A9r7vZ8ZlBhWeTiP/lRebm8yZsUfOZ1E+qESVWiRPeuVrqTSgieLXsfqtY5TyxP/x
         Dd2DzhJ+4z/3V+aGaZqyFzQ5Zq+XhTrORD4uAu4diCcDxDO8LNZQBwPPZZYmKqAEJgKD
         yVWpio+KgY6cjhoDxmx1d74z/VlUb9KfSTNtuDyxt0vsLB8vqUsehqOrHdhezGQLep2h
         he7CHReYmn+YhydZAmCnIKkHQqZzh8uoyG4CZ9kR80yml8EGNXT/et0zjCG+6ATf2N4Z
         lz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67VThcpI2x2PWH5UFNvSAgzY9u26UXk66nDlvm2jIEc=;
        b=s0XI1lEKxu0tc1h6A+jVook4wjbx/WNdQvOHcfjjELMI90uWku4lJuO45j8GViy0CJ
         5TuQPCzow8oHZ/CUbpBqyp/MXxeExKJyustRuKC6urT4zmOHHICVPKeAjfZuySBf7ILB
         F8sHBtAmFwEkCaAj5qNaMfGdFTbvYZkgX++RiXRr/VC1m+EZ7PSY3g1nuzBomXmM6oKp
         knrD1O0PycwmwoHVPQ0Cxd7TCE6y5X1VtnDYNx8RwJqrQJO50dB4+bB/Ieq7POvT2KIs
         ooOBdFAW4jUpCEo3oRR4FMIREy7908W5JT59ZKTzRmycn238q8fq2+Fm+W7jarNaGs9o
         imnQ==
X-Gm-Message-State: AFqh2krnO8CS/L0zaEhIDvpRoZXO1aVNPinkEW3leism3e4uW7x2EHde
        yyNUzSbRYR7SYhzCKWnVrANdXA==
X-Google-Smtp-Source: AMrXdXthY76wGuVwFDwuHjj4XXBHcX3l/xHiP+DG+xJUfB8VR1ait/AJdVXI771NbQe8NcUIlwxQXg==
X-Received: by 2002:aa7:9ad9:0:b0:582:4a5e:b1ec with SMTP id x25-20020aa79ad9000000b005824a5eb1ecmr819079pfp.2.1673961163760;
        Tue, 17 Jan 2023 05:12:43 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7956f000000b0058bacd6c4e8sm4689685pfq.207.2023.01.17.05.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 05:12:43 -0800 (PST)
Message-ID: <ae9a5f7e-7c1d-c791-a0f3-894b4d724699@kernel.dk>
Date:   Tue, 17 Jan 2023 06:12:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V4 0/6] genirq/affinity: Abstract APIs from managed irq
 affinity spread
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
References: <20221227022905.352674-1-ming.lei@redhat.com>
 <Y74cXN4SP7FNtSl3@T590> <ca08f6b8-a491-3a7e-f576-833acdf2135b@kernel.dk>
 <87k01mmgwb.ffs@tglx>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87k01mmgwb.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/23 12:13 PM, Thomas Gleixner wrote:
> Jens!
> 
> On Wed, Jan 11 2023 at 12:04, Jens Axboe wrote:
>> On 1/10/23 7:18 PM, Ming Lei wrote:
>>> Hello Thomas, Jens and guys,
>>
>> I took a look and it looks good to me, no immediate issues spotted.
> 
> Want me to take the blk-mq change through tip too or do you prefer to
> merge that into your tree?
> 
> If this goes through tip, I'd appreciate an Ack. If you want it through
> block, then I give you a tag with the irq parts for you to pull.

I think the risk of conflicts there is going to be very small, so
please just take it through the tip tree. You can add my:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

to the series. Thanks!

-- 
Jens Axboe


