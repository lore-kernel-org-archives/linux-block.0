Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED32C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 05:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiF2FUa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 01:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiF2FU3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 01:20:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE2831520
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 22:20:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A02768AFE; Wed, 29 Jun 2022 07:20:25 +0200 (CEST)
Date:   Wed, 29 Jun 2022 07:20:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tj@kernel.org, jack@suse.cz, hch@lst.de, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/2] blk-cgroup: factor out blkcg_free_all_cpd()
Message-ID: <20220629052024.GB16113@lst.de>
References: <20220629015022.2667445-1-yanaijie@huawei.com> <20220629015022.2667445-3-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629015022.2667445-3-yanaijie@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
