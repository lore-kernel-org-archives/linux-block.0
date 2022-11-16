Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B66C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 21:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiKPV3Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiKPV3Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 16:29:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEC65E9D6
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:29:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65A31B81E96
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 21:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA46EC433D7;
        Wed, 16 Nov 2022 21:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668634161;
        bh=lF2wcsFNS3tp5cDZQlALyGmgyCpt9+zn/5uewQ381rw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gvkp6VG+zsE18LF5h2kWGer8lEFezoWDkW9VU4cbY5sjM0O5/RZ8yjgyWwNiULyTK
         L6JnLcivyjuoIHoh3tVkenGuzrX76mR9ScZc/eWFCSJhlJmURdVIUdanF4qfYbHkAD
         B0BMUyY8kOZ25QZforCMb84HQIEz9adzNYPvojG0=
Date:   Wed, 16 Nov 2022 13:29:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 10/14] mm: add bdi_get_min_bytes() function.
Message-Id: <20221116132920.312de0f71d6f21d46acc8aea@linux-foundation.org>
In-Reply-To: <20221024190603.3987969-11-shr@devkernel.io>
References: <20221024190603.3987969-1-shr@devkernel.io>
        <20221024190603.3987969-11-shr@devkernel.io>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Oct 2022 12:05:59 -0700 Stefan Roesch <shr@devkernel.io> wrote:

> This adds a function to return the specified value for min_bytes. It
> converts the stored min_ratio of the bdi to the corresponding bytes
> value. This is an approximation as it is based on the value that is
> returned by global_dirty_limits(), which can change. The returned
> value can be different than the value when the min_bytes value was set.
> 
> ...
>
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -105,6 +105,7 @@ static inline unsigned long wb_stat_error(void)
>  /* BDI ratio is expressed as part per 1000 for finer granularity. */
>  #define BDI_RATIO_SCALE 10
>  
> +unsigned long long bdi_get_min_bytes(struct backing_dev_info *bdi);

u64?

> +EXPORT_SYMBOL_GPL(bdi_get_min_bytes);

Needed?
