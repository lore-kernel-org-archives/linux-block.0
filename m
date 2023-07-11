Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4184EB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 11:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGKLbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 07:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGKLbb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 07:31:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BA211D;
        Tue, 11 Jul 2023 04:31:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7B01268AA6; Tue, 11 Jul 2023 13:31:26 +0200 (CEST)
Date:   Tue, 11 Jul 2023 13:31:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH 1/2] blk-flush: fix rq->flush.seq for post-flush
 requests
Message-ID: <20230711113126.GA26978@lst.de>
References: <20230710064705.1847287-1-chengming.zhou@linux.dev> <20230710133024.GA23157@lst.de> <4431d779-e6e7-aff1-5cf8-4147de974d8d@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4431d779-e6e7-aff1-5cf8-4147de974d8d@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 11, 2023 at 07:06:20PM +0800, Chengming Zhou wrote:
> Ok, will add a Fixes tag and send it as a separate patch since it's a bug fix.

Btw, it's probably not worth resending patch 2 until we've figured out
and dealt with the SATA flush regression that Chuck reported.
