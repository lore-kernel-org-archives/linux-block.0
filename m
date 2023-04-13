Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C27C77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 05:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDMFAw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 01:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMFAv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 01:00:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DA05BA2;
        Wed, 12 Apr 2023 22:00:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 666496732D; Thu, 13 Apr 2023 07:00:47 +0200 (CEST)
Date:   Thu, 13 Apr 2023 07:00:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com
Subject: Re: [PATCH 4/4] blk-iolatency: Make initialization lazy
Message-ID: <20230413050047.GC14083@lst.de>
References: <20230413000649.115785-1-tj@kernel.org> <20230413000649.115785-5-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413000649.115785-5-tj@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
