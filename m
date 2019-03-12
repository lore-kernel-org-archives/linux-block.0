Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D7EC43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 01:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001BC214AF
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 01:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfCLBWc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:22:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfCLBWc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 21:22:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17877307D848;
        Tue, 12 Mar 2019 01:22:32 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 022EF600CD;
        Tue, 12 Mar 2019 01:22:25 +0000 (UTC)
Date:   Tue, 12 Mar 2019 09:22:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 2/6] block: don't merge adjacent bvecs to one segment in
 bio blk_queue_split
Message-ID: <20190312012220.GC28841@ming.t460p>
References: <20190309013737.27741-1-ming.lei@redhat.com>
 <20190309013737.27741-3-ming.lei@redhat.com>
 <20190311142106.GB7850@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311142106.GB7850@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 12 Mar 2019 01:22:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 11, 2019 at 03:21:06PM +0100, Christoph Hellwig wrote:
> On Sat, Mar 09, 2019 at 09:37:33AM +0800, Ming Lei wrote:
> > For normal filesystem IO, each page is added via blk_add_page(),
> > in which bvec(page) merge has been handled already, and basically
> > not possible to merge two adjacent bvecs in one bio.
> > 
> > So not try to merge two adjacent bvecs in blk_queue_split(), also add
> > check if one page is mergeable to current bvec in bio_add_page() for
> > avoiding to break XEN.
> 
> Isn't this two entirely different things?  Both look good to me,
> but I don't understand why this is one patch vs two.

You are right, it should have been two things logically.

Thanks,
Ming
