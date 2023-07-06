Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35AEEB64D9
	for <linux-block@archiver.kernel.org>; Thu,  6 Jul 2023 13:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjGFNIh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 09:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjGFNI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 09:08:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31691BDB;
        Thu,  6 Jul 2023 06:08:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67E7968AFE; Thu,  6 Jul 2023 15:08:25 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:08:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 3/4] blk-flush: reuse rq queuelist in flush state
 machine
Message-ID: <20230706130825.GC13089@lst.de>
References: <20230629110359.1111832-1-chengming.zhou@linux.dev> <20230629110359.1111832-4-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629110359.1111832-4-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

