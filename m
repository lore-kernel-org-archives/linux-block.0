Return-Path: <SRS0=iG2v=ZY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0379C432C3
	for <linux-block@archiver.kernel.org>; Mon,  2 Dec 2019 07:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D1A20715
	for <linux-block@archiver.kernel.org>; Mon,  2 Dec 2019 07:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLBHVn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Dec 2019 02:21:43 -0500
Received: from verein.lst.de ([213.95.11.211]:37313 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfLBHVn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Dec 2019 02:21:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1092268B05; Mon,  2 Dec 2019 08:21:40 +0100 (CET)
Date:   Mon, 2 Dec 2019 08:21:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/7] block: merge invalidate_partitions into
 rescan_partitions
Message-ID: <20191202072140.GA29554@lst.de>
References: <20191114143438.14681-1-hch@lst.de> <20191114143438.14681-3-hch@lst.de> <20191130214942.GA676@sol.localdomain> <20191130220641.GA669@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191130220641.GA669@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 30, 2019 at 02:06:41PM -0800, Eric Biggers wrote:
> Actually this code was moved around more between the bad commit and mainline,
> so the fix for mainline would be:

Can you send this JJens with a proper changelog and signoff?

Whіle not sending the event for the non-partition case doesn't make
a whole lot sense it clearly breaks userspace after we've done it for
a long time.
