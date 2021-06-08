Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC83C4743E
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 16:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49DB561278
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 16:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhFHQj7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:39:59 -0400
Received: from verein.lst.de ([213.95.11.211]:51622 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhFHQj7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 12:39:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D48367373; Tue,  8 Jun 2021 18:38:02 +0200 (CEST)
Date:   Tue, 8 Jun 2021 18:38:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org
Subject: Re: [PATCH 08/16] dm-writecache: use bvec_kmap_local instead of
 bvec_kmap_irq
Message-ID: <20210608163802.GA12173@lst.de>
References: <20210608160603.1535935-1-hch@lst.de> <20210608160603.1535935-9-hch@lst.de> <4c248453-713f-9da8-04e8-7939388be49a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c248453-713f-9da8-04e8-7939388be49a@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 08, 2021 at 09:30:56AM -0700, Bart Van Assche wrote:
> >From one of the functions called by kunmap_local():
> 
> unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
> 
> This won't work well if bvec->bv_offset >= PAGE_SIZE I assume?

It won't indeed.  Both the existing and new helpers operate on single
page bvecs only, and all callers only use those.  I should have
probably mentioned that in the cover letter and documented the
assumptions in the code, though.
