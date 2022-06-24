Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643EDC43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 04:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiFXE4V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 00:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiFXE4U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 00:56:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C2FC7
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 21:56:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E0A068BEB; Fri, 24 Jun 2022 06:56:14 +0200 (CEST)
Date:   Fri, 24 Jun 2022 06:56:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
Message-ID: <20220624045613.GA4505@lst.de>
References: <20220623180528.3595304-1-bvanassche@acm.org> <20220623180528.3595304-52-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623180528.3595304-52-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 23, 2022 at 11:05:28AM -0700, Bart Van Assche wrote:
> Since __bitwise types are not supported by the tracing infrastructure, store
> the operation type as an int in the tracing event.

Please give the field in the trace even the proper type instead of
all the crazy casting.

