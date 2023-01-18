Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B3CC32793
	for <linux-block@archiver.kernel.org>; Wed, 18 Jan 2023 17:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjARRnf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Jan 2023 12:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjARRm7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 12:42:59 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367A646158;
        Wed, 18 Jan 2023 09:42:31 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1054168D13; Wed, 18 Jan 2023 18:42:28 +0100 (CET)
Date:   Wed, 18 Jan 2023 18:42:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v4 13/14] blk-mq: use switch/case to improve
 readability in blk_mq_try_issue_list_directly
Message-ID: <20230118174227.GI12399@lst.de>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com> <20230118093726.3939160-13-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118093726.3939160-13-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
