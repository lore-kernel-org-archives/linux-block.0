Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02758C433FE
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 07:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiKUHNK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 02:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUHNJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 02:13:09 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D0B120B9;
        Sun, 20 Nov 2022 23:13:08 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA23468AA6; Mon, 21 Nov 2022 08:13:05 +0100 (CET)
Date:   Mon, 21 Nov 2022 08:13:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] elevator: restore old io scheduler on failure
 in elevator_switch
Message-ID: <20221121071305.GB23882@lst.de>
References: <cover.1668772991.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668772991.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 18, 2022 at 08:09:52PM +0800, Jinlong Chen wrote:
> elevator_switch contains the fallback logic in sq era, but it was removed
> when moving to mq (commit: a1ce35fa49852db60fc6e268038530be533c5b15),
> leaving the document mismatched with the behavior. As far as I can see,
> restoring the old io scheduler is more reasonable than just leaving the
> scheduler none, hence there is the series.

What failure scenariou can you think off where switching to the intended
schedule fails, but switching back to the previous one will succeed?
