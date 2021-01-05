Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B015BC433DB
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 07:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656BB2256F
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 07:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbhAEHwN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 02:52:13 -0500
Received: from verein.lst.de ([213.95.11.211]:60404 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbhAEHwN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jan 2021 02:52:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9AB4167373; Tue,  5 Jan 2021 08:51:31 +0100 (CET)
Date:   Tue, 5 Jan 2021 08:51:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
        syzbot+825f0f9657d4e528046e@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: fix use-after-free in disk_part_iter_next
Message-ID: <20210105075131.GA30262@lst.de>
References: <20201221043335.2831589-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221043335.2831589-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 21, 2020 at 12:33:35PM +0800, Ming Lei wrote:
> Make sure that bdgrab() is done on the 'block_device' instance before
> referring to it for avoiding use-after-free.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+825f0f9657d4e528046e@syzkaller.appspotmail.com
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
