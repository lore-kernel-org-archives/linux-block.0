Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA8AEB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 05:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjF2Fad (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 01:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjF2FaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 01:30:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66A030EC;
        Wed, 28 Jun 2023 22:30:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F29DB67373; Thu, 29 Jun 2023 07:30:01 +0200 (CEST)
Date:   Thu, 29 Jun 2023 07:30:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        ming.lei@redhat.com, hch@lst.de
Subject: Re: [PATCH v3 2/3] blk-mq: ktime_get_ns() only once for batched
 requests init
Message-ID: <20230629053001.GE16819@lst.de>
References: <20230628124546.1056698-1-chengming.zhou@linux.dev> <20230628124546.1056698-3-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628124546.1056698-3-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Can we just stash the start time into blk_mq_alloc_data instead of
passing down yet another parameter?

