Return-Path: <SRS0=YBZ7=DG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435EEC4346E
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 06:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA382083B
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 06:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgI2GhX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 02:37:23 -0400
Received: from verein.lst.de ([213.95.11.211]:38340 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgI2GhX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 02:37:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 53AF86736F; Tue, 29 Sep 2020 08:37:21 +0200 (CEST)
Date:   Tue, 29 Sep 2020 08:37:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: change the hash used for looking up block
 devices
Message-ID: <20200929063721.GA1839@lst.de>
References: <20200927071115.372289-1-hch@lst.de> <20200928222116.GG1340@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928222116.GG1340@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 28, 2020 at 03:21:16PM -0700, Eric Biggers wrote:
> Doesn't ->bd_dev still need to be set somewhere?

Yes.  This was fixed in the next patch in my series which isn't
quite ready..
