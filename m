Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACA0C4332D
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 14:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58E064E60
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 14:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhBWOup (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 09:50:45 -0500
Received: from verein.lst.de ([213.95.11.211]:34136 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233152AbhBWOun (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 09:50:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E79C668D0A; Tue, 23 Feb 2021 15:50:00 +0100 (CET)
Date:   Tue, 23 Feb 2021 15:50:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: fix logging on capacity change
Message-ID: <20210223145000.GA17432@lst.de>
References: <20210223085015.832088-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223085015.832088-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 23, 2021 at 04:50:15PM +0800, Ming Lei wrote:
> Local variable of 'capacity' stores the previous disk capacity, and
> 'size' variable records the latest disk capacity, so swap them for
> fixing logging on capacity change.

Ok, looks like we're racing for fixes a lot lately.  I have the same
fix commited locally since this morning..

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
