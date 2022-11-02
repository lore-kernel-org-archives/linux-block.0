Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922EEC433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 06:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKBG76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 02:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiKBG74 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 02:59:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18CB637D;
        Tue,  1 Nov 2022 23:59:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2EC016732D; Wed,  2 Nov 2022 07:59:46 +0100 (CET)
Date:   Wed, 2 Nov 2022 07:59:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] blk-mq: use if-else instead of goto in
 blk_mq_alloc_cached_request()
Message-ID: <20221102065945.GB9096@lst.de>
References: <cover.1667358114.git.nickyc975@zju.edu.cn> <d3306fa4e92dc9cc614edc8f1802686096bafef2.1667358114.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3306fa4e92dc9cc614edc8f1802686096bafef2.1667358114.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
