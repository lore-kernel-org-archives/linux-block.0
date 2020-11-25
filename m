Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BB5C5519F
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 11:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B078206D4
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 11:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c80TixwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgKYLbm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 06:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgKYLbm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 06:31:42 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21105C0613D4;
        Wed, 25 Nov 2020 03:31:42 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id k8so1821650ilr.4;
        Wed, 25 Nov 2020 03:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AxD8Lx1wPAcMK6c6Xgjc4ejsoSw94YMc+Ttgjs3yeUM=;
        b=c80TixwYUTz2wiaDaHm+1xsWy0qLfA1KXCix1FHrretd49PKUURcCVtdvrPtRYwupk
         6aJAMo104wFylCtBb8+JLhsDusChCmC+4V5LTEFXz0eGoiXfs8U7ybhYrWVi0XMbRfO/
         FHH/wp4iEY3K5xzoMuwPSRXE67szrtoBNi5NaCLFlvzL8HdXtQpea2pSBeaDNmfY0hjb
         nMAOQYRFL0KxKChFUYUrraWU3Mova3cuBHcg/ZfjOadKcLB68Y77ZDVJWyJ9GM3Zs4BM
         w8vMSYbbai+NG2wyJLdtCOEfK0SqZJ/u/Ol0VM5I8+oB592k8buf2+Wbzg568YR5bv/f
         DkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AxD8Lx1wPAcMK6c6Xgjc4ejsoSw94YMc+Ttgjs3yeUM=;
        b=RnU1Kci44V9gCzKjnzmMbfB2pcKTtDQ/aUAGXv5N/OaUf5bqPCEyYFz3jTDhazA4j1
         2zF/+GXn/v3u5JNBU4STrsqyKuYQJ+qwvbPiewv04Cwg8XGnELgBJfD5iDlI4r40LYfo
         BYH1VNf29vWcTMoYcobvOqPMCA4XzvxRMZQm+bXCljMagbz91qs2UfyWv7bTUvUmqZtM
         lARjGXYg3v8ym/B06B5UCeoPgAcNFfrIC9MBCMu9CjE5eKcyjWFRcUjxcj33wAWJZFZD
         RPVaTFY8YcuX/Q1fY8XnI65P2AisREYnaN6QmzGnb0iJiPGg6TGpfy1OUjPPFw6lhNzC
         JBWQ==
X-Gm-Message-State: AOAM5309cK0B9to3imGXIvEFW4MU7NjXKY7acRlD7RBicBOpbgRBdl/E
        UfT/x668e28Z3Ky8aPm+Pi1CKU/57JHGNA==
X-Google-Smtp-Source: ABdhPJy7BORE25DpWvxPwvWc2Hqkp5SVBIzI1DHOXNUZ6VWWvja9+nFEUePzUbkzNg4ZDgB493Mvuw==
X-Received: by 2002:a92:cc52:: with SMTP id t18mr2424477ilq.124.1606303901350;
        Wed, 25 Nov 2020 03:31:41 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id n1sm1197750ile.86.2020.11.25.03.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 03:31:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 06:31:19 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] blk-iocost: Remove unnecessary advance declaration
Message-ID: <X75Ah8qy3m0rchQl@mtj.duckdns.org>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <aebd196113ec2086a92cb05c158c02591caa8079.1606186717.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aebd196113ec2086a92cb05c158c02591caa8079.1606186717.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 24, 2020 at 11:33:31AM +0800, Baolin Wang wrote:
> Remove unnecessary advance declaration of struct ioc_gq.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
