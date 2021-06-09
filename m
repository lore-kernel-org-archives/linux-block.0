Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A09C48BCD
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 01:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFC56128A
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 01:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhFICBi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 22:01:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:29091 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233303AbhFICBi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 22:01:38 -0400
IronPort-SDR: QuqK2AfQBH5SR3aZ+/OC+eIwTGcibSsd/qUNvBIFl3jDSyoBaz4k5mJhJiinGtYH1bnYDdP+Gj
 0kX+kus9ntWg==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="268841742"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="268841742"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 18:59:44 -0700
IronPort-SDR: l5m0zsMDo0S/BY6flob2JC9Z0fcbfXs0snnKIkUOGNUZsN5SIUPiUFSjvaStBruug7QhFYdMqJ
 TyBwGFTSV0lA==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="482201365"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 18:59:44 -0700
Date:   Tue, 8 Jun 2021 18:59:43 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org
Subject: Re: switch the block layer to use kmap_local_page
Message-ID: <20210609015943.GV3697498@iweiny-DESK2.sc.intel.com>
References: <20210608160603.1535935-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608160603.1535935-1-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 08, 2021 at 06:05:47PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series switches the core block layer code and all users of the
> existing bvec kmap helpers to use kmap_local_page.  Drivers that
> currently use open coded kmap_atomic calls will converted in a follow
> on series.

Other than the missing flush_dcache's.

For the series.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Diffstat:
>  arch/mips/include/asm/mach-rc32434/rb.h |    2 -
>  block/bio-integrity.c                   |   14 ++++------
>  block/bio.c                             |   37 +++++++---------------------
>  block/blk-map.c                         |    2 -
>  block/bounce.c                          |   35 ++++++--------------------
>  block/t10-pi.c                          |   16 ++++--------
>  drivers/block/ps3disk.c                 |   19 ++------------
>  drivers/block/rbd.c                     |   15 +----------
>  drivers/md/dm-writecache.c              |    5 +--
>  include/linux/bio.h                     |   42 --------------------------------
>  include/linux/bvec.h                    |   27 ++++++++++++++++++--
>  include/linux/highmem.h                 |    4 +--
>  12 files changed, 64 insertions(+), 154 deletions(-)
