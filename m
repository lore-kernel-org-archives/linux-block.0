Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FC1C77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 04:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDME7n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 00:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDME7m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 00:59:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB085BA2;
        Wed, 12 Apr 2023 21:59:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 00D8A6732D; Thu, 13 Apr 2023 06:59:38 +0200 (CEST)
Date:   Thu, 13 Apr 2023 06:59:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com
Subject: Re: [PATCH 1/4] blkcg: Drop unnecessary RCU read [un]locks from
 blkg_conf_prep/finish()
Message-ID: <20230413045937.GA14083@lst.de>
References: <20230413000649.115785-1-tj@kernel.org> <20230413000649.115785-2-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413000649.115785-2-tj@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
