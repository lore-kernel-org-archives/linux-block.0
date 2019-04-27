Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E5BC43218
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 05:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDB02087C
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 05:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfD0Fpl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Apr 2019 01:45:41 -0400
Received: from verein.lst.de ([213.95.11.211]:52122 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfD0Fpl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Apr 2019 01:45:41 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5D30068BFE; Sat, 27 Apr 2019 07:45:24 +0200 (CEST)
Date:   Sat, 27 Apr 2019 07:45:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH V3 1/3] lib/sg_pool.c: improve APIs for allocating sg
 pool
Message-ID: <20190427054524.GA21401@lst.de>
References: <20190426005346.27962-1-ming.lei@redhat.com> <20190426005346.27962-2-ming.lei@redhat.com> <20190426144928.GA18339@lst.de> <20190426222338.GC31470@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426222338.GC31470@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 27, 2019 at 06:23:39AM +0800, Ming Lei wrote:
> On Fri, Apr 26, 2019 at 04:49:28PM +0200, Christoph Hellwig wrote:
> > On Fri, Apr 26, 2019 at 08:53:44AM +0800, Ming Lei wrote:
> > > Introduces __sg_alloc_table_chained() and __sg_free_table_chained() with
> > > one extra parameter to specify size of the pre-allocated SGL, then the
> > > 'first_chunk' SGL can include any number of entries.
> > 
> > Can you just update the existing sg_alloc_table_chained and
> > sg_free_table_chained chained instead?  We only have a handful users
> > of them in total, and most of them should eventually use your new
> > semantics anyway.
> 
> Yeah, I'd like to do that too.
> 
> Not do that in V3 just because both nvme and network change are
> involved.
> 
> Will do this way if our maintainers don't object.

sunrpc is maintained by the network maintainers, and the rdma code that
is calling this in particular has been herded by Chuck Lever.  Add them
to Cc, I bet they won't object to the trivial paramter change.  In fact
I wouldn't be surprised if they'd be interested in the smaller inline
SGLs as well for next merge window.
