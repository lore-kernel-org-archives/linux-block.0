Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD4C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 14:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC172075C
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 14:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfCKOQO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:16:14 -0400
Received: from verein.lst.de ([213.95.11.211]:41681 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfCKOQO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 10:16:14 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 154C368C7B; Mon, 11 Mar 2019 15:16:09 +0100 (CET)
Date:   Mon, 11 Mar 2019 15:16:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] block: pass page to xen_biovec_phys_mergeable
Message-ID: <20190311141608.GA7850@lst.de>
References: <20190309013737.27741-1-ming.lei@redhat.com> <20190309013737.27741-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309013737.27741-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 09, 2019 at 09:37:32AM +0800, Ming Lei wrote:
> xen_biovec_phys_mergeable() only needs .bv_page of the 2nd bio bvec
> for checking if the two bvecs can be merged, so pass page to
> xen_biovec_phys_mergeable() directly.

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
