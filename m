Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21998C433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 16:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJKQ4z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Oct 2022 12:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJKQ4y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2022 12:56:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFC11EC64;
        Tue, 11 Oct 2022 09:56:53 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f193so13355651pgc.0;
        Tue, 11 Oct 2022 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5RbqDPmU+T36Dzi3M78WhRya0SfBBrW03GAQn62eSk=;
        b=n+fdqDOwWSVskXE762n/Ybb/cMZTP1sawPVMLS51GoXmFxXJimchm4b/VL6PniWksJ
         d0pr1VneQQoJPpYsa/jg8lSB/bZ6yemyTTuqnxPDAqO2/nlSx3G6HE9uDSx64apkRfi7
         1/MIXES/V8/H60dSlCV9JxLf+QmH6rvL+SV/xfv7knxZKPx92wQ1IyrUoCwziRxJ6rHu
         QFRta3qlBzXxZl/bfgIlC4qCnqgasE0mE0X6ICTgTBsPhXEjfD+ahMTa5IQJfatymf2/
         M4eVbEyFltiQLdlrLG9fU52sO0ByM7NK7XnT2rwsHuCP3D2ndcCFdI7ENUQnGgREAcwl
         YCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5RbqDPmU+T36Dzi3M78WhRya0SfBBrW03GAQn62eSk=;
        b=beASmbzG8x4fUjN2Alq4uIOEY3xP569lsnEqHEqC6rBYqa7czYXvVrsu9msUolByEm
         DQy5BdMrDXWAQGPSOPLc995gYHVe7mlpTxkHtYjXHR7UI1mPEE7Nnj5goT8afFemB55f
         AjSPzlsW9JjBkubhgVCUx4TpEXlyRvENR4/+ph+CVnLYRBsVUs6Hwx3pQM/gXwUBZHQi
         4Nw5ix4R6RLgZG/p5GYazBsAC0G/LWu3S5PRjaZ85kXGpFO04MbbinJQWoMQjsmIyUjh
         Ry9azlNYUW+G/h0WSn8IvwiYddpWNwNWKv/oYLac+DRHawFBP5nTBmZzOy5PSwCLHu1R
         k9kA==
X-Gm-Message-State: ACrzQf1GVBb1sqiJKRFn/R2BMM7PKYggDv+yw+YuJyMvpJ/V57hZk4zh
        sBgxF/P0Pe38xaTfMmPvlTM=
X-Google-Smtp-Source: AMsMyM6ovS/PvL0XzhCu1Dgk0tPCY8KuNlZdZ/CjV6JHsJhC/E3577NH8AnWv1BADA0UfpTQHAYevw==
X-Received: by 2002:a05:6a00:124b:b0:563:ce4b:f519 with SMTP id u11-20020a056a00124b00b00563ce4bf519mr3539498pfi.5.1665507412570;
        Tue, 11 Oct 2022 09:56:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a0d5600b001ef8ab65052sm8146959pju.11.2022.10.11.09.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:56:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Oct 2022 06:56:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 2/5] blk-iocost: don't release 'ioc->lock' while
 updating params
Message-ID: <Y0WgUgfRcKhaXiLx@slm.duckdns.org>
References: <20221011083547.1831389-1-yukuai1@huaweicloud.com>
 <20221011083547.1831389-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011083547.1831389-3-yukuai1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 11, 2022 at 04:35:44PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> ioc_qos_write() and ioc_cost_model_write() are the same:
> 
> 1) hold lock to read 'ioc->params' to local variable;
> 2) update params to local variable without lock;
> 3) hold lock to write local variable to 'ioc->params';
> 
> In theroy, if user updates params concurrenty, the params might be lost:
> 
> t1: update params a		t2: update params b
> spin_lock_irq(&ioc->lock);
> memcpy(qos, ioc->params.qos, sizeof(qos))
> spin_unlock_irq(&ioc->lock);
> 
> qos[a] = xxx;
> 
> 				spin_lock_irq(&ioc->lock);
> 				memcpy(qos, ioc->params.qos, sizeof(qos))
> 				spin_unlock_irq(&ioc->lock);
> 
> 				qos[b] = xxx;
> 
> spin_lock_irq(&ioc->lock);
> memcpy(ioc->params.qos, qos, sizeof(qos));
> ioc_refresh_params(ioc, true);
> spin_unlock_irq(&ioc->lock);
> 
> 				spin_lock_irq(&ioc->lock);
> 				// updates of a will be lost
> 				memcpy(ioc->params.qos, qos, sizeof(qos));
> 				ioc_refresh_params(ioc, true);
> 				spin_unlock_irq(&ioc->lock);
> 
> Althrough this is not common case, the problem can by fixed easily by
> holding the lock through the read, update, write process.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
