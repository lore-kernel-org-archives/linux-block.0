Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3013EE4996
	for <linux-block@archiver.kernel.org>; Tue, 22 Aug 2023 14:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbjHVO6f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Aug 2023 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjHVO6e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2023 10:58:34 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE5410B
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 07:58:32 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-34bbc394fa0so3611675ab.1
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692716312; x=1693321112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB1Ww7Xem8WGw089z88YFa9W21ZWu8LSbkqc+/UePgk=;
        b=Wa/Yyd/kaC5r3r5yj8BC1U3nsT5jPqnb4GwBnzTcs3H05Y3QdTqX/2NLwI+JPq1Jue
         +WwJsSxc4NYmg3cMmhJVbKAL+Ul52iRp8WKzJK6FexeWCg3rfZ4CKa7XhZR2+St+ynZx
         0b6POKHXLNtb+eYvi8RQlZT1Q/5xmMwim3Fr3sutttDD6tNXvKV2kuhC6OYocMmXhClL
         bf/zO4bHSGibmad3sP3G/Hvw7HPnjybr//eOrl7yC/MZRDJp8D0v/g3GA0a/wYuQUSFP
         Gdy+XTMfU+zx1f11YIP0FA+XADzQF0wL1B9udx20Wql3H1ZjK9DWO8voXBc5mlFCpqEb
         R36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692716312; x=1693321112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB1Ww7Xem8WGw089z88YFa9W21ZWu8LSbkqc+/UePgk=;
        b=k/Y5aQTXK24KRFLTGUNiUwXVmZ8Oy946QGagEKQZpXbOnQTjtiwkGPPza+DAL7pJS6
         t4bHEb0EPjM6Lqy2tzPb1XOyg560bMg4NQsKWkmQ3TB1B2dr5U/H6qq0d/1hjsWCNgfA
         aQt7XaoOUKX6ty1zmMME3EfnXui50hVI+WQyViHY9TjVRSeHc+RBN/mGfq6gi3q0fBXo
         3v+Kj8Pn2NPWNAwF8l48zpzKwcmgFODOq5dHDEQc3IrTMabaivwTnMZTJJVUGmByx/Fm
         x3Zfh9efmiVhaWf2c9byfw/xnnE8GOOrbaA2kWWNYHuK87DeESo+/4SJ01wcVJ67x4T0
         Qdkg==
X-Gm-Message-State: AOJu0YxXd5UJX3bFIaMQaUl+MIvWaFbe2Rh2odXJcCFfmaQVN6xI2iIY
        nas200yLETRrU5WOOJWieeGcZQ==
X-Google-Smtp-Source: AGHT+IHr+XM33y4EusXFmXmeCjm9xQ3Z4ae/IlSxx/Fyh+yXTFLSUazav+XXl49xnpqnVLrupr7AKg==
X-Received: by 2002:a6b:c8d1:0:b0:780:d65c:d78f with SMTP id y200-20020a6bc8d1000000b00780d65cd78fmr11704836iof.2.1692716312011;
        Tue, 22 Aug 2023 07:58:32 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b19-20020a5d8953000000b0079199e52035sm3245417iot.52.2023.08.22.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:58:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, ming.lei@redhat.com, bvanassche@acm.org,
        chengming.zhou@linux.dev
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
In-Reply-To: <20230821095602.70742-1-chengming.zhou@linux.dev>
References: <20230821095602.70742-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH 1/3] blk-mq: fix tags leak when shrink nr_hw_queues
Message-Id: <169271631079.42104.4944668728331842875.b4-ty@kernel.dk>
Date:   Tue, 22 Aug 2023 08:58:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 21 Aug 2023 17:56:00 +0800, chengming.zhou@linux.dev wrote:
> Although we don't need to realloc set->tags[] when shrink nr_hw_queues,
> we need to free them. Or these tags will be leaked.
> 
> How to reproduce:
> 1. mount -t configfs configfs /mnt
> 2. modprobe null_blk nr_devices=0 submit_queues=8
> 3. mkdir /mnt/nullb/nullb0
> 4. echo 1 > /mnt/nullb/nullb0/power
> 5. echo 4 > /mnt/nullb/nullb0/submit_queues
> 6. rmdir /mnt/nullb/nullb0
> 
> [...]

Applied, thanks!

[1/3] blk-mq: fix tags leak when shrink nr_hw_queues
      commit: e1dd7bc93029024af5688253b0c05181d6e01f8e
[2/3] blk-mq: delete redundant tagset map update when fallback
      commit: 2bc4d7a355a4d617452eaf1b21d6d261194b3667
[3/3] blk-mq: prealloc tags when increase tagset nr_hw_queues
      commit: 7222657e51b5626d10154b3e48ad441c33b5da96

Best regards,
-- 
Jens Axboe



