Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ECCC433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 21:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiKPVay (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiKPV3L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 16:29:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F248C4E412
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:29:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BD04B81D80
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 21:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A079C433D7;
        Wed, 16 Nov 2022 21:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668634145;
        bh=QHSo4QpYq5gY8cAcFM8PoSPCkW4GshAkMsc3XfMpcb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tSQFilJNiVyK1qnw8LLv1DQ3LIFh1RmpvAwCC70nihbEzRMnXSiiXGN76GsPcY6JO
         rfXQJORynMorZbXvfQrU8s+rnT3FihV0wI0KOvXYI7RBBwq/q/oExkhlillnk7WVbX
         odsLarlUQAIVwmdIt9TCKRt3xIdvRwYeCdMMbBOs=
Date:   Wed, 16 Nov 2022 13:29:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 05/14] mm: add bdi_get_max_bytes() function
Message-Id: <20221116132904.516884bc7eec135cfcd326a7@linux-foundation.org>
In-Reply-To: <20221024190603.3987969-6-shr@devkernel.io>
References: <20221024190603.3987969-1-shr@devkernel.io>
        <20221024190603.3987969-6-shr@devkernel.io>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Oct 2022 12:05:54 -0700 Stefan Roesch <shr@devkernel.io> wrote:

> This adds a function to return the specified value for max_bytes. It
> converts the stored max_ratio of the bdi to the corresponding bytes
> value. It introduces the bdi_get_bytes helper function to do the
> conversion. This is an approximation as it is based on the value that is
> returned by global_dirty_limits(), which can change. The helper function
> will also be used by the min_bytes bdi knob.
> 
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -105,6 +105,7 @@ static inline unsigned long wb_stat_error(void)
>  /* BDI ratio is expressed as part per 1000 for finer granularity. */
>  #define BDI_RATIO_SCALE 10
>  
> +unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi);

We don't use unsigned long long much.  If you want a 64-bit unsigned,
use u64?

> +EXPORT_SYMBOL_GPL(bdi_get_max_bytes);

Is this symbol to be used by modules?
