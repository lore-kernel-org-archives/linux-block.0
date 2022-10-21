Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2DDC4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 13:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiJUNUg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJUNUf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 09:20:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1713C16910A
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 06:20:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 50F4C68B05; Fri, 21 Oct 2022 15:20:31 +0200 (CEST)
Date:   Fri, 21 Oct 2022 15:20:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Message-ID: <20221021132031.GB22327@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-4-hch@lst.de> <Y1GE37ujxcfRn7Tm@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1GE37ujxcfRn7Tm@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 20, 2022 at 11:26:55AM -0600, Keith Busch wrote:
> Since you're not dealing with flexible arrays anymore, I don't think
> srcu strictly needs to be the last member.

True.  I thought I had removed this sentence when copying the comment
over, but it looks like I messed that up somewhow.

