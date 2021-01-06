Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F3C433DB
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 16:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277A423131
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 16:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbhAFQBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAFQBq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jan 2021 11:01:46 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE1EC061357
        for <linux-block@vger.kernel.org>; Wed,  6 Jan 2021 08:01:06 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id n142so2857228qkn.2
        for <linux-block@vger.kernel.org>; Wed, 06 Jan 2021 08:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:84;0;0cto;
        bh=jm56A5fGr5OHx7iCDDhPN4SHAU/tIA8rQFxkvyE92iE=;
        b=Dddn9wMthR5XWrq98TxmB19IF2oALaMnU3GWm5gzC230Z83w7O/ORVj5WS0go2azW0
         SbkKugPbU03bDvQyoR+f4kaWXjumlc3K1uxI+SkqaMhlZ8fGn96MZ1jI9xaSBxBfs99c
         bU4HI1P2Y2phUeFQoHQvNfCL6YY1C6LKvP40HJ9cCEuETtjeekNQuqQkrTzmFMUaSihU
         X7vJM4cJIK6Zi/c+imF6FZlIlHPuUOSqWvUULAY+iOf+NWRvtZNZMGH8/pczh/sYRc4b
         t8BG1fBXyGofY8Y8bnqlx9/cfy7KO5R4OmUu5kP9Us+VFjfLdhdfWbFdJSCvO3ByCvBL
         ufbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:84;0;0cto;
        bh=jm56A5fGr5OHx7iCDDhPN4SHAU/tIA8rQFxkvyE92iE=;
        b=jVnfZpzyWmyhbmUlSvUxrIMSxUeCmTaxPuaBKDxxqH+z+KZSS0zTik71rczVjmA53U
         4aiPnSkF+aG0lpxiw2W9dqcf9LqAECfkJIIuKxF4pImmauckYnuvpZh6AP4VH1D4hJOd
         eQg1IEqZc8llOGd6tntjP3DLB6DoaCdKOTD8JByUnX85nlFf9RfUtT7hpapBLrEStsxm
         vMb3ft5NjDSFH6CCx4rzciZggILV63Nvs7FSsm0k3UVB5jQnhYYCYTlwplii134sTeLw
         7FenXE122xaf4xEL4hJZhhPAphaLisxrK9ELPr0r0PZ5m928YKGzGoMcPX3TBoF98Zr5
         lBBA==
X-Gm-Message-State: AOAM531PM1AhqO/xomX/9S2Q4q6JVrC+R2XckXoItMBOwmh9DoWlORVv
        V20dRId7ZLxIWdww8UC1DmQ=
X-Google-Smtp-Source: ABdhPJzAab2hnXo6O/x9xi3TM2y2jYeHLXy5BMECnGVUzxM2KBu45FvIR3s0Q/be8ZbOdQY3xfQluA==
X-Received: by 2002:a37:a158:: with SMTP id k85mr4931179qke.432.1609948865137;
        Wed, 06 Jan 2021 08:01:05 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:414d])
        by smtp.gmail.com with ESMTPSA id o29sm1314199qtl.7.2021.01.06.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 08:01:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 6 Jan 2021 11:00:19 -0500
From:   Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove redundant get/put operations for queue
Message-ID: <X/Xek5yjkLTv80ER@mtj.duckdns.org>
References: <1609909421-3487-1-git-send-email-brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609909421-3487-1-git-send-email-brookxu@tencent.com>
84;0;0cTo: Chunguang Xu <brookxu.cn@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 06, 2021 at 01:03:41PM +0800, Chunguang Xu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> When calling blkcg_schedule_throttle(), for the same queue,
> redundant get/put operations can be removed.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
