Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A27C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAAE20863
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PCNxY+Gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCROPL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:15:11 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50649 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfCROPL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 10:15:11 -0400
Received: by mail-it1-f194.google.com with SMTP id m137so5089016ita.0
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UEvuBP4aWr3OZ9AbbtlftQYNPHMcYiA4Lc7tJGEj2d8=;
        b=PCNxY+GjJLNG3IzzkvalG7bq0ayQXLFHhvR42imaxaxJV53WouFQgAUiTP6csgOLE6
         lXzbD55wujjKY4aQ+fDuNDQRYqxLxHpFn3diV5UljP2Kg+0AXCniQ+PKPyXMpowZ5Ykj
         DylaGsYPu2aXi9Y/BtWe/I495Od/ngTjS8nCUZg3kL2f+56pVAAo2bVkGnPc8HtCT9tF
         ku4fosPO/U16WCHNmfUZ/0bZQkFhMa845TEKNskdfDBw/4vOD7TkajcH93dJxpqJTq+F
         rjZMMH2or8ic2JmrU3iGxU7mHwrGuKcs2whuiWpvlRTFKjTd+1/CdH2Bc32+16GJdV0s
         menA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UEvuBP4aWr3OZ9AbbtlftQYNPHMcYiA4Lc7tJGEj2d8=;
        b=B9OQaKFN4/tly47ZaaXRSScJWQ8EDPjGvOt7adViTUCRztMv5WjPasu54izQQwy2+d
         0RE8zdfsY6ys2X9CxG1GkQBJYkaJDBz72um6yWKtpZj5V0gW1Li6JVZUx7QuSLL4Utaa
         Rm/Qh6AtLdcBD/UZFHJC/hkfgfK+hmYRxwCMBxDLZTMv4t+4gYCjU9W9Qv0LvQAR47LB
         caqKIpWJhxWCJUOpxJ2f5wFGf571Tu7F3LHkX9mCz6htq+N6JTYKcInGpqkWfYsSjx6u
         f3rM2X6RiCs+I6hJbDdQuxWlI8stEqo0/9S0kNLV6A7iFkaDIHBfrSV3CMs2x4sg3g+y
         NDlA==
X-Gm-Message-State: APjAAAX+YkUyWTaSvk8IkZEfwRfWwgdcxxA0q3wTJ2sygXfYMEELdEOh
        ZT8aKVirQFUBXMeemjS11zztgqxady1qEg==
X-Google-Smtp-Source: APXvYqwV6URnb30AZ6YG/UCfvssSS/2/lYECQee/weuRiLlVjI9AmQABmW0R9RdTsui4WioFRz9rIA==
X-Received: by 2002:a24:3c53:: with SMTP id m80mr6273097ita.102.1552918509612;
        Mon, 18 Mar 2019 07:15:09 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o129sm240313ito.0.2019.03.18.07.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 07:15:08 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: use blk_mq_sched_mark_restart_hctx to set RESTART
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-block@vger.kernel.org
References: <20190315030510.36531-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3c176be6-afeb-6770-c112-ff1026e40c45@kernel.dk>
Date:   Mon, 18 Mar 2019 08:15:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315030510.36531-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/19 9:05 PM, Yufen Yu wrote:
> Let blk_mq_mark_tag_wait() use the blk_mq_sched_mark_restart_hctx()
> to set BLK_MQ_S_SCHED_RESTART.

Applied, thanks.

-- 
Jens Axboe

