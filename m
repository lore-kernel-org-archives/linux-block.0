Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259D4C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 08:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C339E64EEA
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 08:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhBXITR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 03:19:17 -0500
Received: from verein.lst.de ([213.95.11.211]:36585 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232661AbhBXITJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 03:19:09 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 29D7C68D0A; Wed, 24 Feb 2021 09:18:26 +0100 (CET)
Date:   Wed, 24 Feb 2021 09:18:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH V2 0/3] block: avoid to drop & re-add partitions if
 partitions aren't changed
Message-ID: <20210224081825.GA1339@lst.de>
References: <20210224035830.990123-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224035830.990123-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 24, 2021 at 11:58:26AM +0800, Ming Lei wrote:
> Hi Guys,
> 
> The two patches changes block ioctl(BLKRRPART) for avoiding drop &
> re-add partitions if partitions state isn't changed. The current
> behavior confuses userspace because partitions can disappear anytime
> when calling into ioctl(BLKRRPART).

Which is the f***king point of BLKRRPART and the behavior it had
since day 1.  Please fix the application(s) that all it all the time
instead of bloating the kernel, as said before.
