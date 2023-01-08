Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6624C53210
	for <linux-block@archiver.kernel.org>; Sun,  8 Jan 2023 17:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjAHR4z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Jan 2023 12:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjAHR4y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Jan 2023 12:56:54 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098B42BD;
        Sun,  8 Jan 2023 09:56:54 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67A3768AA6; Sun,  8 Jan 2023 18:56:51 +0100 (CET)
Date:   Sun, 8 Jan 2023 18:56:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, john.garry@huawei.com,
        jack@suse.cz
Subject: Re: [PATCH v2 05/13] blk-mq: remove unnecessary list_empty check
 in blk_mq_try_issue_list_directly
Message-ID: <20230108175651.GD23466@lst.de>
References: <20230104142259.2673013-1-shikemeng@huaweicloud.com> <20230104142259.2673013-6-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104142259.2673013-6-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
