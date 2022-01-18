Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AA4C433EF
	for <linux-block@archiver.kernel.org>; Tue, 18 Jan 2022 16:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiARQUS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:20:18 -0500
Received: from verein.lst.de ([213.95.11.211]:37642 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347373AbiARQT5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jan 2022 11:19:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F6AE68AA6; Tue, 18 Jan 2022 17:19:54 +0100 (CET)
Date:   Tue, 18 Jan 2022 17:19:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: move freeing disk into queue's release
 handler
Message-ID: <20220118161954.GA30449@lst.de>
References: <20220116041815.1218170-1-ming.lei@redhat.com> <20220116041815.1218170-2-ming.lei@redhat.com> <20220118082259.GA21847@lst.de> <YebhFeJb/0Fux5Ei@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YebhFeJb/0Fux5Ei@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 18, 2022 at 11:47:33PM +0800, Ming Lei wrote:
> Can you share steps for this test case? And it shouldn't hard to extend this
> patch for supporting it.

Just use the sysfs unbind/bind files to detach and attach the ULP.
