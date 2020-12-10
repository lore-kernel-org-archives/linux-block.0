Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA5C4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9162423E1F
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 14:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390047AbgLJO1T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 09:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbgLJO1T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 09:27:19 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6394EC061793;
        Thu, 10 Dec 2020 06:26:39 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id u21so3707642qtw.11;
        Thu, 10 Dec 2020 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ng4ID+FM2jUqrNZONA64ob770LHcIUG2qaThMjtYWo=;
        b=mS4Vy4IyDXA25U6bvb0/TypwovVLWDzbeT5Dvgp9XDkoefmNPRU5zXV+1tnvZcQyfv
         OGcd06bcpHwNKVd841KCON2RHQxAw5sLflbYtrih+/JWZc1MvG9Zga/7Sw/4gdVsELwi
         woR0IpOivMH5X4Gn2mCub3b2mYF7nsfq8ReQiPT8hlBTw6KZI2eSVkp82HMCx0M/vL2C
         XLWSCzCPvopxouk7We+3aMrrmg7CMDpR1xCtipeYzOfJyOFLHzkqDRPavP5DaK1k+Q/M
         nWBoP+3n04RcGWka8taxOWLCx4dYPy+qMnHfBng3teBUal4QVLUagVcLZAlUUNm/Q8rV
         RngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3ng4ID+FM2jUqrNZONA64ob770LHcIUG2qaThMjtYWo=;
        b=Z3oJWGf42WQMXZjkPcwZlu7P0sutOOySSA/64lxgEWaxnjuMayNoXERzrmil6J8zMp
         /VuLtSLHUX9bMVhn0Lep3Vk8/EEZ6hNfP2RQ4aAUVypz6qeyLF0B/8I+9FT51OYPFk/f
         20fju7SnLcEJkFgIe5tlkDl48VOlppN3PggLIXs4MUE8jhngax4RCOtSEbJ7k9g38p81
         SM18CwhX5IVU8d/sjIhqXXebNvKwZXvamUw7/TTuMijAg6HOc1KK4HMSAFfvfJ6kLoWC
         qcPOwpk0itc0riUmSJeqpStV7Q+AtNRt+2ZznyNNt0NNRGlcRxa9dHJfh/1IGPPMoN4Y
         iN6w==
X-Gm-Message-State: AOAM533M9yRTLJqSUILwPspdsBV0PLjRWKA8TYnQTbsh/dIoxn5Jr9f7
        exGVYs423W6JF6Z4xv1gfjjEQPoi5xHzFQ==
X-Google-Smtp-Source: ABdhPJwHAj1DJJnJI5dhH37w9B1Mx24/0xO2E4UfyVlvP7J1GD/QLCW4JUeeAlGjJCYofnPsZ21Rcg==
X-Received: by 2002:ac8:5a90:: with SMTP id c16mr7935568qtc.331.1607610398475;
        Thu, 10 Dec 2020 06:26:38 -0800 (PST)
Received: from localhost ([2600:380:5a4a:42b3:c6ce:6e34:f826:c141])
        by smtp.gmail.com with ESMTPSA id i68sm598858qkc.82.2020.12.10.06.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 06:26:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 10 Dec 2020 09:26:04 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-iocost: Use alloc_percpu_gfp() to simplify the
 code
Message-ID: <X9Iv/MlqQI00wZRn@mtj.duckdns.org>
References: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
 <aa518c5b5c7185e660a1c8515c10d9513fe92132.1607591591.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa518c5b5c7185e660a1c8515c10d9513fe92132.1607591591.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Dec 10, 2020 at 06:56:45PM +0800, Baolin Wang wrote:
> Use alloc_percpu_gfp() with __GFP_ZERO flag, which can remove
> some explicit initialization code.

__GFP_ZERO is implicit for percpu allocations and local[64]_t's initial
states aren't guaranteed to be all zeros on different archs.

Thanks.

-- 
tejun
