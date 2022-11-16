Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D320C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 21:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiKPV3U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiKPV3T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 16:29:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B054AF03
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:29:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41CE961FC7
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 21:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBEFC433D6;
        Wed, 16 Nov 2022 21:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668634157;
        bh=djYHaWyhxCzztBQzBwasQx+gb86ZzrqajkqDb8YKU80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LAo1yjsrG0zroAlo8F7QbbvejLzWRMmfW6kWVO5fNKKjSUdmZ06EvfMydP62jh0Ok
         VVX69eSLVE9jdU94cGOU/vEjht8kCLeWuDfsjzO7pN4pwLZAS7K7PtvGx9fZuNHQnL
         OGnBQ/cmgN/NwAHiSd9eKWNzVI2cVWt8wDW2cJKE=
Date:   Wed, 16 Nov 2022 13:29:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 07/14] mm: add bdi_set_max_bytes() function.
Message-Id: <20221116132916.564a26142c1f15c8553edb9f@linux-foundation.org>
In-Reply-To: <20221024190603.3987969-8-shr@devkernel.io>
References: <20221024190603.3987969-1-shr@devkernel.io>
        <20221024190603.3987969-8-shr@devkernel.io>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Oct 2022 12:05:56 -0700 Stefan Roesch <shr@devkernel.io> wrote:

> This introduces the bdi_set_max_bytes() function. The max_bytes function
> does not store the max_bytes value. Instead it converts the max_bytes
> value into the corresponding ratio value.
> 
> ...
>
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -108,6 +108,7 @@ static inline unsigned long wb_stat_error(void)
>  unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi);
>  int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_ratio);
>  int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
> +int bdi_set_max_bytes(struct backing_dev_info *bdi, unsigned long long max_bytes);
>  int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int strict_limit);
>  
>  /*
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 8b8936603783..21d7c1880ea8 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include <linux/export.h>
>  #include <linux/spinlock.h>
>  #include <linux/fs.h>
> @@ -650,6 +651,28 @@ void wb_domain_exit(struct wb_domain *dom)
>   */
>  static unsigned int bdi_min_ratio;
>  
> +static int bdi_check_pages_limit(unsigned long pages)
> +{
> +	unsigned long max_dirty_pages = global_dirtyable_memory();
> +
> +	if (pages > max_dirty_pages / 2)
> +		return -EINVAL;
> +
> +	return 0;
> +}

Some code comments are needed here.  Explain what it does and why it
does it.  The "/ 2" seems utterly arbitray - explain why this value was
chosen?  Why is it better than "/ 3"?



> +static unsigned long bdi_ratio_from_pages(unsigned long pages)
> +{
> +	unsigned long background_thresh;
> +	unsigned long dirty_thresh;
> +	unsigned long ratio;
> +
> +	global_dirty_limits(&background_thresh, &dirty_thresh);
> +	ratio = div64_u64(pages * 100ULL * BDI_RATIO_SCALE, dirty_thresh);

`unsigned long' is 32-bit on 32-bit machines, which makes this code a
bit odd.  Should everything here be u64?


