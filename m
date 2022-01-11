Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5970C433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 06:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiAKGsU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 01:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348284AbiAKGsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 01:48:18 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95222C061751
        for <linux-block@vger.kernel.org>; Mon, 10 Jan 2022 22:48:18 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id o1so13453172ilo.6
        for <linux-block@vger.kernel.org>; Mon, 10 Jan 2022 22:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ITfgoI/hkOmitkObr0MHrURTFUggwhsmZdLLG4Gu2M=;
        b=GABoh6pTU+pkl9fJ9X9wQyh8l3BAM0EjSTJ8UZIw0e63NG2i+GA0fm1hYaysk5wJN/
         H6rs77qHpwEimHUe1jN16hBsJvebs6S6fU8PUu1jDtpC9JDJcieelEGDirjE0k1vGY/6
         evh2E5j4Td1nsfFrfbq6WvpWZo/Ivt2UBOK5ModiZ8TiC6NvdCFgUAXQEhe/94cZ8avk
         7WH8xDyE0nNWwbHlSFq8P0vDA0Fs56hR7Y0O7DjoXqVO5TfLrnMVeGRrZwhJKPL5e7R7
         vYs3TXmDX0vytbI8UQyI4rdkpOTLj0bu+BSlUn7jhUsKuQolqvkehX/TepcNEfU6lMt8
         58nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ITfgoI/hkOmitkObr0MHrURTFUggwhsmZdLLG4Gu2M=;
        b=lxPgbXaqBjVqPkq4RNa7Anw6GkmIqhrDNQE7tVhjOPl4A1lR8zSpDHW+HfFhjQUCfj
         amDjMlevoJGY24WE7GVG07kx4qm7UWLwWAlA8/3ML3Wj+PI6vE0JcZlu6i+JjSuODOYk
         9INbnb2OP1Cyj/lLWiXKu/GxjA9cWuiuqz6IXLsXct7QiGG0pFac1xRRTESmXFr0OiP3
         ZLY54XQ8CKoK1JkyYK/eW2ewb/UvpLRnoWK7IhEBoKwCJenGNH4S7u8H4jcVIKGFxl+u
         6ywafm+DU3k9Ox7xYprCELy22VxWbfUb1cA4uD9eNfcqpcWpC2yXIII8+oQml6IQiIP5
         W1tg==
X-Gm-Message-State: AOAM533UYHQBgzeGDUWqNxROV3uZiqo0nFtq7+93S9yz0MFRs67DJ0m9
        +BSXBVHOYTTsXOs6xbFsGIKuOQ==
X-Google-Smtp-Source: ABdhPJxkBBT+vJl/fMTZBYKd1S3+ewDILh1A0DcwFOkufVI7CJv0nZmtTj3GQxdMLl6jqhJ6R/uVQw==
X-Received: by 2002:a05:6e02:12ee:: with SMTP id l14mr1645211iln.313.1641883697841;
        Mon, 10 Jan 2022 22:48:17 -0800 (PST)
Received: from google.com ([2620:15c:183:200:bdd9:6181:19a:9d62])
        by smtp.gmail.com with ESMTPSA id n6sm4481201ili.60.2022.01.10.22.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 22:48:17 -0800 (PST)
Date:   Mon, 10 Jan 2022 23:48:13 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <Yd0oLWtVAyAexyQc@google.com>
References: <20220105233440.63361-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105233440.63361-1-mfo@canonical.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 163ac4e6bcee..8671de473c25 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  
>  			/* MADV_FREE page check */
>  			if (!PageSwapBacked(page)) {
> -				if (!PageDirty(page)) {
> +				int ref_count = page_ref_count(page);
> +				int map_count = page_mapcount(page);
> +
> +				/*
> +				 * The only page refs must be from the isolation
> +				 * (checked by the caller shrink_page_list() too)
> +				 * and one or more rmap's (dropped by discard:).
> +				 *
> +				 * Check the reference count before dirty flag
> +				 * with memory barrier; see __remove_mapping().
> +				 */
> +				smp_rmb();
> +				if ((ref_count - 1 == map_count) &&
> +				    !PageDirty(page)) {
>  					/* Invalidate as we cleared the pte */
>  					mmu_notifier_invalidate_range(mm,
>  						address, address + PAGE_SIZE);

Out of curiosity, how does it work with COW in terms of reordering?
Specifically, it seems to me get_page() and page_dup_rmap() in
copy_present_pte() can happen in any order, and if page_dup_rmap()
is seen first, and direct io is holding a refcnt, this check can still
pass?
