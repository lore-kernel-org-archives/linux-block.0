Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16475C04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 13:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FFF21479
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 13:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfEINbj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 09:31:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfEINbj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 May 2019 09:31:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 018AFC0753A1;
        Thu,  9 May 2019 13:31:39 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA7F18162;
        Thu,  9 May 2019 13:31:29 +0000 (UTC)
Date:   Thu, 9 May 2019 21:31:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     keith.busch@intel.com, sagi@grimberg.me, axboe@fb.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme-pci: fix single segment detection
Message-ID: <20190509133120.GA22059@ming.t460p>
References: <20190509110409.19647-1-hch@lst.de>
 <20190509112410.GA20711@ming.t460p>
 <20190509123406.GB21483@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509123406.GB21483@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 09 May 2019 13:31:39 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 09, 2019 at 02:34:06PM +0200, Christoph Hellwig wrote:
> On Thu, May 09, 2019 at 07:24:12PM +0800, Ming Lei wrote:
> > I'd suggest to fix block layer instead of working around the issue here,
> > then any driver may benefit from the fix.
> 
> That is my plan, and I started on it.  But the fix isn't trivial, and
> will probably take a while and be invasive.
> 
> > Especially checking bio->bi_vcnt is just a hack, and drivers should
> > never use .bi_vcnt.
> 
> That is why it is explicitly commented as a hack.  But a good enough
> one to still speed up typical 4K I/Os - one a bio has been cloned
> chances are very high we don't care about the fast path any more.

NVMe hasn't max segment size limit, so fair enough for typical
4K IO workload:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming
