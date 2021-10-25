Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08293C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 08:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E503960EE9
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 08:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhJYIaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhJYIaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 04:30:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A97CC061745;
        Mon, 25 Oct 2021 01:28:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gn3so7704272pjb.0;
        Mon, 25 Oct 2021 01:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+mmc/7BEwZRLX6+ZqDE43E4jjRWpDliO633u1hVx2ts=;
        b=GALr7cTe4sEh368r3rwdvOiXIQbDkSmS8+Ts63+iBVfU3pqyxfzTRg9+ymOToYG8a8
         ZBC4MQ1u3mN7+rScfsrDcVgobysrhU5vKa22GLJyLfZubtU6rU0G/cJEsj4uICxGmtZP
         OCnPBjhQPF7YsgEk3usFn8tcrJ/IJV0nFVFozTe5oaYHrTIpKDOqfdRx6BKqMWnaEBN+
         DcDaSDpNDD1GN+Lkm/Hkc8La+EGvSS23BbXGgqL2oen94RZ7oJv2eEmDoGWYrtEU4OLU
         vECffbUH/a6ykZZ6EoybEgujqXnG3m/0QAAgrnNXMSCO1o39ciWO0sq9B/sAjWtH0Yt2
         mg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+mmc/7BEwZRLX6+ZqDE43E4jjRWpDliO633u1hVx2ts=;
        b=mPm2vCcf4sHEuJWsX2Xnz5Y5slIYjarYw28QgdNciJmUphrTfcZcPPEkAVlLmMEyRP
         cFCAqC+6/JkjKwEi8CsJebGfg95VwFQi5qUF0oygpFx011a+HAfVNb80YU9XzEUXxTMj
         q16BLtREjiumYCsRx/cOQ5qGrIXP9iJ6PMYo8icxliYX4oi0hGzd5UCK4v98/eJiy0e0
         AG0EXcUMH/BB+PdFOmD+mS7KdPaaKSwXWF5/qJhlWOsP/t2Pf1uPbWu0igWNa8Q2kEuq
         C02j+4gi8834MkDyL0g36g8jPDIXFbTa/9a7Dijm5Y19efnMrVjTejqMPesP4sKUtDWV
         mw+g==
X-Gm-Message-State: AOAM533CNWCIyLHC6K0rCir41BcWuEE3h7+Tf3Rt1/AJarM/4C8ExcVa
        8da1wi6CPhLveXfYK4a14ujRMeu+Trz/Dr8o
X-Google-Smtp-Source: ABdhPJyadfzEQgFXhwwgjg6jPwIFK0Y53vSe6zPdWVrtNVaryWFv4LhXxRPKRMhhG5dPqjRj00lZ0g==
X-Received: by 2002:a17:902:cecf:b0:140:5397:92b7 with SMTP id d15-20020a170902cecf00b00140539792b7mr5041260plg.66.1635150481684;
        Mon, 25 Oct 2021 01:28:01 -0700 (PDT)
Received: from [172.18.2.138] ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id n2sm2906435pjo.20.2021.10.25.01.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 01:28:01 -0700 (PDT)
Subject: Re: [PATCH v3] block: fix incorrect references to disk objects
To:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     axboe@kernel.dk, hch@lst.de, sunhao.th@gmail.com,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211018115807.21103-1-qiang.zhang1211@gmail.com>
 <YW1n91DAaVyuISVV@casper.infradead.org>
From:   Zqiang <qiang.zhang1211@gmail.com>
Message-ID: <9d2f7753-d7a7-f91e-077b-40b274199185@gmail.com>
Date:   Mon, 25 Oct 2021 16:27:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YW1n91DAaVyuISVV@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2021/10/18 下午8:26, Matthew Wilcox wrote:
> On Mon, Oct 18, 2021 at 07:58:07PM +0800, Zqiang wrote:
>> When adding partitions to the disk, the reference count of the disk
>> object is increased. then alloc partition device and called
>> device_add(), if the device_add() return error, the reference
>> count of the disk object will be reduced twice, at put_device(pdev)
>> and put_disk(disk). this leads to the end of the object's life cycle
>> prematurely, and trigger following calltrace.
>>
>>    __init_work+0x2d/0x50 kernel/workqueue.c:519
>>    synchronize_rcu_expedited+0x3af/0x650 kernel/rcu/tree_exp.h:847
>>    bdi_remove_from_list mm/backing-dev.c:938 [inline]
>>    bdi_unregister+0x17f/0x5c0 mm/backing-dev.c:946
>>    release_bdi+0xa1/0xc0 mm/backing-dev.c:968
>>    kref_put include/linux/kref.h:65 [inline]
>>    bdi_put+0x72/0xa0 mm/backing-dev.c:976
>>    bdev_free_inode+0x11e/0x220 block/bdev.c:408
>>    i_callback+0x3f/0x70 fs/inode.c:226
>>    rcu_do_batch kernel/rcu/tree.c:2508 [inline]
>>    rcu_core+0x76d/0x16c0 kernel/rcu/tree.c:2743
>>    __do_softirq+0x1d7/0x93b kernel/softirq.c:558
>>    invoke_softirq kernel/softirq.c:432 [inline]
>>    __irq_exit_rcu kernel/softirq.c:636 [inline]
>>    irq_exit_rcu+0xf2/0x130 kernel/softirq.c:648
>>    sysvec_apic_timer_interrupt+0x93/0xc0
>>
>> Return directly after calling the put_device().
>>
>> Reported-by: Hao Sun <sunhao.th@gmail.com>
>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> Fixes: 9d3b8813895d ("block: change the refcounting for partitions")
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Hello Jens Axboe

The patch description information of the previous v2 version is 
incorrect, v3 modified the description information, please applied the 
v3 version.

Thanks

Zqiang



