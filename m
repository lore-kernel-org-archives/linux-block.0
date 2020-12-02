Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406C8C6369E
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 20:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC992224B
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 20:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgLBUAG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 15:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbgLBUAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 15:00:06 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DADBC0613CF;
        Wed,  2 Dec 2020 11:59:20 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id x25so2508297qkj.3;
        Wed, 02 Dec 2020 11:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a+5iwKU/1c/swCFdTpX9vzDsm481ZGbz4NuaZisDpdA=;
        b=GviI6R2nSpKxd4DNlv81VRu8peR3srnGzmIkCTEm2ejBAIjZtdy0uusLp2GoHk8ryb
         D36eE7yZFMPhsLKHg4pw6gvd2VDT3GvTpGaHnKfOkhdQCVY4HiKEbMe/Y9XKpkzZy/r4
         qOaWYJ5TqQLQgDv4biHVMHaE+Mv2pW+w2RJu7mVEDk72e+ux8/Ia9kGtabajKOIIQcVi
         dStHUKcWLmKMPWTta/A5R07Z1DM/GYOjmLC3vNecvjdiRaOTHihTcn42xN95IVW3OJUh
         x18WRzjYyoD/dsvTvSdJrKquG7xR6qtxNlRkpx3LKQnrGP9WsV1ZsHG2KOD2O6mOe3cS
         bwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a+5iwKU/1c/swCFdTpX9vzDsm481ZGbz4NuaZisDpdA=;
        b=RZby9TsgK/Ej0owmoppTiY+0Se7rFhXn0E7wu0/EpvFd5yY1R6Czj77ZopyAIp1I7o
         2TWo/1kF5UtVvU81XwInNHCD+Lx+OXq8Q1QeHej/eBVAU0mVHtvVhWEzPbK5gsN92r4q
         r/f531JJuSKtpaWwX5pNTvs0I5awAyTndoZbSLtgC4WwKCHyh6PkerzrSuh60BhQbTyV
         tcrOXn0HHjwZKx+aHD5VTgoAOtU4OrTv1k8XqVZ1ni4mP/pbaulK3xz7QDyrdgGE5J9y
         x52EWnpBZ8Bw1O1NsLtIK+qk+pqw3ZlcFRDtg22+20cHsXAW1uBrWKdSASR1l18PcIJD
         sFrA==
X-Gm-Message-State: AOAM531/N7DxKZZbj7nEjsssUiV/jg2Z7ohw5AFZ2LTIVaobzq8bHpVL
        X7CVV44zjJhuzn3uBJLYfRE=
X-Google-Smtp-Source: ABdhPJwohC7X2e+s3xNZatip7FGxQ3JfqcHQvdS5HTnfk4uZ4C89NFAJ4szkc8nMjxTreQKa3NXyRw==
X-Received: by 2002:a37:2cc4:: with SMTP id s187mr4283176qkh.385.1606939159503;
        Wed, 02 Dec 2020 11:59:19 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8dbd])
        by smtp.gmail.com with ESMTPSA id y23sm2837067qkb.26.2020.12.02.11.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:59:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 14:58:50 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] blk-iocost: Factor out the active iocgs' state
 check into a separate function
Message-ID: <X8fx+oAz3jnrOMTF@mtj.duckdns.org>
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
 <6d2097e2aeb24281359e91b18c89ac8be7ca3ab3.1606378475.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d2097e2aeb24281359e91b18c89ac8be7ca3ab3.1606378475.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 26, 2020 at 04:16:14PM +0800, Baolin Wang wrote:
> Factor out the iocgs' state check into a separate function to
> simplify the ioc_timer_fn().
> 
> No functional change.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
