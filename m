Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B003EC433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 17:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiKARfW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKARfW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 13:35:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8157A1FC;
        Tue,  1 Nov 2022 10:35:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E92B86732D; Tue,  1 Nov 2022 18:35:18 +0100 (CET)
Date:   Tue, 1 Nov 2022 18:35:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] blk-mq: use if-else instead of goto in
 blk_mq_alloc_cached_request()
Message-ID: <20221101173518.GB20690@lst.de>
References: <cover.1667314759.git.nickyc975@zju.edu.cn> <8c2ebea324addffbe799eea1958214f6d89b5aad.1667314759.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2ebea324addffbe799eea1958214f6d89b5aad.1667314759.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 01, 2022 at 11:11:36PM +0800, Jinlong Chen wrote:
> if-else is more readable than goto here.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
