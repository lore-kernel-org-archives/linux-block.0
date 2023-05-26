Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850B8C77B7C
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 05:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjEZFgC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 01:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjEZFgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 01:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D941A4;
        Thu, 25 May 2023 22:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 944F464CC2;
        Fri, 26 May 2023 05:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24D6C4339B;
        Fri, 26 May 2023 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685079359;
        bh=SBy/V1XGvQa9U7b0SSSlskCOsczWK9EZtJih3sffwtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojcFBIDzo6GTdw8CASYmJXXIKgRmqwnKiReeAlMViuuagW/rSQH0e3EFafEDyU2ob
         MiJX0go5Kvk8AFDECpL24C23WMzHjksUYKLw2xJ46yJB79XGCG7HptODIKI+q6ah3y
         gSZciHVlOVEnxgva3IFZwXoAvQnlmqwdFL9Q72cyVZoswDXme7x2W5l9/Qm0+pPw4w
         xb5Lczon18dzSrh+RLtnMFsY3TkbB48Als+8wmRuQaTgcsHRVgsSgZglYw2DDe+Ojg
         wyJtRbXbXh4r5s06TF71vsCo53Lw6sCNGRg6v2eiA1n24mOBvikwza698Tly2EBpNh
         FcRw1EdK6t1dg==
Date:   Thu, 25 May 2023 22:35:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Zhong Jinghua <zhongjinghua@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH -next v2] block: Fix the partition start may overflow in
 add_partition()
Message-ID: <20230526053557.GA875@sol.localdomain>
References: <20230525072041.3701176-1-zhongjinghua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525072041.3701176-1-zhongjinghua@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 25, 2023 at 03:20:41PM +0800, Zhong Jinghua wrote:
> +	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
> +		return -EINVAL;

Were zero-length partitions allowed before?

- Eric
