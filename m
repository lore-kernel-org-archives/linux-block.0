Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B41C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 06:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjEXGPN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 02:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbjEXGPM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 02:15:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC89196
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 23:15:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F40C568CFE; Wed, 24 May 2023 08:15:07 +0200 (CEST)
Date:   Wed, 24 May 2023 08:15:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3 0/7] Submit zoned writes in order
Message-ID: <20230524061507.GF19611@lst.de>
References: <20230522183845.354920-1-bvanassche@acm.org> <20230523072216.GE8758@lst.de> <d372a3b8-f5ef-f281-bb3d-315030504d4f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d372a3b8-f5ef-f281-bb3d-315030504d4f@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 01:04:44PM -0700, Bart Van Assche wrote:
>> Can you explain why?  The resulting code looks rather odd to me as we
>> now reach out to a global list from the per-hctx run_queue helper,
>> which seems a bit awkward.
>
> Hi Christoph,
>
> This change is based on the assumption that requeuing and flushing are 
> relatively rare events.

The former are, the latter not so much.  But more importantly you now
look into a global list in the per-hctx dispatch, adding cache line
sharing.

> Do you perhaps want me to change the approach back 
> to one requeue list and one flush list per hctx?

Unless we have a very good reason to make them global that would
be my preference.

