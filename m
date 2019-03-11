Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52693C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 14:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD9B2084F
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 14:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfCKOVN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:21:13 -0400
Received: from verein.lst.de ([213.95.11.211]:41714 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfCKOVN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 10:21:13 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0448B68C7B; Mon, 11 Mar 2019 15:21:06 +0100 (CET)
Date:   Mon, 11 Mar 2019 15:21:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6] block: don't merge adjacent bvecs to one segment
 in bio blk_queue_split
Message-ID: <20190311142106.GB7850@lst.de>
References: <20190309013737.27741-1-ming.lei@redhat.com> <20190309013737.27741-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309013737.27741-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 09, 2019 at 09:37:33AM +0800, Ming Lei wrote:
> For normal filesystem IO, each page is added via blk_add_page(),
> in which bvec(page) merge has been handled already, and basically
> not possible to merge two adjacent bvecs in one bio.
> 
> So not try to merge two adjacent bvecs in blk_queue_split(), also add
> check if one page is mergeable to current bvec in bio_add_page() for
> avoiding to break XEN.

Isn't this two entirely different things?  Both look good to me,
but I don't understand why this is one patch vs two.
