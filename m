Return-Path: <SRS0=37yO=WZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973E8C3A59F
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 14:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727F72339E
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 14:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfH2OIx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:08:53 -0400
Received: from verein.lst.de ([213.95.11.211]:46554 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfH2OIx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Aug 2019 10:08:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 04EAF68B20; Thu, 29 Aug 2019 16:08:50 +0200 (CEST)
Date:   Thu, 29 Aug 2019 16:08:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: reeze while write on external usb 3.0 hard disk [Bug 204095]
Message-ID: <20190829140849.GA18387@lst.de>
References: <20190817095422.GA4200@lazy.lzy> <Pine.LNX.4.44L0.1908191009490.1506-100000@iolanthe.rowland.org> <20190820072326.GD28968@lst.de> <20190820163722.GA2991@lazy.lzy> <20190826173833.GA4166@lazy.lzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826173833.GA4166@lazy.lzy>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 26, 2019 at 07:38:33PM +0200, Piergiorgio Sartor wrote:
> any news on this?

Sorry, I've been dropping the ball here, and I'm a little puzzled
on what is going on.  Including on why we are bounce buffering for
xhci at all.  What kind of system (CPU / mainboard) is this?
