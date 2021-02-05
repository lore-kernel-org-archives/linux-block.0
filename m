Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82406C433DB
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 07:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A26B64FBC
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 07:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhBEHPQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 02:15:16 -0500
Received: from verein.lst.de ([213.95.11.211]:59197 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhBEHPP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Feb 2021 02:15:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 282CA68B05; Fri,  5 Feb 2021 08:14:30 +0100 (CET)
Date:   Fri, 5 Feb 2021 08:14:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH 2/2] block: avoid to drop & re-add partitions if
 partitions aren't changed
Message-ID: <20210205071429.GA28033@lst.de>
References: <20210205021708.1498711-1-ming.lei@redhat.com> <20210205021708.1498711-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205021708.1498711-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 05, 2021 at 10:17:08AM +0800, Ming Lei wrote:
> block ioctl(BLKRRPART) always drops current partitions and adds
> partitions again, even though there isn't any change in partitions table.
> 
> ioctl(BLKRRPART) may be called by systemd-udevd and some disk utilities
> frequently.

Err, why?  We should probably fix udev to not do stupid things first.
