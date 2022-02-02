Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED39C433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 19:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiBBT4n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 14:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBBT4l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 14:56:41 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D3DC061714
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 11:56:41 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id i62so488504ioa.1
        for <linux-block@vger.kernel.org>; Wed, 02 Feb 2022 11:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x4EmlywqkQoylNhYBRuox6SRIiEzbwhPvfKpjSJFK+M=;
        b=l3voQQKWVSw3dmBrF5gUp9aqpe/kM74Ejxd2FckHK9neSs+1XDuSJpA1Zxtl7mTiEv
         xVVWK4HM3L046ckQ+54VeBw2/Yc8RSk9uX9GRaIr/nAXRxm3bTeTv3oD71hWXYz/72RI
         edo/FL5fq09HoNxNCCNBpYLeL1D5Wdj3qXLQiVI2U5blnh7DGSLt2NAg5Rbyq6lgfAf5
         gH34Fe3fgkgt/j+CS66yaUO03MfsBOHNwgYUyD5DUR7JfJKRiOlwskHiuP1Egvj8opAP
         snR7ewmzBpyzcytDK4brGeWYoOeKLsilZm2w1l92jmMgws9QBX/wn0XbDIq3b32e696y
         UC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x4EmlywqkQoylNhYBRuox6SRIiEzbwhPvfKpjSJFK+M=;
        b=tS+FDHjyv3SdpJ8XNapSkz62UeyUoT/50dQzyN68QZSzW4DDG6gzG0QyT99uzlWVbT
         SAhBd6mf96zXg7uNDrxyrz7p8IF3PBp5h5xonsHL++mCJHK+3zD1dh7YeEjQtrpTFLnc
         OEfIHwCcNhkmu2Mci9w+rYosHqGn6un6oywWlH7pLnjXFh8zpRqmi9xTAT4IN43FXFcq
         ANWtI9u/b25qP9sdgoXabcGsLWztzVLC9SjGTCg+DcA8KMFUGiFvaghluDMfqR9du3n+
         oJwF3kXLs+S4HQZgwgTWuWQn18imWhfEdKF5Eht5MJBQ0dHPDPI7S4ILSfBUhxT4LSvA
         sGGQ==
X-Gm-Message-State: AOAM53198Cq2wml7dXNm8bFjSktBxsm4roawdtkG5rvIwrzo1PFXcjOV
        YbsG0Lf8o37y+B0WA4+5ahtQyrcTW+C0LQ==
X-Google-Smtp-Source: ABdhPJzFUw2pmEPSNA9INY7/MGXp6OqK7XCDhMp7FMvJtW2oqoJ0wtwNI5ZO2AdTz42lwV/iio4RYw==
X-Received: by 2002:a05:6638:329a:: with SMTP id f26mr10431290jav.28.1643831800333;
        Wed, 02 Feb 2022 11:56:40 -0800 (PST)
Received: from google.com ([2620:15c:183:200:a1e5:3cc4:4458:6ce8])
        by smtp.gmail.com with ESMTPSA id h13sm21709954ili.31.2022.02.02.11.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 11:56:39 -0800 (PST)
Date:   Wed, 2 Feb 2022 12:56:36 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <Yfrh9F67ligMDUB7@google.com>
References: <20220131230255.789059-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131230255.789059-1-mfo@canonical.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 31, 2022 at 08:02:55PM -0300, Mauricio Faria de Oliveira wrote:
> Problem:
> =======

Thanks for the update. A couple of quick questions:

> Userspace might read the zero-page instead of actual data from a
> direct IO read on a block device if the buffers have been called
> madvise(MADV_FREE) on earlier (this is discussed below) due to a
> race between page reclaim on MADV_FREE and blkdev direct IO read.

1) would page migration be affected as well?

> @@ -1599,7 +1599,30 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  
>  			/* MADV_FREE page check */
>  			if (!PageSwapBacked(page)) {
> -				if (!PageDirty(page)) {
> +				int ref_count, map_count;
> +
> +				/*
> +				 * Synchronize with gup_pte_range():
> +				 * - clear PTE; barrier; read refcount
> +				 * - inc refcount; barrier; read PTE
> +				 */
> +				smp_mb();
> +
> +				ref_count = page_count(page);
> +				map_count = page_mapcount(page);
> +
> +				/*
> +				 * Order reads for page refcount and dirty flag;
> +				 * see __remove_mapping().
> +				 */
> +				smp_rmb();

2) why does it need to order against __remove_mapping()? It seems to
   me that here (called from the reclaim path) it can't race with
   __remove_mapping() because both lock the page.

> +				/*
> +				 * The only page refs must be from the isolation
> +				 * plus one or more rmap's (dropped by discard:).
> +				 */
> +				if ((ref_count == 1 + map_count) &&
> +				    !PageDirty(page)) {
>  					/* Invalidate as we cleared the pte */
>  					mmu_notifier_invalidate_range(mm,
>  						address, address + PAGE_SIZE);
