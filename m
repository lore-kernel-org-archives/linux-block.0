Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4637CC433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 06:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiCNGTw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 02:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiCNGTv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 02:19:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E372DD6D;
        Sun, 13 Mar 2022 23:18:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E67468BEB; Mon, 14 Mar 2022 07:18:36 +0100 (CET)
Date:   Mon, 14 Mar 2022 07:18:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
        syzbot+b42749a851a47a0f581b@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: release rq qos structures for queue without disk
Message-ID: <20220314061835.GA2974@lst.de>
References: <20220314043018.177141-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314043018.177141-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good (for 5.17 only):

Reviewed-by: Christoph Hellwig <hch@lst.de>
