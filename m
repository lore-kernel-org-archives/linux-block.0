Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF93BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 01:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiALBqs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 20:46:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:11704 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234009AbiALBqr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 20:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641952007; x=1673488007;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ja5XEXe3L9WwTnPzS4XAGuR/jxoyzbCGm01nJS455Pw=;
  b=VkbtDtvVDu1xR1zhhQ71mDskxeoCu+gEWcNcpuMG5bcOiExWAj6lOwnF
   MRjGPSFhlMjgghW9GC4xNyuAT9TS34t8IJUCL3nSMjon1b/ekNhpHenkv
   n4Tq6bhaRGISt0QkY8G5vK1IgAh+EQMqnEyscg5OPeNMjHbMSUW3p8w+C
   BZxcq1JwhJnxj8YDkQWIvtHl5Fn8avZsGwqEeq80T4wiUXiajqJKhThzJ
   rSgJWGPZ3R+PDr03akNiIKWjZj1BMU2Vd7zSXVAIWkWbVXML8sR/NXKwZ
   CSHhhXyHEf6Dss6tPV1FAi1t/baMCiWezSeuoLmIkX29RwmL+fEUDtSHT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="329984941"
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="329984941"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 17:46:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="528982378"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 17:46:24 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
References: <20220105233440.63361-1-mfo@canonical.com>
        <Yd0oLWtVAyAexyQc@google.com>
Date:   Wed, 12 Jan 2022 09:46:23 +0800
In-Reply-To: <Yd0oLWtVAyAexyQc@google.com> (Yu Zhao's message of "Mon, 10 Jan
        2022 23:48:13 -0700")
Message-ID: <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 163ac4e6bcee..8671de473c25 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>  
>>  			/* MADV_FREE page check */
>>  			if (!PageSwapBacked(page)) {
>> -				if (!PageDirty(page)) {
>> +				int ref_count = page_ref_count(page);
>> +				int map_count = page_mapcount(page);
>> +
>> +				/*
>> +				 * The only page refs must be from the isolation
>> +				 * (checked by the caller shrink_page_list() too)
>> +				 * and one or more rmap's (dropped by discard:).
>> +				 *
>> +				 * Check the reference count before dirty flag
>> +				 * with memory barrier; see __remove_mapping().
>> +				 */
>> +				smp_rmb();
>> +				if ((ref_count - 1 == map_count) &&
>> +				    !PageDirty(page)) {
>>  					/* Invalidate as we cleared the pte */
>>  					mmu_notifier_invalidate_range(mm,
>>  						address, address + PAGE_SIZE);
>
> Out of curiosity, how does it work with COW in terms of reordering?
> Specifically, it seems to me get_page() and page_dup_rmap() in
> copy_present_pte() can happen in any order, and if page_dup_rmap()
> is seen first, and direct io is holding a refcnt, this check can still
> pass?

I think that you are correct.

After more thoughts, it appears very tricky to compare page count and
map count.  Even if we have added smp_rmb() between page_ref_count() and
page_mapcount(), an interrupt may happen between them.  During the
interrupt, the page count and map count may be changed, for example,
unmapped, or do_swap_page().

Best Regards,
Huang, Ying
