Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A37C77B73
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 12:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjEaMoJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 May 2023 08:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjEaMoJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 08:44:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46A11F;
        Wed, 31 May 2023 05:44:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 078E268B05; Wed, 31 May 2023 14:44:05 +0200 (CEST)
Date:   Wed, 31 May 2023 14:44:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v2] block: fix blktrace debugfs entries leak
Message-ID: <20230531124404.GA27412@lst.de>
References: <20230531092606.3037560-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531092606.3037560-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I like where this is going, but did you check that this doesn't
introduce a potential crash with the current /dev/sg based blktrace?

