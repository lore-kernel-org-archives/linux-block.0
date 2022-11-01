Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88701C43217
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 17:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiKAReR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 13:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiKAReH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 13:34:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0369922C;
        Tue,  1 Nov 2022 10:34:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 757206732D; Tue,  1 Nov 2022 18:34:01 +0100 (CET)
Date:   Tue, 1 Nov 2022 18:34:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] blk-mq: improve error handling in
 blk_mq_alloc_rq_map()
Message-ID: <20221101173401.GA20690@lst.de>
References: <cover.1667314759.git.nickyc975@zju.edu.cn> <992db53bdeaba35d37de3784fe6f80879c9bbb35.1667314759.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <992db53bdeaba35d37de3784fe6f80879c9bbb35.1667314759.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  	if (!tags)
> -		return NULL;
> +		goto err_out;

Using a label just for the direct error return here is a bit silly.

The rest looks fine.
