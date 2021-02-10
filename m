Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB11C433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 13:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E42B64E16
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 13:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhBJNmI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 08:42:08 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53342 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhBJNmG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 08:42:06 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Feb 2021 08:42:04 EST
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id 356713fafb91dd28; Wed, 10 Feb 2021 14:34:38 +0100
Received: from kreacher.localnet (89-64-80-225.dynamic.chello.pl [89.64.80.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 193DE6608F9;
        Wed, 10 Feb 2021 14:34:37 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] mm: simplify swapdev_block
Date:   Wed, 10 Feb 2021 14:34:37 +0100
Message-ID: <6090993.SemHdl1DLP@kreacher>
In-Reply-To: <20210209171419.4003839-2-hch@lst.de>
References: <20210209171419.4003839-1-hch@lst.de> <20210209171419.4003839-2-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrheejgdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttddvnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfelheffhfetffelhfelteejffetteetgfetkeejvdfhfeeftdeufeevgeevieevnecukfhppeekledrieegrdektddrvddvheenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrvddvhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tuesday, February 9, 2021 6:14:19 PM CET Christoph Hellwig wrote:
> Open code the parts of map_swap_entry that was actually used by
> swapdev_block, and remove the now unused map_swap_entry function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  mm/swapfile.c | 30 +++---------------------------
>  1 file changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 351999a84e6e4e..21a98cb8d646e3 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1790,9 +1790,6 @@ int free_swap_and_cache(swp_entry_t entry)
>  }
>  
>  #ifdef CONFIG_HIBERNATION
> -
> -static sector_t map_swap_entry(swp_entry_t, struct block_device**);
> -
>  /*
>   * Find the swap type that corresponds to given device (if any).
>   *
> @@ -1852,12 +1849,13 @@ int find_first_swap(dev_t *device)
>   */
>  sector_t swapdev_block(int type, pgoff_t offset)
>  {
> -	struct block_device *bdev;
>  	struct swap_info_struct *si = swap_type_to_swap_info(type);
> +	struct swap_extent *se;
>  
>  	if (!si || !(si->flags & SWP_WRITEOK))
>  		return 0;
> -	return map_swap_entry(swp_entry(type, offset), &bdev);
> +	se = offset_to_swap_extent(si, offset);
> +	return se->start_block + (offset - se->start_page);
>  }
>  
>  /*
> @@ -2283,28 +2281,6 @@ static void drain_mmlist(void)
>  	spin_unlock(&mmlist_lock);
>  }
>  
> -#ifdef CONFIG_HIBERNATION
> -/*
> - * Use this swapdev's extent info to locate the (PAGE_SIZE) block which
> - * corresponds to page offset for the specified swap entry.
> - * Note that the type of this function is sector_t, but it returns page offset
> - * into the bdev, not sector offset.
> - */
> -static sector_t map_swap_entry(swp_entry_t entry, struct block_device **bdev)
> -{
> -	struct swap_info_struct *sis;
> -	struct swap_extent *se;
> -	pgoff_t offset;
> -
> -	sis = swp_swap_info(entry);
> -	*bdev = sis->bdev;
> -
> -	offset = swp_offset(entry);
> -	se = offset_to_swap_extent(sis, offset);
> -	return se->start_block + (offset - se->start_page);
> -}
> -#endif
> -
>  /*
>   * Free all of a swapdev's extent information
>   */
> 




