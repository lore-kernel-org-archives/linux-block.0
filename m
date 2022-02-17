Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57604C433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 06:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiBQGIu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 01:08:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiBQGIt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 01:08:49 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BB2C7D6B
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 22:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645078116; x=1676614116;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=m2kcHBEI7JLaKzxurYEKxslk3esMl6wjzgpM2u6BgEM=;
  b=T4NOnwb4yEsxnmHmQGCVUNzU5M1oUzLRydGed3qpbBmLcTdxDxwyS4LH
   GRoimF7Ez9Snscy62rmGWKE0DpYy7tXmkbT1u8yfp/m63/jynjQoiiTtM
   GzIWY3m3qF17U/IcVWB7oon9mQzcPUeDosxc+PgdIpgQ37LHv1NCbDYJa
   b9wB+cMyKI7LLh6Ewsptp5dQqhAIHhgScwUA2mVLZv65JebwxOAe0sx/P
   N02J7J+a6klrc7cLYSMjaBgFF+XGX+wi1ds74ySrJRlbQuEBVY3WhHqMY
   rZg3HWvwvP2m6Kz0Y9JuFi5t9humIeBWYZ4X9eMfsVnKNiQoCgRYNVKpH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="248400864"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="248400864"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 22:08:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="545390963"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 22:08:33 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
References: <20220131230255.789059-1-mfo@canonical.com>
        <Yfrh9F67ligMDUB7@google.com>
        <CAO9xwp3DNioiVPJNH9w-eXLxfVmTx9jBpOgq9eatpTFJTTg50Q@mail.gmail.com>
        <Yfr9UkEtLSHL2qhZ@google.com>
        <87o837cnnw.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Yg1zjHkctX0zkF+o@google.com>
Date:   Thu, 17 Feb 2022 14:08:31 +0800
In-Reply-To: <Yg1zjHkctX0zkF+o@google.com> (Yu Zhao's message of "Wed, 16 Feb
        2022 14:58:36 -0700")
Message-ID: <87zgmq6n4w.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Wed, Feb 16, 2022 at 02:48:19PM +0800, Huang, Ying wrote:
>> Yu Zhao <yuzhao@google.com> writes:
>> 
>> > On Wed, Feb 02, 2022 at 06:27:47PM -0300, Mauricio Faria de Oliveira wrote:
>> >> On Wed, Feb 2, 2022 at 4:56 PM Yu Zhao <yuzhao@google.com> wrote:
>> >> >
>> >> > On Mon, Jan 31, 2022 at 08:02:55PM -0300, Mauricio Faria de Oliveira wrote:
>> >> > > Problem:
>> >> > > =======
>> >> >
>> >> > Thanks for the update. A couple of quick questions:
>> >> >
>> >> > > Userspace might read the zero-page instead of actual data from a
>> >> > > direct IO read on a block device if the buffers have been called
>> >> > > madvise(MADV_FREE) on earlier (this is discussed below) due to a
>> >> > > race between page reclaim on MADV_FREE and blkdev direct IO read.
>> >> >
>> >> > 1) would page migration be affected as well?
>> >> 
>> >> Could you please elaborate on the potential problem you considered?
>> >> 
>> >> I checked migrate_pages() -> try_to_migrate() holds the page lock,
>> >> thus shouldn't race with shrink_page_list() -> with try_to_unmap()
>> >> (where the issue with MADV_FREE is), but maybe I didn't get you
>> >> correctly.
>> >
>> > Could the race exist between DIO and migration? While DIO is writing
>> > to a page, could migration unmap it and copy the data from this page
>> > to a new page?
>> 
>> Check the migrate_pages() code,
>> 
>>   migrate_pages
>>     unmap_and_move
>>       __unmap_and_move
>>         try_to_migrate // set PTE to swap entry with PTL
>>         move_to_new_page
>>           migrate_page
>>             folio_migrate_mapping
>>               folio_ref_count(folio) != expected_count // check page ref count
>>             folio_migrate_copy
>> 
>> The page ref count is checked after unmapping and before copying.  This
>> is good, but it appears that we need a memory barrier between checking
>> page ref count and copying page.
>
> I didn't look into this but, off the top of head, this should be
> similar if not identical to the DIO case. Therefore, it requires two
> barriers -- before and after the refcnt check (which may or may not
> exist).

Yes.  I think so too.

Best Regards,
Huang, Ying
