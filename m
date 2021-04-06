Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C19C433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 06:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59DE861245
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 06:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbhDFGat (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:30:49 -0400
Received: from verein.lst.de ([213.95.11.211]:53118 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237859AbhDFGas (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Apr 2021 02:30:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C34BA68BEB; Tue,  6 Apr 2021 08:30:38 +0200 (CEST)
Date:   Tue, 6 Apr 2021 08:30:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: shutdown blktrace in case of fatal signal
 pending
Message-ID: <20210406063038.GA6337@lst.de>
References: <20210323081440.81343-1-ming.lei@redhat.com> <20210323081440.81343-2-ming.lei@redhat.com> <20210330165330.GA13829@lst.de> <YGO/cpalyGevAJjn@T590> <20210402172730.GA22923@lst.de> <YGgi6FOr6cEiei+7@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGgi6FOr6cEiei+7@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 03, 2021 at 04:10:16PM +0800, Ming Lei wrote:
> We still may shutdown blktrace if current is the last opener, otherwise
> new blktrace can't be started and memory should be leaked forever, and
> what do you think of the revised version?

I don't think this works.  For one there might be users of the blktrace
ioctl that explicitly rely on this not happening as difference processes
might start the tracing vs actually consume the trace data.  Second this
might not actually work as another process could be the last opener.

If you want to fix this for the blktrace tool (common) case I think we
need a new ioctl that explicitly ties the buffer lifetime to the fd.
