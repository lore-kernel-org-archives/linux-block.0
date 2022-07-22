Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72797C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 06:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiGVGAa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 02:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVGA3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 02:00:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B0040BEA
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 23:00:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 362C268BFE; Fri, 22 Jul 2022 08:00:23 +0200 (CEST)
Date:   Fri, 22 Jul 2022 08:00:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] block: move ->bio_split to the gendisk
Message-ID: <20220722060021.GA31300@lst.de>
References: <20220720142456.1414262-1-hch@lst.de> <20220720142456.1414262-2-hch@lst.de> <05f5c887-df0c-7960-7497-3f2e39f98e5d@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f5c887-df0c-7960-7497-3f2e39f98e5d@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 22, 2022 at 02:56:13PM +0900, Damien Le Moal wrote:
> Suggestion for a follow-up patch: we could save the *bio pointer in a
> local variable instead of constantly de-referencing bio.

I suspect a better calling convention might be to just return the
new bio.  I'll give that a spin for the follow up and see what it does
to code size.
