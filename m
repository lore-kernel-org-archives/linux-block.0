Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C256EB64D9
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 12:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjGJMLm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 08:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjGJMLl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 08:11:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E8D123;
        Mon, 10 Jul 2023 05:11:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3FA226732D; Mon, 10 Jul 2023 14:11:36 +0200 (CEST)
Date:   Mon, 10 Jul 2023 14:11:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, tj@kernel.org, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Message-ID: <20230710121136.GA17422@lst.de>
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710105516.2053478-1-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As a personal preference I kinda hate the empty ?:, but otherwise this
looks good;

Reviewed-by: Christoph Hellwig <hch@lst.de>
