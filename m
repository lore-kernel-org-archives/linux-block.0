Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF38C433DB
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 07:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD8164E02
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 07:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhBQHRV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Feb 2021 02:17:21 -0500
Received: from verein.lst.de ([213.95.11.211]:43203 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231444AbhBQHRM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Feb 2021 02:17:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 753F367373; Wed, 17 Feb 2021 08:16:29 +0100 (CET)
Date:   Wed, 17 Feb 2021 08:16:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH 0/2] block: avoid to drop & re-add partitions if
 partitions aren't changed
Message-ID: <20210217071629.GA15362@lst.de>
References: <20210205021708.1498711-1-ming.lei@redhat.com> <20210215040341.GA257964@T590> <20210216084430.GA23694@lst.de> <20210217030714.GB259250@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217030714.GB259250@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 17, 2021 at 11:07:14AM +0800, Ming Lei wrote:
> Do you think it is correct for ioctl(BLKRRPART) to always drop/re-add
> partition device node?

Yes, that is what it is designed to do.  The only reason to call this
ioctl is when userspace software has written new partition table
information to the disk.
