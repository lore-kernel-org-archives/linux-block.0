Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5181CC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 05:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2749A20878
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 05:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfDXFmW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:42:22 -0400
Received: from verein.lst.de ([213.95.11.211]:51426 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfDXFmW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 01:42:22 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DA6CB68AFE; Wed, 24 Apr 2019 07:42:06 +0200 (CEST)
Date:   Wed, 24 Apr 2019 07:42:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] block: integrity: simplify bio_integrity_prep
Message-ID: <20190424054206.GE12136@lst.de>
References: <20190423071550.20806-1-ming.lei@redhat.com> <20190423071550.20806-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423071550.20806-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 23, 2019 at 03:15:50PM +0800, Ming Lei wrote:
> Now bio integrity is capable of dealing with multi-page bvec,
> also bio_integrity_add_page() can add physically contiguous pages
> into bip once, so avoid to loop over page by page.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
