Return-Path: <SRS0=exTe=U7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF546C06510
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 18:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CFC2184B
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 18:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGBS3h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:29:37 -0400
Received: from verein.lst.de ([213.95.11.211]:44710 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGBS3h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jul 2019 14:29:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0CB5B227A8A; Tue,  2 Jul 2019 20:29:35 +0200 (CEST)
Date:   Tue, 2 Jul 2019 20:29:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: Re: remove bi_phys_segments and related cleanups
Message-ID: <20190702182934.GA20763@lst.de>
References: <20190606102904.4024-1-hch@lst.de> <a703a5cb-1e39-6194-698a-56dbc4577f25@fb.com> <bbc9baba-19f2-03ec-59dc-adab225eb3b2@kernel.dk> <20190702133406.GC15874@lst.de> <bfe8a4b5-901e-5ac4-e11c-0e6ccc4faec2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfe8a4b5-901e-5ac4-e11c-0e6ccc4faec2@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 02, 2019 at 07:39:52AM -0600, Jens Axboe wrote:
> .config attached.

I couldn't get that to boot in my test systems even with mainline,
but that seems to be do to systemd waiting for some crap not supported
in the config.

But with my usual test config I've just completed a test run with
KASAN enabled on a VWC=1 driver with no issues, so this keeps puzzling
me.
