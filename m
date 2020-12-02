Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5115AC64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 20:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E998C21527
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 20:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgLBUda (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 15:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbgLBUd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 15:33:28 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7245FC0617A7;
        Wed,  2 Dec 2020 12:32:42 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id k3so1377105qvz.4;
        Wed, 02 Dec 2020 12:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bi4yjCY3FALmEA0HGC/jzq/xV0+n6rZC92KaCyBy7YM=;
        b=R9hr6FKWwwTYwc20K91Z1UWrBTBrsMw0yhziMzEDLFh0MDE++f1Zxe7twY7/Ywqh2W
         54jGKU1/mXkXPShm/fltc4fFO0gVC93iGuiRPTWbWyLcjV2DLyIWwcwF1iWXfjJ65UY5
         1gKVaVBB4f5PycgJvJUvoxJ2/mHpL0dYwhopf5QV72CwaBgqWFwrhHvVym/Vnp+RHda9
         trdwWObES7APrwV42cIoHrS0wl4uLoKGfCi4ykpSByrqINfBXQjJ4DnGql1ChuzlvgZz
         oYg33QQFC4Tu0+rpnznQl7wUBPcvwvR3hxNcKGZhZiwZq6gjJtgjuD7CGSBONc4+SGHK
         4Vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bi4yjCY3FALmEA0HGC/jzq/xV0+n6rZC92KaCyBy7YM=;
        b=d/qEgLmHGwUu2Z3MKCLt7i3EkMDKByhSILs1UwlXqiaVZTH6luHkIeUATKY7lEAuMj
         p43Qw3M79E7JW1Vx/NJyxJ2udm0GSDNy69xAPllx543XJkXm9ZF5yopGyPojrVu2iuCB
         XeEpgV2VL+jbWU2nbHi1Tz3GwfHn/+7vsVDlYLI11lnlRYoAWZWUUfGX1mIuLzePdBjE
         LI6CL0SWZmdf2dwilQ6M4cKpaKQmT7qHyuj0MSuGNPxJ6zUAmr33HzKcE1atlSHuUygM
         DLQGTe5co59u7lLVyz3HivxmHXC1dlw706QHVAXsOufrnUiC+iImOeHGXML7uUL0UEvs
         MRcQ==
X-Gm-Message-State: AOAM530rzCY7ul+UcNwrw1YyqDitRye+qMHyssRMyO5F8w9R/lP/l4vB
        S/79e7UAE/UHq6Y4JGeN+IAchbFktboYlw==
X-Google-Smtp-Source: ABdhPJxOKYIsdGtRADGmB5ndMCWZLHbqy637TkYN0i1VVXW8GFv7NEfdvJQ4DtiXKCsS6MEMmgMhnw==
X-Received: by 2002:ad4:4673:: with SMTP id z19mr4532382qvv.60.1606941161611;
        Wed, 02 Dec 2020 12:32:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8dbd])
        by smtp.gmail.com with ESMTPSA id p62sm3063465qkf.50.2020.12.02.12.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:32:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 15:32:13 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] blk-iocost: Optimize the ioc_refreash_vrate()
 function
Message-ID: <X8f5zQi+AzaY+ieY@mtj.duckdns.org>
References: <071dbbbdfecaebf9e850e622c52dd591969e21ab.1606617087.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <071dbbbdfecaebf9e850e622c52dd591969e21ab.1606617087.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Nov 29, 2020 at 10:37:18AM +0800, Baolin Wang wrote:
> The ioc_refreash_vrate() will only be called in ioc_timer_fn() after
> starting a new period or stopping the period.
> 
> So when starting a new period, the variable 'pleft' in ioc_refreash_vrate()
> is always the period's time, which means if the abs(ioc->vtime_err)
> is less than the period's time, the vcomp is 0, and we do not need
> compensate the vtime_rate in this case, just set it as the base vrate
> and return.
> 
> When stopping the period, the ioc->vtime_err will be cleared to 0,
> and we also do not need to compensate the vtime_rate, just set it as
> the base vrate and return.

Before, the function did something which is conceptually discrete and
describable. After, its operation is intertwined with when it's called. I
don't think this sort of micro optimizations are beneficial in cold paths.

Thanks.

-- 
tejun
