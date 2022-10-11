Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53784C433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 18:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJKSUT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKSUT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2022 14:20:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB10133E2B
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qzecNvEAd/3Dg0SsYsChABTL2C2tH/O8AsUWj1hnFcI=; b=NGCMNMiw48kZ4qCz/icSwGiMeZ
        o3g+twL7gPxReL7q1QxXz+DDVdl8EiimeEEFPVqZxgkjRcc84P9OLdTY5gzSWI6h7E1/Dt7bz8dDD
        jzUfcOvYkXlf8rO1kgz969f9NAFsP7ouwLyfh/vnHVtcq0M5SPMbC6SCcwI0wmYlNaoz71s960RTZ
        ylJAXLo68YgiVG0uBMV+hSbrIZ29HkKdoA54QldSEI1mOTqrzGP536G2rycwu5vDrQshIkVjUdLSm
        kQsvHZGWm2xCS34Sm4nVOSyrA9Uh0evjlhfCpYobLKY8oUveyHYVkJF6DHVfbXnP7mOYvMy/DFCV2
        DcguWYHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiJrP-005CRx-JF; Tue, 11 Oct 2022 18:20:11 +0000
Date:   Tue, 11 Oct 2022 19:20:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com
Subject: Re: [RFC PATCH v1 00/14] mm/block: add bdi sysfs knobs
Message-ID: <Y0Wz28QzRtH+72Pu@casper.infradead.org>
References: <20221011010044.851537-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011010044.851537-1-shr@devkernel.io>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 10, 2022 at 06:00:30PM -0700, Stefan Roesch wrote:
> 2) Part of 10000 internal calculation
>   The max_ratio is based on percentage. With the current machine sizes percentage
>   values can be very high (1% of a 256GB main memory is already 2.5GB). This change
>   uses part of 10000 instead of percentages for the internal calculations.

Why 10,000?  If you need better accuracy than 1/1000, the next step
should normally be parts per million.
