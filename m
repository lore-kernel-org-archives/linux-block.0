Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C50ECAAA1
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 08:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ1Iar (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 04:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJ1Iaq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 04:30:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDD97E010;
        Fri, 28 Oct 2022 01:30:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 70D0868C4E; Fri, 28 Oct 2022 10:30:38 +0200 (CEST)
Date:   Fri, 28 Oct 2022 10:30:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org
Subject: Re: [PATCH v2] blk-mq: Properly init requests from
 blk_mq_alloc_request_hctx()
Message-ID: <20221028083037.GA1043@lst.de>
References: <1666780513-121650-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666780513-121650-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
