Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AB1C433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 06:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351420AbhLXGAd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Dec 2021 01:00:33 -0500
Received: from verein.lst.de ([213.95.11.211]:55683 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351410AbhLXGAd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Dec 2021 01:00:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB0FD68AA6; Fri, 24 Dec 2021 07:00:28 +0100 (CET)
Date:   Fri, 24 Dec 2021 07:00:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        Ondrej Zary <linux@rainbow-software.org>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] block: remove paride
Message-ID: <20211224060027.GA12234@lst.de>
References: <20211223113504.1117836-1-hch@lst.de> <20211223113504.1117836-2-hch@lst.de> <6660785e-5954-1b8f-eeb1-1a23604571d7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6660785e-5954-1b8f-eeb1-1a23604571d7@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 23, 2021 at 07:16:22AM -0700, Jens Axboe wrote:
> On 12/23/21 4:35 AM, Christoph Hellwig wrote:
> > From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> 
> Hmm?

Oops.  git-rebease mess as I accidentally folded this into the loop
patch before splitting it out again..
