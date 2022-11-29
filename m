Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA5BC4332F
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 08:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiK2IcB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 03:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiK2IbB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 03:31:01 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B7459850;
        Tue, 29 Nov 2022 00:30:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 226C668D06; Tue, 29 Nov 2022 09:30:11 +0100 (CET)
Date:   Tue, 29 Nov 2022 09:30:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] elevator: print none at first in elv_iosched_show
 even if the queue has a scheduler
Message-ID: <20221129083010.GA24762@lst.de>
References: <cover.1669391142.git.nickyc975@zju.edu.cn> <b613ad2a94ff552937672d70a5f2e43068e42bb2.1669391142.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b613ad2a94ff552937672d70a5f2e43068e42bb2.1669391142.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 25, 2022 at 11:53:11PM +0800, Jinlong Chen wrote:
> This makes the printing order of the io schedulers consistent, and removes
> a redundant q->elevator check.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
