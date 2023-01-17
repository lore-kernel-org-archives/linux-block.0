Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297FAC3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 17:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjAQRLP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjAQRLM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:12 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F552CC75
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 09:11:10 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id s26so7358209ioa.11
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 09:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wywbYDdRewZbeBYdBqsQPCT3pfo92S64CwjLHS6OdeQ=;
        b=FHQzA+SB1PjLtYDocMcaQu5ERZlfgETSf3c+RoL6zvzVfhmdguW8sINbIv0wDEirVD
         MPNNkk03+hwWl9H7z8x+7JDXDwUi7/TsCreHXebPgL7k8OcPG3lpH44HIFh4FtRHP9P7
         7dpEJxhY2F+sm1kvPsqzQ3BP5QZ86SC4dwmGfbelIeb35tODo8f1BvcATovtijxhug3E
         EIuycqfh4KTyQQsJqveGukZeBccVVJ4rpg3RQKzPgyxCPBkVJuEejLYYL3J38uU1WZg/
         H4uv/FkYRhCOpaqDPBkoE/0rzJZo7bkn9bE3J2oH10TbbxVAg1Sw1POFsrZhuVevJzzu
         V20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wywbYDdRewZbeBYdBqsQPCT3pfo92S64CwjLHS6OdeQ=;
        b=GWYwdGafV4H8X5DlmYGYudrllE5R+9FpOGEICYo61T3pJy/8ayk8yN7c66RpM4N4iR
         8BcNS8iJMm0volWXg5je0+csBMNjKNUQdq+MaKPN26/xAl0xtDDWS3BBA9kgxdbQmwbb
         lCDgE7fbtD0+CsW31Ah2xhRmVIuajBtEm0byoaIojkdZbLcS3sw6e9obx6uX6dpcdFwl
         2GLOYAF2coX0VOoRU3CAazqnR40vpYRX3+gpxcYIxI1XDXnFA3gG/aYyWLz/9a4sBuiq
         fowrlRJbHlb6eKAExDpwpjoy5wyJcRvWpBGCHk2TUBVNDrUHvOy42TOdoTg/hK3sZzG0
         6cTQ==
X-Gm-Message-State: AFqh2krcXaiaZFbYVXm8ChuiqH85IILjTxthkTxhr3JJCCq5ueJlZ8rJ
        8qUi+W1jq4kc0ernJZOKBhpIbQ==
X-Google-Smtp-Source: AMrXdXuH0uUysfUh/dakMTeWj+tvfqr+wlc/wqmWBNGp6+udS4yaxUSf2d+cKDtvJ/YnZMPW1mQmDQ==
X-Received: by 2002:a6b:b2d0:0:b0:6e2:d939:4f30 with SMTP id b199-20020a6bb2d0000000b006e2d9394f30mr592309iof.0.1673975469840;
        Tue, 17 Jan 2023 09:11:09 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x20-20020a0566022c5400b006bc039e3224sm10560144iov.17.2023.01.17.09.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:11:09 -0800 (PST)
Message-ID: <0e88f8e6-961e-28b2-0606-50c1a0de10fb@kernel.dk>
Date:   Tue, 17 Jan 2023 10:11:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH for-next v1 0/2] enable pcpu bio-cache for IRQ
 uring-passthru I/O
Content-Language: en-US
To:     Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com
References: <CGME20230117120741epcas5p2c7d2a20edd0f09bdff585fbe95bdadd9@epcas5p2.samsung.com>
 <20230117120638.72254-1-anuj20.g@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230117120638.72254-1-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/23 5:06?AM, Anuj Gupta wrote:
> This series extends bio pcpu caching for normal / IRQ-driven
> uring-passthru I/Os. Earlier, only polled uring-passthru I/Os could
> leverage bio-cache. After the series from Pavel[1], bio-cache can be
> leveraged by normal / IRQ driven I/Os as well. t/io_uring with an Optane
> SSD setup shows +7.21% for batches of 32 requests.
> 
> [1] https://lore.kernel.org/io-uring/cover.1666347703.git.asml.silence@gmail.com/
> 
> IRQ, 128/32/32, cache off

Tests here -

before:

polled=0, fixedbufs=1/0, register_files=1, buffered=1, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=62.88M, BW=30.70GiB/s, IOS/call=32/31
IOPS=62.95M, BW=30.74GiB/s, IOS/call=32/31
IOPS=62.52M, BW=30.53GiB/s, IOS/call=32/32
IOPS=62.61M, BW=30.57GiB/s, IOS/call=31/32
IOPS=62.52M, BW=30.53GiB/s, IOS/call=32/31
IOPS=62.40M, BW=30.47GiB/s, IOS/call=32/32

after:

polled=0, fixedbufs=1/0, register_files=1, buffered=1, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=76.58M, BW=37.39GiB/s, IOS/call=31/31
IOPS=79.42M, BW=38.78GiB/s, IOS/call=32/32
IOPS=78.06M, BW=38.12GiB/s, IOS/call=31/31
IOPS=77.64M, BW=37.91GiB/s, IOS/call=32/31
IOPS=77.17M, BW=37.68GiB/s, IOS/call=32/32
IOPS=76.73M, BW=37.47GiB/s, IOS/call=31/31
IOPS=76.94M, BW=37.57GiB/s, IOS/call=32/31

Note that this includes Pavel's fix as well:

https://lore.kernel.org/linux-block/80d4511011d7d4751b4cf6375c4e38f237d935e3.1673955390.git.asml.silence@gmail.com/

But this mirrors the improvement seen on the non-passthrough side as
well. I'd say that's a pass :-)

-- 
Jens Axboe

