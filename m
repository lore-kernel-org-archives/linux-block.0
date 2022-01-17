Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E69DC433EF
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 08:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiAQInN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:43:13 -0500
Received: from verein.lst.de ([213.95.11.211]:59026 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233239AbiAQInM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 03:43:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1DADD68AFE; Mon, 17 Jan 2022 09:43:09 +0100 (CET)
Date:   Mon, 17 Jan 2022 09:43:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: Re: [PATCH v2] block: deprecate autoloading based on dev_t
Message-ID: <20220117084308.GA23131@lst.de>
References: <20220104071647.164918-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104071647.164918-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 04, 2022 at 08:16:47AM +0100, Christoph Hellwig wrote:
> Make the legacy dev_t based autoloading optional and add a deprecation
> warning.  This kind of autoloading has ceased to be useful about 20 years
> ago.

ping?
