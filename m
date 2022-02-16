Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB97C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 06:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiBPGxn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 01:53:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBPGxm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 01:53:42 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027C028572B
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 22:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644994402; x=1676530402;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=q8LqAYTT+rCKLBOuXOQb7rqDPKP6It+owG5+PV14lP8=;
  b=B6gaBh9S95C09fub2S/Sbn0abuf0CMIzBcmje7Iqqe9ViYX8rvRELpRI
   gIny5VowJAdBVdQamI4nNgsbSY2sc0KrygJ7UAhK0vujPvGQX9HuOeF3+
   rW4aaUg+nOLDqU+f75lB7CV7X6YSjOkthY5b00VRYySF4ikXYGK8hEr6u
   0Fp80RFPngbCWG+KOkA9UJdVA+OEQdfxMJe9lA1smh9vPqFIsnO9BCtCs
   SzsRtxh9S/d5/tumFrhrIDq71EtezP0uOSgieSkMxzU2cqU10/vjv5H9E
   DloPh/ItkDAG7in/bOQ9d8fD8zZAcmvsyNcCARPqgHZzQU2NR4TXwltdP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="248134098"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="248134098"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:48:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="633342319"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:48:21 -0800
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
Date:   Wed, 16 Feb 2022 14:48:19 +0800
In-Reply-To: <Yfr9UkEtLSHL2qhZ@google.com> (Yu Zhao's message of "Wed, 2 Feb
        2022 14:53:22 -0700")
Message-ID: <87o837cnnw.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Wed, Feb 02, 2022 at 06:27:47PM -0300, Mauricio Faria de Oliveira wrote:
>> On Wed, Feb 2, 2022 at 4:56 PM Yu Zhao <yuzhao@google.com> wrote:
>> >
>> > On Mon, Jan 31, 2022 at 08:02:55PM -0300, Mauricio Faria de Oliveira wrote:
>> > > Problem:
>> > > =======
>> >
>> > Thanks for the update. A couple of quick questions:
>> >
>> > > Userspace might read the zero-page instead of actual data from a
>> > > direct IO read on a block device if the buffers have been called
>> > > madvise(MADV_FREE) on earlier (this is discussed below) due to a
>> > > race between page reclaim on MADV_FREE and blkdev direct IO read.
>> >
>> > 1) would page migration be affected as well?
>> 
>> Could you please elaborate on the potential problem you considered?
>> 
>> I checked migrate_pages() -> try_to_migrate() holds the page lock,
>> thus shouldn't race with shrink_page_list() -> with try_to_unmap()
>> (where the issue with MADV_FREE is), but maybe I didn't get you
>> correctly.
>
> Could the race exist between DIO and migration? While DIO is writing
> to a page, could migration unmap it and copy the data from this page
> to a new page?

Check the migrate_pages() code,

  migrate_pages
    unmap_and_move
      __unmap_and_move
        try_to_migrate // set PTE to swap entry with PTL
        move_to_new_page
          migrate_page
            folio_migrate_mapping
              folio_ref_count(folio) != expected_count // check page ref count
            folio_migrate_copy

The page ref count is checked after unmapping and before copying.  This
is good, but it appears that we need a memory barrier between checking
page ref count and copying page.

Best Regards,
Huang, Ying
