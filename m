Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23493C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 21:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiKPV3A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiKPV26 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 16:28:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E79D21E1A
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:28:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B525E61F8E
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 21:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A42C433D6;
        Wed, 16 Nov 2022 21:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668634137;
        bh=/9l0Nf4U9WJvdT9Wc61RdT3/RrfG2M/RnBHBsLG8M94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KvovNXgtvaouAjH2iKqipsJoslPMbuawfIKg+OM9a8F+3WpVOijHt8yn6xaUAO5HT
         xQnaYkg/ILGIesKQ03EFkTo8LSvJBEwatobpG37stPoWlVwLQYaRsCxNmtP+puO+Ap
         P9w+Wwvuc0d6agsz3kUd3T5bJ5123NTJcDujCuu0=
Date:   Wed, 16 Nov 2022 13:28:56 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 01/14] mm: add bdi_set_strict_limit() function
Message-Id: <20221116132856.b3403e3ae1e39cc3a7a4f865@linux-foundation.org>
In-Reply-To: <20221024190603.3987969-2-shr@devkernel.io>
References: <20221024190603.3987969-1-shr@devkernel.io>
        <20221024190603.3987969-2-shr@devkernel.io>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Oct 2022 12:05:50 -0700 Stefan Roesch <shr@devkernel.io> wrote:

> This adds the bdi_set_strict_limit function to be able to set/unset the
> BDI_CAP_STRICTLIMIT flag.
> 
> ...
>
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -698,6 +698,22 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned max_ratio)
>  }
>  EXPORT_SYMBOL(bdi_set_max_ratio);
>  
> +int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int strict_limit)
> +{
> +	if (strict_limit > 1)
> +		return -EINVAL;
> +
> +	spin_lock_bh(&bdi_lock);
> +	if (strict_limit)
> +		bdi->capabilities |= BDI_CAP_STRICTLIMIT;
> +	else
> +		bdi->capabilities &= ~BDI_CAP_STRICTLIMIT;
> +	spin_unlock_bh(&bdi_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bdi_set_strict_limit);

I don't believe the export is needed?
