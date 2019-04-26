Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA162C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 22:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C194B206DD
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 22:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfDZWXw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:23:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfDZWXv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 18:23:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C88593082E72;
        Fri, 26 Apr 2019 22:23:51 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3559460923;
        Fri, 26 Apr 2019 22:23:44 +0000 (UTC)
Date:   Sat, 27 Apr 2019 06:23:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH V3 1/3] lib/sg_pool.c: improve APIs for allocating sg pool
Message-ID: <20190426222338.GC31470@ming.t460p>
References: <20190426005346.27962-1-ming.lei@redhat.com>
 <20190426005346.27962-2-ming.lei@redhat.com>
 <20190426144928.GA18339@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426144928.GA18339@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 26 Apr 2019 22:23:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 04:49:28PM +0200, Christoph Hellwig wrote:
> On Fri, Apr 26, 2019 at 08:53:44AM +0800, Ming Lei wrote:
> > Introduces __sg_alloc_table_chained() and __sg_free_table_chained() with
> > one extra parameter to specify size of the pre-allocated SGL, then the
> > 'first_chunk' SGL can include any number of entries.
> 
> Can you just update the existing sg_alloc_table_chained and
> sg_free_table_chained chained instead?  We only have a handful users
> of them in total, and most of them should eventually use your new
> semantics anyway.

Yeah, I'd like to do that too.

Not do that in V3 just because both nvme and network change are
involved.

Will do this way if our maintainers don't object.

Thanks,
Ming
