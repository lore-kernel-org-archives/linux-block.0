Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08745C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 12:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E75610EA
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 12:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhJNMNF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 08:13:05 -0400
Received: from verein.lst.de ([213.95.11.211]:49866 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231460AbhJNMNF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 08:13:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F8E368B05; Thu, 14 Oct 2021 14:10:56 +0200 (CEST)
Date:   Thu, 14 Oct 2021 14:10:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH V4 3/6] nvme: prepare for pairing quiescing and
 unquiescing
Message-ID: <20211014121055.GA15198@lst.de>
References: <20211014081710.1871747-1-ming.lei@redhat.com> <20211014081710.1871747-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014081710.1871747-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 14, 2021 at 04:17:07PM +0800, Ming Lei wrote:
> Add two helpers so that we can prepare for pairing quiescing and
> unquiescing which will be done in next patch.

I'd prefer to not add these wrappers with 1 or two callers, all in the
local file respectively.
