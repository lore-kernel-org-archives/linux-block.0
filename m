Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B63C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 14:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC942089F
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 14:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfDXOdV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:33:21 -0400
Received: from verein.lst.de ([213.95.11.211]:54221 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfDXOdV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 10:33:21 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A76E067358; Wed, 24 Apr 2019 16:33:05 +0200 (CEST)
Date:   Wed, 24 Apr 2019 16:33:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: don't run get_page() on pages from non-bvec iov
 iter
Message-ID: <20190424143305.GA21209@lst.de>
References: <20190424110146.17343-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424110146.17343-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 24, 2019 at 07:01:46PM +0800, Ming Lei wrote:
> The refcount has been increased for pages retrieved from non-bvec iov iter
> via __bio_iov_iter_get_pages(), so don't need to do that again.
> 
> Otherwise, IO pages are leaked easily.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
