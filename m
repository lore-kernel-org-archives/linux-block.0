Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BE4C04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 12:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF5B216C4
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 12:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfEIMe0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 08:34:26 -0400
Received: from verein.lst.de ([213.95.11.211]:45581 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfEIMe0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 May 2019 08:34:26 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E3F8968AFE; Thu,  9 May 2019 14:34:06 +0200 (CEST)
Date:   Thu, 9 May 2019 14:34:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, keith.busch@intel.com,
        sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme-pci: fix single segment detection
Message-ID: <20190509123406.GB21483@lst.de>
References: <20190509110409.19647-1-hch@lst.de> <20190509112410.GA20711@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509112410.GA20711@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 09, 2019 at 07:24:12PM +0800, Ming Lei wrote:
> I'd suggest to fix block layer instead of working around the issue here,
> then any driver may benefit from the fix.

That is my plan, and I started on it.  But the fix isn't trivial, and
will probably take a while and be invasive.

> Especially checking bio->bi_vcnt is just a hack, and drivers should
> never use .bi_vcnt.

That is why it is explicitly commented as a hack.  But a good enough
one to still speed up typical 4K I/Os - one a bio has been cloned
chances are very high we don't care about the fast path any more.
