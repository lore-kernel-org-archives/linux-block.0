Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F149BC001DF
	for <linux-block@archiver.kernel.org>; Wed,  2 Aug 2023 09:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjHBJlU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Aug 2023 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHBJlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2023 05:41:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9801716;
        Wed,  2 Aug 2023 02:41:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0687A6732D; Wed,  2 Aug 2023 11:41:07 +0200 (CEST)
Date:   Wed, 2 Aug 2023 11:41:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dusty Mabe <dusty@dustymabe.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, marmijo@redhat.com
Subject: Re: XFS metadata CRC errors on zram block device on ppc64le
 architecture
Message-ID: <20230802094106.GA28187@lst.de>
Reply-To: wq@lst.de
References: <b2d40565-7868-ba15-4bb1-fca6f0df076b@dustymabe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d40565-7868-ba15-4bb1-fca6f0df076b@dustymabe.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 01, 2023 at 11:31:37PM -0400, Dusty Mabe wrote:
> We ran a kernel bisect and narrowed it down to offending commit af8b04c6:
> 
> ```
> [root@ibm-p8-kvm-03-guest-02 linux]# git bisect good
> af8b04c63708fa730c0257084fab91fb2a9cecc4 is the first bad commit
> commit af8b04c63708fa730c0257084fab91fb2a9cecc4
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Tue Apr 11 19:14:46 2023 +0200
> 
>     zram: simplify bvec iteration in __zram_make_request
>     
>     bio_for_each_segment synthetize bvecs that never cross page boundaries, so
>     don't duplicate that work in an inner loop.

> Any ideas on how to fix the problem?

So the interesting cases are:

  - ppc64 usually uses 64k page sizes
  - ppc64 is somewhat cache incoherent (compared to say x86)

Let me think of this a bit more.
