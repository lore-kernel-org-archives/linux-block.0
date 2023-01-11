Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C30C5479D
	for <linux-block@archiver.kernel.org>; Wed, 11 Jan 2023 05:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjAKF0M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Jan 2023 00:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjAKFZM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2023 00:25:12 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148D913D59;
        Tue, 10 Jan 2023 21:19:17 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7787768BEB; Wed, 11 Jan 2023 06:19:14 +0100 (CET)
Date:   Wed, 11 Jan 2023 06:19:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v3 09/14] blk-mq: use blk_mq_commit_rqs helper in
 blk_mq_try_issue_list_directly
Message-ID: <20230111051914.GB16576@lst.de>
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com> <20230111130159.3741753-10-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111130159.3741753-10-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 11, 2023 at 09:01:54PM +0800, Kemeng Shi wrote:
> +	blk_status_t ret;

Same here, I think ret needs to be initialized now.

