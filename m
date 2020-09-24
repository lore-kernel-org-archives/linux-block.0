Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98485C2D0E2
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 13:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585EE2344C
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 13:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgIXNks (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 09:40:48 -0400
Received: from verein.lst.de ([213.95.11.211]:52478 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgIXNkn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 09:40:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6AE1A68B05; Thu, 24 Sep 2020 15:40:40 +0200 (CEST)
Date:   Thu, 24 Sep 2020 15:40:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, hch@lst.de,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: add QUEUE_FLAG_NOWAIT
Message-ID: <20200924134039.GA4882@lst.de>
References: <20200923200652.11082-1-snitzer@redhat.com> <20200923200652.11082-2-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923200652.11082-2-snitzer@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 23, 2020 at 04:06:51PM -0400, Mike Snitzer wrote:
> Add QUEUE_FLAG_NOWAIT to allow a block device to advertise support for
> REQ_NOWAIT. Bio-based devices may set QUEUE_FLAG_NOWAIT where
> applicable.
> 
> Update QUEUE_FLAG_MQ_DEFAULT to include QUEUE_FLAG_NOWAIT.  Also
> update submit_bio_checks() to verify it is set for REQ_NOWAIT bios.
> 
> Reported-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
