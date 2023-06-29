Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47ECEB64DC
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 04:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjF2E6X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 00:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF2E6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 00:58:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD52171E;
        Wed, 28 Jun 2023 21:58:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D5CEF67373; Thu, 29 Jun 2023 06:58:06 +0200 (CEST)
Date:   Thu, 29 Jun 2023 06:58:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 3/3] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Message-ID: <20230629045806.GA16513@lst.de>
References: <20230628124546.1056698-4-chengming.zhou@linux.dev> <1bf88665-f779-7d45-1d5f-1af05aeb0882@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bf88665-f779-7d45-1d5f-1af05aeb0882@web.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 28, 2023 at 08:56:30PM +0200, Markus Elfring wrote:
> …
> > This patch fix it by setting alloc_time_ns and start_time_ns to now
> …
> 
> Please choose another imperative change suggestion.

Please stop bothering our contributors.
