Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A290C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 14:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbiBBOML (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:12:11 -0500
Received: from verein.lst.de ([213.95.11.211]:34252 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237388AbiBBOMK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Feb 2022 09:12:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B4DBF68AFE; Wed,  2 Feb 2022 15:12:07 +0100 (CET)
Date:   Wed, 2 Feb 2022 15:12:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH] block: fix DIO handling regressions in
 blkdev_read_iter()
Message-ID: <20220202141207.GA24276@lst.de>
References: <20220201100420.25875-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201100420.25875-1-idryomov@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
